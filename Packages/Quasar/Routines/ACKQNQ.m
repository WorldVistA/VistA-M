ACKQNQ ;AUG/JLTP,AEM BIR/PTD HCIOFO/BH HCIOFO/AG - Inquire - A&SP Patient ;18 Jun 2013  10:09 AM
 ;;3.0;QUASAR;**8,14,18,22,21**;Feb 11, 2000;Build 40
 ;
 ; Reference/IA
 ;  $$CSI^ICDEX - 5747
 ;
OPTN ;  Introduce option.
 S ACKQUIT=0
 W:$E(IOST,1,2)="C-" @IOF,!,"This option displays demographic data, inpatient status, and diagnostic",!,"history for a selected A&SP patient."
 ;
DIC ;  LOOKUP PATIENT
 N DIC
 W ! S DIC=509850.2,DIC(0)="AEMQ" D ^DIC
 I (Y<0)!($D(DUOUT)) S ACKQUIT=1 G EXIT
 S ACKDFN=+Y
 ;
ASK ;  Update patient's diagnostic history?
 S DIR(0)="Y",DIR("A")="Do you want to update this patient's diagnostic history NOW",DIR("B")="NO",DIR("?")="Enter YES to recompile the Problem List; enter NO to continue."
 S DIR("??")="^D UPDATE^ACKQHLP1" W ! D ^DIR K DIR G:$D(DIRUT) EXIT I Y=1 D UPDATE
 ;
DEV W !!,"The right margin for this report is 80.",!,"You can queue it to run at a later time.",!
 K %ZIS,IOP S %ZIS="QM",%ZIS("B")="" D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED." G EXIT
 I $D(IO("Q")) K IO("Q") S ZTRTN="EN^ACKQNQ",ZTSAVE("ACKDFN")="",ZTDESC="QUASAR - Inquire - A&SP Patient" D ^%ZTLOAD D HOME^%ZIS K ZTSK G EXIT
 ;
EN U IO N DFN,I,X,Y S DFN=ACKDFN
 D DEM^VADPT,INP^VADPT,ELIG^VADPT
 S ACKIVD=$$NUMDT^ACKQUTL($P(^ACK(509850.2,DFN,0),U,2))
 K ACK S ACK(1)=VADM(1),ACK(2)=$P(VADM(3),U,2),ACK(3)=$P(VADM(2),U,2),ACK(4)=VADM(7),ACK(6)=$P(VAIN(4),U,2)
 S ACKINP=$S($L(ACK(6)):1,1:0),ACK(5)="Patient is "_$S(ACKINP:"",1:"not ")_"currently an inpatient."
 S ACK(7)=VAIN(5),ACK(8)=$P(VAIN(3),U,2),ACK(9)=$P(VAEL(1),U,2)
 ;
 ;
PRINT W:$E(IOST,1,2)="C-" @IOF
 D CNTR^ACKQUTL("Patient Inquiry")
 ;
 W !!
 W "PATIENT: ",ACK(1),?45,"DOB: ",ACK(2),?63,"SSN: ",ACK(3)
 W !,"ELIGIBILITY: ",ACK(9)
 W ?45,"INITIAL VISIT DATE: ",ACKIVD
 W:$L(ACK(4)) !,ACK(4) W !,ACK(5) D:ACKINP INP
 ;
 I $P(VAEL(3),U,1) W !!,"Patient is Service Connected."
 I '$P(VAEL(3),U,1) D
 . S ACKPAT=DFN D STATUS^ACKQUTL4 K VASV
 . D NOT^ACKQUTL7("Patient is not Service Connected.",ACKAO,ACKRAD,ACKENV)
 . K ACKPAT,ACKAO,ACKRAD,ACKENV
 ;
 D RATDIS  G:$G(DIRUT) EXIT
 D ICDSORT,DIAGHIST
 ;
EXIT I $G(ACKVISIT)'="",$G(DIRUT)=1 S ACKDIRUT=1  ;  Quit flag for template
 K %ZIS,ACK,ACKCDST,ACKDATE,ACKDC,ACKDD,ACKDESC,ACKDFN,ACKDN,ACKDX
 K ACKI,ACKICD,ACKICDX,ACKINFO,ACKINP,ACKIVD,ACKLINE,ACKQECON,ACKQIR,ACKQORG
 K ACKRD,ACKQSER,CNTR0,CNTR9,DATA,DIRUT,DTOUT,DUOUT,IOUOFF,IOUON,POP
 K VA,VADM,VAEL,VAERR,VAIN,X,X1,Y,ZTDESC,ZTIO,ZTRTN,ZTSAVE
 I $G(ACKQUIT)=1 D KILL^%ZISS Q
 I $E(IOST,1,2)="C-" W !!,"Press return to continue." R X:DTIME  W @IOF
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 S ACKQUIT=0 G DIC
 Q
 ;
