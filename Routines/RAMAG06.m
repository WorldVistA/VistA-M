RAMAG06 ;HCIOFO/SG - ORDERS/EXAMS API (EXAM COMPLETION) ; 3/6/09 4:20pm
 ;;5.0;Radiology/Nuclear Medicine;**90**;Mar 16, 1998;Build 20
 ;
 Q
 ;
 ;##### COMPLETES THE EXAM
 ;
 ; .RAPARAMS       Reference to the API descriptor
 ;                 (see the ^RA01 routine for details)
 ; 
 ; RACASE          Exam/case identifiers
 ;                   ^01: IEN of the patient in the file #70   (RADFN)
 ;                   ^02: IEN in the REGISTERED EXAMS multiple (RADTI)
 ;                   ^03: IEN in the EXAMINATIONS multiple     (RACNI)
 ;
 ; [.RAMISC]       Reference to a local array containing miscellaneous
 ;                 exam parameters.
 ;
 ;                 See the ^RAMAG routine for additional important
 ;                 details regarding this parameter.
 ;
 ; RAMISC(
 ;
 ;   "ACLHIST",    Text for the ADDITIONAL CLINICAL HISTORY field
 ;     Seq#)       (400) of the RAD/NUC MED REPORTS file (#74).
 ;                 Required: No
 ;                 Default:  undefined
 ;
 ;   "FLAGS")      Flags that control the execution (see the ^RAMAG
 ;                 routine for details). Supported flags: "F", "S".
 ;                 Required: No
 ;                 Default:  undefined
 ;
 ;   "IMPRESSION", Text for the IMPRESSION TEXT field (300) of the
 ;     Seq#)       file #74.
 ;                 Required: Site and/or imaging type specific
 ;                 Default:  undefined
 ;
 ;   "PROBSTAT")   Free text value for the PROBLEM STATEMENT field
 ;                 (25) of the file #74. If this parameter is defined 
 ;                 and not empty (space characters are not counted),
 ;                 then the PROBLEM DRAFT status is assigned to the
 ;                 report.
 ;                 Required: No
 ;                 Default:  undefined
 ;
 ;   "REPORT",     Text for the REPORT TEXT field (200)
 ;     Seq#)       of the file #74.
 ;                 Required: Yes
 ;                 Default:  undefined
 ;
 ;   "RPTDTE")     Internal date value (FileMan) for the REPORTED
 ;                 DATE field (8) of the file #74. The date must be
 ;                 exact. If time is provided, it is ignored.
 ;                 Required: Yes
 ;                 Default:  undefined
 ;
 ;   "RPTSTATUS")  Internal value for the REPORT STATUS field (5) of
 ;                 the file #74. Currently, only "V" (Verified) and
 ;                 "EF" (Electronically Filed) codes are supported.
 ;                 Required: Yes
 ;                 Default:  "V"
 ;
 ;   "TRANSCRST")  Internal value for the TRANSCRIPTIONIST field (11)
 ;                 of the file #74: IEN in the NEW PERSON file (#200).
 ;                 Required: No
 ;                 Default:  undefined
 ;
 ;   "VERDTE")     Internal date value (FileMan) for the VERIFIED DATE
 ;                 field (7) of the file #74. The date must be exact.
 ;                 Required: No
 ;                 Default:  undefined
 ;
 ;   "VERPHYS")    Internal value for the VERIFYING PHYSICIAN field
 ;                 (9) of the file #74: IEN in the NEW PERSON file
 ;                 (#200).
 ;                 Required: No
 ;                 Default:  undefined
 ;
 ;   "BEDSECT")    If any of these optional parameters are defined,
 ;   "CMUSED")     their values replace the existing ones assigned
 ;   "COMPLICAT")  by the $$REGISTER^RAMAG03 and $$EXAMINED^RAMAG07.
 ;   "CONTMEDIA",#)
 ;   "CPTMODS",#)
 ;   "EXAMCAT")
 ;   "FILMSIZE",#)
 ;   "PRIMCAM")
 ;   "PRIMDXCODE")
 ;   "PRIMINTRES")
 ;   "PRIMINTSTF")
 ;   "PRINCLIN")
 ;   "RDPHARMS",#,"RDPH-...")
 ;   "SERVICE")
 ;   "TECH",#)
 ;   "TECHCOMM")
 ;   "WARD")
 ;
 ; Return values:
 ;       <0  Error descriptor (see $$ERROR^RAERR)
 ;        0  Exam has been completed
 ;
