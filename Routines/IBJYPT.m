IBJYPT ;ALB/ARH - IBJ V2.0 POST-INITIALIZATION ROUTINE ; 05-AUG-92
 ;;Version 2.0 ; INTEGRATED BILLING ;**39**; 21-MAR-94
 ;
 ; Perform one-time post init items
 ;
 ; Run at every installation
 ;
 D ^IBJONIT ;     install protocols
 D LT ;           install list templates
 D MENU ;         add new options to menus
 D XREF ;         index APDS cross reference
 ;
 W !!,"Installation Complete."
 Q
 ;
LT ; install list templates
 W !!!,?4,"LIST TEMPLATE INSTALLATION",!!
 D ^IBJYL
 W !,"OK, List Template Installation is Complete."
 Q
 ;
XREF ; build 'APDS' cross reference
 ;
 N DA,CT,X,Y,IBH1,IBH2
 ;
 I $D(^DGCR(399,"APDS")) W !!,"*** APDS cross reference already exists on #399, will not be re-built ***",!! Q
 W !!,">>> Building the 'APDS' cross reference on field 399,151.",!,?5,"(I'll write a dot for every 500 entries processed)",!
 S (CT,DA)=0 F  S DA=$O(^DGCR(399,DA)) Q:'DA  S CT=CT+1,X=$P($G(^DGCR(399,DA,0)),U,2),Y=+$G(^DGCR(399,DA,"U")) W:'(CT#50) "." I +X,+Y S ^DGCR(399,"APDS",+X,-Y,DA)=""
 ;
 W !,?5,"Cross Reference build complete.",!!
 Q
 ;
MENU ; add new options to menus
 ;
 S IBMNU="SITE",IBOPTION="IBJ MCCR SITE PARAMETERS",IBMENU="IB SYSTEM DEFINITION MENU" D MSET
 S IBMNU="TPJI",IBOPTION="IBJ THIRD PARTY JOINT INQUIRY",IBMENU="IB BILLING SUPERVISOR MENU" D MSET
 S IBMNU="TPJI",IBOPTION="IBJ THIRD PARTY JOINT INQUIRY",IBMENU="IB BILLING CLERK MENU" D MSET
 S IBMNU="TP",IBOPTION="IBJ THIRD PARTY JOINT INQUIRY",IBMENU="IBT USER MENU (BI)" D MSET
 S IBMNU="TP",IBOPTION="IBJ THIRD PARTY JOINT INQUIRY",IBMENU="IBT USER MENU (IR)" D MSET
 K IBMNU,IBOPTION,IBMENU,IBDAM,IBDAO
 Q
 ;
MSET S IBDAM=$O(^DIC(19,"B",IBMENU,0))
 I 'IBDAM W !!,"*** Unable to find ",IBMENU,", could not add ",IBOPTION," ***" Q
 S IBDAO=$O(^DIC(19,"B",IBOPTION,0))
 I 'IBDAO W !!,"*** Unable to find new option ",IBOPTION,", could not add it to ",IBMENU," ***" Q
 ;
 I $O(^DIC(19,+IBDAM,10,"B",+IBDAO,0)) W !!,"*** ",IBOPTION," already on ",IBMENU," ***" Q
 ;
 W !!,">>> Adding ",IBOPTION," option to ",IBMENU
 I '$D(^DIC(19,+IBDAM,10,0)) S ^DIC(19,+IBDAM,10,0)="^19.01IP^0^0"
 S (Y,DA,D0)=+IBDAM,DIC="^DIC(19,"_+IBDAM_",10,",DIC(0)="L",DA(1)=+IBDAM,DLAYGO=19.01,X=IBOPTION D ^DIC
 S DA=+Y,DIE="^DIC(19,"_DA(1)_",10,",DR="2///"_IBMNU D ^DIE
 K DIC,DIE,DA,DR,D0,DLAYGO,IBDAM,IBDAO,X,Y
 Q
