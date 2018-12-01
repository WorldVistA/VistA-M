PSOORFI6 ;BIR/SJA-finish cprs orders cont. ;01/05/07
 ;;7.0;OUTPATIENT PHARMACY;**225,505**;DEC 1997;Build 39
 ;External reference to ^PSDRUG supported by DBIA 221
 ;External references PSOL, and PSOUL^PSSLOCK supported by DBIA 2789
 ;External reference to ^DPT supported by DBIA 10035
 ;
DC N ACTION,LST,PSI,PSODFLG,PSONOORS,PSOOPT
 N VALMCNT W ! K DIR,DUOUT,DIROUT,DTOUT,PSOELSE
 I '$G(PSOERR("DEAD")) S PSOELSE=1 D PDATA Q:$D(DUOUT)!$D(DTOUT)  D  Q:$D(DIRUT)
 .D NOOR^PSOCAN4 Q:$D(DIRUT)
 .S DIR("A")="Comments",DIR(0)="F^10:75",DIR("B")="Per Pharmacy Request" D ^DIR K DIR
 I '$G(PSOELSE) K PSOELSE S PSONOOR="A" D DE^PSOORFI2 I '$G(ACTION)!('$D(PSODFLG)) S VALMBCK="R" Q
 K PSOELSE I $D(DIRUT) K DIRUT,DUOUT,DTOUT,Y Q
 S ACOM=Y
 S INCOM=ACOM,PSONOORS=PSONOOR D DE^PSOORFI2
 I '$G(ACTION)!('$D(PSODFLG)) Q
 S PSONOOR=PSONOORS D RTEST D SPEED D ULP^PSOCAN
 K PSOCAN,ACOM,INCOM,ACTION,LINE,PSONOOR,PSOSDXY,PSONOORS,PSOOPT,RXCNT,REA,RX,PSODA,DRG
 S Y=-1
 Q
PSPEED S (YY,PSODA)=$P(PSOSD(STA,DRG),"^"),RX=$P($G(^PSRX(PSODA,0)),"^") D SPEED1 Q:PSPOP!($D(PSINV(RX)))
 Q:$G(SPEED)&(REA="R")
SHOW S DRG=+$P(^PSRX(PSODA,0),"^",6),DRG=$S($D(^PSDRUG(DRG,0)):$P(^(0),"^"),1:"")
 S LC=0 W !,$P(^PSRX(PSODA,0),"^"),"  ",DRG,?52,$S($D(^DPT(+$P(^PSRX(PSODA,0),"^",2),0)):$P(^(0),"^"),1:"PATIENT UNKNOWN")
 I REA="C" W !?25,"Rx to be Discontinued",! Q
 W !?21,"*** Rx to be Reinstated ***",!
 Q
SPEED1 S PSPOP=0 I $G(PSODIV),+$P($G(^PSRX(PSODA,2)),"^",9)'=$G(PSOSITE) D:'$G(SPEED) DIV^PSOCAN
 K STAT S STAT=+$P(^PSRX(PSODA,"STA"),"^"),REA=$E("C00CCCCCCCCCR000C",STAT+1)
 Q:$G(SPEED)&(REA="R")
 I REA="R",$P($G(^PSRX(PSODA,"PKI")),"^") S PKI=1 S PSINV(RX)="" Q
 I REA=0!(PSPOP)!($P(^PSRX(+YY,"STA"),"^")>12),$P(^("STA"),"^")<16 S PSINV(RX)="" Q
 S:REA'=0&('PSPOP) PSCAN(RX)=PSODA_"^"_REA,RXCNT=$G(RXCNT)+1
 Q
SPEED N PKI K PSINV,PSCAN S PSODA=IN I $D(^PSRX(PSODA,0)) S YY=PSODA,RX=$P(^(0),"^") S:PSODA<0 PSINV(RX)="" D:PSODA>0 SPEED1
 G:'$D(PSCAN) INVALD S II="",RXCNT=0 F  S II=$O(PSCAN(II)) Q:II=""  S PSODA=+PSCAN(II),REA=$P(PSCAN(II),"^",2),RXCNT=RXCNT+1 D SHOW
 ;
