IB20P627 ;OAK/ELZ - POST INIT FOR PATCH;06/20/2018 ; 31 Jan 2019  3:24 PM
 ;;2.0;INTEGRATED BILLING;**627**;21-MAR-94;Build 21
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;
POST ; post init entry point
 ;
 D MES^XPDUTL("  Starting post-init for IB*2.0*627")
 ;
 D 3542
 D 3503
 ;
 D MES^XPDUTL("  Finished post-init for IB*2.0*627")
 ;
 Q
 ;
3542 ; add entry to exemption file 354.2 if not there
 I $O(^IBE(354.2,"B","MEDAL OF HONOR",0)) D  Q
 . D MES^XPDUTL("    - MEDAL OF HONOR already exists, nothing to add to 354.2.")
 ;
 N DO,X,Y,DIC
 ;
 S X="MEDAL OF HONOR",DIC="^IBE(354.2,",DIC(0)=""
 S DIC("DR")=".02///Patient awarded Medal of Honor;.03///1;.04///1;.05///50"
 D FILE^DICN
 ;
 D MES^XPDUTL($S(Y>1:"    - MEDAL OF HONOR Exemption Reason (#354.2) added.",1:"*** ERROR: COULD NOT CREATE NEW MOH ENTRY IN 354.2 ***"))
 ;
 Q
 ;
3503 ; add entry to Charge Removal Reason file if not there
 ;
 N IBX,DO,DIC,X,Y
 ;
 D MES^XPDUTL("    - Adding entry to Charge Removal Reason (#350.3) file.")
 S IBX="MEDAL OF HONOR^MOH" D
 . S DIC="^IBE(350.3,",DIC(0)="",X=$P(IBX,"^")
 . S DIC("DR")=".02///^S X=$P(IBX,U,2);.03///3"
 . I $O(^IBE(350.3,"B",X,0)) D MES^XPDUTL("      - "_X_" already exists.") Q
 . D FILE^DICN
 . D MES^XPDUTL($S(Y>1:"      - "_$P(IBX,"^")_" entry added.",1:"*** ERROR: COULD NOT CREATE NEW "_$P(IBX,"^",2)_" ENTRY IN 350.3 ***"))
 ;
 D MES^XPDUTL("    - Done adding entry in Charge Removal Reason (#350.3) file.")
 Q
 ;
