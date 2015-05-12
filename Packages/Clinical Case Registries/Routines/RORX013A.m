RORX013A ;HCIOFO/SG - DIAGNOSIS CODES (QUERY & SORT) ;6/21/06 2:24pm
 ;;1.5;CLINICAL CASE REGISTRIES;**1,13,19,21**;Feb 17, 2006;Build 45
 ;
 ; This routine uses the following IAs:
 ;
 ; #928          ACTIVE^GMPLUTL (controlled)
 ; #1554         POV^PXAPIIB (controlled)
 ; #1905         SELECTED^VSIT (controlled)
 ; #2977         GETFLDS^GMPLEDT3 (controlled)
 ; #3157         RPC^DGPTFAPI (supported)
 ; #3545         Access to the "AAD" cross-reference and the field 80 (private)
 ; #92           ^DGPT(IEN,0)  (controlled)
 ; #5747         $$CODEN^ICDEX, $$CODEC^ICDEX, $$VSTD^ICDEX (controlled)
 ;
 ;******************************************************************************
 ;******************************************************************************
 ;                 --- ROUTINE MODIFICATION LOG ---
 ;        
 ;PKG/PATCH    DATE        DEVELOPER    MODIFICATION
 ;-----------  ----------  -----------  ----------------------------------------
 ;ROR*1.5*13   DEC 2010    A SAUNDERS   User can select specific patients,
 ;                                      clinics, or divisions for the report.
 ;ROR*1.5*19   FEB 2012    J SCOTT      Support for ICD-10 Coding System.
 ;ROR*1.5*21   SEP 2013    T KOPP       Add Utilization date range to the report
 ;                                      Add ICN to report, if requested
 ;                                      
 ;******************************************************************************
 ;******************************************************************************
 Q
 ;
 ;**** STORES THE ICD CODE
 ;
 ; PATIEN        Patient IEN (DFN)
 ; SOURCE        ICD source code ("I", "O", "PB")
 ; [ICDIEN]      IEN of the ICD descriptor in file #80
 ; DATE          Date when the code was entered
 ; [ICD]         ICD code
 ;
 ; Either the ICDIEN or the ICD parameter must be provided.
 ;
ICDSET(PATIEN,SOURCE,ICDIEN,DATE,ICD) ;
 Q:DATE'>0
 N TMP
 S ICDIEN=+$G(ICDIEN)
 I ICDIEN'>0  Q:$G(ICD)=""  D  Q:ICDIEN'>0
 . S ICDIEN=+$$CODEN^ICDEX(ICD,80)
 ;---
 Q:$$ICDGRCHK^RORXU008(.RORPTGRP,ICDIEN,RORICDL)
 ;---
 S TMP=+$G(@RORTMP@("PAT",PATIEN,ICDIEN))
 S:'TMP!(DATE<TMP) @RORTMP@("PAT",PATIEN,ICDIEN)=DATE_U_SOURCE
 S ^(SOURCE)=$G(@RORTMP@("PAT",PATIEN,ICDIEN,SOURCE))+1 ;naked reference: ^TMP($J,"RORTMP-n") from RORX013
 Q
 ;
 ;***** SEARCHES FOR INPATIENT DIAGNOSES
 ;
 ; PATIEN        Patient IEN (DFN)
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;       >0  Number of non-fatal errors
 ;
INPAT(PATIEN) ;
 N ADMDT,DISDT,I,IEN,NODE,RC,RORBUF,RORMSG,TMP
 S NODE=$NA(^DGPT("AAD",+PATIEN))
 S RC=0
 ;--- Browse through the admissions
 S ADMDT=ROREDT1
 F  S ADMDT=$O(@NODE@(ADMDT),-1)  Q:ADMDT'>0  D  Q:RC
 . S IEN=""
 . F  S IEN=$O(@NODE@(ADMDT,IEN),-1)  Q:IEN'>0  D  Q:RC
 . . Q:+$G(^DGPT(IEN,0))'=PATIEN
 . . Q:$$PTF^RORXU001(IEN,"FP",,.DISDT)
 . . ;--- Skip invalid and/or incomplete admissions
 . . I DISDT'>0  D  Q:TMP!(DISDT'>0)
 . . . S TMP=$$CHKADM^RORXU001(PATIEN,ADMDT,.DISDT)
 . . ;--- Check if any appropriate admissions are left
 . . I DISDT<RORSDT  S RC=1  Q
 . . Q:DISDT'<ROREDT1
 . . ;--- Load and process the admission data
 . . K RORBUF  D RPC^DGPTFAPI(.RORBUF,IEN)
 . . I $G(RORBUF(0))<0  D  Q
 . . . D ERROR^RORERR(-57,,,,RORBUF(0),"RPC^DGPTFAPI")
 . . S TMP=$P($G(RORBUF(1)),U,3)
 . . D:TMP'="" ICDSET(PATIEN,"I",,DISDT,TMP)   ; ICD1
 . . D:$G(RORBUF(2))'=""                       ; ICD2 - ICD10
 . . . F I=1:1:9  S TMP=$P(RORBUF(2),U,I)  D:TMP'=""
 . . . . D ICDSET(PATIEN,"I",,DISDT,TMP)
 . . S TMP=+$$GET1^DIQ(45,IEN,80,"I",,"RORMSG")
 . . D:$G(DIERR) DBS^RORERR("RORMSG",-9,,,45,IEN)
 . . D:TMP>0 ICDSET(PATIEN,"I",TMP,DISDT)     ; PRINCIPAL DIAGNOSIS
 ;---
 Q $S(RC<0:RC,1:0)
 ;
 ;***** SEARCHES FOR OUTPATIENT DIAGNOSES
 ;
 ; PATIEN        Patient IEN (DFN)
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;       >0  Number of non-fatal errors
 ;
