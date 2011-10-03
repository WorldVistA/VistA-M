RORX011 ;HOIFO/SG,VAC - PATIENT MEDICATION HISTORY ;4/17/09 10:45am
 ;;1.5;CLINICAL CASE REGISTRIES;**1,8,13**;Feb 17, 2006;Build 27
 ;
 ; This routine uses the following IAs:
 ;
 ; #10103 DT^XLFDT, FMADD^XLFDT (supported)
 ;    
 ;******************************************************************************
 ;******************************************************************************
 ;                 --- ROUTINE MODIFICATION LOG ---
 ;        
 ;PKG/PATCH    DATE        DEVELOPER    MODIFICATION
 ;-----------  ----------  -----------  ----------------------------------------
 ;ROR*1.5*8    MAR  2010   V CARR       Modified to handle ICD9 filter for
 ;                                      'include' or 'exclude'.
 ;ROR*1.5*13   DEC  2010   A SAUNDERS   Added #refills remaining and logic
 ;                                      to include only most recent fills
 ;                                      NOTE: Patch 11 became patch 13.
 ;                                      Any references to patch 11 in the code
 ;                                      below is referring to path 13.
 ;
 ;******************************************************************************
 ;******************************************************************************
 Q
 ;
 ;***** OUTPUTS THE REPORT HEADER
 ;
 ; PARTAG        Reference (IEN) to the parent tag
 ;
 ; Return Values:
 ;       <0  Error code
 ;       >0  IEN of the HEADER element
 ;
