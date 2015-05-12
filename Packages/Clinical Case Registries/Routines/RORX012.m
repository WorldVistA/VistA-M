RORX012 ;HOIFO/SG,VAC - COMBINED MEDS AND LABS REPORT ;4/9/09 9:40am
 ;;1.5;CLINICAL CASE REGISTRIES;**8,21**;Feb 17, 2006;Build 45
 ;
 ;Modified Feb 2009, to permit only the most recent test to be
 ;    displayed on the report - a call to ^RORXU009
 ;
 ;Modified March 2009 to filter patients on Include or Exclude ICD9
 ;    codes.  Call to ^RORXU010
 ;
 ;ROR*1.5*21   SEP 2013    T KOPP       Add ICN column if Additional Identifier
 ;                                       requested.
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
 ;;DRUGS(#,NAME,LAST4,DOD,RXNAME)
 ;;LABTESTS(#,NAME,LAST4,DOD,DATE,LTNAME,RESULT)
 ;;PATIENTS(#,NAME,LAST4,DOD,ICN)
 ;
 N HEADER,RC
 S HEADER=$$HEADER^RORXU002(.RORTSK,PARTAG)
 Q:HEADER<0 HEADER
 S RC=$$TBLDEF^RORXU002("HEADER^RORX012",HEADER)
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
 ;--- Process the list of drugs and groups
 I RORPHARM  D  Q:TMP<0 TMP
 . S TMP=$$DRUGLST^RORXU007(.RORTSK,PARAMS,.RORXL,.RORXGRP)
 ;--- Process the list of Lab tests
 I RORLAB  D  Q:TMP<0 TMP
 . S TMP=$$LTLST^RORXU006(.RORTSK,PARAMS,.RORLTST,"RORLTRV")
 ;---
 Q PARAMS
 ;
 ;***** DETERMINES THE REPORT MODE FOR LAB OR PHARMACY
 ;
 ; NAME          Base name of the attribute ("LAB" or "PHARM")
 ;
 ; Return Values:
 ;       <0  "Did Not"
 ;        0  Not selected
 ;       >0  "Did"
RPTMODE(NAME) ;
 Q:$$PARAM^RORTSK01("PATIENTS",NAME) 1        ; "Did"
 Q:$$PARAM^RORTSK01("PATIENTS","NO"_NAME) -1  ; "Did Not"
 Q 0
 ;
 ;***** COMPILES THE "COMBINED PHARMACY AND LAB" REPORT
 ; REPORT CODE: 012
 ;
 ; .RORTSK       Task number and task parameters
 ;
 ; The ^TMP("RORX012",$J) global node is used by this function.
 ;
 ; ^TMP("RORX012",$J,
 ;   "PAT",
 ;     DFN,              Patient descriptor
 ;                         ^01: Last 4 digits of SSN
 ;                         ^02: Patient name
 ;                         ^03: Date of Death
 ;                         ^04: ICN
 ;       "LR",
 ;         Date,
 ;           TestName,
 ;             TestIEN)  Result
 ;       "RX",
 ;         DrugName,
 ;           DrugIEN)    ""
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
RXANDLAB(RORTSK) ;
 N RORLAB        ; Labs mode (-1|0|1)
 N RORLTST       ; Closed root of the list of lab tests for the
 ;               ; Lab search API
 N RORLTRV       ; Closed root of the list of lab tests with ranges
 N RORPHARM      ; Meds mode (-1|0|1)
 N RORREG        ; Registry IEN
 N RORXEDT       ; Pharmacy end date
 N RORXGRP       ; List of drug groups
 N RORXL         ; Closed root of the drug list for the pharmacy
 ;               ; search API or "*" if all drugs were selected
 N RORXSDT       ; Pharmacy start date
 ;
 N ECNT,NSPT,RC,REPORT,SFLAGS,TMP
 N RORDEL        ; Flag to determine if Most Recent is set
 N RORDELTSK     ; Task number passed to delete tests
 S RORDEL=$G(RORTSK("PARAMS","LABTESTS","A","MOST_RECENT"))
 S RORDELTSK=RORTSK
 S (RORXL,RORLTST)="",(ECNT,RC)=0
 K ^TMP("RORX012",$J)
 ;--- Root node of the report
 S REPORT=$$ADDVAL^RORTSK11(RORTSK,"REPORT")
 Q:REPORT<0 REPORT
 ;
 D
 . ;--- Get and prepare the report parameters
 . S RORREG=$$PARAM^RORTSK01("REGIEN")  ; Registry IEN
 . S RORLAB=$$RPTMODE("LAB")            ; Labs logic
 . S RORPHARM=$$RPTMODE("PHARM")        ; Meds logic
 . S RC=$$PARAMS(REPORT,.RORXSDT,.RORXEDT,.SFLAGS)  Q:RC<0
 . ;--- Report header
 . S RC=$$HEADER(REPORT)  Q:RC<0
 . ;--- Query the registry
 . D TPPSETUP^RORTSK01(80)
 . S RC=$$QUERY^RORX012A(SFLAGS,.NSPT)
 . I RC  Q:RC<0  S ECNT=ECNT+RC
 . ;--- Store the results
 . D TPPSETUP^RORTSK01(20)
 . S RC=$$STORE^RORX012A(REPORT,NSPT)
 . I RC  Q:RC<0  S ECNT=ECNT+RC
 ;
 ;--- Cleanup
 ;--- Modify the report if only the latest test is required
 ;    Inputs are Task number for File 798.8 and the flag
 I RORDEL=1 D DEL^RORXU009(RORDELTSK)
 K ^TMP("RORX012",$J)
 D FREE^RORTMP(RORXL),FREE^RORTMP(RORLTST)
 ;
 Q $S(RC<0:RC,ECNT>0:-43,1:0)
