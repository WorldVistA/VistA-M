RORX010 ;HOIFO/SG,VAC - LAB TESTS BY RANGE REPORT ;4/7/09 2:08pm
 ;;1.5;CLINICAL CASE REGISTRIES;**8,13,19,21,31**;Feb 17, 2006;Build 62
 ;
 ; This routine uses the following IAs:
 ;
 ; #2056  GETS^DIQ (supported)
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
 ;ROR*1.5*19   FEB  2012   K GUPTA      Support for ICD-10 Coding System
 ;ROR*1.5*21   SEP 2013    T KOPP       Added ICN as last report column if
 ;                                      additional identifier option selected
 ;ROR*1.5*31   MAY 2017    M FERRARESE  Adding PACT, PCP, and AGE/DOB as additional identifiers.
 ;                                      Fixing the ICN and PCP at the end of the 
 ;                                      Highest Combined OP and IP Utilization Summary panel
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
 ;        0  Ok
 ;
HEADER(PARTAG) ;
 ;;PATIENTS(#,NAME,LAST4,DOD,ICN,PACT,PCP,PTLRL(GROUP,DATE,NAME,RESULT))^I $$PARAM^RORTSK01("AGE_RANGE","TYPE")="ALL"
 ;;PATIENTS(#,NAME,LAST4,AGE,DOD,ICN,PACT,PCP,PTLRL(GROUP,DATE,NAME,RESULT))^I $$PARAM^RORTSK01("AGE_RANGE","TYPE")="AGE"
 ;;PATIENTS(#,NAME,LAST4,DOB,DOD,ICN,PACT,PCP,PTLRL(GROUP,DATE,NAME,RESULT))^I $$PARAM^RORTSK01("AGE_RANGE","TYPE")="DOB"
 ; 
 N COLUMNS,HEADER,LT,NAME,TMP
 S HEADER=$$HEADER^RORXU002(.RORTSK,PARTAG)
 Q:HEADER<0 HEADER
 S RC=$$TBLDEF^RORXU002("HEADER^RORX010",HEADER)
 Q $S(RC<0:RC,1:HEADER)
 ;
 ;***** COMPILES THE LAB TESTS BY RANGE REPORT
 ; REPORT CODE: 010
 ;
 ; .RORTSK       Task number and task parameters
 ;
 ; The ^TMP("RORX010",$J) global node is used by this function.
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
LRGRANGE(RORTSK) ;
 N RORDST        ; Callback descriptor
 N ROREDT        ; End date
 N ROREDT1       ; End date + 1 day
 N RORLTL        ; Closed root of the list of lab tests to search for
 N RORREG        ; Registry IEN
 N RORSDT        ; Start date
 N RORCDLIST     ; Flag to indicate whether a clinic or division list exists
 N RORCDSTDT     ; Start date for clinic/division utilization search
 N RORCDENDT     ; End date for clinic/division utilization search
 ;
 N BODY,CNT,ECNT,IEN,IENS,LRGLST,RC,REPORT,RORPTN,SFLAGS,TMP
 N DFN,RCC,FLAG
 ;--- Root node of the report
 S REPORT=$$ADDVAL^RORTSK11(RORTSK,"REPORT")
 Q:REPORT<0 REPORT
 ;
 ;--- Get and prepare the report parameters
 S RORREG=+$$PARAM^RORTSK01("REGIEN")
 S RC=$$PARAMS(REPORT,.SFLAGS,.LRGLST)  Q:RC<0 RC
 ;
 ;--- Initialize constants and variables
 S RORPTN=$$REGSIZE^RORUTL02(+RORREG)  S:RORPTN<0 RORPTN=0
 S ROREDT1=$$FMADD^XLFDT(ROREDT\1,1),ECNT=0
 K ^TMP("RORX010",$J)
 S RORLTL=$$ALLOC^RORTMP()
 ;
 ;--- Prepare the search parameters
 S RORDST=$NA(^TMP("RORX010",$J))
 S RORDST("RORCB")="$$LTCB^RORX010"
 S RC=$$LOADTSTS^RORUTL10(RORLTL,+RORREG,LRGLST)
 ;
 ;--- Report header and list of patients
 S RC=$$HEADER(REPORT)  G:RC<0 ERROR
 S BODY=$$ADDVAL^RORTSK11(RORTSK,"PATIENTS",,REPORT)
 I BODY<0  S RC=+BODY  G ERROR
 D ADDATTR^RORTSK11(RORTSK,BODY,"TABLE","PATIENTS")
 ;
 ;=== Set up Clinic/Division list parameters
 S RORCDLIST=$$CDPARMS^RORXU001(.RORTSK,.RORCDSTDT,.RORCDENDT)
 ;
 ;--- Browse through the registry records
 S (CNT,IEN,RC)=0
 S FLAG=$G(RORTSK("PARAMS","ICDFILT","A","FILTER"))
 F  S IEN=$O(^RORDATA(798,"AC",RORREG,IEN))  Q:IEN'>0  D  Q:RC<0
 . S TMP=$S(RORPTN>0:CNT/RORPTN,1:"")
 . S RC=$$LOOP^RORTSK01(TMP)  Q:RC<0
 . S IENS=IEN_",",CNT=CNT+1
 . ;--- Get patient DFN
 . S DFN=$$PTIEN^RORUTL01(IEN) Q:DFN'>0
 . ;--- Check for patient list and quit if not on list
 . I $D(RORTSK("PARAMS","PATIENTS","C")),'$D(RORTSK("PARAMS","PATIENTS","C",DFN)) Q
 . ;--- Check if the patient should be skipped
 . Q:$$SKIP^RORXU005(IEN,SFLAGS,RORSDT,ROREDT)
 . ;--- Check pateint against ICD Filter
 . S RCC=0
 . I FLAG'="ALL" D
 . . S RCC=$$ICD^RORXU010(DFN)
 . I (FLAG="INCLUDE")&(RCC=0) Q
 . I (FLAG="EXCLUDE")&(RCC=1) Q
 . ;--- End of ICD Check
 . ;--- Check for Clinic or Division list and quit if not in list
 . I RORCDLIST,'$$CDUTIL^RORXU001(.RORTSK,DFN,RORCDSTDT,RORCDENDT) Q
 . ;--- Process the registry record
 . I $$PATIENT(IENS,BODY)<0  S ECNT=ECNT+1  Q
 ;
ERROR ;--- Cleanup
 D FREE^RORTMP(RORLTL)
 K ^TMP("RORX010",$J)
 Q $S(RC<0:RC,ECNT>0:-43,1:0)
 ;
 ;***** CALLBACK FUNCTION FOR LAB DATA SEARCH
LTCB(RORDST,INVDT,RESULT) ;
 N GRP,NODE,RC,VAL
 S NODE=$NA(RORTSK("PARAMS","LRGRANGES","C"))
 S GRP=+$P($G(RESULT(2)),U,3)
 ;--- Check the result range if necessary
 I $D(@NODE@(GRP))>1  S RC=1  D  Q:RC RC
 . S VAL=$$CLRNMVAL^RORUTL18($P($G(RESULT(1)),U,3))
 . ;--- Skip a non-numeric result
 . Q:'$$NUMERIC^RORUTL05(VAL)
 . ;--- Check the range
 . I $G(@NODE@(GRP,"L"))'=""  Q:VAL<@NODE@(GRP,"L")
 . I $G(@NODE@(GRP,"H"))'=""  Q:VAL>@NODE@(GRP,"H")
 . S RC=0
 ;--- Store the result
 K RORDST("GRP",GRP)
 S RORDST("RORPTR")=$G(RORDST("RORPTR"))+1
 M @RORDST@(RORDST("RORPTR"))=RESULT
 Q 0
 ;
 ;***** OUTPUTS THE REPORT PARAMETERS
 ;
 ; PARTAG        Reference (IEN) to the parent tag
 ;
 ; .FLAGS        Flags for the $$SKIP^RORXU005 are
 ;               returned via this parameter
 ;
 ; .LRGLST       List of lab group codes for the $$LOADTSTS^RORUTL10
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
PARAMS(PARTAG,FLAGS,LRGLST) ;
 N PARAMS,TMP
 S (FLAGS,LRGLST)=""
 S PARAMS=$$PARAMS^RORXU002(.RORTSK,PARTAG,.RORSDT,.ROREDT,.FLAGS)
 Q:PARAMS<0 PARAMS
 ;--- Lab test ranges
 I $D(RORTSK("PARAMS","LRGRANGES","C"))>1  D  Q:RC<0 RC
 . N GRC,ELEMENT,NODE,LRGELMTS,RANGE
 . S NODE=$NA(RORTSK("PARAMS","LRGRANGES","C"))
 . S LRGELMTS=$$ADDVAL^RORTSK11(RORTSK,"LRGRANGES",,PARAMS)
 . S (GRC,RC)=0
 . F  S GRC=$O(@NODE@(GRC))  Q:GRC'>0  D  Q:RC<0
 . . S RANGE=0,TMP=$$RANGE(GRC)
 . . S ELEMENT=$$ADDVAL^RORTSK11(RORTSK,"LRGRANGE",TMP,LRGELMTS)
 . . I ELEMENT<0  S RC=ELEMENT  Q
 . . D ADDATTR^RORTSK11(RORTSK,ELEMENT,"ID",GRC)
 . . S LRGLST=LRGLST_$S(LRGLST'="":","_GRC,1:GRC)
 . . ;--- Process the range values
 . . S TMP=$G(@NODE@(GRC,"L"))
 . . I TMP'=""  D  S RANGE=1
 . . . D ADDATTR^RORTSK11(RORTSK,ELEMENT,"LOW",TMP)
 . . S TMP=$G(@NODE@(GRC,"H"))
 . . I TMP'=""  D  S RANGE=1
 . . . D ADDATTR^RORTSK11(RORTSK,ELEMENT,"HIGH",TMP)
 . . D:RANGE ADDATTR^RORTSK11(RORTSK,ELEMENT,"RANGE",1)
 ;--- Success
 Q PARAMS
 ;
 ;***** ADDS THE PATIENT DATA TO THE REPORT
 ;
 ; IENS          IENS of the patient's record in the registry
 ; PARTAG        Reference (IEN) to the parent tag
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
PATIENT(IENS,PARTAG) ;
 N DFN,I,LABTESTS,LT,NAME,PTAG,RC,RORBUF,RORMSG,TMP,VA,VADM,RORPACT,RORPCP,AGE,AGETYPE
 ;--- Get the data from the ROR REGISTRY RECORD file
 K RORMSG D GETS^DIQ(798,IENS,".01","I","RORBUF","RORMSG")
 ;Q:$G(DIERR) $$DBS^RORERR("RORMSG",-9,,,798,IENS)
 Q:$G(RORMSG("DIERR")) $$DBS^RORERR("RORMSG",-9,,,798,IENS)
 S DFN=$G(RORBUF(798,IENS,.01,"I"))
 ;--- Search for the lab results
 K @RORDST,RORDST("RORPTR")
 M RORDST("GRP")=RORTSK("PARAMS","LRGRANGES","C")
 S RC=$$LTSEARCH^RORUTL10(DFN,RORLTL,.RORDST,,RORSDT,ROREDT1)
 Q:RC'>0 RC
 ;--- Results from all groups should be present
 Q:$D(RORDST("GRP"))>1 0
 ;--- Load the demographic data
 D VADEM^RORUTL05(DFN,1)
 ;--- The <PATIENT> tag
 S PTAG=$$ADDVAL^RORTSK11(RORTSK,"PATIENT",,PARTAG,,DFN)
 Q:PTAG<0 PTAG
 ;--- Patient Name
 D ADDVAL^RORTSK11(RORTSK,"NAME",VADM(1),PTAG,1)
 ;--- Last 4 digits of the SSN
 D ADDVAL^RORTSK11(RORTSK,"LAST4",VA("BID"),PTAG,2)
 ;--- Age/DOB
 S AGETYPE=$$PARAM^RORTSK01("AGE_RANGE","TYPE")
 S AGE=$S(AGETYPE="AGE":$P(VADM(4),U),AGETYPE="DOB":$$DATE^RORXU002($P(VADM(3),U)\1),1:"")
 I AGETYPE'="ALL" D ADDVAL^RORTSK11(RORTSK,AGETYPE,AGE,PTAG,1)
 ;--- Date of death
 S TMP=$$DATE^RORXU002($P(VADM(6),U)\1)
 D ADDVAL^RORTSK11(RORTSK,"DOD",TMP,PTAG,1)
 I $$PARAM^RORTSK01("PATIENTS","ICN") D
 . S TMP=$$ICN^RORUTL02(DFN)
 . D ADDVAL^RORTSK11(RORTSK,"ICN",TMP,PTAG,1)
 I $$PARAM^RORTSK01("PATIENTS","PACT") S RORPACT="" D
 . S RORPACT=$$PACT^RORUTL02(DFN) D ADDVAL^RORTSK11(RORTSK,"PACT",RORPACT,PTAG,1)
 ;
 I $$PARAM^RORTSK01("PATIENTS","PCP") S RORPCP="" D
 . S RORPCP=$$PCP^RORUTL02(DFN) D ADDVAL^RORTSK11(RORTSK,"PCP",RORPCP,PTAG,1)
 ;--- Lab results
 S LABTESTS=$$ADDVAL^RORTSK11(RORTSK,"PTLRL",,PTAG)
 S I=""
 F  S I=$O(@RORDST@(I))  Q:I=""  D
 . S LT=$$ADDVAL^RORTSK11(RORTSK,"LT",,LABTESTS)
 . D ADDVAL^RORTSK11(RORTSK,"GROUP",$P(@RORDST@(I,2),U,4),LT,1)
 . D ADDVAL^RORTSK11(RORTSK,"DATE",$P(@RORDST@(I,1),U,2),LT,1)
 . D ADDVAL^RORTSK11(RORTSK,"NAME",$P(@RORDST@(I,2),U,2),LT,1)
 . D ADDVAL^RORTSK11(RORTSK,"RESULT",$P(@RORDST@(I,1),U,3),LT,3)
 ;---
 Q $S(RC<0:RC,1:0)
 ;
 ;***** PROCESSES THE RESULT RANGE OPTIONS
 ;
 ; GRC           Code of a Lab Group
 ;
 ; Return Values:
 ;       Description of the Lab results to be included in the report.
 ;
RANGE(GRC) ;
 N RANGE,TMP
 S RANGE=""
 ;--- Range
 D:$D(RORTSK("PARAMS","LRGRANGES","C",GRC))>1
 . ;--- Low
 . S TMP=$G(RORTSK("PARAMS","LRGRANGES","C",GRC,"L"))
 . S:TMP'="" RANGE=RANGE_" not less than "_TMP
 . ;--- High
 . S TMP=$G(RORTSK("PARAMS","LRGRANGES","C",GRC,"H"))
 . I TMP'=""  D:RANGE'=""  S RANGE=RANGE_" not greater than "_TMP
 . . S RANGE=RANGE_" and"
 ;--- Description
 S TMP=$G(RORTSK("PARAMS","LRGRANGES","C",GRC))
 S:TMP="" TMP="Unknown ("_GRC_")"
 Q TMP_" - "_$S(RANGE'="":"numeric results"_RANGE,1:"all results")
