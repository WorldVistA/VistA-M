RORUTL19 ;HCIOFO/SG - PATIENT DATA UTILITIES ; 1/29/07 9:53am
 ;;1.5;CLINICAL CASE REGISTRIES;**2**;Feb 17, 2006;Build 6
 ;
 Q
 ;
 ;***** UPDATES THE LOCAL FIELDS
 ;
 ; IENS798       IENS of the registry record in the file #798
 ;
 ; .LFV          Reference to a local variable that stores the
 ;               list of the local field values
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok. No changes in local fields.
 ;       >1  Ok. Local fields were modified.
 ;
UPDLFV(IENS798,LFV) ;
 N DA,DIK,FLDIEN,IENS,IR,LFCNT,LFIEN,MOD,RC,RORFDA,RORLST,RORMSG,SCR
 S (MOD,RC)=0
 ;
 S (LFCNT,LFIEN)=0
 F  S LFIEN=$O(LFV(LFIEN))  Q:LFIEN'>0  D
 . S LFCNT=LFCNT+1,IENS="?+"_LFCNT_","_IENS798
 . S RORFDA(798.02,IENS,.01)=LFIEN
 . S RORFDA(798.02,IENS,.02)=$P(LFV(LFIEN),U,5)
 . S RORFDA(798.02,IENS,1)=$P(LFV(LFIEN),U,6)
 ;--- Delete values of active fields that are not present in the
 ;    LFV array (deleted by the user). Values of inactive fields
 ;--- are always left intact.
 S SCR="I $$LFACTIVE^RORDD01(+$G(^(0)))"
 S IENS=","_IENS798
 D LIST^DIC(798.02,IENS,"@;.01I",,,,,"B",SCR,,"RORLST","RORMSG")
 Q:$G(DIERR) $$DBS^RORERR("RORMSG",-9,,,798.02,IENS)
 S DIK=$$ROOT^DILFD(798.02,IENS),DA(1)=+IENS798
 S IR=""
 F  S IR=$O(RORLST("DILIST","ID",IR))  Q:IR=""  D
 . S FLDIEN=+RORLST("DILIST","ID",IR,.01)
 . I '$D(LFV(FLDIEN))  S DA=+RORLST("DILIST",2,IR)  D ^DIK  S MOD=1
 ;--- Store the data
 I $D(RORFDA)>1  S MOD=1  D  Q:RC<0 RC
 . D UPDATE^DIE(,"RORFDA",,"RORMSG")
 . S:$G(DIERR) RC=$$DBS^RORERR("RORMSG",-9,,,798.02,IENS798)
 ;--- Success
 Q MOD
