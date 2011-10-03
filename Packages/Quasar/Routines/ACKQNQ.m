ACKQNQ ;AUG/JLTP,AEM BIR/PTD HCIOFO/BH HCIOFO/AG-Inquire - A&SP Patient ; 12/24/09 2:14pm
 ;;3.0;QUASAR;**8,14,18**;Feb 11, 2000;Build 1
 ;Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
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
 K %ZIS,ACK,ACKDC,ACKDD,ACKDFN,ACKDN,ACKI,ACKICD,ACKINP,ACKIVD,ACKLINE
 K ACKRD,DIRUT,DTOUT,DUOUT,VA,VADM,VAEL,VAERR,VAIN,X,X1,Y,ZTDESC,ZTIO
 K ZTRTN,ZTSAVE
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
 N ACKI,RC
 D ENS^%ZISS
 ;---
 S RC=$$PAGE(7)  Q:RC<0  W:'RC !!
 W IOUON,"Patient Diagnostic History",IOUOFF
 W !,$S($P(VADM(5),U)="F":"Ms. ",1:"Mr. "),$P(VADM(1),",")," has been seen for the following:",!
 D DIHEAD
 ;---
 S ACKI=""
 F  S ACKI=$O(ACKICD(ACKI))  Q:ACKI=""  D  Q:RC<0
 . S RC=$$PAGE(2)  Q:RC<0
 . I RC  D  D DIHEAD
 . . W IOUON,"Patient Diagnostic History (cont'd)","  (",ACK(1),")",IOUOFF,!
 . W !,$P(ACKICD(ACKI),U),?15,$P(ACKICD(ACKI),U,3)
 . W ?60,$$NUMDT^ACKQUTL($P(ACKICD(ACKI),U,4))
 Q
 ;
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
ICDSORT S ACKI=0 F  S ACKI=$O(^ACK(509850.2,DFN,1,ACKI)) Q:'ACKI  D
 . N ACKARY,ACKDD
 . S ACKDC=^ACK(509850.2,DFN,1,ACKI,0),ACKDD=$P(ACKDC,U,2)
 . D GETS^DIQ(80,+ACKDC_",",".01;2","E","ACKTGT","ACKMSG")
 . S ACKDN=ACKTGT(80,+ACKDC_",",.01,"E")
 . S ACKARY=$P($$ICDDX^ICDCODE(ACKDN,ACKDD),"^",4)
 . S ACKICD(ACKDN)=ACKDN_U_ACKTGT(80,+ACKDC_",",2,"E")_U_ACKARY_U_ACKDD
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