COMPLETE(RAPARAMS,RACASE,RAMISC) ;
 N RACN            ; Case number
 N RACNI           ; IEN of the exam in the EXAMINATIONS multiple
 N RADFN           ; IEN of the patient in the file #70
 N RADTE           ; Date/time of the exam
 N RADTI           ; Inverted date/time of the exam
 N RAIENS          ; IENS of the exam record
 N RAIMGTYI        ; Imaging type IEN (file #79.2)
 N RAMSPSDEFS      ; Data for miscellaneous parameters validation
 N RANMDIEN        ; IEN of the nuclear medicine data (file #70.2)
 N RAOIFN          ; IEN of the order (file #75.1)
 N RAPROCIEN       ; Radiology procedure IEN
 N RPTIEN          ; IEN of the report (file #74)
 ;
 N RACTION,RALOCK,RAMSG,RAPOST,RAPRIEN,RARC,RARCP,RATRKCMB,TMP
 D:$G(RAPARAMS("DEBUG"))>1
 . D W^RAMAGU11("$$COMPLETE^RAMAG06","!!")
 . D VARS^RAMAGU11("RACASE")
 . D ZW^RAUTL22("RAMISC")
 S (RARC,RARCP)=0
 ;
 ;--- Validate case identifiers
 S RARC=$$CHKREQ^RAUTL22("RACASE")   Q:RARC<0 RARC
 S RARC=$$CHKEXMID^RAMAGU04(RACASE)  Q:RARC<0 RARC
 S RADFN=$P(RACASE,U),RADTI=$P(RACASE,U,2),RACNI=$P(RACASE,U,3)
 S RAIENS=$$EXAMIENS^RAMAGU04(RACASE)
 ;
 ;--- Get the order IEN
 S RAOIFN=$$GET1^DIQ(70.03,RAIENS,11,"I",,"RAMSG")
 Q:$G(DIERR) $$DBS^RAERR("RAMSG",-9,70.03,RAIENS)
 Q:RAOIFN'>0 $$ERROR^RAERR(-19,,70.03,RAIENS,11)
 ;
 ;--- Create the report stub if necessary
 S RPTIEN=$$RPTSTUB^RAMAGU12(RACASE,.RADTE,.RACN)
 Q:RPTIEN<0 RPTIEN
 ;
 ;--- Lock affected objects
 K TMP
 S TMP(70.03,RAIENS)=""
 S TMP(74,RPTIEN_",")=""
 S TMP(75.1,RAOIFN_",")=""
 S RARC=$$LOCKFM^RALOCK(.TMP)
 Q:RARC $$LOCKERR^RAERR(RARC,"exam/order/report")
 M RALOCK=TMP
 ;
 D
 . ;--- Setup the error handler
 . N $ESTACK,$ETRAP  D SETDEFEH^RAERR("RARC")
 . ; 
 . ;--- Initialize variables
 . N EXMST,RAFDA,RAFDAM
 . D LDMSPRMS^RAMAGU01(.RAMSPSDEFS)
 . S RACTION="EC"
 . ;
 . ;--- Load exam properties
 . S RARC=$$EXAMVARS^RAMAGU04(RAIENS)  Q:RARC<0
 . ;
 . ;--- Get descriptor of the desired exam status
 . S EXMST=$$EXMSTINF^RAMAGU06("^^9",RAIMGTYI)
 . I EXMST<0  S RARC=EXMST  Q
 . ;
 . ;--- Validate general parameters
 . S RARC=$$VAL70^RAMAGU08(RAIENS,+EXMST,.RACTION,.RAMISC,.RAFDAM)
 . I RARC<0  S RARC=$$ERROR^RAERR(-11)  Q
 . Q:RACTION=""  ;--- Exam already has requested status
 . S RARC=$$VAL74^RAMAGU10(RPTIEN_",",RACTION,.RAMISC,.RAFDAM)
 . I RARC<0  S RARC=$$ERROR^RAERR(-11)  Q
 . ;
 . ;--- Nuclear medicine (including parameter validation)
 . S RARC=$$NUCMED^RAMAG06A(RACASE,RACTION,.RAMISC,.RAFDAM)  Q:RARC<0
 . S RANMDIEN=RARC
 . ;
 . ;--- Pre-processing
 . S RARC=$$EDTPRE^RAMAG06A(RACTION,.RATRKCMB,.RAPRIEN)  Q:RARC<0
 . K RAFDAM("RACNT"),RAFDAM("RAIENS")
 . ;
 . ;--- Update the exam record
 . K RAFDA,RAMSG  M RAFDA(70.03)=RAFDAM(70.03)  K RAFDAM(70.03)
 . I $D(RAFDA)>1  D  Q:RARC<0  S RAPOST=1
 . . D FILE^DIE(,"RAFDA","RAMSG")
 . . S:$G(DIERR) RARC=$$DBS^RAERR("RAMSG",-9,70.03,RAIENS)
 . ;
 . ;--- Update the nuclear medicine data
 . K RAFDA,RAMSG  M RAFDA(70.21)=RAFDAM(70.21)  K RAFDAM(70.21)
 . I $D(RAFDA)>1  D  Q:RARC<0  S RAPOST=1
 . . S RARC=$$UPDMULT^RAMAGU13(.RAFDA,RANMDIEN_",")
 . ;
 . ;--- Update the report record
 . K RAFDA,RAMSG  M RAFDA(74)=RAFDAM(74)  K RAFDAM(74)
 . I $D(RAFDA)>1  D  Q:RARC<0  S RAPOST=1
 . . D FILE^DIE(,"RAFDA","RAMSG")
 . . S:$G(DIERR) RARC=$$DBS^RAERR("RAMSG",-9,74,RPTIEN_",")
 . ;
 . ;--- Update multiples of the exam record
 . I $D(RAFDAM)>1  D  Q:RARC<0  S RAPOST=1
 . . S RARC=$$UPDMULT^RAMAGU13(.RAFDAM,RAIENS)
 . ;
 . ;--- Report status
 . S TMP=$G(RAMISC("PROBSTAT"))
 . S RARC=$$UPDRPTST^RAMAGU12(RPTIEN,$G(RAMISC("RPTSTATUS")),TMP)
 . Q:RARC<0
 . ;--- Exam status
 . S TMP=$$TRFLAGS^RAUTL22($G(RAMISC("FLAGS")),"F","F")
 . S RARC=$$UPDEXMST^RAMAGU05(RACASE,EXMST,TMP)  Q:RARC<0
 . ;--- Activity log
 . S TMP=$G(RAMISC("TECHCOMM"))
 . S RARC=$$UPDEXMAL^RAMAGU05(RACASE,"C",TMP)
 ;
 ;--- Post-processing is performed and notifications are sent if any
 ;    changes to the case have been made (even if its status has not
 ;--- been changed to 'COMPLETE').
 D:$G(RAPOST)
 . N $ESTACK,$ETRAP
 . D SETDEFEH^RAERR("RARCP")
 . S RARCP=$$EDTPST^RAMAG06A(RACTION,RATRKCMB,.RAPRIEN)
 ;
 ;--- Error handling and cleanup
 D UNLOCKFM^RALOCK(.RALOCK)
 Q $S(RARC<0:RARC,RARCP<0:RARCP,1:0)
