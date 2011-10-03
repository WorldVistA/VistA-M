FBXIP117 ;WOIFO/SAB - PATCH INSTALL ROUTINE ;11/2/2010
 ;;3.5;FEE BASIS;**117**;JAN 30, 1995;Build 9
 Q
 ;
PS ; post-install entry point
 ; create KIDS checkpoints with call backs
 N FBX,Y
 F FBX="XREF" D
 . S Y=$$NEWCP^XPDUTL(FBX,FBX_"^FBXIP117")
 . I 'Y D BMES^XPDUTL("ERROR Creating "_FBX_" Checkpoint.")
 Q
 ;
XREF ; Set new x-ref
 N DIK
 D BMES^XPDUTL("    Setting ADS x-ref...")
 ;
 S DIK="^FBAA(161.7,"
 S DIK(1)="5^ADS"
 D ENALL^DIK
 ;
 D MES^XPDUTL("    Done.")
 Q
 ;
 ;FBXIP117
