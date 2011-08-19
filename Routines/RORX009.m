RORX009 ;HCIOFO/SG - PHARMACY PRESCRIPTION UTILIZATION ; 11/16/05 10:49am
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
 ;;DOSES(NP,IPNRX)^I $$PARAM^RORTSK01("PATIENTS","INPATIENT")
 ;;DRUGS_DOSES(#,NAME,NP,IPNRX,MAXNRPP,MAXNP)
 ;;DRUGS_FILLS(#,NAME,NP,OPNRX,MAXNRPP,MAXNP)
 ;;FILLS(NP,OPNRX)^I $$PARAM^RORTSK01("PATIENTS","OUTPATIENT")
 ;;HU_DOSES(#,NAME,LAST4,DOD,IPNRX,ND)^I $$PARAM^RORTSK01("PATIENTS","INPATIENT")
 ;;HU_FILLS(#,NAME,LAST4,DOD,OPNRX,ND)^I $$PARAM^RORTSK01("PATIENTS","OUTPATIENT")
 ;;HU_NRX(#,NAME,LAST4,DOD,OPNRX,IPNRX,ND)^I $$PARAM^RORTSK01("PATIENTS","OUTPATIENT"),$$PARAM^RORTSK01("PATIENTS","INPATIENT")
 ;
 N HEADER,RC
 S HEADER=$$HEADER^RORXU002(.RORTSK,PARTAG)
 Q:HEADER<0 HEADER
 S RC=$$TBLDEF^RORXU002("HEADER^RORX009",HEADER)
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
 S TMP=$$DRUGLST^RORXU007(.RORTSK,PARAMS,.RORXL,.RORXGRP)
 Q:TMP<0 TMP
 ;--- Additional parameters
 F NAME="MAXUTNUM"  D
 . S TMP=$$PARAM^RORTSK01(NAME)
 . D:TMP'="" ADDVAL^RORTSK11(RORTSK,NAME,TMP,PARAMS)
 ;---
 Q PARAMS
 ;
 ;***** COMPILES THE "PHARMACY PRESCRIPTION UTILIZATION" REPORT
 ; REPORT CODE: 009
 ;
 ; .RORTSK       Task number and task parameters
 ;
 ; The ^TMP("RORX009",$J) global node is used by this function.
 ;
 ; ^TMP("RORX009",$J,
 ;
 ;     "IP",             Number of inpatients
 ;       DFN,            Patient's data
 ;                         ^01: Last 4 digits of SSN
 ;                         ^02: Name
 ;                         ^03: Date of Death
 ;                         ^04: Total number of doses
 ;                         ^05: Number of different drugs
 ;         "D",
 ;           DrugIEN)    Quantity
 ;
 ;     "IPD",            Number of different drugs
 ;       DrugIEN,        Drug Name
 ;         "D")          Number of doses
 ;         "M")          Maximum
 ;                         ^01: Maximum number of doses
 ;                         ^02: Number of patients
 ;         "P")          Number of patients
 ;       "B",
 ;         NumOfDoses,
 ;           DrugName,
 ;             DrugIEN)  ""
 ;
 ;     "IPRX",           Total number of doses
 ;       NumOfDoses,     Number of patients
 ;         PatientName,
 ;           DFN)        ""
 ;
 ;     "OP",             Number of outpatients
 ;       DFN,            Patient's data
 ;                         ^01: Last 4 digits of SSN
 ;                         ^02: Name
 ;                         ^03: Date of Death
 ;                         ^04: Total number of fills
 ;                         ^05: Number of different drugs
 ;         "D",
 ;           DrugIEN)    Quantity
 ;
 ;     "OPD",            Number of different drugs
 ;       DrugIEN,        Drug Name
 ;         "D")          Number of fills
 ;         "M")          Maximum
 ;                         ^01: Maximum number of fills
 ;                         ^02: Number of patients
 ;         "P")          Number of patients
 ;       "B",
 ;         NumOfFills,
 ;           DrugName,
 ;             DrugIEN)  ""
 ;
 ;     "OPRX",           Total number of fills
 ;       NumOfFills,     Number of patients
 ;         PatientName,
 ;           DFN)        ""
 ;
 ;     "SUMRX",
 ;       NumberOfRX,     Number of patients
 ;         PatientName,
 ;           DFN,        Number of different drugs
 ;             "IP")
 ;             "OP")
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
RXUTIL(RORTSK) ;
 N ROREDT        ; End date
 N RORREG        ; Registry IEN
 N RORSDT        ; Start date
 N RORXGRP       ; List of drug groups
 N RORXL         ; List of drugs for the pharmacy search API
 ;
 N ECNT,RC,REPORT,SFLAGS,TMP
 S RORXL="",(ECNT,RC)=0
 K ^TMP("RORX009",$J)
 ;--- Root node of the report
 S REPORT=$$ADDVAL^RORTSK11(RORTSK,"REPORT")
 Q:REPORT<0 REPORT
 ;
 D
 . ;--- Get and prepare the report parameters
 . S RORREG=$$PARAM^RORTSK01("REGIEN")
 . S RC=$$PARAMS(REPORT,.RORSDT,.ROREDT,.SFLAGS)  Q:RC<0
 . ;--- Report header
 . S RC=$$HEADER(REPORT)  Q:RC<0
 . ;--- Query the registry
 . D TPPSETUP^RORTSK01(80)
 . S RC=$$QUERY^RORX009A(SFLAGS)
 . I RC  Q:RC<0  S ECNT=ECNT+RC
 . ;--- Sort the data
 . D TPPSETUP^RORTSK01(10)
 . S RC=$$SORT^RORX009A()
 . I RC  Q:RC<0  S ECNT=ECNT+RC
 . ;--- Store the results
 . D TPPSETUP^RORTSK01(10)
 . S RC=$$STORE^RORX009C(REPORT)
 . I RC  Q:RC<0  S ECNT=ECNT+RC
 ;
 ;--- Cleanup
 K ^TMP("RORX009",$J)
 D FREE^RORTMP(RORXL)
 Q $S(RC<0:RC,ECNT>0:-43,1:0)
