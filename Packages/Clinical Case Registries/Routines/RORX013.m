RORX013 ;HOIFO/SG - DIAGNOSIS CODES REPORT ; 6/21/06 3:05pm
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
 ;;ICD9LST(#,CODE,DIAG,NP,NC)
 ;;PATIENTS(#,NAME,LAST4,DOD,PTICDL(CODE,DIAG,DATE,SOURCE))
 ;
 N HEADER,RC
 S HEADER=$$HEADER^RORXU002(.RORTSK,PARTAG)
 Q:HEADER<0 HEADER
 S RC=$$TBLDEF^RORXU002("HEADER^RORX013",HEADER)
 Q $S(RC<0:RC,1:HEADER)
 ;
 ;
 ;***** COMPILES THE "DIAGNOSIS CODE" REPORT
 ; REPORT CODE: 013
 ;
 ; .RORTSK       Task number and task parameters
 ;
 ; The ^TMP("VSIT",$J) global node is used by this function.
 ;
 ; @RORTMP@(
 ;
 ;   "PAT",              Number of patients
 ;     DFN,              Descriptor
 ;                         ^01: Las 4 digits of SSN
 ;                         ^02: Name
 ;                         ^03: Date of Death
 ;       ICD9IEN,        Earliest Code Descriptor
 ;                         ^01: Date
 ;                         ^02: Source ("I", "O", or "PB")
 ;         "C")          Quantity
 ;         "I")          Inpatient quantity
 ;         "O")          Outpatient quantity
 ;         "PB")         Problem List quantity
 ;
 ;   "ICD",              Totals
 ;                         ^01: Number of ICD-9 codes
 ;                         ^02: Number of different codes
 ;     ICD9IEN,          ICD-9 Descriptor
 ;                         ^01: Code
 ;                         ^02: Diagnosis (current version)
 ;       "C")            Quantity
 ;       "P")            Number of unique patients
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
ICD9LST(RORTSK) ;
 N ROREDT        ; End date
 N RORICDL       ; Prepared list of ICD-9 codes
 N RORIGRP       ; List of ICD-9 groups
 N RORREG        ; Registry IEN
 N RORSDT        ; Start date
 N RORTMP        ; Closed root of the temporary buffer
 ;
 N ECNT,RC,REPORT,SFLAGS,TMP
 S RORICDL="",(ECNT,RC)=0
 ;--- Root node of the report
 S REPORT=$$ADDVAL^RORTSK11(RORTSK,"REPORT")
 Q:REPORT<0 REPORT
 ;
 ;--- Get and prepare the report parameters
 S RORREG=$$PARAM^RORTSK01("REGIEN")
 S RC=$$PARAMS(REPORT,.RORSDT,.ROREDT,.SFLAGS)  Q:RC<0 RC
 ;
 ;--- Report header
 S RC=$$HEADER(REPORT)  Q:RC<0 RC
 S RORTMP=$$ALLOC^RORTMP()
 D
 . ;--- Query the registry
 . D TPPSETUP^RORTSK01(70)
 . S RC=$$QUERY^RORX013A(SFLAGS)
 . I RC  Q:RC<0  S ECNT=ECNT+RC
 . ;--- Sort the data
 . D TPPSETUP^RORTSK01(10)
 . S RC=$$SORT^RORX013A()
 . I RC  Q:RC<0  S ECNT=ECNT+RC
 . ;--- Store the results
 . D TPPSETUP^RORTSK01(20)
 . S RC=$$STORE^RORX013C(REPORT)
 . I RC  Q:RC<0  S ECNT=ECNT+RC
 ;
 ;--- Cleanup
 D FREE^RORTMP(RORTMP),FREE^RORTMP(RORICDL)
 K ^TMP("VSIT",$J)
 Q $S(RC<0:RC,ECNT>0:-43,1:0)
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
 ;--- Process the list of ICD9 codes
 S TMP=$$ICD9LST^RORXU008(.RORTSK,PARAMS,.RORICDL,.RORIGRP)
 Q:TMP<0 TMP
 ;---
 Q PARAMS
