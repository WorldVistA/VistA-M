FBXIP151 ;WOIFO/SAB - PATCH INSTALL ROUTINE ;4/3/2014
 ;;3.5;FEE BASIS;**151**;JAN 30, 1995;Build 14
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ; 
 ; ICRs
 ;  #10141  BMES^XPDUTL, MES^XPDUTL, $$NEWCP^XPDUTL, $$PATCH^XPDUTL
 ;  #3352   DIEZ^DIKCUTL3
 ;
PS ; post-install entry point
 ; create KIDS checkpoints with call backs
 N FBX,Y
 F FBX="RCIT" D
 . S Y=$$NEWCP^XPDUTL(FBX,FBX_"^FBXIP151")
 . I 'Y D BMES^XPDUTL("ERROR Creating "_FBX_" Checkpoint.")
 Q
 ;
RCIT ; Recompile Input Templates
 ; need to include new cross-reference logic in complied templates
 N FBFLD,FBLIST
 D BMES^XPDUTL("    Recompiling Input Templates for File 161...")
 ;
 F FBFLD=.01,.02,.06,.07,.095 S FBLIST(161.01,FBFLD)=""
 D DIEZ^DIKCUTL3(161,.FBLIST)
 ;
 D MES^XPDUTL("    Done.")
 Q
 ;
 ;FBXIP151
