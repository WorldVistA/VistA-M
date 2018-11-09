IB20P614 ;SLC/RED-PATCH 614 POST INSTALL ; 8-MAR-18
 ;;2.0;INTEGRATED BILLING;**614**;21-MAR-18;Build 25
 ;
 ;Post install for IB*2.0*614
 ; IA:  FILE^DICN  - #10009 
 Q
POST ;
 D REASON
 Q
REASON ; entry added to file #350.3  - IB CHARGE REMOVE REASON
 ;
 N DIC,X,IBX
 D MES^XPDUTL(" >>- Adding entry 'HRFS FLAGGED' to IB Charge Removal Reason (#350.3) file.")
 S IBX="HRFS FLAGGED^HRFS" D
 . S DIC="^IBE(350.3,",DIC(0)="",X=$P(IBX,"^")
 . S DIC("DR")=".02///^S X=$P(IBX,U,2);.03///3"
 . I $O(^IBE(350.3,"B",X,0)) D MES^XPDUTL("      - "_X_" already exists.") Q
 . D FILE^DICN
 Q
MESSAGE(IBMSG) ;
 D BMES^XPDUTL(IBMSG)
 Q
