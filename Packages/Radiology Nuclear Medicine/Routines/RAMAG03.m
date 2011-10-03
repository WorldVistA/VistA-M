RAMAG03 ;HCIOFO/SG - ORDERS/EXAMS API (EXAM REGISTRATION) ; 2/10/09 4:14pm
 ;;5.0;Radiology/Nuclear Medicine;**90**;Mar 16, 1998;Build 20
 ;
 Q
 ;
 ;##### REGISTERS THE EXAM(S)
 ;
 ; .RAPARAMS       Reference to the API descriptor
 ;                 (see the ^RA01 routine for details)
 ;
 ; .RAEXAMS(       Reference to a local array where identifiers of
 ;                 registered examination(s) are returned to.
 ;
 ;   Seq#)         Exam/case identifiers:
 ;                   ^01: IEN of the patient in the file #70   (RADFN)
 ;                   ^02: IEN in the REGISTERED EXAMS multiple (RADTI)
 ;                   ^03: IEN in the EXAMINATIONS multiple     (RACNI)
 ;                   ^04: Case number
 ;                   ^05: Accession number.
 ;                          SSS-MMDDYY-NNNNN  if RA*5*47 is installed;
 ;                              MMDDYY-NNNNN  otherwise.
 ;                   ^06: Actual date/time of the case (FileMan)
 ;
 ; RAOIFN          IEN of the order in the file #75.1
 ;
 ; RADTE           Date/time of the exam (FileMan). If seconds are
 ;                 provided, they are ignored. The date must be exact 
 ;                 and the time is required.
 ;
 ; .RAMISC         Reference to a local array containing miscellaneous
 ;                 request parameters.
 ;
 ;                 See the ^RAMAG routine for additional important
 ;                 details regarding this parameter.
 ;
 ; RAMISC(
 ;
 ;   "BEDSECT")    IEN of the bedsection in the SPECIALTY
 ;                 file (#42.4).
 ;                 Required: No (used for inpatient category only)
 ;                 Default:  Bedsection on exam date
 ;
 ;   "EXAMCAT")    Exam category: value for the CATEGORY OF EXAM field
 ;                 (4) of the EXAMINATIONS multiple (sub-file #70.03).
 ;                 Required: Yes
 ;                 Default:  Exam category from the order
 ;
 ;   "FLAGS")      Flags that control the execution (see the ^RAMAG
 ;                 routine for details). Supported flags: "A" and "D".
 ;                 Required: No
 ;                 Default:  undefined
 ;
 ;   "PRINCLIN")   IEN of the principal clinic in the HOSPITAL
 ;                 LOCATION file (#44).
 ;                 Required: Yes (for non-inpatient categories only)
 ;                 Default:  Requesting location if it is a clinic
 ;
 ;   "RAPROC",
 ;     Seq#)       Radiology procedure and modifiers
 ;                   ^01: Procedure IEN in file #71
 ;                   ^02: Optional procedure modifiers (IENs in
 ;                   ...  the PROCEDURE MODIFIERS file (#71.2))
 ;                   ^nn:
 ;                 Required: Yes
 ;                 Default:  Procedure and modifiers from the order
 ;
 ;   "SERVICE")    IEN of the service in the SERVICE/SECTION
 ;                 file (#49).
 ;                 Required: No (used for inpatient category only)
 ;                 Default:  Service section on exam date
 ;
 ;   "SINGLERPT")  If this parameter is defined and not 0, then all
 ;                 cases should be associated with the same order
 ;                 and they will share the same report. See the
 ;                 MEMBER OF SET (25) and IMAGING ORDER (11) fields
 ;                 of the sub-file #70.03 for more details.
 ;                 Required: No
 ;                 Default:  If the order references a parent
 ;                           procedure that requires a single report
 ;                           (see the SINGLE REPORT field (18) of the 
 ;                           file #71), then a non-zero value is
 ;                           assigned to this parameter. Otherwise,
 ;                           it is undefined.
 ;
 ;                 NOTE: If a parent procedure is being registered,
 ;                       the default value cannot be overridden.
 ;
 ;   "TECHCOMM")   Technologist comment
 ;                 Required: No
 ;                 Default:  undefined
 ;
 ;   "WARD")       IEN of the ward in the WARD LOCATION file (#42).
 ;                 Required: No (used for inpatient category only)
 ;                 Default:  Ward location on exam date
 ;
 ; This function uses the ^TMP($J,"RAREG1") global node.
 ;
 ; ^TMP($J,
 ;   "RAREG1",i)   Exam identifiers
 ;                   ^01: IEN of the patient in the file #70
 ;                   ^02: IEN in the REGISTERED EXAMS multiple
 ;                   ^03: IEN in the EXAMINATIONS multiple
 ;
 ; Return values:
 ;       <0  Error descriptor (see $$ERROR^RAERR)
 ;       >0  Number of registered examinations
 ;           (number of elements in the RAEXAMS array)
 ;
REGISTER(RAPARAMS,RAEXAMS,RAOIFN,RADTE,RAMISC) ;
 N RADFN           ; IEN of the patient in the file #70
 N RADTI           ; "Inverted" date/time of registered exam(s)
 N RAEXMVAL        ; Exam parameters extracted from the order
 N RASACN31        ; Use the new site accession number
 N RAIMGTYI        ; Imaging type IEN (file #79.2)
 N RAMDIV          ; Radiology division IEN (file #79)
 N RAMLC           ; Imaging location IEN (file #79.1)
 N RAPARENT        ; Indicator of an exam set
 N RAPRLST         ; List of detailed/series procedures
 ;
 N HLA,RAEXMCNT,RAFLAGS,RALOCK,RARC,TMP
 D:$G(RAPARAMS("DEBUG"))>1
 . D W^RAMAGU11("$$REGISTER^RAMAG03","!!")
 . D VARS^RAMAGU11("RAOIFN,RADTE")
 . D ZW^RAUTL22("RAMISC")
 K RAEXAMS,^TMP($J,"RAREG1")
 S (RAEXMCNT,RARC)=0
 ;
 D
 . ;=== Setup the error handler
 . N $ESTACK,$ETRAP  D SETDEFEH^RAERR("RARC")
 . ;
 . ;=== Validate parameters
 . S RARC=$$VALIDATE^RAMAG03A(.RALOCK)  Q:RARC<0
 . S RAFLAGS=$$TRFLAGS^RAUTL22($G(RAMISC("FLAGS")),"AD","AD")
 . S RASACN31=$$USLNGACN^RAMAGU13($G(RAMDIV))
 . ;
 . ;=== Lock the exam date/time node and double check parameters
 . S RARC=$$LOCKDT^RAMAG03D(RADFN,.RADTE,.RALOCK,RAFLAGS)  Q:RARC<0
 . S RADTI=$$INVDTE^RAMAGU04(RADTE)
 . ;
 . ;=== Register the exam(s)
 . S RARC=$$EXAM^RAMAG03C()  Q:RARC<0
 . ;
 . ;=== Update order status and send OE v3.0 message
 . D:$D(^TMP($J,"RAREG1"))>1
 . . N RAOSTS,RAPROC  D UOSM^RAREG2
 . ;
 . ;=== Additional post-processing
 . S TMP=$$POSTPROC^RAMAG03C(.RAEXAMS,RADTE)
 . S:TMP'<0 RAEXMCNT=+TMP
 ;
 ;=== Error handling and cleanup
 D:RARC<0 ROLLBACK^RAMAG03D($G(RADFN),$G(RADTI))
 ;--- Unlock the global nodes
 D UNLOCKFM^RALOCK(.RALOCK)
 ;--- Cleanup
 K ^TMP($J,"RAREG1")
 Q $S(RARC<0:RARC,1:RAEXMCNT)
