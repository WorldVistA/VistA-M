IBY137PR ;ALB/TMP - IB*2*137 PRE-INSTALL ;23-AUG-00
 ;;2.0;INTEGRATED BILLING;**137**;21-MAR-94
 ;
 N DIE,DR,DIK,DA,IBX,DA,IBXREF,Z
 D BMES^XPDUTL("Pre-Installation Updates")
 ;I $O(^IBA(364.3,0)) G OVER ; Already installed once - skip some parts
 D BMES^XPDUTL("Delete xrefs and output formatter data that will be updated during install")
 S DA(1)=399.0222,DA=.02,DIK="^DD(399.0222," D ^DIK
 ;
 S DA=265,DR="3///@",DIE="^IBA(364.7," D ^DIE
 S DIK="^IBA(364.7,",DA=505 D ^DIK
 D DELIX^DDMOD(399,9,2)
 S IBX="   >> ^DD(399,9) cross reference #2 deleted." D MES^XPDUTL(IBX)
 D DELIX^DDMOD(399,151,3)
 S IBX="   >> ^DD(399,151) cross reference #3 deleted." D MES^XPDUTL(IBX)
 D DELIX^DDMOD(399,201,1)
 S IBX="   >> ^DD(399,201) cross reference #1 deleted." D MES^XPDUTL(IBX)
 D DELIX^DDMOD(399,210,1)
 S IBX="   >> ^DD(399,210) cross reference #1 deleted." D MES^XPDUTL(IBX)
 D DELIX^DDMOD(399.042,.04,1)
 S IBX="   >> ^DD(399.042,.04) cross reference #1 deleted." D MES^XPDUTL(IBX)
 K ^DD(399,151,21),^DD(399,152,21)
 I $G(^IBA(364.6,745,0))'="",$P(^(0),U,9)'=31 S $P(^(0),U,9)=31
 ;
 S IBXREF=0
 F  S IBXREF=$O(^DD(399,6,1,IBXREF)) Q:'IBXREF  D DELIX^DDMOD(399,6,IBXREF)
 D DELIX^DDMOD(399,3,3) ; Deletes trigger of field 6
 S IBX="   >> All ^DD(399,6) cross references deleted." D MES^XPDUTL(IBX)
 ;
OVER ; Start here for a reinstall
 D BMES^XPDUTL("Pre-install complete")
 Q
 ;