OUTPAT(PATIEN) ;
 N DATE,ICDIEN,RC,RORMSG,RORVPLST,TMP,VPIEN,VSIEN,VSIT
 D SELECTED^VSIT(PATIEN,RORSDT,ROREDT)
 ;--- Browse through the visits
 S (VSIEN,RC)=0
 F  S VSIEN=$O(^TMP("VSIT",$J,VSIEN))  Q:VSIEN=""  D  Q:RC<0
 . S TMP=+$O(^TMP("VSIT",$J,VSIEN,""))  Q:TMP'>0
 . S DATE=$P($G(^TMP("VSIT",$J,VSIEN,TMP)),U)  Q:DATE'>0
 . ;--- Get a list of V POV records
 . D POV^PXAPIIB(VSIEN,.RORVPLST)
 . ;--- Process the records
 . S (VPIEN,RC)=0
 . F  S VPIEN=$O(RORVPLST(VPIEN))  Q:VPIEN'>0  D  Q:RC
 . . S ICDIEN=+$P(RORVPLST(VPIEN),U)
 . . D:ICDIEN>0 ICDSET(PATIEN,"O",ICDIEN,DATE)
 Q $S(RC<0:RC,1:0)
 ;
 ;***** SEARCHES FOR PROBLEMS
 ;
 ; PATIEN        Patient IEN (DFN)
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;       >0  Number of non-fatal errors
 ;
