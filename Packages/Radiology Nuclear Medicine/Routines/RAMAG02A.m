RAMAG02A ;HCIOFO/SG - ORDERS/EXAMS API (REQUEST UTILITIES) ; 2/6/09 11:45am
 ;;5.0;Radiology/Nuclear Medicine;**90**;Mar 16, 1998;Build 20
 ;
 Q
 ;
 ;+++++ CREATES AN ORDER IN THE RAD/NUC MED ORDERS FILE (#75.1)
 ;
 ; Input variables:
 ;   RACAT, RADFN, RADTE, RAIMGTYI, RAMDIV, RAMISC, RAMLC, RAPROC,
 ;   RAREASON, REQLOC, REQPHYS
 ;
 ; Return values:
 ;       <0  Error descriptor (see $$ERROR^RAERR)
 ;       >0  IEN of the order in the file #75.1
 ;
 ; NOTE: This is an internal entry point. Do not call it from
 ;       routines other than the ^RAMAG02.
 ;
ORD() ;
 N IENS,RABUF,RAFDA,RAIENS,RALOCK,RAMSG,RAOIFN,RARC,TMP
 S RARC=0
 ;
 ;=== Create the new order
 S IENS="+1,"
 S RAFDA(75.1,IENS,.01)=RADFN  ; NAME
 S RAFDA(75.1,IENS,2)=+RAPROC  ; PROCEDURE
 S RAFDA(75.1,IENS,21)=RADTE   ; DATE DESIRED
 D UPDATE^DIE(,"RAFDA","RAIENS","RAMSG")
 Q:$G(DIERR) $$DBS^RAERR("RAMSG",-9,75.1,IENS)
 S RAOIFN=RAIENS(1)
 ;
 ;=== Store remaining fields of the order
 D
 . ;--- Setup the error processing
 . N $ESTACK,$ETRAP  D SETDEFEH^RAERR("RARC")
 . ;
 . ;--- Lock the record
 . K TMP  S TMP(75.1,RAOIFN_",")=""
 . S RARC=$$LOCKFM^RALOCK(.TMP)
 . I RARC  S RARC=$$LOCKERR^RAERR(RARC,"order")  Q
 . M RALOCK=TMP
 . ;
 . ;--- Prepare required fields
 . S IENS=RAOIFN_","
 . S RAFDA(75.1,IENS,1.1)=RAREASON          ; REASON FOR STUDY
 . S RAFDA(75.1,IENS,3)="`"_RAIMGTYI        ; TYPE OF IMAGING
 . D ZSET(IENS,4,RACAT)                     ; CATEGORY OF EXAM
 . S RAFDA(75.1,IENS,14)="`"_REQPHYS        ; REQUESTING PHYSICIAN
 . S RAFDA(75.1,IENS,20)="`"_RAMLC          ; IMAGING LOCATION
 . S RAFDA(75.1,IENS,22)="`"_REQLOC         ; REQUESTING LOCATION
 . ;
 . ;--- Prepare miscellaneous/optional fields
 . D ZSET(IENS,6,$G(RAMISC("REQURG")))      ; REQUEST URGENCY
 . D ZSET(IENS,13,$G(RAMISC("PREGNANT")))   ; PREGNANT
 . D ZSET(IENS,19,$G(RAMISC("TRANSPMODE"))) ; MODE OF TRANSPORT
 . D ZSET(IENS,24,$G(RAMISC("ISOLPROC")))   ; ISOLATION PROCEDURES
 . D ZSET(IENS,26,$G(RAMISC("REQNATURE")))  ; NATURE OF (NEW) ORDER...
 . ;
 . ;--- PRE-OP SCHEDULED DATE/TIME
 . S TMP=$G(RAMISC("PREOPDT"))
 . S:TMP>0 RAFDA(75.1,IENS,12)=$$FMTE^XLFDT(TMP)
 . ;
 . ;--- CLINICAL HISTORY FOR EXAM
 . S TMP=$NA(RAMISC("CLINHIST"))
 . S:$D(@TMP)>1 RAFDA(75.1,IENS,400)=TMP
 . ;
 . ;--- Update the record
 . D FILE^DIE("ET","RAFDA","RAMSG")
 . I $G(DIERR)  S RARC=$$DBS^RAERR("RAMSG",-9,75.1,IENS)  Q
 . ;
 . ;--- Store procedure modifiers
 . S RARC=$$PROCMOD(RAOIFN,RAPROC)  Q:RARC<0
 . ;
 . ;--- Update status of the order
 . S RARC=$$UPDORDST^RAMAGU02(RAOIFN,5)  Q:RARC<0
 ;
 ;=== Error handling and cleanup
 D:RARC<0
 . ;--- Delete incomplete record
 . N DA,DIK  S DA=RAOIFN,DIK="^RAO(75.1,"  D ^DIK
 ;--- Unlock the record
 D UNLOCKFM^RALOCK(.RALOCK)
 ;---
 Q $S(RARC<0:RARC,1:RAOIFN)
 ;
 ;+++++ STORES PROCEDURE MODIFIERS
 ;
 ; RAOIFN        IEN of the order in the file #75.1
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
PROCMOD(RAOIFN,RAPROC) ;
 N I,IENS,LP,PMCNT,RAFDA,RAMSG,RC,TMP
 S (PMCNT,RC)=0
 ;--- Prepare the data
 S LP=$L(RAPROC,U)
 F I=2:1:LP  S TMP=$P(RAPROC,U,I)  D:TMP'=""
 . S PMCNT=PMCNT+1,IENS="+"_PMCNT_","_(+RAOIFN)_","
 . S RAFDA(75.1125,IENS,.01)="`"_TMP
 ;--- Store procedure modifiers
 D:PMCNT>0
 . D UPDATE^DIE("E","RAFDA",,"RAMSG")
 . S:$G(DIERR) RC=$$DBS^RAERR("RAMSG",-9,75.1125)
 ;---
 Q RC
 ;
 ;+++++ VALIDATES ORDER PARAMETERS AND INITIALIZES RELATED VARIABLES
 ;
 ; Input variables:
 ;   RACAT, RADFN, RADTE, RAMISC, RAMLC, RAPROC, RAREASON, REQLOC,
 ;   REQPHYS
 ;
 ; Output variables:
 ;   RAIMGTYI, RAMDIV, VA, VADM
 ;
 ; Return values:
 ;       <0  Error descriptor (see $$ERROR^RAERR)
 ;        0  Success
 ;
 ; NOTE: This is an internal entry point. Do not call it from
 ;       routines other than the ^RAMAG02.
 ;
VALIDATE() ;
 N ERRCNT,I,IENS,L,RABUF,RAMSG,RC,TMP,X
 S ERRCNT=0
 ;=== Check required variables
 S X="RACAT,RADFN,RADTE,RAMLC,RAPROC,RAREASON,REQLOC,REQPHYS"
 S RC=$$CHKREQ^RAUTL22(X)  Q:RC<0 RC
 ;
 ;=== Patient IEN (DFN)
 S RC=$$VADEM^RAMAGU07(RADFN)
 I RC'<0  S:$G(VADM(1))="" RC=$$IPVE^RAERR("RADFN")
 S:RC<0 ERRCNT=ERRCNT+1,RADFN=0
 ;
 ;=== Requesting physician
 I REQPHYS>0  D  I X
 . N RACRE,Y  S Y=REQPHYS  S X=$$PROV^RABWORD()
 E  D
 . D IPVE^RAERR("REQPHYS")
 . S ERRCNT=ERRCNT+1,REQPHYS=0
 ;
 ;=== Requesting location
 S RC=0  D
 . S TMP=$$GET1^DIQ(44,REQLOC_",",.01,,,"RAMSG")
 . I $G(DIERR)  S RC=$$DBS^RAERR("RAMSG",-9,44,REQLOC_",")  Q
 . ;--- Missing .01 field
 . I TMP=""  S RC=$$IPVE^RAERR("REQLOC")  Q
 S:RC<0 ERRCNT=ERRCNT+1,REQLOC=0
 K RAMSG
 ;
 ;=== Desired date
 I ($$ISEXCTDT^RAUTL22(RADTE)'>0)!($$FMTE^XLFDT(RADTE)=RADTE)  D
 . D IPVE^RAERR("RADTE")
 . S ERRCNT=ERRCNT+1,RADTE=""
 E  S RADTE=RADTE\1  ; Strip the time
 ;
 ;=== Imaging location IEN
 S RC=0  D
 . S IENS=RAMLC_",",(RAIMGTYI,RAMDIV)=0
 . D GETS^DIQ(79.1,IENS,"6;25","I","RABUF","RAMSG")
 . I $G(DIERR)  S RC=$$DBS^RAERR("RAMSG",-9,79.1,IENS)  Q
 . ;--- Check required fields
 . S RAIMGTYI=+$G(RABUF(79.1,IENS,6,"I")) ; Imaging type IEN
 . S RAMDIV=+$G(RABUF(79.1,IENS,25,"I"))  ; Division IEN
 . I (RAIMGTYI'>0)!(RAMDIV'>0)  D  Q
 . . S RC=$$IPVE^RAERR("RAMLC")
 S:RC<0 ERRCNT=ERRCNT+1,RAMLC=0
 K RABUF,RAMSG
 ;
 ;=== Radiology procedure and modifiers
 S RC=0  D
 . I RAPROC'>0  S RC=$$IPVE^RAERR("RAPROC")  Q
 . ;=== Additional checks only if related parameters are valid
 . Q:(RADTE'>0)!(RAIMGTYI'>0)
 . S RC=$$CHKPROC^RAMAGU03(RAPROC,RAIMGTYI,RADTE)
 S:RC<0 ERRCNT=ERRCNT+1,RAPROC=""
 ;
 ;=== Miscellaneous parameters
 S:$G(RAMISC("ISOLPROC"))="" RAMISC("ISOLPROC")="n"
 S:$G(RAMISC("REQNATURE"))="" RAMISC("REQNATURE")="s"
 S:$G(RAMISC("REQURG"))="" RAMISC("REQURG")="9"
 ;--- MODE OF TRANSPORT (Default value: WHEEL CHAIR for
 ;--- inpatient exam category, AMBULATORY otherwise)
 D:$G(RAMISC("TRANSPMODE"))=""
 . S RAMISC("TRANSPMODE")=$S(RACAT="I":"w",1:"a")
 ;--- PRE-OP SCHEDULED DATE/TIME
 S TMP=$G(RAMISC("PREOPDT"))
 D:TMP'=""
 . I ($$ISEXCTDT^RAUTL22(TMP)'>0)!($$FMTE^XLFDT(TMP)=TMP)  D  Q
 . . D IPVE^RAERR($NA(RAMISC("PREOPDT")))  S ERRCNT=ERRCNT+1
 . S RAMISC("PREOPDT")=+$E(TMP,1,12) ; Strip the seconds
 ;--- PREGNANT
 I $G(RAMISC("PREGNANT"))=""  D
 . S:$P($G(VADM(5)),U)="F" RAMISC("PREGNANT")="u"
 E  I $P($G(VADM(5)),U)="M"  D
 . D ERROR^RAERR(-27)  S ERRCNT=ERRCNT+1
 ;
 ;===
 Q $S(ERRCNT>0:$$ERROR^RAERR(-11),1:0)
 ;
 ;+++++ STORES THE EXTERNAL FIELD VALUE INTO THE RAFDA
ZSET(IENS,FIELD,VALUE) ;
 Q:VALUE=""
 N RAMSG,TMP
 S TMP=$$EXTERNAL^DILFD(75.1,FIELD,,VALUE,"RAMSG")
 S RAFDA(75.1,IENS,FIELD)=$S(TMP'="":TMP,1:VALUE)
 Q
