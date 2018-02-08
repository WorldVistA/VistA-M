RORX023 ;ALB/TMK -  HCV SUSTAINED VIROLOGIC RESPONSE REPORT ;7/21/11 1:04pm
 ;;1.5;CLINICAL CASE REGISTRIES;**24,31**;Feb 17, 2006;Build 62
 ;
 ;******************************************************************************
 ;                       --- ROUTINE MODIFICATION LOG ---
 ;        
 ;PKG/PATCH    DATE        DEVELOPER    MODIFICATION
 ;-----------  ----------  -----------  ----------------------------------------
 ;ROR*1.5*24   JUN 2014    T KOPP       Created report
 ;ROR*1.5*31   MAY 2017    M FERRARESE  Adding PACT, PCP, and AGE/DOB as additional
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
 ;;PATIENTS(#,NAME,LAST4,HCV_DATE,HCV,GT,LAST_TAKEN,ICN,PACT,PCP)^I $$PARAM^RORTSK01("AGE_RANGE","TYPE")="ALL"
 ;;PATIENTS(#,NAME,LAST4,AGE,HCV_DATE,HCV,GT,LAST_TAKEN,ICN,PACT,PCP)^I $$PARAM^RORTSK01("AGE_RANGE","TYPE")="AGE"
 ;;PATIENTS(#,NAME,LAST4,DOB,HCV_DATE,HCV,GT,LAST_TAKEN,ICN,PACT,PCP)^I $$PARAM^RORTSK01("AGE_RANGE","TYPE")="DOB"
 ;
 N HEADER,RC
 S HEADER=$$HEADER^RORXU002(.RORTSK,PARTAG)
 Q:HEADER<0 HEADER
 S RC=$$TBLDEF^RORXU002("HEADER^RORX023",HEADER)
 Q $S(RC<0:RC,1:HEADER)
 ;
 ;***** COMPILES THE "SUSTAINED VIROLOGIC RESPONSE" REPORT
 ; REPORT CODE: 023
 ;
 ; .RORTSK       Task number and task parameters
 ;
 ; The ^TMP("RORX023",$J) global node is used by this function.
 ;
 ; ^TMP("RORX023",$J,
 ;   "PAT",
 ;     DFN,              Patient descriptor
 ;                         ^01: Last 4 digits of SSN
 ;                         ^02: Patient name
 ;                         ^03: empty
 ;                         ^04: National ICN
 ;                         ^05: Patient Care Team
 ;                         ^06: Priamary Care Provider
 ;                         ^07: Age/DOB
 ;       "LR",
 ;         Category,
 ;           Date(inverse) = Result
 ;            
 ;       "RX",
 ;         Last Taken Date) = ""
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
HCVSVR(RORTSK) ;
 N RORLTST       ; Closed root of the list of lab tests for the
 ;               ; Lab search API
 N RORREG        ; Registry IEN
 N RORSDT       ; Pharmacy start date
 N ROREDT       ; Pharmacy end date
 N RORXGRP       ; List of drug groups
 N RORXL         ; Closed root of the drug list for the pharmacy
 ;               ; search API 
 N ECNT,NSPT,RC,SFLAGS,TMP,BUF,RORXEDT,RORXSDT
 N REPORT,PARAMS,ELEMENT  ;XML parent variables
 ;
 S (RORXL,RORLTST)="",(ECNT,RC)=0
 K ^TMP("RORX023",$J)
 ;--- Root node of the report
 S REPORT=$$ADDVAL^RORTSK11(RORTSK,"REPORT")
 Q:REPORT<0 REPORT
 ;
 ;--- Get and prepare the report parameters
 D
 . S RORREG=$$PARAM^RORTSK01("REGIEN")  ; Registry IEN
 . S PARAMS=$$PARAMS^RORXU002(.RORTSK,REPORT,.RORXSDT,.RORXEDT,.SFLAGS)
 . Q:PARAMS<0
 . S TMP=""
 . F  S TMP=$O(BUF(TMP))  Q:TMP=""  D  Q:RC<0
 . . S RC=$$ADDATTR^RORTSK11(RORTSK,ELEMENT,TMP,BUF(TMP))
 . ;--- Report header
 . S RC=$$HEADER(REPORT)  Q:RC<0
 . ;--- Query the registry
 . D TPPSETUP^RORTSK01(80)
 . S RC=$$QUERY^RORX023A(REPORT,SFLAGS,.NSPT)
 . I RC Q:RC<0  S ECNT=ECNT+RC
 . ;--- Store the results
 . D TPPSETUP^RORTSK01(20)
 . S RC=$$STORE^RORX023A(REPORT,NSPT)
 . I RC Q:RC<0  S ECNT=ECNT+RC
 ;
 ;--- Cleanup
 K ^TMP("RORX023",$J)
 ;
 Q $S(RC<0:RC,ECNT>0:-43,1:0)
