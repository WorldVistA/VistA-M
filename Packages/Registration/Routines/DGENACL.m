DGENACL ;ALB/MRY,LBD - NEW ENROLLEE APPOINTMENT CALL LIST - UPDATE ; 6/9/10 2:09pm
 ;;5.3;Registration;**779,788,824**;08/13/93;Build 2
 ;
EDIT ;-Entry point - Edit Appointment Request Status and Comment option
 N DIC,DIE,DA,DR,Y,DFN
 S DIC="^DPT(",DIC(0)="AEQMZ" D ^DIC G Q:Y'>0 S DFN=+Y
 S DIE=DIC,DA=+Y,DR="[DGEN NEACL]" D ^DIE W !!
 G EDIT
Q Q
 ;
REPORT(DGRPT) ;-Entry point - Call List/Tracking reports
 ;
 ; DGRPT: 1 = Call List: New enrollee appt. request/no appt. assigned.
 ;        2 = Tracking Report: New enrollee appt. request/by date range
 ;
 N DGBEG,DGEND,DTOUT,DUOUT,DIRUT,DGFMT1,DGFMT2,DGERROR,DGPFTF,DGPFTFLG,DGSITE
 S (DGBEG,DGEND,DGERROR)="",DGSITE=+$P($$SITE^VASITE(),U,3)
 I $G(DGRPT)'=1&($G(DGRPT)'=2) G Q
 I DGRPT=1 D FMT1 I $D(DTOUT)!($D(DUOUT)) G Q
 I DGRPT=2 D FMT2 I $D(DTOUT)!($D(DUOUT)) G Q
 D PFTF I $D(DTOUT)!($D(DUOUT)) G Q
 I DGPFTFLG,'$O(DGPFTF("")) G Q
 N ZTDESC,ZTRTN,ZTSAVE,ZTSK,ZUSR,ZTDTH,POP,X,ERR,V
 K IOP,%ZIS
 S %ZIS="Q" D ^%ZIS G:POP EXIT
 I $D(IO("Q")) D  Q
 . F V="DGSITE","DGRPT","DGFMT1","DGFMT2","DGBEG","DGEND","DGPFTF(","DGERROR","DGPFTFLG" S ZTSAVE(V)=""
 . S ZTRTN="BUILD^DGENACL",ZTDESC="NEW ENROLLEE APPT. CALL LIST REPORT",ZTDTH=$H
 . D ^%ZTLOAD
 . D ^%ZISC,HOME^%ZIS
 . W !,$S($D(ZTSK):"REQUEST QUEUED!",1:"REQUEST CANCELLED!")
 D BUILD
EXIT D ^%ZISC,HOME^%ZIS
 Q
 ;
BUILD ;-Build temp global
 K ^TMP($J,"DGEN NEACL")
 N DFNIEN,DGDT,DGEDT
 I DGRPT=1 S DFNIEN=0 F  S DFNIEN=$O(^DPT("AEAR",1,DFNIEN)) Q:'DFNIEN  D  Q:+DGERROR
 . I $$GET1^DIQ(2,DFNIEN,1010.159,"I") D EXTRACT
 I DGRPT=2 D
 . S DGDT=DGBEG-.01,DGEDT=DGEND_.999
 . F  S DGDT=$O(^DPT("AEACL",DGDT)) Q:'DGDT!(DGDT>DGEDT)  D  Q:+DGERROR
 .. S DFNIEN=0 F  S DFNIEN=$O(^DPT("AEACL",DGDT,DFNIEN)) Q:'DFNIEN  D  Q:+DGERROR
 ... I $$GET1^DIQ(2,DFNIEN,1010.159,"I") D EXTRACT
 D PRINT^DGENACL1
 Q
 ;
EXTRACT ;
 D EXTRACT^DGENACL2
 Q
 ;
DATE N X1,X2
 S DIR(0)="DAO^,"_DT_",::EX"
 S X1=DT,X2=-7 D C^%DTC
 S Y=X D DD^%DT
 S DIR("A")="APPOINTMENT REQUEST ON 1010EZ START DATE: "
 S DIR("B")=Y
 S DIR("?")="Enter a date that an enrollee was asked question."
 D ^DIR K DIR
 I $D(DIRUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 S DGBEG=Y
 S DIR(0)="DAO^"_DGBEG_","_DT_"::EX"
 S Y=DT D DD^%DT S DGDT=Y
 S DIR("B")=DGDT
 S DIR("A")="APPOINTMENT REQUEST ON 1010EZ END DATE: "
 S DIR("?")="Enter a date that an enrollee was asked question."
 D ^DIR K DIR
 I $D(DIRUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 S DGEND=Y
 I $G(DGBEG)']""!($G(DGEND)']"") W !!,"DATE RANGE NOT SET.  EXITING"  S DUOUT=1
 Q
FMT1 ;Call List D/S
 N DIR
 K DIR S DIR("A")="Select report format",DIR(0)="S^D:DETAILED;S:SHORT"
 S DIR("?",1)="SHORT format lists enrollee appointment requests w/o an appointment."
 S DIR("?")="DETAILED format, in addition, lists patient lookup information."
 S DIR("B")="SHORT" D ^DIR K DIR
 I $D(DTOUT)!($D(DUOUT)) Q
 S DGFMT1=Y
 Q
FMT2 ;Tracking Report D/S
 N DIR
 K DIR S DIR("A")="Select report format",DIR(0)="S^D:DETAILED;S:SUMMARY"
 S DIR("?",1)="SUMMARY format lists totals of enrollee appointment requests."
 S DIR("?")="DETAILED format, lists individual enrollee appointment requests."
 S DIR("B")="SUMMARY" D ^DIR K DIR
 I $D(DTOUT)!($D(DUOUT)) Q
 S DGFMT2=Y
 D DATE
 Q
PFTF ;Ask Preferred Facility?
 S DGPFTFLG=0
 S DIR("A")="Select individual Preferred Facilities",DIR(0)="Y",DIR("B")="NO"
 D ^DIR K DIR
 I $D(DTOUT)!($D(DUOUT)) Q
 I Y=1 S DGPFTFLG=1
 I DGPFTFLG D
 . K DGPFTF
 . S DIR("A")="Preferred Facility",DIR(0)="PO^4:EMZ",DIR("S")="I $$PFTF^DGREGDD(Y),(+DGSITE=+$$GET1^DIQ(4,Y,99))"
 . F  D ^DIR Q:(+Y<0)!($D(DTOUT))!($D(DUOUT))  S DGPFTF(+Y)=""
 Q
BCKJOB(DGRPT) ;Queued entry point
 N DGERROR,DGPFTFLG,DGFMT1,DGSITE
 S DGRPT=$G(DGRPT) I DGRPT'=1 Q
 S DGFMT1="D"
 S (DGERROR,DGPFTFLG)="",DGSITE=+$P($$SITE^VASITE(),U,3)
 D BUILD
 Q
 ;
