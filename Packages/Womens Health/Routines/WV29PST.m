WV29PST ;SLC/WAS-WV*1*29 POST INSTALLATION ROUTINE; Aug 17,2022@14:28
 ;;1.0;WOMEN'S HEALTH;**29**;Sep 30, 1998;Build 20
 ;
 ; Reference to ^XPDUTL in ICR #10141
 ; Reference to ^DIE in ICR #10013
 ; Reference to ^DIE in ICR #10018
 ;
ENV ; Environment check point.
 ;
 S XPDABORT=""
 D PROGCHK(.XPDABORT) ;checks programmer variables
 I XPDABORT="" K XPDABORT
 Q
 ;
PRE ; Main entry point for Pre-init items.
 ;
 D BMES^XPDUTL("Pre-installation begin...")
 ;
 ; Delete invalid pointers in .07 in file #790.404
 N TSTFLD,DR,DIE,DA
 S DA="" F  S DA=$O(^WV(790.404,DA)) Q:DA=""  D
 .S TSTFLD=$P($G(^WV(790.404,DA,0)),"^",7)
 .I (TSTFLD'="") D
 ..I '$D(^WV(790.51,TSTFLD)) D
 ...S DIE="^WV(790.404,",DR=".07///@" D ^DIE
 ;
 D BMES^XPDUTL("Pre-installation complete...")
 ;
 Q
 ;
POST ; Main entry point for Post-init items.
 ;
 D BMES^XPDUTL("Post-installation begin...")
 ;
 ; Update the BREAST NEED MRI value to "BREAST MRI" in file #790.404
 N DR,DIE
 N DA S DA=$O(^WV(790.404,"U","BREAST NEED MRI","")) Q:'DA
 S DIE="^WV(790.404,",DR=".07///Breast MRI" D ^DIE
 ;
 D BMES^XPDUTL("Post-installation complete...")
 ;
 Q
 ;
PROGCHK(XPDABORT) ; Checks for necessary programmer variables
 ;
 I '$G(DUZ)!($G(DUZ(0))'="@")!('$G(DT))!($G(U)'="^") D
 .D MES^XPDUTL("*****")
 .D MES^XPDUTL("Your programming variables are not set up properly.")
 .D MES^XPDUTL("Installation aborted.")
 .D MES^XPDUTL("*****")
 .S XPDABORT=2
 Q
