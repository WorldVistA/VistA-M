RORX021A ;BPOIFO/CLR - HCV DAA CANDIDATES(QUERY & STORE) ;7/15/11 3:37pm
 ;;1.5;CLINICAL CASE REGISTRIES;**17,19,21**;Feb 17, 2006;Build 45
 ;
 ; This routine uses the following IAs:
 ;
 ; #10103 FMADD^XLFDT (supported)
 ; #10035 Direct read of the DOD field of the file #2 (supported)
 ; #10000 C^%DTC (supported)
 ; #10103 $$TRIM^XLFSTR (supported)
 ; #10103 $$UP^XLFSTR (supported)
 ;   
 ;******************************************************************************
 ;******************************************************************************
 ;                 --- ROUTINE MODIFICATION LOG ---
 ;        
 ;PKG/PATCH    DATE        DEVELOPER    MODIFICATION
 ;-----------  ----------  -----------  ----------------------------------------
 ;ROR*1.5*19   JUN  2012   K GUPTA      Support for ICD-10 Coding System
 ;ROR*1.5*21   SEP 2013    T KOPP       Added ICN as last report column if
 ;                                      additional identifier option selected
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
 I CAT'="HepC GT",(CAT'="HepC Quant"),(CAT'="HepC Qual") Q 1
 ;=== Mark values as quantitative, qualitative or responded to treatment
 ;---  HCVQT=quant,HCVQL=qual,HCVOK=cured
 I CAT="HepC Quant"!(CAT="HepC Qual") D  Q:TMP 1
 . S TMP=0
 . S VAL=$$UP^XLFSTR(VAL)  ;convert to upper case
 . S VAL=$TR(VAL," ")  ;strip out all spaces
 . I VAL["POS" S SUB="HCVQL" Q
 . I $E(VAL,1,1)="P" S SUB="HCVQL" Q
 . I VAL["NEG" S SUB="HCVOK" Q
 . I VAL["NO" S SUB="HCVOK" Q
 . I $E(VAL,1,1)="N" S SUB="HCVOK" Q
 . I VAL["COMMENT"!(VAL["CANC")!(VAL["DNR")!(VAL["TNP") S TMP=1 Q
 . I +VAL=VAL,VAL<51 S TMP=1 Q  ;skip abnormally low values
 . I $$NUMERIC^RORUTL05($TR(VAL," >,GT")) S SUB="HCVQT" Q
 . I $$NUMERIC^RORUTL05($TR(VAL," <,LT")) S SUB="HCVOK" Q
 . S TMP=1
 S SUB=$S(CAT="HepC GT":"GT",1:SUB)
 ;--- Store the result
 S @ROR8DST@(SUB,DATE)=$P(RESULT(1),U,3)
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
QUERY(REPORT,FLAGS,NSPT) ;
 N RORLDST       ; Descriptor for Lab search API
 N RORPTN        ; Number of patients in the registry
 N RORXDST       ; Descriptor for pharmacy search API
 N RORCDLIST     ; Flag to indicate whether a clinic or division list exists
 N RORCDSTDT     ; Start date for clinic/division utilization search
 N RORCDENDT     ; End date for clinic/division utilization search
 N RORXCDT       ; User selected cut off date for registry meds
 N RORTS         ; User selected treatment status categories
 N RORXEDT       ; RX end date
 N RORXSDT       ; RX start date
 N RORTH         ; Patient treatment status (EXP=experienced, NAIVE=naive)
 ;
 N CNT,ECNT,IEN,IENS,LTEDT,LTSDT,PATIEN,RC,RXEDT,SKIP,TMP,UTEDT,UTIL,UTSDT,VA,VADM,XREFNODE
 N RCC,FLAG,HCV,GT,ROR1,ROR2,ROR3
 S XREFNODE=$NA(^RORDATA(798,"AC",+RORREG))
 S (CNT,ECNT,NSPT,RC)=0,(UTEDT,UTSDT)=0
 ;=== Set up parameters
 ;--- Utilization date range
 D:$$PARAM^RORTSK01("PATIENTS","CAREONLY")
 . S UTSDT=$$PARAM^RORTSK01("DATE_RANGE_3","START")\1
 . S UTEDT=$$PARAM^RORTSK01("DATE_RANGE_3","END")\1
 ;--- Number of patients in the registry
 S RORPTN=$$REGSIZE^RORUTL02(+RORREG)  S:RORPTN<0 RORPTN=0
 ;--- Set up Treatment status parameters
 F TMP="NAIVE","EXP","EXP_DAYS" D
 . S RORTS(TMP)=$$PARAM^RORTSK01("TREATMENT_HISTORY",TMP)
 ;--- Lab parameters
 S RORLDST("RORCB")="$$LTSCB^RORX021A"
 ;--- Labs date range
 S LTSDT=""
 S LTEDT=DT
 ;--- Shift the Labs end date
 S LTEDT=$$FMADD^XLFDT(LTEDT,1)
 ;== Pharm parameters
 S RORXDST("GENERIC")=1  ;only meds with generic name
 S RORXDST("RORCB")="$$RXOCB^RORX021A"   ;call back routine
 ;--- RX cut off date (inverse)/shift cut off back one day
 N X1,X2,X S X2=-(+RORTS("EXP_DAYS")+1),X1=DT D C^%DTC S RORXCDT=99999999-X
 ;--- RX start and end dates
 S RORXSDT=2000101  ;start date 1/1/1900
 S RORXEDT=DT
 ;--- RX list of HepC registry drugs
 S RORXL=$$ALLOC^RORTMP()
 S RC=$$DRUGLIST^RORUTL16(RORXL,+RORREG)
 ;--- Shift the Labs end date
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
 . ;=== Check labs and meds
 . S SKIP=1,UTIL=0
 . D  I RC<0  S ECNT=ECNT+1,RC=0  Q
 . . S RORLDST=$NA(^TMP("RORX021",$J,"PAT",PATIEN,"LR"))
 . . S RC=$$LTSEARCH^RORUTL10(PATIEN,+RORREG,.RORLDST,,LTSDT,LTEDT)
 . . Q:RC'>0
 . . ;--- Skip if most recent GT result is not Genotype 1
 . . S TMP=+$O(@RORLDST@("GT","")) I TMP=0 S SKIP=1 Q
 . . I $G(@RORLDST@("GT",TMP))'[1 S SKIP=1 Q 
 . . ;=== Skip if patient no longer has HCV
 . . S ROR1=+$O(@RORLDST@("HCVOK","")),ROR2=+$O(@RORLDST@("HCVQL","")),ROR3=(+$O(@RORLDST@("HCVQT","")))
 . . I ROR1>0 D  Q:SKIP=1
 . . . ;--- Skip if date of most recent HCV test is normal
 . . . I (ROR1<ROR2),(ROR1<ROR3) S SKIP=1 Q
 . . . I (ROR1<ROR2),(ROR3=0) S SKIP=1 Q
 . . . I (ROR1<ROR3),(ROR2=0) S SKIP=1 Q
 . . . ;--- Skip if no qual or quant test
 . . . I ROR2+ROR3=0 S SKIP=1 Q
 . . . S SKIP=0
 . . ;--- Check if patient should be skipped because of user selected Treatment status
 . . S RORXDST=$NA(^TMP("RORX021",$J,"PAT",PATIEN,"RX"))
 . . S RC=$$RXSEARCH^RORUTL14(PATIEN,RORXL,.RORXDST,"EIOV",RORXSDT,RORXEDT)
 . . Q:RC<0  ;error occurred
 . . I $G(RORXDST("SKIP")) S SKIP=1 K RORXDST("SKIP") Q  ;skip if taking DAA meds
 . . I RC>0,'+RORTS("EXP") S SKIP=1 Q  ; skip naive patients 
 . . I RC=0,'+RORTS("NAIVE") S SKIP=1 Q  ;skip experienced patients
 . . I RC>0,$O(@RORXDST@(RORXCDT),-1) S SKIP=1 Q  ;skip if patient has meds after cutoff
 . . ;--- Include patient 
 . . S RORTH=$S(RC>0:"EXP",RC=0:"NAIVE",1:"")
 . . S SKIP=0
 . ;--- Check if patient should be skipped because no utilization in the corresponding date range
 . I 'SKIP D:$$PARAM^RORTSK01("PATIENTS","CAREONLY")
 . . K TMP  S TMP("ALL")=1
 . . S UTIL=+$$UTIL^RORXU003(UTSDT,UTEDT,PATIEN,.TMP)
 . . S:'UTIL SKIP=1
 . ;
 . ;--- Skip the patient if not all selection criteria have been met
 . I SKIP K ^TMP("RORX021",$J,"PAT",PATIEN)  Q
 . ;
 . ;--- Get and store the patient's data  last4^name^treatment status
 . D VADEM^RORUTL05(PATIEN,1)
 . S TMP=$S($$PARAM^RORTSK01("PATIENTS","ICN"):$$ICN^RORUTL02(PATIEN),1:"")
 . S ^TMP("RORX021",$J,"PAT",PATIEN)=VA("BID")_U_VADM(1)_U_RORTH_U_TMP
 . S NSPT=NSPT+1   ;increment count of selected patients
 ;
 D FREE^RORTMP(RORXL)  ;clean up drug list
 Q $S(RC<0:RC,1:ECNT)
 ;
 ;***** CALLBACK FUNCTION FOR THE PHARMACY SEARCH API
 ;
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
 N DRUGIEN,DRUGNAME,IEN,IRP,OFD,RPSUB,RXBUF,RXCNT,RXNUM,TMP
 ;--- Skip med if med does not have a generic name
 I ROR8DST("GENERIC")  D
 . S DRUGIEN=+ROR8DST("RORXGEN"),DRUGNAME=$P(ROR8DST("RORXGEN"),U,2)
 E  Q 1
 Q:(DRUGIEN'>0)!(DRUGNAME="") 1
 ;--- Skip patient if med is DAA med
 I DRUGNAME="BOCEPREVIR"!(DRUGNAME="TELAPREVIR") S ROR8DST("SKIP")=1 Q 2
 ;--- Process the order
 S TMP=$G(^TMP("PS",$J,"RXN",0))
 S RXNUM=$P(TMP,U)  S:RXNUM="" RXNUM=" "
 S RXCNT=0
 ;--- Original prescription
 I ORDFLG["I"  D  ;--- Inpatient
 . S OFD=$P($G(^TMP("PS",$J,0)),U,5)         ; Start Date
 . S RXCNT=RXCNT+1
 . S @ROR8DST@((99999999-OFD),DRUGNAME,DRUGIEN,RXNUM,RXCNT)=""
 E  D             ;--- Outpatient
 . S OFD=+$P($G(^TMP("PS",$J,"RXN",0)),U,6)  ; Original Fill Date
 . Q:(OFD<ROR8DST("RORSDT"))!(OFD'<ROR8DST("ROREDT"))
 . S RXCNT=RXCNT+1
 . S @ROR8DST@((99999999-OFD),DRUGNAME,DRUGIEN,RXNUM,RXCNT)=""
 ;--- Refills and partials
 F RPSUB="REF","PAR"  D
 . S $P(RXBUF,U)=$E(RPSUB,1)
 . S IRP=0
 . F  S IRP=$O(^TMP("PS",$J,RPSUB,IRP))  Q:IRP'>0  D
 . . S TMP=$G(^TMP("PS",$J,RPSUB,IRP,0))
 . . I TMP>0  S RXCNT=RXCNT+1,TMP=99999999-TMP  D
 . . . S @ROR8DST@(+TMP,DRUGNAME,DRUGIEN,RXNUM,RXCNT)=""
 Q 0
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
 N RORFDT        ;med fill date
 N RORLBG        ;lab test type (GT, HCVQT,HCVQL)
 N RORLVAL       ;lab value
 N RORRX         ;med name
 N RORSTNAM      ;
 N RORLDST
 N RORXDST
 N RORICN
 N RORBODY,PTAG  ;parent iens
 N CNT,DATE,DFN,ECNT,IEN,LAST4,LTLST,NAME,NODE,PTCNT,PTLST,PTNAME,RC,RXLST,TMP,VAL,THIST
 N GT,HCVQT,HCV,HCVQL
 S (ECNT,RC)=0,(LTLST,PTLST,RXLST)=-1
 ;--- Create 'patients' table
 S RORBODY=$$ADDVAL^RORTSK11(RORTSK,"PATIENTS",,REPORT)
 D ADDATTR^RORTSK11(RORTSK,RORBODY,"TABLE","PATIENTS")
 S (CNT,DFN,PTCNT)=0
 F  S DFN=$O(^TMP("RORX021",$J,"PAT",DFN))  Q:DFN'>0  D  Q:RC<0
 . S TMP=$S(NSPT>0:CNT/NSPT,1:"")
 . S RC=$$LOOP^RORTSK01(TMP)  Q:RC<0
 . S CNT=CNT+1,NODE=$NA(^TMP("RORX021",$J,"PAT",DFN))
 . ;--- Patient's data
 . S TMP=$G(@NODE)
 . S LAST4=$P(TMP,U),PTNAME=$P(TMP,U,2),THIST=$P(TMP,U,3),RORICN=$P(TMP,U,4)
 . ;--- get lab results
 . S RORLDST=$NA(^TMP("RORX021",$J,"PAT",DFN,"LR"))
 . S RORXDST=$NA(^TMP("RORX021",$J,"PAT",DFN,"RX"))
 . ;--- Gets most recent result for HepC Qual, HepC Quant and GT
 . ;    HCVQT=date of most recent quanitative test^result
 . ;    HCVQL=date of most recent qualitative test^result
 . ;    GT=date of most recent GT test^result
 . K HCVQT,HCVQL,GT
 . F RORLBG="HCVQT","HCVQL","GT" D
 . . S NODE=RORLBG,@NODE="^"
 . . S RORFDT=$O(@RORLDST@(RORLBG,""))
 . . Q:RORFDT=""
 . . S RORLVAL=$G(@RORLDST@(RORLBG,RORFDT))
 . . S RORFDT=9999999-RORFDT
 . . S RORFDT=RORFDT\1  ;strip time  
 . . S @NODE=(RORFDT)_U_RORLVAL
 . ;--- get most recent registry med if experienced
 . ;--- if more than one med give preference to INTERFERON
 . S RORFDT=$O(@RORXDST@("")),RORRX=""
 . I THIST="EXP" D
 . . S RORSTNAM="",RORRX=""
 . . F  S RORSTNAM=$O(@RORXDST@(RORFDT,RORSTNAM)) Q:RORSTNAM=""  D
 . . . S RORRX=$S(RORRX="":RORSTNAM,RORRX["INTERFERON":RORRX,1:RORSTNAM)
 . . S RORFDT=99999999-RORFDT
 . . S RORFDT=RORFDT\1
 . S PTAG=$$ADDVAL^RORTSK11(RORTSK,"PATIENT",,RORBODY,,DFN)
 . ;--- give preference to quant result over qual result
 . S HCV=$S(+$G(HCVQL)>+$G(HCVQT):HCVQL,$G(HCVQT):HCVQT,1:"")
 . ;--- store
 . D ADDVAL^RORTSK11(RORTSK,"NAME",PTNAME,PTAG,1)
 . D ADDVAL^RORTSK11(RORTSK,"LAST4",LAST4,PTAG,2)
 . D ADDVAL^RORTSK11(RORTSK,"STATUS",THIST,PTAG,1)
 . D ADDVAL^RORTSK11(RORTSK,"HCV_DATE",$P(HCV,U),PTAG,1)
 . D ADDVAL^RORTSK11(RORTSK,"HCV",$P(HCV,U,2),PTAG,3)
 . D ADDVAL^RORTSK11(RORTSK,"GT",$P(GT,U,2),PTAG,1)
 . D ADDVAL^RORTSK11(RORTSK,"FILL_DATE",RORFDT,PTAG,1)
 . D ADDVAL^RORTSK11(RORTSK,"FILL_MED",RORRX,PTAG,1)
 . I $$PARAM^RORTSK01("PATIENTS","ICN") D ADDVAL^RORTSK11(RORTSK,"ICN",RORICN,PTAG,1)
 . S PTCNT=PTCNT+1
 ;--- Inactivate the patient list tag if the list is empty
 D:PTCNT'>0 UPDVAL^RORTSK11(RORTSK,PTLST,,,1)
 ;---
 Q ECNT
