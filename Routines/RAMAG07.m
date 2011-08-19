RAMAG07 ;HCIOFO/SG - ORDERS/EXAMS API (EXAMINED) ; 9/30/08 8:52am
 ;;5.0;Radiology/Nuclear Medicine;**90**;Mar 16, 1998;Build 20
 ;
 Q
 ;
 ;##### INDICATES THAT THE PROCEDURE HAS BEEN PERFORMED
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
 ;   "CMUSED")     Internal value for the CONTRAST MEDIA USED field
 ;                 (10) of the EXAMINATIONS multiple (sub-file
 ;                 #70.03).
 ;                 Required: No
 ;                 Default:  undefined
 ;
 ;   "COMPLICAT")  Internal values for the COMPLICATION (16)
 ;                 and COMPLICATION TEXT (16.5) fields of the
 ;                 sub-file #70.03.
 ;                   ^01: IEN in the COMPLICATION TYPES file (#78.1)
 ;                   ^02: Complication text
 ;                 Required: No
 ;                 Default:  undefined
 ;
 ;   "CONTMEDIA"
 ;     Seq#)       Internal value for the CONTRAST MEDIA field (.01)
 ;                 of the sub-file #70.3225.
 ;                 Required: No
 ;                 Default:  undefined
 ;
 ;   "CPTMODS",
 ;     Seq#)       Internal value for the CPT MODIFIERS field (.01)
 ;                 of the sub-file #70.3135: IEN in the CPT MODIFIER
 ;                 file (#81.3).
 ;                 Required: Site and/or imaging type specific
 ;                 Default:  undefined
 ;
 ;   "FILMSIZE",
 ;     Seq#)       Internal values for the record of the FILM SIZE
 ;                 multiple (70) of the sub-file #70.03.
 ;                   ^01: IEN in the FILM SIZES file (#78.4)
 ;                   ^02: Amount (#films or cine ft)
 ;                 Required: Site and/or imaging type specific
 ;                 Default:  undefined
 ;
 ;   "FLAGS")      Flags that control the execution (see the ^RAMAG
 ;                 routine for details). Supported flags: "F", "S".
 ;                 Required: No
 ;                 Default:  undefined
 ;
 ;   "PRIMCAM")    Internal value for the PRIMARY CAMERA/EQUIP/RM
 ;                 field (18) of the sub-file #70.03: IEN in the
 ;                 CAMERA/EQUIP/RM file (#78.6).
 ;                 Required: Site and/or imaging type specific
 ;                 Default:  undefined
 ;
 ;   "PRIMDXCODE") Internal value for the PRIMARY DIAGNOSTIC CODE
 ;                 field (13) of the sub-file #70.03: IEN in the
 ;                 DIAGNOSTIC CODES file (#78.3).
 ;                 Required: Site and/or imaging type specific
 ;                 Default:  undefined
 ;
 ;   "PRIMINTRES") Internal value for the PRIMARY INTERPRETING
 ;                 RESIDENT field (12) of the sub-file #70.03: IEN in
 ;                 the NEW PERSON file (#200).
 ;                 Required: Site and/or imaging type specific
 ;                 Default:  undefined
 ;
 ;   "PRIMINTSTF") Internal value for the PRIMARY INTERPRETING
 ;                 STAFF field (15) of the sub-file #70.03: IEN in
 ;                 the NEW PERSON file (#200).
 ;                 Required: Site and/or imaging type specific
 ;                 Default:  undefined
 ;
 ;   "RAPROC",
 ;     1)          Radiology procedure and modifiers
 ;                   ^01: Procedure IEN in file #71
 ;                   ^02: Optional procedure modifiers (IENs in
 ;                   ...  the PROCEDURE MODIFIERS file (#71.2))
 ;                   ^nn:
 ;                 Required: No (if defined, replaces the existing
 ;                           value assigned by $$REGISTER^RAMAG03)
 ;                 Default:  undefined
 ;
 ;                 NOTE: Only a single procedure is associated with
 ;                       a case. Therefore, only the first subnode
 ;                       of the "RAPROC" with a subscript greater
 ;                       than 0 is used.
 ;
 ;   "RDPHARMS",   INTERNAL VALUES FOR THE RECORDS OF THE
 ;     i,          'RADIOPHARMACEUTICALS' MULTIPLE (100) OF THE
 ;                 'NUC MED EXAM DATA' FILE (#70.2).
 ;
 ;       "RDPH-ACDR")  Internal value for the ACTIVITY DRAWN
 ;                     field (4).
 ;                     Required: Site and/or imaging type specific
 ;                     Default:  undefined
 ;
 ;       "RDPH-DOSE")  Internal value for the DOSE ADMINISTERED
 ;                     field (7).
 ;                     Required: Yes (if any other radiopharmaceutical
 ;                               parameters are provided)
 ;                     Default:  undefined
 ;
 ;       "RDPH-DRUG")  Internal value for the RADIOPHARMACEUTICAL
 ;                     field (.01).
 ;                     Required: Yes (if any other radiopharmaceutical
 ;                               parameters are provided)
 ;                     Default:  undefined
 ;
 ;       "RDPH-DTADM") Internal value for the DATE/TIME DOSE
 ;                     ADMINISTERED field (8).
 ;                     Required: Site and/or imaging type specific
 ;                     Default:  undefined
 ;
 ;       "RDPH-DTDRW") Internal value for the DATE/TIME DRAWN
 ;                     field (5).
 ;                     Required: Site and/or imaging type specific
 ;                     Default:  undefined
 ;
 ;       "RDPH-FORM")  Internal value for the FORM field (15).
 ;                     Required: Site and/or imaging type specific
 ;                     Default:  undefined
 ;
 ;       "RDPH-LOTN")  Internal value for the LOT NO field (13).
 ;                     Required: Site and/or imaging type specific
 ;                     Default:  undefined
 ;
 ;       "RDPH-PWADM") Internal value for the PERSON WHO ADMINISTERED 
 ;                     DOSE field (9).
 ;                     Required: Site and/or imaging type specific
 ;                     Default:  undefined
 ;
 ;       "RDPH-PWMSD") Internal value for the PERSON WHO MEASURED DOSE
 ;                     field (6).
 ;                     Required: Site and/or imaging type specific
 ;                     Default:  undefined
 ;
 ;       "RDPH-ROUTE") Internal value for the ROUTE OF ADMINISTRATION
 ;                     field (11).
 ;                     Required: Site and/or imaging type specific
 ;                     Default:  undefined
 ;
 ;       "RDPH-SITE")  Internal value for the SITE OF ADMINISTRATION
 ;                     field (12).
 ;                     Required: Site and/or imaging type specific
 ;                     Default:  undefined
 ;
 ;       "RDPH-VOL")   Internal value for the VOLUME field (14).
 ;                     Required: Site and/or imaging type specific
 ;                     Default:  undefined
 ;
 ;   "TECH",
 ;     Seq#)       Internal value for the TECHNOLOGIST field (.01)
 ;                 of the subfile #70.12: IEN in the NEW PERSON
 ;                 file (#200).
 ;                 Required: Site and/or imaging type specific
 ;                 Default:  undefined
 ;
 ;   "TECHCOMM")   Technologist comment
 ;                 Required: No
 ;                 Default:  undefined
 ;
 ;   "BEDSECT")    If any of these optional parameters are defined,
 ;   "EXAMCAT")    their values replace the existing ones assigned
 ;   "PRINCLIN")   by the $$REGISTER^RAMAG03.
 ;   "SERVICE")
 ;   "WARD")
 ;
 ; Return values:
 ;       <0  Error descriptor (see $$ERROR^RAERR)
 ;        0  Case has been marked as 'examined'
 ;
