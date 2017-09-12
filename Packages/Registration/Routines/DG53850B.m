DG53850B ;ALB/JRC - ICD-10 POST-INIT ;3/12/11 7:21am
 ;;5.3;Registration;**850**;Aug 13, 1993;Build 171
 ;
 Q
 ;
EN ; -- Post init entry
 N DGPATCH,DGRETV,DGCATAR,DG4589ST,DG2717ST
 S DGRETV=0
 S DGPATCH=$$PATCH^XPDUTL("DG*5.3*850")
 I DGPATCH D MES^XPDUTL("Patch DG*5.3*850 previously installed - File 27.17 and File #45.89 updates skipped.")
 I 'DGPATCH D
 . S DG2717ST=100 ;IEN to start adding ICD-10 entries in #27.17
 . S DG4589ST=5000 ;IEN to start adding ICD-10 entries in #45.89
 . S DGRETV=$$CHKPREP(.DGCATAR,DG2717ST,DG4589ST)
 . I DGRETV<0 Q
 . D BMES^XPDUTL("File #27.17:")
 . D UPD^DG53850D(DG2717ST)
 . D BMES^XPDUTL("File #45.89:")
 . D UPD4589(DG4589ST)
 . D REIN4589
 . D ADD4589(.DGCATAR,DG4589ST)
 I DGRETV<0 D MES^XPDUTL("Installation aborted. Fix the issues and start again.") Q
 ;
 D REC ;,ICD
 Q
 ;
REC ; -- re-compile all compiled input templates.
 N X,Y,DA,DIK,DMAX,DGERR,DGDUZSV,DGINTP,DNM
 I $G(DUZ)="" W !,"Your DUZ is not defined.  It must be defined to run this routine." Q
 S DGDUZSV=DUZ(0),DUZ(0)="@"
 ;
 D BMES^XPDUTL("Compiling Input Templates....")
 ;
 F DGINTP="DG101","DG401","DG501","DG501F","DG701" S Y=$O(^DIE("B",DGINTP,0)) S DGERR=0 D  I DGERR D BMES^XPDUTL("** "_DGINTP_" input template could not be updated")
 .I 'Y S DGERR=1 Q
 .S X=$P($G(^DIE(Y,"ROU")),U,2) I X="" S DGERR=1 Q
 .S DMAX=$$ROUSIZE^DILF D EN^DIEZ
 ;
 S DUZ(0)=DGDUZSV
 Q
 ;
 ;re-index #4589
REIN4589 ;
 D BMES^XPDUTL("Re-indexing existing ICD-9 entries for new indexes ....")
 N DIK
 S DIK="^DIC(45.89,"
 S DIK(1)=".02^ACODE"
 D ENALL^DIK
 Q
 ;adding coding system values to existing ICD-9 entries  
