RORX007A ;HOIFO/BH,SG,VAC - RADIOLOGY UTILIZATION (OVERFLOW) ;4/7/09 2:07pm
 ;;1.5;CLINICAL CASE REGISTRIES;**1,8,13,19,21,31**;Feb 17, 2006;Build 62
 ;
 ; This routine uses the following IAs:
 ;
 ; #2043         EN1^RAO7PC1 (supported)
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
 ;ROR*1.5*31   MAY 2017    M FERRARESE  Adding PACT, PCP, and AGE/DOB as additional
 ;                                      identifiers.
 ;                                   
 ;******************************************************************************
 ;******************************************************************************
 Q
 ;
 ;***** APPENDS MODIFIERS TO THE CPT CODE
 ;
 ; CPT           CPT code
 ;
 ; NODE          Closed root of the exam data node returned
 ;               by the EN1^RAO7PC1
 ;
CPTMOD(CPT,NODE) ;
 N CPM,RORIM
 S RORIM=""
 F  S RORIM=$O(@NODE@("CMOD",RORIM))  Q:RORIM=""  D
 . S CPM=$P($G(@NODE@("CMOD",RORIM)),U)
 . S:CPM'="" CPT=CPT_"-"_CPM
 Q CPT
 ;
 ;***** LOADS AND PROCESSES THE RADIOLOGY DATA
 ;
 ; DFN           Patient IEN (in file #2)
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
GETDATA(DFN) ;
 N CPT,EXAMID,NODE,PRNAME,RORBUF
 ;--- Get the data
 D EN1^RAO7PC1(DFN,RORSDT,ROREDT,999999)
 ;data returned from radiology/nuclear medicine API in ^TMP($J,"RAE1"
 Q:'$D(^TMP($J,"RAE1",DFN)) 0
 ;
 ;--- Process the data
 S EXAMID=""
 F  S EXAMID=$O(^TMP($J,"RAE1",DFN,EXAMID))  Q:EXAMID=""  D
 . S NODE=$NA(^TMP($J,"RAE1",DFN,EXAMID))
 . S RORBUF=$G(@NODE),CPT=$$CPTMOD($P(RORBUF,U,10),NODE)
 . ;--- Get Procedure Name
 . S PRNAME=$E($P(RORBUF,U),1,30)  Q:PRNAME=""
 . S PRNAME=PRNAME_U_$S(CPT'="":CPT,1:" ")
 . ;--- Increment the counters
 . S ^(DFN)=$G(^TMP("RORX007",$J,"PROC",PRNAME,DFN))+1 ;naked reference: ^TMP("RORX007",$J,"PROC",PRNAME,DFN)
 . S ^(PRNAME)=$G(^TMP("RORX007",$J,"PAT",DFN,PRNAME))+1 ;naked reference: ^TMP("RORX007",$J,"PROC",PRNAME,DFN,PRNAME)
 ;
 ;--- Cleanup
 K ^TMP($J,"RAE1")
 Q 0
 ;
 ;***** OUTPUTS THE REPORT HEADER
 ;
 ; PARTAG        Reference (IEN) to the parent tag
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
HEADER(PARTAG) ;
 ;;PATIENTS(#,NAME,LAST4,DOD,TOTAL,UNIQUE,ICN,PACT,PCP)^I $$PARAM^RORTSK01("AGE_RANGE","TYPE")="ALL"
 ;;PATIENTS(#,NAME,LAST4,AGE,DOD,TOTAL,UNIQUE,ICN,PACT,PCP)^I $$PARAM^RORTSK01("AGE_RANGE","TYPE")="AGE"
 ;;PATIENTS(#,NAME,LAST4,DOB,DOD,TOTAL,UNIQUE,ICN,PACT,PCP)^I $$PARAM^RORTSK01("AGE_RANGE","TYPE")="DOB"
 ;;PROCEDURES(#,NAME,CPT,PATIENTS,TOTAL)
 ;
 N HEADER,RC
 S HEADER=$$HEADER^RORXU002(.RORTSK,PARTAG)
 Q:HEADER<0 HEADER
 S RC=$$TBLDEF^RORXU002("HEADER^RORX007A",HEADER)
 Q $S(RC<0:RC,1:HEADER)
 ;
 ;***** OUTPUTS THE PARAMETERS TO THE REPORT
 ;
 ; PARTAG        Reference (IEN) to the parent tag
 ;
 ; [.STDT]       Start and end dates of the report
 ; [.ENDT]       are returned via these parameters
 ;
 ; [.FLAGS]      Flags for the $$SKIP^RORXU005 are
 ;               returned via this parameter
 ;
 ; Return Values:
 ;       <0  Error code
 ;       >0  IEN of the PARAMETERS element
 ;
PARAMS(PARTAG,STDT,ENDT,FLAGS) ;
 N NAME,PARAMS,TMP
 S PARAMS=$$PARAMS^RORXU002(.RORTSK,PARTAG,.STDT,.ENDT,.FLAGS)
 Q:PARAMS<0 PARAMS
 ;--- Additional parameters
 F NAME="MAXUTNUM","MINRPNUM"  D
 . S TMP=$$PARAM^RORTSK01(NAME)
 . D:TMP'="" ADDVAL^RORTSK11(RORTSK,NAME,TMP,PARAMS)
 ;---
 Q PARAMS
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
 N CNT,ECNT,IEN,IENS,PATIEN,RC,RORMSG,TMP,XREFNODE
 N RCC,FLAG
 N RORCDLIST     ; Flag to indicate whether a clinic or division list exists
 N RORCDSTDT     ; Start date for clinic/division utilization search
 N RORCDENDT     ; End date for clinic/division utilization search
 ;
 S XREFNODE=$NA(^RORDATA(798,"AC",+RORREG))
 S (CNT,ECNT,RC)=0
 ;=== Set up Clinic/Division list parameters
 S RORCDLIST=$$CDPARMS^RORXU001(.RORTSK,.RORCDSTDT,.RORCDENDT)
 ;
 ;--- Browse through the registry records
 S IEN=0
 S FLAG=$G(RORTSK("PARAMS","ICDFILT","A","FILTER"))
 F  S IEN=$O(@XREFNODE@(IEN)) Q:IEN'>0  D  Q:RC<0
 . S TMP=$S(RORPTN>0:CNT/RORPTN,1:"")
 . S RC=$$LOOP^RORTSK01(TMP)  Q:RC<0
 . S IENS=IEN_",",CNT=CNT+1
 . ;--- Get the patient DFN
 . S PATIEN=$$PTIEN^RORUTL01(IEN) Q:PATIEN'>0
 . ;--- Check for patient list and quit if not on list
 . I $D(RORTSK("PARAMS","PATIENTS","C")),'$D(RORTSK("PARAMS","PATIENTS","C",PATIEN)) Q
 . ;--- Check if the patient should be skipped
 . Q:$$SKIP^RORXU005(IEN,FLAGS,RORSDT,ROREDT)
 . ;--- Check the patient against the ICD Filter
 . S RCC=0
 . I FLAG'="ALL" D
 . . S RCC=$$ICD^RORXU010(PATIEN)
 . I (FLAG="INCLUDE")&(RCC=0) Q
 . I (FLAG="EXCLUDE")&(RCC=1) Q
 . ;--- End of ICD check
 . ;--- Check for Clinic or Division list and quit if not in list
 . I RORCDLIST,'$$CDUTIL^RORXU001(.RORTSK,PATIEN,RORCDSTDT,RORCDENDT) Q
 . ;--- Get the radiology data
 . S RC=$$GETDATA(PATIEN)
 . I RC  S ECNT=ECNT+1  Q:RC<0
 ;---
 Q $S(RC<0:RC,1:ECNT)
 ;
 ;***** PLURAL/SINGULAR
SRPL(QNTY,WORD,SQ) ;
 Q $S('$G(SQ):QNTY_" ",1:"")_$P(WORD,U,$S(QNTY=1:1,1:2))