ASK G:'$D(PSCAN) INVALD W ! S DIR("A")="OK to "_$S($G(RXCNT)>1:"Change Status",REA="C":"Discontinue the active order",1:"Reinstate"),DIR(0)="Y",DIR("B")="N"
 D ^DIR K DIR I $D(DIRUT) S:$O(PSOSDX(0)) PSOSDXY=1 Q
 I 'Y S:$O(PSOSDX(0)) PSOSDXY=1 K PSCAN D INVALD Q
 S RX="" F  S RX=$O(PSCAN(RX)) Q:RX=""  D PSOL^PSSLOCK(+PSCAN(RX)) I $G(PSOMSG) D ACT D PSOUL^PSSLOCK(+PSCAN(RX))
 D INVALD
 Q
ACT S DA=+PSCAN(RX),REA=$P(PSCAN(RX),"^",2),II=RX,PSODFN=$P(^PSRX(DA,0),"^",2) I REA="R" D REINS^PSOCAN2 Q
 S PSOOPT=-1 D CAN^PSOCAN
 Q
INVALD K PSCAN Q:'$D(PSINV)  W !! F I=1:1:80 W "="
 W $C(7),!!,"The Following Rx Number(s) Are Invalid Choices, Expired, "_$S($G(PKI):"Digitally Signed",1:""),!,"Discontinued by Provider, or Marked As Deleted:" S II="" F  S II=$O(PSINV(II)) Q:II=""  W !?10,II
 K PSINV I $G(PSOERR)!($G(SPEED)) K DIR,DUOUT,DTOUT,DIRUT S DIR(0)="E",DIR("A")="Press Return to Continue"
 D ^DIR K DIR,DTOUT,DIRUT,DUOUT
KILL D KILL^PSOCAN2
 K PSOMSG,PSOPLCK,PSOWUN,PSOULRX
 Q
RTEST ;
 Q:'$G(LINE)
 N PCIN,PCINFLAG,PCINX
 S PCINFLAG=0 F PCIN=1:1 S PCINX=$P(LINE,",",PCIN) Q:$P(LINE,",",PCIN)']""  D
 .Q:'$G(PCINX)
 .Q:'$G(PSOCAN(PCINX))
 .I $P($G(^PSRX(+$G(PSOCAN(PCINX)),"STA")),"^")'=12,'$G(PCINFLAG) S PSOCANRD=+$P($G(^PSRX($G(PSOCAN(PCINX)),0)),"^",4) S PCINFLAG=1
 I '$G(PCINFLAG) S PSOCANRZ=1
 Q
RTESTA ;
 N PFIN,PFINZ,PFINFLAG
 S PFINFLAG=0 S PFIN="" F  S PFIN=$O(PSOSD(PFIN)) Q:PFIN=""  S PFINZ="" F  S PFINZ=$O(PSOSD(PFIN,PFINZ)) Q:PFINZ=""  D
 .I $G(PFIN)'="PENDING" I $P($G(^PSRX(+$P($G(PSOSD(PFIN,PFINZ)),"^"),"STA")),"^")'=12,'$G(PFINFLAG) S PSOCANRD=+$P($G(^(0)),"^",4),PFINFLAG=1
 I '$G(PFINFLAG) S PSOCANRZ=1
 Q
PDATA Q:$P(^PS(52.41,ORD,0),"^",3)'="RNW"!('$P(^PS(52.41,ORD,0),"^",21))
 S PSI=0,IN=0 F  S PSI=$O(PSOLST(PSI)) Q:'PSI!(IN)  I $P(PSOLST(PSI),"^",2)=$P(^PS(52.41,ORD,0),"^",21) S LINE=PSI,(PSOCAN(PSI),IN)=$P(PSOLST(PSI),"^",2)
 Q:'$G(LINE)
 S:(+$G(^PSRX($P(^PS(52.41,ORD,0),"^",21),"STA"))<9) PSODFLG=1 Q:'$G(PSODFLG)
 D ASKDC S ACTION=Y
 Q
