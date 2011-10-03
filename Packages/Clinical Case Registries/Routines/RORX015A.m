RORX015A ;HOIFO/SG,VAC - OUTPATIENT PROCEDURES (QUERY & SORT) ;4/7/09 2:10pm
 ;;1.5;CLINICAL CASE REGISTRIES;**1,8,13**;Feb 17, 2006;Build 27
 ;
 ; This routine uses the following IAs:
 ;
 ; #1995         $$CODEN^ICPTCOD and $$CPT^ICPTCOD (supported)
 ; #2055         ROOT^DILFD
 ; #2056         GETS^DIQ
 ; #2546         GETCPT^SDOE
 ; #2548         Multiple APIs in SDQ routine (supported)
 ; #3990         $$CODEN^ICDCODE and $$ICDOP^ICDCODE (supported)
 ; #10103        FMADD^XLFDT (supported)
 ;
 ;******************************************************************************
 ;******************************************************************************
 ;                 --- ROUTINE MODIFICATION LOG ---
 ;        
 ;PKG/PATCH    DATE        DEVELOPER    MODIFICATION
 ;-----------  ----------  -----------  ----------------------------------------
 ;ROR*1.5*8    MAR  2010   V CARR       Modified to handle ICD9 filter for
 ;                                      'include' or 'exclude'.
 ;ROR*1.5*13   DEC  2010   A SAUNDERS   User can select specific patients,
 ;                                      clinics, or divisions for the report.
 ;                                      
 ;******************************************************************************
 ;******************************************************************************
 Q
 ;
 ;***** SEARCHES FOR INPATIENT PROCEDURES
 ;
 ; PTIEN         Patient IEN (DFN)
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;       >0  Number of non-fatal errors
 ;
