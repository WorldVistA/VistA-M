RORX005 ;HCIOFO/BH,SG - INPATIENT UTILIZATION ;10/14/05 1:53pm
 ;;1.5;CLINICAL CASE REGISTRIES;**21,31**;Feb 17, 2006;Build 62
 ;
 ;******************************************************************************
 ;                       --- ROUTINE MODIFICATION LOG ---
 ;        
 ;PKG/PATCH    DATE        DEVELOPER    MODIFICATION
 ;-----------  ----------  -----------  ----------------------------------------
 ;ROR*1.5*21   SEP 2013    T KOPP       Add ICN column if Additional Identifier
 ;                                       requested.
 ;ROR*1.5*31   MAY 2017    M FERRARESE  Adding PACT, PCP, and AGE/DOB as additional
 ;                                      identifiers.  
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
 ;;HU_DAYS(#,NAME,LAST4,AGE,NST,ND,NSS,ICN,PACT,PCP)^I $$PARAM^RORTSK01("AGE_RANGE","TYPE")="AGE"
 ;;HU_DAYS(#,NAME,LAST4,DOB,NST,ND,NSS,ICN,PACT,PCP)^I $$PARAM^RORTSK01("AGE_RANGE","TYPE")="DOB"
 ;;HU_DAYS(#,NAME,LAST4,NST,ND,NSS,ICN,PACT,PCP)^I $$PARAM^RORTSK01("AGE_RANGE","TYPE")="ALL"
 ;;HU_STAYS(#,NAME,LAST4,AGE,NST,ND,NSS,ICN,PACT,PCP)^I $$PARAM^RORTSK01("AGE_RANGE","TYPE")="AGE"
 ;;HU_STAYS(#,NAME,LAST4,DOB,NST,ND,NSS,ICN,PACT,PCP)^I $$PARAM^RORTSK01("AGE_RANGE","TYPE")="DOB"
 ;;HU_STAYS(#,NAME,LAST4,NST,ND,NSS,ICN,PACT,PCP)^I $$PARAM^RORTSK01("AGE_RANGE","TYPE")="ALL"
 ;;BEDSECTIONS(#,NAME,NP,NST,ND,MLOS,NSS)
 ;;NOBS(#,NAME,LAST4,AGE,DATE,PTF,ICN,PACT,PCP)^I $$PARAM^RORTSK01("AGE_RANGE","TYPE")="AGE"
 ;;NOBS(#,NAME,LAST4,DOB,DATE,PTF,ICN,PACT,PCP)^I $$PARAM^RORTSK01("AGE_RANGE","TYPE")="DOB"
 ;;NOBS(#,NAME,LAST4,DATE,PTF,ICN,PACT,PCP)^I $$PARAM^RORTSK01("AGE_RANGE","TYPE")="ALL"
 ;;STAYS(NP,NST)
 ;
 N HEADER,RC
 S HEADER=$$HEADER^RORXU002(.RORTSK,PARTAG)
 Q:HEADER<0 HEADER
 S RC=$$TBLDEF^RORXU002("HEADER^RORX005",HEADER)
 Q $S(RC<0:RC,1:HEADER)
 ;
 ;
 ;***** COMPILES THE "INPATIENT UTILIZATION" REPORT
 ; REPORT CODE: 005
 ;
 ; .RORTSK       Task number and task parameters
 ;
 ; The ^TMP("RORX005",$J) global node is used by this function.
 ;
 ; ^TMP("RORX005",$J,
 ;
 ;   "IP",             Number of inpatients
 ;     DFN,            Last 4 digits of SSN^National ICN^Patient care team PACT^Primary Care provider PCP^Age/DOB
 ;       "D")          Number of days
 ;       "S")          Number of overnight stays
 ;       "V")          Number of short stays
 ;
 ;   "IPB",
 ;#    BedSectID,
 ;       "D")          Number of days
 ;       "P",          Number of patients
 ;         DFN)
 ;       "S")          Number of overnight stays
 ;       "V")          Number of short stays
 ;     "B",
 ;       BedSectName,
 ;%        BedSectID)
 ;
 ;   "IPD",            Total number of days
 ;     NumOfDays,      Number of patients
 ;       PatientName,
 ;         DFN)
 ;
 ;   "IPMLOS",         Median Length Of Stay
 ;*    BedSectID,      Median Length Of Stay
 ;       NumOfDays,
 ;         Seq#)
 ;
 ;   "IPNOBS",
 ;      PatientName,
 ;        Date,
 ;          PTF#,
 ;            DFN)
 ;
 ;   "IPS",            Total number of stays
 ;     NumOfStays,     Number of patients
 ;       PatientName,
 ;         DFN)
 ;
 ;   "IPV")            Total number of short stays
 ;
 ; Bed section IDs (BedSectID):
 ;   -1  No bed section               [#%*]
 ;    0  Whole patient's stays        [  *]
 ;   >0  Bed section ID (IEN;File#)   [# *]
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
IPUTL(RORTSK) ;
 N ROREDT        ; End date
 N RORREG        ; Registry IEN
 N RORSDT        ; Start date
 ;
 N ECNT,RC,REPORT,SFLAGS,TMP
 S (ECNT,RC)=0
 K ^TMP("RORX005",$J)
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
 . S RC=$$QUERY^RORX005A(SFLAGS)
 . I RC  Q:RC<0  S ECNT=ECNT+RC
 . ;--- Sort the data
 . D TPPSETUP^RORTSK01(15)
 . S RC=$$SORT^RORX005B()
 . I RC  Q:RC<0  S ECNT=ECNT+RC
 . ;--- Store the results
 . D TPPSETUP^RORTSK01(15)
 . S RC=$$STORE^RORX005C(REPORT)
 . I RC  Q:RC<0  S ECNT=ECNT+RC
 ;
 ;--- Cleanup
 K ^TMP("RORX005",$J)
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
 N NAME,PARAMS,TMP
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
