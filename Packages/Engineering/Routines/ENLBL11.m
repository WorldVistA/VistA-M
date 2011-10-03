ENLBL11 ;(WASH ISC)/DH-Print Bar Coded Equipment Labels ;1/11/2001
 ;;7.0;ENGINEERING;**12,35,45,68,90**;Aug 17, 1993;Build 25
 ;
WRKLST ;Print labels for PM worklist
 S ENERR=0 D STA^ENLBL3 G:ENEQSTA="^" QUIT^ENLBL3
 I '$D(DT) S %DT="",X="T" D ^%DT G:Y'>0 EXIT1^ENLBL8 S DT=+Y
 S ENPMDT="",Y=$E(DT,1,5)_"00" X ^DD("DD") S %DT("A")="Select MONTH: ",%DT("B")=Y,%DT="AEFMX" D ^%DT K %DT G:Y'>0 EXIT1^ENLBL8 S ENPMDT=$E(Y,2,5)
 D SSHOP^ENWO G:ENSHKEY'>0 EXIT1^ENLBL8 S ENPM=""
MORW W !,"MONTHLY worklist" S %=1 D YN^DICN G:%<0 EXIT1^ENLBL8 I %=0 W !!,"YES for a MONTHLY worklist; NO for a WEEKLY worklist.",*7 G MORW
 S:%=1 ENPM="M" D:ENPM="" WEEK G:X="^" EXIT1^ENLBL8
 S ENPMWO(0)="PM-"_$P(^DIC(6922,ENSHKEY,0),U,2)_ENPMDT_ENPM,ENPMWO=$O(^ENG(6920,"B",ENPMWO(0))) I ENPMWO'[ENPMWO(0) W !,*7,"Worklist is empty." D HOLD G EXIT1^ENLBL8
 S DIR(0)="Y",DIR("A")="New labels only",DIR("B")="YES"
 S DIR("?",1)="The system records the printing of equipment bar code labels. If you do not"
 S DIR("?",2)="wish to have labels printed again if they have already been printed at least"
 S DIR("?")="once, please enter 'YES' at this time."
 D ^DIR K DIR Q:$D(DIRUT)  ;Suppress reprints?
 S ENEQREP=+Y
 K IO("Q") S %ZIS("A")="Select BAR CODE PRINTER: ",%ZIS("B")="",%ZIS="Q" D ^%ZIS K %ZIS("A"),%ZIS("B") G:POP EXIT1^ENLBL8
 S ENBCIO=IO,ENBCIOSL=IOSL,ENBCIOF=IOF,ENBCION=ION,ENBCIOST=IOST,ENBCIOST(0)=IOST(0),ENBCIOS=IOS S:$D(IO("S")) ENBCIO("S")=IO("S")
 I $D(IO("Q")) K IO("Q") S ZTIO=ION,ZTRTN="WRKLST1^ENLBL11",ZTSAVE("EN*")="",ZTDESC="Bar Code Labels for PM Worklist" D ^%ZTLOAD K ZTSK D HOME^%ZIS G EXIT1^ENLBL8
 ;HD308658
WRKLST1 S ENEQBY="",ENBCIO=IO U ENBCIO D FORMAT^ENLBL7 S ENDA=$O(^ENG(6920,"B",ENPMWO,0)) I ENDA>0 S DA=$S($D(^ENG(6920,ENDA,3)):$P(^(3),U,8),1:"") I DA]"" D STATCK^ENLBL3 I DA]"" D NXPRT^ENLBL7,BCDT^ENLBL7
WRKLST2 S ENPMWO=$O(^ENG(6920,"B",ENPMWO)) I ENPMWO[ENPMWO(0) S ENDA=$O(^ENG(6920,"B",ENPMWO,0)) I ENDA>0,$P($G(^ENG(6920,ENDA,5)),U,2)="" D
 . S DA=$P($G(^ENG(6920,ENDA,3)),U,8) I DA]"" D STATCK^ENLBL3 I DA]"" D NXPRT^ENLBL7,BCDT^ENLBL7
 D:'(DA#10) DOTS^ENLBL3 G:ENPMWO[ENPMWO(0) WRKLST2
 G EXIT1^ENLBL8
 ;
HOLD W !,"Press <RETURN> to continue..." R X:DTIME
 Q
WEEK R !,"Week number (enter an integer from 1 to 5, or '^' to escape): ",X:DTIME Q:X="^"
 I X?1N,X>0,X<6 S ENPM="W"_X
 E  W "??",*7 G WEEK
 Q
 ;ENLBL11
