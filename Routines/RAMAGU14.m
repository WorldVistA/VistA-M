RAMAGU14 ;HCIOFO/SG - ORDERS/EXAMS API (RAMISC VALID. #70.2) ; 8/18/08 10:02am
 ;;5.0;Radiology/Nuclear Medicine;**90**;Mar 16, 1998;Build 20
 ;
 Q
 ;
 ;***** VALIDATES RAMISC PARAMETERS RELATED TO THE FILE #70.2
 ;
 ; RAIENS        IENS of the nuclear medicine data (file #70.2)
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
VAL702(RAIENS,RACTION,RAMISC,RAFDA,RAFDACNT) ;
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
 ;--- Validate parameters specific to the 'EXAMINED' status
 I $TR(RACTION,"EC")'=RACTION  D  S:TMP<0 ERRCNT=ERRCNT+1
 . S TMP=$$VEXAMND(RAIENS,RACTION,.RAMISC,.RAFDA)
 ;
 ;--- Error handling and cleanup
 Q $S(ERRCNT>0:-11,1:0)
 ;
 ;+++++ VALIDATES 'EXAMINED' PARAMETERS
 ;
 ; RAIENS        IENS of the nuclear medicine data (file #70.2)
 ;
 ; RACTION       Action (can be combined):
 ;                 E  Examined (procedure has been performed)
 ;                 C  Complete
 ;
 ; .RAMISC       Reference to a local array containing miscellaneous
 ;               request parameters.
 ;
 ; .RAFDA        Reference to a local array where field values will
 ;               be prepared for storage (FileMan FDA array).
 ;
 ; Return values:
 ;       <0  Error code
 ;        0  Ok
 ;
VEXAMND(RAIENS,RACTION,RAMISC,RAFDA) ;
 N ERRCNT,IENS7021,NAME,NODE,RDPHI,TMP
 S ERRCNT=0
 ;
 ;=== Check if the nuclear medicine parameter list exists
 S TMP=$$VALPRM^RAMAGU09("RDPHARMS")
 I TMP'>0  Q $S(TMP<0:-11,1:0)
 ;
 ;=== Validate the nuclear medicine parameters
 S RDPHI=0
 F  S RDPHI=$O(RAMISC("RDPHARMS",RDPHI))  Q:RDPHI'>0  D
 . S NODE=$NA(RAMISC("RDPHARMS",RDPHI))
 . ;--- A new record IENS (with a placeholder) will be assigned to
 . ;--- this variable by the next call to $$CHECKFLD^RAMAGU09
 . K IENS7021
 . ;--- Validate RDPH-* parameters
 . S NAME=""
 . F  S NAME=$O(RAMSPSDEFS("F",70.21,NAME))  Q:NAME=""  D
 . . S:$$VALPRM^RAMAGU09(NAME,,.IENS7021,NODE)<0 ERRCNT=ERRCNT+1
 ;
 ;=== Error handling and cleanup
 Q $S(ERRCNT>0:-11,1:0)
