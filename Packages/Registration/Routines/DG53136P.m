DG53136P ;ALB/MM - POST INSTALL DG*5.3*136 ; 8/27/97
 ;;5.3;Registration;**136**;Aug 13, 1993
 ;
 ;Delete PROVIDER SSN field (79.101) from PTF file (#45)
 ;Field references PROVIDER file (#6) not New Person (#200)
 ;
EN ;
 I $D(^DD(45,79.101,0)) D
 .D BMES^XPDUTL("  Deleting Provider SSN (#79.101) field from PTF File (#45).")
 .N DA,DIK
 .S DIK="^DD(45,"
 .S DA=79.101 ;Provider SSN field
 .S DA(1)=45 ;PTF File
 .D ^DIK
 Q