EXAMINED(RAPARAMS,RACASE,RAMISC) ;
 N RACN            ; Case number
 N RACNI           ; IEN of the exam in the EXAMINATIONS multiple
 N RADFN           ; IEN of the patient in the file #70
 N RADTE           ; Date/time of the exam
 N RADTI           ; Inverted date/time of the exam
 N RAIENS          ; IENS of the exam record
 N RAIMGTYI        ; Imaging type IEN (file #79.2)
 N RAMSPSDEFS      ; Data for miscellaneous parameters validation
 N RANMDIEN        ; IEN of the nuclear medicine data (file #70.2)
 N RAPROCIEN       ; Radiology procedure IEN
 ;
 N RALOCK,RAMSG,RARC,TMP
 D:$G(RAPARAMS("DEBUG"))>1
 . D W^RAMAGU11("$$EXAMINED^RAMAG07","!!")
 . D VARS^RAMAGU11("RACASE")
 . D ZW^RAUTL22("RAMISC")
 ;
 ;--- Validate case identifiers
 S RARC=$$CHKREQ^RAUTL22("RACASE")   Q:RARC<0 RARC
 S RARC=$$CHKEXMID^RAMAGU04(RACASE)  Q:RARC<0 RARC
 S RADFN=$P(RACASE,U),RADTI=$P(RACASE,U,2),RACNI=$P(RACASE,U,3)
 S RAIENS=$$EXAMIENS^RAMAGU04(RACASE)
 ;
 ;--- Lock the exam
 K TMP  S TMP(70.03,RAIENS)=""
 S RARC=$$LOCKFM^RALOCK(.TMP)
 Q:RARC $$LOCKERR^RAERR(RARC,"examination")
 M RALOCK=TMP
 ;
 D
 . ;--- Setup the error handler
 . N $ESTACK,$ETRAP  D SETDEFEH^RAERR("RARC")
 . ;
 . ;--- Initialize variables
 . N EXMST,RACTION,RAFDA,RAFDAM,RAPRIEN,RATRKCMB
 . D LDMSPRMS^RAMAGU01(.RAMSPSDEFS)
 . S RACTION="E"
 . ;
 . ;--- Get the current exam status
 . S EXMST=$$EXMSTAT^RAMAGU05(RACASE)
 . I EXMST<0  S RARC=EXMST  Q
 . ;--- Find the exam status that has 'E:Examined' value
 . ;--- in the VISTARAD CATEGORY field (9).
 . S RARC=$$GETEXMND^RAMAGU06(+EXMST)  Q:RARC<0
 . I RARC'>0  D  Q
 . . S RARC=$$ERROR^RAERR(-31,"RACASE='"_RACASE_"'","EXAMINED")
 . S EXMST=RARC  ; New exam status
 . ;
 . ;--- Load exam properties and initialize key variables
 . S RARC=$$EXAMVARS^RAMAGU04(RAIENS)  Q:RARC<0
 . ;
 . ;--- Validate general parameters
 . S RARC=$$VAL70^RAMAGU08(RAIENS,+EXMST,.RACTION,.RAMISC,.RAFDAM)
 . I RARC<0  S RARC=$$ERROR^RAERR(-11)  Q
 . Q:RACTION=""  ;--- Exam is at or past the requested status
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
 . I $D(RAFDA)>1  D  Q:RARC<0
 . . D FILE^DIE(,"RAFDA","RAMSG")
 . . S:$G(DIERR) RARC=$$DBS^RAERR("RAMSG",-9,70.03,RAIENS)
 . ;
 . ;--- Update the nuclear medicine data
 . K RAFDA,RAMSG  M RAFDA(70.21)=RAFDAM(70.21)  K RAFDAM(70.21)
 . I $D(RAFDA)>1  D  Q:RARC<0
 . . S RARC=$$UPDMULT^RAMAGU13(.RAFDA,RANMDIEN_",")
 . ;
 . ;--- Update procedure and modifiers
 . S TMP=$O(RAMISC("RAPROC",0))
 . I TMP>0  S TMP=$G(RAMISC("RAPROC",TMP))  D:TMP'=""  Q:RARC<0
 . . S RARC=$$UPDEXMPR^RAMAGU04(RACASE,TMP)
 . ;
 . ;--- Update multiples of the exam record
 . I $D(RAFDAM)>1  D  Q:RARC<0
 . . S RARC=$$UPDMULT^RAMAGU13(.RAFDAM,RAIENS)
 . ;
 . ;--- Create the stub report
 . S RARC=$$RPTSTUB^RAMAGU12(RACASE,RADTE,RACN)  Q:RARC<0
 . ;
 . ;--- Exam status
 . S TMP=$$TRFLAGS^RAUTL22($G(RAMISC("FLAGS")),"F","F")
 . S RARC=$$UPDEXMST^RAMAGU05(RACASE,EXMST,TMP)  Q:RARC<0
 . ;--- Activity log
 . S TMP=$G(RAMISC("TECHCOMM"))
 . S RARC=$$UPDEXMAL^RAMAGU05(RACASE,"C",TMP)
 . ;
 . ;--- Post-processing and notifications
 . S RARC=$$EDTPST^RAMAG06A(RACTION,RATRKCMB)  Q:RARC<0
 ;
 ;=== Error handling and cleanup
 D UNLOCKFM^RALOCK(.RALOCK)
 Q $S(RARC<0:RARC,1:0)