PROBLEM(PATIEN) ;
 N DATE,GMPFLD,GMPORIG,GMPROV,GMPVAMC,ICDIEN,IEN,IS,RC,RORPLST,TMP
 ;--- Load a list of active problems
 D ACTIVE^GMPLUTL(PATIEN,.RORPLST)
 ;--- Browse through the problems
 S (GMPVAMC,GMPROV)=0
 S (IS,RC)=0
 F  S IS=$O(RORPLST(IS))  Q:IS=""  D  Q:RC
 . S IEN=+$G(RORPLST(IS,0))  Q:IEN'>0
 . K GMPFLD,GMPORIG  D GETFLDS^GMPLEDT3(IEN)
 . S ICDIEN=+$G(GMPFLD(.01))  Q:ICDIEN'>0
 . S DATE=$P($G(GMPFLD(.08)),U)
 . D:(DATE'<RORSDT)&(DATE<ROREDT1) ICDSET(PATIEN,"PB",ICDIEN,DATE)
 Q 0
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
 N RORDOD        ; Date of death
 N ROREDT1       ; Day after the end date
 N RORLAST4      ; Last 4 digits of the current patient's SSN
 N RORPNAME      ; Name of the current patient
 N RORICN        ; ICN of patient (optional)
 N RORPTGRP      ; Temporary list of ICD groups
 N RORPTN        ; Number of patients in the registry
 N RORCDLIST     ; Flag to indicate whether a clinic or division list exists
 N RORCDSTDT     ; Start date for clinic/division utilization search
 N RORCDENDT     ; End date for clinic/division utilization search
 ;
 N CNT,ECNT,IEN,IENS,PATIEN,RC,SKIPEDT,SKIPSDT,TMP,UTEDT,UTIL,UTSDT,VA,VADM,XREFNODE
 ;--- Utilization date range
 D:$$PARAM^RORTSK01("PATIENTS","CAREONLY")
 . S UTSDT=$$PARAM^RORTSK01("DATE_RANGE_3","START")\1
 . S UTEDT=$$PARAM^RORTSK01("DATE_RANGE_3","END")\1
 . ;--- Combined date range
 . S SKIPSDT=$$DTMIN^RORUTL18(SKIPSDT,UTSDT)
 . S SKIPEDT=$$DTMAX^RORUTL18(SKIPEDT,UTEDT)
 S XREFNODE=$NA(^RORDATA(798,"AC",+RORREG))
 S RORPTN=$$REGSIZE^RORUTL02(+RORREG)  S:RORPTN<0 RORPTN=0
 S ROREDT1=$$FMADD^XLFDT(ROREDT\1,1)
 S (CNT,ECNT,RC)=0
 ;
 ;=== Set up Clinic/Division list parameters
 S RORCDLIST=$$CDPARMS^RORXU001(.RORTSK,.RORCDSTDT,.RORCDENDT)
 ;
 ;--- Browse through the registry records
 S IEN=0
 F  S IEN=$O(@XREFNODE@(IEN))  Q:IEN'>0  D  Q:RC<0
 . S TMP=$S(RORPTN>0:CNT/RORPTN,1:"")
 . S RC=$$LOOP^RORTSK01(TMP)  Q:RC<0
 . S IENS=IEN_",",CNT=CNT+1
 . ;--- Get patient DFN
 . S PATIEN=$$PTIEN^RORUTL01(IEN)  Q:PATIEN'>0
 . ;check for patient list and quit if not on list
 . I $D(RORTSK("PARAMS","PATIENTS","C")),'$D(RORTSK("PARAMS","PATIENTS","C",PATIEN)) Q
 . ;--- Check if the patient should be skipped
 . Q:$$SKIP^RORXU005(IEN,FLAGS,RORSDT,ROREDT)
 . ;
 . ;--- Check for Clinic or Division list and quit if not in list
 . I RORCDLIST,'$$CDUTIL^RORXU001(.RORTSK,PATIEN,RORCDSTDT,RORCDENDT) Q
 . ;
 . ;--- Check for any utilization in the corresponding date range
 . I $$PARAM^RORTSK01("PATIENTS","CAREONLY") D  Q:'UTIL
 . . K TMP  S TMP("ALL")=1
 . . S UTIL=+$$UTIL^RORXU003(UTSDT,UTEDT,PATIEN,.TMP)
 . ;
 . M RORPTGRP=RORIGRP("C")
 . ;
 . ;--- Inpatient codes
 . S RC=$$INPAT(PATIEN)
 . I RC  Q:RC<0  S ECNT=ECNT+RC
 . ;
 . ;--- Outpatient codes
 . S RC=$$OUTPAT(PATIEN)
 . I RC  Q:RC<0  S ECNT=ECNT+RC
 . ;
 . ;--- Problem list
 . S RC=$$PROBLEM(PATIEN)
 . I RC  Q:RC<0  S ECNT=ECNT+RC
 . ;
 . ;--- Skip the patient if no data has been found
 . Q:$D(@RORTMP@("PAT",PATIEN))<10
 . ;--- No ICD from some groups
 . I $D(RORPTGRP)>1  K @RORTMP@("PAT",PATIEN)  Q
 . ;
 . ;--- Get the patient's data
 . D VADEM^RORUTL05(PATIEN,1)
 . S RORPNAME=VADM(1),RORDOD=$P(VADM(6),U),RORLAST4=VA("BID")
 . I $$PARAM^RORTSK01("PATIENTS","ICN") S RORICN=$$ICN^RORUTL02(PATIEN)
 . ;
 . ;--- Calculate the patient's totals
 . S RC=$$TOTALS(PATIEN)
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
 N ICDIEN,TMP,TNC,TNDC
 ;---
 S ICDIEN=0,(TNC,TNDC)=0
 F  S ICDIEN=$O(@RORTMP@("ICD",ICDIEN))  Q:ICDIEN'>0  D
 . S TNC=TNC+$G(@RORTMP@("ICD",ICDIEN,"C"))
 . S TNDC=TNDC+1
 S @RORTMP@("ICD")=TNC_U_TNDC
 ;---
 Q 0
 ;
 ;***** CALCULATES INTERMEDIATE TOTALS
 ;
 ; PATIEN        Patient IEN (DFN)
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;       >0  Number of non-fatal errors
 ;
TOTALS(PATIEN) ;
 N CNT,ICD,ICDIEN,ICDVST,PNODE,RC,TMP
 S PNODE=$NA(@RORTMP@("PAT",PATIEN))
 S @PNODE=RORLAST4_U_RORPNAME_U_RORDOD_U_$G(RORICN)
 S ^("PAT")=$G(@RORTMP@("PAT"))+1 ;naked reference: ^TMP($J,"RORTMP-n") from RORX013
 ;
 S ICDIEN=0
 F  S ICDIEN=$O(@PNODE@(ICDIEN))  Q:ICDIEN'>0  D
 . S ICD=$P($G(@RORTMP@("ICD",ICDIEN)),U)
 . I ICD=""  D
 . . S ICD=$$CODEC^ICDEX(80,ICDIEN)
 . . S ICDVST=$$VSTD^ICDEX(ICDIEN)
 . . S:ICD="" ICD="UNKN"
 . . S:ICDVST="" ICDVST="Unknown ("_ICDIEN_")"
 . . S @RORTMP@("ICD",ICDIEN)=ICD_U_ICDVST
 . ;---
 . S CNT=0
 . F TMP="I","O","PB"  S CNT=CNT+$G(@PNODE@(ICDIEN,TMP))
 . S @PNODE@(ICDIEN,"C")=CNT
 . S ^("C")=$G(@RORTMP@("ICD",ICDIEN,"C"))+CNT ;naked reference: ^TMP($J,"RORTMP-n") from RORX013
 . S ^("P")=$G(@RORTMP@("ICD",ICDIEN,"P"))+1 ;naked reference: ^TMP($J,"RORTMP-n") from RORX013
 Q 0
