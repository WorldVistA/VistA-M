ESPOFFE ;DALISC/CKA- OFFENSE REPORT EDIT;8/92
 ;;1.0;POLICE & SECURITY;**3,12,15,21**;Mar 31, 1994
EN ;The program will check for CHIEF key.
 ;If don't have key-Must be completed and unconfidential-OR
 ;If have key- can edit any OPEN report ORC
 D DT^DICRW S ESPVAR=1
 I $D(^XUSEC("ESP CHIEF",DUZ)) G ORC
OR S DIC(0)="QAEMZ",DIC("A")="UOR#: ",DIC("S")="I $D(^(5)),$P(^(5),U,2),'$P(^(5),U,4),$P(^(5),U,5),$P(^(0),U,8)=""O""",DIC="^ESP(912,"
 D ^DIC
 G:$D(DTOUT)!($D(DUOUT))!(X="") EXIT
 G:Y<0 OR S ESPDTR=$P(^ESP(912,+Y,0),U,2),(ESPID,ESPOFN)=+Y
 G PRT
ORC S DIC(0)="QAEMZ",DIC("A")="UOR#: ",DIC("S")="I $D(^(5)),$P(^(5),U,5),$P(^(0),U,8)=""O""",DIC="^ESP(912,"
 D ^DIC G:$D(DTOUT)!($D(DUOUT))!(X="") EXIT G:Y<0 ORC S ESPDTR=$P(^ESP(912,+Y,0),U,2),(ESPID,ESPOFN)=+Y
PRT ;CALLS ESPORP,ESPORP1,ESPORP2- PRINTS THE REPORT
Q S %ZIS="Q" D ^%ZIS G:POP EXIT I '$D(IO("Q")) U IO D START^ESPORP G OK
 S ZTRTN="START^ESPORP",ZTSAVE("ESP*")="",ZTDESC="OFFENSE REPORT" D ^%ZTLOAD,HOME^%ZIS
 W !!!!
OK G:ESPVAR=4 CLO
 S DIR(0)="Y",DIR("A")="Do you want to edit",DIR("B")="YES" D ^DIR K DIR W !!
 I $D(DTOUT) W $C(7) G EXIT
 I Y G EDIT
 ;if ESPVAR=0, report is incomplete, resume editing own
 ;if ESPVAR=1, report could be incomplete or complete, editing own or any if chief
 ;if ESPVAR=2, opened a closed report
 ;if ESPVAR=3, created a report
 ;if ESPVAR=4, reviewing a completed report
 I (ESPVAR=0)!(ESPVAR=3) G COMP
 I ESPVAR=1,$P($G(^ESP(912,ESPOFN,5)),U,2),$D(^XUSEC("ESP CHIEF",DUZ)) G CLO
 I ESPVAR=1,$D(^XUSEC("ESP CHIEF",DUZ)) G COMP
 G EXIT
EDIT ;CALL DIE TO EDIT OFFENSE REPORT
 S DIE="^ESP(912,",DA=ESPOFN,DR="[ESP OFFENSE REPORT EDIT 1"
 L +^ESP(912,DA):1 I '$T W !,"Another user is editing this record!!" G EXIT
 D ^DIE
 S DIE="^ESP(912,",DA=ESPOFN,DR="[ESP OFFENSE REPORT EDIT 2"
 D ^DIE
 S DIE="^ESP(912,",DA=ESPOFN,DR="[ESP OFFENSE REPORT EDIT 3"
 D ^DIE
 S DIE="^ESP(912,",DA=ESPOFN,DR="[ESP OFFENSE REPORT 4"
 D ^DIE
 S DIE="^ESP(912,",DA=ESPOFN,DR="[ESP OFFENSE REPORT 5"
 D ^DIE
 I ESPVAR=0!(ESPVAR=3) G COMP
 I ESPVAR=1,$P($G(^ESP(912,ESPOFN,5)),U,2),$D(^XUSEC("ESP CHIEF",DUZ)) G CLO
 I ESPVAR=2 G CLO
 G EXIT
COMP ;ASK IF WANT TO COMPLETE REPORT OR NOT
 W !! S DIR(0)="Y",DIR("A")="Is the report completed",DIR("?")="Answer YES or NO.",DIR("??")="^W !,""Answer NO if you don't wish to complete the report at this time.  Answer YES if you do."""
 D ^DIR K DIR
 I 'Y!($D(DIRUT)) G EXIT
 D ^ESPVAL
 I $P(^ESP(912,ESPOFN,5),U,2) D SEND
 G EXIT
CLO ;ASK IF WANT TO CLOSE THE REPORT
 I ('$D(^XUSEC("ESP CHIEF",DUZ))&'$D(^XUSEC("ESP SUPERVISOR",DUZ))) G EXIT
 I ESPVAR=4 D SAT I UNSAT G EXIT
 G:$D(DTOUT) EXIT
 I '$P(^ESP(912,ESPOFN,5),U,2) W !!,$C(7),"The report must be completed before closing!" G EXIT
CLO1 ;entry point from 'close an offense report' option
 S DIR(0)="Y",DIR("A")="Do you want to close the report",DIR("?")="Answer YES or NO.",DIR("??")="^W !,""Answer NO if you don't want to close the report.  Answer YES if you do."""
 D ^DIR K DIR
 I 'Y!($D(DIRUT)) G EXIT
 I Y S $P(^ESP(912,ESPOFN,0),U,8)="C" W !!,"The report is now closed."
 L -^ESP(912,ESPOFN)
EXIT K %ZIS,DA,DIC,DIE,DIR,DIRUT,DR,DTOUT,DUOUT,ESPDTR,ESPID,ESPN,ESPNO,ESPOFN,ESPVAR,ESPY,POP,UNSAT,Y,ZTDESC,ZTRTN,ZTSAVE Q
SEND S ESPDTR=$P(^ESP(912,ESPOFN,0),U,2),XMB(1)=$$CONV^ESPUOR(ESPDTR),XMB(2)=$P($G(^VA(200,+$P(^ESP(912,ESPOFN,0),U,6),0)),U),XMB(3)=$P($G(^VA(200,+$P($G(^ESP(912,ESPOFN,5)),U,3),0)),U)
 S XMB="ESP UOR COMPLETED" D EN^XMB
 QUIT
ASK2 ;CALLED FROM ESPOFFC- COMPLETE A REPORT
 S DIR(0)="Y",DIR("A")="Do you want to print the report first",DIR("B")="NO" D ^DIR K DIR
 I $D(DTOUT) W $C(7) G EXIT
 I 'Y G OK
 G PRT
SAT ;ASK IF REPORT IS COMPLETED FULLY AND SEND BULLETIN TO OFFICER 
 ;IF ADDITIONAL INFO NEEDED
 S UNSAT=0
 S DIR(0)="Y",DIR("A")="Is the report completed fully",DIR("B")="YES" D ^DIR K DIR
 Q:Y!($D(DIRUT))
 S ESPDTR=$P(^ESP(912,ESPOFN,0),U,2),XMB(1)=$$CONV^ESPUOR(ESPDTR),XMB="ESP SUPERVISOR REVIEW",XMY($P(^ESP(912,ESPOFN,0),U,6))="" D EN^XMB
 S UNSAT=1
 Q
