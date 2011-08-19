QANAUX1 ;;HISC/GJC-UTILITIES FOR INCIDENT REPORTING ;4/26/91
 ;;2.0;Incident Reporting;**26**;08/07/1992
 ;
EN0 ;Mark a incident record for deletion, also the associated patient(s).
 W !!,$C(7),"This option will allow the user to open, close, or delete a record at the local level.",!,"The appropriate patient(s) records are marked to reflect the change."
 K DIC,DINUM,DLAYGO S DIC=742.4,DIC(0)="QEAMZ",DIC("A")="Select Incident: "
 D ^DIC K DIC,DINUM,DLAYGO Q:+Y=-1
 S QANIEN=+Y K DIE,DR S DIE="^QA(742.4,",DA=QANIEN,DR=".09" D ^DIE K DIE,DR,DA S QAN0=$G(^QA(742.4,QANIEN,0))
 I $D(Y)!(QAN0="") W !!,$C(7),"No action taken, premature exit action encountered." G KILL
 S QANMSS(0)="W !!,$C(7),""Appropriate Patient(s) records now being marked as deleted!"""
 S QANMSS(1)="W !!,$C(7),""Appropriate Patient(s) records now being marked as closed!"""
 S QANMSS(2)="W !!,$C(7),""Appropriate Patient(s) records now being marked as open!"""
 X $S(+$P(QAN0,U,8)=2:QANMSS(0),+$P(QAN0,U,8)=0:QANMSS(1),1:QANMSS(2))
 K DIE,DR S DIE="^QA(742,",DR=$S(+$P(QAN0,U,8)=2:".13///^S X=""-1""",+$P(QAN0,U,8)=0:".13///^S X=""0""",1:".13///^S X=""1""")
 F QAN=0:0 S QAN=$O(^QA(742,"BCS",QANIEN,QAN)) Q:QAN'>0  S DA=QAN D ^DIE
KILL K QANIEN,QAN0,QAN,DA,DIE,DR,QANMSS,Y
 Q
EN1 ;Choose the MAILGROUP.
 L +^QA(740,1,0):5 I '$T W !!?16,$C(7),"Another person is editing this entry." Q
 K DA,DIE,DR S DIE="^QA(740,",DA=1,DR="[QAQA QAN SITE PARAMETERS]" D ^DIE
 L -^QA(740,1,0)
 K %X,%Y,D,D0,DA,DI,DIC,DIE,DQ,DR
 Q
EN2 ;INCIDENT STATUS ENTER/EDIT
 S (DIC,DIE)="^QA(742.1,",DIC("A")="Select Incident Type: ",DIC(0)="QEALMNZ",D="B^BUPPER",DIC("S")="I $P(^(0),U,6)'=""N"""
 D MIX^DIC1 K DIC,DINUM,DLAYGO Q:+Y=-1
 S QANQAN=+Y,DA=QANQAN
 I $P(Y,U,3)=1 S DR=".07///"_"L" D ^DIE
 L +^QA(742.1,QANQAN,0):5 I '$T W !!?16,$C(7),"Another person is editing this entry." Q
 S DR=".01  INCIDENT" D ^DIE
 I $D(Y) L -^QA(742.1,QANQAN,0) Q
 S QAN0=$G(^QA(742.1,QANQAN,0))
 S DA=QANQAN,DR=".02;.04;.06" D ^DIE ;remove .03 and .05 from DR in QAN26
 K DIR S DIR(0)="SA^1:INACTIVE;L:LOCAL",DIR("A")="Incident Status: "
 S DIR("?")="Enter ""1"" for Inactive, ""L"" for Local."
 S DIR("B")=$S($P(QAN0,U,6)="L":"LOCAL",1:"INACTIVE") D ^DIR K DIR
 I $D(DTOUT)!($D(DUOUT))!($D(DIROUT)) L -^QA(742.1,QANQAN,0) Q
 S DR=$S(Y=1:".07///1",1:".07///L") D ^DIE
 L -^QA(742.1,QANQAN,0)
 Q
EN3 ;Choose X again.
 W !!?5,$C(7),"Number """_X_""" previously chosen, try again"
 K X
 Q
HDR ;Header generator.
 S PAGE=PAGE+1 W @IOF,!,?$S(IOM=132:114,1:69),TODAY,!,?$S(IOM=132:114,1:69),"Page: ",PAGE,!!
 W ?(IOM-$L(QANHEAD(0))\2),QANHEAD(0)
 I $D(QANCHOS),QANCHOS="I" W !,?(IOM-$L(QANHEAD(1))\2),QANHEAD(1)
 I '$D(QANCHOS) W !,?(IOM-$L(QANHEAD(1))\2),QANHEAD(1)
 I $D(QANCHOS),QANCHOS="W" W !,?(IOM-$L(QANHEAD(2))\2),QANHEAD(2)
 W !,?(IOM-$L(QANHEAD(3))\2),QANHEAD(3),!
 I $G(QANDVFLG)=1 W !,?(IOM-$L(QANHEAD(4))\2),QANHEAD(4),!
 F LOOP=1:1:2 W BNDRY,!
 W:$D(QANCHOS) !,$S(QANCHOS="I":"INCIDENT LOCATION",1:"PATIENT'S WARD"),?35,"INCIDENT",?70,"NUMBER",!,"------------------",?35,"--------",?70,"------",!
 W:'$D(QANCHOS) !?17,"INCIDENT",?57,"NUMBER",!?17,"--------",?57,"------"
 Q
WARN ;Deleting a patient's record.
 W !?5,"Patient: ",$P(^DPT($P(^QA(742,QANPAT,0),U),0),U)_"// "
WARN1 F QAN=0:0 R QANST:DTIME S:'$T QANST="^" Q:QANST?1"@"!(QANST']"")!(QANST["^")  W !!?5,$C(7),"Enter ""@"" to delete a record, <CR> to keep the patient active.",!!?5,"Patient: ",$P(^DPT($P(^QA(742,QANPAT,0),U),0),U)_"// "
 Q:QANST["^"!(QANST']"")
WARN2 ;Checks for associated incident deletion
 S QANYN=0
 I QANST["@" W !!,$C(7),"Are you sure you want to delete?",!,"Deletion marks the associated incident as deleted."
 I  K DIR S DIR(0)="Y" D ^DIR S QANYN=+Y
 I QANYN K DA,DIE,DR S DIE="^QA(742,",DA=QANPAT,DR=".13///^S X=""-1""" D ^DIE K DA,DIE,DR S DIE="^QA(742.4,",DA=QANINCD,DR=".09///^S X=""2""" D ^DIE K DA,DIE,DR
 I QANYN D AUDIT
 ;CODE TO DELETE A PATIENT AND DELETE AN INCIDENT
 Q
AUDIT ;Enter entries in the QA Audit file.
 K QAUDIT S QAUDIT("FILE")="742^50",QAUDIT("DA")=QANPAT,QAUDIT("ACTION")="d",QAUDIT("COMMENT")="Delete a patient record" D ^QAQAUDIT
 K QAUDIT S QAUDIT("FILE")="742.4^50",QAUDIT("DA")=QANINCD,QAUDIT("ACTION")="d",QAUDIT("COMMENT")="Delete an incident record" D ^QAQAUDIT
 Q
