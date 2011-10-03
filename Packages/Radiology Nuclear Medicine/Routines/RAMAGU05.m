RAMAGU05 ;HCIOFO/SG - ORDERS/EXAMS API (EXAM UTILITIES) ; 5/27/08 2:16pm
 ;;5.0;Radiology/Nuclear Medicine;**90**;Mar 16, 1998;Build 20
 ;
 Q
 ;
 ;##### RETURNS EXAM STATUS
 ;
 ; RACASE        Examination identifiers
 ;                 ^01: IEN of the patient in the file #70    (RADFN)
 ;                 ^02: IEN in the REGISTERED EXAMS multiple  (RADTI)
 ;                 ^03: IEN in the EXAMINATIONS multiple      (RACNI)
 ;
 ; Return Values:
 ;       <0  Error descriptor (see $$ERROR^RAERR)
 ;       >0  Exam status descriptor (see the ^RAMAGU06)
 ;
EXMSTAT(RACASE) ;
 N IEN72,IENS,RABUF,RAMSG,RC
 S RC=$$CHKEXMID^RAMAGU04(RACASE)  Q:RC<0 RC
 ;--- Get the IEN of the status record
 S IENS=$$EXAMIENS^RAMAGU04(RACASE)
 S IEN72=$$GET1^DIQ(70.03,IENS,3,"I",,"RAMSG")
 Q:$G(DIERR) $$DBS^RAERR("RAMSG",-9,70.03,IENS)
 Q:IEN72'>0 $$ERROR^RAERR(-19,,70.03,IENS,3)
 ;--- Return the descriptor
 Q $$EXMSTINF^RAMAGU06(IEN72)
 ;
 ;***** UPDATES THE EXAM ACTIVITY LOG
 ;
 ; RACASE        Examination identifiers
 ;                 ^01: IEN of the patient in the file #70    (RADFN)
 ;                 ^02: IEN in the REGISTERED EXAMS multiple  (RADTI)
 ;                 ^03: IEN in the EXAMINATIONS multiple      (RACNI)
 ;
 ; ACTION        Internal action value (see the TYPE OF ACTION
 ;               field (2) of the sub-file #70.07).
 ;
 ; [COMMENT]     Optional value for the TECHNOLOGIST COMMENT
 ;               field (4) of the sub-file #70.7.
 ;
 ; [LOGDT]       Internal date value (FileMan) for the LOG DATE
 ;               field (.01) of the sub-file #70.07. If this
 ;               parameter is not defined or not greater than 0, 
 ;               then the current date/time is used.
 ;
 ; Return Values:
 ;       <0  Error descriptor (see $$ERROR^RAERR)
 ;       >0  IEN of the new activity sub-record in sub-file #70.07
 ;
UPDEXMAL(RACASE,ACTION,COMMENT,LOGDT) ;
 N IENS,IENS7003,LOGDT1,RAFDA,RAIENS,RALOCK,RAMSG,RARC,TMP
 S RARC=$$CHKREQ^RAUTL22("RACASE,ACTION")  Q:RARC<0 RARC
 S RARC=$$CHKEXMID^RAMAGU04(RACASE)         Q:RARC<0 RARC
 S IENS7003=$$EXAMIENS^RAMAGU04(RACASE)
 ;
 ;--- Check the date/time
 I $G(LOGDT)>0  D  Q:RARC<0 RARC
 . S TMP=+$E(LOGDT,1,12),LOGDT1=$$FMTE^XLFDT(TMP)
 . S:(LOGDT1=TMP)!(LOGDT1="") RARC=$$IPVE^RAERR("LOGDT")
 E  S LOGDT1="NOW"
 ;
 ;--- Prepare the data
 S IENS="+1,"_IENS7003
 S RAFDA(70.07,IENS,.01)=LOGDT1     ; LOG DATE
 S RAFDA(70.07,IENS,2)=ACTION       ; TYPE OF ACTION
 S RAFDA(70.07,IENS,3)="`"_(+DUZ)   ; COMPUTER USER
 S RAFDA(70.07,IENS,4)=$G(COMMENT)  ; TECHNOLOGIST COMMENT
 ;
 ;--- Lock the ACTIVITY LOG multiple
 K TMP  S TMP(70.07,","_IENS7003)=""
 S RARC=$$LOCKFM^RALOCK(.TMP)
 Q:RARC $$LOCKERR^RAERR(RARC,"exam activity log")
 M RALOCK=TMP
 ;
 D
 . N $ESTACK,$ETRAP
 . ;--- Setup the error processing
 . D SETDEFEH^RAERR("RARC")
 . ;--- Add the record
 . D UPDATE^DIE("E","RAFDA","RAIENS","RAMSG")
 . S:$G(DIERR) RARC=$$DBS^RAERR("RAMSG",-9,70.07,IENS)
 ;
 ;--- Error handling and cleanup
 D UNLOCKFM^RALOCK(.RALOCK)
 Q $S(RARC<0:RARC,1:+RAIENS(1))
 ;
 ;***** UPDATES THE EXAM STATUS
 ;
 ; RACASE        Examination identifiers
 ;                 ^01: IEN of the patient in the file #70    (RADFN)
 ;                 ^02: IEN in the REGISTERED EXAMS multiple  (RADTI)
 ;                 ^03: IEN in the EXAMINATIONS multiple      (RACNI)
 ;
 ; RASTAT        Status identifier(s) in the format of the exam
 ;               status descriptor (see the ^RAMAGU06 for details).
 ;
 ;               NOTE: Imaging type required to find appropriate
 ;                     status record is extracted from the TYPE OF
 ;                     IMAGING field (2) of the sub-file #70.02.
 ;
 ; [RAFLAGS]     Flags that control the execution (can be combined):
 ;
 ;                 F  Force the new status even if not all required
 ;                    conditions (see $$EXMSTREQ^RAMAGU06) are met.
 ;
 ; [REASON]      Cancellation reason: either IEN of a record of
 ;               the RAD/NUC MED REASON file (#75.2) or a valid
 ;               synonym (see SYNONYM field (3) of that file).
 ;
 ;               This parameter is required if RASTAT=0.
 ;
 ;               The referenced record must have the appropriate
 ;               type of reason (see TYPE OF REASON field (2) of
 ;               the file #75.2): CANCEL REQUEST (1) or GENERAL
 ;               REQUEST (9).
 ;
 ; Return Values:
 ;       <0  Error descriptor (see $$ERROR^RAERR)
 ;        0  Exam already has the requested status
 ;       >0  IEN of the new record in the sub-file #70.05
 ;
UPDEXMST(RACASE,RASTAT,RAFLAGS,REASON) ;
 N IENS,IENS7003,RAAFTER,RABEFORE,RABUF,RAFDA,RAIENS,RALOCK,RAMSG,RANODE,RARC,TMP
 S RARC=$$CHKREQ^RAUTL22("RACASE,RASTAT")  Q:RARC<0 RARC
 S RARC=$$CHKEXMID^RAMAGU04(RACASE)        Q:RARC<0 RARC
 S IENS7003=$$EXAMIENS^RAMAGU04(RACASE)
 S RAFLAGS=$G(RAFLAGS)
 ;
 ;=== If status order number is provided, it must be valid
 S TMP=$P(RASTAT,U,3)
 I TMP'="",(+TMP'=TMP)!(TMP<0)!(TMP>9)  D  Q RARC
 . S RARC=$$IPVE^RAERR("RASTAT")
 ;
 ;=== Validate the new exam status and get its descriptor
 I RASTAT'>0  D
 . S IENS=$P(IENS7003,",",2,99)
 . S TMP=$$GET1^DIQ(70.02,IENS,2,"I",,"RAMSG")  ; TYPE OF IMAGING
 . I $G(DIERR)  S RASTAT=$$DBS^RAERR("RAMSG",-9,70.02,IENS)  Q
 . I TMP'>0  S RASTAT=$$ERROR^RAERR(-19,,70.02,IENS,2)  Q
 . S RASTAT=$$EXMSTINF^RAMAGU06(RASTAT,TMP)
 E  S RASTAT=$$EXMSTINF^RAMAGU06(RASTAT)
 Q:RASTAT<0 RASTAT
 ;
 ;=== Check the cancelation reason
 I $P(RASTAT,U,3)=0  D  Q:RARC<0 RARC
 . N RTYPE
 . ;--- Check if it has a value
 . I $G(REASON)=""  S RARC=$$ERROR^RAERR(-8,,"REASON")  Q
 . ;--- Find the IEN of the synonym
 . S RARC=$$RARSNIEN^RAMAGU13(REASON,.RTYPE)  Q:RARC<0
 . S REASON="`"_(+RARC)  ; Pseudo-external value
 . ;--- Check the type of reason
 . S TMP=+RTYPE
 . I TMP'=1,TMP'=9  D  Q
 . . S RARC=$$ERROR^RAERR(-16,,$P(RTYPE,U,2),$P(RASTAT,U,2))
 E  S REASON=""
 ;
 ;=== Lock the exam
 K TMP  S TMP(70.03,IENS7003)=""
 S RARC=$$LOCKFM^RALOCK(.TMP)
 Q:RARC $$LOCKERR^RAERR(RARC,"examination")
 M RALOCK=TMP
 ;
 D
 . N $ESTACK,$ETRAP,RAOVER,ZTQUEUED
 . S ZTQUEUED=1  ; Silence EXAM STATUS input transform (^RASTREQ)
 . ;=== Setup the error processing
 . D SETDEFEH^RAERR("RARC")
 . ;
 . ;=== Check if the exam currently has the same status
 . S TMP=$$GET1^DIQ(70.03,IENS7003,3,"I",,"RAMSG")
 . I $G(DIERR)  S RARC=$$DBS^RAERR("RAMSG",-9,70.03,IENS7003)  Q
 . Q:+RASTAT=TMP
 . ;
 . ;=== Execute the input transform and the ^RASTREQ routine
 . I RAFLAGS'["F"  D  Q:RARC<0
 . . D VAL^DIE(70.03,IENS7003,3,,"`"_(+RASTAT),.TMP,,"RAMSG")
 . . I TMP="^"  S RARC=$$IPVE^RAERR("RASTAT")  Q
 . . Q:$G(RAAFTER)=$P(RASTAT,U,3)
 . . S RARC=$$ERROR^RAERR(-31,"RACASE='"_RACASE_"'",$P(RASTAT,U,2))
 . ;
 . ;=== Prepare the data
 . S IENS=IENS7003
 . S RAFDA(70.03,IENS,3)="`"_(+RASTAT)  ; EXAM STATUS
 . S RAFDA(70.03,IENS,3.5)=REASON       ; REASON FOR CANCELLATION
 . S IENS="+1,"_IENS7003
 . S RAFDA(70.05,IENS,.01)="NOW"        ; STATUS CHANGE DATE/TIME
 . S RAFDA(70.05,IENS,2)="`"_(+RASTAT)  ; NEW STATUS
 . S RAFDA(70.05,IENS,3)="`"_(+DUZ)     ; COMPUTER USER
 . ;
 . ;=== Update the record
 . D UPDATE^DIE("E","RAFDA","RAIENS","RAMSG")
 . S:$G(DIERR) RARC=$$DBS^RAERR("RAMSG",-9,70.05,IENS)
 ;
 ;=== Error handling and cleanup
 D UNLOCKFM^RALOCK(.RALOCK)
 Q $S(RARC<0:RARC,1:+$G(RAIENS(1)))
