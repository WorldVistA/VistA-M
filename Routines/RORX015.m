RORX015 ;HOIFO/SG - PROCEDURES REPORT ; 6/23/06 1:36pm
 ;;1.5;CLINICAL CASE REGISTRIES;**1**;Feb 17, 2006;Build 24
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
 ;;PROCLST(#,PROCODE,PROCNAME,NP,NC,SOURCE)
 ;;PROCEDURES(#,NAME,LAST4,DOD,PROCODE,PROCNAME,DATE,SOURCE)
 ;;PATIENTS(#,NAME,LAST4,DOD)
 ;
 N HEADER,RC
 S HEADER=$$HEADER^RORXU002(.RORTSK,PARTAG)
 Q:HEADER<0 HEADER
 S RC=$$TBLDEF^RORXU002("HEADER^RORX015",HEADER)
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
 ;--- Process the list of ICD-9 codes
 I $$PARAM^RORTSK01("PATIENTS","INPATIENT")  D  Q:TMP<0 TMP
 . S TMP=$$ICD9LST^RORXU008(.RORTSK,PARAMS,.RORICDL,.RORIGRP)
 ;--- Process the list of CPT codes
 I $$PARAM^RORTSK01("PATIENTS","OUTPATIENT")  D  Q:TMP<0 TMP
 . S TMP=$$CPTLST^RORXU006(.RORTSK,PARAMS)
 ;---
 Q PARAMS
 ;
 ;***** COMPILES THE "PROCEDURES" REPORT
 ; REPORT CODE: 015
 ;
 ; .RORTSK       Task number and task parameters
 ;
 ; @RORTMP@(
 ;
 ;   "PAT",              Number of patients
 ;     DFN,              Descriptor
 ;                         ^01: Las 4 digits of SSN
 ;                         ^02: Name
 ;                         ^03: Date of Death
 ;       "I",
 ;         ICDIEN,       Earliest Code Descriptor
 ;                         ^01: Date
 ;         "C")          Quantity
 ;       "O",
 ;         CPTIEN,       Earliest Code Descriptor
 ;                         ^01: Date
 ;           "C")        Quantity
 ;
 ;   "PROC",             Totals
 ;                         ^01: Number of procedure codes
 ;                         ^02: Number of different codes
 ;     "B",
 ;       ProcName,
 ;         Source,
 ;           IEN)        ""
 ;     "I",
 ;       ICDIEN,         Procedure Descriptor
 ;                         ^01: Code
 ;                         ^02: Short description (current version)
 ;         "C")          Quantity
 ;         "P")          Number of unique patients
 ;     "O",
 ;       CPTIEN,         Procedure Descriptor
 ;                         ^01: Code
 ;                         ^02: Short description (current version)
 ;         "C")          Quantity
 ;         "P")          Number of unique patients
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
PROCLST(RORTSK) ;
 N RORPROC       ; Procedures mode (-1|1)
 N ROREDT        ; End date
 N RORICDL       ; Prepared list of ICD-9 codes
 N RORIGRP       ; List of ICD-9 groups
 N RORREG        ; Registry IEN
 N RORSDT        ; Start date
 N RORTMP        ; Closed root of the temporary buffer
 ;
 N ECNT,RC,REPORT,SFLAGS,TMP
 S (ECNT,RC)=0,(RORICDL,RORTMP)=""
 ;
 ;--- Root node of the report
 S REPORT=$$ADDVAL^RORTSK11(RORTSK,"REPORT")
 Q:REPORT<0 REPORT
 ;
 ;--- Get and prepare the report parameters
 S RORREG=$$PARAM^RORTSK01("REGIEN")
 S RC=$$PARAMS(REPORT,.RORSDT,.ROREDT,.SFLAGS)  Q:RC<0 RC
 S RORPROC=$$RPTMODE("PROC")
 ;
 ;--- Report header
 S RC=$$HEADER(REPORT)  Q:RC<0 RC
 S RORTMP=$$ALLOC^RORTMP()
 D
 . ;--- Query the registry
 . D TPPSETUP^RORTSK01(70)
 . S RC=$$QUERY^RORX015A(SFLAGS)
 . I RC  Q:RC<0  S ECNT=ECNT+RC
 . ;--- Sort the data
 . D TPPSETUP^RORTSK01(10)
 . S RC=$$SORT^RORX015A()
 . I RC  Q:RC<0  S ECNT=ECNT+RC
 . ;--- Store the results
 . D TPPSETUP^RORTSK01(20)
 . S RC=$$STORE^RORX015C(REPORT)
 . I RC  Q:RC<0  S ECNT=ECNT+RC
 ;
 ;--- Cleanup
 D FREE^RORTMP(RORTMP),FREE^RORTMP(RORICDL)
 Q $S(RC<0:RC,ECNT>0:-43,1:0)
 ;
 ;***** DETERMINES THE REPORT MODE FOR PROCEDURES
 ;
 ; NAME          Base name of the attribute ("PROC")
 ;
 ; Return Values:
 ;       <0  "Did Not"
 ;        0  Not selected
 ;       >0  "Did"
RPTMODE(NAME) ;
 Q:$$PARAM^RORTSK01("PATIENTS",NAME) 1        ; "Did"
 Q:$$PARAM^RORTSK01("PATIENTS","NO"_NAME) -1  ; "Did Not"
 Q 0
