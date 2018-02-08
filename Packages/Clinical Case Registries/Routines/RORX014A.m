RORX014A ;HOIFO/BH,SG,VAC - REGISTRY MEDS REPORT (QUERY & SORT) ;4/7/09 2:09pm
 ;;1.5;CLINICAL CASE REGISTRIES;**8,13,19,21,31**;Feb 17, 2006;Build 62
 ;
 ;******************************************************************************
 ;******************************************************************************
 ;                 --- ROUTINE MODIFICATION LOG ---
 ;        
 ;PKG/PATCH    DATE        DEVELOPER    MODIFICATION
 ;-----------  ----------  -----------  ----------------------------------------
 ;ROR*1.5*8    MAR 2010    V CARR       Modified to handle ICD9 filter for
 ;                                      'include' or 'exclude'.
 ;ROR*1.5*13   DEC 2010    A SAUNDERS   User can select specific patients,
 ;                                      clinics, or divisions for the report.
 ;ROR*1.5*19   FEB 2012    J SCOTT      Support for ICD-10 Coding System.
 ;ROR*1.5*21   SEP 2013    T KOPP       Added ICN as last report column if
 ;                                      additional identifier option selected
 ;ROR*1.5*31   MAY 2017    M FERRARESE  Adding PACT ,PCP,and AGE/DOB as additional
 ;                                      identifiers.
 ;******************************************************************************
 ;******************************************************************************
 Q
 ;
 ;***** ADDS THE DRUG COMBINATION TO THE REPORT
 ;
 ; RXLST         List of drug IEN's separated by commas
 ; PATIEN        Patient IEN in file #2 (DFN)
 ;
