IBYAPT ;ALB/CPM - PATCH IB*2*28 POST-INITIALIZATION ; 25-JAN-95
 ;;Version 2.0 ; INTEGRATED BILLING ;**28**; 21-MAR-94
 ;
EN ; Patch IB*2*28 post initialization.
 ;
 D DEL ;          delete IBCNS QUIT as an item of IBCNSC INSURANCE CO
 D ^IBYAONIT ;    install protocols
 D BLD ;          update ^XUTL("XQORM" for menu protocols
 D TEM ;          install list templates
 D ADD ;          add new option to the Ins Mgmt menu
 D REF ;          build x-refs
 D BKG^IBYAPT1 ;  queue off insurance clean-up
 Q
 ;
 ;
DEL ; Delete IBCNS QUIT from the item multiple of IBCNSC INSURANCE CO.
 S DIC(0)="F",DIC="^ORD(101,",X="IBCNSC INSURANCE CO"
 D ^DIC K DIC Q:Y<0  S IBMENU=+Y
 S DIC(0)="F",DIC="^ORD(101,"_IBMENU_",10,",DA(1)=IBMENU,X="IBCNS QUIT"
 D ^DIC K DIC Q:Y<0  S IBITEM=+Y
 W !!,">>> Deleting protocol IBCNS QUIT as an item of IBCNSC INSURANCE CO..."
 W !,"    (It will be added back in momentarily)"
 S DA(1)=IBMENU,DA=IBITEM,DIK="^ORD(101,"_IBMENU_",10," D ^DIK
 K DA,DIK,IBITEM,IBMENU
 Q
 ;
BLD ; Update ^XUTL("XQORM" for menu protocols.
 W !
 F IBX="IBCNSJ PLAN LOOKUP","IBCNSP POLICY MENU","IBCNSC INSURANCE CO" D
 .S DIC="^ORD(101,",DIC(0)="F",X=IBX D ^DIC K DIC S IBY=+Y
 .I IBY>0 D
 ..W !,">>> Rebuilding ^XUTL(""XQORM"" for protocol '",IBX,"' ..."
 ..S XQORM=IBY_";ORD(101," D XREF^XQORM
 K IBX,IBY,ORULT,X,XQORM,Y
 Q
 ;
TEM ; Install List Templates
 W !!,">>> Installing List Templates..."
 W !,"'IBCNS EXPANDED POLICY' List Template..."
 S DA=$O(^SD(409.61,"B","IBCNS EXPANDED POLICY",0)),DIK="^SD(409.61," D ^DIK:DA
 K DO,DD S DIC(0)="L",DIC="^SD(409.61,",X="IBCNS EXPANDED POLICY" D FILE^DICN S VALM=+Y
 I VALM>0 D
 .S ^SD(409.61,VALM,0)="IBCNS EXPANDED POLICY^1^^80^5^17^1^1^Policy^IBCNSP POLICY MENU^Patient Policy Information^1"
 .S ^SD(409.61,VALM,1)="^VALM HIDDEN ACTIONS"
 .S ^SD(409.61,VALM,"ARRAY")=" ^TMP(""IBCNSVP"",$J)"
 .S ^SD(409.61,VALM,"COL",0)="^409.621^^0"
 .S ^SD(409.61,VALM,"FNL")="D EXIT^IBCNSP"
 .S ^SD(409.61,VALM,"HDR")="D HDR^IBCNSP"
 .S ^SD(409.61,VALM,"HLP")="D HELP^IBCNSP"
 .S ^SD(409.61,VALM,"INIT")="D INIT^IBCNSP"
 .S DA=VALM,DIK="^SD(409.61," D IX1^DIK K DA,DIK
 .W "Filed."
 ;
 W !,"'IBCNS PLAN LOOKUP' List Template..."
 S DA=$O(^SD(409.61,"B","IBCNS PLAN LOOKUP",0)),DIK="^SD(409.61," D ^DIK:DA
 K DO,DD S DIC(0)="L",DIC="^SD(409.61,",X="IBCNS PLAN LOOKUP" D FILE^DICN S VALM=+Y
 I VALM>0 D
 .S ^SD(409.61,VALM,0)="IBCNS PLAN LOOKUP^1^^80^7^19^1^1^Plan^IBCNSJ PLAN LOOKUP^Insurance Plan Lookup^1^^1"
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
 .S ^SD(409.61,VALM,"HDR")="D HDR^IBCNSU2"
 .S ^SD(409.61,VALM,"HLP")="S X=""?"" D DISP^XQORM1 W !!"
 .S ^SD(409.61,VALM,"INIT")="D INIT^IBCNSU2"
 .S DA=VALM,DIK="^SD(409.61," D IX1^DIK K DA,DIK
 .W "Filed."
 ;
 K DIC,DIK,VALM,X,DA Q
 ;
ADD ; Add the option List Plans by Insurance Company to the Ins Mgmt menu
 S (IBUY,Y)=$O(^DIC(19,"B","IBCN INSURANCE MGMT MENU",0)) Q:Y=""
 S X=$O(^DIC(19,"B","IBCN LIST PLANS BY INS CO",0)) Q:X=""
 W !!,">>> Adding IBCN LIST PLANS BY INS CO option to the IBCN INSURANCE MGMT MENU..."
 I '$D(^DIC(19,+Y,10,0)) S ^DIC(19,+Y,10,0)="^19.01IP^0^0"
 S (DA,D0)=+Y,DIC="^DIC(19,"_+Y_",10,",DIC(0)="L",DA(1)=+Y,DLAYGO=19.01,X="IBCN LIST PLANS BY INS CO" D ^DIC
 S DA=+Y,DIE="^DIC(19,"_DA(1)_",10,",DR="2///^S X=""LP""" D ^DIE
 K DIC,DIE,DA,IBUY,DR,X,Y
 Q
 ;
REF ; Build the ACCP, AGNA, and AGNU cross-references.
 W !!,">>> Building the 'ACCP' cross-reference for file #355.3 ..."
 W !,"    (I'll write a dot for every 100 entries processed)",!
 S (IBCT,IBP)=0
 F IB=1:1 S IBP=$O(^IBA(355.3,IBP)) Q:'IBP  S IBPD=$G(^(IBP,0)) I IBPD D
 .W:'(IB#100) "."
 .S IBX=$P(IBPD,"^",3) I IBX]"" D
 ..S ^IBA(355.3,"AGNA",+IBPD,IBX,IBP)=""
 ..S Y=$$COMP^IBCNSJ(IBX) I Y]"" S ^IBA(355.3,"ACCP",+IBPD,Y,IBP)=""
 .S IBX=$P(IBPD,"^",4) I IBX]"" D
 ..S ^IBA(355.3,"AGNU",+IBPD,IBX,IBP)=""
 ..S Y=$$COMP^IBCNSJ(IBX) I Y]"" S ^IBA(355.3,"ACCP",+IBPD,Y,IBP)=""
 .I $P(IBPD,"^",2),$P(IBPD,"^",10) D
 ..S DIE="^IBA(355.3,",DA=IBP,DR=".1////@;1.05///NOW;1.06////"_DUZ
 ..D ^DIE K DIE,DA,DR S IBCT=IBCT+1
 I IBCT W !?4,"Note that ",IBCT," group plan",$S(IBCT>1:"s",1:"")," had the individual policy pointer removed."
 K IBCT,IBP,IB,IBPD,IBX,Y
 Q
