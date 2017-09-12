IBY135PR ;ALB/TMK - IB*2*135 PRE-INSTALL ;06-OCT-03
 ;;2.0;INTEGRATED BILLING;**135**;21-MAR-94
 ;
 N DA,DIK,X,Y
 D BMES^XPDUTL("Pre-Installation Updates")
 D BMES^XPDUTL("Delete PROCEDURE field in file #361.1, subfield 15 that changes from pointer to free text")
 I $D(^DD(361.115,.04,0)) S DA(1)=361.115,DA=.04,DIK="^DD(361.115," D ^DIK
 ;
 D BMES^XPDUTL("Pre-install complete")
 Q
 ;
