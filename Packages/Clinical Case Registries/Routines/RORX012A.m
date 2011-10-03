RORX012A ;HOIFO/SG,VAC - COMBINED MEDS AND LABS (QUERY & STORE) ;4/7/09 2:09pm
 ;;1.5;CLINICAL CASE REGISTRIES;**8,13**;Feb 17, 2006;Build 27
 ;
 ; This routine uses the following IAs:
 ;
 ; #10103 FMADD^XLFDT (supported)
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
 ;***** LAB SEARCH CALLBACK
 ;
 ; .ROR8DST      Reference to the ROR8DST parameter.
 ;
 ; INVDT         IEN of the Lab test (inverted date)
 ;
 ; .RESULT       Reference to a local variable, which contains
 ;               the result (see the $$LTSEARCH^RORUTL10).
 ;
 ; Return Values:
 ;       <0  Error code (the search will be aborted)
 ;        0  Ok
 ;        1  Skip this result
 ;        2  Skip this and all remaining results
 ;
LTSCB(ROR8DST,INVDT,RESULT) ;
 N DATE,IEN,NAME,RC,TMP,VAL
 S IEN=+RESULT(2)           Q:IEN'>0 1   ; IEN of the Lab test
 S NAME=$P(RESULT(2),U,2)   Q:NAME="" 1  ; Name of the test
 S DATE=+$P(RESULT(1),U,2)  Q:DATE'>0 1  ; Date of the test
 S ROR8DST("RORUTIL")=1
 ;--- Check the result range if necessary
 I $D(RORLTRV(IEN))>1  S RC=1  D  Q:RC RC
 . S VAL=$$CLRNMVAL^RORUTL18($P(RESULT(1),U,3))
 . ;--- Skip a non-numeric result
 . Q:'$$NUMERIC^RORUTL05(VAL)
 . ;--- Check the range
 . I $G(RORLTRV(IEN,"L"))'=""  Q:VAL<RORLTRV(IEN,"L")
 . I $G(RORLTRV(IEN,"H"))'=""  Q:VAL>RORLTRV(IEN,"H")
 . S RC=0
 ;--- Store the result
 S @ROR8DST@(DATE,NAME,IEN)=$P(RESULT(1),U,3)
 Q 0
 ;
 ;***** QUERIES THE REGISTRY
 ;
 ; FLAGS         Flags for the $$SKIP^RORXU005
 ; .NSPT         Number of selected patients is returned here
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;       >0  Number of non-fatal errors
 ;