ASKDC W ! K DIR,DUOUT,DIRUT,DTOUT
 S DIR("A")="There is an active Rx for this pending order, Discontinue both (Y/N)",DIR("B")="NO",DIR(0)="Y"
 S DIR("?",1)="Y - Discontinue both pending and active Rx",DIR("?",2)="N - Discontinue pending order only"
 S DIR("?")="'^' - Quit (no action taken)" D ^DIR K DIR Q
 ; INPUT
 ; FS - the first sort type that was done before calling into the secondary sort.
 ;    - EX: PA:PATIENT, RT:ROUTE, PR:PRIORITY ..
 ; FSVAL - the value associated with the first sort.
DIR(FSORT,FSVAL) ;
 N DIR,Y,RLINE,STAG,SVAL,RES,FILSTR,DONE,FILTER,FIRST,JCNT,J
 K DIR
 S DIR(0)="Y",DIR("B")="N"
 S DIR("A")="Would you like to select a secondary filter"
 D ^DIR K DIR I 'Y K Y Q 0
 I $G(FSORT)']"" S FILSTR="PA:PATIENT;RT:ROUTE;PR:PRIORITY;CL:CLINIC;FL:FLAGGED;CS:CONTROLLED SUBSTANCES;SU:SUPPLY;C:CONTINUE W/PRIMARY;E:EXIT"
 I '$L($G(FILSTR)) D
 .S (DONE,JCNT)=0
 .F J=1:1 D  Q:DONE
 ..S FILTER=$T(SCRIT+J) I FILTER=" Q" S DONE=1 Q
 ..S FILTER=$P(FILTER,";;",2)
 ..I $D(FSORT),FILTER=FSORT Q
 ..I $D(FSORT),FSORT="SU:SUPPLY",FILTER="CS:CONTROLLED SUBSTANCES" Q
 ..I $D(FSORT),FSORT="CS:CONTROLLED SUBSTANCES",FILTER="SU:SUPPLY" Q
 ..; set up default for DIR("B"), in our case we will use the first item in the list that is not equal
 ..; to the first sort that occured
 ..S JCNT=JCNT+1 I JCNT=1 S FIRST=FILTER
 ..I '$L($G(FILSTR)) S FILSTR=FILTER Q
 ..S FILSTR=$G(FILSTR)_";"_FILTER
 I $G(FIRST)']"" S FIRST="PA:PATIENT"
 S DIR("?")="^D ST^PSOORFI1("_""""_$P(FSORT,":")_""""_")",DIR("A")="Select another filter",DIR("B")=$P($G(FIRST),":",2)
 S DIR(0)="SMB"_U_FILSTR
 D ^DIR K DIR
 I $D(DIRUT)!(Y="E") Q U
 I Y="C" Q 0
 S RES=Y
 S RLINE=$S(RES="PA":"PAT",RES="RT":"RTE",RES="PR":"PRI",RES="CL":"CLIN",RES="FL":"FLG",RES="CS":"CS",RES="SU":"SUPPLY",1:"")
 I RLINE']"" Q 0
 S STAG=RLINE
 S SVAL=$$@STAG
 I SVAL=U Q U
 I SVAL=""!(SVAL=0) Q 0
 ; consider a message indicating that the secondary sort may cause delays/hang time before display
 Q RES_U_SVAL
PAT() ;
 N DIR,Y,PSOSORT,DIC,SEL
 S PSOSORT="PATIENT"
 S DIR("?")="^D PT^PSOORFI1",DIR("A")="All Patients or Single Patient",DIR(0)="SBM^A:ALL;S:SINGLE;E:EXIT",DIR("B")="SINGLE"
 D ^DIR K DIR
 S SEL=Y
 I $D(DIRUT)!(SEL="E") Q U
