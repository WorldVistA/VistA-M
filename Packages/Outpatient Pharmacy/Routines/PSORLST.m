PSORLST ;BIRM/MFR - List of Patients/Prescriptions for Recall Notice ;12/30/09
 ;;7.0;OUTPATIENT PHARMACY;**348**;DEC 1997;Build 50
 ;
 ; External reference to ^PSS50 supported by DBIA 4533
 ; External reference to ^PSS50P7 supported by DBIA 4662
 ; External reference to ^DPT supported by DBIA 10035
 ; External reference to ^PSNDF(50.6 supported by DBIA 2079
 ;
START ; Prompt user for search/selection criteria.
 N PSODTRNG,PSONDC,PSOMED,PSOXDED,PSODDRG,PSOOI,PSOGEN,DDRG,EXIT,PSODIV,PSORXDIV,PSODJ
 N DIC,PSODEAD,OUTPUT,PSOSDIV,PSOTYPE
 ;
 ; - Division/Site selection
 D DIVSEL(.PSOSDIV) I $G(PSOSDIV)="^" G EXIT
 I $G(PSOSDIV)="ALL" S PSODIV=0 F  S PSODIV=$O(^PS(59,PSODIV)) Q:'PSODIV  S PSOSDIV(PSODIV)=""
 ;
 ; Date range selection
 W ! S PSODTRNG=$$DTRNG("T-90","T") I PSODTRNG="^" G START
LKTP ; Type of Drug Lookup
 S PSOMED=$$MED() W ! I PSOMED<1 D EXIT W !! G START
 I PSOMED=1 D NDC(.PSONDC) I $D(PSONDC)<10 D EXIT G LKTP
 I PSOMED=2!(PSOMED=3) D DDRG(.PSODDRG,PSOMED) I ($D(PSODDRG)<10) D EXIT G LKTP
 I PSOMED=4 D GENERIC(.PSODDRG) I $D(PSODDRG)<10 D EXIT G LKTP
 I PSOMED=5 D ORDITEM(.PSODDRG) I $D(PSODDRG)<10 D EXIT G LKTP
 ; Exclude Deceased Patients?
 W ! S PSOXDED=$$EXCL() I PSOXDED="^" G START
 ;
 D MARGIN
 W ! D DEV I $G(EXIT) D EXIT G START
 D EXCMSG I $G(DUOUT) D EXIT G START
 ;
QUE ; Entry point for queued report. Begin processing based on user's selection criteria.
 U IO
 D PROCESS^PSORLST2
 G START
 ;
EXIT ; Quit.
 Q
 ;
DTRNG(BGN,END) ; Date Range Selection
 ;Input: (o) BGN - Default Begin Date 
 ;       (o) END - Default End Date 
 N %DT,DTOUT,DUOUT,DTRNG,X,Y
 S DTRNG=""
 S %DT="AEST",%DT("A")="From Release Date: ",%DT("B")=$G(BGN) K:$G(BGN)="" %DT("B") D ^%DT
 I $G(DUOUT)!$G(DTOUT)!($G(Y)=-1) Q "^"
 S $P(DTRNG,U)=Y
 W ! K %DT
 S %DT="AEST",%DT("A")="To Release Date: ",%DT("B")=$G(END),%DT(0)=Y K:$G(END)="" %DT("B") D ^%DT
 I $G(DUOUT)!$G(DTOUT)!($G(Y)=-1) Q "^"
 S $P(DTRNG,U,2)=Y
 Q DTRNG
 ;
EXCL() ; Exclude Deceased Patients
 ; Input: (o) EXCLUDE - "Y"es or "N"o
 K DIR,X,Y S DIR("A")="Exclude Deceased Patients"
 S DIR(0)="Y",DIR("B")="YES" D ^DIR K DIR
 Q Y
 ;
MED() ; Select Medication(s)
 ; Medication Selection (NDC/Dispense Drug/Generic Drug)
 K DIR,Y,X
 S DIR(0)="S^1:NDC;2:DISPENSE DRUG AND LOT NUMBER;3:DISPENSE DRUG;4:VA GENERIC NAME;5:ORDERABLE ITEM"
 S DIR("A")="Select 1-5 ",DIR("?")="Choose a drug selection method."
 D ^DIR
 Q Y
 ;
NDC(NDC) ; Select NDC
 K NDC
 F  Q:Y<1  D
 .K DIR,X,Y
 .S DIR("A")="NDC"
 .S DIR(0)="FO^5:13"
 .S DIR("?")="Answer must be from 5 to 20 characters, in correct NDC format ( e.g., 4-4-2, 5-3-2, 5-4-1, 5-4-2, or 6-4-2)"
 .D ^DIR
 .I Y'="",$TR($TR(Y,"-","")," ","")="" W !,DIR("?") S Y=1 Q
 .I Y>0 S NDC($TR($TR(Y,"-","")," ",""))=1
 I '$D(NDC) W !!," *** NO NDC SELECTED ***"
 Q
 ;
DDRG(PSODDRG,LOTSEL) ; Select Dispense Drug
 K DIC
 S DIC=50,DIC(0)="QVAEZ",DIC("A")="Dispense Drug: "
 S DIC("S")="I $S($G(^(""I"")):0,1:1)"
 F  Q:(Y<1)!$G(EXIT)  K X,Y D ^DIC I Y>0 S PSODDRG(+Y)=$P(Y,"^",2) I LOTSEL=2 D LOT(+Y,.PSODDRG,Y(0,0))
 I '$D(PSODDRG) W !!," *** NO MEDICATION SELECTED ***"
 Q
 ;
LOT(DRGNO,DRGARR,DRGNAM) ; Enter Lot Number(s)
 N X,Y,LOT,EXIT,PSOLOTAR
 F  Q:$G(EXIT)  D
 .K DIR,Y,X
 .S DIR("A")="Lot # ",DIR(0)="FO^2:20"
 .D ^DIR S:$G(DUOUT) EXIT=1 W !
 .I $L(Y)>1 S PSOLOTAR(Y)="",DRGARR(DRGNO,Y)="" Q
 .I Y="",$D(PSOLOTAR)>1 S EXIT=1
 .Q:$D(PSOLOTAR)>1
 .I '$G(EXIT),Y="" W !?5,"At least one Lot # must be entered" Q
 I $G(EXIT),'$D(PSOLOTAR) K DRGARR(DRGNO),PSOLOTAR W !?27,"* No LOT # was entered *" D
 .W !?((80-$L(DRGNAM))/2),DRGNAM,!?22,"will not be included on the report",!!
 Q
 ;
GENERIC(PSODDRG) ; Select drug by VA GENERIC (file 50.6)
 N GENUM,GENAM,DDRGLI,INACTDT,DDRGLIA
 S INACTDT=$$FMADD^XLFDT(DT,-1)
GLOOP ; Prompt loop
 S DIC="^PSNDF(50.6,",DIC(0)="QMEAZ",DIC("A")="VA Generic Name: "
 F  Q:($G(GENUM)<0)  K X,Y D ^DIC S GENUM=+Y I GENUM>0 S GENUM=+Y,GENAM=$P(Y,"^",2) D
 .K ^TMP($J,"PSORLDN"),^TMP($J,"PSORLGN")
 .D AND^PSS50(GENUM,INACTDT,,"PSORLGN")
 .S DDRGLI=0 F  S DDRGLI=$O(^TMP($J,"PSORLGN",DDRGLI)) Q:'DDRGLI  D
 ..D DATA^PSS50(DDRGLI,,INACTDT,,,"PSORLDN")
 ..S DDRGLIA(DDRGLI)=$G(^TMP($J,"PSORLDN",DDRGLI,.01)) K ^TMP($J,"PSORLDN",DDRGLI)
 .I $D(DDRGLIA)>1 D DDSEL(.DDRGLIA,.PSODDRG)
 I '$D(PSODDRG) W !!," *** NO MEDICATION SELECTED ***"
 Q
 ;
ORDITEM(PSODDRG) ; Select drug by ORDERABLE ITEM (file 50.7)
 N OINUM,OINAM,OIDRGLI,INACTDT,OINUM,OIDRGLIA
 S INACTDT=$$FMADD^XLFDT(DT,-1)
OLOOP ; Prompt loop 
 S DIC="50.7",DIC(0)="QMEAZ",DIC("A")="Orderable Item: ",DIC("S")="I $S($P($G(^(0)),""^"",4):0,1:1)"
 F  Q:($G(OINUM)<0)  K X,Y D ^DIC S OINUM=+Y I OINUM>0 S OINAM=$P(Y,"^",2) D
 .K ^TMP($J,"PSORLDN"),^TMP($J,"PSORLDOI")
 .D DRGIEN^PSS50P7(OINUM,INACTDT,"PSORLOI")
 .S OIDRGLI=0 F  S OIDRGLI=$O(^TMP($J,"PSORLOI",OIDRGLI)) Q:'OIDRGLI  D
 ..D DATA^PSS50(OIDRGLI,,INACTDT,,,"PSORLDN")
 ..S DDRGLIA(OIDRGLI)=$G(^TMP($J,"PSORLDN",OIDRGLI,.01)) K ^TMP($J,"PSORLDN",OIDRGLI)
 .I $D(DDRGLIA)>1 D DDSEL(.DDRGLIA,.PSODDRG)
 I '$D(PSODDRG) W !!," *** NO MEDICATION SELECTED ***"
 Q
 ;
DDSEL(DDIN,DDOUT) ; Display selectable dispense drugs (DDIN), prompt for selection, save selected dispense drugs in DDOUT
 K DIR
 I $D(DDIN)<10 K DDIN Q
 W !!?2,"Dispense Drugs"
 W !?2,"---------------"
 S (II,DD)=0 F II=1:1 S DD=$O(DDIN(DD)) Q:'DD  W !?3,II," - ",DDIN(DD)
 W ! S II=II-1 S DIR(0)="L^1:"_II D ^DIR W !
 S (II,DD)=0 F II=1:1 S DD=$O(DDIN(DD)) Q:'DD  I (","_Y_",")[(","_II_",") S DDOUT(DD)=DDIN(DD)
 K DDIN
 Q
 ;
DEV ; Prompt user for output device
 K %ZIS,IOP,POP,ZTSK,EXIT S PSOION=$I,%ZIS="QM"
 D ^%ZIS K %ZIS
 I POP S IOP=PSOION D ^%ZIS K IOP,PSOION W !,"Please try later!" S EXIT=1
 S X=0 X ^%ZOSF("RM")
 K PSOION I $D(IO("Q")) D  S EXIT=1 Q
 .S ZTDESC="List of Patient for Recall Notice",ZTRTN="QUE^PSORLST"
 .F G="PSODTRNG","PSOXDED","PSOMED","PSODIV","PSODJ","PSONDC(","PSODDRG(","PSOSDIV(" S ZTSAVE(G)=""
 .K IO("Q") D ^%ZTLOAD W:$D(ZTSK) !,"Report is Queued to print!" K ZTSK
 Q
 ;
DIVSEL(ARRAY) ; - Division selection (one, multiple or ALL)
 N DIC,DTOUT,DUOUT,QT,Y,X
 W !!,"You may select a single or multiple Divisions,"
 W !,"or enter ^ALL to select all Divisions.",!
 I '$G(DT) N DT S DT=$$NOW^XLFDT()
 S DIC("S")="I $S('$D(^PS(59,+Y,""I"")):1,'^(""I""):1,DT'>^(""I""):1,1:0)"
 K ARRAY S DIC="^PS(59,",DIC(0)="QEZAM",DIC("A")="Division: "
 F  D ^DIC Q:X=""  D  Q:$G(QT)
 .I $$UP^XLFSTR(X)="^ALL" K ARRAY S ARRAY="ALL",QT=1 Q
 .I $D(DTOUT)!$D(DUOUT) K ARRAY S ARRAY="^",QT=1 Q
 .W "   ",$P(Y,"^",2),$S($D(ARRAY(+Y)):"       (already selected)",1:"")
 .W ! S ARRAY(+Y)="",DIC("A")="ANOTHER ONE: " K DIC("B")
 I '$D(ARRAY) S ARRAY="^"
 Q
 ;
EXCMSG ;Display the message about capturing to an Excel file format
 K DUOUT
 Q:$E($G(IOST))'="C"
 W !!?5,"Before continuing, please set up your terminal to capture the"
 W !?5,"detailed report data. On some terminals, this can be done by"
 W !?5,"clicking on the 'Tools' menu above, then click on 'Capture"
 W !?5,"Incoming Data' to save to Desktop."
 W !
 W !?5,"     *** THIS REPORT MAY TAKE AWHILE TO RUN ***",!!
 N DIR S DIR(0)="E",DIR("A")="Press Return to Continue" D ^DIR K DIR
 W !
 Q
 ;
MARGIN   ; Display message about margin and page length
 I $G(PSODWFL) D
 . W !!!?8,"** Users unfamiliar with sort templates should review **"
 . W !?8,"**   sort template documentation before continuing.   **"
 . K PSODFWL
 W !!
 W !?8,"**  To avoid undesired wrapping of the output data,    **"
 W !?8,"**  please enter '0;256;999' at the 'DEVICE:' prompt.  **"
 W !
 Q
 ;
PSODED(RXIEN) ;
 N PSODED
 S PSODED=""
 I $G(DFN) S PSODED=$S($G(^DPT(+$P(^PSRX(RXIEN,0),"^",2),.35)):"Y",1:"N")
 Q PSODED
