ESP118PT ;ALB/REV - ES Post-init Driver; 4/28/97
 ;;1.0;POLICE & SECURITY;**18**;MAR 31, 1994
 ;
EN ; -- main entry point
 D UPDAT ; update patch file for ES*1*14
 ;
 Q
 ;
UPDAT ;  update package file for install of POLICE & SECURITY patch ES*1*14
 N PKG,VER,PATCH
 ; find ien of ES in PACKAGE file
 S PKG=$O(^DIC(9.4,"B","POLICE & SECURITY",0)) Q:'PKG
 S VER=1.0 ; version 
 S PATCH="14 SEQ#14^"_DT_"^"_DUZ ; patch #^today^installed by
 ;
 D BMES^XPDUTL(" >>Updating Patch Application History for POLICE & SECURITY with ES*1*14")
 S PATCH=$$PKGPAT^XPDIP(PKG,VER,.PATCH)
 Q
