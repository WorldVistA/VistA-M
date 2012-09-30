RORX021 ;BPOIFO/CLR - HCV DAA CANDIDATES REPORT ; 7/21/11 1:04pm
 ;;1.5;CLINICAL CASE REGISTRIES;**17**;;Build 33
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
 ;;PATIENTS(#,NAME,LAST4,STATUS,HCV_DATE,HCV,GT,FILL_DATE,FILL_MED)
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
 ;                         ^03: Treatment History
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
 N ECNT,NSPT,RC,SFLAGS,TMP,BUF
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
 . S RORREG=$$PARAM^RORTSK01("REGIEN")  ; Registry IEN
 . S PARAMS=$$PARAMS^RORXU002(.RORTSK,REPORT,.RORXSDT,.RORXEDT,.SFLAGS)
 . Q:PARAMS<0
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
 . S RC=$$QUERY^RORX021A(REPORT,SFLAGS,.NSPT)
 . I RC Q:RC<0  S ECNT=ECNT+RC
 . ;--- Store the results
 . D TPPSETUP^RORTSK01(20)
 . S RC=$$STORE^RORX021A(REPORT,NSPT)
 . I RC Q:RC<0  S ECNT=ECNT+RC
 ;
 ;--- Cleanup
 K ^TMP("RORX021",$J)
 ;
 Q $S(RC<0:RC,ECNT>0:-43,1:0)
