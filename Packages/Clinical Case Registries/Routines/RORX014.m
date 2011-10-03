RORX014 ;HOIFO/SG - REGISTRY MEDICATIONS REPORT ; 11/25/05 5:57pm
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
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
 ;;RXCOMBLST(NP,PATIENTS(NAME,LAST4,DOD))^I $$PARAM^RORTSK01("OPTIONS","COMPLETE")
 ;;RXCOMBLST(NP,RXCOMB)^I $$PARAM^RORTSK01("OPTIONS","SUMMARY")
 ;
 N HEADER,RC
 S HEADER=$$HEADER^RORXU002(.RORTSK,PARTAG)
 Q:HEADER<0 HEADER
 S RC=$$TBLDEF^RORXU002("HEADER^RORX014",HEADER)
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
 N PARAMS,RC
 S PARAMS=$$PARAMS^RORXU002(.RORTSK,PARTAG,.STDT,.ENDT,.FLAGS)
 Q:PARAMS<0 PARAMS
 ;--- Process the drug list and options
 S RORTSK("PARAMS","DRUGS","A","REGMEDS")=1
 S RORTSK("PARAMS","DRUGS","A","AGGR_GENERIC")=1
 S RC=$$DRUGLST^RORXU007(.RORTSK,PARAMS,.RORXL)
 Q:RC<0 RC
 ;--- Success
 Q PARAMS
 ;
 ;***** COMPILES THE "REGISTRY MEDICATIONS" REPORT
 ; REPORT CODE: 014
 ;
 ; .RORTSK       Task number and task parameters
 ;
 ; The ^TMP("RORX014",$J) global node is used by this function.
 ;
 ; ^TMP("RORX014",$J,
 ;   "DRG",
 ;     DrugIEN)          Medication name (generic or formulation)
 ;   "RXC",
 ;     RxcIEN,
 ;       1)              List of Drug IEN's separated by ","
 ;       "P"             Number of patients
 ;         DFN)          Patient Descriptor
 ;                         ^01: Las 4 digits of SSN
 ;                         ^02: Name
 ;                         ^03: Date of Death
 ;     "B",
 ;       RxcNdx,
 ;         RxcIEN)       ""
 ;     "P",
 ;       NumOfPat,
 ;         RxcIEN)       ""
 ;
 ; RxcNdx is the first 100 characters of the list of Drug IEN's.
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
RXCOMB(RORTSK) ;
 N ROREDT        ; End date
 N ROREDT1       ; End date + 1
 N RORREG        ; Registry IEN
 N RORSDT        ; Start date
 N RORXL         ; Drug list for the pharmacy search API
 ;
 N ECNT,NRXC,RC,REPORT,SFLAGS,TMP
 S RORXL="",(ECNT,RC)=0
 K ^TMP("RORX014",$J)
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
 . D TPPSETUP^RORTSK01(80)
 . S RC=$$QUERY^RORX014A(SFLAGS)
 . I RC  Q:RC<0  S ECNT=ECNT+RC
 . ;--- Sort the data
 . D TPPSETUP^RORTSK01(5)
 . S RC=$$SORT^RORX014A(.NRXC)
 . I RC  Q:RC<0  S ECNT=ECNT+RC
 . ;--- Store the results
 . D TPPSETUP^RORTSK01(15)
 . S RC=$$STORE^RORX014A(REPORT,NRXC)
 . I RC  Q:RC<0  S ECNT=ECNT+RC
 ;
 ;--- Cleanup
 K ^TMP("RORX014",$J)
 D FREE^RORTMP(RORXL)
 Q $S(RC<0:RC,ECNT>0:-43,1:0)
