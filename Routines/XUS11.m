XUS11 ;SFISC/RWF - READ AND STORE DA FROM TERMINALS ;3/11/93  07:48
 ;;8.0;KERNEL;;Jul 10, 1995
A W !!,"This routine will get the ANSI DA for your terminal.",!,"And allow you to save it."
 W !,"First lets get the DA response from your terminal",!,">"
 X ^%ZOSF("TYPE-AHEAD") S D1=""
 W $C(27,91,99) R *X:2 I X=27 F  R X#1:2 S D1=D1_X Q:'$T!(X="c")
 I $E(D1,1)'="[" W !!,$C(7)," This doesn't start with a '[' like it should." G EXIT
 S DIC="^%ZIS(3.22,",DIC(0)="MZ",X=D1 D ^DIC S DA=+Y
 G B:DA'>0
 W !,"This DA code is already assigned to terminal type: ",$P(Y(0),U,2)
 S DIR(0)="Y",DIR("A")="Want to change this" D ^DIR G EXIT:$D(DIRUT)!(Y'=1)
B W !,"Now, What terminal type are you on?"
 S DIC="^%ZIS(2,",DIC(0)="AEMQ" D ^DIC G EXIT:Y<1 S T1=$P(Y,U,2)
 W !!,"ANSI DA response of ",D1,!?7," to set sign on to terminal type ",T1
 S DIR(0)="Y",DIR("A")="OK to file this" D ^DIR G EXIT:$D(DIRUT)!(Y'=1)
 S DIC="^%ZIS(3.22,",DIC(0)="MLZ",DLAYGO=3,X=D1 D ^DIC S DA=+Y
 I $P(Y(0),U,2)'=T1 S DIE=DIC,DR="2///"_T1_";3" D ^DIE
 W !,"Done"
 ;
EXIT K DIR,DIE,DIC,T1,D1,Y
 Q
