RORX021 ;BPOIFO/CLR - HCV DAA CANDIDATES REPORT ;26 May 2015  4:02 PM
 ;;1.5;CLINICAL CASE REGISTRIES;**17,21,26,31**;Feb 17, 2006;Build 62
 ;
 ;******************************************************************************
 ;                       --- ROUTINE MODIFICATION LOG ---
 ;        
 ;PKG/PATCH    DATE        DEVELOPER    MODIFICATION
 ;-----------  ----------  -----------  ----------------------------------------
 ;ROR*1.5*21   SEP 2013    T KOPP       Added ICN as last report column if
 ;                                      additional identifier option selected
 ;ROR*1.5*26   JAN 2015    T KOPP       Added FIB4 parameters set and header
 ;                                      for FIB4 score. Remove treatment status.
 ;ROR*1.5*31   MAY 2017    M FERRARESE  Adding PACT ,PCP,and AGE/DOB as additional
 ;                                      identifiers.
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
 ;       >0  IEN of the HEADER element
 ;
HEADER(PARTAG) ;
 ;;PATIENTS(#,NAME,LAST4,HCV_DATE,HCV,GT,FILL_DATE,FILL_MED,FIB4,ICN,PACT,PCP)^I $$PARAM^RORTSK01("AGE_RANGE","TYPE")="ALL"
 ;;PATIENTS(#,NAME,LAST4,AGE,HCV_DATE,HCV,GT,FILL_DATE,FILL_MED,FIB4,ICN,PACT,PCP)^I $$PARAM^RORTSK01("AGE_RANGE","TYPE")="AGE"
 ;;PATIENTS(#,NAME,LAST4,DOB,HCV_DATE,HCV,GT,FILL_DATE,FILL_MED,FIB4,ICN,PACT,PCP)^I $$PARAM^RORTSK01("AGE_RANGE","TYPE")="DOB"
 ;
 N HEADER,RC
 S HEADER=$$HEADER^RORXU002(.RORTSK,PARTAG)
 Q:HEADER<0 HEADER
 S RC=$$TBLDEF^RORXU002("HEADER^RORX021",HEADER)
 Q $S(RC<0:RC,1:HEADER)
 ;
 ;***** COMPILES THE "POTENTIAL DAA CANDIDATES" REPORT
 ; REPORT CODE: 021
 ;
 ; .RORTSK       Task number and task parameters
 ;
 ; The ^TMP("RORX021",$J) global node is used by this function.
 ;
 ; ^TMP("RORX021",$J,
 ;   "PAT",
 ;     DFN,              Patient descriptor
 ;                         ^01: Last 4 digits of SSN
 ;                         ^02: Patient name
 ;                         ^03: Treatment History (not used)
 ;                         ^04: National ICN
 ;                         ^05: FIB4 score
 ;                         ^06: Patient Care Team
 ;                         ^07: Priamary Care Provider
 ;                         ^08: Age/DOB
 ;       "LR",
 ;         Category,
 ;           Date(inverse) = Result
 ;            
 ;       "RX",
 ;         Date(inverse),
 ;           Generic Drug Name,
 ;             Drug IEN,
 ;                RX #,
 ;                   Count) = ""
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
HCVDAA(RORTSK) ;
 N RORLTST       ; Closed root of the list of lab tests for the
 ;               ; Lab search API
 N RORREG        ; Registry IEN
 N RORSDT       ; Pharmacy start date
 N ROREDT       ; Pharmacy end date
 N RORXGRP       ; List of drug groups
 N RORXL         ; Closed root of the drug list for the pharmacy
 ;               ; search API 
 N RORLC         ; sub-file and LOINC codes to search for FIB4
 N ECNT,NSPT,RC,SFLAGS,TMP,BUF,RORDATA
 N REPORT,PARAMS,ELEMENT  ;XML parent variables
 ;
 S (RORXL,RORLTST)="",(ECNT,RC)=0
 K ^TMP("RORX021",$J)
 ;--- Root node of the report
 S REPORT=$$ADDVAL^RORTSK11(RORTSK,"REPORT")
 Q:REPORT<0 REPORT
 ;
 ;--- Get and prepare the report parameters
 D
 . N Z
 . S RORREG=$$PARAM^RORTSK01("REGIEN")  ; Registry IEN
 . S PARAMS=$$PARAMS^RORXU002(.RORTSK,REPORT,.RORXSDT,.RORXEDT,.SFLAGS)
 . I PARAMS<0 S RC=PARAMS Q
 . S Z=0,RORDATA("IDLST")=""
 . F  S Z=$O(RORTSK("PARAMS","LRGRANGES","C",Z)) Q:'Z  D
 .. S RORDATA("IDLST")=RORDATA("IDLST")_$S(RORDATA("IDLST")'="":",",1:"")_Z
 . K:RORDATA("IDLST")="" RORDATA("IDLST")
 . I $D(RORDATA("IDLST")) D  Q:RC<0
 .. D LIVPARAM^RORX019(.RORDATA,.RORTSK,.RORLC)
 .. ;--- Add lab results range parameters to output
 .. S RC=$$PARAMS(PARAMS,.RORDATA,.RORTSK)
 .. Q:RC<0
 .. S ELEMENT=$$ADDVAL^RORTSK11(RORTSK,"FIB4",$$OPTXT^RORXU002(.RORDATA),PARAMS)
 .. I ELEMENT<0 S RC=ELEMENT Q
 . Q:RC<0
 . ;--- Get and store treatment history parameters
 . M BUF=RORTSK("PARAMS","TREATMENT_HISTORY","A")  Q:$D(BUF)<10
 . S ELEMENT=$$ADDVAL^RORTSK11(RORTSK,"TREATMENT_HISTORY",$$OPTXT^RORXU002(.BUF),PARAMS)
 . I ELEMENT'>0  S RC=ELEMENT  Q
 . S TMP=""
 . F  S TMP=$O(BUF(TMP))  Q:TMP=""  D  Q:RC<0
 . . S RC=$$ADDATTR^RORTSK11(RORTSK,ELEMENT,TMP,BUF(TMP))
 . ;--- Report header
 . S RC=$$HEADER(REPORT)  Q:RC<0
 . ;--- Query the registry
 . D TPPSETUP^RORTSK01(80)
 . S RC=$$QUERY^RORX021A(REPORT,SFLAGS,.NSPT,.RORLC)
 . I RC Q:RC<0  S ECNT=ECNT+RC
 . ;--- Store the results
 . D TPPSETUP^RORTSK01(20)
 . S RC=$$STORE^RORX021A(REPORT,NSPT)
 . I RC Q:RC<0  S ECNT=ECNT+RC
 ;--- Cleanup
 K ^TMP("RORX021",$J)
 ;
 Q $S(RC<0:RC,ECNT>0:-43,1:0)
 ;
  ;*****************************************************************************
 ;OUTPUT REPORT 'RANGE' PARAMETERS, SET UP REPORT ID LIST (EXTRINISIC FUNCTION)
 ;
 ; PARTAG        Reference (IEN) to the parent tag
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;*****************************************************************************
PARAMS(PARTAG,RORDATA,RORTSK) ;  Currently, only FIB-4 is used for this report
 N PARAMS,DESC,TMP,RC S RC=0
 ;--- Lab test ranges
 S RORDATA("RANGE",4)=0 ;initialize FIB4 to 'no range passed in'
 I $D(RORTSK("PARAMS","LRGRANGES","C",4)) D  Q:RC<0 RC
 . N ELEMENT,NODE,RTAG,RANGE
 . S NODE=$NA(RORTSK("PARAMS","LRGRANGES","C"))
 . S RTAG=$$ADDVAL^RORTSK11(RORTSK,"LRGRANGES",,PARTAG)
 . S RANGE=0,DESC=$$RTEXT^RORX019A(4,.RORDATA,.RORTSK) ;get range description
 . S ELEMENT=$$ADDVAL^RORTSK11(RORTSK,"LRGRANGE",DESC,RTAG) ;add desc to output
 . I ELEMENT<0 S RC=ELEMENT Q
 . D ADDATTR^RORTSK11(RORTSK,ELEMENT,"ID",4)
 . ;--- Process the range values
 . S TMP=$G(@NODE@(4,"L"))
 . I TMP'="" D  S RANGE=1
 .. D ADDATTR^RORTSK11(RORTSK,ELEMENT,"LOW",TMP) S RORDATA("RANGE",4)=1
 .. S TMP=$G(@NODE@(4,"H"))
 .. I TMP'="" D  S RANGE=1
 ... D ADDATTR^RORTSK11(RORTSK,ELEMENT,"HIGH",TMP) S RORDATA("RANGE",4)=1
 .. I RANGE D ADDATTR^RORTSK11(RORTSK,ELEMENT,"RANGE",1)
 Q RC
 ;
