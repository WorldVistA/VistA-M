RAMAGU04 ;HCIOFO/SG - ORDERS/EXAMS API (EXAM UTILITIES) ; 8/18/08 10:16am
 ;;5.0;Radiology/Nuclear Medicine;**90**;Mar 16, 1998;Build 20
 ;
 Q
 ;
 ;***** CONSTRUCTS THE SITE ACCESSION NUMBER
 ;
 ; RADTE         Exam date   (.01 field of the sub-file #70.02)
 ;
 ; RACN          Case number (.01 field of the sub-file #70.03)
 ;
 ; [FLAGS]       Flags that control the execution (can be combined):
 ;
 ;                 S  Return the short accession number: MMDDYY-NNNNN.
 ;                    By default, the long version (SSS-MMDDYY-NNNNN)
 ;                    is returned.
 ;
ACCNUM(RADTE,RACN,FLAGS) ;
 N RAD  S RAD=$E(RADTE,4,7)_$E(RADTE,2,3)_"-"_(+RACN)  ; mmddyy-case#
 Q:$G(FLAGS)["S" RAD
 Q $E($P($$NS^XUAF4($$KSP^XUPARAM("INST")),U,2),1,3)_"-"_RAD
 ;
 ;***** CHECKS EXAMINATION IDENTIFIERS
 ;
 ; RACASE        Examination identifiers
 ;                 ^01: IEN of the patient in the file #70    (RADFN)
 ;                 ^02: IEN in the REGISTERED EXAMS multiple  (RADTI)
 ;                 ^03: IEN in the EXAMINATIONS multiple      (RACNI)
 ;
 ; [RAPRMNM]     Parameter name inserted into the error message.
 ;               By default ($G(RAPRMNM)=""), "RACASE" is assumed.
 ;
 ; Return Values:
 ;       <0  Error descriptor (see $$ERROR^RAERR)
 ;        0  Success
 ;
CHKEXMID(RACASE,RAPRMNM) ;
 N NODE,RC
 S:$G(RAPRMNM)="" RAPRMNM="RACASE"
 ;--- Check the IDs
 S RC=(RACASE'>0)!($P(RACASE,U,2)'>0)!($P(RACASE,U,3)'>0)
 Q:RC $$ERROR^RAERR(-3,RAPRMNM_"='"_RACASE_"'",RAPRMNM)
 ;--- Check if the case exists
 S NODE=$$ROOT^DILFD(70.03,","_$P(RACASE,U,2)_","_$P(RACASE,U)_",",1)
 Q:'$D(@NODE@($P(RACASE,U,3),0)) $$ERROR^RAERR(-25,,RAPRMNM)
 ;--- Success
 Q 0
 ;
 ;***** CONSTRUCTS THE DAY-CASE EXAM IDENTIFIER
 ;
 ; RADTE         Exam date   (.01 field of the sub-file #70.02)
 ;
 ; RACN          Case number (.01 field of the sub-file #70.03)
 ;
 ; Return Values:
 ;           MMDDYY-Case#
 ;
DAYCASE(RADTE,RACN) ;
 Q $E(+RADTE,4,7)_$E(+RADTE,2,3)_"-"_(+RACN)
 ;
 ;***** CONVERTS EXAM IDENTIFIERS INTO THE EXAM IENS
 ;
 ; RACASE        Examination identifiers
 ;                 ^01: IEN of the patient in the file #70    (RADFN)
 ;                 ^02: IEN in the REGISTERED EXAMS multiple  (RADTI)
 ;                 ^03: IEN in the EXAMINATIONS multiple      (RACNI)
 ;
EXAMIENS(RACASE) ;
 Q $P(RACASE,U,3)_","_$P(RACASE,U,2)_","_$P(RACASE,U)_","
 ;
 ;***** RETURNS THE EXAM GLOBAL NODE
 ;
 ; RACASE        Examination identifiers
 ;                 ^01: IEN of the patient in the file #70    (RADFN)
 ;                 ^02: IEN in the REGISTERED EXAMS multiple  (RADTI)
 ;                 ^03: IEN in the EXAMINATIONS multiple      (RACNI)
 ;
EXAMNODE(RACASE) ;
 N IENS,NODE
 S IENS=$$EXAMIENS(RACASE),$P(IENS,",")=""
 S NODE=$$ROOT^DILFD(70.03,IENS,1)
 Q $NA(@NODE@($P(RACASE,U,3)))
 ;
 ;***** LOADS EXAM PROPERTIES AND INITIALIZES VARIABLES
 ;
 ; RAIENS        IENS of the exam record in the EXAMINATIONS multiple
 ;               (50) of the RAD/NUC MED PATIENT file (#70).
 ;
 ; Output variables:
 ;   RACN, RADTE, RAIMGTYI
 ;
 ; Return Values:
 ;       <0  Error descriptor (see $$ERROR^RAERR)
 ;        0  Ok
 ;
EXAMVARS(RAIENS) ;
 N IENS,RABUF,RAMSG
 ;=== Data from the REGISTERED EXAMS multiple
 S IENS=$P(RAIENS,",",2,4)
 D GETS^DIQ(70.02,IENS,".01;2","I","RABUF","RAMSG")
 Q:$G(DIERR) $$DBS^RAERR("RAMSG",-9,70.02,IENS)
 ;--- Exam date
 S RADTE=+$G(RABUF(70.02,IENS,.01,"I"))
 Q:RADTE'>0 $$ERROR^RAERR(-19,,70.02,IENS,.01)
 ;--- Imaging type IEN
 S RAIMGTYI=+$G(RABUF(70.02,IENS,2,"I"))
 Q:RAIMGTYI'>0 $$ERROR^RAERR(-19,,70.02,IENS,2)
 ;
 ;=== Data from the EXAMINATIONS multiple
 D GETS^DIQ(70.03,RAIENS,".01","I","RABUF","RAMSG")
 Q:$G(DIERR) $$DBS^RAERR("RAMSG",-9,70.03,RAIENS)
 ;--- Case number
 S RACN=$G(RABUF(70.03,RAIENS,.01,"I"))
 Q:RACN'>0 $$ERROR^RAERR(-19,,70.03,RAIENS,.01)
 ;
 ;=== Success
 Q 0
 ;
 ;***** RETURNS 'INVERTED' DATE/TIME
INVDTE(DTE) ;
 Q 9999999.9999-DTE
 ;
 ;***** REGISTERS THE PATIENT IN THE FILE #70 (IF NOT REGISTERED)
 ;
 ; DFN           Patient IEN (in file #2)
 ;
 ; [USLCAT]      Usual category (value of the USUAL CATEGORY (.04)
 ;               field of the RAD/NUC MED PATIENT file #70).
 ;               By default ($G(USLCAT)=""), "O" (outpatient) is
 ;               assumed.
 ;
 ; Return Values:
 ;       <0  Error descriptor (see $$ERROR^RAERR)
 ;       >0  IEN in the file #70 (the same as DFN)
 ;
RAPTREG(DFN,USLCAT) ;
 Q:$G(DFN)'>0 $$IPVE^RAERR("DFN")
 ;--- Check if the patient is already registered
 Q:$D(^RADPT(+DFN)) +DFN
 ;--- Register a new Radiology patient
 N IENS,RAFDA,RAIENS,RAMSG
 S IENS="+1,",RAIENS(1)=+DFN
 S RAFDA(70,IENS,.01)="`"_(+DFN)  ; NAME
 S RAFDA(70,IENS,.06)="`"_(+DUZ)  ; USER WHO ENTERED PATIENT
 S RAFDA(70,IENS,.04)=$S($G(USLCAT)'="":USLCAT,1:"O")
 D UPDATE^DIE("E","RAFDA","RAIENS","RAMSG")
 Q:$G(DIERR) $$DBS^RAERR("RAMSG",-9,70,IENS)
 ;--- Success
 Q RAIENS(1)
 ;
 ;***** UPDATES EXAM PROCEDURE AND MODIFIERS
 ; 
 ; RACASE          Exam/case identifiers
 ;                   ^01: IEN of the patient in the file #70   (RADFN)
 ;                   ^02: IEN in the REGISTERED EXAMS multiple (RADTI)
 ;                   ^03: IEN in the EXAMINATIONS multiple     (RACNI)
 ;
 ; RAPROC        Radiology procedure and modifiers
 ;                 ^01: Procedure IEN in file #71
 ;                 ^02: Optional procedure modifiers (IENs in
 ;                 ...  the PROCEDURE MODIFIERS file (#71.2))
 ;                 ^nn:
 ;
 ; Return values:
 ;       <0  Error descriptor (see $$ERROR^RAERR)
 ;        0  Ok
 ;
UPDEXMPR(RACASE,RAPROC) ;
 N DA,DIK,I,RAIENS,RANODE,RAFDA,RAMSG,TMP
 S RAIENS=$$EXAMIENS(RACASE)
 ;--- Prepare the new data for storage
 S RAFDA(70.03,RAIENS,2)=+RAPROC            ; Procedure
 F I=2:1  S TMP=$P(RAPROC,U,I)  Q:TMP=""  D:TMP>0
 . S RAFDA(70.1,"+"_I_","_RAIENS,.01)=+TMP  ; Modifiers
 ;--- Delete the old modifiers
 S TMP=","_RAIENS  D DA^DILF(TMP,.DA)
 S DIK=$$ROOT^DILFD(70.1,TMP),RANODE=$$CREF^DILF(DIK)
 D IXALL2^DIK  ; Delete entries from cross-references
 K @RANODE     ; Clear the whole multiple
 ;--- Store the new data
 D UPDATE^DIE(,"RAFDA",,"RAMSG")
 Q:$G(DIERR) $$DBS^RAERR("RAMSG",-9,70.03,RAIENS)
 ;---
 Q 0
