SD53P205 ;bp/cmf - Patch SD*5.3*205 utility routine ; 10/23/99 
 ;;5.3;Scheduling;**205**;AUG 13, 1993
 ;
ENV ;environment check point.
 ;
 S XPDABORT=""
 D PROGCHK(.XPDABORT) ;checks programmer variables
 I XPDABORT="" K XPDABORT
 Q
 ;
PRE ;Pre-init
 D DFILE ;Delete entries in file #404.45 and #404.46
 Q
 ;
DFILE ;
 ;Delete #404.45 entries
 I $D(^SCTM(404.45)) D
 . N DIK,DA S DIK="^SCTM(404.45,",DA=0
 . D BMES^XPDUTL("Deleting file #404.45 entries...")
 . F  S DA=$O(^SCTM(404.45,DA)) Q:'DA  D ^DIK
 . Q
 ;
 ;Delete #404.46 entries
 I $D(^SCTM(404.46)) D
 . N DIK,DA S DIK="^SCTM(404.46,",DA=0
 . D BMES^XPDUTL("Deleting file #404.46 entries...")
 . F  S DA=$O(^SCTM(404.46,DA)) Q:'DA  D ^DIK
 . Q
 Q
 ;
 ;
PROGCHK(XPDABORT) ;checks for necessary programmer variables
 ;
 I '$G(DUZ)!($G(DUZ(0))'="@")!('$G(DT))!($G(U)'="^") DO
 .D BMES^XPDUTL("*****")
 .D MES^XPDUTL("Your programming variables are not set up properly.")
 .D MES^XPDUTL("Installation aborted.")
 .D MES^XPDUTL("*****")
 .S XPDABORT=2
 .Q
 Q
 ;
