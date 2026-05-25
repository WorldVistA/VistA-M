EHMAPPT3 ;ALB/WTC - EHRM APPOINTMENT MAINTENANCE; Jan 22, 2025@15:13:02
 ;;1.0;ELECTRONIC HEALTH MODERNIZATION;**13**;Apr 19, 2021;Build 27
 ;
 ;
 Q  ;
 ;
CNVTD ;
 ;
 ;  Summary of converted appointments with action required encounters.
 ;
 N CONVDATE,CLINFLTR,DFN,APPTDTTM,CLINIC,X1,X2,X3,LASTFI,SORT1,SORT2,SORT3,OUTPTFMT,Y,POP,%ZIS,DIRUT,QUEUED,OUTPTFMT,TITLE,CLINICS,NONCOUNT ;
 ;
 D CNVSELCT^EHMAPPT("OTHER",.CONVDATE,1,.CLINFLTR,.CLINICS,,.NONCOUNT) Q:$D(DIRUT)  Q:CONVDATE=""  Q:CLINFLTR=""  Q:NONCOUNT=""  ;
 ;
 S %ZIS="Q" D ^%ZIS I POP K ^TMP($J) Q  ;
 ;
 ;  If report is queued, add to Taskman
 ;
 S QUEUED=0 I $D(IO("Q")) S QUEUED=1 D  Q  ;
 . N ZTDESC,ZTRTN,ZTSAVE,ZTSK ;
 . S ZTRTN="CNVTD1^EHMAPPT2",ZTDESC="Action Required Encounters Summary" ;
 . S ZTSAVE("*")="" ;
 . D ^%ZTLOAD W $S($D(ZTSK):"...Task queued",1:"...Task cancelled"),! ;
 ;
CNVTD1 ;  TaskMan start point
 ;
 ;  Build list of converted appointments.
 ;
 U IO D CNVTDAPT^EHMAPPT("OTHER",CONVDATE,1,CLINFLTR,.CLINICS,,NONCOUNT,QUEUED,1,1) ;  Build list of converted appointments.
 S TITLE(1)="SUMMARY OF CONVERTED APPOINTMENTS WITH ACTION REQUIRED ENCOUNTERS" ;
 D SUMOUT^EHMAPPT2(.TITLE,CONVDATE,QUEUED,1) ;
 ;
 D ^%ZISC ;
 K ^TMP($J) ;
 Q  ;
 ;
POSTLIVE ;
 ;
 ;  Summary of post-conversion appointments with action required encounters.
 ;
 N CONVDATE,CLINFLTR,CLINICS,DFN,APPTDTTM,CLINIC,X1,X2,X3,LASTFI,SORT1,SORT2,SORT3,OUTPTFMT,Y,POP,%ZIS,QUEUED,CLINICS,NONCOUNT ;
 ;
 D POSTSLCT^EHMAPPT0("OTHER",.CONVDATE,1,.CLINFLTR,.CLINICS,,.NONCOUNT) Q:$D(DIRUT)  Q:CONVDATE=""  Q:CLINFLTR=""  Q:NONCOUNT=""  ;
 ;
 S %ZIS="Q" D ^%ZIS I POP K ^TMP($J) Q  ;
 ;
 ;  If report is queued, add to Taskman
 ;
 S QUEUED=0 I $D(IO("Q")) S QUEUED=1 D  Q  ;
 . N ZTDESC,ZTRTN,ZTSAVE,ZTSK ;
 . S ZTRTN="POSTLIV1^EHMAPPT2",ZTDESC="Action Required Encounters Summary" ;
 . S ZTSAVE("*")="" ;
 . D ^%ZTLOAD W $S($D(ZTSK):"...Task queued",1:"...Task cancelled"),! ;
 ;
POSTLIV1 ;  TaskMan start point
 ;
 ;  Build list of post-conversion appointments.
 ;
 U IO D POSTLIVE^EHMAPPT0("OTHER",CONVDATE,1,CLINFLTR,.CLINICS,,NONCOUNT,QUEUED,1,1) ; Build list of post-conversion appointments.
 S TITLE(1)="SUMMARY OF POST-CONVERSION APPOINTMENTS WITH ACTION REQUIRED ENCOUNTERS" ;
 D SUMOUT^EHMAPPT2(.TITLE,CONVDATE,QUEUED,1) ;
 ;
 D ^%ZISC ;
 K ^TMP($J) ;
 Q  ;
 ;
ALLAPPT ;
 ;
 ;  Summary of all appointments with action required encounters.
 ;
 N CONVDATE,CLINFLTR,CLINICS,DFN,APPTDTTM,CLINIC,X1,X2,X3,LASTFI,SORT1,SORT2,SORT3,OUTPTFMT,Y,POP,%ZIS,DIRUT,QUEUED,OUTPTFMT,TITLE ;
 ;
 D ALLSLCT^EHMAPPT0("OTHER",1,.CLINFLTR,.CLINICS,,.NONCOUNT) Q:CLINFLTR=""  Q:NONCOUNT=""  ;
 ;
 S %ZIS="Q" D ^%ZIS I POP K ^TMP($J) Q  ;
 ;
 ;  If report is queued, add to Taskman
 ;
 S QUEUED=0 I $D(IO("Q")) S QUEUED=1 D  Q  ;
 . N ZTDESC,ZTRTN,ZTSAVE,ZTSK ;
 . S ZTRTN="ALLAPPT1^EHMAPPT2",ZTDESC="Action Required Encounters Summary" ;
 . S ZTSAVE("*")="" ;
 . D ^%ZTLOAD W $S($D(ZTSK):"...Task queued",1:"...Task cancelled"),! ;
 ;
