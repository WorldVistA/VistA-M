FBXIP111 ;ALB/RC -FB*3.5*111 POST INSTALL ROUTINE ; 12/21/09 11:28am
 ;;3.5;FEE BASIS;**111**;JAN 30, 1995;Build 17
 Q
EN ;pre-install entry point
 ;create KIDS checkpoints with call backs
 N FBX,Y
 S FBX="PRE" D
 .S Y=$$NEWCP^XPDUTL(FBX,FBX_"^FBXIP111")
 .I 'Y D BMES^XPDUTL("ERROR creating "_FBX_" checkpoint.")
 Q
PRE ;begin pre-install
 D DEL
 Q
DEL ;update entries with the wrong conversion category
 D BMES^XPDUTL("Deleting entries in the FEE BASIS MODIFIER TABLE INDEX (#162.98) file.")
 N FBTBLNO,FBTBLNM,FBTBLIEN
 F FBTBLNO=1:1:359 D
 .S FBTBLNM="2009-"_$S($L(FBTBLNO)=1:"00"_FBTBLNO,$L(FBTBLNO)=2:"0"_FBTBLNO,1:FBTBLNO)
 .N DA,DIK
 .S DIK="^FB(162.98,"
 .S DA=$$FIND1^DIC(162.98,,"MX",FBTBLNM)
 .I 'DA D BMES^XPDUTL("Modifier Table "_FBTBLNO_" not found, please verify this entry in the FEE BASIS MODIFIER TABLE INDEX file (#162.98).") Q
 .D ^DIK K DIK,DA
 Q
 ;FBXIP111
