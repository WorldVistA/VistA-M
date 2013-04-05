FBXIP132 ;WOIFO/SAB - PATCH INSTALL ROUTINE ;4/25/2012
 ;;3.5;FEE BASIS;**132**;JAN 30, 1995;Build 17
 ; 
 ; ICRs
 ;  #10141  BMES^XPDUTL, MES^XPDUTL, $$NEWCP^XPDUTL, $$PATCH^XPDUTL
 ;  #4440   $$PROD^XUPROD
 ;
 ; the top of the routine is the environment check entry point
 ;
 N FBSKIP
 S FBSKIP=""
 ;
 ; determine if environmental check should be skipped
 I FBSKIP="",$G(XPDENV)'=1 S FBSKIP="Not a KIDS Install phase."
 I FBSKIP="",$$PROD^XUPROD()'=1 S FBSKIP="Not a production account."
 I FBSKIP="",$$PATCH^XPDUTL("FB*3.5*132")=1 S FBSKIP="Patch was previously installed."
 I FBSKIP]"" D
 . D BMES^XPDUTL(FBSKIP)
 . D MES^XPDUTL("Skipping environmental check.")
 ;
 I FBSKIP="" D
 . N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 . D BMES^XPDUTL("Performing environmental check.")
 . I $O(^FBAA(161.7,"AC","T",0)) D  Q
 . . D MES^XPDUTL("This patch cannot be installed because there are.")
 . . D MES^XPDUTL("batches with status equal to TRANSMITTED.")
 . . D MES^XPDUTL("The Active Batch Listing by Status option can be used")
 . . D MES^XPDUTL("to generate a list of the batches with this status.")
 . . S XPDQUIT=2
 . ;
 . ; ask user for confirmation
 . D BMES^XPDUTL("The Chief Fiscal Officer or representative must verify")
 . D MES^XPDUTL("there are no pending payments on Central Fee report")
 . D MES^XPDUTL("number 12007 for your site.")
 . D MES^XPDUTL(" ")
 . S DIR(0)="Y"
 . S DIR("A")="Has the Chief Fiscal Officer approved installation of this patch"
 . D ^DIR K DIR
 . I $D(DIRUT)!'Y S XPDQUIT=2
 Q
 ;
PR ; pre-install entry point
 ; create KIDS checkpoints with call backs
 N FBX,Y
 F FBX="DELAJ" D
 . S Y=$$NEWCP^XPDUTL(FBX,FBX_"^FBXIP132")
 . I 'Y D BMES^XPDUTL("ERROR Creating "_FBX_" Checkpoint.")
 Q
 ;
DELAJ ; Delete AJ x-ref definition
 D BMES^XPDUTL("    Deleting traditional AJ x-ref from file 162 ...")
 ;
 ; delete traditional mumps AJ x-ref definition from INVOICE NUMBER
 ; it will be replaced by an equivalent new-style regular AJ x-ref
 ;   during the KIDS install of the partial DD
 ; the cross-referance data will not be impacted
 D DELIX^DDMOD(162.03,14,2,"","")
 ;
 D MES^XPDUTL("    Done.")
 Q
 ;
PS ; post-install entry point
 ; create KIDS checkpoints with call backs
 N FBX,Y
 F FBX="XREF" D
 . S Y=$$NEWCP^XPDUTL(FBX,FBX_"^FBXIP132")
 . I 'Y D BMES^XPDUTL("ERROR Creating "_FBX_" Checkpoint.")
 Q
 ;
XREF ; Set new x-ref
 N DIK
 D BMES^XPDUTL("    Setting File 161.45 AN x-ref...")
 ;
 S DIK="^FBAA(161.45,"
 S DIK(1)="2^AN"
 D ENALL^DIK
 ;
 D MES^XPDUTL("    Done.")
 Q
 ;
 ;FBXIP132