ALLAPPT1 ;  TaskMan start point
 ;
 ;  Build list of all appointments.
 ;
 U IO D ALLAPPTS^EHMAPPT0("OTHER",1,CLINFLTR,.CLINICS,,NONCOUNT,QUEUED,1,1) ;  Build list of appointments.
 S TITLE(1)="SUMMARY OF ALL APPOINTMENTS WITH ACTION REQUIRED ENCOUNTERS" ;
 D SUMOUT^EHMAPPT2(.TITLE,,QUEUED,1) ;
 ;
 D ^%ZISC ;
 K ^TMP($J) ;
 Q  ;
 ;
EDIT1610 ;
 ;
 ;  Add/Edit EHRM ACTIVE CLINIC FILE (#1610)
 ;
 N DIC,X,Y,IEN,DIR,DIK,DA,DIRUT,SELECTBY,STOPCODE,INACTDT,REACTDT,I,ACTION ;
 ;
 K DIR S DIR(0)="SO^NAME:Clinic Name;STOP:Stop Code",DIR("A")="Select by",DIR("B")="NAME" D ^DIR Q:$D(DIRUT)  S SELECTBY=Y ;
 ;
 I SELECTBY="NAME" D  Q  ;
 . ;
 . W !,"Select CLINIC to add or delete from the EHRM ACTIVE CLINIC file.",! ;
 . S Y=-1 F I=0:0 D  Q:Y<0  ;
 .. K DIC S DIC=44,DIC(0)="AEQM" D ^DIC Q:Y<0  S IEN=+Y W ! ;
 .. ;
 .. I $D(^EHRM(1610,"B",IEN)) D  Q  ;
 ... ;
 ... K DIR S DIR(0)="Y",DIR("A")="Delete clinic from EHRM ACTIVE CLINIC file?",DIR("B")="NO" D ^DIR Q:'Y  ; 
 ... ;
 ... K DIK S DIK=^DIC(1610,0,"GL"),DA=$O(^EHRM(1610,"B",IEN,0)) D ^DIK W "...Deleted" ;
 .. ;
 .. I '$D(^EHRM(1610,"B",IEN)) D  Q  ;
 ... ;
 ... S INACTDT=$$GET1^DIQ(44,IEN,2505,"I"),REACTDT=$$GET1^DIQ(44,IEN,2506,"I") ;
 ... I INACTDT'="",INACTDT'>DT,REACTDT=""!(REACTDT>DT) W "...Inactive.  Skipped." Q  ;
 ... ;
 ... K DIR S DIR(0)="Y",DIR("A")="Add clinic to EHRM ACTIVE CLINIC file?",DIR("B")="YES" D ^DIR Q:'Y  ; 
 ... ;
 ... K DIC S DIC=1610,DIC(0)="L",X=IEN D FILE^DICN W "...Added" ;
 ;
 I SELECTBY="STOP" D  Q  ;
 . ;
 . W !,"Select STOP CODE of clinics to add or delete from the EHRM ACTIVE CLINIC file.",! ;
 . K DIC S DIC=40.7,DIC(0)="AEQM" D ^DIC Q:Y<0  S STOPCODE=+Y W ! ;
 . ;
 . K DIR S DIR(0)="S^A:Add;D:Delete",DIR("A")="Clinics matching stop code",DIR("B")="A" D ^DIR Q:Y=""  Q:$D(DIRUT)  S ACTION=Y W ! ;
 . ;
 . I ACTION="A" D  ;
 .. S IEN=0 F  S IEN=$O(^SC("AST",STOPCODE,IEN)) Q:'IEN  W !,$$GET1^DIQ(44,IEN,.01) D  ;
 ... ;
 ... I $D(^EHRM(1610,"B",IEN)) W "...Already in EHRM ACTIVE CLINIC file." Q  ;  ALREADY ON FILE
 ... S INACTDT=$$GET1^DIQ(44,IEN,2505,"I"),REACTDT=$$GET1^DIQ(44,IEN,2506,"I") ;
 ... I INACTDT'="",INACTDT'>DT,REACTDT=""!(REACTDT>DT) W "...Inactive.  Skipped." Q  ;
 ... ;
 ... K DIC S DIC=1610,DIC(0)="L",X=IEN D FILE^DICN W "...Added" ;
 .. W ! ;
 . ;
 . I ACTION="D" D  ;
 .. S IEN=0 F  S IEN=$O(^SC("AST",STOPCODE,IEN)) Q:'IEN  W !,$$GET1^DIQ(44,IEN,.01) D  ;
 ... ;
 ... I '$D(^EHRM(1610,"B",IEN)) W "...Not in file." Q  ;
 ... ;
 ... K DIK S DIK=^DIC(1610,0,"GL"),DA=$O(^EHRM(1610,"B",IEN,0)) D ^DIK W "...Deleted" ;
 ;
 Q  ;
 ;
