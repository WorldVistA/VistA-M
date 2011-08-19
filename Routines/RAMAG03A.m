RAMAG03A ;HCIOFO/SG - ORDERS/EXAMS API (REGISTR. PARAMS) ; 2/6/09 11:41am
 ;;5.0;Radiology/Nuclear Medicine;**90**;Mar 16, 1998;Build 20
 ;
 ; This routine uses the following IAs:
 ;
 ; #1337         Read access to the file #42.4 (controlled)
 ; #10039        Read access to the file #42 (supported)
 ; #10040        Read access to the file #44 (supported)
 ; #10093        Read access to the file #49 (supported)
 ;
 Q
 ;
 ;+++++ VALIDATES EXAM PARAMETERS AND INITIALIZES RELATED VARIABLES
 ;
 ; .RALOCK       Reference to a local variable where identifiers
 ;               of the locked order are added to.
 ;
 ; Input variables:
 ;   RADTE, RAMISC, RAOIFN
 ;
 ; Output variables:
 ;   RADFN, RAEXMVAL, RAIMGTYI, RAMDIV, RAMISC, RAMLC, RAPARENT,
 ;   RAPRLST
 ;
 ; Return values:
 ;       <0  Error descriptor (see $$ERROR^RAERR)
 ;        0  Success
 ;
 ; NOTE: This is an internal entry point. Do not call it from
 ;       routines other than the ^RAMAG03.
 ;
 ;       This function also locks the order record in the
 ;       RAD/NUC MED ORDERS file (#75.1).
 ;
VALIDATE(RALOCK) ;
 N ERRCNT,I,IENS,IENS751,RACAT,RABUF,RADTI,RAMSG,RAORDSTS,RC,TMP
 S ERRCNT=0  K RAEXMVAL
 ;=== Check required variables
 S RC=$$CHKREQ^RAUTL22("RADTE,RAOIFN")  Q:RC<0 RC
 ;
 ;=== Order IEN
 I RAOIFN>0,$D(^RAO(75.1,RAOIFN))
 E  Q $$IPVE^RAERR("RAOIFN")
 ;
 ;=== Lock the order
 K TMP  S TMP(75.1,RAOIFN_",")=""
 S RC=$$LOCKFM^RALOCK(.TMP)
 Q:RC $$LOCKERR^RAERR(RC,"order")
 M RALOCK=TMP
 ;
 ;=== Order status
 S RAORDSTS=$$ORDSTAT^RAMAGU02(RAOIFN)  Q:RAORDSTS<0 RAORDSTS
 ;--- Only orders with HOLD (3), PENDING (5), and SCHEDULED (8)
 ;--- statuses can be registered
 S I=+RAORDSTS
 Q:(I'=3)&(I'=5)&(I'=8) $$ERROR^RAERR(-35,,$P(RAORDSTS,U,2),RAOIFN)
 ;
 ;=== Exam date/time
 S TMP=+$E(RADTE,1,12)  ; Strip the seconds
 S I=$$ISEXCTDT^RAUTL22(TMP)
 I I>0,$P(TMP,".",2),$$FMTE^XLFDT(TMP)'=TMP  D
 . S RADTE=TMP,RADTI=$$INVDTE^RAMAGU04(RADTE)  ; Inverted date/time
 E  D
 . D:I'<0 IPVE^RAERR("RADTE")
 . S ERRCNT=ERRCNT+1,RADTE="",RADTI=0
 ;
 ;=== Load the order data
 S IENS751=RAOIFN_","
 D GETS^DIQ(75.1,IENS751,".01;3;4;14;20;21;22","I","RABUF","RAMSG")
 Q:$G(DIERR) $$DBS^RAERR("RAMSG",-9,75.1,IENS751)
 ;
 ;=== Patient IEN
 S RADFN=+$G(RABUF(75.1,IENS751,.01,"I"))
 Q:RADFN'>0 $$ERROR^RAERR(-19,,75.1,IENS751,.01)
 ;
 ;=== Imaging type IEN
 S RAIMGTYI=+$G(RABUF(75.1,IENS751,3,"I"))
 I RAIMGTYI'>0  D ERROR^RAERR(-19,,75.1,IENS751,3)  S ERRCNT=ERRCNT+1
 ;
 ;=== Imaging location IEN and Radiology division IEN
 S RAMLC=+$G(RABUF(75.1,IENS751,20,"I"))
 I RAMLC>0  D
 . S RAMDIV=$$GET1^DIQ(79.1,RAMLC_",",25,"I",,"RAMSG")
 . I $G(DIERR)  D  S ERRCNT=ERRCNT+1  Q
 . . D DBS^RAERR("RAMSG",-9,79.1,RAMLC_",")
 . I RAMDIV'>0  D  S ERRCNT=ERRCNT+1  Q
 . . D ERROR^RAERR(-19,,79.1,RAMLC_",",25)
 E  D ERROR^RAERR(-19,,75.1,IENS751,20)  S ERRCNT=ERRCNT+1
 ;
 ;=== REQUESTING PHYSICIAN, DATE DESIRED, and REQUESTING LOCATION
 F I=14,21,22  S RAEXMVAL(I)=$G(RABUF(75.1,IENS751,I,"I"))
 ;
 ;=== Category of exam
 S RACAT=$G(RAMISC("EXAMCAT"))
 I RACAT=""  D
 . S RACAT=$G(RABUF(75.1,IENS751,4,"I"))
 . I RACAT=""  D ERROR^RAERR(-19,,75.1,IENS751,4)  S ERRCNT=ERRCNT+1
 . ;--- Assign default value to the parameter
 . S RAMISC("EXAMCAT")=RACAT
 ;
 ;=== Radiology procedure(s) and modifiers
 S:$$VALPROC(IENS751)<0 ERRCNT=ERRCNT+1
 ;
 ;=== Parameters specific to the exam category
 S RC=0
 I RACAT="I"  D  ; Inpatient
 . S RC=$$VALINPAT(IENS751)
 . K RAMISC("PRINCLIN")
 ;
 ;=== Check for CATEGORY OF PATIENT discrepancy
 I RACAT="I",$G(RAMISC("WARD"))=""  D
 . S (RAMISC("EXAMCAT"),RACAT)="O"
 ;
 I RACAT'="I"  D            ; Other categories
 . S RC=$$VALOUTPT(IENS751)
 . F I="BEDSECT","SERVICE","WARD"  K RAMISC(I)
 S:RC<0 ERRCNT=ERRCNT+1
 ;
 ;=== Always get clinical history from the order
 D
 . K RAMISC("CLINHIST")
 . D GETS^DIQ(75.1,IENS751,"400",,"RABUF","RAMSG")
 . I $G(DIERR)  D  S ERRCNT=ERRCNT+1  Q
 . . D DBS^RAERR("RAMSG",-9,75.1,IENS751)
 . S I=""
 . F  S I=$O(RABUF(75.1,IENS751,400,I))  Q:I=""  D
 . . S RAMISC("CLINHIST",I)=RABUF(75.1,IENS751,400,I)
 . K RABUF(75.1,IENS751,400)
 ;
 ;=== Check the flags
 I $G(RAPARENT)  D:$G(RAMISC("FLAGS"))["A"
 . ;--- A parent procedure cannot be added to the existing exam(s)
 . D ERROR^RAERR(-53)  S ERRCNT=ERRCNT+1
 ;
 ;===
 Q $S(ERRCNT>0:$$ERROR^RAERR(-11),1:0)
 ;
 ;+++++ VALIDATES PARAMETERS SPECIFIC TO INPATIENT CATEGORY
 ;
 ; IENS751       IENS of the order in the RAD/NUC MED ORDERS file
 ;
 ; Input variables:
 ;   RADFN, RADTE, RAMISC
 ;
 ; Output variables:
 ;   RAMISC
 ;
 ; Return values:
 ;       <0  Error descriptor (see $$ERROR^RAERR)
 ;        0  Parameters are valid
 ;
 ; NOTE: This is an internal entry point. Do not call it from
 ;       outside of the RAMAG03* routines.
 ;
VALINPAT(IENS751) ;
 N BEDSECT,ERRCNT,I,IEN,RC,SERVICE,TMP,WARD
 S ERRCNT=0
 ;
 ;=== Check if at least one default value is needed
 S TMP=0
 F I="BEDSECT","SERVICE","WARD"  I '($D(RAMISC(I))#10)  S TMP=1  Q
 I TMP  S RC=0  D  Q:RC<0 +RC
 . ;--- Get inpatient data
 . S RC=$$RAINP^RAMAGU07(RADFN,.SERVICE,.BEDSECT,.WARD,RADTE)  Q:RC<0
 . ;--- Assign default values to the parameters
 . S:'($D(RAMISC("BEDSECT"))#10)&(BEDSECT>0) RAMISC("BEDSECT")=+BEDSECT
 . S:'($D(RAMISC("SERVICE"))#10)&(SERVICE>0) RAMISC("SERVICE")=+SERVICE
 . S:'($D(RAMISC("WARD"))#10)&(WARD>0) RAMISC("WARD")=+WARD
 ;
 ;=== Validate parameters
 S IEN=$G(RAMISC("BEDSECT"))
 D:IEN>0
 . S TMP=$$ROOT^DILFD(42.4,,1)
 . I '$D(@TMP@(IEN,0))  D  S ERRCNT=ERRCNT+1
 . . D IPVE^RAERR($NA(RAMISC("BEDSECT")))
 ;---
 S IEN=$G(RAMISC("SERVICE"))
 D:IEN>0
 . S TMP=$$ROOT^DILFD(49,,1)
 . I '$D(@TMP@(IEN,0))  D  S ERRCNT=ERRCNT+1
 . . D IPVE^RAERR($NA(RAMISC("SERVICE")))
 ;---
 S IEN=$G(RAMISC("WARD"))
 D:IEN>0
 . S TMP=$$ROOT^DILFD(42,,1)
 . I '$D(@TMP@(IEN,0))  D  S ERRCNT=ERRCNT+1
 . . D IPVE^RAERR($NA(RAMISC("WARD")))
 ;
 ;===
 Q $S(ERRCNT>0:-11,1:0)
 ;
 ;+++++ VALIDATES PARAMETERS SPECIFIC TO NON-INPATIENT CATEGORIES
 ;
 ; IENS751       IENS of the order in the RAD/NUC MED ORDERS file
 ;
 ; Input variables:
 ;   RAMISC
 ;
 ; Output variables:
 ;   RAMISC
 ;
 ; Return values:
 ;       <0  Error code
 ;        0  Parameters are valid
 ;
 ; NOTE: This is an internal entry point. Do not call it from
 ;       outside of the RAMAG03* routines.
 ;
VALOUTPT(IENS751) ;
 N CLINIC,ERRCNT,I,IENS,RAMSG,RC,TMP
 S ERRCNT=0
 ;
 ;=== Principal Clinic
 S RC=0,CLINIC=$G(RAMISC("PRINCLIN"))
 ;--- Use the Requesting Location from the order as default value
 D:CLINIC'>0
 . S CLINIC=$$GET1^DIQ(75.1,IENS751,22,"I",,"RAMSG")
 . I $G(DIERR)  S RC=$$DBS^RAERR("RAMSG",-9,75.1,IENS751)  Q
 . S:CLINIC'>0 RC=$$ERROR^RAERR(-19,,75.1,IENS751,22)
 ;--- Check the location type
 I RC'<0  D
 . S IENS=CLINIC_",",TMP=$$GET1^DIQ(44,IENS,2,"I",,"RAMSG")
 . I $G(DIERR)  S RC=$$DBS^RAERR("RAMSG",-9,44,IENS)  Q
 . I TMP=""  S RC=$$ERROR^RAERR(-19,,44,IENS,2)  Q
 . S:TMP'="C" RC=-3
 I RC<0  D  S ERRCNT=ERRCNT+1
 . D IPVE^RAERR($NA(RAMISC("PRINCLIN")))
 E  S RAMISC("PRINCLIN")=CLINIC
 ;
 ;===
 Q $S(ERRCNT>0:-11,1:0)
 ;
 ;+++++ VALIDATES RADIOLOGY PROCEDURE AND MODFIERS
 ;
 ; IENS751       IENS of the order in the RAD/NUC MED ORDERS file
 ;
 ; Input variables:
 ;   RADTE, RAIMGTYI, RAMISC
 ;
 ; Output variables:
 ;   RAMISC, RAPARENT, RAPRLST
 ;
 ; Return values:
 ;       <0  Error code
 ;        0  Procedure and modifiers are valid
 ;
 ; NOTE: This is an internal entry point. Do not call it from
 ;       outside of this routine.
 ;
VALPROC(IENS751) ;
 N CNT,DESCPLST,I,RABUF,RAMSG,RAPD,RAPROC,RAPTL,SNGLRPT,RC,TMP
 S (RAPARENT,RC)=0
 ;
 ;=== Compile the list of detailed/series procedures
 I $D(RAMISC("RAPROC"))>1  D
 . S (CNT,I,RAPD)=0
 . F  S I=$O(RAMISC("RAPROC",I))  Q:I'>0  D  Q:RC<0
 . . S RAPROC=RAMISC("RAPROC",I)
 . . ;--- "Parent" procedure should be the only procedure in the list
 . . I RAPARENT  S RC=$$ERROR^RAERR(-30)  Q
 . . ;--- Process a "parent" procedure
 . . S RC=$$DESCPLST^RAMAGU03(+RAPROC,.DESCPLST,.SNGLRPT)  Q:RC<0
 . . I RC>0  S RAPARENT=1  D  Q
 . . . ;--- "Parent" procedure should be the only proc. in the list
 . . . I CNT>0  S RC=$$ERROR^RAERR(-30)  Q
 . . . ;--- Modifiers cannot be used with "parent" procedures
 . . . S TMP=0
 . . . F I=2:1:$L(RAPROC,U)  I $P(RAPROC,U,I)'=""  S TMP=1  Q
 . . . I TMP  S RC=$$ERROR^RAERR(-32)  Q
 . . . ;--- Add detailed/series procedures to the list
 . . . S TMP=""
 . . . F  S TMP=$O(DESCPLST(TMP))  Q:TMP=""  D
 . . . . S CNT=CNT+1,RAPRLST(CNT)=+DESCPLST(TMP)
 . . ;--- Process a detailed/series procedure
 . . S CNT=CNT+1,RAPRLST(CNT)=RAPROC
 E  D
 . S CNT=0
 . ;--- Get the procedure and modifiers from the order
 . D GETS^DIQ(75.1,IENS751,"2;125*","I","RABUF","RAMSG")
 . I $G(DIERR)  S RC=$$DBS^RAERR("RAMSG",-9,75.1,IENS751)  Q
 . ;--- Procedure IEN
 . S RAPROC=+$G(RABUF(75.1,IENS751,2,"I"))
 . I RAPROC'>0  S RC=$$ERROR^RAERR(-19,,75.1,IENS751,2)  Q
 . ;--- Process a parent procedure
 . S RC=$$DESCPLST^RAMAGU03(+RAPROC,.DESCPLST,.SNGLRPT)  Q:RC<0
 . I RC>0  S RAPARENT=1,TMP=""  D  Q
 . . F  S TMP=$O(DESCPLST(TMP))  Q:TMP=""  D
 . . . S CNT=CNT+1,RAPRLST(CNT)=+DESCPLST(TMP)
 . ;--- Procedure modifier IENs
 . S I=""
 . F  S I=$O(RABUF(75.1125,I))  Q:I=""  D
 . . S TMP=+$G(RABUF(75.1125,I,.01,"I"))
 . . I TMP'>0  S RC=$$ERROR^RAERR(-19,,75.1125,I,.01)  Q
 . . S RAPROC=RAPROC_U_TMP
 . ;--- Add the procedure to the list
 . S RAPRLST(1)=RAPROC
 ;
 ;=== Validate procedures
 I RC'<0,RADTE>0,RAIMGTYI>0  D
 . S I=0
 . F  S I=$O(RAPRLST(I))  Q:I'>0  D
 . . S TMP=$$CHKPROC^RAMAGU03(RAPRLST(I),RAIMGTYI,RADTE,"DS")
 . . S:TMP<0 RC=TMP
 ;
 ;=== Enforce report type for descendants of a parent procedure
 I RAPARENT  K RAMISC("SINGLERPT")  S:SNGLRPT RAMISC("SINGLERPT")=1
 ;
 ;===
 Q $S(RC<0:-11,1:0)