QUERY(FLAGS,NSPT) ;
 N RORLDST       ; Descriptor for Lab search API
 N RORPTN        ; Number of patients in the registry
 N RORXDST       ; Descriptor for pharmacy search API
 N RORCDLIST     ; Flag to indicate whether a clinic or division list exists
 N RORCDSTDT     ; Start date for clinic/division utilization search
 N RORCDENDT     ; End date for clinic/division utilization search
 ;
 N CNT,ECNT,IEN,IENS,LTEDT,LTSDT,PATIEN,RC,RXEDT,SKIP,SKIPEDT,SKIPSDT,TMP,UTEDT,UTIL,UTSDT,VA,VADM,XREFNODE
 N RCC,FLAG
 S XREFNODE=$NA(^RORDATA(798,"AC",+RORREG))
 S (CNT,ECNT,NSPT,RC)=0,(SKIPEDT,SKIPSDT)=0
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
 ;--- Setup the descriptors for callback API's
 I RORLAB  D
 . I RORLTST'="*",$D(@RORLTST)<10  S RORLAB=0  Q
 . S RORLDST("RORCB")="$$LTSCB^RORX012A"
 . ;--- Labs date range
 . S LTSDT=$$PARAM^RORTSK01("DATE_RANGE_2","START")\1
 . S LTEDT=$$PARAM^RORTSK01("DATE_RANGE_2","END")\1
 . ;--- Combined date range
 . S SKIPSDT=$$DTMIN^RORUTL18(SKIPSDT,LTSDT)
 . S SKIPEDT=$$DTMAX^RORUTL18(SKIPEDT,LTEDT)
 . ;--- Shift the Labs end date
 . S LTEDT=$$FMADD^XLFDT(LTEDT,1)
 I RORPHARM  D
 . I RORXL'="*",$D(@RORXL)<10  S RORPHARM=0  Q
 . S RORXDST("RORCB")="$$RXSCB^RORX012A"
 . S RORXDST("GENERIC")=$$PARAM^RORTSK01("DRUGS","AGGR_GENERIC")
 . ;--- Combined date range
 . S SKIPSDT=$$DTMIN^RORUTL18(SKIPSDT,RORXSDT)
 . S SKIPEDT=$$DTMAX^RORUTL18(SKIPEDT,RORXEDT)
 . ;--- Shift the Meds end date
 . S RXEDT=$$FMADD^XLFDT(RORXEDT\1,1)
 Q:'(RORLAB!RORPHARM) 0
 ;
 ;=== Set up Clinic/Division list parameters
 S RORCDLIST=$$CDPARMS^RORXU001(.RORTSK,.RORCDSTDT,.RORCDENDT,1)
 ;
 ;--- Browse through the registry records
 S IEN=0
 S FLAG=$G(RORTSK("PARAMS","ICD9FILT","A","FILTER"))
 F  S IEN=$O(@XREFNODE@(IEN))  Q:IEN'>0  D  Q:RC<0
 . S TMP=$S(RORPTN>0:CNT/RORPTN,1:"")
 . S RC=$$LOOP^RORTSK01(TMP)  Q:RC<0
 . S IENS=IEN_",",CNT=CNT+1
 . ;--- Get patient DFN
 . S PATIEN=$$PTIEN^RORUTL01(IEN)  Q:PATIEN'>0
 . ;check for patient list and quit if not on list
 . I $D(RORTSK("PARAMS","PATIENTS","C")),'$D(RORTSK("PARAMS","PATIENTS","C",PATIEN)) Q
 . ;--- Check if the patient should be skipped
 . Q:$$SKIP^RORXU005(IEN,FLAGS,SKIPSDT,SKIPEDT)
 . S SKIP=1,UTIL=0
 . ;--- Check if patient should be filtered because of ICD9 codes
 . S RCC=0
 . I FLAG'="ALL" D
 . . S RCC=$$ICD^RORXU010(PATIEN,RORREG)
 . I (FLAG="INCLUDE")&(RCC=0) Q
 . I (FLAG="EXCLUDE")&(RCC=1) Q
 . ;
 . ;--- Check for Clinic or Division list and quit if not in list
 . I RORCDLIST,'$$CDUTIL^RORXU001(.RORTSK,PATIEN,RORCDSTDT,RORCDENDT) Q
 . ;
 . D  I RC<0  S ECNT=ECNT+1,RC=0  Q
 . . ;--- Search for pharmacy data
 . . I RORPHARM  D  Q:RC'>0
 . . . M RORXDST("RORXGRP")=RORXGRP("C")
 . . . S RORXDST=$NA(^TMP("RORX012",$J,"PAT",PATIEN,"RX"))
 . . . K RORXDST("RORUTIL")
 . . . S RC=$$RXSEARCH^RORUTL14(PATIEN,RORXL,.RORXDST,"EIOV",RORXSDT,RXEDT)
 . . . Q:RC<0
 . . . ;S:$G(RORXDST("RORUTIL")) UTIL=1
 . . . I RC>0  S:$D(RORXDST("RORXGRP"))>1 RC=0
 . . . ;--- Invert the result if the "Did Not" logic was selected
 . . . I RORPHARM<0  S RC='RC  K @RORXDST
 . . ;--- Search for Lab data
 . . I RORLAB  D  Q:RC'>0
 . . . S RORLDST=$NA(^TMP("RORX012",$J,"PAT",PATIEN,"LR"))
 . . . K RORLDST("RORUTIL")
 . . . S RC=$$LTSEARCH^RORUTL10(PATIEN,RORLTST,.RORLDST,,LTSDT,LTEDT)
 . . . Q:RC<0
 . . . ;S:$G(RORLDST("RORUTIL")) UTIL=1
 . . . ;--- Invert the result if the "Did Not" logic was selected
 . . . S:RORLAB<0 RC='RC
 . . ;---
 . . S SKIP=0
 . ;
 . ;--- Check for any utilization in the corresponding date range
 . I 'SKIP  D:$$PARAM^RORTSK01("PATIENTS","CAREONLY")
 . . K TMP  S TMP("ALL")=1
 . . S UTIL=+$$UTIL^RORXU003(UTSDT,UTEDT,PATIEN,.TMP)
 . . S:'UTIL SKIP=1
 . ;
 . ;--- Skip the patient if not all search criteria have been met
 . I SKIP  K ^TMP("RORX012",$J,"PAT",PATIEN)  Q
 . ;
 . ;--- Get and store the patient's data
 . D VADEM^RORUTL05(PATIEN,1)
 . S TMP=$$DATE^RORXU002(VADM(6)\1)
 . S ^TMP("RORX012",$J,"PAT",PATIEN)=VA("BID")_U_VADM(1)_U_TMP
 . S NSPT=NSPT+1
 ;
 ;---
 Q $S(RC<0:RC,1:ECNT)
 ;
 ;***** CALLBACK FUNCTION FOR THE PHARMACY SEARCH API
