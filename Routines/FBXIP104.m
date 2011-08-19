FBXIP104 ;WCIOFO/TCK-PATCH INSTALL ROUTINE ;10/29/2007
 ;;3.5;FEE BASIS;**104**;JAN 30, 1995;Build 22
 Q
 ;
PRE ;Delete Adjustment Reason Code file before overwriting with updated file.
 N IEN,U
 S IEN=0,U="^"
 F  S IEN=$O(^FB(161.91,IEN)) Q:'IEN  D
 .S DIK="^FB(161.91,",DA=IEN D ^DIK K DA
 K DIK,DA
 Q
 ;
PS ; post-install entry point
 ; create KIDS checkpoints with call backs
 N FBX
 F FBX="CF" D
 . S Y=$$NEWCP^XPDUTL(FBX,FBX_"^FBXIP104")
 . I 'Y D BMES^XPDUTL("ERROR Creating "_FBX_" Checkpoint.")
 Q
 ;
CF ; Change the RVU values for procedure 14301 and 14302.
 D BMES^XPDUTL("  Changing FEE BASIS CPT RVU values for procedures 44180 and 44186.")
 N CPT,DD,DO,DA,DIE,DR,X,Y
 F CPT=44180,44186 D
 . S DA(1)=$O(^FB(162.97,"B",CPT,0))
 . Q:DA(1)'>0
 . S DA=$O(^FB(162.97,DA(1),"CY","B",2007,0))
 . Q:DA'>0
 . S DIE="^FB(162.97,"_DA(1)_",""CY"","
 . I CPT=44180 D
 . . S DR=".03////15.19;.04////6.09;.05////6.09;.06////1.86"
 . I CPT=44186 D
 . . S DR=".03////10.3;.04////4.7;.05////4.7;.06////1.27"
 . D ^DIE K DIE,DA(1),CPT
 Q
 ;
 ;FBXIP104
