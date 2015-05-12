RORX008A ;HOIFO/BH,SG,VAC - VERA REIMBURSEMENT REPORT ;4/7/09 2:08pm
 ;;1.5;CLINICAL CASE REGISTRIES;**8,13,19,21**;Feb 17, 2006;Build 45
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
 ;ROR*1.5*19   FEB  2012   K GUPTA      Support for ICD-10 Coding System
 ;ROR*1.5*21   SEP 2013    T KOPP       Added ICN as last report column if
 ;                                      additional identifier option selected
 ;                                      
 ;******************************************************************************
 ;******************************************************************************
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
 N RORPTN        ; Number of patients in the registry
 N RORCDLIST     ; Flag to indicate whether a clinic or division list exists
 N RORCDSTDT     ; Start date for clinic/division utilization search
 N RORCDENDT     ; End date for clinic/division utilization search
 ;
 N CLINAIDS,CMPXCARE,CNT,CNTARV,CNTBASIC,CNTCMPX,ECNT,FLAG,IEN,NAME,PATIEN,RC,RCC,RORIEN,RORXDST,TMP,UTLCHK,VA,VADM,VAERR,XREFNODE
 ;
 S XREFNODE=$NA(^RORDATA(798,"AC",+RORREG))
 S RORPTN=$$REGSIZE^RORUTL02(+RORREG)  S:RORPTN<0 RORPTN=0
 S (CNT,CNTARV,CNTBASIC,CNTCMPX,ECNT,RC)=0
 S UTLCHK("ALL")=""
 ;
 ;--- Prepare parameters for the pharmacy search API
 S RORXDST("RORCB")="$$RXSCB^RORX008A"
 S TMP=$$PARAM^RORTSK01("OPTIONS","REGMEDSMRY")
 S RORXDST("SINGLE")='TMP!'$$PARAM^RORTSK01("PATIENTS","COMPLEX")
 ;
 ;=== Set up Clinic/Division list parameters
 S RORCDLIST=$$CDPARMS^RORXU001(.RORTSK,.RORCDSTDT,.RORCDENDT)
 ;
 ;--- Browse through the registry records
 S RORIEN=0
 S FLAG=$G(RORTSK("PARAMS","ICDFILT","A","FILTER"))
 F  S RORIEN=$O(@XREFNODE@(RORIEN))  Q:RORIEN'>0  D  Q:RC<0
 . ;--- Start progress counter
 . S TMP=$S(RORPTN>0:CNT/RORPTN,1:"")
 . S RC=$$LOOP^RORTSK01(TMP)  Q:RC<0
 . S CNT=CNT+1
 . ;--- Get patient DFN
 . S PATIEN=$$PTIEN^RORUTL01(RORIEN) Q:PATIEN'>0
 . ;check for patient list and quit if not on list
 . I $D(RORTSK("PARAMS","PATIENTS","C")),'$D(RORTSK("PARAMS","PATIENTS","C",PATIEN)) Q
 . ;--- Check if the patient should be skipped
 . Q:$$SKIP^RORXU005(RORIEN,FLAGS,RORSDT,ROREDT)
 . ;--- Check patient against ICD list
 . S RCC=0
 . I FLAG'="ALL" D
 . . S RCC=$$ICD^RORXU010(PATIEN)
 . I (FLAG="INCLUDE")&(RCC=0) Q
 . I (FLAG="EXCLUDE")&(RCC=1) Q
 . ; End of check of ICD list
 . ;
 . ;--- Check for Clinic or Division list and quit if not in list
 . I RORCDLIST,'$$CDUTIL^RORXU001(.RORTSK,PATIEN,RORCDSTDT,RORCDENDT) Q
 . ;
 . ;--- Skip Clinical AIDS if Complex Care was not requested
 . S CMPXCARE=0
 . S CLINAIDS=$S($$CLINAIDS^RORHIVUT(RORIEN,ROREDT):1,1:0)
 . I CLINAIDS  Q:'$$PARAM^RORTSK01("PATIENTS","COMPLEX")  S CMPXCARE=1
 . ;
 . ;--- Skip a patient without utlilization
 . Q:'$$UTIL^RORXU003(RORSDT,ROREDT,PATIEN,.UTLCHK)
 . ;
 . ;--- Search for pharmacy data
 . K RORXDST("ARV")
 . S TMP=$$RXSEARCH^RORUTL14(PATIEN,RORXL,.RORXDST,"EIOV",RORSDT,ROREDT1)
 . I TMP<0  S ECNT=ECNT+1  Q
 . I $D(RORXDST("ARV"))  Q:'$$PARAM^RORTSK01("PATIENTS","COMPLEX")  D
 . . S IEN=0
 . . F  S IEN=$O(RORXDST("ARV",IEN))  Q:IEN'>0  D
 . . . D:'$D(^TMP("RORX008",$J,"DRG",IEN))
 . . . . S ^TMP("RORX008",$J,"DRG",IEN)=RORXDST("ARV",IEN)
 . . . S ^(CLINAIDS)=$G(^TMP("RORX008",$J,"DRG",IEN,CLINAIDS))+1 ;naked reference: ^TMP("RORX008",$J,"DRG",IEN,CLINAIDS)
 . . S CMPXCARE=1,CNTARV=CNTARV+1
 . ;
 . ;--- Skip Basic Care if it was not requested
 . I CMPXCARE  S CNTCMPX=CNTCMPX+1
 . E  Q:'$$PARAM^RORTSK01("PATIENTS","BASIC")  S CNTBASIC=CNTBASIC+1
 . ;
 . D:$$PARAM^RORTSK01("OPTIONS","PTLIST")
 . . D VADEM^RORUTL05(PATIEN,1)
 . . S TMP=$$DATE^RORXU002(VADM(6)\1)
 . . S TMP=TMP_U_($D(RORXDST("ARV"))>0)_U_CMPXCARE_U_CLINAIDS
 . . S ^TMP("RORX008",$J,"PAT",PATIEN)=VA("BID")_U_VADM(1)_U_TMP
 . . S $P(^TMP("RORX008",$J,"PAT",PATIEN),U,6)=$S($$PARAM^RORTSK01("PATIENTS","ICN"):$$ICN^RORUTL02(PATIEN),1:"")
 ;
 ;--- Totals
 S ^TMP("RORX008",$J,"PAT")=CNTBASIC_U_CNTCMPX_U_CNTARV
 ;---
 Q $S(RC<0:RC,1:ECNT)
 ;
 ;***** CALLBACK FUNCTION FOR THE PHARMACY SEARCH API
