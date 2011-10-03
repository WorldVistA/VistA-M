PRCFAC0 ;WISC@ALTOONA/CTB-ROUTINE TO PROCESS OBLIGATIONS ;11/4/92  4:32 PM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 D ^PRCFSITE G:'% OUT3^PRCFAC01
 K DIC("A") S D="C",DIC("S")="I $D(^(7)),+^(0)=PRC(""SITE""),$D(^PRCD(442.3,+^(7),0)) S FSO=$P(^(0),U,3) I FSO>9,FSO<21",DIC("A")="Select Purchase Order Number: ",DIC=442,DIC(0)="AEQZ" D IX^DIC K DIC("S"),DIC("A"),FSO G:+Y<0 OUT3^PRCFAC01
 S PO(0)=Y(0),PO=Y,PRCFA("PODA")=+Y,PCP=+$P(PO(0),"^",3),$P(PCP,"^",2)=$S($D(^PRC(420,PRC("SITE"),1,+PCP,0)):$P(^(0),"^",12),1:"")
 I +$P(PO(0),U,3)=0!('$D(^PRC(420,PRC("SITE"),1,+PCP,0))) W $C(7),"PURCHASE ORDER DOES NOT CONTAIN A CONTROL POINT.",!,"UNABLE TO PROCESS, PLEASE RETURN TO SUPPLY FOR CORRECTION!" G OUT3^PRCFAC01
 I $P(PO(0),U,5)="",$P(PCP,"^",2)<2 F II=0:0 D CCEDIT Q:$P(PO(0),"^",5)]""  G:'% OUT3^PRCFAC01
 I +$P(PO(0),"^",16)=0 D NC G OUT3^PRCFAC01:%<0,NC^PRCFAC01:%=2
 I $P(PO(0),U,6)="",+$P(PO(0),U,7)'=0,$P(PCP,"^",2)="" F II=0:0 W !!,"No BOC data has been recorded for this Purchase Order.",$C(7) D SAEDIT Q:($P(PO(0),"^",6)]""&(+$P(PO(0),"^",7)=0))  Q:%<0
SC ;PAINT SCREEN
 I '$D(IOF)!('$D(IOM)) S IOP="HOME" D ^%ZIS K POP
 K II W @IOF,!?(IOM-37\2),"PURCHASE ORDER - "_$P(PO(0),"^"),!!,"  COST CENTER: "_$P(PO(0),"^",5),?IOM\2-4,"CONTROL POINT: "_$P(PO(0),"^",3)
 W !!,"BOC #1: "_$P(PO(0),"^",6),?IOM\2,"AMOUNT #1: $ "_$J($P(PO(0),"^",7),0,2),!!
 I $P(PO(0),"^",8)]"",$P(PO(0),"^",9)]"" W "BOC #2: "_$P(PO(0),"^",8),?IOM\2,"AMOUNT #2: $ "_$J($P(PO(0),"^",9),0,2),!!
 D:$D(^PRC(442,PRCFA("PODA"),13)) ^PRCFAC0J
 S %A="The information listed above is recorded on this Purchase order.",%A(1)="Is this information correct",%B="Entering a 'NO' will allow you to edit the Cost Center and BOCs.",%B(1)="An '^' will terminate the option.",%=1
 D ^PRCFYN G OUT3^PRCFAC01:%<1 I %=2 D:$P(PCP,"^",2)<2 CCEDIT G:'% OUT3^PRCFAC01 D:$P(PCP,"^",2)="" SAEDIT G SC
 S Z=PRC("SITE")_"-"_PRC("FY")_"-"_PRC("QTR")_"-"_$P($P(PO(0),"^",3)," "),C1=1
 G ^PRCFAC01
ONEITEM S DIC("A")="Select ITEM: ",DA=PRCFA("PODA"),DIC="^PRC(442,"_DA_",2,",DIC(0)="AEQMZ" D ^DIC K DIC("A") I Y<0 S:X["^" PRCFOUT="" D ^PRCHS S PO(0)=^PRC(442,PRCFA("PODA"),0) S %=$S($D(PRCFOUT):-1,1:1) Q
 S DA=+Y,DIE=DIC,DR=3.5 D ^DIE S DIC("A")="Select Next ITEM: " G ONEITEM
ALLITEMS S DIC=420.2,DIC(0)="AQEMNZ" D ^DIC Q:Y<0  S SA=+Y
 I $P(PO(0),"^",5)="" W !,"You're missing a Cost Center.  Let's start over." G OUT3^PRCFAC01
 S SA=Y(0) I '$D(^PRCD(420.1,$P(PO(0),"^",5),1,+SA)) W $C(7) S %A="BOC "_+SA_" is not valid with Cost Center "_$P(PO(0),"^",5)_".  OK to continue",%B="",%=2 D ^PRCFYN I %'=1 S %=-1 Q
 S %A="I will now enter BOC "_+SA_", on all items.  Is this OK",%B="",%=2 D ^PRCFYN Q:%'=1
 S DA=0 F I=1:1 S DA=$O(^PRC(442,+PO,2,DA)) Q:'DA  S:$D(^(DA,0)) $P(^(0),"^",4)=$P(SA,"^")
 K SA S DA=PRCFA("PODA") D ^PRCHS S PO(0)=^PRC(442,PRCFA("PODA"),0) Q
SAEDIT S %A="Do you wish to assign the same BOC to ALL items",%B="",%=2 D ^PRCFYN G ALLITEMS:%=1,ONEITEM:%=2 Q
CCEDIT S DA=PRCFA("PODA"),DR="2;",DIE="^PRC(442," D ^DIE S %=1 I $D(Y) S %=0 Q
 S PO(0)=^PRC(442,DA,0) Q
NC S %A="This order appears to be a 'NO CHARGE' order.  Do you need to take",%A(1)="any action on this order",%B="'No' will mark the order appropriately and return it to supply."
 S %B(1)="'Yes' will allow you to continue and create a code sheet.",%B(2)="'^' to exit.",%=2 D ^PRCFYN Q:%'=2
 D SIG^PRCFACX0 I $D(PRCFA("SIGFAIL")) K PRCFA("SIGFAIL") S %=-1 Q
 S %=2 Q
