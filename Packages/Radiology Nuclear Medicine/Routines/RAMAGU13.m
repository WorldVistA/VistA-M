RAMAGU13 ;HCIOFO/SG - ORDERS/EXAMS API (MISC UTILITIES) ; 2/10/09 4:11pm
 ;;5.0;Radiology/Nuclear Medicine;**90**;Mar 16, 1998;Build 20
 ;
 Q
 ;
 ;***** CREATES A STUB IN THE NUC MED EXAM DATA FILE (#70.2)
 ;
 ; RACASE        Examination identifiers
 ;                 ^01: IEN of the patient in the file #70    (RADFN)
 ;                 ^02: IEN in the REGISTERED EXAMS multiple  (RADTI)
 ;                 ^03: IEN in the EXAMINATIONS multiple      (RACNI)
 ;
 ; [RAPROCIEN]   IEN of the Radiology procedure. By default
 ;               ($G(RAPROCIEN)'>0), it is loaded from the exam
 ;               record.
 ;
 ; [RADTE]       Exam date. By default ($G(RADTE)'>0), it is
 ;               loaded from the date/time record of the exam.
 ;
 ; [RACN]        Case number. By default ($G(RACN)'>0), it is
 ;               loaded from the exam record.
 ;
 ; Return Values:
 ;       <0  Error descriptor (see $$ERROR^RAERR)
 ;        0  The record is not needed
 ;       >0  IEN of the record of the NUC MED EXAM DATA file (#70.2)
 ;
NMEDSTUB(RACASE,RAPROCIEN,RADTE,RACN) ;
 N IENS,RABUF,RAFDA,RAIENLST,RAIENS,RAMSG,RANMDIEN,RARC,TMP
 S RARC=0,RAIENS=$$EXAMIENS^RAMAGU04(RACASE)
 ;
 ;=== Check parameter values and load default ones if necessary
 S TMP="500"                      ; NUCLEAR MED DATA
 S:$G(RACN)'>0 TMP=TMP_";.01"     ; CASE NUMBER
 S:$G(RAPROCIEN)'>0 TMP=TMP_";2"  ; PROCEDURE
 D GETS^DIQ(70.03,RAIENS,TMP,"I","RABUF","RAMSG")
 Q:$G(DIERR) $$DBS^RAERR("RAMSG",-9,70.03,RAIENS)
 S:$G(RACN)'>0 RACN=$G(RABUF(70.03,RAIENS,.01,"I"))
 S:$G(RAPROCIEN)'>0 RAPROCIEN=$G(RABUF(70.03,RAIENS,2,"I"))
 S RANMDIEN=+$G(RABUF(70.03,RAIENS,500,"I"))
 ;--- Return IEN of the nuclear medicine record if it exists already
 I RANMDIEN>0  Q:$D(^RADPTN(RANMDIEN)) RANMDIEN
 ;--- Exam date/time
 I $G(RADTE)'>0  D  Q:$G(DIERR) $$DBS^RAERR("RAMSG",-9,70.02,IENS)
 . S IENS=$P(RAIENS,",",2,4)  ; Keep the trailing comma
 . S RADTE=$$GET1^DIQ(70.02,IENS,.01,"I",,"RAMSG")
 ;
 ;=== Check if the nuclear medicine record is needed
 S IENS=+RAPROCIEN_","
 ;--- Check the value of the RADIOPHARMACEUTICALS USED?
 ;--- field of the IMAGING TYPE file (#79.2)
 S TMP=$$GET1^DIQ(71,IENS,"#12:#5","I",,"RAMSG")
 Q:$G(DIERR) $$DBS^RAERR("RAMSG",-9,71,IENS)
 Q:TMP'="Y" 0
 ;--- Check the value of the SUPPRESS RADIOPHARM PROMPT
 ;--- field of the RAD/NUC MED PROCEDURES file (#71)
 S TMP=$$GET1^DIQ(71,IENS,2,"I",,"RAMSG")
 Q:$G(DIERR) $$DBS^RAERR("RAMSG",-9,71,IENS)
 Q:TMP 0
 ;
 ;=== Create the stub record
 S IENS="+1,"
 S RAFDA(70.2,IENS,.01)=$P(RACASE,U)
 S RAFDA(70.2,IENS,2)=RADTE
 S RAFDA(70.2,IENS,3)=RACN
 D UPDATE^DIE(,"RAFDA","RAIENLST","RAMSG")
 Q:$G(DIERR) $$DBS^RAERR("RAMSG",-9,70.2,IENS)
 S RANMDIEN=+RAIENLST(1)
 ;
 ;=== Store the pointer
 D
 . ;--- Setup the error handler
 . N $ESTACK,$ETRAP  D SETDEFEH^RAERR("RARC")
 . ;--- Update the exam record
 . S RAFDA(70.03,RAIENS,500)=RANMDIEN
 . D FILE^DIE(,"RAFDA","RAMSG")
 . S:$G(DIERR) RARC=$$DBS^RAERR("RAMSG",-9,70.03,RAIENS)
 ;--- Remove the stray record if the pointer cannot be stored
 I RARC<0  D  Q RARC
 . N DA,DIK  S DIK="^RADPTN(",DA=RANMDIEN  D ^DIK
 ;
 ;=== Success
 Q RANMDIEN
 ;
 ;***** SEARCHES FOR THE RAD/NUC MED REASON SYNONYM
 ;
 ; REASON        Either IEN of a record of the RAD/NUC MED REASON
 ;               file (#75.2) or a valid synonym (see SYNONYM field
 ;               (3) of that file).
 ;
 ; [.TYPE]       Reference to a local variable where internal and
 ;               external values (separated by "^") of the TYPE OF
 ;               REASON field (2) of the file #75.2 are returned to.
 ;
 ; Return Values:
 ;       <0  Error descriptor (see $$ERROR^RAERR)
 ;       >0  IEN of the record in the file #75.2
 ;
RARSNIEN(REASON,TYPE) ;
 N IENS,RABUF,RAMSG,RC,TMP
 S TYPE="",RC=$$CHKREQ^RAUTL22("REASON")  Q:RC<0 RC
 ;---
 I (+REASON)'=REASON  D  ;--- Synonym of the reason
 . ;--- Find the reason
 . D FIND^DIC(75.2,,"@;2IE",,REASON,2,"S",,,"RABUF","RAMSG")
 . I $G(DIERR)  S RC=$$DBS^RAERR("RAMSG",-9,75.2)  Q
 . S TMP=+$G(RABUF("DILIST",0))
 . ;--- No such synonym on file
 . I TMP<1  S RC=$$ERROR^RAERR(-33,,"synonym",75.2)  Q
 . ;--- Ambiguous synonym
 . I TMP>1  S RC=$$ERROR^RAERR(-14,,"synonym",REASON)  Q
 . ;--- Reason IEN and type
 . S TYPE=$G(RABUF("DILIST","ID",1,2,"I"))
 . S TYPE=TYPE_U_$G(RABUF("DILIST","ID",1,2,"E"))
 . S REASON=+RABUF("DILIST",2,1)
 E  D                    ;--- Reason IEN
 . S IENS=REASON_","
 . D GETS^DIQ(75.2,IENS,"2","EI","RABUF","RAMSG")
 . I $G(DIERR)  S RC=$$DBS^RAERR("RAMSG",-9,75.2,IENS)  Q
 . S TYPE=$G(RABUF(75.2,IENS,2,"I"))_U_$G(RABUF(75.2,IENS,2,"E"))
 ;---
 Q $S(RC<0:RC,1:REASON)
 ;
 ;***** UPDATES VALUES OF THE MULTIPLE(S)
 ;
 ; .RAFDAM       Reference to a local variable that stores field
 ;               values prepared for storage (FileMan FDA array)
 ;
 ; RAIENS        IENS of the main record that multiple values in
 ;               the RAFDAM belong to
 ;
 ; [RAFLAGS]     Flags for UPDATE^DIE
 ;
 ; Return values:
 ;       <0  Error descriptor (see $$ERROR^RAERR)
 ;        0  Success
 ;
UPDMULT(RAFDAM,RAIENS,RAFLAGS) ;
 N DA,DIK,ERR,IENS,RAFDA,RAMSG,RANODE,RARC,RASUBF
 S (RARC,RASUBF)=0,RAFLAGS=$G(RAFLAGS)
 F  S RASUBF=$O(RAFDAM(RASUBF))  Q:RASUBF'>0  D  Q:RARC<0
 . K RAFDA,RAMSG  M RAFDA(RASUBF)=RAFDAM(RASUBF)
 . S IENS=","_RAIENS  D DA^DILF(IENS,.DA)
 . S DIK=$$ROOT^DILFD(RASUBF,IENS,0,.ERR)
 . I $G(ERR)!(DIK="")  S RARC=$$ERROR^RAERR(-50,,RASUBF,IENS)  Q
 . S RANODE=$$CREF^DILF(DIK)
 . ;--- Delete the old data
 . D IXALL2^DIK  ; Delete entries from cross-references
 . K @RANODE     ; Clear the whole multiple
 . ;--- Store the new data
 . I $D(RAFDA)>1  D  Q:RARC<0
 . . D UPDATE^DIE(RAFLAGS,"RAFDA",,"RAMSG")
 . . S:$G(DIERR) RARC=$$DBS^RAERR("RAMSG",-9,RASUBF,"*,"_RAIENS)
 . ;--- Remove subfile data from the source FDA
 . K:RAFLAGS'["S" RAFDAM(RASUBF)
 ;---
 Q $S(RARC<0:RARC,1:0)
 ;
 ;***** CHECKS IF THE LONG ACCESSION NUMBER SHOULD BE USED
 ;
 ; RAMDIV        Radiology division IEN (file #79)
 ;
 ; Return values:
 ;        0  Use short accession number (MMDDYY-NNNNN)
 ;        1  Use long accession number (SSS-MMDDYY-NNNNN)
 ;
USLNGACN(RAMDIV) ;
 Q:RAMDIV'>0 0
 N RAMSG
 ;--- Check the value of the USE SITE ACCESSION NUMBER? field (.131)
 ;    of the RAD/NUC MED DIVISION file (#79). This field is exported
 ;--- by the patch RA*5*47. See the data dictionary for details.
 Q ($$GET1^DIQ(79,RAMDIV_",",.131,"I",,"RAMSG")="Y")
