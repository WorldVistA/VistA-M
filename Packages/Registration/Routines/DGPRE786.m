DGPRE786 ;ALB/RC - PRE-INSTALL DG*5.3*786 ; 8/14/08 4:51pm
 ;;5.3;Registration;**786**;Aug 13, 1993;Build 21
 Q
EN ;Pre-install entry point
 N DGX,Y
 F DGX="DEL" D
 .S Y=$$NEWCP^XPDUTL(DGX,DGX_"^DGPRE786")
 .I 'Y D BMES^XPDUTL("ERROR creating "_DGX_" checkpoint.")
 Q
DEL ;Delete .03 field in file 46.  
 N DA,DIK
 S DIK="^DD(46,",DA=.03,DA(1)=46
 D ^DIK
 Q
