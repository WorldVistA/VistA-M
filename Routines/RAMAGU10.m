RAMAGU10 ;HCIOFO/SG - ORDERS/EXAMS API (RAMISC VALID. #74) ; 3/5/09 2:23pm
 ;;5.0;Radiology/Nuclear Medicine;**90**;Mar 16, 1998;Build 20
 ;
 Q
 ;
 ;***** VALIDATES RAMISC PARAMETERS RELATED TO THE FILE #74
 ;
 ; RAIENS        IENS of the report (file #74)
 ;
 ; RACTION       Action (can be combined):
 ;                 E  Examined (procedure has been performed)
 ;                 C  Complete
 ;
 ; .RAMISC       Reference to a local array containing miscellaneous
 ;               request parameters.
 ;
 ; .RAFDA(       Reference to a local array where field values will
 ;               be prepared for storage (FileMan FDA array).
 ;
 ;   "RACNT")    This is an additional node that stores counter for
 ;               the IENS placeholders. Do not forget to remove this
 ;               node before passing the array into a FileMan API.
 ;
 ;   "RAIENS")   This is an additional node that stores IENS of the
 ;               record being processed. Do not forget to remove this 
 ;               node before passing the array into a FileMan API.
 ;
 ; [RAFDACNT]    New value for the placeholder counter for the RAFDA. 
 ;               If this parameter is greater than zero, it replaces
 ;               the value stored in the RAFDA("RACNT").
 ;
 ; Input variables:
 ;   RAMSPSDEFS
 ;
 ; Return values:
 ;       <0  Error code
 ;        0  Ok
 ;
VAL74(RAIENS,RACTION,RAMISC,RAFDA,RAFDACNT) ;
 N ERRCNT,RC,TMP
 ;
 ;--- Check required parameters and variables
 S RC=$$CHKREQ^RAUTL22("RACTION,RAIENS")  Q:RC<0 RC
 Q:$TR(RACTION,"EC")'="" $$IPVE^RAERR("RACTION")
 ;
 ;--- Initialize variables
 S RAFDA("RAIENS")=RAIENS
 S:$G(RAFDACNT)>0 RAFDA("RACNT")=+RAFDACNT
 S (ERRCNT,RC)=0
 ;
 ;--- Validate parameters specific to the 'COMPLETE' status
 I RACTION["C"  D  S:TMP<0 ERRCNT=ERRCNT+1
 . S TMP=$$VCOMPLT(RAIENS,RACTION,.RAMISC,.RAFDA)
 ;
 ;--- Error handling and cleanup
 Q $S(ERRCNT>0:-11,1:0)
 ;
 ;+++++ VALIDATES 'COMPLETE' PARAMETERS
VCOMPLT(RAIENS,RACTION,RAMISC,RAFDA) ;
 N ERRCNT,NAME,PNODE,RC,TMP
 S ERRCNT=0
 ;
 ;=== Word-processing fields
 S:$$VALPRM^RAMAGU09("ACLHIST",,RAIENS)<0 ERRCNT=ERRCNT+1
 S:$$VALPRM^RAMAGU09("IMPRESSION",,RAIENS)<0 ERRCNT=ERRCNT+1
 S:$$VALPRM^RAMAGU09("REPORT",,RAIENS,,"R")<0 ERRCNT=ERRCNT+1
 ;
 ;=== Problem statement
 S RC=$$VALPRM^RAMAGU09("PROBSTAT",,RAIENS)
 I RC>0  D
 . K RAFDA(74,RAIENS,25)  ; Do not store directly
 E  S:RC<0 ERRCNT=ERRCNT+1
 ;
 ;=== Report date
 S NAME="RPTDTE"
 S:$D(RAMISC(NAME))#10 RAMISC(NAME)=RAMISC(NAME)\1  ; Strip the time
 S:$$VALPRM^RAMAGU09(NAME,,RAIENS,,"R")<0 ERRCNT=ERRCNT+1
 ;
 ;=== Transcriptionist
 S:$$VALPRM^RAMAGU09("TRANSCRST",,RAIENS)<0 ERRCNT=ERRCNT+1
 ;
 ;=== Verification date
 S:$$VALPRM^RAMAGU09("VERDTE",,RAIENS)<0 ERRCNT=ERRCNT+1
 ;
 ;=== Verifying physician
 S:$$VALPRM^RAMAGU09("VERPHYS",,RAIENS)<0 ERRCNT=ERRCNT+1
 ;
 ;=== Report status
 S PNODE=$NA(RAMISC("RPTSTATUS"))
 S:'($D(@PNODE)#10) @PNODE="V"
 I @PNODE'="V",@PNODE'="EF"  D:$P($G(RAMSPSDEFS("R")),U,12)
 . D IPVE^RAERR(PNODE)  S ERRCNT=ERRCNT+1
 ;
 ;=== Error handling and cleanup
 Q $S(ERRCNT>0:-11,1:0)
