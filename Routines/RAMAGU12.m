RAMAGU12 ;HCIOFO/SG - ORDERS/EXAMS API (REPORT UTILS) ; 2/6/09 11:48am
 ;;5.0;Radiology/Nuclear Medicine;**90**;Mar 16, 1998;Build 20
 ;
 Q
 ;
 ;***** CREATES A REPORT STUB
 ;
 ; RACASE        Examination identifiers
 ;                 ^01: IEN of the patient in the file #70    (RADFN)
 ;                 ^02: IEN in the REGISTERED EXAMS multiple  (RADTI)
 ;                 ^03: IEN in the EXAMINATIONS multiple      (RACNI)
 ;
 ; [[.]RADTE]    Date of the exam. If this parameter is not defined,
 ;               the value is loaded from the case record.
 ;
 ; [[.]RACN]     Case number. If this parameter is not defined, the
 ;               value is loaded from the subfile #70.02.
 ;
 ; Return values:
 ;       <0  Error descriptor (see $$ERROR^RAERR)
 ;       >0  Report IEN in the RAD/NUC MED REPORTS file (#74)
 ;
RPTSTUB(RACASE,RADTE,RACN) ;
 N RABUF,RACNI,RADFN,RADTI,RAIENS,RAMSG,RARPT,TMP
 S RADFN=$P(RACASE,U),RADTI=$P(RACASE,U,2),RACNI=$P(RACASE,U,3)
 S RAIENS=$$EXAMIENS^RAMAGU04(RACASE)
 ;--- Get case properties
 S TMP=$S($G(RACN)'>0:".01;17",1:"17")
 D GETS^DIQ(70.03,RAIENS,TMP,"I","RABUF","RAMSG")
 Q:$G(DIERR) $$DBS^RAERR("RAMSG",-9,70.03,RAIENS)
 S RARPT=+$G(RABUF(70.03,RAIENS,17,"I"))
 Q:RARPT>0 RARPT  ;--- Report already exists
 S:$G(RACN)'>0 RACN=$G(RABUF(70.03,RAIENS,.01,"I"))
 ;--- Get the date if necessary
 I $G(RADTE)'>0  D  Q:$G(DIERR) $$DBS^RAERR("RAMSG",-9,70.02,TMP)
 . S TMP=$P(RAIENS,",",2,4)  ; Include trailing comma
 . S RADTE=$$GET1^DIQ(70.02,TMP,.01,"I",,"RAMSG")
 ;--- Create the stub
 D
 . N MAGSCN,RAFDA,RASULT,RAX
 . D CREATE^RARIC
 Q $S($G(RARPT)>0:+RARPT,1:$$ERROR^RAERR(-52))
 ;
 ;***** RETURNS REPORT STATUS
 ;
 ; RPTIEN        IEN of the report in RAD/NUC MED REPORTS file (#74)
 ;
 ; Return Values:
 ;       <0  Error descriptor (see $$ERROR^RAERR)
 ;       >0  Internal and external values of the REPORT STATUS
 ;           field (5) of the RAD/NUC MED REPORTS file (#74)
 ;           separated by "^".
 ;
RPTSTAT(RPTIEN) ;
 N IENS,RABUF,RAMSG
 S IENS=(+RPTIEN)_","
 D GETS^DIQ(74,IENS,"5","EI","RABUF","RAMSG")
 Q:$G(DIERR) $$DBS^RAERR("RAMSG",-9,74,IENS)
 Q $G(RABUF(74,IENS,5,"I"))_U_$G(RABUF(74,IENS,5,"E"))
 ;
 ;***** UPDATES THE REPORT ACTIVITY LOG
 ;
 ; RPTIEN        IEN of the report in RAD/NUC MED REPORTS file (#74)
 ;
 ; ACTION        Internal action value (see the TYPE OF ACTION
 ;               field (2) of the sub-file #74.01).
 ;
 ; [LOGDT]       Internal date value (FileMan) for the LOG DATE
 ;               field (.01) of the sub-file #74.01. If this
 ;               parameter is not defined or not greater than 0, 
 ;               then the current date/time is used.
 ;
 ; Return Values:
 ;       <0  Error descriptor (see $$ERROR^RAERR)
 ;       >0  IEN of the new activity sub-record in sub-file #74.01
 ;
UPDRPTAL(RPTIEN,ACTION,LOGDT) ;
 N IENS,LOGDT1,RAFDA,RAIENS,RALOCK,RAMSG,RARC,TMP
 S RARC=$$CHKREQ^RAUTL22("RPTIEN,ACTION")  Q:RARC<0 RARC
 S RPTIEN=+RPTIEN
 ;
 ;--- Check the date/time
 I $G(LOGDT)>0  D  Q:RARC<0 RARC
 . S TMP=+$E(LOGDT,1,12),LOGDT1=$$FMTE^XLFDT(TMP)
 . S:(LOGDT1=TMP)!(LOGDT1="") RARC=$$IPVE^RAERR("LOGDT")
 E  S LOGDT1="NOW"
 ;
 ;--- Prepare the data
 S IENS="+1,"_RPTIEN_","
 S RAFDA(74.01,IENS,.01)=LOGDT1     ; LOG DATE
 S RAFDA(74.01,IENS,2)=ACTION       ; TYPE OF ACTION
 S RAFDA(74.01,IENS,3)="`"_(+DUZ)   ; COMPUTER USER
 ;
 ;--- Lock the ACTIVITY LOG multiple
 K TMP  S TMP(74.01,","_RPTIEN_",")=""
 S RARC=$$LOCKFM^RALOCK(.TMP)
 Q:RARC $$LOCKERR^RAERR(RARC,"report activity log")
 M RALOCK=TMP
 ;
 D
 . N $ESTACK,$ETRAP
 . ;--- Setup the error processing
 . D SETDEFEH^RAERR("RARC")
 . ;--- Add the record
 . D UPDATE^DIE("E","RAFDA","RAIENS","RAMSG")
 . S:$G(DIERR) RARC=$$DBS^RAERR("RAMSG",-9,74.01,IENS)
 ;
 ;--- Error handling and cleanup
 D UNLOCKFM^RALOCK(.RALOCK)
 Q $S(RARC<0:RARC,1:+RAIENS(1))
 ;
 ;***** UPDATES THE REPORT STATUS
 ;
 ; RPTIEN        IEN of the report in RAD/NUC MED REPORTS file (#74)
 ;
 ; STATUS        Value for the REPORT STATUS field (5) of file #74
 ;
 ; [PROBSTAT]    Problem statement. If this parameter is defined and
 ;               not empty (spaces are not counted), then its value
 ;               is stored into the PROBLEM STATEMENT field (25) of
 ;               the file #74 and the status is automatically changed
 ;               to PROBLEM DRAFT.
 ;
 ; Return Values:
 ;       <0  Error descriptor (see $$ERROR^RAERR)
 ;        0  Success
 ;
UPDRPTST(RPTIEN,STATUS,PROBSTAT) ;
 N IENS,RAFDA,RALOCK,RAMSG,RARC,TMP
 S RARC=$$CHKREQ^RAUTL22("RPTIEN,STATUS")  Q:RARC<0 RARC
 S IENS=(+RPTIEN)_","
 ;
 ;--- Lock the report
 K TMP  S TMP(74,IENS)=""
 S RARC=$$LOCKFM^RALOCK(.TMP)
 Q:RARC $$LOCKERR^RAERR(RARC,"report")
 M RALOCK=TMP
 ;
 D
 . N $ESTACK,$ETRAP
 . ;--- Setup the error processing
 . D SETDEFEH^RAERR("RARC")
 . ;
 . ;--- Check the problem statement
 . S TMP=$$TRIM^XLFSTR($G(PROBSTAT))
 . S:TMP'="" STATUS="PD"
 . D VAL^DIE(74,IENS,25,"F",TMP,.TMP,"RAFDA","RAMSG")
 . I $G(DIERR)  S RARC=$$DBS^RAERR("RAMSG",-9)    Q
 . I TMP="^"    S RARC=$$IPVE^RAERR("PROBSTAT")  Q
 . ;
 . ;--- Check the new report status
 . D VAL^DIE(74,IENS,5,"F",STATUS,.TMP,"RAFDA","RAMSG")
 . I $G(DIERR)  S RARC=$$DBS^RAERR("RAMSG",-9)  Q
 . I TMP="^"    S RARC=$$IPVE^RAERR("STATUS")  Q
 . S STATUS=TMP
 . ;
 . ;--- Check if the report currently has the same status
 . S TMP=$$GET1^DIQ(74,IENS,5,"I",,"RAMSG")
 . I $G(DIERR)  S RARC=$$DBS^RAERR("RAMSG",-9,74,IENS)  Q
 . I TMP=STATUS  K RAFDA(74,IENS,5)  Q:$D(RAFDA)<10
 . ;
 . ;--- Update the record
 . D FILE^DIE(,"RAFDA","RAMSG")
 . S:$G(DIERR) RARC=$$DBS^RAERR("RAMSG",-9,74,IENS)
 ;
 ;--- Error handling and cleanup
 D UNLOCKFM^RALOCK(.RALOCK)
 Q $S(RARC<0:RARC,1:0)