ADD(RXLST,PATIEN) ;
 N RXCIEN,RXCNDX,TMP,VA,VADM,VAERR
 S RXCNDX=$E(RXLST,1,100)
 ;--- Search for the combination
 S RXCIEN=""
 F  D  Q:RXCIEN=""  Q:^TMP("RORX014",$J,"RXC",RXCIEN,1)=RXLST
 . S RXCIEN=$O(^TMP("RORX014",$J,"RXC","B",RXCNDX,RXCIEN))
 ;--- Add new combination
 D:RXCIEN'>0
 . S RXCIEN=$O(^TMP("RORX014",$J,"RXC"," "),-1)+1
 . S ^TMP("RORX014",$J,"RXC",RXCIEN,1)=RXLST
 . S ^TMP("RORX014",$J,"RXC","B",RXCNDX,RXCIEN)=""
 ;--- Add new patient
 S ^("P")=$G(^TMP("RORX014",$J,"RXC",RXCIEN,"P"))+1 ;naked reference: ^TMP("RORX014",$J,"RXC",RXCIEN,"P")
 D VADEM^RORUTL05(PATIEN,1)
 S AGETYPE=$$PARAM^RORTSK01("AGE_RANGE","TYPE") D
 . S AGE=$S(AGETYPE="AGE":$P(VADM(4),U),AGETYPE="DOB":$$DATE^RORXU002($P(VADM(3),U)\1),1:"")
 S TMP=VA("BID")_U_VADM(1)_U_$$DATE^RORXU002(VADM(6)\1)_U_$S($$PARAM^RORTSK01("PATIENTS","ICN"):$$ICN^RORUTL02(PATIEN),1:"")
 S TMP=TMP_U_$S($$PARAM^RORTSK01("PATIENTS","PACT"):$$PACT^RORUTL02(PATIEN),1:"")_U_$S($$PARAM^RORTSK01("PATIENTS","PCP"):$$PCP^RORUTL02(PATIEN),1:"")_U_AGE
 S ^TMP("RORX014",$J,"RXC",RXCIEN,"P",PATIEN)=TMP
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
 N RORXDST       ; Descriptor for pharmacy search API
 ;
 N CNT,DRGIEN,ECNT,NAME,PATIEN,RC,RORIEN,RXFLAGS,STR,TMP,XREFNODE
 N RCC,FLAG
 N RORCDLIST     ; Flag to indicate whether a clinic or division list exists
 N RORCDSTDT     ; Start date for clinic/division utilization search
 N RORCDENDT     ; End date for clinic/division utilization search
 ;
 S XREFNODE=$NA(^RORDATA(798,"AC",+RORREG))
 S RORPTN=$$REGSIZE^RORUTL02(+RORREG)  S:RORPTN<0 RORPTN=0
 S (CNT,ECNT,RC)=0
 ;
 ;--- Prepare parameters for the pharmacy search API
 S RORXDST=$NA(RORXDST("RORX014"))
 S RORXDST("RORCB")="$$RXSCB^RORX014A"
 S RORXDST("GENERIC")=$$PARAM^RORTSK01("DRUGS","AGGR_GENERIC")
 S RXFLAGS="E"
 S:$$PARAM^RORTSK01("PATIENTS","INPATIENT") RXFLAGS=RXFLAGS_"IV"
 S:$$PARAM^RORTSK01("PATIENTS","OUTPATIENT") RXFLAGS=RXFLAGS_"O"
 Q:RXFLAGS="E" 0
 ;
 ;=== Set up Clinic/Division list parameters
 S RORCDLIST=$$CDPARMS^RORXU001(.RORTSK,.RORCDSTDT,.RORCDENDT)
 ;
 ;--- Browse through the registry records
 S RORIEN=0
 S FLAG=$G(RORTSK("PARAMS","ICDFILT","A","FILTER"))
 F  S RORIEN=$O(@XREFNODE@(RORIEN))  Q:RORIEN'>0  D  Q:RC<0
 . S TMP=$S(RORPTN>0:CNT/RORPTN,1:"")
 . S RC=$$LOOP^RORTSK01(TMP)  Q:RC<0
 . S CNT=CNT+1
 . ;--- Get patient DFN
 . S PATIEN=$$PTIEN^RORUTL01(RORIEN)  Q:PATIEN'>0
 . ;check for patient list and quit if not on list
 . I $D(RORTSK("PARAMS","PATIENTS","C")),'$D(RORTSK("PARAMS","PATIENTS","C",PATIEN)) Q
 . ;--- Check if the patient should be skipped
 . Q:$$SKIP^RORXU005(RORIEN,FLAGS,RORSDT,ROREDT)
 . ;--- Check the patient against the ICD Filter
 . S RCC=0
 . I FLAG'="ALL" D
 . . S RCC=$$ICD^RORXU010(PATIEN)
 . I (FLAG="INCLUDE")&(RCC=0) Q
 . I (FLAG="EXCLUDE")&(RCC=1) Q
 . ;--- End of ICD check
 . ;
 . ;--- Check for Clinic or Division list and quit if not in list
 . I RORCDLIST,'$$CDUTIL^RORXU001(.RORTSK,PATIEN,RORCDSTDT,RORCDENDT) Q
 . ;
 . ;--- Search for pharmacy data
 . S TMP=$$RXSEARCH^RORUTL14(PATIEN,RORXL,.RORXDST,RXFLAGS,RORSDT,ROREDT1)
 . I TMP'>0  S:TMP<0 ECNT=ECNT+1  Q:$D(@RORXDST)<10
 . ;
 . S (NAME,STR)=""
 . F  S NAME=$O(@RORXDST@(NAME))  Q:NAME=""  D
 . . S DRGIEN=0
 . . F  S DRGIEN=$O(@RORXDST@(NAME,DRGIEN))  Q:DRGIEN'>0  D
 . . . S ^TMP("RORX014",$J,"DRG",DRGIEN)=NAME
 . . . S STR=STR_","_DRGIEN
 . K @RORXDST
 . ;
 . D ADD($P(STR,",",2,999),PATIEN)
 ;
 ;---
 Q $S(RC<0:RC,1:ECNT)
 ;
 ;***** CALLBACK FUNCTION FOR THE PHARMACY SEARCH API
