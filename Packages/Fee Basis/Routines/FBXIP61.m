FBXIP61 ;WCIOFO/SAB-PATCH INSTALL ROUTINE ;11/25/2003
 ;;3.5;FEE BASIS;**61**;JAN 30, 1995
 Q
 ; THIS INIT ROUTINE IS ONLY NEEDED FOR SITES THAT HAVE INSTALLED
 ; TEST v1 of PATCH FB*3.5*61.  IT WILL BE INCLUDED WITH TEST v2.
 ; IT WILL NOT BE INCLUDED IN LATER VERSIONS OF THE PATCH
 ;
PR ; pre-install entry point
 ; create KIDS checkpoints with call backs
 N FBX,Y
 F FBX="KDD" D
 . S Y=$$NEWCP^XPDUTL(FBX,FBX_"^FBXIP61")
 . I 'Y D BMES^XPDUTL("ERROR Creating "_FBX_" Checkpoint.")
 Q
 ;
KDD ; Kill DD (but leave any data) for File 163.5
 N DIU
 D BMES^XPDUTL("  Removing current DD definition for file 163.5...")
 ;
 S DIU="^FBHL(163.5,"
 S DIU(0)=""
 D EN^DIU2
 ;
 D MES^XPDUTL("  Done.")
 Q
 ;
 ;FBXIP61
