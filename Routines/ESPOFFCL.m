ESPOFFCL ;DALISC/CKA- CLOSE AN OFFENSE REPORT;8/92
 ;;1.0;POLICE & SECURITY;;Mar 31, 1994
EN ;This routine allows the officer to close an open offense report.
 ;A report must be completed before it can be closed.
 ;Program will check if user holds ESP CHIEF key.
 ; OR for nonholders of the key (will not see confidential reports)
 D DT^DICRW
 I $D(^XUSEC("ESP CHIEF",DUZ)) G ORC
OR S DIC(0)="QAEMZ",DIC("A")="UOR#: ",DIC("S")="I $D(^(5)),$P(^(5),U,2),'$P(^(5),U,4),$P(^(5),U,5),'($P(^ESP(912,+Y,0),U,8)=""C"")",DIC="^ESP(912,"
 D ^DIC
 G:$D(DTOUT)!($D(DUOUT))!(X="") EXIT
 G:Y<0 OR S ESPDTR=$P(^ESP(912,+Y,0),U,2),(ESPID,ESPOFN)=+Y
 G CLO
ORC S DIC(0)="QAEMZ",DIC("A")="UOR#: ",DIC("S")="I $D(^(5)),$P(^(5),U,2),$P(^(5),U,5),'($P(^ESP(912,+Y,0),U,8)=""C"")",DIC="^ESP(912,"
 D ^DIC
 G:$D(DTOUT)!($D(DUOUT))!(X="") EXIT
 G:Y<0 OR S ESPDTR=$P(^ESP(912,+Y,0),U,2),(ESPID,ESPOFN)=+Y
CLO ;ASK IF WANT TO CLOSE THE REPORT
 D CLO1^ESPOFFE
 G EXIT
 ;
OR1 ;ENTRY POINT FOR MAKE A REPORT SENSITIVE
 S DIC(0)="AEMZ",DIC("A")="UOR#: ",DIC("S")="I $D(^(5)),$P(^(5),U,2),$P(^(5),U,5)",DIC="^ESP(912,"
 D ^DIC
 G:$D(DTOUT)!($D(DUOUT))!(X="") EXIT
 G:Y<0 OR1 S ESPDTR=$P(^ESP(912,+Y,0),U,2),(ESPID,ESPOFN)=+Y
CHK I $P(^ESP(912,ESPOFN,5),U,4) D UNCONF G EXIT
CONF ;MAKE REPORT SENSITIVE
 S $P(^ESP(912,ESPOFN,5),U,4)=1
 W !!,"The report is now sensitive."
EXIT K DIC,DTOUT,DUOUT,ESPDTR,ESPID,ESPN,ESPOFN,Y Q
UNCONF ;MAKE REPORT NONSENSITIVE
 W !!,"This report is now sensitive."
ASK S DIR(0)="Y",DIR("A")="Do you want to make it nonsensitive",DIR("?")="Answer YES or NO.",DIR("??")="Answer NO if you want the report to remain sensitive.  Answer YES if you want the report to be nonsensitive."
 D ^DIR K DIR
 W:$D(DTOUT) $C(7)
 Q:'Y!($D(DIRUT))
 S $P(^ESP(912,ESPOFN,5),U,4)=0
 W !!,"The report is now nonsensitive."
 Q