PRMT I SEL="S" D  Q PSOSORT
 .S PSOSORT=PSOSORT_U_"SINGLE"
 .S DIR(0)="FO^2:30",DIR("A")="Select Patient",DIR("?")="^D HELP^PSOORFI2" D ^DIR I $E(X)="?" S PSOSORT=0 Q
 .I $D(DIRUT) S PSOSORT=0 Q
 .S DIC(0)="EQM",DIC=2,DIC("S")="I $D(^PS(52.41,""AOR"",+Y,PSOPINST))"
 .D ^DIC K DIC
 .I "^"[X S PSOSORT=0 Q
 .S (PSODFN,PAT)=+Y,PSOFINY=Y
 .I $P(Y,U)<1 G PRMT
 .I $P(Y,U) S PSOSORT=PSOSORT_U_$P(Y,U),(PSODFN,PAT)=+Y,PSOFINY=Y
 I SEL="A" S PSOSORT=PSOSORT_U_"ALL"
 Q PSOSORT
RTE() ;
 N DIR,Y,PSOSORT
 K DIR S PSOSORT="ROUTE"
 S DIR("?")="^D RT^PSOORFI1",DIR("A")="Route",DIR(0)="SBM^W:WINDOW;M:MAIL;C:CLINIC;E:EXIT",DIR("B")="WINDOW"
 D ^DIR K DIR
 I $D(DIRUT)!(Y="E") Q U
 S PSOSORT=PSOSORT_"^"_Y
 Q PSOSORT
PRI() ;
 N DIR,Y,PSOSORT
 K DIR S PSOSORT="PRIORITY"
 S DIR("A")="Select Priority",DIR(0)="SBM^S:STAT;E:EMERGENCY;R:ROUTINE",DIR("B")="ROUTINE"
 D ^DIR K DIR
 I $D(DIRUT) Q U
 S PSOSORT=PSOSORT_"^"_Y
 Q PSOSORT
CLIN() ;
 K ^TMP($J,"PSOCL"),^TMP($J,"PSOCLX"),PSOCLIN,PSOCLINF,PSOXINST
 N PSOCFLAG,PSONPTRX,PSOINPTR,PSCLP,PSOCLINS,PSOSTC,PSOLGD,PSODIEN,PSOCTMP
 K DIR S DIR(0)="SMB^C:CLINIC;S:SORT GROUP;E:EXIT",DIR("A")="Select By",DIR("B")="Clinic",DIR("?",1)="Enter 'C' to process orders for one individual Clinic,"
 S DIR("?",2)="      'S' to process orders for all Clinics associated with a Sort Group,",DIR("?",3)="      '^' or 'E' to exit" S DIR("?")=" "
 W ! D ^DIR K DIR I $D(DTOUT)!($D(DUOUT))!(Y="E") W ! Q U
 I Y="S" D SORT I $O(^TMP($J,"PSOCL",0)) Q 1
CLIN2 W ! K DIC S DIC="^SC(",DIC(0)="QEAMZ",DIC("A")="Select CLINIC: " D ^DIC K DIC I Y<1!($D(DTOUT))!($D(DUOUT)) Q 0
 S PSOCLIN=+Y,PSOCLINF=1 D CHECK^PSOORFI3 I $G(PSOCFLAG) D INSTNM^PSOORFI2 W !!,"You are signed in under the "_$G(PSODINST)_" CPRS Ordering",!,"Institution, which does not match the Institution for this Clinic!",! K PSODINST G CLIN2
 S ^TMP($J,"PSOCL",PSOCLIN)=PSOCLIN K PSOCLIN Q 1
SORT W ! K DIC S DIC="^PS(59.8,",DIC(0)="QEAMZ",DIC("A")="Select CLINIC SORT GROUP: " D ^DIC K DIC I Y<1!($D(DTOUT))!($D(DUOUT)) Q 0
 S PSOCLINS=+Y
 K ^TMP($J,"PSOCL"),^TMP($J,"PSOCLX") F PSCLP=0:0 S PSCLP=$O(^PS(59.8,PSOCLINS,1,PSCLP)) Q:'PSCLP  S PSOSTC=+$P($G(^PS(59.8,PSOCLINS,1,PSCLP,0)),"^") S:$G(PSOSTC)&($D(^SC(PSOSTC,0))) ^TMP($J,"PSOCL",PSOSTC)=PSOSTC
 I '$O(^TMP($J,"PSOCL",0)) W !!,"There are no Clinics associated with this Sort Group!",! K ^TMP($J,"PSOCL") G SORT
 F PSCLP=0:0 S PSCLP=$O(^TMP($J,"PSOCL",PSCLP)) Q:'PSCLP  S PSOCLIN=PSCLP D CHECK^PSOORFI3 I $G(PSOCFLAG) S ^TMP($J,"PSOCLX",PSCLP)=PSCLP K ^TMP($J,"PSOCL",PSCLP)
 I $O(^TMP($J,"PSOCLX",0)) H 1 W @IOF W !,"Orders for these Clinics in the Sort Group will not be displayed for Finishing",!,"because the CPRS Ordering Institution does not match the Institution that is",!,"associated with the Clinic:",! D
 .F PSCLP=0:0 S PSCLP=$O(^TMP($J,"PSOCLX",PSCLP)) Q:'PSCLP  D:($Y+4)>IOSL  W !,$P($G(^SC(PSCLP,0)),"^")
 ..W ! K DIR S DIR(0)="E",DIR("A")="Press RETURN to continue" D ^DIR K DIR W @IOF
 I $O(^TMP($J,"PSOCLX",0)) D EOP^PSOORFI3 Q 1
 K ^TMP($J,"PSOCLX") I '$O(^TMP($J,"PSOCL",0)) W !!,"There are no Clinics that have a matching Institution!",! D EOP^PSOORFI3 G SORT
 Q
FLG() ;
 Q "FLAGGED^FLAGGED"
CS() ;
 N DIR,PSOCSRT,Y
 K DIR N PSOCSRT S DIR("A")="Route",DIR(0)="SBM^W:WINDOW;M:MAIL;B:BOTH;E:EXIT",DIR("B")="BOTH" D ^DIR
 Q:$D(DIRUT)!(Y="E") U
 S PSOCSRT=$S(Y="B":1,1:Y)
 W !!,"Select a schedule(s)"
 K DIR S PSOSORT="DIGITALLY SIGNED"
 S DIR("A")="Select Schedule(s)",DIR(0)="S^1:SCHEDULE II;2:SCHEDULES III - V;3:SCHEDULES II - V;4:NON-CS+SCHEDULES III - V;5:NON-CS ONLY;E:EXIT",DIR("B")=3
 D ^DIR K DIR
 I $D(DIRUT)!(Y="E") Q U
 S PSOSORT=PSOSORT_"^"_Y_U_PSOCSRT
 Q PSOSORT
SUPPLY() ;
 Q "SUPPLY^SUPPLY"
 ; INPUT
 ;  IEN - IEN of the entry in 52.41 (PENDING OUTPATIENT ORDERS)
 ;  FLTR - filter criteria as returned from $$DIR
CHKFLTR(IEN,FLTR,CNT) ; CHECK THE SECONDARY FILTER FOR PENDING ORDERS
 N FLTRTYP,FLTRVAL,RES,DRG,CLIN,OR0
 ; everytime we have a result of 0 increment the counter
 ; everytime we have a result of 1, reset the counter
 ; when counter reaches 100, display a '.' on the screen and reset the counter
 ;S GL=$NA(^TMP($J,"ROUTINE","CNT"))
 I '$G(IEN) Q 0
 S FLTRTYP=$P(FLTR,U) I FLTRTYP="" Q 1
 S FLTRVAL=$P(FLTR,U,3)
 ; always return 1 for all patients
 I FLTRTYP="PA",FLTRVAL="ALL" Q 1
 ; route filter
 I FLTRTYP="RT" D  Q RES
 .I $$GET1^DIQ(52.41,IEN,19,"I")'=FLTRVAL S RES=0 Q
 .S RES=1
 ; single patient
 I FLTRTYP="PA" D  Q RES
 .; for a single patient selection, the IEN is piece 4. also, if there is no filter value, how could we filter? just return 1?
 .S FLTRVAL=$P(FLTR,U,4) I 'FLTRVAL S RES=1 Q
 .I $$GET1^DIQ(52.41,IEN,1,"I")'=FLTRVAL S RES=0 Q
 .S RES=1
 ; clinic filter
 I FLTRTYP="CL" D  Q RES
 .I $P(FLTR,U,2)'=1 S RES=1 Q
 .I '$O(^TMP($J,"PSOCL",0)) S RES=1 Q
 .S CLIN=$$GET1^DIQ(52.41,IEN,1.1,"I") I 'CLIN S RES=0 Q
 .I '$D(^TMP($J,"PSOCL",CLIN)) S RES=0 Q
 .S RES=1
 ; supply items filter
 I FLTRTYP="FL" D  Q RES
 .I '$D(^PS(52.41,IEN,0))!('$P($G(^PS(52.41,IEN,0)),"^",23)) S RES=0 Q
 .S RES=1
 ; priority
 I FLTRTYP="PR" D  Q RES
 .I $$GET1^DIQ(52.41,IEN,25,"I")'=FLTRVAL S RES=0 Q
 .S RES=1
 ; supply filter
 I FLTRTYP="SU" D  Q RES
 .S RES=$$ISSUPPLY(IEN)
 ; controlled substances
 S FLTRVAL=$P(FLTR,U,3)
 I FLTRTYP="CS" D  Q RES
 .S PDEA=0,OR0=$G(^PS(52.41,IEN,0)),PSRT=FLTRVAL
 .D PDEA^PSOORFI5 I 'PDEA!(PDEA'=PSRT) S RES=0 Q
 .S RES=1
 Q
