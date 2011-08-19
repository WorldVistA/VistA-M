RORX006 ;HCIOFO/BH,SG - LAB UTILIZATION ; 11/8/05 8:53am
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
 ;;LABTESTS(#,NAME,NP,NR,MAXNRPP,MAXNP)
 ;;PATIENTS(#,NAME,LAST4,DOD,NO,NR,NDT)
 ;;RESULTS(NP,NR)
 ;
 N HEADER,RC
 S HEADER=$$HEADER^RORXU002(.RORTSK,PARTAG)
 Q:HEADER<0 HEADER
 S RC=$$TBLDEF^RORXU002("HEADER^RORX006",HEADER)
 Q $S(RC<0:RC,1:HEADER)
 ;
 ;
 ;***** COMPILES THE "LAB UTILIZATION" REPORT
 ; REPORT CODE: 006
 ;
 ; .RORTSK       Task number and task parameters
 ;
 ; The ^TMP("RORX006",$J) global node is used by this function.
 ;
 ; ^TMP("RORX006",$J,
 ;
 ;     "ORD",            Total number of orders
 ;       NumOfOrd,       Number of patients
 ;         PatientName,
 ;           DFN)
 ;
 ;     "PAT",            Total number of patients
 ;       DFN,            Patient descriptor
 ;                         01: Last 4 digits of SSN
 ;                         02: Date of death
 ;         "O")          Number of orders
 ;         "R",          Results
 ;                         ^01: Number of results
 ;                         ^02: Number of different tests
 ;           TestIEN)    Number of results
 ;
 ;     "RES",            Totals
 ;                         ^01: Total number of results
 ;                         ^02: Number of different tests
 ;       TestIEN,
 ;         "M")          Maximum
 ;                         ^01: Maximum number of results
 ;                         ^02: Number of patients
 ;         "P")          Number of patients
 ;         "R")          Number of results
 ;       "B",
 ;         NumOfRes,
 ;           TestName,
 ;             TestIEN)
 ;
 ;     "RES1",
 ;       NumOfResults,   Number of patients
 ;         PatientName,
 ;           DFN)
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
LABUTL(RORTSK) ;
 N ROREDT        ; End date
 N ROREDT1       ; End date + 1 day
 N RORLTST       ; Closed root of the list of lab tests
 N RORREG        ; Registry IEN
 N RORSDT        ; Start date
 ;
 N ECNT,RC,REPORT,SFLAGS,TMP
 K ^TMP("RORX006",$J)
 S RORLTST="",(ECNT,RC)=0
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
 . D TPPSETUP^RORTSK01(70)
 . S RC=$$QUERY^RORX006A(SFLAGS)
 . I RC  Q:RC<0  S ECNT=ECNT+RC
 . ;--- Sort the data
 . D TPPSETUP^RORTSK01(15)
 . S RC=$$SORT^RORX006A()
 . I RC  Q:RC<0  S ECNT=ECNT+RC
 . ;--- Store the results
 . D TPPSETUP^RORTSK01(15)
 . S RC=$$STORE^RORX006C(REPORT)
 . I RC  Q:RC<0  S ECNT=ECNT+RC
 ;
 ;--- Cleanup
 D FREE^RORTMP(RORLTST)
 K ^TMP("RORX006",$J)
 Q $S(RC<0:RC,ECNT>0:-43,1:0)
 ;
 ;***** OUTPUTS PARAMETERS TO THE REPORT
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
 ;--- Additional parameters
 F NAME="MAXUTNUM","MINRPNUM"  D
 . S TMP=$$PARAM^RORTSK01(NAME)
 . D:TMP'="" ADDVAL^RORTSK11(RORTSK,NAME,TMP,PARAMS)
 ;--- Process the list of Lab tests
 S TMP=$$LTLST^RORXU006(.RORTSK,PARAMS,.RORLTST)  Q:TMP<0 TMP
 ;---
 Q PARAMS
