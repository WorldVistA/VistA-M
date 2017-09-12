PRYKPST ;ALB/CMR - POST INIT TO POPULATE PKG FILE  ;7/10/97
 ;;4.5;Accounts Receivable;**84**;Mar 20, 1995
UPDAT ; -- update package file for install of AR patch PRCA*4.5*84
 N PKG,VER,PATCH
 ; -- find ien of AR in PACKAGE file
 S PKG=$O(^DIC(9.4,"B","ACCOUNTS RECEIVABLE",0)) Q:'PKG
 S VER="4.5" ;version
 S PATCH="84^"_DT_"^"_DUZ ;patch #^today^installed by
 ;
 D BMES^XPDUTL(" >>Updating Patch Application History for AR with PRCA*4.5*84")
 S PATCH=$$PKGPAT^XPDIP(PKG,VER,.PATCH)
 Q