ISSUPPLY(IEN) ;
 N DIEN,DEAHLDG,ORITEM,ORSUP,RES
 S RES=0
 S DIEN=$$GET1^DIQ(52.41,IEN,11,"I")
 I DIEN S DEAHLDG=$$GET1^DIQ(50,DIEN,3,"E")
 S ORITEM=$$GET1^DIQ(52.41,IEN,8,"I") Q:'ORITEM
 I ORITEM S ORSUP=$$GET1^DIQ(50.7,ORITEM,.09,"I")
 I $G(DEAHLDG)["S"!($G(ORSUP)=1) S RES=1
 Q RES
 ; replace PDEA^PSOORFI5 with updated version
PDEA ;
 I +$P(OR0,"^",9) S PDEA=$P($G(^PSDRUG($P(OR0,"^",9),0)),"^",3),PDEA=$S(PDEA[2:1,PDEA[3!(PDEA[4)!(PDEA[5):2,1:0)
 E  S PDEA=$$OIDEA^PSSUTLA1($P(OR0,"^",8),"O")
 I PDEA=2,PSRT=4 S PDEA=4 Q
 I PDEA=0,PSRT=5 S PDEA=5 Q
 I PDEA,PSRT=3 S PDEA=3
 Q
SCRIT ;
 ;;PA:PATIENT
 ;;RT:ROUTE
 ;;PR:PRIORITY
 ;;CL:CLINIC
 ;;FL:FLAGGED
 ;;CS:CONTROLLED SUBSTANCES
 ;;SU:SUPPLY
 ;;C:CONTINUE W/PRIMARY
 ;;E:EXIT
 Q
