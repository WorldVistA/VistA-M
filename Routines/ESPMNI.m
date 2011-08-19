ESPMNI ;DALISC/CKA - MASTER NAME INPUT;5/92
 ;;1.0;POLICE & SECURITY;;Mar 31, 1994
EN ;
 ;Called from ^ESPOFF,
 ;ESPVAR=1 Master Name Input
 ;ESPVAR=2 Vehicle Registration
 ;ESPVAR=3 Offense Report
 ;ESPVAR=4 Violation Notice
 ;returns ESPFN- internal entry # of Master Name Index file
 S:'$D(ESPVAR) ESPVAR=1 S ESPNO=0 D DT^DICRW F I=.01:.01:.11 S ESPD(I)="",ESPD(I,"P")=""
 F I=1.01:.01:1.06 S ESPD(I)="",ESPD(I,"P")=""
 F I=2.01:.01:2.06 S ESPD(I)="",ESPD(I,"P")=""
 F I=3.01:.01:3.06 S ESPD(I)="",ESPD(I,"P")=""
X S DIR(0)="FO^1:30",DIR("A")="NAME",DIR("?")="Enter the name in'Last,First Middle' format [<30 characters].  You may also enter part of the name for lookup purposes",DIR("??")="^S D=""B"",DIC=""^ESP(910,"",DIC(0)=""EZ"" D DQ^DICQ K DIC"
 D ^DIR K DIR I $D(DIRUT) K ESPFN G EXIT
 S ESPX=Y
LKUP S DIC="^ESP(910,",DIC(0)="EMZ" D ^DIC K DIC S ESPFN=+Y
 I $D(DTOUT) G NOU
 I Y'<0 D FND G:Y["^"!($D(DTOUT)) NOU G:ESPNO ADD G:ESPVAR=1&('Y) EN G:ESPVAR=2&('Y) NUM^ESPVREG G:ESPVAR=3&('Y) RET G:ESPVAR=4&('Y) RETV D FDISP^ESPMNI2 G:$D(DTOUT) EXIT G:ESPVAR=1 EN G:ESPVAR=2 NUM^ESPVREG G:ESPVAR=3 RET G:ESPVAR=4 RETV G EXIT
 I Y<0 W !! G:$D(DUOUT) X
 S DIC(0)="E" D LAYGO^ESPXREF W !! G:$D(ESPOUT) EXIT G:'X X G:X NAME
ADD S DIR(0)="Y",DIR("A")="Do you want to add this name",DIR("B")="YES" D ^DIR G:$D(DIRUT) NOU K DIR
 I 'Y G X
NAME D ^ESPMNI0 G:$D(DUOUT)!('$D(ESPFN)) EN G:$D(DTOUT) EXIT
 G CONT^ESPMNI1
EXIT W:$D(DTOUT) $C(7)
 K %X,%Y,DA,DIC,DIR,DIRUT,DIWF,DIWL,DIWR,DUOUT,ESPAKA,ESPD,ESPDOB,ESPOUT,ESPJ,ESPNO,ESPX,I,IEN,X,Y,^TMP($J,"MNI")
 I ESPVAR=1 K ESPFN,ESPVAR
 QUIT
NOU W !!,$C(7),?20,"NO UPDATING HAS OCCURRED!!!",!! K DIR,ESPAKA,ESPD,^TMP($J,"MNI") G:$D(DTOUT) EXIT G EN
FND ;this entry exists already
 S Y=$P(Y(0),U,3) D DD^%DT S ESPDOB=Y,ESPNO=0
 W !!,"This name is already in the Master Name Index file.",!!?5,"Name: ",$P(Y(0),U),?40,"SSN: ",$P(Y(0),U,2),!?5,"DOB: ",ESPDOB,?25,"SEX: ",$P(Y(0),U,8),?35,"RACE: ",$S($D(^DIC(10,+$P(Y(0),U,9),0)):$P(^DIC(10,+$P(Y(0),U,9),0),U),1:""),!
 S DIR(0)="Y",DIR("A")="Is this the correct one" D ^DIR K DIR
 I 'Y S ESPNO=1 Q
YN1 S DIR(0)="Y",DIR("A")="Do you want to edit this record",DIR("B")="NO" D ^DIR K DIR W !! Q
RET W !,"Now returning to the Offense Report!" G EXIT
RETV W !,"Now returning to the Violation Notice!" G EXIT
