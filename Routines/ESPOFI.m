ESPOFI ;DALISC/CKA- ENTER/EDIT FOLLOW-UP INVESTIGATION NOTES;5/93
 ;;1.0;POLICE & SECURITY;;Mar 31, 1994
EN ;This routine allows the officer to enter follow-up investigation notes.
 ;When the officer hits '??' at the UOR# prompt, he/she will see open offense reports.
START D DT^DICRW
 I '$D(^XUSEC("ESP CHIEF",DUZ)) G OR
ORC ;This allows persons holding the ESP CHIEF key to add follow-up notes to sensitive reports
 S DIC(0)="QAEMZ",DIC("A")="UOR#: ",DIC("S")="I $D(^(5)),$P(^(5),U,5),$P(^(0),U,8)=""O""",DIC="^ESP(912,"
 D ^DIC G:$D(DTOUT)!($D(DUOUT)) EXIT G:Y<0 OR S ESPDTR=$P(^ESP(912,+Y,0),U,2),(ESPID,ESPOFN)=+Y
 G DISP
OR ;This allows persons to add follow-up notes to nonsensitive reports
 S DIC(0)="QAEMZ",DIC("A")="UOR#: ",DIC("S")="I $D(^(5)),'$P(^(5),U,4),$P(^(5),U,5)",DIC="^ESP(912,"
 D ^DIC
 G:$D(DTOUT)!($D(DUOUT))!(X="") EXIT
 G:Y<0 OR S ESPDTR=$P(^ESP(912,+Y,0),U,2),(ESPID,ESPOFN)=+Y
 I $P(^ESP(912,+Y,0),U,8)="C" W !,$C(7),"This report is closed and follow-up notes cannot be added!" G OR
DISP ;ASK IF WANT TO DISPLAY THIS REPORT
 S DIR(0)="Y",DIR("A")="Do you want to print the report first",DIR("B")="NO" D ^DIR K DIR
 G:$D(DTOUT) EXIT
 I 'Y G EDIT
Q S %ZIS="Q" D ^%ZIS G:POP EXIT I '$D(IO("Q")) U IO D START^ESPORP G EDIT
 S ZTRTN="START^ESPORP",ZTSAVE("ESP*")="",ZTDESC="OFFENSE REPORT" D ^%ZTLOAD,HOME^%ZIS
 W !!!!
 G:$D(DTOUT) EXIT
EDIT ;ADD/EDIT FOLLOW-UP NOTES
 D DT^DICRW
 S DIE="^ESP(912,",DA=ESPOFN,DIE("NO^")="OUTOK",DR="[ESP FOLLOW-UP NOTES"
 L +^ESP(912,DA):1 I '$T W !,"Another user is editing this record!!" G EXIT
 D ^DIE
 L -^ESP(912,ESPOFN)
EXIT W:$D(DTOUT) $C(7)
 K %ZIS,DA,DD,DIC,DIE,DIR,DO,DR,DTOUT,DUOUT,ESPDTR,ESPID,ESPOFN,X,Y Q