EN1 ;  CALL THIS ENTRY POINT INSTEAD OF EN
 D HOME^%ZIS G EN
 ;
 ;
INP ;  PRINT INPATIENT INFO
 W !,"WARD: ",ACK(6),?20,"ROOM/BED: ",ACK(7),?40,"TREATING SPEC: ",$E(ACK(8),1,25)
 Q
 ;
 ;
RATDIS ;  Display Patients RATED DISABILITIES
 Q:'$O(^DPT(DFN,.372,0))
 N ACKRD,RC,X,X1
 D ENS^%ZISS
 ;---
 S RC=$$PAGE(5)  Q:RC<0  W:'RC !!
 W IOUON,"Rated Disabilities",IOUOFF,!
 ;---
 S ACKRD=0
 F  S ACKRD=$O(^DPT(DFN,.372,ACKRD))  Q:'ACKRD  D  Q:RC<0
 . S RC=$$PAGE(2)  Q:RC<0
 . W:RC IOUON,"Rated Disabilities (cont'd)",IOUOFF,!
 . S X=^DPT(DFN,.372,ACKRD,0),X1=$P(^DIC(31,+X,0),U)
 . W !,X1_"  ("_$P(X,U,2)_"%)"  I $P(X,U,3) W "  (SC)"
 Q
 ;
DIAGHIST ;
 Q:$D(ACKICD)<10
 N ACKI,ACKICD0,ACKICD9,RC
 D ENS^%ZISS
 ;---
 S RC=$$PAGE(7)  Q:RC<0  W:'RC !!
 W IOUON,"Patient Diagnostic History",IOUOFF
 W !,$S($P(VADM(5),U)="F":"Ms. ",1:"Mr. "),$P(VADM(1),",")," has been seen for the following:",!
 D DIHEAD
 ;---
 S ACKI=""
 S ACKICDX=""
 F  S ACKI=$O(ACKICD(ACKI)) Q:ACKI=""  D  Q:RC<0
 . S RC=$$PAGE(2)  Q:RC<0
 . I RC  D  D DIHEAD
 . . W IOUON,"Patient Diagnostic History (cont'd)","  (",ACK(1),")",IOUOFF,!
 . S ACKICDX=""
 . S ACKICDX=$O(ACKICD(ACKI,ACKICDX))
 . S ACKCDST(ACKICDX)=ACKICDX
 I $D(ACKCDST(1)),$D(ACKCDST(30)) D
 . S ACKI="",CNTR9=0,CNTR0=0
 . F  S ACKI=$O(ACKICD(ACKI)) Q:ACKI=""  D
 . . S ACKICD=""
 . . F  S ACKICD=$O(ACKICD(ACKI,ACKICD)) Q:ACKICD=""  D
 . . . S ACKDX=$P(ACKICD(ACKI,ACKICD),U)
 . . . S ACKDESC=$P(ACKICD(ACKI,ACKICD),U,3)
 . . . S ACKDATE=$$NUMDT^ACKQUTL($P(ACKICD(ACKI,ACKICD),U,4))
 . . . I ACKICD=1 S CNTR9=CNTR9+1 S ACKICD9(CNTR9)=ACKDX_U_ACKDESC_U_ACKDATE
 . . . I ACKICD=30 S CNTR0=CNTR0+1 S ACKICD0(CNTR0)=ACKDX_U_ACKDESC_U_ACKDATE
 . D PRTHEAD,EXIT Q
 S ACKI="" F  S ACKI=$O(ACKICD(ACKI)) Q:ACKI=""  D  Q:RC<0
 . S RC=$$PAGE(2)  Q:RC<0
 . I RC  D  D DIHEAD
 . . W IOUON,"Patient Diagnostic History (cont'd)","  (",ACK(1),")",IOUOFF,! Q
 . S ACKICDX=""
 . S ACKICDX=$O(ACKICD(ACKI,ACKICDX)) D
 . . W !,$P(ACKICD(ACKI,ACKICDX),U),?15,$P(ACKICD(ACKI,ACKICDX),U,3),?60,$$NUMDT^ACKQUTL($P(ACKICD(ACKI,ACKICDX),U,4))
 Q
 ;
