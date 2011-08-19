FBXIP114 ;ALB/RC-PATCH INSTALL ROUTINE ; 8/31/10 2:44pm
 ;;3.5;FEE BASIS;**114**;JAN 30, 1995;Build 7
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
PS ; post-install entry point
 ; create KIDS checkpoints with call backs
 N FBX
 Q
 F FBX="EN" D
 .S Y=$$NEWCP^XPDUTL(FBX,FBX_"^FBXIP114")
 .I 'Y D BMES^XPDUTL("ERROR Creating "_FBX_" Checkpoint.")
 Q
 ;
EN ; Begin Post-Install
 ;re-index "AF" cross reference.
 Q
 N DIK
 S DIK="^FBAA(161.7,",DIK(1)="13^AF"
 D ENALL2^DIK ;Kill existing "AF" cross-reference.
 D ENALL^DIK ;Re-create "AF" cross-reference.  
 Q
 ;FBXIP114