HEADER(PARTAG) ;
 ;;PATIENTS(#,NAME,LAST4,DOB,AGE,DOD)
 ;;PTRXL(DATE,ORDER,TYPE,NAME,GENERIC,DAYSPLY,FILLTYPE,REFILLS)
 ;REFILLS added to column headers (above) - Patch 11
 N HEADER,NOTES,RC
 S HEADER=$$HEADER^RORXU002(.RORTSK,PARTAG)
 Q:HEADER<0 HEADER
 S NOTES=$$ADDVAL^RORTSK11(RORTSK,"NOTES",,HEADER)
 D ADDVAL^RORTSK11(RORTSK,"AGE",$$DT^XLFDT,NOTES)
 S RC=$$TBLDEF^RORXU002("HEADER^RORX011",HEADER)
 Q $S(RC<0:RC,1:HEADER)
 ;
 ;***** OUTPUTS THE PARAMETERS TO THE REPORT
 ;
 ; PARTAG        Reference (IEN) to the parent tag
 ;
 ; [.STDT]       Start and end dates of the report
 ; [.ENDT]       are returned via these parameters
 ; [.FLAGS]      Flags for the $$SKIP^RORXU005 are returned via this parameter
 ;
 ; Return Values:
 ;       <0  Error code
 ;       >0  IEN of the PARAMETERS element
 ;
PARAMS(PARTAG,STDT,ENDT,FLAGS) ;
 N PARAMS,TMP
 S PARAMS=$$PARAMS^RORXU002(.RORTSK,PARTAG,.STDT,.ENDT,.FLAGS)
 Q:PARAMS<0 PARAMS
 ;--- Process the drug list and options
 S TMP=$$DRUGLST^RORXU007(.RORTSK,PARAMS,.RORXL,.RORXGRP)
 Q:TMP<0 TMP
 ;
 Q PARAMS
 ;
 ;***** PROCESS THE PATIENT'S DATA
 ;
 ; PTLIST        Reference (IEN) to the parent tag
 ; PATIEN        Patient IEN in the file #2 (DFN)
 ; RORXDST       Patient's Medication History data
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;       >0  Number of non-fatal errors
 ;
PATIENT(PTLIST,PATIEN,RORXDST) ;
 N BUF,FLT,FLTL,FQL,ITEM,NODE,PTAG,QSB,RC,TABLE,VA,VADM,VAERR
 S (ECNT,RC)=0
 ;--- Patient data
 S PTAG=$$ADDVAL^RORTSK11(RORTSK,"PATIENT",,PTLIST,,PATIEN)
 Q:PTAG<0 PTAG
 D VADEM^RORUTL05(PATIEN,1)
 D ADDVAL^RORTSK11(RORTSK,"NAME",VADM(1),PTAG,1)
 D ADDVAL^RORTSK11(RORTSK,"LAST4",VA("BID"),PTAG,2)
 D ADDVAL^RORTSK11(RORTSK,"DOB",$$DATE^RORXU002(VADM(3)\1),PTAG,1)
 D ADDVAL^RORTSK11(RORTSK,"AGE",VADM(4),PTAG,3)
 D ADDVAL^RORTSK11(RORTSK,"DOD",$$DATE^RORXU002(VADM(6)\1),PTAG,1)
 ;--- List of drugs
 S TABLE=$$ADDVAL^RORTSK11(RORTSK,"PTRXL",,PTAG)
 Q:TABLE<0 TABLE
 D ADDATTR^RORTSK11(RORTSK,TABLE,"TABLE","PTRXL")
 ;---
 S NODE=RORXDST,FLTL=$L(NODE)-1,FLT=$E(NODE,1,FLTL)
 S QSB=$QL(NODE),FQL=QSB+5
 F  S NODE=$Q(@NODE)  Q:$E(NODE,1,FLTL)'=FLT  D:$QL(NODE)=FQL
 . ; NODE: @RORXDST@(DATE,DRUGNAME,DRUGIEN,RXNUM,RXCNT)
 . S BUF=@NODE
 . S ITEM=$$ADDVAL^RORTSK11(RORTSK,"DRUG",,TABLE)
 . D ADDVAL^RORTSK11(RORTSK,"DATE",$QS(NODE,QSB+1)\1,ITEM,1)
 . D ADDVAL^RORTSK11(RORTSK,"ORDER",$QS(NODE,QSB+4),ITEM,1)
 . S TMP=$P(BUF,U)
 . S TMP=$S(TMP="O":"ORIGINAL",TMP="P":"PARTIAL",TMP="R":"REFILL",1:"")
 . D ADDVAL^RORTSK11(RORTSK,"TYPE",TMP,ITEM,1)
 . D ADDVAL^RORTSK11(RORTSK,"NAME",$QS(NODE,QSB+2),ITEM,1)
 . D ADDVAL^RORTSK11(RORTSK,"GENERIC",$P(BUF,U,4),ITEM,1)
 . D ADDVAL^RORTSK11(RORTSK,"DAYSPLY",$P(BUF,U,5),ITEM,1)
 . S TMP=$P(BUF,U,2)
 . S TMP=$S(TMP="I":"INPATIENT",TMP="M":"MAIL",TMP="W":"WINDOW",1:"")
 . D ADDVAL^RORTSK11(RORTSK,"FILLTYPE",TMP,ITEM,1)
 . D ADDVAL^RORTSK11(RORTSK,"REFILLS",$P(BUF,U,6),ITEM,1) ;number of refills remaining - Patch 11
 ;---
 Q $S(RC<0:RC,1:ECNT)
 ;
 ;***** PROCESSES THE LIST OF PATIENTS
 ;
 ; REPORT        Reference (IEN) to the parent tag
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;       >0  Number of non-fatal errors
 ;
PROCESS(REPORT,FLAGS) ;
 N CNT,ECNT,IEN798,PTIEN,PTLIST,PTNODE,RC,RORPTN,RORXDST,RXFLAGS,TMP,DFN
 N RORX011 S RORX011=1 ;Patch 11: needed for 'callback' function setup in PROCESS^RORUTL15
 S (CNT,ECNT,RC)=0
 N RCC,FLAG
 N RORCDLIST     ; Flag to indicate whether a clinic or division list exists
 N RORCDSTDT     ; Start date for clinic/division utilization search
 N RORCDENDT     ; End date for clinic/division utilization search
 ;
 ;--- Count patients in the list.  Define which patient 'list' to use: the one 
 ;selected by the user, or all patients in 798
 I RORALL  D  S:RORPTN<0 RORPTN=0
 . S PTNODE=$NA(^RORDATA(798,"ARP",RORREG_"#"))
 . S RORPTN=$$REGSIZE^RORUTL02(+RORREG)
 E  S (PTIEN,RORPTN)=0  D  Q:RORPTN'>0 0
 . S PTNODE=$NA(RORTSK("PARAMS","PATIENTS","C"))
 . F  S PTIEN=$O(@PTNODE@(PTIEN))  Q:PTIEN'>0  S RORPTN=RORPTN+1
 ;---
 S PTLIST=$$ADDVAL^RORTSK11(RORTSK,"PATIENTS",,REPORT)
 Q:PTLIST<0 PTLIST
 ;
 ;--- Prepare parameters for the pharmacy search API
 S RORXDST=$NA(^TMP("RORX011",$J))
 S RORXDST("RORCB")="$$RXSCB^RORX011"
 S RXFLAGS="E"
 S:$$PARAM^RORTSK01("PATIENTS","INPATIENT") RXFLAGS=RXFLAGS_"IV"
 S:$$PARAM^RORTSK01("PATIENTS","OUTPATIENT") RXFLAGS=RXFLAGS_"O"
 ;
 ;=== Set up Clinic/Division list parameters
 S RORCDLIST=$$CDPARMS^RORXU001(.RORTSK,.RORCDSTDT,.RORCDENDT)
 ;
 ;--- Browse through the list of selected patients
 S (CNT,PTIEN)=0
 S FLAG=$G(RORTSK("PARAMS","ICD9FILT","A","FILTER"))
 ;
 F  S PTIEN=$O(@PTNODE@(PTIEN))  Q:PTIEN'>0  D  Q:RC<0
 . S RC=$$LOOP^RORTSK01(CNT/RORPTN)  Q:RC<0
 . S CNT=CNT+1,IEN798=$$PRRIEN^RORUTL01(PTIEN,RORREG)  Q:IEN798'>0
 . ;--- Check if the patient should be skipped
 . I RORALL  Q:$$SKIP^RORXU005(IEN798,FLAGS,RORSDT,ROREDT)
 . ;--- Check the patient against the ICD9 Filter
 . S RCC=0
 . I FLAG'="ALL" D
 . . S RCC=$$ICD^RORXU010(PTIEN,RORREG)
 . I (FLAG="INCLUDE")&(RCC=0) Q
 . I (FLAG="EXCLUDE")&(RCC=1) Q
 . ;--- End of check for ICD9 Filter
 . ;--- Check for Clinic or Division list and quit if not in list
 . I RORCDLIST,'$$CDUTIL^RORXU001(.RORTSK,PTIEN,RORCDSTDT,RORCDENDT) Q
 . ;--- Search the pharmacy data
 . K @RORXDST
 . S TMP=$$RXSEARCH^RORUTL14(PTIEN,RORXL,.RORXDST,RXFLAGS,RORSDT,ROREDT1)
 . I TMP<0  S ECNT=ECNT+1  Q
 . I RORALL  Q:TMP'>0
 . ;--- If user selected most recent drug fills, remove older duplicates
 . I $$PARAM^RORTSK01("OPTIONS","RECENT_FILLS") D RECENT(RORXDST)
 . ;--- Append the patient's data to the report
 . S TMP=$$PATIENT(PTLIST,PTIEN,RORXDST)
 . I TMP  S ECNT=ECNT+$S(TMP>0:TMP,1:1)  Q
 ;
 ;--- Cleanup
 K @RORXDST
 K ^TMP("RORX011-RESORTED",$J) ;Patch 11
 Q $S(RC<0:RC,1:ECNT)
 ;
 ;***** COMPILES THE "PATIENT DRUG HISTORY" REPORT
 ; REPORT CODE: 011
 ;
 ; .RORTSK       Task number and task parameters
 ;
 ; The ^TMP("RORX011",$J) global node is used by this function.
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
RXHIST(RORTSK) ;
 N RORALL        ; Consider all registry patients
 N ROREDT        ; End date
 N ROREDT1       ; End date + 1
 N RORREG        ; Registry IEN
 N RORSDT        ; Start date
 N RORXGRP       ; List of drug groups
 N RORXL         ; Closed root of the medication list
 ;
 N ECNT,FLAGS,RC,REPORT,TMP
 S RORXL="",(ECNT,RC)=0
 K ^TMP("RORX011",$J)
 ;
 ;--- Root node of the report
 S REPORT=$$ADDVAL^RORTSK11(RORTSK,"REPORT")
 Q:REPORT<0 REPORT
 ;
 D
 . ;--- Get and prepare the report parameters
 . S RORREG=+$$PARAM^RORTSK01("REGIEN")
 . S RORALL=$$PARAM^RORTSK01("PATIENTS","ALL")
 . S RC=$$PARAMS(REPORT,.RORSDT,.ROREDT,.FLAGS)  Q:RC<0
 . S ROREDT1=$$FMADD^XLFDT(ROREDT\1,1)
 . ;
 . ;--- Report header
 . S RC=$$HEADER(REPORT)  Q:RC<0
 . ;
 . ;--- Process the data and generate the report
 . S RC=$$PROCESS(REPORT,FLAGS)  S:RC>0 ECNT=ECNT+RC
 ;
 ;--- Cleanup
 K ^TMP("RORX011-RESORTED",$J)
 D FREE^RORTMP(RORXL)
 Q $S(RC<0:RC,ECNT>0:-43,1:0)
 ;
 ;***** CALLBACK FUNCTION FOR THE PHARMACY SEARCH API
RXSCB(ROR8DST,ORDER,ORDFLG,DRUG,DATE,NUMREF) ;
 N DRUGIEN,DRUGNAME,FILLTYPE,IEN,IRP,OFD,RPSUB,RXBUF,RXCNT,RXNUM,TMP
 S DRUGIEN=+DRUG,DRUGNAME=$P(DRUG,U,2)
 Q:(DRUGIEN'>0)!(DRUGNAME="") 1
 ;--- Check the drug groups
 S TMP=$$RXGRPCHK^RORXU007(.ROR8DST,+DRUG,RORXL)
 Q:TMP TMP
 ;--- Process the order
 S:ROR8DST("RORXGEN")>0 $P(RXBUF,U,4)=$P(ROR8DST("RORXGEN"),U,2)
 S $P(RXBUF,U,5)=$P($G(^TMP("PS",$J,0)),U,7)  ; Days Supply
 S $P(RXBUF,U,6)=+$G(NUMREF)  ; # Refills remaining - Patch 11
 S TMP=$G(^TMP("PS",$J,"RXN",0))
 S FILLTYPE=$S(ORDFLG["I":"I",1:$P(TMP,U,3))
 S RXNUM=$P(TMP,U)  S:RXNUM="" RXNUM=" "
 S RXCNT=0
 ;--- Original prescription
 I ORDFLG["I"  D  ;--- Inpatient
 . S OFD=$P($G(^TMP("PS",$J,0)),U,5)         ; Start Date
 . S $P(RXBUF,U,1,2)="I"_U_FILLTYPE,RXCNT=RXCNT+1
 . S @ROR8DST@(OFD,DRUGNAME,DRUGIEN,RXNUM,RXCNT)=RXBUF
 E  D             ;--- Outpatient
 . S OFD=+$P($G(^TMP("PS",$J,"RXN",0)),U,6)  ; Original Fill Date
 . Q:(OFD<ROR8DST("RORSDT"))!(OFD'<ROR8DST("ROREDT"))
 . S $P(RXBUF,U,1,2)="O"_U_FILLTYPE,RXCNT=RXCNT+1
 . S @ROR8DST@(OFD,DRUGNAME,DRUGIEN,RXNUM,RXCNT)=RXBUF
 ;--- Refills and partials
 F RPSUB="REF","PAR"  D
 . S $P(RXBUF,U)=$E(RPSUB,1)
 . S IRP=0
 . F  S IRP=$O(^TMP("PS",$J,RPSUB,IRP))  Q:IRP'>0  D
 . . S TMP=$G(^TMP("PS",$J,RPSUB,IRP,0))
 . . S $P(RXBUF,U,2)=$S(ORDFLG["I":"I",1:$P(TMP,U,5))
 . . S $P(RXBUF,U,5)=$P(TMP,U,2)  ; Days Supply
 . . I TMP>0  S RXCNT=RXCNT+1  D
 . . . S @ROR8DST@(+TMP,DRUGNAME,DRUGIEN,RXNUM,RXCNT)=RXBUF
 Q 0
 ;
 ;***** KEEP ONLY MOST RECENT FILLS FOR EACH DRUG
 ;Input:
 ;   RORXDST - arry containing all drug fills for patient
 ;
 ;Output:
 ;   RORXDST - array containing only most recent drug fills for patient
 ;       
 ;The ^TMP("RORX011-RESORTED",$J) global node is used by this function.
 ;Indirection: RORXDST = $NA(^TMP("RORX011",$J))
 ;                           ^TMP("RORX011",$J,DATE,DRUG_NAME,IEN,...)
 ;
RECENT(RORXDST) ;
 N DATE,DRUG
 K ^TMP("RORX011-RESORTED",$J) ;empty the temporary global
 ;Patient's Rx data was stored by date, then drug name.  Spin through
 ;Rx data and re-order it by drug name first, then date.  The reordered
 ;data is put into temp global ^TMP("RORX011-RESORTED",$J,DRUG,DATE)
 S DATE=0 F  S DATE=$O(@RORXDST@(DATE)) Q:'DATE  D
 . S DRUG=0 F  S DRUG=$O(@RORXDST@(DATE,DRUG)) Q:'$L(DRUG)  D
 . . S ^TMP("RORX011-RESORTED",$J,DRUG,DATE)=1
 ;
 ;spin through re-sorted drug file
 S DRUG=0 F  S DRUG=$O(^TMP("RORX011-RESORTED",$J,DRUG)) Q:'$L(DRUG)  D
 . ;get entry for drug with most recent (latest) date
 . S DATE=$O(^TMP("RORX011-RESORTED",$J,DRUG,9999999),-1)
 . ;has any drug been re-filled?
 . F  S DATE=$O(^TMP("RORX011-RESORTED",$J,DRUG,DATE),-1) Q:'DATE  D
 . . ;yes, previous/older fill found - delete from the original file
 . . K @RORXDST@(DATE,DRUG)
 Q
