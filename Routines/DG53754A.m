DG53754A ;ALB/TDM - Patch DG*5.3*754 Pre-Install Utility Routine ; 6/8/09 11:36am
 ;;5.3;Registration;**754**;AUG 13, 1993;Build 46
 ;
 Q
START ;Entry point for field definition cleanup
 N X,DGFIL,DGFLD,MSG
 ;
 D BMES^XPDUTL(">> Starting field definition cleanup...")
 S DGFIL=2 D HEADER F DGFLD=.03,.152,.351 D DELETE(DGFIL,DGFLD)
 D BMES^XPDUTL(">> Field definition cleanup completed")
 Q
 ;
HEADER ;Display file name & #
 S MSG=">> "_$P($G(^DIC(DGFIL,0)),U,1)_" File (#"_DGFIL_")"
 D BMES^XPDUTL(MSG)
 Q
 ;
DELETE(DGFIL,DGFLD) ;The procedure will delete the field definition from the Data Dictionary
 ;    DGFIL  - DD File Number (Required)
 ;    DGFLD  - DD Field Number (Required)
 ;
 Q:($G(DGFIL)=""!$G(DGFLD)="")
 N DIK,DA,DGFLDNM
 ;
 S DIK="^DD("_DGFIL_","
 S DA=DGFLD,DA(1)=DGFIL
 S DGFLDNM=$P($G(^DD(DGFIL,DGFLD,0)),U,1)
 S MSG="   Updating the '"_DGFLDNM_"' field (#"_DGFLD_") definition"
 D MES^XPDUTL(MSG)
 D ^DIK
 Q
