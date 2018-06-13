RORX002 ;HOIFO/SG,VAC - CURRENT INPATIENT LIST ;4/7/09 2:06pm
 ;;1.5;CLINICAL CASE REGISTRIES;**1,8,19,21,31,32**;Feb 17, 2006;Build 20
 ;
 ; This routine uses the following IAs:
 ;
 ; #10061        51^VADPT (supported)
 ;
 ; Routine modified March 2009 for ICD9 filter for INCLUDE or EXCLUDE
 ;
 ;******************************************************************************
 ;******************************************************************************
 ;                       --- ROUTINE MODIFICATION LOG ---
 ;        
 ;PKG/PATCH    DATE        DEVELOPER    MODIFICATION
 ;-----------  ----------  -----------  ----------------------------------------
 ;ROR*1.5*19   FEB  2012   K GUPTA      Support for ICD-10 Coding System
 ;ROR*1.5*21   SEP 2013    T KOPP       Add ICN column if Additional Identifier
 ;                                       requested.
 ;ROR*1.5*31   MAY 2017    M FERRARESE  Adding PACT, PCP, and AGE/DOB as additional
 ;                                       identifiers.
 ;ROR*1.5*32   11/07/17    S ALSAHHAR   Add 'Admitting Diagnosis' column
 ;******************************************************************************
 ;
 Q
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
 ;;PATIENTS(#,NAME,LAST4,AGE,WARD,ROOM-BED,DIAG,ICN,PACT,PCP)^I $$PARAM^RORTSK01("AGE_RANGE","TYPE")="AGE"
 ;;PATIENTS(#,NAME,LAST4,DOB,WARD,ROOM-BED,DIAG,ICN,PACT,PCP)^I $$PARAM^RORTSK01("AGE_RANGE","TYPE")="DOB"
 ;;PATIENTS(#,NAME,LAST4,WARD,ROOM-BED,DIAG,ICN,PACT,PCP)^I $$PARAM^RORTSK01("AGE_RANGE","TYPE")="ALL"
 ;
 N HEADER,RC
 S HEADER=$$HEADER^RORXU002(.RORTSK,PARTAG)
 Q:HEADER<0 HEADER
 S RC=$$TBLDEF^RORXU002("HEADER^RORX002",HEADER)
 Q $S(RC<0:RC,1:HEADER)
 ;
 ;***** COMPILES THE "CURRENT INPATIENT LIST"
 ; REPORT CODE: 002
 ;
 ; .RORTSK       Task number and task parameters
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
INPTLST(RORTSK) ;
 N RORPTN        ; Number of patients in the registry
 N RORREG        ; Registry IEN
 N RORTMP        ; Closed root of the temporary buffer
 ;
 N BODY,ECNT,INPCNT,RC,REPORT,SFLAGS,TMP
 ;--- Root node of the report
 S REPORT=$$ADDVAL^RORTSK11(RORTSK,"REPORT")
 Q:REPORT<0 REPORT
 ;
 ;--- Get and prepare the report parameters
 S RORREG=$$PARAM^RORTSK01("REGIEN")
 S RC=$$PARAMS^RORXU002(.RORTSK,REPORT,,,.SFLAGS)  Q:RC<0 RC
 ;
 ;--- Initialize constants and variables
 S ECNT=0
 S RORPTN=$$REGSIZE^RORUTL02(+RORREG)  S:RORPTN<0 RORPTN=0
 ;
 ;--- Report header
 S RC=$$HEADER(REPORT)  Q:RC<0 RC
 S RORTMP=$$ALLOC^RORTMP()
 D
 . ;--- Query the registry
 . D TPPSETUP^RORTSK01(50)
 . S RC=$$QUERY(.INPCNT,SFLAGS)
 . I RC  Q:RC<0  S ECNT=ECNT+RC
 . ;--- Generate the list of patients
 . D TPPSETUP^RORTSK01(50)
 . S RC=$$PTLIST(REPORT,INPCNT)
 . I RC  Q:RC<0  S ECNT=ECNT+RC
 ;
 ;--- Cleanup
 D FREE^RORTMP(RORTMP)
 Q $S(RC<0:RC,ECNT>0:-43,1:0)
 ;
 ;***** ADDS THE PATIENT DATA TO THE REPORT
 ;
 ; NODE          Closed root of the patient's node in the buffer
 ; PARTAG        Reference (IEN) to the parent tag
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
PATIENT(NODE,PARTAG) ;
 N IEN,NAME,PATIEN,PTAG,PTBUF,RC,TMP,AGETYPE
 S PTBUF=@NODE,PATIEN=$P(PTBUF,U,2)
 Q:PATIEN'>0 0
 ;--- The <PATIENT> tag
 S PTAG=$$ADDVAL^RORTSK11(RORTSK,"PATIENT",,PARTAG,,PATIEN)
 ;--- Patient data
 D ADDVAL^RORTSK11(RORTSK,"NAME",$QS(NODE,4),PTAG,1)
 D ADDVAL^RORTSK11(RORTSK,"LAST4",$QS(NODE,5),PTAG,2)
 S AGETYPE=$$PARAM^RORTSK01("AGE_RANGE","TYPE") I AGETYPE'="ALL" D
 . D ADDVAL^RORTSK11(RORTSK,$S(AGETYPE="AGE":"AGE",1:"DOB"),$P(PTBUF,U,8),PTAG,1)
 S TMP=$$DATE^RORXU002($P(PTBUF,U,4)\1)
 ;D ADDVAL^RORTSK11(RORTSK,"DOD",TMP,PTAG,1)
 ;
 D ADDVAL^RORTSK11(RORTSK,"WARD",$QS(NODE,3),PTAG,1)
 D ADDVAL^RORTSK11(RORTSK,"ROOM-BED",$P(PTBUF,U,3),PTAG,1)
 D ADDVAL^RORTSK11(RORTSK,"DIAG",$P(PTBUF,U,9),PTAG,1)
 ; --- ICN, PACT, PCP if selected will be one of the last columns on report accordingly.
 I $$PARAM^RORTSK01("PATIENTS","ICN") D ADDVAL^RORTSK11(RORTSK,"ICN",$P(PTBUF,U,5),PTAG,1)
 I $$PARAM^RORTSK01("PATIENTS","PACT") D ADDVAL^RORTSK11(RORTSK,"PACT",$P(PTBUF,U,6),PTAG,1)
 I $$PARAM^RORTSK01("PATIENTS","PCP") D ADDVAL^RORTSK11(RORTSK,"PCP",$P(PTBUF,U,7),PTAG,1)
 Q 0
 ;
 ;***** GENERATES THE LIST OF PATIENTS
 ;
 ; REPORT        IEN of the <REPORT> node
 ; INPCNT        Number of inpatients
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;       >0  Number of non-fatal errors
 ;
PTLIST(REPORT,INPCNT) ;
 N BODY,CNT,ECNT,FLT,FLTLEN,NODE,RC,TCNT,TMP
 S (CNT,ECNT,RC)=0
 S BODY=$$ADDVAL^RORTSK11(RORTSK,"PATIENTS",,REPORT)
 Q:BODY<0 BODY
 D ADDATTR^RORTSK11(RORTSK,BODY,"TABLE","PATIENTS")
 D:$D(@RORTMP)>1
 . S NODE=RORTMP
 . S FLTLEN=$L(NODE)-1,FLT=$E(NODE,1,FLTLEN)
 . F  S NODE=$Q(@NODE)  Q:$E(NODE,1,FLTLEN)'=FLT  D  Q:RC<0
 . . S TMP=$S(INPCNT>0:CNT/INPCNT,1:"")
 . . S RC=$$LOOP^RORTSK01(TMP)  Q:RC<0
 . . S CNT=CNT+1
 . . I $$PATIENT(NODE,BODY)<0  S ECNT=ECNT+1  Q
 Q $S(RC<0:RC,1:ECNT)
 ;
 ;***** QUERIES THE REGISTRY
 ;
 ; .INPCNT       Number of inpatients is returned in this parameter
 ; SFLAGS        Flags for $$SKIP^RORXU005
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;       >0  Number of non-fatal errors
 ;
QUERY(INPCNT,SFLAGS) ;
 N CNT,DFN,ECNT,IEN,IENS,RC,TCNT,TMP,VA,VADM,VAHOW,VAIP,VAROOT,XREFNODE,WARD,AGEDOB
 N RCC,FLAG
 S XREFNODE=$NA(^RORDATA(798,"AC",+RORREG))
 S (CNT,ECNT,INPCNT,RC)=0
 ;--- Browse through the registry records
 S IEN=0
 S FLAG=$G(RORTSK("PARAMS","ICDFILT","A","FILTER"))
 F  S IEN=$O(@XREFNODE@(IEN))  Q:IEN'>0  D  Q:RC<0
 . S TMP=$S(RORPTN>0:CNT/RORPTN,1:"")
 . S RC=$$LOOP^RORTSK01(TMP)  Q:RC<0
 . S IENS=IEN_",",CNT=CNT+1
 . ;--- Skip a patient
 . Q:$$SKIP^RORXU005(IEN,SFLAGS)
 . ;--- Process the registry record
 . S DFN=$$PTIEN^RORUTL01(IEN)  Q:DFN'>0
 .; --- Check the ICD filter
 . S RCC=0
 . I FLAG'="ALL" D
 . . S RCC=$$ICD^RORXU010(DFN)
 . I (FLAG="INCLUDE")&(RCC=0) Q
 . I (FLAG="EXCLUDE")&(RCC=1) Q
 .;--- End of ICD Filter check
 . K VA,VADM,VAIP,VAIN S VAIP("D")=DT\1 D 51^VADPT
 . D INP^VADPT
 . S AGEDOB=$$PARAM^RORTSK01("AGE_RANGE","TYPE") S AGEDOB=$S(AGEDOB="AGE":$P($G(VADM(4)),U),AGEDOB="DOB":$P($G(VADM(3)),U),1:"")
 . S WARD=$P(VAIP(5),U,2)  Q:WARD=""
 . S TMP=$S($G(VA("BID"))'="":VA("BID"),1:"UNKN") ; Last 4 of SSN
 . S @RORTMP@(WARD,VADM(1),TMP)=IEN_U_DFN_U_$P(VAIP(6),U,2)_U_$P(VADM(6),U)
 . S @RORTMP@(WARD,VADM(1),TMP)=@RORTMP@(WARD,VADM(1),TMP)_U_$$ICN^RORUTL02(DFN)
 . S @RORTMP@(WARD,VADM(1),TMP)=@RORTMP@(WARD,VADM(1),TMP)_U_$$PACT^RORUTL02(DFN)
 . S @RORTMP@(WARD,VADM(1),TMP)=@RORTMP@(WARD,VADM(1),TMP)_U_$$PCP^RORUTL02(DFN)
 . S @RORTMP@(WARD,VADM(1),TMP)=@RORTMP@(WARD,VADM(1),TMP)_U_$$DATE^RORXU002(AGEDOB\1)
 . S @RORTMP@(WARD,VADM(1),TMP)=@RORTMP@(WARD,VADM(1),TMP)_U_VAIN(9)
 . S INPCNT=INPCNT+1
 ;---
 Q $S(RC<0:RC,1:ECNT)
 ;
 ;***** CHECKS THE SUFFIX FOR VALIDITY
 ;
 ; SUFFIX        Suffix
 ;
 ; Return Values:
 ;        0  Ok
 ;        1  Invalid suffix
VSUFFIX(SUFFIX) ;
 Q '("9AA,9AB,9BB,A0,A4,A5,BU,BV,PA"[SUFFIX)
