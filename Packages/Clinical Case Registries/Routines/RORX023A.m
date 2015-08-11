RORX023A ;ALB/TMK - HCV SUSTAINED VIROLOGIC RESPONSE REPORT(QUERY & STORE) ;7/15/11 3:37pm
 ;;1.5;CLINICAL CASE REGISTRIES;**24,27**;Feb 17, 2006;Build 58
 ;
 ; This routine uses the following IAs:
 ;
 ; #10103 FMADD^XLFDT (supported)
 ; #10104 UP^XLFSTR (supported)
 ;   
 ;******************************************************************************
 ;******************************************************************************
 ;                 --- ROUTINE MODIFICATION LOG ---
 ;        
 ;PKG/PATCH    DATE        DEVELOPER    MODIFICATION
 ;-----------  ----------  -----------  ----------------------------------------
 ;ROR*1.5*24   JUN 2014    T KOPP       New report
 ;ROR*1.5*27   FEB 2015    T KOPP       Fix selection of SVR chg ">" to "<" 
 ;                                      at LTSCB+11 and pull SVR/NO SVR logic
 ;                                      into callable function $$SVR
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
 N DATE,IEN,NAME,RC,TMP,VAL,CAT,SUB
 S IEN=+RESULT(2)           Q:IEN'>0 1   ; IEN of the Lab test
 S NAME=$P(RESULT(2),U,2)   Q:NAME="" 1  ; Name of the test
 S DATE=+$P(RESULT(1),U,1)  Q:DATE'>0 1  ; Date of the test
 S CAT=$P(RESULT(2),U,4)    Q:CAT="" 1   ; Category(lab group) of the test
 S VAL=$P(RESULT(1),U,3)    Q:VAL="" 1   ; Result of the test
 ;--- Skip if test is not in lab groups HepC GT, Quant, or Qual
 S TMP=0
 I CAT'="HepC GT",(CAT'="HepC Quant"),(CAT'="HepC Qual") S TMP=1
 I 'TMP,CAT'="HepC GT" D
 . S TMP=$S($E(VAL)="<":0,VAL["NOT DETECT":0,VAL["NO HCV RNA":0,VAL["NO RNA":0,$E(VAL,1,3)="NEG":0,VAL["NEGATIVE":0,VAL["NO_HCV_RNA_DETECTED":0,VAL["TND":0,1:1)
 I 'TMP,+VAL=VAL,VAL<51 S TMP=1  ;skip abnormally low values
 I TMP Q 1
 S SUB=$S(CAT="HepC GT":"GT",1:"HepC")
 ;--- Store the result
 S @ROR8DST@(SUB,DATE)=VAL
 Q 0
 ;
 ;***** QUERIES THE REGISTRY
 ; REPORT        Parent IEN of report
 ; FLAGS         Flags for the $$SKIP^RORXU005
 ; .NSPT         Number of selected patients is returned here
 ;
 ; Return Values:
 ;       <0  Fatal error
 ;        0  Ok
 ;       >0  Number of non-fatal errors
 ;
 ;  Assumes RORREG = the ien of the ROR REGISTER PARAMETERS entry in file 798.1 being processed
QUERY(REPORT,FLAGS,NSPT) ;
 N RORLDST       ; Descriptor for Lab search API
 N RORPTN        ; Number of patients in the registry
 N RORXDST       ; Descriptor for pharmacy search API
 N RORCDLIST     ; Flag to indicate whether a clinic or division list exists
 N RORCDSTDT     ; Start date for clinic/division utilization search
 N RORCDENDT     ; End date for clinic/division utilization search
 N RORXEDT       ; RX end date
 N RORXSDT       ; RX start date
 ;
 N CNT,ECNT,IEN,IENS,LTEDT,LTSDT,PATIEN,RC,RXEDT,SKIP,TMP,UTEDT,UTIL,UTSDT,VA,VADM,XREFNODE
 N RCC,FLAG,HCV,GT,ROR1,ROR2,ROR3,RORX023,RORTAKN,RORXL
 S XREFNODE=$NA(^RORDATA(798,"AC",+RORREG))
 S (CNT,ECNT,NSPT,RC)=0,(UTEDT,UTSDT)=0,RORX023=1
 ;=== Set up parameters
 ;--- Utilization date range
 D:$$PARAM^RORTSK01("PATIENTS","CAREONLY")
 . S UTSDT=$$PARAM^RORTSK01("DATE_RANGE_3","START")\1
 . S UTEDT=$$PARAM^RORTSK01("DATE_RANGE_3","END")\1
 ;--- Number of patients in the registry
 S RORPTN=$$REGSIZE^RORUTL02(+RORREG)  S:RORPTN<0 RORPTN=0
 ;--- Lab parameters
 S RORLDST("RORCB")="$$LTSCB^RORX023A"
 ;--- Labs date range
 S LTSDT=""
 S LTEDT=DT
 ;--- Shift the Labs end date
 S LTEDT=$$FMADD^XLFDT(LTEDT,1)
 ;== Pharm parameters
 S RORXDST("GENERIC")=1  ;only meds with generic name
 S RORXDST("RORCB")="$$RXOCB^RORX023A"   ;call back routine
 ;--- RX start and end dates
 S RORXSDT=2000101  ;start date 1/1/1900
 S RORXEDT=DT
 ;--- RX list of HepC registry drugs
 S RORXL=$$ALLOC^RORTMP()
 S RC=$$DRUGLIST^RORUTL16(RORXL,+RORREG)
 ;--- Shift the RXs end date
 S RORXEDT=$$FMADD^XLFDT(RORXEDT\1,1)
 ;--- Set up Clinic/Division list parameters date_range_3
 S RORCDLIST=$$CDPARMS^RORXU001(.RORTSK,.RORCDSTDT,.RORCDENDT,1)
 ;--- Set up ICD parameters
 S FLAG=$G(RORTSK("PARAMS","ICDFILT","A","FILTER"))
 ;=== Browse through the registry records
 S IEN=0
 F  S IEN=$O(@XREFNODE@(IEN))  Q:IEN'>0  D  Q:RC<0
 . S TMP=$S(RORPTN>0:CNT/RORPTN,1:"")
 . S RC=$$LOOP^RORTSK01(TMP)  Q:RC<0
 . S IENS=IEN_",",CNT=CNT+1
 . ;--- Get patient DFN
 . S PATIEN=$$PTIEN^RORUTL01(IEN)  Q:PATIEN'>0
 . I +$P($G(^DPT(PATIEN,.35)),U)>0 Q  ;patient has died
 . ;--- Check if the patient should be skipped based on standard filters
 . Q:$$SKIP^RORXU005(IEN,FLAGS,UTSDT,UTEDT)
 . ;--- Check if patient should be skipped because of ICD codes
 . S RCC=0
 . I FLAG'="ALL" D
 . . S RCC=$$ICD^RORXU010(PATIEN)
 . I (FLAG="INCLUDE")&(RCC=0) Q
 . I (FLAG="EXCLUDE")&(RCC=1) Q
 . ;
 . ;--- Check if patient should be skipped because of Clinic or Division 
 . I RORCDLIST,'$$CDUTIL^RORXU001(.RORTSK,PATIEN,RORCDSTDT,RORCDENDT) Q
 . ;=== Check meds and labs
 . ; Find last date HepC registry meds were taken, add 84 days to the date of the last med fill/refill plus the days supply
 . ; Include in report if the patient has selected HepC Quant or HepC Qual lab results:
 . ;  Result either starts with a <   -- OR -- includes the phrase "NOT DETECT" or "NO HCV RNA" or "NO RNA" or "NEGATIVE" 
 . ; -- OR -- starts "NEG"  -- OR -- = "NO_HCV_RNA_DETECTED" or "TND".) and the last result was on or after 84 days past
 . ; the last date registry med was taken calculated date.
 . ;
 . S SKIP=1,UTIL=0
 . D  I RC<0  S ECNT=ECNT+1,RC=0  Q
 . . N RORCHK
 . . S RORCHK=$$SVR(PATIEN,RORXSDT,RORXEDT,RORREG,RORXL,LTSDT,LTEDT,.RORLDST,.RORXDST),RC=RORCHK
 . . I RORCHK<0 Q  ;error
 . . I RORCHK S SKIP=0 ; SVR criteria met - don't skip
 . ;
 . ;--- Check if patient should be skipped because no utilization in the corresponding date range
 . I 'SKIP D:$$PARAM^RORTSK01("PATIENTS","CAREONLY")
 . . K TMP  S TMP("ALL")=1
 . . S UTIL=+$$UTIL^RORXU003(UTSDT,UTEDT,PATIEN,.TMP)
 . . S:'UTIL SKIP=1
 . ;
 . ;--- Skip the patient if not all selection criteria have been met
 . I SKIP K ^TMP("RORX023",$J,"PAT",PATIEN) Q
 . ;
 . ;--- Get and store the patient's data  last4^name
 . D VADEM^RORUTL05(PATIEN,1)
 . S TMP=$S($$PARAM^RORTSK01("PATIENTS","ICN"):$$ICN^RORUTL02(PATIEN),1:"")
 . S ^TMP("RORX023",$J,"PAT",PATIEN)=VA("BID")_U_VADM(1)_U_U_TMP
 . S NSPT=NSPT+1   ;increment count of selected patients
 ;
 D FREE^RORTMP(RORXL)  ;clean up drug list
 Q $S(RC<0:RC,1:ECNT)
 ;
 ;***** CALLBACK FUNCTION FOR THE PHARMACY SEARCH API
 ;
 ; Need to identify the 
 ;
 ;                .ROR8DST      Reference to the ROR8DST parameter.
 ;
 ;
 ;                 ORDER         Order number (from condensed list)
 ;
 ;                 FLAGS         Flags describing the order to be
 ;                               processed.
 ;
 ;                 DRUG          Dispensed drug
 ;                                 ^01: Drug IEN in file #50
 ;                                 ^02: Drug name
 ;
 ;                 DATE          Order date (issue date for outpatient
 ;                               drugs or start date for inpatient)
 ;
 ;Return Values:
 ;       <0  Error code (the search will be aborted)
 ;        0  Ok
 ;        1  Skip this result
 ;        2  Skip this and all remaining results
 ;
RXOCB(ROR8DST,ORDER,ORDFLG,DRUG,DATE) ;
 N DRUGIEN,DRUGNAME,IEN,IRP,OFD,RPSUB,RXBUF,RXCNT,RXNUM,RORDS,RORTAKEN,TMP
 ;--- Skip med if med does not have a generic name
 I ROR8DST("GENERIC")  D
 . S DRUGIEN=+ROR8DST("RORXGEN"),DRUGNAME=$P(ROR8DST("RORXGEN"),U,2)
 E  Q 1
 Q:(DRUGIEN'>0)!(DRUGNAME="") 1
 ;--- Process the order
 S TMP=$G(^TMP("PS",$J,"RXN",0))
 S RXNUM=$P(TMP,U)  S:RXNUM="" RXNUM=" "
 S RXCNT=0
 ;--- Original prescription
 I ORDFLG["I"  D  ;--- Inpatient
 . S OFD=$P($G(^TMP("PS",$J,0)),U,5)         ; Start Date
 . S RORDS=$P($G(^TMP("PS",$J,0)),U,7)       ; Days supply
 . S RORTAKEN=$$FMADD^XLFDT(OFD,+RORDS)      ; Last date taken
 . S RXCNT=RXCNT+1
 . S @ROR8DST@(RORTAKEN)=""
 E  D             ;--- Outpatient
 . S OFD=+$P($G(^TMP("PS",$J,"RXN",0)),U,6)   ; Original Fill Date
 . S RORDS=$P($G(^TMP("PS",$J,0)),U,7)        ; Days supply
 . S RORTAKEN=$$FMADD^XLFDT(OFD,+RORDS)       ; Last date taken
 . Q:(OFD<ROR8DST("RORSDT"))!(OFD'<ROR8DST("ROREDT"))
 . S RXCNT=RXCNT+1
 . S @ROR8DST@(RORTAKEN)=""
 ;--- Refills and partials
 F RPSUB="REF","PAR"  D
 . S $P(RXBUF,U)=$E(RPSUB,1)
 . S IRP=0
 . F  S IRP=$O(^TMP("PS",$J,RPSUB,IRP))  Q:IRP'>0  D
 . . S TMP=$G(^TMP("PS",$J,RPSUB,IRP,0))
 . . I TMP>0  S RXCNT=RXCNT+1 D
 . . . S RORDS=$P(TMP,U,2)                           ; Days supply
 . . . S RORTAKEN=$$FMADD^XLFDT(+TMP,+RORDS)         ; Last date taken
 . . . S @ROR8DST@(RORTAKEN)=""
 Q 0
 ;
 ;***** CHECKS FOR SVR CRITERIA MET
 ;PATIEN the ien of patient entry from PATIENT file (#2)
 ;RORREG the ien of the ROR REGISTER PARAMETERS entry in file 798.1 being processed
 ;RORXL Closed root of the array containing RX list of HepC registry drugs from call to $$DRUGLIST^RORUTL1
 ;RORXEDT RX end date
 ;RORXSDT RX start date
 ;LTSDT  Labs start date
 ;LTEDT   Labs end date
 ;RORLDST  Descriptor for Lab search API
 ;RORXDST  Descriptor for pharmacy search API
 ;
 ;=== SVR criteria 'rules'
 ; Find last date HepC registry meds were taken, add the days supply to the date of the last med fill/refill
 ; Include in report if the patient has selected HepC Quant or HepC Qual lab results:
 ; Result either starts with a < -- OR -- includes the phrase "NOT DETECT" or "NO HCV RNA" or "NO RNA" or "NEGATIVE" 
 ; -- OR -- starts "NEG" -- OR -- = "NO_HCV_RNA_DETECTED" or "TND".) and the last result was on or after 84 days past
 ; the last date registry med was taken calculated date.
 ;
 ; Return Values:
 ; <0 Error code
 ; 0 SVR criteria not met
 ; 1 SVR criteria met
 ;
SVR(PATIEN,RORXSDT,RORXEDT,RORREG,RORXL,LTSDT,LTEDT,RORLDST,RORXDST) ; 
 N RC,RORLABDT,RORTAKN
 ; Get registry meds for patient
 S RORXDST=$NA(^TMP("RORX023",$J,"PAT",PATIEN,"RX"))
 S RC=$$RXSEARCH^RORUTL14(PATIEN,RORXL,.RORXDST,"EIOV",RORXSDT,RORXEDT)
 I RC<0 Q RC  ;error occurred
 I $G(RORXDST("SKIP"))!'$O(@RORXDST@("")) K RORXDST("SKIP") Q 0 ;patient never took or still takes registry meds
 ;
 S RORLDST=$NA(^TMP("RORX023",$J,"PAT",PATIEN,"LR"))
 S RC=$$LTSEARCH^RORUTL10(PATIEN,+RORREG,.RORLDST,,LTSDT,LTEDT)
 I RC<0 Q RC  ;error
 ;=== SVR if patient has a qualifying lab test at least 84 days past the last med taken date
 I '$O(@RORLDST@("HepC","")) Q 0  ; No lab result date
 S RORLABDT=(9999999-$O(@RORLDST@("HepC","")))/1 ; Data stored inversely, reverse to normal and strip time
 S RORTAKN=$O(@RORXDST@(" "),-1)
 I 'RORTAKN Q 0  ; No last taken date
 I RORLABDT<$$FMADD^XLFDT(RORTAKN,84) Q 0  ; No qualifying lab test at least 84 days past the last taken date
 Q 1
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
 N RORFDT        ;med last taken date
 N RORLBG        ;lab test type (GT, HCV)
 N RORLVAL       ;lab value
 N RORLDST
 N RORXDST
 N RORICN
 N RORBODY,PTAG  ;parent iens
 N CNT,DATE,DFN,ECNT,IEN,LAST4,LTLST,NAME,NODE,PTCNT,PTLST,PTNAME,RC,RXLST,TMP,VAL,THIST
 N GT,HCV,HCVHEPC
 S (ECNT,RC)=0,(LTLST,PTLST,RXLST)=-1
 ;--- Create 'patients' table
 S RORBODY=$$ADDVAL^RORTSK11(RORTSK,"PATIENTS",,REPORT)
 D ADDATTR^RORTSK11(RORTSK,RORBODY,"TABLE","PATIENTS")
 S (CNT,DFN,PTCNT)=0
 F  S DFN=$O(^TMP("RORX023",$J,"PAT",DFN))  Q:DFN'>0  D  Q:RC<0
 . S TMP=$S(NSPT>0:CNT/NSPT,1:"")
 . S RC=$$LOOP^RORTSK01(TMP)  Q:RC<0
 . S CNT=CNT+1,NODE=$NA(^TMP("RORX023",$J,"PAT",DFN))
 . ;--- Patient's data
 . S TMP=$G(@NODE)
 . S LAST4=$P(TMP,U),PTNAME=$P(TMP,U,2),RORICN=$P(TMP,U,4)
 . ;--- get lab results
 . S RORLDST=$NA(^TMP("RORX023",$J,"PAT",DFN,"LR"))
 . S RORXDST=$NA(^TMP("RORX023",$J,"PAT",DFN,"RX"))
 . ;--- Gets most recent result for Qualifying HepC and GT lab tests
 . ;    HEPC=date of most recent quanitative or qualitative test^result
 . ;    GT=date of most recent GT test^result
 . K HEPC,GT
 . F RORLBG="HepC","GT" D
 . . S NODE=$$UP^XLFSTR(RORLBG),@NODE="^"
 . . S RORFDT=$O(@RORLDST@(RORLBG,""))
 . . Q:RORFDT=""
 . . S RORLVAL=$G(@RORLDST@(RORLBG,RORFDT))
 . . S RORFDT=(9999999-RORFDT)\1  ;strip time  
 . . S @NODE=(RORFDT)_U_RORLVAL
 . S PTAG=$$ADDVAL^RORTSK11(RORTSK,"PATIENT",,RORBODY,,DFN)
 . S RORFDT=$O(@RORXDST@(""),-1)
 . ;--- store
 . D ADDVAL^RORTSK11(RORTSK,"NAME",PTNAME,PTAG,1)
 . D ADDVAL^RORTSK11(RORTSK,"LAST4",LAST4,PTAG,2)
 . D ADDVAL^RORTSK11(RORTSK,"HCV_DATE",$P(HEPC,U),PTAG,1)
 . D ADDVAL^RORTSK11(RORTSK,"HCV",$P(HEPC,U,2),PTAG,3)
 . D ADDVAL^RORTSK11(RORTSK,"GT",$P(GT,U,2),PTAG,1)
 . D ADDVAL^RORTSK11(RORTSK,"LAST_TAKEN",RORFDT,PTAG,1)
 . I $$PARAM^RORTSK01("PATIENTS","ICN") D ADDVAL^RORTSK11(RORTSK,"ICN",RORICN,PTAG,1)
 . S PTCNT=PTCNT+1
 ;--- Inactivate the patient list tag if the list is empty
 D:PTCNT'>0 UPDVAL^RORTSK11(RORTSK,PTLST,,,1)
 ;---
 Q ECNT