RXSCB(ROR8DST,ORDER,ORDFLG,DRUG,DATE) ;
 N GRP,IEN,NAME,TMP
 S ROR8DST("RORUTIL")=1
 ;=== Check the drug groups
 S TMP=$$RXGRPCHK^RORXU007(.ROR8DST,+DRUG,RORXL)
 Q:TMP TMP
 ;--- Get the drug data
 I ROR8DST("GENERIC")  D
 . S IEN=+ROR8DST("RORXGEN"),NAME=$P(ROR8DST("RORXGEN"),U,2)
 E  S IEN=+DRUG,NAME=$P(DRUG,U,2)
 Q:(IEN'>0)!(NAME="") 1
 ;--- Output the data
 S @ROR8DST@(NAME,IEN)=""
 Q 0
 ;
 ;***** STORES THE REPORT DATA
 ;
 ; REPORT        IEN of the REPORT element
 ; NSPT          Number of selected patients
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;       >0  Number of non-fatal errors
 ;
STORE(REPORT,NSPT) ;
 N CNT,DATE,DFN,DOD,ECNT,IEN,ITEM,LAST4,LTLST,NAME,NODE,PTCNT,PTLST,PTNAME,RC,RXLST,TMP,VAL
 S (ECNT,RC)=0,(LTLST,PTLST,RXLST)=-1
 ;--- Force the "patient data" note in the output
 D ADDVAL^RORTSK11(RORTSK,"PATIENT",,REPORT)
 ;--- Create lab test list
 I RORLAB  D  Q:LTLST<0 LTLST
 . S LTLST=$$ADDVAL^RORTSK11(RORTSK,"LABTESTS",,REPORT)
 . D ADDATTR^RORTSK11(RORTSK,LTLST,"TABLE","LABTESTS")
 ;--- Create pharmacy list
 I RORPHARM>0  D  Q:RXLST<0 RXLST
 . S RXLST=$$ADDVAL^RORTSK11(RORTSK,"DRUGS",,REPORT)
 . D ADDATTR^RORTSK11(RORTSK,RXLST,"TABLE","DRUGS")
 ;--- Create patient list
 I (RORLAB<0)!(RORPHARM<0)  D  Q:PTLST<0 PTLST
 . S PTLST=$$ADDVAL^RORTSK11(RORTSK,"PATIENTS",,REPORT)
 . D ADDATTR^RORTSK11(RORTSK,PTLST,"TABLE","PATIENTS")
 ;---
 S (CNT,DFN,PTCNT)=0
 F  S DFN=$O(^TMP("RORX012",$J,"PAT",DFN))  Q:DFN'>0  D  Q:RC<0
 . S TMP=$S(NSPT>0:CNT/NSPT,1:"")
 . S RC=$$LOOP^RORTSK01(TMP)  Q:RC<0
 . S CNT=CNT+1,NODE=$NA(^TMP("RORX012",$J,"PAT",DFN))
 . ;--- Patient's data
 . S TMP=$G(@NODE)
 . S LAST4=$P(TMP,U),PTNAME=$P(TMP,U,2),DOD=$P(TMP,U,3)
 . ;--- Patient list
 . S TMP=$S(LTLST<0:1,1:$D(@NODE@("LR"))<10)
 . I TMP,$S(RXLST<0:1,1:$D(@NODE@("RX"))<10)  D  Q
 . . S ITEM=$$ADDVAL^RORTSK11(RORTSK,"PATIENT",,PTLST,,DFN)
 . . D ADDVAL^RORTSK11(RORTSK,"NAME",PTNAME,ITEM,1)
 . . D ADDVAL^RORTSK11(RORTSK,"LAST4",LAST4,ITEM,2)
 . . D ADDVAL^RORTSK11(RORTSK,"DOD",DOD,ITEM,1)
 . . S PTCNT=PTCNT+1
 . ;--- List of Lab tests
 . S DATE=""
 . F  S DATE=$O(@NODE@("LR",DATE))  Q:DATE=""  D
 . . S NAME=""
 . . F  S NAME=$O(@NODE@("LR",DATE,NAME))  Q:NAME=""  D
 . . . S IEN=""
 . . . F  S IEN=$O(@NODE@("LR",DATE,NAME,IEN))  Q:IEN=""  D
 . . . . S ITEM=$$ADDVAL^RORTSK11(RORTSK,"LT",,LTLST,,DFN)
 . . . . D ADDVAL^RORTSK11(RORTSK,"NAME",PTNAME,ITEM,1)
 . . . . D ADDVAL^RORTSK11(RORTSK,"LAST4",LAST4,ITEM,2)
 . . . . D ADDVAL^RORTSK11(RORTSK,"DOD",DOD,ITEM,1)
 . . . . D ADDVAL^RORTSK11(RORTSK,"DATE",DATE\1,ITEM,1)
 . . . . D ADDVAL^RORTSK11(RORTSK,"LTNAME",NAME,ITEM,1)
 . . . . S VAL=$G(@NODE@("LR",DATE,NAME,IEN))
 . . . . S TMP=$S($$NUMERIC^RORUTL05(VAL):3,1:1)
 . . . . D ADDVAL^RORTSK11(RORTSK,"RESULT",VAL,ITEM,TMP)
 . ;--- List of drugs
 . S NAME=""
 . F  S NAME=$O(@NODE@("RX",NAME))  Q:NAME=""  D
 . . S ITEM=$$ADDVAL^RORTSK11(RORTSK,"DRUG",,RXLST,,DFN)
 . . D ADDVAL^RORTSK11(RORTSK,"NAME",PTNAME,ITEM,1)
 . . D ADDVAL^RORTSK11(RORTSK,"LAST4",LAST4,ITEM,2)
 . . D ADDVAL^RORTSK11(RORTSK,"DOD",DOD,ITEM,1)
 . . D ADDVAL^RORTSK11(RORTSK,"RXNAME",NAME,ITEM,1)
 ;--- Inactivate the patient list tag if the list is empty
 D:PTCNT'>0 UPDVAL^RORTSK11(RORTSK,PTLST,,,1)
 ;---
 Q ECNT