RXSCB(RORDST,ORDER,ORDFLG,DRUG,DATE) ;
 N IEN,NAME
 I ROR8DST("GENERIC")  D
 . S IEN=+ROR8DST("RORXGEN"),NAME=$P(ROR8DST("RORXGEN"),U,2)
 E  S IEN=+DRUG,NAME=$P(DRUG,U,2)
 Q:(IEN'>0)!(NAME="") 1
 S @RORDST@(NAME,IEN)=""
 Q 0
 ;
 ;***** SORTS THE RESULTS AND COMPILES THE TOTALS
 ;
 ; NRXC          Number of drug combinations
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;       >0  Number of non-fatal errors
 ;
SORT(NRXC) ;
 N IEN,TMP
 S (IEN,NRXC)=0
 F  S IEN=$O(^TMP("RORX014",$J,"RXC",IEN))  Q:IEN'>0  D
 . S TMP=^TMP("RORX014",$J,"RXC",IEN,"P")
 . S ^TMP("RORX014",$J,"RXC","P",TMP,IEN)="",NRXC=NRXC+1
 Q 0
 ;
 ;***** STORES THE REPORT DATA
 ;
 ; REPORT        IEN of the REPORT element
 ; NRXC          Number of drug combinations
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;       >0  Number of non-fatal errors
 ;
STORE(REPORT,NRXC) ;
 N BUF,CNT,DRG,ITEM,NODE,PATIEN,RORI,RXCIEN,RXCNT,RXCOMB,SECTION,TABLE,VA,VADM,VAERR,AGETYPE,AGE
 S NODE=$NA(^TMP("RORX014",$J))
 S SECTION=$$ADDVAL^RORTSK11(RORTSK,"RXCOMBLST",,REPORT)
 Q:SECTION<0 SECTION
 D ADDATTR^RORTSK11(RORTSK,SECTION,"TABLE","RXCOMBLST")
 ;---
 Q:NRXC'>0 0
 ;---
 S RXCNT="",CNT=0,AGE=""
 F  S RXCNT=$O(@NODE@("RXC","P",RXCNT),-1)  Q:RXCNT=""  D
 . S RC=$$LOOP^RORTSK01(CNT/NRXC),CNT=CNT+1  Q:RC<0
 . S RXCIEN=""
 . F  S RXCIEN=$O(@NODE@("RXC","P",RXCNT,RXCIEN),-1)  Q:RXCIEN=""  D
 . . S RXCOMB=$$ADDVAL^RORTSK11(RORTSK,"RXCOMB",,SECTION)
 . . ;--- List of drugs
 . . S TABLE=$$ADDVAL^RORTSK11(RORTSK,"DRUGS",,RXCOMB)
 . . S BUF=@NODE@("RXC",RXCIEN,1)
 . . F RORI=1:1  S DRG=$P(BUF,",",RORI)  Q:DRG=""  D
 . . . S DRG=$P(^TMP("RORX014",$J,"DRG",DRG),U)
 . . . D ADDVAL^RORTSK11(RORTSK,"NAME",DRG,TABLE,1)
 . . ;--- Number of unique patients
 . . D ADDVAL^RORTSK11(RORTSK,"NP",RXCNT,RXCOMB,3)
 . . ;--- List of patients
 . . Q:'$$PARAM^RORTSK01("OPTIONS","COMPLETE")
 . . S TABLE=$$ADDVAL^RORTSK11(RORTSK,"PATIENTS",,RXCOMB)
 . . D ADDATTR^RORTSK11(RORTSK,TABLE,"TABLE","PATIENTS")
 . . S PATIEN=""
 . . F  S PATIEN=$O(@NODE@("RXC",RXCIEN,"P",PATIEN))  Q:PATIEN=""  D
 . . . S BUF=@NODE@("RXC",RXCIEN,"P",PATIEN)
 . . . S ITEM=$$ADDVAL^RORTSK11(RORTSK,"PATIENT",,TABLE,,PATIEN)
 . . . D ADDVAL^RORTSK11(RORTSK,"NAME",$P(BUF,U,2),ITEM,1)
 . . . D ADDVAL^RORTSK11(RORTSK,"LAST4",$P(BUF,U),ITEM,2)
 . . . ;
 . . . S AGETYPE=$$PARAM^RORTSK01("AGE_RANGE","TYPE") I AGETYPE'="ALL" D
 . . . . D ADDVAL^RORTSK11(RORTSK,AGETYPE,$P(BUF,U,7),ITEM,1)
 . . . ;
 . . . D ADDVAL^RORTSK11(RORTSK,"DOD",$P(BUF,U,3),ITEM,1)
 . . . I $$PARAM^RORTSK01("PATIENTS","ICN") D ADDVAL^RORTSK11(RORTSK,"ICN",$P(BUF,U,4),ITEM,1)
 . . . I $$PARAM^RORTSK01("PATIENTS","PACT") D ADDVAL^RORTSK11(RORTSK,"PACT",$P(BUF,U,5),ITEM,1)
 . . . I $$PARAM^RORTSK01("PATIENTS","PCP") D ADDVAL^RORTSK11(RORTSK,"PCP",$P(BUF,U,6),ITEM,1)
 Q 0