INPAT(PTIEN) ;
 N DATE,ERRCNT,FLDLST,IEN,IEN45,IENS,NODE,RC,RORBUF,RORMSG,XREF
 S (ERRCNT,RC)=0
 S XREF=$$ROOT^DILFD(45,,1),XREF=$NA(@XREF@("B",PTIEN))
 S IEN45=0
 F  S IEN45=$O(@XREF@(IEN45))  Q:IEN45'>0  D
 . ;Q:$$GET1^DIQ(45,IEN45_",",6,"I",,"RORMSG")<1  ; Skip open records
 . ;S IENS=IEN45_","
 . ;S FLDLST="45.01;45.02;45.03;45.04;45.05"
 . ;D GETS^DIQ(45,IENS,FLDLST,"I","RORBUF","RORMSG")
 . ;I $G(DIERR)  D  S ERRCNT=ERRCNT+1
 . ;. D DBS^RORERR("RORMSG",-99,,PTIEN,45,IENS)
 . ;D INP(PTIEN,$NA(RORBUF(IENS)),FLDLST,???)
 . ;--- Surgical procedures
 . S NODE=$$ROOT^DILFD(45.01,","_IEN45_",",1)
 . S IEN=0
 . F  S IEN=$O(@NODE@(IEN))  Q:IEN'>0  D
 . . S IENS=IEN_","_IEN45_","  K RORBUF
 . . S FLDLST="8;9;10;11;12"
 . . ;--- Load the data
 . . K RORMSG D GETS^DIQ(45.01,IENS,".01;"_FLDLST,"I","RORBUF","RORMSG")
 . . ;I $G(DIERR)  D  S ERRCNT=ERRCNT+1
 . . I $G(RORMSG("DIERR"))  D  S ERRCNT=ERRCNT+1
 . . . D DBS^RORERR("RORMSG",-99,,PTIEN,45.01,IENS)
 . . S DATE=$G(RORBUF(45.01,IENS,.01,"I"))
 . . Q:(DATE<RORSDT)!(DATE'<ROREDT1)
 . . ;--- Generate the output
 . . D INP(PTIEN,$NA(RORBUF(45.01,IENS)),FLDLST,DATE)
 . ;--- Other procedures
 . S NODE=$$ROOT^DILFD(45.05,","_IEN45_",",1)
 . S IEN=0
 . F  S IEN=$O(@NODE@(IEN))  Q:IEN'>0  D
 . . S IENS=IEN_","_IEN45_","  K RORBUF
 . . S FLDLST="4;5;6;7;8"
 . . ;--- Load the data
 . . K RORMSG D GETS^DIQ(45.05,IENS,".01;"_FLDLST,"I","RORBUF","RORMSG")
 . . ;I $G(DIERR)  D  S ERRCNT=ERRCNT+1
 . . I $G(RORMSG("DIERR"))  D  S ERRCNT=ERRCNT+1
 . . . D DBS^RORERR("RORMSG",-99,,PTIEN,45.05,IENS)
 . . S DATE=$G(RORBUF(45.05,IENS,.01,"I"))
 . . Q:(DATE<RORSDT)!(DATE'<ROREDT1)
 . . ;--- Generate the output
 . . D INP(PTIEN,$NA(RORBUF(45.05,IENS)),FLDLST,DATE)
 ;---
 Q $S(RC<0:RC,1:ERRCNT)
 ;
 ;****
INP(PTIEN,ROR8BUF,FLDLST,DATE) ;
 N I,ICD9IEN,FLD
 F I=1:1  S FLD=$P(FLDLST,";",I)  Q:FLD=""  D
 . S ICD9IEN=+$G(@ROR8BUF@(FLD,"I"))
 . D:ICD9IEN>0 PROCSET(PTIEN,"I",ICD9IEN,DATE)
 Q
 ;
 ;***** CALL-BACK PROCEDURE FOR THE OUTPATIENT SEARCH
 ;
 ; PTIEN         Patient IEN (DFN)
 ;
OPSCAN(PTIEN) ;
 N CPTIEN,DATE,IEN,RORCPT,VDATE
 D GETCPT^SDOE(Y,"RORCPT")
 Q:$G(RORCPT)'>0
 S VDATE=+$P(Y0,U)
 ;---
 S IEN=0
 F  S IEN=$O(RORCPT(IEN))  Q:IEN'>0  D
 . S CPTIEN=+$P(RORCPT(IEN),U),DATE=+$P($G(RORCPT(IEN,12)),U)
 . D:CPTIEN>0 PROCSET(PTIEN,"O",CPTIEN,$S(DATE>0:DATE,1:VDATE))
 Q
 ;
 ;***** SEARCHES FOR OUTPATIENT PROCEDURES
 ;
 ; PTIEN         Patient IEN (DFN)
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;       >0  Number of non-fatal errors
 ;
OUTPAT(PTIEN) ;
 N QUERY
 D OPEN^SDQ(.QUERY)
 D INDEX^SDQ(.QUERY,"PATIENT/DATE","SET")
 D PAT^SDQ(.QUERY,PTIEN,"SET")
 D DATE^SDQ(.QUERY,RORSDT,ROREDT1,"SET")
 D SCANCB^SDQ(.QUERY,"D OPSCAN^RORX015A("_PTIEN_")","SET")
 D ACTIVE^SDQ(.QUERY,"TRUE","SET")
 D SCAN^SDQ(.QUERY,"FORWARD")
 D CLOSE^SDQ(.QUERY)
 Q 0
 ;
 ;**** STORES THE PROCEDURE CODE
 ;
 ; PTIEN         Patient IEN (DFN)
 ; SOURCE        CPT source code ("O" or "I")
 ; [IEN]         IEN of the procedure descriptor (file #81 or #80.1)
 ; DATE          Date when the code was entered
 ; [CODE]        Procedure code (CPT or ICD-9)
 ;
 ; Either the IEN or the CODE parameter must be provided.
 ;
PROCSET(PTIEN,SOURCE,IEN,DATE,CODE) ;
 Q:DATE'>0
 N TMP
 S IEN=+$G(IEN)
 ;---
 I IEN'>0  Q:$G(CODE)=""  D  Q:IEN'>0
 . I SOURCE="O"  S IEN=+$$CODEN^ICPTCOD(CODE)       Q
 . I SOURCE="I"  S IEN=+$$CODEN^ICDCODE(CODE,80.1)  Q
 ;---
 I SOURCE="O",'$$PARAM^RORTSK01("CPTLST","ALL")  D  Q:'TMP
 . S TMP=$D(RORTSK("PARAMS","CPTLST","C",IEN))
 I SOURCE="I"  Q:$$ICDGRCHK^RORXU008(.RORPTGRP,IEN,RORICDL)
 ;---
 S TMP=+$G(@RORTMP@("PAT",PTIEN,SOURCE,IEN))
 S:'TMP!(DATE<TMP) @RORTMP@("PAT",PTIEN,SOURCE,IEN)=DATE
 S ^("C")=$G(@RORTMP@("PAT",PTIEN,SOURCE,IEN,"C"))+1 ;naked reference: ^TMP($J,"RORTMP-n") from RORX015
 Q
 ;
 ;***** QUERIES THE REGISTRY
 ;
 ; FLAGS         Flags for the $$SKIP^RORXU005
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;       >0  Number of non-fatal errors
 ;
QUERY(FLAGS) ;
 N ROREDT1       ; Day after the end date
 N RORPTGRP      ; Temporary list of ICD-9 groups
 N RORPTN        ; Number of patients in the registry
 N RORCDLIST     ; Flag to indicate whether a clinic or division list exists
 N RORCDSTDT     ; Start date for clinic/division utilization search
 N RORCDENDT     ; End date for clinic/division utilization search
 ;
 N CNT,ECNT,IEN,IENS,MODE,PTIEN,RC,SKIP,SKIPEDT,SKIPSDT,TMP,UTEDT,UTSDT,XREFNODE
 N RCC,FLAG
 S XREFNODE=$NA(^RORDATA(798,"AC",+RORREG))
 S ROREDT1=$$FMADD^XLFDT(ROREDT\1,1)
 S (CNT,ECNT,RC)=0,SKIPEDT=ROREDT,SKIPSDT=RORSDT
 S:$$PARAM^RORTSK01("PATIENTS","INPATIENT") MODE("I")=1
 S:$$PARAM^RORTSK01("PATIENTS","OUTPATIENT") MODE("O")=1
 ;--- Utilization date range
 D:$$PARAM^RORTSK01("PATIENTS","CAREONLY")
 . S UTSDT=$$PARAM^RORTSK01("DATE_RANGE_3","START")\1
 . S UTEDT=$$PARAM^RORTSK01("DATE_RANGE_3","END")\1
 . ;--- Combined date range
 . S SKIPSDT=$$DTMIN^RORUTL18(SKIPSDT,UTSDT)
 . S SKIPEDT=$$DTMAX^RORUTL18(SKIPEDT,UTEDT)
 ;--- Number of patients in the registry
 S RORPTN=$$REGSIZE^RORUTL02(+RORREG)  S:RORPTN<0 RORPTN=0
 ;
 ;=== Set up Clinic/Division list parameters
 S RORCDLIST=$$CDPARMS^RORXU001(.RORTSK,.RORCDSTDT,.RORCDENDT,1)
 ;
 ;=== Browse through the registry records
 S IEN=0
 S FLAG=$G(RORTSK("PARAMS","ICD9FILT","A","FILTER"))
 F  S IEN=$O(@XREFNODE@(IEN))  Q:IEN'>0  D  Q:RC<0
 . S TMP=$S(RORPTN>0:CNT/RORPTN,1:"")
 . S RC=$$LOOP^RORTSK01(TMP)  Q:RC<0
 . S IENS=IEN_",",CNT=CNT+1
 . ;--- Get patient DFN
 . S PTIEN=$$PTIEN^RORUTL01(IEN)  Q:PTIEN'>0
 . ;--- Check for patient list and quit if not on list
 . I $D(RORTSK("PARAMS","PATIENTS","C")),'$D(RORTSK("PARAMS","PATIENTS","C",PTIEN)) Q
 . ;--- Check if the patient should be skipped
 . Q:$$SKIP^RORXU005(IEN,FLAGS,SKIPSDT,SKIPEDT)
 . ;--- Check if patient has passed the ICD9 Filter
 . S RCC=0
 . I FLAG'="ALL" D
 . . S RCC=$$ICD^RORXU010(PTIEN,RORREG)
 . I (FLAG="INCLUDE")&(RCC=0) Q
 . I (FLAG="EXCLUDE")&(RCC=1) Q
 . ;--- End of ICD9 check
 . M RORPTGRP=RORIGRP("C")
 . ;
 . ;--- Check for Clinic or Division list and quit if not in list
 . I RORCDLIST,'$$CDUTIL^RORXU001(.RORTSK,PTIEN,RORCDSTDT,RORCDENDT) Q
 . ;
 . ;--- Inpatient codes (ICD-9)
 . I $G(MODE("I"))   D  I RC  Q:RC<0  S ECNT=ECNT+RC
 . . S RC=$$INPAT(PTIEN)
 . ;--- Outpatient codes (CPT)
 . I $G(MODE("O"))  D  I RC  Q:RC<0  S ECNT=ECNT+RC
 . . S RC=$$OUTPAT(PTIEN)
 . ;
 . ;--- If ICD-9 codes from some groups have not been found,
 . ;--- then do not consider inpatient procedures at all
 . K:$D(RORPTGRP)>1 @RORTMP@("PAT",PTIEN,"I")
 . ;---
 . S SKIP=($D(@RORTMP@("PAT",PTIEN))<10)
 . S:RORPROC<0 SKIP='SKIP
 . ;
 . ;--- Check for any utilization in the corresponding date range
 . I 'SKIP  D:$$PARAM^RORTSK01("PATIENTS","CAREONLY")
 . . K TMP  S TMP("ALL")=1
 . . S UTIL=+$$UTIL^RORXU003(UTSDT,UTEDT,PTIEN,.TMP)
 . . S:'UTIL SKIP=1
 . ;
 . ;--- Skip the patient if not all search criteria have been met
 . I SKIP  K @RORTMP@("PAT",PTIEN)  Q
 . ;
 . ;--- Calculate the patient's totals
 . S RC=$$TOTALS(PTIEN)
 . I RC  Q:RC<0  S ECNT=ECNT+RC
 ;---
 Q $S(RC<0:RC,1:ECNT)
 ;
 ;***** SORTS THE RESULTS AND COMPILES THE TOTALS
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;       >0  Number of non-fatal errors
 ;
SORT() ;
 N IEN,SRC,TMP,TNC,TNDC
 ;---
 S (TNC,TNDC)=0
 F SRC="I","O"  D
 . S IEN=0
 . F  S IEN=$O(@RORTMP@("PROC",SRC,IEN))  Q:IEN'>0  D
 . . S TMP=$P($G(@RORTMP@("PROC",SRC,IEN)),U,2)
 . . S:TMP'="" @RORTMP@("PROC","B",TMP,SRC,IEN)=""
 . . S TNC=TNC+$G(@RORTMP@("PROC",SRC,IEN,"C"))
 . . S TNDC=TNDC+1
 S @RORTMP@("PROC")=TNC_U_TNDC
 ;---
 Q 0
 ;
 ;***** CALCULATES INTERMEDIATE TOTALS
 ;
 ; PTIEN         Patient IEN (DFN)
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;       >0  Number of non-fatal errors
 ;
TOTALS(PTIEN) ;
 N CNT,CODE,IEN,NAME,PNODE,RC,SRC,TMP,VA,VADM
 S PNODE=$NA(@RORTMP@("PAT",PTIEN))
 ;--- Get and store the patient's data
 D VADEM^RORUTL05(PTIEN,1)
 S @PNODE=VA("BID")_U_VADM(1)_U_$$DATE^RORXU002(VADM(6)\1)
 S ^("PAT")=$G(@RORTMP@("PAT"))+1 ;naked reference: ^TMP($J,"RORTMP-n") from RORX015
 ;
 F SRC="I","O"  D
 . S IEN=0
 . F  S IEN=$O(@PNODE@(SRC,IEN))  Q:IEN'>0  D
 . . S CODE=$P($G(@RORTMP@("PROC",SRC,IEN)),U),NAME=""
 . . D:CODE=""
 . . . I SRC="O"  D
 . . . . S TMP=$$CPT^ICPTCOD(IEN)
 . . . . S:TMP'<0 CODE=$P(TMP,U,2),NAME=$P(TMP,U,3)
 . . . E  D
 . . . . S TMP=$$ICDOP^ICDCODE(IEN)
 . . . . S:TMP'<0 CODE=$P(TMP,U,2),NAME=$P(TMP,U,5)
 . . . S:CODE="" CODE="UNKN"
 . . . S:NAME="" NAME="Unknown ("_IEN_")"
 . . . S @RORTMP@("PROC",SRC,IEN)=CODE_U_NAME
 . . ;---
 . . S CNT=+$G(@PNODE@(SRC,IEN,"C"))
 . . S ^("C")=$G(@RORTMP@("PROC",SRC,IEN,"C"))+CNT ;naked reference: ^TMP($J,"RORTMP-n") from RORX015
 . . S ^("P")=$G(@RORTMP@("PROC",SRC,IEN,"P"))+1 ;naked reference: ^TMP($J,"RORTMP-n") from RORX015
 Q 0
