RAMAG03D ;HCIOFO/SG - ORDERS/EXAMS API (REGISTR. UTILS) ; 5/27/08 1:31pm
 ;;5.0;Radiology/Nuclear Medicine;**90**;Mar 16, 1998;Build 20
 ;
 Q
 ;
 ;***** GENERATES NEW CASE NUMBER
 ;
 ; RADTE         Date of the exam (FileMan)
 ;
 ; [RATYPE]      IEN of the imaging type (file #79.2).
 ;
 ;               Currently, the Radiology package always uses
 ;               IEN of the "GENERAL RADIOLOGY" record. This API
 ;               does the same if the RATYPE parameter is not
 ;               defined or not greater than 0.
 ;
 ; Return Values:
 ;       <0  Error descriptor (see $$ERROR^RAERR)
 ;       >0  Case number (1-99999)
 ;
CASENUM(RADTE,RATYPE) ;
 N %H,%T,%Y,RADTE99,RAII,RAJ,RALOCK,RAX,RAXX,RC,TMP,X,X1,X2
 Q:$G(RADTE)'>0 $$IPVE^RAERR("RADTE")
 ;--- Get the default imaging type
 I $G(RATYPE)'>0  D  Q:'$D(^RA(79.2,RATYPE,0)) $$ERROR^RAERR(-36)
 . S RATYPE=+$O(^RA(79.2,"B","GENERAL RADIOLOGY",0))
 ;---
 K TMP  S TMP(79.2,RATYPE_",",25)=""  ; "CN" node
 S RC=$$LOCKFM^RALOCK(.TMP)
 Q:RC $$LOCKERR^RAERR(RC,"next case number")
 M RALOCK=TMP
 D
 . S X=$G(^RA(79.2,RATYPE,"CN"))
 . D:(DT>$P(X,U,2))!(X>99999) CAL^RAREG1
 . ;--- Double check that the number is not used
 . S RAX=+^RA(79.2,RATYPE,"CN")  D DUP^RAREG1
 . ;--- Recalculate if DUP returned a value bigger than 99999
 . I RAX>99999  D  I RAX>99999  S RAX=$$ERROR^RAERR(-37)  Q
 . . D CAL^RAREG1  S RAX=+^RA(79.2,RATYPE,"CN")  D DUP^RAREG1
 . ;--- Get the next free case number and store it
 . F RAJ=RAX+1:1  I '$D(^RADPT("AE",RAJ))  D  Q
 . . S $P(^RA(79.2,RATYPE,"CN"),U)=RAJ
 . ;--- If the next free case number for future use is
 . ;--- greater than 99999,then recalculate again
 . D:^RA(79.2,RATYPE,"CN")>99999 CAL^RAREG1
 D UNLOCKFM^RALOCK(.RALOCK)
 ;---
 Q RAX
 ;
 ;+++++ DOUBLE CHECKS AND LOCKS THE EXAM DATE/TIME
 ;
 ; RADFN         Patient IEN (DFN)
 ;
 ; .RADTE        Reference to a local variable that stores the date
 ;               of the exam (FileMan).
 ;
 ;               NOTE: The $$LOCKDT function can slightly change
 ;                     the exam date/time. The new value is returned
 ;                     in this parameter.
 ;
 ; [.RALOCK]     Reference to a local variable where identifiers
 ;               of the locked exam date/time node are added to.
 ;
 ; [FLAGS]       Flags that control the execution (can be combined).
 ;               See description of the flags "A" and "D" in the
 ;               source code of the ^RAMAG routine.
 ;
 ; Return values:
 ;       <0  Error descriptor (see $$ERROR^RAERR)
 ;        0  Success
 ;
LOCKDT(RADFN,RADTE,RALOCK,FLAGS) ;
 N EXAMSET,IENS,ORIGDATE,RADTI,RAI,RAIENS,RAMSG,RARC,RAROOT,TMP
 S ORIGDATE=RADTE\1,RADTI=$$INVDTE^RAMAGU04(RADTE)
 S RAIENS=","_RADFN_",",RAROOT=$$ROOT^DILFD(70.02,RAIENS,1)
 S FLAGS=$G(FLAGS),RARC=0
 ;
 ;=== Lock the whole REGISTERED EXAMS multiple
 K TMP  S TMP(70.02,RAIENS)=""
 S RARC=$$LOCKFM^RALOCK(.TMP)
 Q:RARC $$LOCKERR^RAERR(RARC,"patient's exams")
 M RALOCK=TMP
 ;
 D
 . ;--- Setup the error handler
 . N $ESTACK,$ETRAP  D SETDEFEH^RAERR("RARC")
 . ;--- Check if the patient already has exam(s) for this date/time
 . I '$D(@RAROOT@(RADTI))  S RARC=0  D  Q:RARC<0
 . . ;--- Check for a 'subset' date
 . . F RAI=1:1:10  D  Q:RARC
 . . . S TMP=$O(@RAROOT@("B",RADTE))
 . . . I TMP'[RADTE,$P(RADTE,".",2),'$D(@RAROOT@(RADTI))  S RARC=1  Q
 . . . ;--- Slightly modify the exam date/time
 . . . S RADTE=$$FMADD^XLFDT(RADTE,,,1)  ; Add 1 minute
 . . . S RADTI=$$INVDTE^RAMAGU04(RADTE)
 . . ;--- Too many registered exams at almost the same date/time
 . . S:'RARC RARC=$$ERROR^RAERR(-29)
 . E  I $TR(FLAGS,"AD")=FLAGS  D  Q
 . . ;--- By default, neither add to existing cases nor modify time
 . . S RARC=$$ERROR^RAERR(-28,,$$FMTE^XLFDT(RADTE))
 . E  S RARC=0  D  Q:RARC<0
 . . F  D  Q:RARC  Q:'$D(@RAROOT@(RADTI))
 . . . ;--- Check if the existing date/time record stores an exam set
 . . . S IENS=RADTI_RAIENS
 . . . S EXAMSET=+$$GET1^DIQ(70.02,IENS,5,"I",,"RAMSG")  ; EXAM SET
 . . . I $G(DIERR)  S RARC=$$DBS^RAERR("RAMSG",-9,70.02,IENS)  Q
 . . . I 'EXAMSET,FLAGS["A"  S RARC=1  Q
 . . . I EXAMSET,FLAGS'["D"  S RARC=$$ERROR^RAERR(-54)  Q
 . . . ;--- Never add a case to an exam set implicitly; modify the
 . . . ;    date/time of the new case instead. Also, check for
 . . . ;--- 'subset' dates. Make sure that the time part is there.
 . . . F  D  Q:(TMP'[RADTE)&$P(RADTE,".",2)
 . . . . ;--- Add 1 minute to the exam date/time
 . . . . S RADTE=$$FMADD^XLFDT(RADTE,,,1)  ; Add 1 minute
 . . . . S RADTI=$$INVDTE^RAMAGU04(RADTE)
 . . . . S TMP=$O(@RAROOT@("B",RADTE))
 . . . ;--- Check if the date is still the same
 . . . S:(RADTE\1)'=ORIGDATE RARC=$$ERROR^RAERR(-29)
 . ;--- Lock the date/time in the REGISTERED EXAMS multiple
 . K TMP  S TMP(70.02,RADTI_RAIENS)=""
 . S RARC=$$LOCKFM^RALOCK(.TMP)
 . I RARC  S RARC=$$LOCKERR^RAERR(RARC,"exam date/time")  Q
 . M RALOCK=TMP
 ;
 ;=== Unlock the REGISTERED EXAMS multiple
 D UNLOCKFM^RALOCK(70.02,RAIENS)
 K RALOCK(70.02,RAIENS)
 ;===
 Q $S(RARC<0:RARC,1:0)
 ;
 ;+++++ DISCARDS THE CHANGES IN CASE OF ERROR(S)
 ;
 ; RADFN         IEN of the patient
 ;
 ; RADTI         "Inverted" date/time of registered exam(s)
 ;
 ; Input variables:
 ;   ^TMP($J,"RAREG1",...)
 ;
ROLLBACK(RADFN,RADTI) ;
 N DA,DIK,RACASE,RAFDA,RAI,RAIENS,RAMSG,RAOIFN,RAOLST,TMP
 ;
 ;=== Delete incomplete exams
 S RAI=0
 F  S RAI=$O(^TMP($J,"RAREG1",RAI))  Q:RAI'>0  D
 . S RACASE=^TMP($J,"RAREG1",RAI)
 . S RAIENS=$$EXAMIENS^RAMAGU04(RACASE)
 . ;--- Delete the Nuclear Medicine data
 . K DA,DIK
 . S DA=$$GET1^DIQ(70.03,RAIENS,500,"I",,"RAMSG")
 . I DA>0  S DIK="^RADPTN("  D ^DIK
 . ;--- Delete the incomplete record
 . K DA,DIK
 . D DA^DILF(RAIENS,.DA)
 . S DIK=$$ROOT^DILFD(70.03,","_DA(1)_","_DA(2)_",")
 . D ^DIK
 . ;--- Restore order status to "pending"
 . S RAOIFN=+$P(RACASE,U,4)
 . I RAOIFN>0,'$D(RAOLST(RAOIFN))  S RAOLST(RAOIFN)=""  D
 . . S TMP=$$OSTRLBCK^RAMAGU02(RAOIFN,5)
 . ;--- Remove the reference from the list
 . K ^TMP($J,"RAREG1",RAI)
 ;
 ;=== Delete incomplete date/time record
 I RADFN>0,RADTI>0  D
 . ;--- Check if the EXAMINATIONS multiple is not empty
 . S TMP=$$ROOT^DILFD(70.03,","_RADTI_","_RADFN_",",1)
 . Q:$O(@TMP@(0))>0
 . ;--- Delete record from the REGISTERED EXAMS multiple
 . K DA,DIK
 . S DIK=$$ROOT^DILFD(70.02,","_RADFN_",")
 . S DA=RADTI,DA(1)=RADFN   D ^DIK
 ;
 ;===
 Q
