ESPEVID ;DALISC/CKA- MAKE AN EVIDENCE RECORD SENSITIVE OR NONSENSITIVE;5/93
 ;;1.0;POLICE & SECURITY;;Mar 31, 1994
EVID ;ENTRY POINT FOR MAKE A THIS EVIDENCE RECORD SENSITIVE
 S DIC(0)="QAEMZ",DIC="^ESP(910.8,"
 D ^DIC
 G:$D(DTOUT)!($D(DUOUT))!(X="") EXIT
 G:Y<0 EVID S ESPEVID=+Y
CHK I $P(^ESP(910.8,ESPEVID,0),U,4) D UNCONF G EXIT
CONF ;MAKE REPORT SENSITIVE
 S $P(^ESP(910.8,ESPEVID,0),U,4)=1
 W !!,"This evidence record is now sensitive."
EXIT W:$D(DTOUT) $C(7)
 K DIC,DIRUT,DTOUT,DUOUT,ESPEVID,X,Y Q
UNCONF ;MAKE EVIDENCE RECORD NONSENSITIVE
 W !!,"This evidence record is now sensitive."
ASK S DIR(0)="Y",DIR("A")="Do you want to make it nonsensitive",DIR("?")="Answer YES or NO.",DIR("??")="Answer NO if you want the report to remain sensitive.  Answer YES if you want the report to be nonsensitive."
 D ^DIR K DIR
 Q:'Y!($D(DIRUT))
 S $P(^ESP(910.8,ESPEVID,0),U,4)=0
 W !!,"This evidence record is now nonsensitive."
 Q
