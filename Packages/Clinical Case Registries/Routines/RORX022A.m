RORX022A ;BPOIFO/CLR LAB DAA MONITOR (CONT.) ; 8/2/11 3:08pm
 ;;1.5;CLINICAL CASE REGISTRIES;**8,13,17,18**;Feb 17, 2006;Build 25
 ;
 ; This routine uses the following IAs:
 ;
 ; #10103 FMADD^XLFDT (supported)
 ; #10103 FMDIFF^XLFDT (supported)
 ; #10035 Direct read of the DOD field of the file #2
 ; #10000 C^%DTC (supported)
 ;   
 ;******************************************************************************
 ;PKG/PATCH    DATE        DEVELOPER    MODIFICATION
 ;-----------  ----------  -----------  ----------------------------------------
 ;ROR*1.5*18   APR  2012   C RAY        Adds select patient panel
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
 ;all lab tests
 N DATE,IEN,NAME,RC,TMP,VAL,WEEKS,DAYS,RAWDAYS
 S IEN=+RESULT(2)           Q:IEN'>0 1   ; IEN of the Lab test
 S NAME=$P(RESULT(2),U,2)   Q:NAME="" 1  ; Name of the test
 S VAL=$P(RESULT(1),U,3)    Q:VAL="" 1   ; Result of the test
 S DATE=+$P(RESULT(1),U,1)  Q:DATE'>0 1  ; Date of the test
 S RAWDAYS=$$FMDIFF^XLFDT(((9999999-DATE)\1),ROR8DST("DAA"))
 S WEEKS=RAWDAYS\7  ;Number of weeks
 S DAYS=RAWDAYS#7  ;Remainder in days
 S VAL=$$UP^XLFSTR(VAL)
 ;--- Skip value if test not performed
 I VAL["CANC"!(VAL["DNR")!(VAL["TNP") Q 1
 ;--- Skip value out of the result range
 I $D(RORLTRV(IEN))>1  S RC=1  D  Q:RC RC
 . S VAL=$$CLRNMVAL^RORUTL18($P(RESULT(1),U,3))
 . ;--- Skip a non-numeric result
 . Q:'$$NUMERIC^RORUTL05(VAL)
 . ;--- Check the range
 . I $G(RORLTRV(IEN,"L"))'=""  Q:VAL<RORLTRV(IEN,"L")
 . I $G(RORLTRV(IEN,"H"))'=""  Q:VAL>RORLTRV(IEN,"H")
 . S RC=0
 ;--- Store the result
 S @ROR8DST@(NAME,IEN,DATE)=($P(RESULT(1),U,3))_U_(+WEEKS_" weeks "_+DAYS_" days")
 Q 0
 ;
 ;***** QUERIES THE REGISTRY
 ;
 ; FLAGS         Flags for the $$SKIP^RORXU005
 ; RORTSK        Parameters passed by client
 ; .NSPT         Number of selected patients is returned here
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;       >0  Number of non-fatal errors
 ;
QUERY(FLAGS,RORTSK,NSPT) ;
 N RORLDST       ; Descriptor for Lab search API
 N RORPTN        ; Number of patients in the registry
 N RORXDST       ; Descriptor for pharmacy search API
 N RORCDLIST     ; Flag to indicate whether a clinic or division list exists
 N RORCDSTDT     ; Start date for clinic/division utilization search
 N RORCDENDT     ; End date for clinic/division utilization search
 N RORDAA        ; Date of patient's 1st DAA fill
 N RORXL         ; Location of drug list
 N RXSDT         ; RX start date
 N RXEDT         ; RX end date
 ;
 N CNT,ECNT,IEN,IENS,PATIEN,RC,SKIP,TMP,VA,VADM,XREFNODE
 N RCC,FLAG,DAASDT,DAAEDT,RORXSDT
 N LTEDT,LTSDT,LTWKDYS,LTWKS
 S XREFNODE=$NA(^RORDATA(798,"AC",+RORREG))
 S (CNT,ECNT,NSPT,RC,RORCDLIST)=0
 ;--- Number of patients in the registry
 S RORPTN=$$REGSIZE^RORUTL02(+RORREG)  S:RORPTN<0 RORPTN=0
 ;--- Date range to search for DAA meds
 S DAASDT=$$PARAM^RORTSK01("DATE_RANGE_4","START")\1
 S DAAEDT=$$PARAM^RORTSK01("DATE_RANGE_4","END")\1
 ;--- set up LAB descriptors
 S LTWKS=$$PARAM^RORTSK01("WEEKS_AFTER")
 S LTWKDYS=LTWKS*7
 S LTMREC=$$PARAM^RORTSK01("WEEKS_AFTER","MOST_RECENT")
 S RORLDST("RORCB")="$$LTSCB^RORX022A"
 ;--- set up RX descriptors
 S RORXDST("RORCB")="$$RXOCB^RORX022A"
 S RORXDST("GENERIC")=1
 S RORXL=$$ALLOC^RORTMP()
 S RC=$$DRUGLIST^RORUTL16(RORXL,+RORREG,"G")
 S RXSDT=3100101  ;based on compliance date PSN*4*293
 S RXEDT=$$FMADD^XLFDT(DAAEDT,1)
 ;--- Set up Clinic/Division list parameters
 I $D(RORTSK("PARAMS","CLINICS","C")) S RORCDLIST=1
 I $D(RORTSK("PARAMS","DIVISIONS","C")) S RORCDLIST=1
 ;--- Set up ICD9 parameters
 S FLAG=$G(RORTSK("PARAMS","ICD9FILT","A","FILTER"))
 ;
 ;--- Browse through the registry records
 S IEN=0
 F  S IEN=$O(@XREFNODE@(IEN))  Q:IEN'>0  D  Q:RC<0
 . S TMP=$S(RORPTN>0:CNT/RORPTN,1:"")
 . S RC=$$LOOP^RORTSK01(TMP)  Q:RC<0
 . S IENS=IEN_",",CNT=CNT+1
 . ;--- Get patient DFN
 . S PATIEN=$$PTIEN^RORUTL01(IEN)  Q:PATIEN'>0
 . I +$P($G(^DPT(PATIEN,.35)),U)>0 Q  ;patient has died
 . ;check for patient list and quit if not on list  ;+18
 . I $D(RORTSK("PARAMS","PATIENTS","C")),'$D(RORTSK("PARAMS","PATIENTS","C",PATIEN)) Q
 . ;--- Check if the patient should be skipped
 . Q:$$SKIP^RORXU005(IEN,FLAGS)
 . ;--- Check if patient should be skipped because of ICD9 codes
 . S RCC=0
 . I FLAG'="ALL" D
 . . S RCC=$$ICD^RORXU010(PATIEN,RORREG)
 . I (FLAG="INCLUDE")&(RCC=0) Q
 . I (FLAG="EXCLUDE")&(RCC=1) Q
 . ;--- Check if patient should be skipped because not on Clinic or Division list
 . I RORCDLIST,'$$CDUTIL^RORXU001(.RORTSK,PATIEN,DAASDT,DAAEDT) Q
 . ;--- Report specific filters
 . S SKIP=1
 . ;--- Check if patient should be skipped because no DAA fill
 . D  I RC<0  S ECNT=ECNT+1,RC=0  Q
 . . ;--- Search for 1st DAA fill date skip patient if not taking DAA
 . . S RORXDST("1STDAA")=1  ;set DAA flag
 . . D  I RC'>0 Q
 . . . S RORXDST=$$ALLOC^RORTMP()
 . . . S RC=$$RXSEARCH^RORUTL14(PATIEN,RORXL,.RORXDST,"EIOV",RXSDT,RXEDT)
 . . S SKIP=0
 . S RORDAA=$O(@RORXDST@(""))
 . I +RORDAA<DAASDT S SKIP=1  ;1st fill before daa start date
 . ;--- Skip the patient if not all search criteria have been met
 . I SKIP D FREE^RORTMP(RORXDST) Q
 . ;=== Store the patient's data
 . D VADEM^RORUTL05(PATIEN,1)
 . D FREE^RORTMP(RORXDST)
 . S ^TMP("RORX022",$J,"PAT",PATIEN)=VA("BID")_U_VADM(1)_U_RORDAA
 . ;--- Get lab tests N weeks after 1st DAA fill
 . N X,X1,X2
 . S X1=RORDAA,X2=LTWKDYS D C^%DTC S LTEDT=X
 . S LTEDT=$$FMADD^XLFDT(LTEDT\1,1)
 . ;--- If baseline requested get all lab results
 . S LTSDT=$S(LTMREC=1:"",1:RORDAA)
 . S RORLDST("DAA")=RORDAA
 . D  Q:RC<0 
 . . S RORLDST=$NA(^TMP("RORX022",$J,"PAT",PATIEN,"LR"))
 . . S RC=$$LTSEARCH^RORUTL10(PATIEN,RORLTST,.RORLDST,,LTSDT,LTEDT)
 . ;--- Get all registry med fills 60 days before 1st DAA fill
 . K RORXDST("1STDAA")  ;clear DAA flag
 . D  Q:RC<0
 . . S RORXDST=$NA(^TMP("RORX022",$J,"PAT",PATIEN,"RX"))
 . . S X1=RORDAA,X2=-60 D C^%DTC S RORXSDT=X
 . . S RORXEDT=$$FMADD^XLFDT(DT,1)
 . . S RC=$$RXSEARCH^RORUTL14(PATIEN,RORXL,.RORXDST,"EIOV",RORXSDT,RORXEDT)
 . S NSPT=NSPT+1
 Q $S(RC<0:RC,1:ECNT)
 ;
 ;
 ;***** CALLBACK FUNCTION FOR THE PHARMACY SEARCH API
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
 I ROR8DST("GENERIC")  D
 . S DRUGIEN=+ROR8DST("RORXGEN"),DRUGNAME=$P(ROR8DST("RORXGEN"),U,2)
 E  Q 1
 Q:(DRUGIEN'>0)!(DRUGNAME="") 1
 ;--- if DAA flag set, skip med if not a DAA
 I +$G(ROR8DST("1STDAA")),(DRUGNAME'="BOCEPREVIR"),(DRUGNAME'="TELAPREVIR") Q 1
 S $P(RXBUF,U,5)=$P($G(^TMP("PS",$J,0)),U,7)  ; Days Supply
 S TMP=$G(^TMP("PS",$J,"RXN",0))
 S RXNUM=$P(TMP,U)  S:RXNUM="" RXNUM=" "
 S RXCNT=0
 ;--- Original prescription
 I ORDFLG["I"  D  ;--- Inpatient
 . S OFD=$P($G(^TMP("PS",$J,0)),U,5)\1         ; Start Date
 . S RXCNT=RXCNT+1
 . S @ROR8DST@(OFD,DRUGNAME,DRUGIEN,RXNUM,RXCNT)=RXBUF
 E  D             ;--- Outpatient
 . S OFD=+$P($G(^TMP("PS",$J,"RXN",0)),U,6)  ; Original Fill Date
 . Q:(OFD<ROR8DST("RORSDT"))!(OFD'<ROR8DST("ROREDT"))
 . S RXCNT=RXCNT+1
 . S @ROR8DST@(OFD,DRUGNAME,DRUGIEN,RXNUM,RXCNT)=RXBUF
 ;--- Refills and partials
 F RPSUB="REF","PAR"  D
 . S IRP=0
 . F  S IRP=$O(^TMP("PS",$J,RPSUB,IRP))  Q:IRP'>0  D
 . . S TMP=$G(^TMP("PS",$J,RPSUB,IRP,0))
 . . S $P(RXBUF,U,5)=$P(TMP,U,2)  ; Days Supply
 . . I TMP>0  S RXCNT=RXCNT+1  D
 . . . S @ROR8DST@(+TMP,DRUGNAME,DRUGIEN,RXNUM,RXCNT)=RXBUF
 Q 0
 ;
 ;***** STORES THE REPORT DATA
 ;
 ; REPORT        IEN of the REPORT element
 ; RORTSK        Parameters passed by GUI
 ; NSPT          Number of selected patients
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;       >0  Number of non-fatal errors
 ;
STORE(REPORT,RORTSK,NSPT) ;
 N CNT,DATE,DFN,DAA,ECNT,IEN,ITEM,LAST4,LTLST,NAME,NODE,PTCNT,PTLST,PTNAME,RC,RXLST,TMP,VAL
 N DAAINV,LRMREC
 S (ECNT,RC)=0,(LTLST,PTLST,RXLST)=-1
 ;--- Force the "patient data" note in the output
 D ADDVAL^RORTSK11(RORTSK,"PATIENT",,REPORT)
 S LRMREC=$$PARAM^RORTSK01("LABTESTS","MOST_RECENT")
 ;--- Create lab test list
 D  Q:LTLST<0 LTLST
 . S LTLST=$$ADDVAL^RORTSK11(RORTSK,"LABTESTS",,REPORT)
 . D ADDATTR^RORTSK11(RORTSK,LTLST,"TABLE","LABTESTS")
 ;--- Create pharmacy list
 D  Q:RXLST<0 RXLST
 . S RXLST=$$ADDVAL^RORTSK11(RORTSK,"DRUGS",,REPORT)
 . D ADDATTR^RORTSK11(RORTSK,RXLST,"TABLE","DRUGS")
 ;--- Loop through selected patients and store as XML
 S (CNT,DFN,PTCNT)=0
 F  S DFN=$O(^TMP("RORX022",$J,"PAT",DFN))  Q:DFN'>0  D  Q:RC<0
 . S TMP=$S(NSPT>0:CNT/NSPT,1:"")
 . S RC=$$LOOP^RORTSK01(TMP)  Q:RC<0
 . S CNT=CNT+1,NODE=$NA(^TMP("RORX022",$J,"PAT",DFN))
 . ;--- Patient's data
 . S TMP=$G(@NODE)
 . S LAST4=$P(TMP,U),PTNAME=$P(TMP,U,2),DAA=$P(TMP,U,3)
 . S PTCNT=PTCNT+1
 . ;--- List of Lab tests
 . S NAME="" K LTCNT
 . F  S NAME=$O(@NODE@("LR",NAME)) Q:NAME=""  D
 . . S IEN=""
 . . F  S IEN=$O(@NODE@("LR",NAME,IEN)) Q:IEN=""  D
 . . . S DATE="",DAAINV=9999999-DAA
 . . . F  S DATE=$O(@NODE@("LR",NAME,IEN,DATE)) Q:DATE=""!($G(LTCNT(NAME,IEN))=2)!((DATE>DAAINV)&'LTMREC)  D
 . . . . ;store results after or on DAA fill date
 . . . . I DATE'>DAAINV D  Q
 . . . . . I LRMREC,$G(LTCNT(NAME,IEN))=0 Q  ;quit if most recent
 . . . . . S ITEM=$$ADDVAL^RORTSK11(RORTSK,"LT",,LTLST,,DFN)
 . . . . . D ADDVAL^RORTSK11(RORTSK,"NAME",PTNAME,ITEM,1)
 . . . . . D ADDVAL^RORTSK11(RORTSK,"LAST4",LAST4,ITEM,2)
 . . . . . D ADDVAL^RORTSK11(RORTSK,"DAA_FILL",DAA,ITEM,1)
 . . . . . D ADDVAL^RORTSK11(RORTSK,"DATE",((9999999-DATE)\1),ITEM,1)
 . . . . . D ADDVAL^RORTSK11(RORTSK,"LTNAME",NAME,ITEM,1)
 . . . . . S VAL=$G(@NODE@("LR",NAME,IEN,DATE))
 . . . . . S TMP=$S($$NUMERIC^RORUTL05($P(VAL,U)):3,1:1)
 . . . . . D ADDVAL^RORTSK11(RORTSK,"RESULT",$P(VAL,U),ITEM,TMP)
 . . . . . D ADDVAL^RORTSK11(RORTSK,"WKS_LAB",$P(VAL,U,2),ITEM,1)
 . . . . . S LTCNT(NAME,IEN)=0
 . . . . ;store 2 baseline results if flag is set
 . . . . I LTMREC D
 . . . . . S LTCNT(NAME,IEN)=$S('$D(LTCNT(NAME,IEN)):1,1:LTCNT(NAME,IEN)+1)  ;count for each test
 . . . . . Q:LTCNT(NAME,IEN)>2  ;stop after 2 baseline results
 . . . . . S ITEM=$$ADDVAL^RORTSK11(RORTSK,"LT",,LTLST,,DFN)
 . . . . . D ADDVAL^RORTSK11(RORTSK,"NAME",PTNAME,ITEM,1)
 . . . . . D ADDVAL^RORTSK11(RORTSK,"LAST4",LAST4,ITEM,2)
 . . . . . D ADDVAL^RORTSK11(RORTSK,"DAA_FILL",DAA,ITEM,1)
 . . . . . D ADDVAL^RORTSK11(RORTSK,"DATE",((9999999-DATE)\1),ITEM,1)
 . . . . . D ADDVAL^RORTSK11(RORTSK,"LTNAME",NAME,ITEM,1)
 . . . . . S VAL=$G(@NODE@("LR",NAME,IEN,DATE))
 . . . . . S TMP=$S($$NUMERIC^RORUTL05($P(VAL,U)):3,1:1)
 . . . . . D ADDVAL^RORTSK11(RORTSK,"RESULT",$P(VAL,U),ITEM,TMP)
 . . . . . D ADDVAL^RORTSK11(RORTSK,"WKS_LAB","Baseline",ITEM,1)
 . ;--- List of drugs
 . S DATE=""
 . F  S DATE=$O(@NODE@("RX",DATE))  Q:DATE=""  D
 . . S NAME=""
 . . F  S NAME=$O(@NODE@("RX",DATE,NAME))  Q:NAME=""  D
 . . . S IEN=""
 . . . F  S IEN=$O(@NODE@("RX",DATE,NAME,IEN))  Q:IEN=""  D
 . . . . S RXNUM=""
 . . . . F  S RXNUM=$O(@NODE@("RX",DATE,NAME,IEN,RXNUM)) Q:RXNUM=""  D
 . . . . . S RXCNT=""
 . . . . . F  S RXCNT=$O(@NODE@("RX",DATE,NAME,IEN,RXNUM,RXCNT)) Q:RXCNT=""  S RXBUF=@NODE@("RX",DATE,NAME,IEN,RXNUM,RXCNT) D
 . . . . . . S ITEM=$$ADDVAL^RORTSK11(RORTSK,"DRUG",,RXLST,,DFN)
 . . . . . . D ADDVAL^RORTSK11(RORTSK,"NAME",PTNAME,ITEM,1)
 . . . . . . D ADDVAL^RORTSK11(RORTSK,"LAST4",LAST4,ITEM,2)
 . . . . . . D ADDVAL^RORTSK11(RORTSK,"DAA_FILL",DAA,ITEM,1)
 . . . . . . D ADDVAL^RORTSK11(RORTSK,"FILL_DATE",DATE\1,ITEM,1)
 . . . . . . D ADDVAL^RORTSK11(RORTSK,"RXNAME",NAME,ITEM,1)
 . . . . . . D ADDVAL^RORTSK11(RORTSK,"DAYSPLY",$P(RXBUF,U,5),ITEM,1)
 ;--- Inactivate the patient list tag if the list is empty
 D:PTCNT'>0 UPDVAL^RORTSK11(RORTSK,PTLST,,,1)
 Q ECNT
