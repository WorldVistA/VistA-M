ESPOFFC ;DALISC/CKA- COMPLETE AN OFFENSE REPORT;8/92
 ;;1.0;POLICE & SECURITY;;Mar 31, 1994
EN ;This routine allows the officer to complete an open offense report.
 ;The officer who entered the report is the only one who can complete the report.
 ;When the officer hits '??' at the DATE/TIME RECEIVED prompt, he/she will see only his incomplete offense reports.
 S ESPVAR=0
START D DT^DICRW
OR S DIC(0)="QAEMZ",DIC("A")="UOR#: ",DIC("S")="I $D(^(5)),'$P(^(5),U,2),$P(^(5),U,3)=DUZ,$P(^(5),U,5)",DIC="^ESP(912,"
 D ^DIC
 G:$D(DTOUT)!($D(DUOUT))!(X="") EXIT
 G:Y<0 OR S ESPDTR=$P(^ESP(912,+Y,0),U,2),(ESPID,ESPOFN)=+Y
 I $P(^ESP(912,+Y,0),U,8)="C" W !,$C(7),"This report is closed and cannot be edited!" G OR
EDIT ;ASK IF WANT TO DISPLAY EDIT THIS REPORT
 D ASK2^ESPOFFE
EXIT K DIC,DTOUT,DUOUT,ESPDTR,ESPID,ESPN,ESPOFN,ESPVAR,Y Q
EN1 ;Entry point for an officer to edit his own reports
 ;It won't ask if the report is completed.
 D DT^DICRW S ESPVAR=1
OR1 S DIC(0)="QAEMZ",DIC("A")="UOR#: ",DIC("S")="I $D(^(5)),$P(^(5),U,3)=DUZ,$P(^(5),U,5)",DIC="^ESP(912,"
 D ^DIC
 G:$D(DTOUT)!($D(DUOUT))!(X="") EXIT
 G:Y<0 OR S ESPDTR=$P(^ESP(912,+Y,0),U,2),(ESPID,ESPOFN)=+Y
 I $P(^ESP(912,+Y,0),U,8)="C" W !,$C(7),"This report is closed and cannot be edited!" G OR1
 G EDIT
