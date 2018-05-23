RORX024 ;ALB/TK,MAF - HEP A VACCINE OR IMMUNITY REPORT ; 27 Jul 2016  3:03 PM
 ;;1.5;CLINICAL CASE REGISTRIES;**29,31,32**;Feb 17, 2006;Build 20
 ;
 ;******************************************************************************
 ; This routine uses the following IAs:
 ;
 ; #10103 HL7TFM^XLFDT
 ;
 ;******************************************************************************
 ;******************************************************************************
 ;                       --- ROUTINE MODIFICATION LOG ---
 ;        
 ;PKG/PATCH    DATE        DEVELOPER    MODIFICATION
 ;-----------  ----------  -----------  ---------------------------------------
 ;ROR*1.5*29   APR 2016    T KOPP       Added 'Hep A vaccine or immunity report'
 ;ROR*1.5*31   MAY 2017    M FERRARESE  Adding PACT, PCP, and AGE/DOB as additional
 ;                                      identifiers.
 ;ROR*1.5*32   11/01/17    S ALSAHHAR   Print the most recent Immunity result
 ;******************************************************************************
 ;******************************************************************************
 ;
 Q
 ;
 ;***** COMPILES THE "HEP A VACCINE OR IMMUNITY" REPORT
 ; REPORT CODE: 024
 ;
 ; .RORTSK       Task number and task parameters
 ;
 ; The ^TMP("RORX024",$J) global node is used by this function.
 ;
 ; ^TMP("RORX024",$J,
 ;   "PAT",
 ;     DFN,              Patient descriptor
 ;                         ^01: Last 4 digits of SSN
 ;                         ^02: Patient name
 ;                         ^03: Date of Death
 ;                         ^04: ICN
 ;                         ^05: Patient Care Team
 ;                         ^06: Primary Care Provider
 ;                         ^07: Age/DOB
 ;       "IMM")          Result if positive test found or "" if no positive test found
 ;                         ^01: Local lab test name
 ;                         ^02: Collected date (FM)
 ;                         ^03: Lab test result
 ;
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
HEPARPT(RORTSK) ;
 N RORIMM        ; Immunity wanted mode (-1|0|1)  no|not selected|yes  (verified by lab test)
 N RORVAC        ; Vaccination (-1|0|1)  not received|not selected|received  (verified by immunization record)
 N RORREG        ; Registry IEN
 N RORVEDT       ; Vaccination end date
 N RORVSDT       ; Vaccination start date
 N RORLEDT       ; Lab test/LOINC end date
 N RORLSDT       ; Lab test/LOINC start date
 N RORRTN        ; Routine to invoke for hep A processing
 ;
 N NSPT,RC,REPORT,SFLAGS,TMP
 S RC=0,RORRTN="RORX024"
 K ^TMP(RORRTN,$J)
 ;--- Root node of the report
 S REPORT=$$ADDVAL^RORTSK11(RORTSK,"REPORT")
 Q:REPORT<0 REPORT
 ;
 D
 . ;--- Get and prepare the report parameters
 . S RORREG=$$PARAM^RORTSK01("REGIEN")  ; Registry IEN
 . S RORVAC=$$RPTMODE("HEPAVAC")        ; Vaccination option chosen
 . S RORIMM=$$RPTMODE("HEPAIMM")        ; Immunity option chosen
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
 ;;PATIENTS(#,NAME,LAST4,AGE,DOD,VAC_NAME,VAC_DATE,LTNAME,DATE,RESULT,ICN,PACT,PCP)^I $$PARAM^RORTSK01("AGE_RANGE","TYPE")="AGE"
 ;;PATIENTS(#,NAME,LAST4,DOB,DOD,VAC_NAME,VAC_DATE,LTNAME,DATE,RESULT,ICN,PACT,PCP)^I $$PARAM^RORTSK01("AGE_RANGE","TYPE")="DOB"
 ;;PATIENTS(#,NAME,LAST4,DOD,VAC_NAME,VAC_DATE,LTNAME,DATE,RESULT,ICN,PACT,PCP)^I $$PARAM^RORTSK01("AGE_RANGE","TYPE")="ALL"
 ;
 N HEADER,LN,RC,CTAG,LTAG
 S HEADER=$$HEADER^RORXU002(.RORTSK,PARTAG)
 Q:HEADER<0 HEADER
 ;--- LOINC codes output
 I $G(RORIMM) D
 . S LTAG=$$ADDVAL^RORTSK11(RORTSK,"LOINC_CODES",,PARTAG)
 . S LN=0 F  S LN=$O(^TMP("RORX024",$J,"IMM","TYPE",LN)) Q:'LN  D
 . . S CTAG=$$ADDVAL^RORTSK11(RORTSK,"CODE",,LTAG)
 . . D ADDATTR^RORTSK11(RORTSK,CTAG,"CODE",^TMP("RORX024",$J,"IMM","TYPE",LN))
 S RC=$$TBLDEF^RORXU002("HEADER^RORX024",HEADER)
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
 . D GETIMM("RORX024") ;extract the immunity criteria for HEP A
 ;--- Process the list of vaccinations
 I $G(RORVAC) D
 . D GETVAC("RORX024") ;extract the vaccine criteria for HEP A
 ;---
 Q PARAMS
 ;
 ;
 ; -- Extract immunity (lab) data for a patient
 ;
 ; PATIEN        IEN of the patient (DFN)
 ;
 ; RORLOINC      Closed root of a variable, which contains a list
 ;               of LOINC codes for HEP A or HEPB in the format
 ;                          @RORLOINC@("VALID",i,
 ;                                          ^01: LOINC code
 ;                                   @("PRIORITY",LOINC code,priority)=""
 ;
 ;                      HEPA priority [0 for Ab Total or 1 for IgG]
 ;                      HEPB priority [0 for Surface AB or 1 for Core AB]
 ;
 ; RORLRES  Closed root of an array where the data will be
 ;               returned.
 ;               The data will be stored into the destination
 ;               array in following format:
 ;
 ;                    @RORLRES
 ;                                 ^01: Local lab test name
 ;                                 ^02: Collected date (FM)
 ;                                 ^03: Lab test result
 ;                             
 ;  LTSDT        Lab test start date (FileMan)
 ;  LTEDT        Lab test end date   (FileMan)
 ;
 ;  The function should return the following values:
 ;
 ;        <0 Error code (the search will be aborted)
 ;         0 No immunity found
 ;         1 At least 1 immunity found
 ;
LAB(PATIEN,RORLOINC,RORLRES,LTSDT,LTEDT) ;
 N RC1,DFN,RORID,RORENDT,RORSTDT,ROR1,RESDT,RESULT,RORLRC,RORLAB,RORMSG,Z,Z0
 ;
 S DFN=PATIEN
 ;
 ; Search for specific LOINC codes and positive results
 S RORLAB=$NA(^TMP("ROROUT",$J)) ;lab API output global
 K RORMSG,@RORLAB ;initialize prior to call
 ;---CALL LAB API---
 M RORLRC=@RORLOINC@("VALID")
 S RORLRC="CH,MI",RORLRES="",RORID=$$PTID^RORUTL02(DFN)
 S RC1=$$GCPR^LA7QRY(RORID,LTSDT,LTEDT,.RORLRC,"*",.RORMSG,RORLAB)
 I RC1<0 Q -1
 Q:$D(@RORLAB)<10 0
 ;Note: the Lab API returns data in the form of HL7 segments
 N FS,TMP,LOINC,RESULT,RORLTN,RORVAL,RORNODE,RORSEG,SEGTYPE,RORDATE,RORX,RORX1
 S FS="|" ;HL7 field separator for lab data
 S (RORNODE,RESULT)=0
 F  S RORNODE=$O(^TMP("ROROUT",$J,RORNODE)) Q:RORNODE=""  D
 . S RORSEG=$G(^TMP("ROROUT",$J,RORNODE)) ;get entire HL7 segment
 . S SEGTYPE=$P(RORSEG,FS,1) ;get segment type (PID,OBR,OBX,etc.)
 . Q:SEGTYPE'="OBX"  ;we want OBX segments only
 . S LOINC=$P($P(RORSEG,FS,4),U,1) ;get LOINC code for test
 . Q:$S(LOINC="":1,1:'$D(@RORLOINC@("PRIORITY",LOINC)))  ; Call to lab does not filter out unwanted LOINCs
 . S RORLTN=$P($P($P(RORSEG,FS,4),U,9),FS) ;local test name
 . S RORVAL=$P(RORSEG,FS,6) ;test result value
 . S RORVAL=$TR(RORVAL,"""","") ;get rid of double quotes around values
 . Q:RORVAL=""  ;quit if no value
 . ;Check if value meets the positive result criteria selected for immunity
 . Q:'$$POS^RORX024A(RORVAL)
 . S RORDATE=$$HL7TFM^XLFDT($E($P(RORSEG,FS,15),1,8)) ;get date collected
 . ;S RORDATE=RORDATE\1
 . ;Output the record into RORX by priority, date, LOINC Code if positive result
 . S RORX(+$O(@RORLOINC@("PRIORITY",LOINC,0)),(9999999-RORDATE),LOINC)=RORVAL_U_RORLTN
 ; Find the result as the earliest date in priority 0 tests and if none, earliest in priority 1
 F Z=1,2 S Z0=$O(RORX(Z,0)) I Z0 D  Q:RESULT
 . S RORX1=$O(RORX(Z,Z0,0))
 . Q:RORX1=""
 . S RESULT=1,RORLRES=$P(RORX(Z,Z0,RORX1),U,2)_U_(9999999-Z0)_U_$P(RORX(Z,Z0,RORX1),U)
 K @RORLAB
 Q RESULT
 ;
 ;***** DETERMINES THE REPORT MODE FOR IMMUNITY OR VACCINATION
 ;
 ; NAME          Base name of the attribute ("HEPAIMM" or "HEPAVAC")
 ;                                    OR    ("HEPBIMM" or "HEPBVAC")
 ; Return Values:
 ;       <0  "No"
 ;        0  Not selected
 ;       >0  "Yes"
 ;
RPTMODE(NAME) ;
 Q:$$PARAM^RORTSK01("PATIENTS",NAME) 1        ; "Yes"
 Q:$$PARAM^RORTSK01("PATIENTS","NO"_NAME) -1  ; "No"
 Q 0
 ;
 ; ******* EXTRACT LOINC CODES FOR IMMUNITY ********
 ; RORRTN = the name of the report routine where the IMMUNITY data should be extracted from
 ;
 ; Returns ^TMP(RORRTN,$J,"IMM","VALID",n)=LOINC code^LN     and
 ;         ^TMP(RORRTN,$J,"IMM","PRIORITY",LOINC code,[0 for Total Ab or 1 for IgG])=""
 ;         ^TMP(RORRTN,$J,"IMM","TYPE",n)=Type of LOINC: list of LOINC codes for type    (used for header output)
 ;         
 ;
GETIMM(RORRTN) ;
 N RORDATA,RORI,RORI1,COM,CT,Z
 K ^TMP(RORRTN,$J,"IMM")
 ;
 I $E(RORRTN)=U S RORRTN=$P(RORRTN,U,2)
 S CT=0
 F RORI=1:1 S RORDATA=$P($T(@("IMMUNITY+"_RORI_U_RORRTN)),";;",2) Q:RORDATA=""  D
 . S ^TMP(RORRTN,$J,"IMM","TYPE",RORI)=$P(RORDATA,U)_": ",COM=0
 . F RORI1=2:1 S Z=$P(RORDATA,U,RORI1) Q:Z=""  D
 . . S CT=CT+1,^TMP(RORRTN,$J,"IMM","VALID",CT)=Z_"^LN"
 . . S ^TMP(RORRTN,$J,"IMM","PRIORITY",Z,RORI)=""
 . . S ^TMP(RORRTN,$J,"IMM","TYPE",RORI)=^TMP(RORRTN,$J,"IMM","TYPE",RORI)_$S('COM:"",1:";")_Z,COM=1
 ;
 Q
 ;
 ; --  LOINC codes to check for HEP A immunity
IMMUNITY ; List of LOINC codes indicating HEP A immunity results by type Line +1 = Total AB (priority), Line +2 = IgG
 ;;Hepatitis A Ab Total^20575-7^13951-9^22312-3^5183-9^5184-7
 ;;Hepatitis A IgG^32018-4^22313-1^5179-7
 ;;
 Q
 ; ******* EXTRACT VACCINE NAMES ********
 ; RORRTN = the name of the report routine where the IMMUNITY data should be extracted from
 ;
 ; Returns ^TMP(RORRTN,$J,"VAC",seq #)=pattern to match
 ;
GETVAC(RORRTN) ;  Extract pertinent vaccine names to match
 N CT,CHAR,QUOTE,POS,RORDATA,RORI,RORI1,RESULT,VACNM,Z
 ;
 I $E(RORRTN="^") S RORRTN=$P(RORRTN,U,2)
 S CT=0
 F RORI=1:1 S RORDATA=$P($T(@("VACCINE+"_RORI_U_RORRTN)),";;",2) Q:RORDATA=""  D
 . F RORI1=1:1 S VACNM=$P(RORDATA,U,RORI1) Q:VACNM=""  D
 .. S RESULT=""
 .. ; determine pattern
 .. S QUOTE=0
 .. F POS=1:1:$L(VACNM) S CHAR=$E(VACNM,POS) D
 ... I POS=1,CHAR="%" S RESULT=".E" Q
 ... I CHAR'="%" S RESULT=RESULT_$S('QUOTE:"1""",1:"")_CHAR,QUOTE=1 Q
 ... I CHAR="%" D
 .... I QUOTE S RESULT=RESULT_""""
 .... S RESULT=RESULT_".E",QUOTE=0
 .. I RESULT'="",QUOTE S RESULT=RESULT_""""
 .. S CT=CT+1,^TMP(RORRTN,$J,"VAC",CT)=RESULT
 ;
 Q
 ;
 ; -- List of vaccines to include
 ;  Business owner also requested (HEPATITIS A&B%, HEPATITIS A/B, HEPATITIS AB) that are the same as %HEPATITIS A%
 ;                                (HEP A/HEP B%, HEP A&B, HEP A/HEP B) that are the same as HEP A%
VACCINE ;  Hepatitis A vaccine names (% = wild card)
 ;;HEP A%^%HEPATITIS A%^HEPATITIS-A%^HEPAADULT^HEPAADLT1^HEPA,%^HEPA/HEPB%^%HEP A/B%^HEPAB%^TWINRIX%
 ;;
 Q
 ;
