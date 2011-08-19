RORX008 ;HOIFO/BH,SG - VERA REIMBURSEMENT REPORT ; 11/8/05 8:38am
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 ;--------------------------------------------------------------------
 ; Registry: [VA ICR]
 ;--------------------------------------------------------------------
 Q
 ;
 ;***** COMPILES THE "VERA REIMBURSEMENT" REPORT
 ; REPORT CODE: 008
 ;
 ; .RORTSK       Task number and task parameters
 ;
 ; The ^TMP("RORX008",$J) global node is used by this function.
 ;
 ; ^TMP("RORX008",$J,
 ;
 ;   "DRG",
 ;     GenDrugIEN,       Generic drug name
 ;       0)              Number of HIV+ patients
 ;       1)              Number of Clinical AIDS patients
 ;
 ;   "PAT",              Totals
 ;                         ^01: Number of basic care patients
 ;                         ^02: Number of complex care patients
 ;                         ^03: Number of patients received ARVs
 ;     DFN)              Patient Descriptor
 ;                         ^01: Las 4 digits of SSN
 ;                         ^02: Name
 ;                         ^03: Date of Death (FileMan)
 ;                         ^04: Received ARV drugs(0/1)
 ;                         ^05: Complex care (0/1)
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
ARVREIMB(RORTSK) ;
 N ROREDT        ; End date
 N ROREDT1       ; End date + 1
 N RORREG        ; Registry IEN
 N RORSDT        ; Start date
 N RORXL         ; Drug list for the pharmacy search API
 ;
 N ECNT,RC,REPORT,SFLAGS,TMP
 K ^TMP("RORX008",$J)
 S RORXL="",(ECNT,RC)=0
 ;--- Root node of the report
 S REPORT=$$ADDVAL^RORTSK11(RORTSK,"REPORT")
 Q:REPORT<0 REPORT
 ;
 D
 . ;--- Get and prepare the report parameters
 . S RORREG=$$PARAM^RORTSK01("REGIEN")
 . S RC=$$PARAMS(REPORT,.RORSDT,.ROREDT,.SFLAGS)  Q:RC<0
 . S ROREDT1=$$FMADD^XLFDT(ROREDT\1,1)
 . ;--- Report header
 . S RC=$$HEADER(REPORT)  Q:RC<0
 . ;--- Query the registry
 . D TPPSETUP^RORTSK01(75)
 . S RC=$$QUERY^RORX008A(SFLAGS)
 . I RC  Q:RC<0  S ECNT=ECNT+RC
 . ;--- Store the results
 . D TPPSETUP^RORTSK01(25)
 . S RC=$$STORE^RORX008A(REPORT)
 . I RC  Q:RC<0  S ECNT=ECNT+RC
 ;
 ;--- Cleanup
 K ^TMP("RORX008",$J)
 D FREE^RORTMP(RORXL)
 Q $S(RC<0:RC,ECNT>0:-43,1:0)
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
 ;;DRUGS(#,NAME,NP,NPHIV,NPAIDS)         ^I $$PARAM^RORTSK01("OPTIONS","REGMEDSMRY")
 ;;PATIENTS(#,NAME,LAST4,DOD,AIDSTAT,ARV,COMPLEX)^I $$PARAM^RORTSK01("OPTIONS","PTLIST")
 ;
 N HEADER,RC
 S HEADER=$$HEADER^RORXU002(.RORTSK,PARTAG)
 Q:HEADER<0 HEADER
 S RC=$$TBLDEF^RORXU002("HEADER^RORX008",HEADER)
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
 N PARAMS,TMP
 S PARAMS=$$PARAMS^RORXU002(.RORTSK,PARTAG,.STDT,.ENDT,.FLAGS)
 Q:PARAMS<0 PARAMS
 ;--- Process the drug list and options
 S RORTSK("PARAMS","DRUGS","A","REGMEDS")=1
 S TMP=$$DRUGLST^RORXU007(.RORTSK,PARAMS,.RORXL)
 Q:TMP<0 TMP
 ;---
 Q PARAMS
