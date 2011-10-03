ESPORR ;DALISC/CKA - REVIEW COMPLETED OFFENSE REPORT;12/92
 ;;1.0;POLICE & SECURITY;;Mar 31, 1994
 ;Locked with ESP SUPERVISOR key
EN ;ASK UOR #- can choose only completed reports
 ;If hold ESP CHIEF key then can see confidential reports too
 ;ESPVAR=4
 D DT^DICRW S ESPVAR=4
 I $D(^XUSEC("ESP CHIEF",DUZ)) G ORC
OR S DIC(0)="QAEMZ",DIC("A")="UOR#: ",DIC("S")="I $D(^(5)),$P(^(5),U,2),'$P(^(5),U,4),$P(^(5),U,5),$P(^(0),U,8)=""O""",DIC="^ESP(912,"
 D ^DIC
 G:$D(DTOUT)!($D(DUOUT))!(X="") EXIT
 G:Y<0 OR S ESPDTR=$P(^ESP(912,+Y,0),U,2),(ESPID,ESPOFN)=+Y
 G PRT
ORC S DIC(0)="QAEMZ",DIC("A")="UOR#: ",DIC("S")="I $P(^(5),U,2),$P(^(5),U,5),$P(^(0),U,8)=""O""",DIC="^ESP(912,"
 D ^DIC G:$D(DTOUT)!($D(DUOUT))!(X="") EXIT G:Y<0 ORC S ESPDTR=$P(^ESP(912,+Y,0),U,2),(ESPID,ESPOFN)=+Y
PRT G PRT^ESPOFFE
EXIT K DIC,ESPDTR,ESPID,ESPOFN,ESPUOR,ESPVAR
 QUIT
