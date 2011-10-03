PSACON ;BIR/LTL-Display Connected Drug and Procurement History ;7/23/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**15**; 10/24/97
 ;References to $$DESCR^PRCPUX1 are covered by IA #259
 ;References to ^DIC(51.5 are covered by IA #1931
 ;References to $$NSN^PRCPUX1 are covered by IA #259
 ;References to $$UNITCODE^PRCPUX1 are covered by IA #259
 ;References to $$UNITVAL^PRCPUX1 are covered by IA #259
 ;References to $$VENNAME^PRCPUX1 are covered by IA #259
 ;References to ^PSDRUG( are covered by IA #2095
 ;References to ^PRC( are covered by IA #214
 ;References to ^PRCP( are covered by IA #214
 ;
 N DA,DIC,DTOUT,DUOUT,PSA,PSACON,PSAW,X,Y
 D DT^DICRW
 F  S DIC="^PSDRUG(",DIC(0)="AEMQZ",DIC("S")="I $S('$D(^(""I"")):1,+^(""I"")>DT:1,1:0)",DIC("W")="W:'$O(^(441,0)) ?65,""NOT CONNECTED""" W ! D ^DIC K DA,DIC G:Y<0 END S PSA=+Y D  G:Y<0 END G:$G(PSAW) ^PSACONW D:$G(PSACON) ^PSACON1 D ^PSACON2
 .W @IOF,!!,$P($G(^PSDRUG(+PSA,0)),U),!!,?25,"** FROM THE DRUG FILE **",!!
 .W "FSN: ",$P($G(^PSDRUG(+PSA,0)),U,6),?40,"NDC: ",$P($G(^PSDRUG(+PSA,2)),U,4),!!
 .S PSA(5)=$S($P($G(^PSDRUG(+PSA,660)),U,5):$P($G(^(660)),U,5),1:1)
 .S PSA(6)=$P($G(^DIC(51.5,+$P($G(^PSDRUG(+PSA,660)),U,2),0)),U)
 .W "PACKAGING: ",PSA(5),"/",PSA(6)
 .S PSA(8)=$P($G(^PSDRUG(+PSA,660)),U,8)
 .W ?20,"PRICE: $",$P($G(^PSDRUG(+PSA,660)),U,3),"/",PSA(6)
 .W ?40,"PRICE/DISPENSE UNIT: $",$P($G(^PSDRUG(+PSA,660)),U,6),"/",PSA(8)
 .S PSA(15)=$O(^PSDRUG(+PSA,441,0)),PSA(1)=$G(^(+PSA(15),0))
 .;more than one item linked
 .D:$O(^PSDRUG(+PSA,441,PSA(15)))  Q:Y<0  K DIC,DA
 ..W !!,"There is more than one item linked to this drug.",!
 ..S DIC="^PSDRUG(+PSA,441,",DIC(0)="AEQ",DA(1)=+PSA
 ..S DIC("W")="W ?10,$$DESCR^PRCPUX1(0,$G(^(0)))"
 ..D ^DIC Q:Y<0  S PSA(1)=$G(^PSDRUG(+PSA,441,+Y,0)) K DIC,DA
 .I 'PSA(1) S Y=-1 Q
 .D:PSA(1)  Q:$D(DTOUT)!($D(DUOUT))
 ..W !!?25,"<< FROM THE ITEM MASTER FILE >>",!!
 ..S PSA(11)=$G(^PRC(441,+PSA(1),0))
 ..W "ITEM #: ",PSA(1),?15,$$DESCR^PRCPUX1(0,PSA(1)),!!
 ..W "NSN: ",$$NSN^PRCPUX1(PSA(1))
 ..I $P($G(^PRC(440,+$P(PSA(11),U,8),0)),U,11)="S" S PSAW=$O(^PRCP(445,"AC","W","")) Q
 ..S PSA(3)=$O(^PRC(441,+PSA(1),2,0))
 ..I PSA(3)&('$O(^PRC(441,+PSA(1),2,+PSA(3)))) D  Q
 ...W ?40,"ONLY VENDOR: ",$E($$VENNAME^PRCPUX1(+PSA(3)_"PRC(440"),1,28),!!
 ...S PSA(33)=$G(^PRC(441,+PSA(1),2,+PSA(3),0))
 ...W "VENDOR STOCK #: ",$P(PSA(33),U,4)
 ...W ?40,"NDC: ",$P(PSA(33),U,5),!!
 ...W "PACKAGING: ",$$UNITVAL^PRCPUX1($P(PSA(33),U,8),$P(PSA(33),U,7))
 ...W ?20,"PRICE: $",$P(PSA(33),U,2),"/",$$UNITCODE^PRCPUX1($P(PSA(33),U,7))
 ...W ?40,"PRICE/DISPENSE UNIT: $",$P(PSA(33),U,2)/PSA(5)
 ...W !!,"MINIMUM ORDER: ",$P(PSA(33),U,12)
 ...S Y=$P(PSA(33),U,6) X ^DD("DD")
 ...S Y=$E(Y,1,4)_$S($L(Y)=10:$E(Y,7,10),$L(Y)=11:$E(Y,8,11),1:"")
 ...W ?20,"PRICE DATE: ",Y
 ...W ?40,"REQUIRED ORDER MULTIPLE: ",$P(PSA(33),U,11),!!
 ..W !!,"LAST VENDOR ORDERED: ",$$VENNAME^PRCPUX1($P(PSA(11),U,4)_"PRC(440"),!!
 ..W "MANDATORY SOURCE: ",$$VENNAME^PRCPUX1($P(PSA(11),U,8)_"PRC(440"),!
 ..K IO("Q") N %ZIS,IOP,POP S %ZIS="Q",%ZIS("A")="For Vendor listing, please select DEVICE: " D ^%ZIS I POP S DTOUT=1,Y=-1 W !,"NO DEVICE SELECTED OR OUTPUT PRINTED!" Q
 ..I $D(IO("Q")) N ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTDTH,ZTSK S ZTRTN="^PSACON1",ZTDESC="DRUG VENDORS",ZTSAVE("PSA*")="" D ^%ZTLOAD,HOME^%ZIS S Y=1 Q
 ..S (DTOUT,PSACON)=1 Q
END K PSAOUT Q
