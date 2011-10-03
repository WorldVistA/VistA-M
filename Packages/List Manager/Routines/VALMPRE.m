VALMPRE ;ALB/MJK - LM Pre-Init ;05:33 PM  15 Dec 1992;
 ;;1;List Manager;;Aug 13, 1993
 ;
EN ; -- pre-init
 D PROT
 Q
 ;
PROT ; -- delete old demo protocols
 N VALMX,VALMI,DA,DIK,VALMPRE
 S VALMPRE="VALM DEMO "
 G PROTQ:$E($O(^ORD(101,"B",VALMPRE)),1,$L(VALMPRE))'=VALMPRE
 W !!,">>> Will now delete demo protocols..."
 S VALMX=VALMPRE
 F  S VALMX=$O(^ORD(101,"B",VALMX)) Q:VALMX=""!($E(VALMX,1,$L(VALMPRE))'=VALMPRE)  D
 .S VALMI=0 F  S VALMI=$O(^ORD(101,"B",VALMX,VALMI)) Q:'VALMI  D
 ..S DA=VALMI,DIK="^ORD(101," D ^DIK
 ..W !?10,"o ",VALMX,?45,"...deleted"
 W !!,">>> A new set of demo protocols will be added during the install."
 S DA=$O(^SD(409.61,"B","VALM OPTION DEMO",0)),DIK="^SD(409.61," D ^DIK:DA
PROTQ Q
