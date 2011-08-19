RAMAG03C ;HCIOFO/SG - ORDERS/EXAMS API (REGISTR. UTILS) ; 2/6/09 11:02am
 ;;5.0;Radiology/Nuclear Medicine;**90**;Mar 16, 1998;Build 20
 ;
 Q
 ;
 ;+++++ CREATES AN EXAM IN THE RAD/NUC MED PATIENT (#70)
 ;
 ; Input variables:
 ;   RADFN, RADTE, RADTI, RAEXMVAL, RAIMGTYI, RALOCK, RAMDIV,
 ;   RAMISC, RAMLC, RAOIFN, RAPARENT, RAPRLST, RASACN31
 ;
 ; Output variables:
 ;   ^TMP($J,"RAREG1",...), RALOCK
 ;
 ; Return values:
 ;       <0  Error descriptor (see $$ERROR^RAERR)
 ;        0  Success
 ;
 ; NOTE: This is an internal entry point. Do not call it from
 ;       routines other than the ^RAMAG03.
 ;
EXAM() ;
 Q:$D(RAPRLST)<10 0
 N IENS,RACN,RACASE,RACRM,RAFDA,RAIENS,RAIP,RAMOS,RAMSG,RAPROC,RARC,TMP
 K ^TMP($J,"RAREG1")  S RARC=0
 S RAMOS=$S('$G(RAPARENT):"",$G(RAMISC("SINGLERPT")):2,1:1)
 ;
 ;=== Create the date/time record if necessary
 S TMP=$$ROOT^DILFD(70.02,","_RADFN_",",1)
 I '$D(@TMP@(RADTI))  D  Q:RARC<0 RARC
 . S IENS="+1,"_RADFN_","
 . S RAFDA(70.02,IENS,.01)=RADTE         ; EXAM DATE
 . S RAFDA(70.02,IENS,2)=RAIMGTYI        ; TYPE OF IMAGING
 . S RAFDA(70.02,IENS,3)=RAMDIV          ; HOSPITAL DIVISION
 . S RAFDA(70.02,IENS,4)=+RAMLC          ; IMAGING LOCATION
 . S:$G(RAPARENT) RAFDA(70.02,IENS,5)=1  ; EXAM SET
 . S RAIENS(1)=RADTI
 . D UPDATE^DIE(,"RAFDA","RAIENS","RAMSG")
 . S:$G(DIERR) RARC=$$DBS^RAERR("RAMSG",-9,70.02,IENS)
 ;
 ;=== Get the credit method from the imaging location
 S RACRM=$$GET1^DIQ(79.1,+RAMLC_",",21,"I",,"RAMSG")
 Q:$G(DIERR) $$DBS^RAERR("RAMSG",-9,79.1,+RAMLC_",")
 ;
 ;=== Register individual case(s)
 S RAIP=0
 F  S RAIP=$O(RAPRLST(RAIP))  Q:RAIP'>0  D  Q:RARC<0
 . S RAPROC=RAPRLST(RAIP)  K RAFDA,RAIENS,RAMSG
 . ;--- Generate a case number
 . S RACN=$$CASENUM^RAMAG03D(RADTE)
 . I RACN<0  S RARC=RACN  Q
 . ;--- Prepare the data
 . S IENS="+1,"_RADTI_","_RADFN_","
 . S RAFDA(70.03,IENS,.01)=RACN                  ; CASE NUMBER
 . S RAFDA(70.03,IENS,2)=+RAPROC                 ; PROCEDURE
 . S RAFDA(70.03,IENS,4)=RAMISC("EXAMCAT")       ; CATEGORY OF EXAM
 . S RAFDA(70.03,IENS,6)=$G(RAMISC("WARD"))      ; WARD
 . S RAFDA(70.03,IENS,7)=$G(RAMISC("SERVICE"))   ; SERVICE
 . S RAFDA(70.03,IENS,8)=$G(RAMISC("PRINCLIN"))  ; PRINCIPAL CLINIC
 . S RAFDA(70.03,IENS,11)=RAOIFN                 ; IMAGING ORDER
 . S RAFDA(70.03,IENS,19)=$G(RAMISC("BEDSECT"))  ; BEDSECTION
 . S RAFDA(70.03,IENS,25)=RAMOS                  ; MEMBER OF SET
 . S RAFDA(70.03,IENS,26)=RACRM                  ; CREDIT METHOD
 . ;---Pregnancy Screen and Pregnancy Screen Comment for female pt ages 12-55
 . I $$PTSEX^RAUTL8(RADFN)="F",(($$PTAGE^RAUTL8(RADFN,"")>11)!($$PTAGE^RAUTL8(RADFN,"")<56)) D
 .. S RAFDA(70.03,IENS,32)="u"
 .. S RAFDA(70.03,IENS,80)="OUTSIDE STUDY"
 . ;--- SITE ACCESSION NUMBER
 . S:$G(RASACN31) RAFDA(70.03,IENS,31)=$$ACCNUM^RAMAGU04(RADTE,RACN)
 . ;--- CLINICAL HISTORY FOR EXAM
 . S TMP=$NA(RAMISC("CLINHIST"))
 . S:$D(@TMP)>1 RAFDA(70.03,IENS,400)=TMP
 . ;--- Values from the order
 . M RAFDA(70.03,IENS)=RAEXMVAL
 . ;--- Add the record
 . D UPDATE^DIE(,"RAFDA","RAIENS","RAMSG")
 . I $G(DIERR)  S RARC=$$DBS^RAERR("RAMSG",-9,70.03,IENS)  Q
 . S RACASE=RADFN_U_RADTI_U_RAIENS(1)
 . ;--- Add to the list
 . S ^TMP($J,"RAREG1",RAIP)=RACASE_U_RAOIFN
 . ;--- Procedure modifiers
 . S $P(IENS,",")=RAIENS(1)
 . S RARC=$$PROCMOD(IENS,RAPROC)  Q:RARC<0
 . ;--- Exam status
 . S RARC=$$UPDEXMST^RAMAGU05(RACASE,"^^1")  Q:RARC<0
 . ;--- Activity log
 . S TMP=$G(RAMISC("TECHCOMM"))
 . S RARC=$$UPDEXMAL^RAMAGU05(RACASE,"E",TMP)  Q:RARC<0
 ;
 ;===
 Q $S(RARC<0:RARC,1:0)
 ;
 ;+++++ PERFORMS EXAM POST-PROCESSING
 ;
 ; .RAEXAMS      Reference to a local array where identifiers of
 ;               registered examination(s) are returned to.
 ;
 ; RADTE         Actual date/time of the exam (FileMan)
 ;
 ; Input variables:
 ;   RASACN31, ^TMP($J,"RAREG1",...)
 ;
 ; Return values:
 ;       <0  Error descriptor (see $$ERROR^RAERR)
 ;      '<0  Number of registered examinations
 ;           (number of elements in the RAEXAMS array)
 ;
POSTPROC(RAEXAMS,RADTE) ;
 N IENS,RABUF,RACASE,RACN,RACNI,RADFN,RADTI,RAEXMCNT,RAI,RAMSG,RAOIFN
 S RAEXMCNT=0  K RAEXAMS
 ;===
 S RAI=0
 F  S RAI=$O(^TMP($J,"RAREG1",RAI))  Q:RAI'>0  D
 . S RACASE=^TMP($J,"RAREG1",RAI)  K RABUF,RAMSG
 . S RADFN=$P(RACASE,U),RADTI=$P(RACASE,U,2)
 . S RACNI=$P(RACASE,U,3),RAOIFN=$P(RACASE,U,4)
 . S IENS=$$EXAMIENS^RAMAGU04(RACASE)
 . ;--- Exam identifiers
 . S RACN=$$GET1^DIQ(70.03,IENS,.01,"I",,"RAMSG")
 . S $P(RACASE,U,4)=RACN                          ; Case number
 . I $G(RASACN31)  D                              ; Accession number
 . . S $P(RACASE,U,5)=$$GET1^DIQ(70.03,IENS,31,"I",,"RAMSG")
 . E  S $P(RACASE,U,5)=$$ACCNUM^RAMAGU04(RADTE,RACN,"S")
 . S $P(RACASE,U,6)=RADTE                         ; Exam date/time
 . S RAEXMCNT=RAEXMCNT+1,RAEXAMS(RAEXMCNT)=RACASE
 . ;--- Execute RA REG* protocols
 . D REG^RAHLRPC
 . ;--- Remove from the list
 . K ^TMP($J,"RAREG1",RAI)
 ;===
 Q RAEXMCNT
 ;
 ;+++++ STORES PROCEDURE MODIFIERS
 ;
 ; IENS7003      IENS of the exam in the sub-file #70.03
 ;
 ; RAPROC        Radiology procedure and modifiers
 ;                 ^01: Procedure IEN in file #71
 ;                 ^02: Optional procedure modifiers (IENs in
 ;                 ...  the PROCEDURE MODIFIERS file (#71.2))
 ;                 ^nn:
 ;
 ; Return values:
 ;       <0  Error descriptor (see $$ERROR^RAERR)
 ;        0  Success
 ;
 ; NOTE: This is an internal entry point. Do not call it from
 ;       outside of this routine.
 ;
PROCMOD(IENS7003,RAPROC) ;
 N I,IENS,LP,RAFDA,RAMSG,RAPMCNT,RARC,TMP
 S (RAPMCNT,RARC)=0
 ;--- Prepare the data
 S LP=$L(RAPROC,U)
 F I=2:1:LP  S TMP=$P(RAPROC,U,I)  D:TMP'=""
 . S RAPMCNT=RAPMCNT+1,IENS="+"_RAPMCNT_","_IENS7003
 . S RAFDA(70.1,IENS,.01)="`"_TMP
 ;--- Store procedure modifiers
 D:RAPMCNT>0
 . D UPDATE^DIE("E","RAFDA",,"RAMSG")
 . S:$G(DIERR) RARC=$$DBS^RAERR("RAMSG",-9,70.1)
 ;---
 Q RARC
