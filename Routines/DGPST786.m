DGPST786 ;ALB/RC - POST-INSTALL DG*5.3*786 ; 1/22/09 12:33pm
 ;;5.3;Registration;**786**;Aug 13, 1993;Build 21
 Q
EN ;Post-install entry point
 N DGX,Y
 F DGX="PST" D
 .S Y=$$NEWCP^XPDUTL(DGX,DGX_"^DGPST786")
 .I 'Y D BMES^XPDUTL("ERROR creating "_DGX_" checkpoint.")
 Q
PST ;Post Install
 D REINDEX
 D RECOMP
 Q
REINDEX ;Reindex File 38.5.
 N DIK
 S DIK="^DGIN(38.5,",DIK(1)=".01"
 D BMES^XPDUTL("Re-indexing the INCONSISTENT DATA file (#38.5).")
 D ENALL^DIK
 Q
RECOMP ;Recompile Input Templates
 N X,Y,DMAX
 D BMES^XPDUTL("Re-compiling input templates")
 S X="DGX5F"
 S Y=$$FIND1^DIC(.402,"","MX","DG501F")
 S DMAX=$$ROUSIZE^DILF
 I Y<0 D BMES^XPDUTL("Error re-compiling DG501F input template")
 D EN^DIEZ
 S X="DGPMX6"
 S Y=$$FIND1^DIC(.402,"","MX","DGPM SPECIALTY TRANSFER")
 I Y<0 D BMES^XPDUTL("Error re-compiling DGPM SPECIALTY TRANSFER input template")
 S DMAX=$$ROUSIZE^DILF
 D EN^DIEZ
 D BMES^XPDUTL("Input templates have been re-compiled.")
 Q
