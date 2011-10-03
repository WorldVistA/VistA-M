ESPOFFDE ;DALISC/CKA- DELETE AN OFFENSE REPORT;8/92
 ;;1.0;POLICE & SECURITY;40;Mar 31, 1994
EN ;This program allows a person holding the ESP CHIEF key to delete
 ;an offense report.  The program sets the deleted/reopened flag
 ;and stores the date/time and user # of the person deleting the
 ;report.  It does not REALLY delete the report; it logically deletes
 ;the report.
 ;** The offense report to be deleted *MUST* be closed prior to deleting.
UOR S DIC(0)="QAEMZ",DIC("A")="UOR#: ",DIC("S")="I $D(^(5)),$P(^(5),U,2),$P(^(5),U,5)",DIC="^ESP(912,"
 D ^DIC
 G:$D(DTOUT)!($D(DUOUT))!(X="") EXIT
 G:Y<0 OR
 I $P(^ESP(912,+Y,0),U,8)'="C" W !,$C(7),"Cannot delete an 'open' UOR#, must close first." G UOR
 S ESPDTR=$P(^ESP(912,+Y,0),U,2),(ESPID,ESPOFN)=+Y
ASK S DIR(0)="Y",DIR("A")="Are you sure you want to delete this offense report",DIR("B")="NO" D ^DIR K DIR
 G:$D(DTOUT) EXIT
 G:'Y EXIT
DEL ;DELETE REPORT
 D NOW^%DTC S ESPNOW=%
 S $P(^ESP(912,ESPOFN,5),U,5)="D",$P(^(5),U,6)=ESPNOW,$P(^(5),U,7)=DUZ
 W !!,"The report is deleted."
EXIT W:$D(DTOUT) $C(7)
 K DIC,DTOUT,DUOUT,ESPDTR,ESPID,ESPN,ESPNOW,ESPOFN,Y Q
OR W !,$C(7),"I could not find this UOR#.  Try again."
 G UOR
 QUIT
