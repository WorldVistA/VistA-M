IB20IN ;ALB/CPM - IB V2.0 INITIALIZATION ROUTINE ; 01-SEP-93
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;
 ; Perform one-time installation items
 I +$G(^DD(350,0,"VR"))<2 D
 .D SC7H ;   delete IB SCREEN7H input template
 .D AVC ;    delete 'AVC' x-ref
 .D AVP ;    delete 'AVP' x-ref
 .D OBSLT ;  delete obsolete list template
 .D BCP ;    delete obsolete print template
 .D OBSPRO ; delete obsolete protocols
 .D EDOPT ;  change name of option IB UB-82 MENU
 ;
 ; Run at every installation
 D DEL ;     delete file #350.8 and data
 D CHGPRO ;  delete IBACM1 MENU protocol
 D DD ;      delete field decriptions and cross references
 ;
 Q
 ;
 ;
SC7H W !!,">>> Removing IB SCREEN7H input template..."
 S IBX=0 F  S IBX=$O(^DIE("B","IB SCREEN7H",IBX)) Q:IBX<1  S DA=IBX,DIE="^DIE(",DR=".01////@" D ^DIE
 K IBX
 Q
 ;
AVC W !!,">>> Removing 'AVC' cross-reference on REVENUE CODE field... "
 S DA=0
 F  S DA=$O(^DD(399.042,.01,1,DA)) Q:DA<1  I $G(^(DA,0))="399.042^AVC^MUMPS" S DIK="^DD(399.042,.01,1,",DA(2)=399.042,DA(1)=.01 W "." D ^DIK W "." K DIK
 K DA
 Q
 ;
AVP W !!,">>> Removing 'AVP' cross-reference on PROCEDURES field..."
 S DA=0
 F  S DA=$O(^DD(399.0304,.01,1,DA)) Q:DA<1  I $G(^(DA,0))="399.0304^AVP^MUMPS" S DIK="^DD(399.0304,.01,1,",DA(2)=399.0304,DA(1)=.01 W "." D ^DIK W "." K DIK
 K DA
 Q
 ;
DEL W !!,">>> Deleting IB ERROR file (350.8) with data."
 W !,"    It will be restored."
 S DIU(0)="D",DIU="^IBE(350.8," D EN^DIU2 K DIU Q
 Q
 ;
CHGPRO ; Delete the 'IBACM1 MENU' protocol (to be added later by IBONIT)
 S DIC="^ORD(101,",DIC(0)="FN",X="IBACM1 MENU" D ^DIC K DIC S DA=+Y
 I DA>0 W !!,">>> Deleting protocol 'IBACM1 MENU'...",!?4,"It will be restored." S DIK="^ORD(101," D ^DIK
 K DA,DIK,X,Y
 Q
 ;
OBSLT ; Delete the obsolete List Template 'IB BILLABLE EVENT'
 S DA=$O(^SD(409.61,"B","IB BILLABLE EVENT",0))
 I DA W !!,">>> Deleting Obsolete List Template 'IB BILLABLE EVENT'..." S DIK="^SD(409.61," D ^DIK
 K DA,DIK
 Q
 ;
BCP ; Delete obsolete print template 'IB BILLING CYCLE PRINT'
 S DA=$O(^DIPT("B","IB BILLING CYCLE PRINT",0))
 I DA W !!,">>> Deleting Obsolete Print Template 'IB BILLING CYCLE PRINT'..." S DIK="^DIPT(" D ^DIK
 K DA,DIK
 Q
 ;
OBSPRO ; Delete obsolete protocols.
 W !!,">>> Deleting obsolete protocols..."
 F IBI=1:1 S IBN=$P($T(OBSP+IBI),";;",2) Q:IBN=""  D
 .W !?5,"deleting protocol '",IBN,"'... "
 .S DIC="^ORD(101,",DIC(0)="FN",X=IBN D ^DIC K DIC S DA=+Y
 .I DA<0 W "not found." Q
 .S DIK="^ORD(101," D ^DIK W "done."
 K DA,DIK,IBI,IBN,X,Y
 Q
 ;
EDOPT ; Change name of option IB UB-82 MENU to IB THIRD PARTY BILLING MENU
 S DA=$O(^DIC(19,"B","IB UB-82 MENU",0))
 I DA W !!,">>> Changing the option 'IB UB-82 MENU' to 'IB THIRD PARTY BILLING MENU'..." S DIE="^DIC(19,",DR=".01///IB THIRD PARTY BILLING MENU" D ^DIE
 K DIE,DA,DR
 Q
 ;
DD ; Delete field descriptions and cross references
 K ^DD(399,.01,21),^DD(399,2,21),^DD(399,205,21),^DD(399,213,23),^DD(399,303,21)
 ;
 S IB=0 F  S IB=$O(^DD(399.1,.11,1,IB)) Q:IB<1  S DIK="^DD(399.1,.11,1,",DA(2)=399.1,DA(1)=.11,DA=IB D ^DIK K DIK
 S IB=0 F  S IB=$O(^DD(399.1,.13,1,IB)) Q:IB<1  S DIK="^DD(399.1,.13,1,",DA(2)=399.1,DA(1)=.13,DA=IB D ^DIK K DIK
 S IB=0 F  S IB=$O(^DD(399.2,.01,1,IB)) Q:IB<1  S DIK="^DD(399.2,.01,1,",DA(2)=399.2,DA(1)=.01,DA=IB D ^DIK K DIK
 ;
 S IB=0 F  S IB=$O(^DD(399.042,.02,1,IB)) Q:IB<1  S DIK="^DD(399.042,.02,1,",DA(2)=399.042,DA(1)=.02,DA=IB D ^DIK K DIK
 S IB=0 F  S IB=$O(^DD(399.042,.03,1,IB)) Q:IB<1  S DIK="^DD(399.042,.03,1,",DA(2)=399.042,DA(1)=.03,DA=IB D ^DIK K DIK
 ;
 K ^DGCR(399.1,"OCC"),^DGCR(399.1,"DIS"),^DGCR(399.2,"D")
 ;
 S DIK="^DD(399,101,1,",DA(2)=399,DA(1)=101,DA=3 D ^DIK
 ;
 K IB,DA,DIK
 Q
 ;
OBSP ; Obsolete protocols to be deleted
 ;;IBACM ENTRY SELECT
 ;;IBACM MENU
 ;;IBACM BLANK 1
 ;;IBACM BLANK 10
 ;;IBACM BLANK 11
 ;;IBACM BLANK 12
 ;;IBACM BLANK 2
 ;;IBACM BLANK 3
 ;;IBACM BLANK 4
 ;;IBACM BLANK 5
 ;;IBACM BLANK 6
 ;;IBACM BLANK 7
 ;;IBACM BLANK 8
 ;;IBACM BLANK 9
 ;