CLASDIS ;  Display Patient Servive Classifications
 N RC
 I '$D(ACKQSER),'$D(ACKQORG),'$D(ACKQIR),'$D(ACKQECON) Q
 S RC=$$PAGE(5)  Q:RC<0  W:'RC !!
 D ENS^%ZISS
 W IOUON,"Service Classifications",IOUOFF,!
 W:$D(ACKQSER) " SERVICE-CONNECTED " W:$D(ACKQORG) " AGENT-ORANGE " W:$D(ACKQIR) " RADIATION " W:$D(ACKQECON) " ENVIRONMENTAL-CONTAMINANTS"
 W !
 Q
 ;
 ;
DIHEAD W !,"DIAGNOSIS",?60,"DATE ENTERED",!,$$REPEAT^XLFSTR("-",IOM-1)
 Q
 ;
 ;
ICDSORT ;
 S ACKI=0 F  S ACKI=$O(^ACK(509850.2,DFN,1,ACKI)) Q:'ACKI  D
 . S ACKDC=^ACK(509850.2,DFN,1,ACKI,0),ACKDD=$P(ACKDC,U,2)
 . S ACKICD=$$CSI^ICDEX(80,+ACKDC) ; returns 1 for ICD9 and 30 for ICD10
 . S ACKINFO=$$ICDDATA^ICDXCODE(ACKICD,+ACKDC,ACKDD,"I")
 . S ACKTGT=$P(ACKINFO,U,3)
 . S ACKDN=$P(ACKINFO,U,2)
 . S ACKICD(ACKDN,ACKICD)=ACKDN_U_ACKTGT_U_$$DIAGTXT^ACKQUTL8(+ACKDC,ACKDD)_U_ACKDD
 K ACKTGT,ACKMSG
 Q
 ;
UPDATE ;  Update patient's diagnostic history in 509850.2.
 ;  ACKDFN is defined upon entry to this module.
 D WAIT^DICD W !
 D PROBLIST^ACKQUTL3(ACKDFN,1)
 Q
 ;
 ;***** CHECKS IS NEW PAGE SHOULD BE STARTED
 ;
 ; [RESERVE]     Number of additional reserved lines (0, by default).
 ;               If the current page does not have so many lines
 ;               available, a new page will be started.
 ;
 ; [FORCE]       Force the prompt
 ;
 ; Return values:
 ;
 ;       -2  Timeout
 ;       -1  User canceled the output ('^' was entered)
 ;        0  Ok
 ;        1  New page
 ;
PAGE(RESERVE,FORCE) ;
 N RC
 I ($Y'<($G(IOSL,24)-$G(RESERVE,1)))!$G(FORCE)  D  S $Y=0
 . I $E(IOST,1,2)'="C-"  W @IOF  Q
 . N DA,DIR,DIROUT,DTOUT,DUOUT,I,X,Y
 . S DIR(0)="E"
 . D ^DIR
 . S RC=$S($D(DUOUT):-1,$D(DTOUT):-2,1:1)
 . W:RC>0 @IOF
 Q +$G(RC)
 ;
PRTHEAD ;
 S CNTR9=0,CNTR0=0
 W !,"ICD-9-CM",!
 F CNTR9=1:1 S DATA=$G(ACKICD9(CNTR9)) Q:'$D(ACKICD9(CNTR9))  D
 . S ACKDX=$P(DATA,U)
 . S ACKDESC=$P(DATA,U,2)
 . S ACKDATE=$P(DATA,U,3)
 . K ACKICDDS,ACKARNUM S ACKICDDS=ACKDESC D BRKDESC^ACKQR3(40)
 . ;W !,ACKDX,?15,ACKDESC,?60,ACKDATE
 . W !,ACKDX,?15,ACKICDDS(1),?60,ACKDATE
 . F ACKARNM2=2:1:ACKARNUM W !?15,ACKICDDS(ACKARNM2)
 . K ACKICDDS,ACKARNUM,ACKARNM2
 W !!,"ICD-10-CM",!
 F CNTR0=1:1 S DATA=$G(ACKICD0(CNTR0)) Q:'$D(ACKICD0(CNTR0))  D
 . S ACKDX=$P(DATA,U)
 . S ACKDESC=$P(DATA,U,2)
 . S ACKDATE=$P(DATA,U,3)
 . K ACKICDDS,ACKARNUM S ACKICDDS=ACKDESC D BRKDESC^ACKQR3(40)
 . ;W !,ACKDX,?15,ACKDESC,?60,ACKDATE
 . W !,ACKDX,?15,ACKICDDS(1),?60,ACKDATE
 . F ACKARNM2=2:1:ACKARNUM W !?15,ACKICDDS(ACKARNM2)
 . K ACKICDDS,ACKARNUM,ACKARNM2
 Q
 ;