UPD4589(DG9IEN) ;
 N DGIEN,DGX
 D BMES^XPDUTL("Populating the new field #.05 for pre-existing ICD-9 entries")
 S DGIEN=0
 F  S DGIEN=$O(^DIC(45.89,DGIEN)) Q:+DGIEN=0!(DGIEN'<DG9IEN)  D
 . S DGX=$P($G(^DIC(45.89,DGIEN,0)),U,2)
 . S DGCSYS=$$CSI^ICDEX($S(DGX["ICD9":80,1:80.1),+DGX)
 . I 'DGCSYS Q
 . I +$$FILLFLDS(45.89,.05,DGIEN,DGCSYS)=0 D MES^XPDUTL("Code "_$$CODEC^ICDEX($S(DGX["ICD9":80,1:80.1),+DGX)_" wasn't updated")
 Q
 ;
 ;check values and prepare arrays
CHKPREP(DGCATAR,DG2717ST,DG4589ST) ;
 N DGCATS,DGIEN,DGIENMAX,DGQUIT
 I '$O(^DIC(45.89,0)) D BMES^XPDUTL("File #45.89 doesn't have any entries. Please restore the file and then install the patch.") Q -2
 I '$O(^DGEN(27.17,0)) D BMES^XPDUTL("File #27.17 doesn't have any entries. Please restore the file and then install the patch.") Q -3
 S DGQUIT=0
 S DGIENMAX=DG2717ST+200 D  I DGQUIT=1 D BMES^XPDUTL("File #27.17 contains entries with IENs in the range "_DG2717ST_" - "_DGIENMAX_". Please restore the standard data and then install the patch.") Q -5
 . F DGIEN=DG2717ST:1:DGIENMAX I $D(^DIC(27.17,DGIEN)) S DGQUIT=1 Q
 S DGQUIT=0
 S DGIENMAX=DG4589ST+1500 D  I DGQUIT=1 D BMES^XPDUTL("File #45.89 contains entries with IENs in the range "_DG4589ST_" - "_DGIENMAX_". Please restore the original data and then install the patch.") Q -6
 . F DGIEN=DG4589ST:1:DGIENMAX I $D(^DIC(27.17,DGIEN)) S DGQUIT=1 Q
 S DGQUIT=0
 F DGCATS="SUBSTANCE ABUSE","SUICIDE INDICATOR","KIDNEY TRANSPLANT STATUS","DIALYSIS TYPE" D  Q:DGQUIT=1
 . S DGCATAR(DGCATS)=$O(^DIC(45.88,"B",DGCATS,0))
 . I +DGCATAR(DGCATS)=0 D BMES^XPDUTL(DGCATS_" wasn't found in the file 45.88. Please correct the file and then install the patch.") S DGQUIT=1
 Q:DGQUIT=1 -1
 Q 1
 ;
 ;adding ICD-10 entries to #45.89 
 ;DGCATAR - array with categories (populated by CHKPREP)
 ;DG10IEN - IEN to start with
ADD4589(DGCATAR,DG10IEN) ;
 N DGSTIEN
 D BMES^XPDUTL("Adding diagnoses to the file #45.89")
 S DGSTIEN=$$DIAG4589(DG10IEN,.DGCATAR)
 D BMES^XPDUTL("Adding Procedure to the file #45.89")
 S DGSTIEN=$$PROC4589(DGSTIEN,.DGCATAR)
 W DGSTIEN
 Q
 ;
DIAG4589(DGIEN,DGCATAR) ;
 N DGY,DGX,DGY2,DGX2,DGCNT1,DGCNT2,DGVAL,DGCAT
 S (DGCNT1,DGCNT2)=0
 S DGVAL(.05)=30
 ;SUBSTANCE ABUSE diagnoses
 D BMES^XPDUTL(" Adding SUBSTANCE ABUSE entries...")
 S DGVAL(.01)=DGCATAR("SUBSTANCE ABUSE")
 F DGY=1:1 S DGX=$P($T(DSUBST+DGY^DG53850C),";",3) Q:DGX=""  D
 . S DGCNT1=DGCNT1+1
 . F DGY2=1:1 S DGX2=$P(DGX,",",DGY2) Q:DGX2=""  D
 .. S DGVAL(.02)=(+$$CODEN^ICDEX(DGX2,80))_";ICD9("
 .. I $G(DGVAL(.02))=-1 D BMES^XPDUTL("Code "_DGX2_" was not found in the file #80") Q
 .. I $$INSREC(45.89,"",.DGVAL,DGIEN,,,,1)<0 D BMES^XPDUTL("Code "_DGX2_" was not added to the file #45.89")
 .. S DGIEN=DGIEN+1
 .. S DGCNT2=DGCNT2+1
 ;D BMES^XPDUTL(DGCNT2_" codes have been added.")
 ;SUICIDE INDICATOR diagnoses
 D BMES^XPDUTL(" Adding SUICIDE INDICATOR entries...")
 S DGVAL(.01)=DGCATAR("SUICIDE INDICATOR")
 F DGY=1:1 S DGX=$P($T(DSUIC+DGY^DG53850C),";",3) Q:DGX=""  D
 . S DGCNT1=DGCNT1+1
 . F DGY2=1:1 S DGX2=$P(DGX,",",DGY2) Q:DGX2=""  D
 .. S DGVAL(.02)=(+$$CODEN^ICDEX(DGX2,80))_";ICD9("
 .. I $G(DGVAL(.02))=-1 D BMES^XPDUTL("Code "_DGX2_" was not found in the file #80") Q
 .. I $$INSREC(45.89,"",.DGVAL,DGIEN,,,,1)<0 D BMES^XPDUTL("Code "_DGX2_" was not added to the file #45.89")
 .. S DGIEN=DGIEN+1
 .. S DGCNT2=DGCNT2+1
 ;D BMES^XPDUTL(DGCNT2_" codes have been added.")
 ;KIDNEY TRANSPLANT STATUS diagnoses
 D BMES^XPDUTL(" Adding KIDNEY TRANSPLANT entries...")
 S DGVAL(.01)=DGCATAR("KIDNEY TRANSPLANT STATUS")
 F DGY=1:1 S DGX=$P($T(DKIDNEY+DGY^DG53850C),";",3) Q:DGX=""  D
 . S DGCNT1=DGCNT1+1
 . F DGY2=1:1 S DGX2=$P(DGX,",",DGY2) Q:DGX2=""  D
 .. S DGVAL(.02)=(+$$CODEN^ICDEX(DGX2,80))_";ICD9("
 .. I $G(DGVAL(.02))=-1 D BMES^XPDUTL("Code "_DGX2_" was not found in the file #80") Q
 .. I $$INSREC(45.89,"",.DGVAL,DGIEN,,,,1)<0 D BMES^XPDUTL("Code "_DGX2_" was not added to the file #45.89")
 .. S DGIEN=DGIEN+1
 .. S DGCNT2=DGCNT2+1
 D BMES^XPDUTL("  "_DGCNT2_" codes have been added.")
 Q DGIEN
 ;
PROC4589(DGIEN,DGCATAR) ;
 N DGY,DGX,DGY2,DGX2,DGCNT1,DGCNT2,DGVAL
 S (DGCNT1,DGCNT2)=0
 S DGVAL(.05)=31
 D BMES^XPDUTL(" Adding DIALYSIS TYPE entries...")
 S DGVAL(.01)=DGCATAR("DIALYSIS TYPE")
 F DGY=1:1 S DGX=$P($T(PDIAL+DGY^DG53850C),";",3) Q:DGX=""  D
 . W "."
 . S DGCNT1=DGCNT1+1
 . F DGY2=1:1 S DGX2=$P(DGX,",",DGY2) Q:DGX2=""  D
 .. S DGVAL(.02)=(+$$CODEN^ICDEX(DGX2,80.1))_";ICD0("
 .. I $G(DGVAL(.02))=-1 D BMES^XPDUTL("Code "_DGX2_" was not found in the file #80.1") Q
 .. I $$INSREC(45.89,"",.DGVAL,DGIEN,,,,1)<0 D BMES^XPDUTL("Code "_DGX2_" was not added to the file #45.89")
 .. S DGIEN=DGIEN+1
 .. S DGCNT2=DGCNT2+1
 D BMES^XPDUTL("  "_DGCNT2_" codes have been added.")
 Q DGIEN
 ;
 ;/**
 ;Creates a new entry (or node for multiple with .01 field)
 ;
 ;DGFILE - file/subfile number
 ;DGIEN - ien of the parent file entry in which the new subfile entry will be inserted
 ;DGZFDA - array with values for the fields
 ; format for DGZFDA:
 ; DGZFDA(.01)=value for #.01 field
 ; DGZFDA(3)=value for #3 field
 ;DGRECNO -(optional) specify IEN if you want specific value
 ; Note: "" then the system will assign the entry number itself.
 ;DGFLGS - FLAGS parameter for UPDATE^DIE
 ;DGLCKGL - fully specified global reference to lock
 ;DGLCKTM - time out for LOCK, if LOCKTIME=0 then the function will not lock the file 
 ;DGNEWRE - optional, flag = if 1 then allow to create a new top level record 
 ;  
 ;output :
 ; positive number - record # created
 ; <=0 - failure
 ;
 ;Example:
 ;"6^564419;ICD0(^^^31" to create an entry with IEN=5000
 ;S ZZ(.01)=6,ZZ(.02)="564419;ICD0(",ZZ(.05)=31 W $$INSREC^DG53850C(45.89,"",.ZZ,5000,,,,1)
INSREC(DGFILE,DGIEN,DGZFDA,DGRECNO,DGFLGS,DGLCKGL,DGLCKTM,DGNEWRE) ;*/
 I ('$G(DGFILE)) Q "0^Invalid parameter"
 I +$G(DGNEWRE)=0 I $G(DGRECNO)>0,'$G(DGIEN) Q "0^Invalid parameter"
 N DGSSI,DGIENS,DGERR,DGFDA
 N DGLOCK S DGLOCK=0
 I '$G(DGRECNO) N DGRECNO S DGRECNO=$G(DGRECNO)
 I DGIEN'="" S DGIENS="+1,"_DGIEN_"," I $L(DGRECNO)>0 S DGSSI(1)=+DGRECNO
 I DGIEN="" S DGIENS="+1," I $L(DGRECNO)>0 S DGSSI(1)=+DGRECNO
 M DGFDA(DGFILE,DGIENS)=DGZFDA
 I $L($G(DGLCKGL)) L +@DGLCKGL:(+$G(DGLCKTM)) S DGLOCK=$T I 'DGLOCK Q -2  ;lock failure
 D UPDATE^DIE($G(DGFLGS),"DGFDA","DGSSI","DGERR")
 I DGLOCK L -@DGLCKGL
 I $D(DGERR) Q -1  ;D BMES^XPDUTL($G(DGERR("DIERR",1,"TEXT",1),"Update Error")) Q -1
 Q +$G(DGSSI(1))
 ;
 ;populate fields
 ;Input:
 ;DGFILE file number
 ;DGFLD field number
 ;DGIENS ien string 
 ;DGNEWVAL new value to file (internal format)
 ;Output:
 ;0^ DGNEWVAL^error if failure
 ;1^ DGNEWVAL if success
FILLFLDS(DGFILE,DGFLD,DGIENS,DGNEWVAL) ;
 I '$G(DGFILE) Q "0^Invalid parameter"
 I '$G(DGFLD) Q "0^Invalid parameter"
 I '$G(DGIENS) Q "0^Invalid parameter"
 I $G(DGNEWVAL)="" Q "0^Null"
 N DGIENSTR,FDA,ERRARR
 S DGIENSTR=DGIENS_","
 S FDA(DGFILE,DGIENSTR,DGFLD)=DGNEWVAL
 D FILE^DIE("","FDA","ERRARR")
 I $D(ERRARR) Q "0^"_DGNEWVAL_"^"_ERRARR("DIERR",1,"TEXT",1)
 Q "1^"_DGNEWVAL
 ;
