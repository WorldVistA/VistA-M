RORX025 ;ALB/TK,MAF - HEP B VACCINE OR IMMUNITY REPORT ;4/21/16 9:40am
 ;;1.5;CLINICAL CASE REGISTRIES;**29,31**;Feb 17, 2006;Build 62
 ;
 ;******************************************************************************
 ;******************************************************************************
 ;                       --- ROUTINE MODIFICATION LOG ---
 ;        
 ;PKG/PATCH    DATE        DEVELOPER    MODIFICATION
 ;-----------  ----------  -----------  ----------------------------------------
 ;ROR*1.5*29   APR 2016    T KOPP       Added 'Hep B vaccine or immunity report'
 ;ROR*1.5*31   MAY 2017    M FERRARESE  Adding PACT, PCP, and AGE/DOB as additional
 ;                                      identifiers.
 ;******************************************************************************
 ;******************************************************************************
 ;
 ;***** COMPILES THE "HEP B VACCINE OR IMMUNITY" REPORT
 ; REPORT CODE: 025
 ;
 ; .RORTSK       Task number and task parameters
 ;
 ; The ^TMP("RORX025",$J) global node is used by this function.
 ;
 ; ^TMP("RORX025",$J,
 ;   "PAT",
 ;     DFN,              Patient descriptor
 ;                         ^01: Last 4 digits of SSN
 ;                         ^02: Patient name
 ;                         ^03: Date of Death
 ;                         ^04: ICN
 ;                         ^05: Patient Care Team
 ;                         ^06: Priamary Care Provider
 ;                         ^07: Age/DOB
 ;       "IMM")          Result if positive test found or "" if no positive test found
 ;                         ^01: Local lab test name
 ;                         ^02: Collected date (FM)
 ;                         ^03: Lab test result
 ;       "VAC",           Number of results
 ;                         ^01: #
 ;           VaccineName, 
 ;             VaccineDate) Always null if node exists
 ;                         ^01: Null
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
HEPBRPT(RORTSK) ;
 N RORIMM        ; Immunity wanted mode (-1|0|1)  no|not selected|yes  (verified by lab test)
 N RORVAC        ; Vaccination (-1|0|1)  not received|not selected|received  (verified by immunization record)
 N RORREG        ; Registry IEN
 N RORVEDT       ; Vaccination end date
 N RORVSDT       ; Vaccination start date
 N RORLEDT       ; Lab test/LOINC end date
 N RORLSDT       ; Lab test/LOINC start date
 N RORRTN        ; Routine to invoke for hep B processing
 ;
 N NSPT,RC,REPORT,SFLAGS,TMP
 S RC=0,RORRTN="RORX025"
 K ^TMP(RORRTN,$J)
 ;--- Root node of the report
 S REPORT=$$ADDVAL^RORTSK11(RORTSK,"REPORT")
 Q:REPORT<0 REPORT
 ;
 D
 . ;--- Get and prepare the report parameters
 . S RORREG=$$PARAM^RORTSK01("REGIEN")  ; Registry IEN
 . S RORVAC=$$RPTMODE^RORX024("HEPBVAC")        ; Vaccination option chosen
 . S RORIMM=$$RPTMODE^RORX024("HEPBIMM")        ; Immunity option chosen
 . S RC=$$PARAMS(REPORT,.RORVSDT,.RORVEDT,.SFLAGS)  Q:RC<0
 . ;--- Report header
 . S RC=$$HEADER(REPORT)  Q:RC<0
 . ;--- Query the registry
 . D TPPSETUP^RORTSK01(80)
 . S RC=$$QUERY^RORX024A(SFLAGS,.NSPT,RORRTN)
 . I RC Q:RC<0
 . ;--- Store the results
 . D TPPSETUP^RORTSK01(20)
 . S RC=$$STORE^RORX024A(REPORT,NSPT,RORRTN)
 . I RC Q:RC<0
 ;
 ;--- Cleanup
 K ^TMP(RORRTN,$J)
 Q $S(RC<0:RC,1:0)
 ;
 ;
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
 ;;PATIENTS(#,NAME,LAST4,DOD,VAC_NAME,VAC_DATE,LTNAME,DATE,RESULT,ICN,PACT,PCP)^I $$PARAM^RORTSK01("AGE_RANGE","TYPE")="ALL"
 ;;PATIENTS(#,NAME,LAST4,AGE,DOD,VAC_NAME,VAC_DATE,LTNAME,DATE,RESULT,ICN,PACT,PCP)^I $$PARAM^RORTSK01("AGE_RANGE","TYPE")="AGE"
 ;;PATIENTS(#,NAME,LAST4,DOB,DOD,VAC_NAME,VAC_DATE,LTNAME,DATE,RESULT,ICN,PACT,PCP)^I $$PARAM^RORTSK01("AGE_RANGE","TYPE")="DOB"
 ;
 N HEADER,LN,RC,CTAG,LTAG
 S HEADER=$$HEADER^RORXU002(.RORTSK,PARTAG)
 Q:HEADER<0 HEADER
 ;--- LOINC codes output
 I $G(RORIMM) D
 . S LTAG=$$ADDVAL^RORTSK11(RORTSK,"LOINC_CODES",,PARTAG)
 . S LN=0 F  S LN=$O(^TMP("RORX025",$J,"IMM","TYPE",LN)) Q:'LN  D
 . . S CTAG=$$ADDVAL^RORTSK11(RORTSK,"CODE",,LTAG)
 . . D ADDATTR^RORTSK11(RORTSK,CTAG,"CODE",^TMP("RORX025",$J,"IMM","TYPE",LN))
 S RC=$$TBLDEF^RORXU002("HEADER^RORX025",HEADER)
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
 S PARAMS=$$PARAMS^RORXU002(.RORTSK,PARTAG,,,.FLAGS)
 Q:PARAMS<0 PARAMS
 ;--- Process the list of Lab tests/LOINC codes
 I $G(RORIMM) D
 . D GETIMM^RORX024("RORX025") ;extract the immunity criteria for HEP B
 ;--- Process the list of vaccinations
 I $G(RORVAC) D
 . D GETVAC^RORX024("RORX025") ;extract the vaccine criteria for HEP B
 ;---
 Q PARAMS
 ;
 ; --  LOINC codes to check for HEP B immunity
IMMUNITY ; LOINC codes indicating HEP B immunity results by type Line +1 = Surface AB (priority), Line +2 = Core AB
 ;;Surface AB^22322-2^10900-9^16935-9^5193-8^5194-6^22323-0^32019-2
 ;;Core AB^32685-0^22318-0^13919-6^16933-4^13952-7^22316-4^5187-0^5188-8^22317-2^21005-4
 ;;
 Q
 ;
 ; -- List of Hep B vaccines to include
VACCINE ;  Hepatitis B vaccine names (% = wild card)
 ;;%ENGERIX-B%^%HEP B%^%HEPATITIS B%^HEPATITIS-B%^HEPB%^HEP A&B^HEPA/HEPB%^%HEP A/B%^HEPAB%^HEPATITIS A & B%^HEPATITIS A&B%
 ;;HEPATITIS A/B^HEPATITIS AB^TWINRIX%
 ;;
 Q
 ;
