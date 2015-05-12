RORX022 ;BPOIFO/CLR - LAB DAA MONITOR REPORT ;4/9/09 9:40am
 ;;1.5;CLINICAL CASE REGISTRIES;**17,21**;Feb 17, 2006;Build 45
 ;
 ;******************************************************************************
 ;******************************************************************************
 ;                       --- ROUTINE MODIFICATION LOG ---
 ;        
 ;PKG/PATCH    DATE        DEVELOPER    MODIFICATION
 ;-----------  ----------  -----------  ----------------------------------------
 ;ROR*1.5*21   SEP 2013    T KOPP       Add ICN column if Additional Identifier
 ;                                       requested.
 ;******************************************************************************
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
 ;;DRUGS(#,NAME,LAST4,DAA_FILL,FILL_DATE,RXNAME,DAYSPLY)
 ;;LABTESTS(#,NAME,LAST4,DAA_FILL,DATE,LTNAME,RESULT,WKS_LAB)
 ;;PATIENTS(#,NAME,LAST4,ICN)
 ;
 N HEADER,RC
 S HEADER=$$HEADER^RORXU002(.RORTSK,PARTAG)
 Q:HEADER<0 HEADER
 S RC=$$TBLDEF^RORXU002("HEADER^RORX022",HEADER)
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
 N PARAMS,TMP,ELEMENT
 S PARAMS=$$PARAMS^RORXU002(.RORTSK,PARTAG,.STDT,.ENDT,.FLAGS)
 Q:PARAMS<0 PARAMS
 ;report specific parameters
 S ELEMENT=$$ADDVAL^RORTSK11(RORTSK,"WEEKS_AFTER",$$PARAM^RORTSK01("WEEKS_AFTER"),PARAMS)
 Q:ELEMENT<0 ELEMENT
 I $$PARAM^RORTSK01("WEEKS_AFTER","MOST_RECENT") D
 . D ADDATTR^RORTSK11(RORTSK,ELEMENT,"MOST_RECENT",$$PARAM^RORTSK01("WEEKS_AFTER","MOST_RECENT"))
 ;--- Process the list of Lab tests
 D  Q:TMP<0 TMP
 . S TMP=$$LTLST^RORXU006(.RORTSK,PARAMS,.RORLTST,"RORLTRV")
 Q PARAMS
 ;
 ;
 ;***** COMPILES THE "DAA LAB MONITOR" REPORT
 ; REPORT CODE: 022
 ;
 ;INPUT
 ;  .RORTSK     Task number and task parameters
 ;
 ;  Below is a sample RORTSK input array for utilization in 2003, most recent
 ;  scores, BMI range from 30 to 45:
 ;
 ;  RORTSK=nnn   (task number)
 ;  RORTSK("EP")="$$DAAMON^RORX022"
 ;  RORTSK("PARAMS","DATE_RANGE_3","A","END")=3031231
 ;  RORTSK("PARAMS","DATE_RANGE_3","A","START")=3030101
 ;  RORTSK("PARAMS","ICD9FILT","A","FILTER")="ALL"
 ;  RORTSK("PARAMS","LRGRANGES","C",1)=""
 ;  RORTSK("PARAMS","LRGRANGES","C",1,"H")=45
 ;  RORTSK("PARAMS","LRGRANGES","C",1,"L")=30
 ;  RORTSK("PARAMS","OPTIONS","A","COMPLETE")=1
 ;  RORTSK("PARAMS","OPTIONS","A","MOST_RECENT")=1
 ;  RORTSK("PARAMS","PATIENTS","A","DE_AFTER")=1
 ;  RORTSK("PARAMS","PATIENTS","A","DE_BEFORE")=1
 ;  RORTSK("PARAMS","PATIENTS","A","DE_DURING")=1
 ;  RORTSK("PARAMS","REGIEN")=1
 ;
 ;  If the user selected an 'as of' date = 12/31/2005:
 ;     RORTSK("PARAMS","OPTIONS","A","MOST_RECENT")=1
 ;  is replaced with:  
 ;     RORTSK("PARAMS","OPTIONS","A","MAX_DATE")=3051231
 ;
 ;
 ; The ^TMP("RORX022",$J) global node is used by this function.
 ;
 ; ^TMP("RORX022",$J,
 ;   "PAT",
 ;     DFN,              Patient descriptor
 ;                         ^01: Last 4 digits of SSN
 ;                         ^02: Patient name
 ;                         ^03: Date of 1st DAA fill
 ;                         ^04: National ICN
 ;       "LR",
 ;         TestName,
 ;          TestIEN
 ;            Inv Date)  Result
 ;                         ^01:  Test result
 ;                         ^02:  # wks since 1st DAA fill
 ;       "RX",
 ;         Inv Date,
 ;           DrugName,
 ;             DrugIEN,
 ;               RX#,
 ;                 Index)Days Supply
 ;                         ^05:Days Supply           
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
DAAMON(RORTSK) ;
 N RORLTST       ; Closed root of the list of lab tests for the
 ;               ; Lab search API
 N RORLTRV       ; Closed root of the list of lab tests with ranges
 N RORREG        ; Registry IEN
 N RORXEDT       ; Pharmacy end date
 N RORXL         ; Closed root of the drug list for the pharmacy
 ;               ; search API or "*" if all drugs were selected
 N RORXSDT       ; Pharmacy start date
 N LTMREC        ; Baseline result request
 ;
 N ECNT,NSPT,RC,REPORT,SFLAGS,TMP
 S (RORXL,RORLTST)="",(ECNT,RC)=0
 K ^TMP("RORX022",$J)
 ;--- Root node of the report
 S REPORT=$$ADDVAL^RORTSK11(RORTSK,"REPORT")
 Q:REPORT<0 REPORT
 ;
 D
 . ;--- Get and prepare the report parameters
 . S RORREG=$$PARAM^RORTSK01("REGIEN")  ; Registry IEN
 . S RC=$$PARAMS(REPORT,.RORXSDT,.RORXEDT,.SFLAGS)  Q:RC<0
 . ;--- Report header
 . S RC=$$HEADER(REPORT)  Q:RC<0
 . ;--- Query the registry
 . D TPPSETUP^RORTSK01(80)
 . S RC=$$QUERY^RORX022A(SFLAGS,.RORTSK,.NSPT)
 . I RC  Q:RC<0  S ECNT=ECNT+RC
 . ;--- Store the results
 . D TPPSETUP^RORTSK01(20)
 . S RC=$$STORE^RORX022A(REPORT,.RORTSK,NSPT)
 . I RC  Q:RC<0  S ECNT=ECNT+RC
 ;
 K ^TMP("RORX022",$J)
 D FREE^RORTMP(RORLTST)
 ;
 Q $S(RC<0:RC,ECNT>0:-43,1:0)