RXSCB(ROR8DST,ORDER,ORDFLG,DRUG,DATE) ;
 N CA,IEN,NAME
 S IEN=+ROR8DST("RORXGEN"),NAME=$P(ROR8DST("RORXGEN"),U,2)
 Q:(IEN'>0)!(NAME="") 1
 ;---
 S ROR8DST("ARV")=""  Q:ROR8DST("SINGLE") 2
 ;---
 S ROR8DST("ARV",IEN)=NAME
 Q 0
 ;
 ;***** STORES THE REPORT DATA
 ;
 ; REPORT        IEN of the REPORT element
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;       >0  Number of non-fatal errors
 ;
STORE(REPORT) ;
 N BUF,CNT,ITEM,IEN,NODE,NPAIDS,NPHIV,RC,TABLE,TMP
 S NODE=$NA(^TMP("RORX008",$J)),RC=0
 ;
 ;--- List of ARV drugs
 S TMP=$$PARAM^RORTSK01("OPTIONS","REGMEDSMRY")
 I TMP,$$PARAM^RORTSK01("PATIENTS","COMPLEX")  D  Q:RC<0 RC
 . S TABLE=$$ADDVAL^RORTSK11(RORTSK,"DRUGS",,REPORT)
 . I TABLE<0  S RC=TABLE  Q
 . D ADDATTR^RORTSK11(RORTSK,TABLE,"TABLE","DRUGS")
 . S IEN=0
 . F  S IEN=$O(@NODE@("DRG",IEN))  Q:IEN'>0  D
 . . S BUF=@NODE@("DRG",IEN)
 . . S ITEM=$$ADDVAL^RORTSK11(RORTSK,"DRUG",,TABLE)
 . . D ADDVAL^RORTSK11(RORTSK,"NAME",$P(@NODE@("DRG",IEN),U),ITEM,1)
 . . S NPHIV=+$G(@NODE@("DRG",IEN,0))
 . . S NPAIDS=+$G(@NODE@("DRG",IEN,1))
 . . D ADDVAL^RORTSK11(RORTSK,"NP",NPHIV+NPAIDS,ITEM,3)
 . . D ADDVAL^RORTSK11(RORTSK,"NPHIV",NPHIV,ITEM,3)
 . . D ADDVAL^RORTSK11(RORTSK,"NPAIDS",NPAIDS,ITEM,3)
 ;
 ;--- List of patients
 I $$PARAM^RORTSK01("OPTIONS","PTLIST")  D  Q:RC<0 RC
 . S TABLE=$$ADDVAL^RORTSK11(RORTSK,"PATIENTS",,REPORT)
 . I TABLE<0  S RC=TABLE  Q
 . D ADDATTR^RORTSK11(RORTSK,TABLE,"TABLE","PATIENTS")
 . S IEN=0
 . F  S IEN=$O(@NODE@("PAT",IEN))  Q:IEN'>0  D
 . . S BUF=@NODE@("PAT",IEN)
 . . S ITEM=$$ADDVAL^RORTSK11(RORTSK,"PATIENT",,TABLE,,IEN)
 . . D ADDVAL^RORTSK11(RORTSK,"NAME",$P(BUF,U,2),ITEM,1)
 . . D ADDVAL^RORTSK11(RORTSK,"LAST4",$P(BUF,U),ITEM,2)
 . . D ADDVAL^RORTSK11(RORTSK,"DOD",$P(BUF,U,3),ITEM,1)
 . . D ADDVAL^RORTSK11(RORTSK,"AIDSTAT",+$P(BUF,U,6),ITEM,1)
 . . D ADDVAL^RORTSK11(RORTSK,"ARV",+$P(BUF,U,4),ITEM,1)
 . . D ADDVAL^RORTSK11(RORTSK,"COMPLEX",+$P(BUF,U,5),ITEM,1)
 . . I $$PARAM^RORTSK01("PATIENTS","ICN") D ADDVAL^RORTSK11(RORTSK,"ICN",$P(BUF,U,6),ITEM,1)
 ;
 ;--- Summary
 S BUF=@NODE@("PAT")
 S ITEM=$$ADDVAL^RORTSK11(RORTSK,"SUMMARY",,REPORT)
 D ADDVAL^RORTSK11(RORTSK,"NP",$P(BUF,U)+$P(BUF,U,2),ITEM)
 D ADDVAL^RORTSK11(RORTSK,"NPBASIC",+$P(BUF,U,1),ITEM)
 D ADDVAL^RORTSK11(RORTSK,"NPCOMPLEX",+$P(BUF,U,2),ITEM)
 D ADDVAL^RORTSK11(RORTSK,"NPARV",+$P(BUF,U,3),ITEM)
 Q 0
