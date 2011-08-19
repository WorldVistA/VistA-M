RAMAG06A ;HCIOFO/SG - ORDERS/EXAMS API (EXAM EDIT TOOLS) ; 2/6/09 11:14am
 ;;5.0;Radiology/Nuclear Medicine;**90**;Mar 16, 1998;Build 20
 ;
 Q
 ;
 ;+++++ EXAM EDIT PRE-PROCESSING
 ;
 ; RACTION       Actions (can be combined):
 ;                 E  Examined (procedure has been performed)
 ;                 C  Complete
 ;
 ; .RATRKCMB     Reference to a local variable where current values
 ;               of the CONTRAST MEDIA multiple will be saved.
 ;
 ; .RAPRIEN      Reference to a local array where some of current
 ;               case properties will be saved.
 ;
 ; Input variables:
 ;   RACNI, RADFN, RADTI
 ;
 ; Return values:
 ;       <0  Error descriptor (see $$ERROR^RAERR)
 ;        0  Ok
 ;
 ; NOTE: This is an internal entry point. Do not call it from outside
 ;       of exam editing routines.
 ;
EDTPRE(RACTION,RATRKCMB,RAPRIEN) ;
 N RARC
 S RARC=0
 ;--- Save 'before' CONTRAST MEDIA data values to compare
 ;--- against the possible 'after' values
 D TRK70CMB^RAMAINU(RADFN,RADTI,RACNI,.RATRKCMB)
 ;--- Save 'before' values (in RAPRIEN) to compare later in RAUTL1
 D SVBEFOR^RAO7XX(RADFN,RADTI,RACNI)
 ;---
 Q $S(RARC<0:RARC,1:0)
 ;
 ;+++++ EXAM EDIT POST-PROCESSING
 ;
 ; RACTION       Actions (can be combined):
 ;                 E  Examined (procedure has been performed)
 ;                 C  Complete
 ;
 ; RATRKCMB      Old values from the CONTRAST MEDIA multiple
 ;
 ; .RAPRIEN      Reference to a local array with saved case
 ;               properties.
 ;
 ; Input variables:
 ;   RACASE, RACNI, RADFN, RADTI, RAMISC
 ;
 ; Return values:
 ;       <0  Error descriptor (see $$ERROR^RAERR)
 ;        0  Ok
 ;
 ; NOTE: This is an internal entry point. Do not call it from outside
 ;       of exam editing routines.
 ;
EDTPST(RACTION,RATRKCMB,RAPRIEN) ;
 N FLAGS,N,RABLNK,RACAT,RAD3,RADELFLG,RAEXM0,RAEXOR,RAIENS,RAILP,RAMIFN,RAMOD,RAMODA,RAMODD,RAOIFN,RAOPT,RAORD0,RAORDB4,RAOREA,RAOSTS,RAPRC,RARC,RARSH,RASFM,RASHA,RATRKCMA,TMP,X,ZTQUEUED
 ;--- Compare new values with those saved by the SVBEFOR^RAO7XX and
 ;--- send changed order control "XX" to CPRS but do not send alert.
 S TMP=$$CMPAFTR^RAO7XX(0)
 ;--- Send HL7 messages
 S FLAGS=$$TRFLAGS^RAUTL22($G(RAMISC("FLAGS")),"S","S")
 I RACTION["E"  D  Q:RARC<0 RARC
 . S RARC=$$EXAMINED^RAMAGHL(RACASE,FLAGS)
 I RACTION["C"  D  Q:RARC<0 RARC
 . S RARC=$$REPORT^RAMAGHL(RACASE,FLAGS)
 ;--- Update the request/order status
 D
 . N IORI,IOSTBM ; Otherwise, the code breaks the BROWSER device
 . N ZTQUEUED
 . S ZTQUEUED=1  ; Suppress the output
 . D ^RAORDC
 ;--- Compare 'before' and 'after' CONTRAST MEDIA data
 ;--- and update the audit log if necessary.
 D TRK70CMA^RAMAINU(RADFN,RADTI,RACNI,RATRKCMB)
 ;---
 Q $S(RARC<0:RARC,1:0)
 ;
 ;+++++ NUCLEAR MEDICINE CODE
 ;
 ; RACASE        Examination identifiers
 ;                 ^01: IEN of the patient in the file #70    (RADFN)
 ;                 ^02: IEN in the REGISTERED EXAMS multiple  (RADTI)
 ;                 ^03: IEN in the EXAMINATIONS multiple      (RACNI)
 ;
 ; RACTION       Actions (can be combined):
 ;                 E  Examined (procedure has been performed)
 ;                 C  Complete
 ;
 ; .RAMISC       Reference to a local array containing miscellaneous
 ;               request parameters.
 ;
 ; .RAFDA        Reference to a local array where field values will
 ;               be prepared for storage (FileMan FDA array).
 ;
 ; Input variables:
 ;   RACN, RADTE, RAMISC, RAMSPSDEFS, RAPROCIEN
 ;
 ; Output variables:
 ;   RALOCK, RAMISC
 ;
 ; Return Values:
 ;       <0  Error descriptor (see $$ERROR^RAERR)
 ;        0  Nuclear medicine data is not needed
 ;       >0  IEN of the record of the NUC MED EXAM DATA file (#70.2)
 ;
NUCMED(RACASE,RACTION,RAMISC,RAFDA) ;
 N RANMDIEN,RARC,TMP
 ;--- Create the nuclear medicine stub if necessary
 S RANMDIEN=$$NMEDSTUB^RAMAGU13(RACASE,RAPROCIEN,RADTE,RACN)
 Q:RANMDIEN<0 RANMDIEN
 ;--- Nuclear medicine related
 I RANMDIEN>0  D  Q:RARC<0 RARC
 . ;--- Lock the nuclear medicine data
 . K TMP  S TMP(70.2,RANMDIEN_",")=""
 . S RARC=$$LOCKFM^RALOCK(.TMP)
 . I RARC  S RARC=$$LOCKERR^RAERR(RARC,"nuc. med. data")  Q
 . M RALOCK=TMP
 . ;--- Validate parameters
 . S RARC=$$VAL702^RAMAGU14(RANMDIEN_",",RACTION,.RAMISC,.RAFDA)
 . I RARC<0  S RARC=$$ERROR^RAERR(-11)  Q
 ;--- Success
 Q RANMDIEN
