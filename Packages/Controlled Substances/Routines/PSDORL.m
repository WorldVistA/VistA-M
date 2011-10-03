PSDORL ;BIR/JPW/LTL-CS Order Entry Listing and Cancel ; 19 Dec 94
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
LIST ;list if pending orders
 W !!,"Searching for pending orders..."
 S PSDOUT=0 D SORT G:PSDOUT END
CANC ;ask to cancel orders
 K DA,DIR,DIRUT S DIR(0)="Y",DIR("A")="Do you wish to cancel any pending orders",DIR("?")="Answer YES to select order(s) to cancel, NO or ^ to continue this order."
 S DIR("B")="NO" D ^DIR I 'Y!($D(DIRUT)) D MSG G END
 D PRT
ASK K DA,DIR,DIRUT
 W !,"You may cancel one order at a time.",!
 S DIR("A")="Please enter the order number you wish to cancel",DIR(0)="NO^1:"_OCNT,DIR("?")="Answer with the order number you wish to cancel or <RET> to continue with your order"
 D ^DIR I 'Y D MSG G END
 S KKO=+Y
ORD ;update ord
 K DA,DIE,DR S DIE="^PSD(58.8,"_NAOU_",1,"_PSDR_",3,",DA=+$P($G(LOC(KKO)),"^",2),DA(1)=PSDR,DA(2)=NAOU,DR="10////9;19////@" D ^DIE K DA,DIE,DR
 S DA=+$P($G(LOC(KKO)),"^")
 K DIE,DR S DIE=58.85,DR="6////9" D ^DIE K DA,DIE,DR
 W $C(7),!!,"** The order you selected has been cancelled. **",!
 G LIST
END K AA,DA,DIR,DIROUT,DIRUT,DTOUT,DUOUT,JJ,KK,KKO,KK2,KK3,KK4,KK5,LL,LOC,NODEL,OCNT,PSDOUT,TOT,Y
 Q
MSG W !!,"No orders cancelled.  Continue processing your order.",!
 Q
SORT ;searches for orders
 K LL
 S (AA,TOT,OCNT)=0 F  S AA=$O(^PSD(58.85,"AC",AA)) Q:'AA!(AA>3)  S JJ=0 F  S JJ=$O(^PSD(58.85,"AC",AA,+NAOU,+PSDR,JJ)) Q:'JJ  S KK=0 F  S KK=$O(^PSD(58.85,"AC",AA,+NAOU,+PSDR,JJ,KK)) Q:'KK  D
 .Q:'$D(^PSD(58.85,KK,0))  S NODEL=^PSD(58.85,KK,0),TOT=TOT+$P(NODEL,"^",6),OCNT=OCNT+1
 .I AA=1,'+$G(^PSD(58.85,KK,2)) S LL(KK)=""
 W !!,$S(OCNT:"Orders pending: "_OCNT_"  Quantity Ordered ("_NBKU_"): "_TOT,1:"No orders pending"),!!
 I 'OCNT S PSDOUT=1 Q
 I '$O(LL(0)) W $C(7),"All pending orders are currently being processed.  Please review the PENDING ",!,"CS ORDERS REPORT for more information.",! S PSDOUT=1 Q
 Q
PRT ;displays list
 K LOC
 W !!,"Accessing pending orders for ",PSDRN,"...",!!,"The following orders may be cancelled:",!
 W !,?6,"DATE ORDERED",?25,"QUANTITY",?38,"ORDERED BY",! S (KK,OCNT)=0
 F  S KK=$O(LL(KK)) Q:'KK  I $D(^PSD(58.85,KK,0)),'$D(^PSD(58.85,KK,2)) D
 .S NODEL=^PSD(58.85,KK,0) Q:$P(NODEL,"^",7)>1
 .Q:+$P($G(NODEL),"^",8)  S KK2=+$P($G(NODEL),"^",5),KK3=+$P($G(NODEL),"^",6),(KK4,Y)=+$P($G(NODEL),"^",18) X ^DD("DD") S KK4=Y
 .S KK5=+$P($G(NODEL),"^",12),KK5=$S($P($G(^VA(200,KK5,0)),"^")]"":$P($G(^(0)),"^"),1:"UNKNOWN")
 .S OCNT=OCNT+1,LOC(OCNT)=KK_"^"_KK2_"^"_KK3_"^"_KK4_"^"_KK5
 .W !,"(",OCNT,")",?5,KK4,?25,$J(KK3,8),?38,KK5
 W !
 Q
