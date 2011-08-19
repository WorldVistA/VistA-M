RORX016 ;HCIOFO/BH,SG - OUTPATIENT UTILIZATION ; 10/14/05 2:06pm
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
 ;;CLINICS(#,STOP,NAME,NP,NV,NSC)
 ;;HU_STOPS(#,NAME,LAST4,NV,NSC,NDS)
 ;;STOPS(NP,NSC)
 ;
 N HEADER,RC
 S HEADER=$$HEADER^RORXU002(.RORTSK,PARTAG)
 Q:HEADER<0 HEADER
 S RC=$$TBLDEF^RORXU002("HEADER^RORX016",HEADER)
 Q $S(RC<0:RC,1:HEADER)
 ;
 ;
 ;***** COMPILES THE "OUTPATIENT UTILIZATION" REPORT
 ; REPORT CODE: 016
 ;
 ; .RORTSK       Task number and task parameters
 ;
 ; The ^TMP("RORX016",$J) global node is used by this function.
 ;
 ; ^TMP("RORX016",$J,
 ;
 ;     "OP",             Number of outpatients
 ;       DFN,            Patient's data
 ;                         ^01: Number of stops
 ;                         ^02: Number of different stops
 ;                         ^03: Last 4 digits of SSN
 ;                         ^04: Number of visits
 ;                       Children of this node are KILL'ed by
 ;                       the $$TOTALS^RORX016B function.
 ;         Date,         Number of stops associated with the visit
 ;           StopCode)   Quantity
 ;
 ;     "OPS",            Totals
 ;                         ^01: Total number of stops
 ;                         ^02: Number of different stops
 ;       StopCode,       Name of the Clinic Stop Code
 ;         "P")          Number of patients
 ;         "S")          Quantity
 ;         "V")          Number of visits
 ;
 ;     "OPS1",
 ;       NumOfStops,     Number of patients
 ;         PatientName,
 ;           DFN)
 ;
 ;     "OPV")            Total number of visits
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
OPUTL(RORTSK) ;
 N RORDIV        ; List of division IEN's
 N ROREDT        ; End date
 N RORREG        ; Registry IEN
 N RORSDT        ; Start date
 ;
 N ECNT,RC,REPORT,SFLAGS,TMP
 S (ECNT,RC)=0  K ^TMP("RORX016",$J)
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
 ;
 D
 . ;--- Query the registry
 . D TPPSETUP^RORTSK01(70)
 . S RC=$$QUERY^RORX016A(SFLAGS)
 . I RC  Q:RC<0  S ECNT=ECNT+RC
 . ;--- Sort the data
 . D TPPSETUP^RORTSK01(15)
 . S RC=$$SORT^RORX016B()
 . I RC  Q:RC<0  S ECNT=ECNT+RC
 . ;--- Store the results
 . D TPPSETUP^RORTSK01(15)
 . S RC=$$STORE^RORX016C(REPORT)
 . I RC  Q:RC<0  S ECNT=ECNT+RC
 ;
 ;--- Cleanup
 K ^TMP("RORX016",$J)
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
 ;--- Process the list of divisions
 S TMP=$$DIVLST^RORXU006(.RORTSK,PARAMS)
 Q:TMP<0 TMP
 ;--- Additional parameters
 F NAME="MAXUTNUM"  D
 . S TMP=$$PARAM^RORTSK01(NAME)
 . D:TMP'="" ADDVAL^RORTSK11(RORTSK,NAME,TMP,PARAMS)
 ;---
 Q PARAMS
