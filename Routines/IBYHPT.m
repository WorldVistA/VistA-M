IBYHPT ;ALB/TMP - PATCH IB*2*43 POST-INITIALIZATION ; 21-AUG-95
 ;;Version 2.0 ; INTEGRATED BILLING ;**43**; 21-MAR-94
 ;
EN D DEL  ;Delete items moved in IBCNSC INSURANCE CO and IBCNSP POLICY MENU
 D ^IBYHONIT   ;Install protocols
 D BLD         ;update ^XUTL("XQORM" for menu protocols
 D TEM         ;Install list templates
 D RIDERS      ;Add records to file 355.6
 D CATUPD      ;Update 355.31 with RIDER file entries just added
 Q
 ;
DEL ;Delete items moved from item multiples of
 ;  IBCNSC INSURANCE COMPANY and IBCNSP POLICY MENU
 S DIC(0)="F",DIC="^ORD(101,",X="IBCNSC INSURANCE CO"
 D ^DIC K DIC
 I Y>0 S IBMENU=+Y D
 .S DIC(0)="F",DIC="^ORD(101,"_IBMENU_",10,"
 .S X="IBCNS QUIT" D ^DIC I Y>0 S DA(1)=IBMENU,DA=+Y D DEL1(.DA,X,IBMENU)
 .K DIC,DA
 S DIC(0)="F",DIC="^ORD(101,",X="IBCNSP POLICY MENU"
 D ^DIC K DIC
 I Y>0 S IBMENU=+Y D
 .S DIC(0)="F",DIC="^ORD(101,"_IBMENU_",10,"
 .F X="IBCNSP ADD COMMENT","IBCNSP EDIT ALL","IBCNSJ CHANGE PLAN" D ^DIC I Y>0 S DA=+Y,DA(1)=IBMENU D DEL1(.DA,X,IBMENU)
 .K DIC,DA
 K DIK,DA,IBMENU
 Q
 ;
DEL1(DA,X,IBMENU) ; delete protocol menu item
 W !!,">>> Deleting protocol ",X," as an item of ",$P($G(^ORD(101,IBMENU,0)),U)," ...",!,"      (It will be re-added in a moment)"
 S DIK="^ORD(101,"_IBMENU_",10," D ^DIK
 K DIK
 Q
 ;
BLD ; Update ^XUTL("XQORM" for menu protocols
 W !
 F IBX="IBCNSC PLAN LIST","IBCNSC PLAN DETAIL","IBCNSC INSURANCE CO","IBCNSP POLICY MENU" D
 .S DIC="^ORD(101,",DIC(0)="F",X=IBX D ^DIC K DIC
 .Q:Y<0
 .W !,">>> Rebuilding ^XUTL for protocol '",IBX,"' ..."
 .S XQORM=+Y_";ORD(101," D XREF^XQORM
 K ORULT,XQORM,X,Y,IBX
 Q
 ;
RIDERS ; Add records to INSURANCE RIDERS file for new limitation categories
 W !,">>> Adding records to INSURANCE RIDERS file for new limitation categories..."
 F X="INPATIENT COVERAGE","OUTPATIENT COVERAGE","PRESCRIPTION COVERAGE" I '$D(^IBE(355.6,"B",X)) S DIC(0)="L",DIC="^IBE(355.6," D ^DIC
 W "Done."
 K DIC
 Q
 ;
CATUPD ; Update PLAN LIMITATION CATEGORY file insurance rider info
 W !,">>> Updating PLAN LIMITATION CATEGORY file with insurance rider info..."
 N DA,CAT
 S DA=0 F  S DA=$O(^IBE(355.31,DA)) Q:'DA  S CAT=$G(^(DA,0)) I $P(CAT,U,3)="" S DIE="^IBE(355.31,",DR=".03///^S X="""_$S($P(CAT,U)'="PHARMACY":$P(CAT,U),1:"PRESCRIPTION")_" COVERAGE""" D ^DIE
 W "Done."
 Q
 ;
TEM ; Install list templates
 W !,">>> Installing List Templates..."
 W !,"'IBCNS INS CO PLAN DETAIL' List Template ..."
 S DA=$O(^SD(409.61,"B","IBCNS INS CO PLAN DETAIL",0)),DIK="^SD(409.61," D ^DIK:DA
 K DO,DD S DIC="^SD(409.61,",DIC(0)="L",X="IBCNS INS CO PLAN DETAIL" D FILE^DICN S VALM=+Y
 I VALM>0 D
 .S ^SD(409.61,VALM,0)="IBCNS INS CO PLAN DETAIL^1^^80^5^17^1^1^Plan^IBCNSC PLAN DETAIL^View/Edit Plan"
 .S ^SD(409.61,VALM,1)="^VALM HIDDEN ACTIONS"
 .S ^SD(409.61,VALM,"ARRAY")=" ^TMP(""IBCNSCP"",$J)"
 .S ^SD(409.61,VALM,"FNL")="D EXIT^IBCNSC41"
 .S ^SD(409.61,VALM,"HDR")="D HDR^IBCNSC41"
 .S ^SD(409.61,VALM,"HLP")="D HELP^IBCNSC41"
 .S ^SD(409.61,VALM,"INIT")="D INIT^IBCNSC4"
 .S DA=VALM,DIK="^SD(409.61," D IX1^DIK K DA,DIK
 .W "Filed."
 ;
 W !,"'IBCNS PLAN LIST' List Template ..."
 S DA=$O(^SD(409.61,"B","IBCNS PLAN LIST",0)),DIK="^SD(409.61," D ^DIK:DA
 K DO,DD S DIC(0)="^SD(409.61,",X="IBCNS PLAN LIST" D FILE^DICN S VALM=+Y
 I VALM>0 D
 .S ^SD(409.61,VALM,0)="IBCNS PLAN LIST^1^^80^6^19^1^1^Plan^IBCNSC PLAN LIST^Insurance Plan List^1^^1"
 .S ^SD(409.61,VALM,1)="^VALM HIDDEN ACTIONS"
 .S ^SD(409.61,VALM,"ARRAY")=" ^TMP(""IBCNSJ"",$J)"
 .S ^SD(409.61,VALM,"COL",0)="^409.621^8^8"
 .S ^SD(409.61,VALM,"COL",1,0)="NUMBER^1^4^"
 .S ^SD(409.61,VALM,"COL",2,0)="GNAME^5^18^Group Name"
 .S ^SD(409.61,VALM,"COL",3,0)="GNUM^25^17^Group Number"
 .S ^SD(409.61,VALM,"COL",4,0)="TYPE^44^13^Type of Plan"
 .S ^SD(409.61,VALM,"COL",5,0)="UR^59^3^UR?"
 .S ^SD(409.61,VALM,"COL",6,0)="PREC^64^3^Ct?"
 .S ^SD(409.61,VALM,"COL",7,0)="PREEX^70^4^ExC?"
 .S ^SD(409.61,VALM,"COL",8,0)="BENAS^76^3^As?"
 .S ^SD(409.61,VALM,"FNL")="D FNL^IBCNSU2"
 .S ^SD(409.61,VALM,"HDR")="D HDR^IBCNSC4"
 .S ^SD(409.61,VALM,"HLP")="S X=""?"" D DISP^XQORM1 W !!"
 .S ^SD(409.61,VALM,"INIT")="D INIT^IBCNSU2"
 .S DA=VALM,DIK="^SD(409.61," D IX1^DIK K DA,DIK
 .W "Filed."
 ;
 W "Done."
 ;
 K DIC,DIK,DIE,VALM,X,DA,DR
 Q
 ;
