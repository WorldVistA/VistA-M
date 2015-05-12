RORX019 ;BPOIFO/ACS - LIVER SCORE BY RANGE ;5/18/11 12:39pm
 ;;1.5;CLINICAL CASE REGISTRIES;**10,13,14,15,19,21**;Feb 17, 2006;Build 45
 ;
 ;******************************************************************************
 ;******************************************************************************
 ;                 --- ROUTINE MODIFICATION LOG ---
 ;        
 ;PKG/PATCH    DATE        DEVELOPER    MODIFICATION
 ;-----------  ----------  -----------  ----------------------------------------
 ;ROR*1.5*10   MAR 2010    A SAUNDERS   Routine created
 ;ROR*1.5*13   DEC 2010    A SAUNDERS   User can select specific patients,
 ;                                      clinics, or divisions for the report.
 ;                                      Modified XML tags for sort.
 ;ROR*1.5*14   APR 2011    A SAUNDERS   Added APRI and FIB4 scores.
 ;ROR*1.5*15   MAY 2011    C RAY        Modified to exclude null tests
 ;ROR*1.5*19   FEB 2012    J SCOTT      Support for ICD-10 Coding System
 ;ROR*1.5*21   SEP 2013    T KOPP       Added ICN as last report column if
 ;                                      additional identifier option selected
 ;******************************************************************************
 ;******************************************************************************
 Q
 ;************************************************************************
 ;COMPILE THE "LIVER SCORE BY RANGE" REPORT (EXTRINISIC FUNCTION)
 ;REPORT CODE: 019
 ;
 ;Called by entry "Liver Score by Range" in ROR REPORT PARAMETERS (#799.34)
 ;
 ;INPUT
 ;  RORTSK     Task number and task parameters
 ;
 ;
 ;  Below is a sample RORTSK input array for utilization in 2003, most recent
 ;  scores, MELD range from 10 to 30, MELD Na range from 20 to 50:
 ;  
 ;  RORTSK=nnn   (the task number)
 ;  RORTSK("EP")="$$MLDRANGE^RORX019"
 ;  RORTSK("PARAMS","DATE_RANGE_3","A","END")=3031231
 ;  RORTSK("PARAMS","DATE_RANGE_3","A","START")=3030101
 ;  RORTSK("PARAMS","ICDFILT","A","FILTER")="ALL"
 ;  RORTSK("PARAMS","LRGRANGES","C",1)=""
 ;  RORTSK("PARAMS","LRGRANGES","C",1,"H")=30
 ;  RORTSK("PARAMS","LRGRANGES","C",1,"L")=10
 ;  RORTSK("PARAMS","LRGRANGES","C",2)=""
 ;  RORTSK("PARAMS","LRGRANGES","C",2,"H")=50
 ;  RORTSK("PARAMS","LRGRANGES","C",2,"L")=20
 ;  RORTSK("PARAMS","OPTIONS","A","COMPLETE")=1
 ;  RORTSK("PARAMS","OPTIONS","A","MOST_RECENT")=1
 ;  RORTSK("PARAMS","PATIENTS","A","DE_AFTER")=1
 ;  RORTSK("PARAMS","PATIENTS","A","DE_BEFORE")=1
 ;  RORTSK("PARAMS","PATIENTS","A","DE_DURING")=1
 ;  RORTSK("PARAMS","REGIEN")=1
 ;  
 ;  If the user selected an 'as of' date = 12/31/2005:
 ;  RORTSK("PARAMS","OPTIONS","A","MOST_RECENT")=1
 ;     is replaced with:  
 ;  RORTSK("PARAMS","OPTIONS","A","MAX_DATE")=3051231
 ;
 ;
 ;OUTPUT
 ;  <0  Error code
 ;   0  Ok
 ;************************************************************************
MLDRANGE(RORTSK) ;
 N RORREG        ; Registry IEN
 N RORSDT        ; report start date
 N ROREDT        ; report end date
 N RORDATA       ; array to hold ROR data and summary totals
 N RORPTIEN      ; IEN of patient in the ROR registry
 N DFN           ; DFN of patient in the PATIENT file (#2)
 N RORLC         ; sub-file and array of LOINC codes to search Lab data
 N RORCDLIST     ; Flag to indicate whether a clinic or division list exists
 N RORCDSTDT     ; Start date for clinic/division utilization search
 N RORCDENDT     ; End date for clinic/division utilization search
 ;
 N REPORT,RC,I,TMP,SFLAGS,PARAMS
 ;--- Establish the root XML Node of the report and put into output
 S REPORT=$$ADDVAL^RORTSK11(RORTSK,"REPORT")
 Q:REPORT<0 REPORT
 ;
 ;--- Get registry IEN
 S RORREG=$$PARAM^RORTSK01("REGIEN")  ; Registry IEN
 ;
 ;--- Set standard report parameters data into output:
 ;registry, comment, patients (before, during, after), options (summary vs.
 ;complete), other registries, and other diagnoses
 S PARAMS=$$PARAMS^RORXU002(.RORTSK,REPORT,.RORSDT,.ROREDT,.SFLAGS) Q:PARAMS<0 PARAMS
 ;
 ;--- Add range parameters to output
 S RC=$$PARAMS^RORX019A(PARAMS,.RORDATA,.RORTSK) Q:RC<0 RC
 ;
 ;--- Get ULNAST value for calculations
 I $D(RORTSK("PARAMS","ULNAST")) S RORDATA("ULNAST")=$G(RORTSK("PARAMS","ULNAST"))
 ;
 ;--- Put report header data into output:
 ;report creation date, task number, last registry update date, last
 ;data extraction date, and ULNAST if present
 S RC=$$HEADER(REPORT,PARAMS) Q:RC<0 RC
 ;
 ;--- Get test ranges requested
 ;I=1 ==> report = MELD      I=2 ==> report = MELD Na
 ;I=3 ==> report = APRI      I=4 ==> report = FIB-4
 S I=0 F  S I=$O(RORTSK("PARAMS","LRGRANGES","C",I)) Q:I=""  D
 . S RORDATA("L",I)=$G(RORTSK("PARAMS","LRGRANGES","C",I,"L")) ;low range
 . S RORDATA("H",I)=$G(RORTSK("PARAMS","LRGRANGES","C",I,"H")) ;high range
 ;
 ;--- Get Max Date for test results  OUTPUT: RORDATA("DATE")
 ;In the GUI, the user selects either 'most recent' or 'as of' date
 S RORDATA("DATE")=$$PARAM^RORTSK01("OPTIONS","MAX_DATE")
 I $G(RORDATA("DATE"))="" S RORDATA("DATE")=DT
 ;
 ;--- Create 'patients' table
 N RORBODY S RORBODY=$$ADDVAL^RORTSK11(RORTSK,"PATIENTS",,REPORT)
 D ADDATTR^RORTSK11(RORTSK,RORBODY,"TABLE","PATIENTS")
 ;
 ;--- Check utilization
 N CNT,ECNT,UTSDT,UTEDT,SKIPSDT,SKIPEDT
 S (CNT,ECNT,RC)=0,SKIPEDT=ROREDT,SKIPSDT=RORSDT
 ; Utilization date range is always sent
 S UTSDT=$$PARAM^RORTSK01("DATE_RANGE_3","START")\1
 S UTEDT=$$PARAM^RORTSK01("DATE_RANGE_3","END")\1
 ; Combined date range
 S SKIPSDT=$$DTMIN^RORUTL18(SKIPSDT,$G(UTSDT))
 S SKIPEDT=$$DTMAX^RORUTL18(SKIPEDT,$G(UTEDT))
 ;
 ;--- Number of patients in the registry - used for calculating the
 ;task progress percentage (shown on the GUI screen)
 N RORPTCNT S RORPTCNT=$$REGSIZE^RORUTL02(+RORREG) S:RORPTCNT<0 RORPTCNT=0
 ;
 ;--- LOINC codes
 I "1,2"[RORDATA("IDLST") D  ;If MELD or MELD-NA scores requested
 . ;create list for future comparison
 . S RORDATA("CR_LOINC")=";15045-8;21232-4;2160-0;" ;Creatinine
 . S RORDATA("BIL_LOINC")=";14631-6;1975-2;" ;Bilirubin
 . S RORDATA("SOD_LOINC")=";2947-0;2951-2;32717-1;" ;Sodium
 . S RORDATA("INR_LOINC")=";34714-6;6301-6;" ;INR 
 . ;set up array for future call to Lab API
 . S RORLC="CH" ;chemistry sub-file to search in #63
 . S RORLC(1)="15045-8^LN" ;Creatinine LOINC
 . S RORLC(2)="21232-4^LN" ;Creatinine LOINC
 . S RORLC(3)="2160-0^LN"  ;Creatinine LOINC
 . S RORLC(4)="14631-6^LN" ;Bilirubin LOINC
 . S RORLC(5)="1975-2^LN"  ;Bilirubin LOINC
 . S RORLC(6)="2947-0^LN"  ;Sodium LOINC
 . S RORLC(7)="2951-2^LN"  ;Sodium LOINC
 . S RORLC(8)="32717-1^LN" ;Sodium LOINC
 . S RORLC(9)="34714-6^LN" ;INR LOINC
 . S RORLC(10)="6301-6^LN" ;INR LOINC
 ;
 I "3,4"[RORDATA("IDLST") D  ;If APRI or FIB-4 scores requested
 . ;create list for future comparison
 . S RORDATA("AST_LOINC")=";1916-6;1920-8;127344-1;" ;AST 
 . S RORDATA("PLAT_LOINC")=";777-3;778-1;26515-7;" ;Platelets 
 . S RORDATA("ALT_LOINC")=";1742-6;16325-3;" ;ALT 
 . ;set up array for future call to Lab API
 . S RORLC="CH" ;chemistry sub-file to search in #63
 . S RORLC(1)="1916-6^LN" ;AST LOINC
 . S RORLC(2)="1920-8^LN" ;AST LOINC
 . ;S RORLC(3)="127344-1^LN" ;AST LOINC
 . S RORLC(4)="777-3^LN" ;Platelets LOINC
 . S RORLC(5)="778-1^LN" ;Platelets LOINC
 . S RORLC(6)="26515-7^LN" ;Platelets LOINC
 . S RORLC(7)="1742-6^LN" ;ALT LOINC
 . S RORLC(8)="16325-3^LN" ;ALT LOINC
 ;
 ;=== Set up Clinic/Division list parameters
 S RORCDLIST=$$CDPARMS^RORXU001(.RORTSK,.RORCDSTDT,.RORCDENDT,1)
 ;
 ;--- Get registry records
 N RCC,FLAG,TMP,DFN,SKIP
 S (CNT,RORPTIEN,RC)=0
 S FLAG=$G(RORTSK("PARAMS","ICDFILT","A","FILTER"))
 F  S RORPTIEN=$O(^RORDATA(798,"AC",RORREG,RORPTIEN))  Q:RORPTIEN'>0  D  Q:RC<0
 . ;--- Calculate 'progress' for the GUI display
 . S TMP=$S(RORPTCNT>0:CNT/RORPTCNT,1:"")
 . S RC=$$LOOP^RORTSK01(TMP)  Q:RC<0
 . S CNT=CNT+1
 . ;--- Get patient DFN
 . S DFN=$$PTIEN^RORUTL01(RORPTIEN) Q:DFN'>0
 . ;check for patient list and quit if not on list
 . I $D(RORTSK("PARAMS","PATIENTS","C")),'$D(RORTSK("PARAMS","PATIENTS","C",DFN)) Q
 . ;--- Check if the patient should be skipped
 . Q:$$SKIP^RORXU005(RORPTIEN,SFLAGS,SKIPSDT,SKIPEDT)
 . ;--- Check if patient has passed the ICD filter
 . S RCC=0
 . I FLAG'="ALL" D
 . . S RCC=$$ICD^RORXU010(DFN)
 . I (FLAG="INCLUDE")&(RCC=0) Q
 . I (FLAG="EXCLUDE")&(RCC=1) Q
 . ;
 . ;--- Check for Clinic or Division list and quit if not in list
 . I RORCDLIST,'$$CDUTIL^RORXU001(.RORTSK,DFN,RORCDSTDT,RORCDENDT) Q
 . ;
 . ;--- Check for any utilization in the corresponding date range
 . S SKIP=0 I $G(UTSDT)>0 D
 .. N UTIL K TMP S TMP("ALL")=1
 .. S UTIL=+$$UTIL^RORXU003(UTSDT,UTEDT,DFN,.TMP)
 .. S:'UTIL SKIP=1
 . ;--- Skip the patient if they have no utilization in the range
 . I $G(SKIP) Q
 . ;
 . ;--- For each patient, process the registry record and create report
 . I $$PATIENT(DFN,RORBODY,.RORDATA,RORPTIEN,.RORLC)<0 S ECNT=ECNT+1 ;error count
 ;
 K ^TMP("RORX019",$J)
 Q $S(RC<0:RC,ECNT>0:-43,1:0)
 ;
 ;************************************************************************
 ;ADD PATIENT DATA TO THE REPORT (EXTRINISIC FUNCTION)
 ;
 ;INPUT
 ;  DFN      Patient DFN in PATIENT file (#2)
 ;  PTAG     Reference IEN to the 'body' parent XML tag
 ;  RORDATA  Array with ROR data
 ;  RORPTIEN Patient IEN in the ROR registry
 ;  RORLC    sub-file and LOINC codes to search for
 ;
 ;OUTPUT
 ;  1        ok
 ; <0        error
 ;************************************************************************
PATIENT(DFN,PTAG,RORDATA,RORPTIEN,RORLC) ;
 ;Calculate the scores requested by the user
 I ((RORDATA("IDLST")[1)!(RORDATA("IDLST")[2)) I $$CALCMLD^RORX019A(DFN,PTAG,.RORDATA,RORPTIEN,.RORLC)<0 Q 1
 I ((RORDATA("IDLST")[3)!(RORDATA("IDLST")[4)) I $$CALCFIB^RORX019A(DFN,PTAG,.RORDATA,RORPTIEN,.RORLC)<0 Q 1
 I '$$INRANGE(.RORDATA) Q 1  ;exclude patient from report if ANY score is out of range
 I '$$SKIP(.RORDATA) Q 1  ;exclude patient from report with null scores
 ;--- Get patient data and put into the report
 N VADM,VA,RORDOD,MTAG,TTAG
 D VADEM^RORUTL05(DFN,1)
 ;--- The <PATIENT> tag
 S PTAG=$$ADDVAL^RORTSK11(RORTSK,"PATIENT",,PTAG,,DFN)
 I PTAG<0 Q PTAG
 ;--- Patient Name
 D ADDVAL^RORTSK11(RORTSK,"NAME",VADM(1),PTAG,1)
 ;--- Last 4 digits of the SSN
 D ADDVAL^RORTSK11(RORTSK,"LAST4",VA("BID"),PTAG,2)
 ;--- Date of death
 S RORDOD=$$DATE^RORXU002($P(VADM(6),U)\1)
 D ADDVAL^RORTSK11(RORTSK,"DOD",$G(RORDOD),PTAG,1)
 ;--- MELDDATA tag
 S MTAG=$$ADDVAL^RORTSK11(RORTSK,"MELDDATA",,PTAG)
 I MTAG<0 Q MTAG
 ;--- Test Result Values
 N TNAME
 I ((RORDATA("IDLST")[1)!(RORDATA("IDLST")[2)) D
 .F TNAME="BILI","CR","INR" D TSTRSLT(TNAME,MTAG)
 .I RORDATA("IDLST")[2 D TSTRSLT("NA",MTAG)
 I ((RORDATA("IDLST")[3)!(RORDATA("IDLST")[4)) D
 .F TNAME="AST","PLAT" D TSTRSLT(TNAME,MTAG)
 .I RORDATA("IDLST")[4 D TSTRSLT("ALT",MTAG)
 ;---  MELD score
 I RORDATA("IDLST")[1 D ADDVAL^RORTSK11(RORTSK,"MELD",$G(RORDATA("SCORE",1)),PTAG,3)
 ;---  MELD-Na Score
 I RORDATA("IDLST")[2 D ADDVAL^RORTSK11(RORTSK,"MELDNA",$G(RORDATA("SCORE",2)),PTAG,3)
 ;---  APRI Score
 I RORDATA("IDLST")[3 D ADDVAL^RORTSK11(RORTSK,"APRI",$G(RORDATA("SCORE",3)),PTAG,3)
 ;---  FIB-4 Score
 I RORDATA("IDLST")[4 D ADDVAL^RORTSK11(RORTSK,"FIB4",$G(RORDATA("SCORE",4)),PTAG,3)
 I $$PARAM^RORTSK01("PATIENTS","ICN") D
 . S TMP=$$ICN^RORUTL02(DFN)
 . D ADDVAL^RORTSK11(RORTSK,"ICN",TMP,PTAG,1)
 Q ($S($G(TTAG)<0:TTAG,1:1))
 ;
 ;*****************************************************
 ;Procedure to add test name, date and results to report
 ;INPUT
 ;   TNAME       Name of test 
 ;   MTAG        IEN of parent record
 ;OUTPUT         n/a
 ;******************************************************
TSTRSLT(TNAME,MTAG) ;
 ;--- Test Result Values
 ;--- TEST tag
 N TNAMEMIX
 S TTAG=$$ADDVAL^RORTSK11(RORTSK,"TEST",,MTAG)
 I TTAG<0 Q
 ;--- Mixed case test name for GUI application
 I TNAME="BILI" S TNAMEMIX="Bili"
 I TNAME="CR" S TNAMEMIX="Cr"
 I TNAME="INR" S TNAMEMIX="INR"
 I TNAME="NA" S TNAMEMIX="Na"
 I TNAME="AST" S TNAMEMIX="AST"
 I TNAME="PLAT" S TNAMEMIX="Platelet"
 I TNAME="ALT" S TNAMEMIX="ALT"
 ;---  Test Name
 D ADDVAL^RORTSK11(RORTSK,"TNAME",TNAMEMIX,TTAG)
 ;---  Test Date
 D ADDVAL^RORTSK11(RORTSK,"DATE",$P($G(RORDATA(TNAME)),U,2),TTAG)
 ;---  Test Result Value
 D ADDVAL^RORTSK11(RORTSK,"RESULT",$P($G(RORDATA(TNAME)),U,1),TTAG)
 Q
 ;****************************************************************
 ;Function to check whether patient should be included on report
 ;To be included patient must have a score for at least one of
 ;the scores requested by the user
 ;
 ;INPUT
 ;   RORDATA   Array with ROR Data
 ;OUTPUT
 ;   1         Include
 ;   0         Exclude
 ;***************************************************************
SKIP(RORDATA) ;
 ;
 N RETURN
 S RETURN=0
 I RORDATA("IDLST")[1,+$G(RORDATA("SCORE",1)) S RETURN=1
 I RORDATA("IDLST")[2,+$G(RORDATA("SCORE",2)) S RETURN=1
 I RORDATA("IDLST")[3,+$G(RORDATA("SCORE",3)) S RETURN=1
 I RORDATA("IDLST")[4,+$G(RORDATA("SCORE",4)) S RETURN=1
 Q RETURN
 ;************************************************************************
 ;DETERMINE IF THE SCORES ARE WITHIN THE REQUESTED RANGES
 ;-- If both tests contain ranges: scores for BOTH tests must fall in the
 ;ranges...treated like an 'AND'
 ;-- If 1 test contains a range: only patients with scores in the requested range
 ;will be displayed, and the test without the range will also be displayed
 ;with the calculated score (if applicable)
 ;-- If neither test contains a range: all patients and their test results
 ;and scores (null if they can't be calculated) are returned
 ;
 ;INPUT
 ;  RORDATA  Array with ROR data
 ;OUTPUT
 ;  1        include on report
 ;  0        exclude from report
 ;************************************************************************
INRANGE(RORDATA) ;
 ;include data and quit if no range was sent in
 Q:($D(RORDATA("RANGE"))'>1) 1
 ;check scores to see if they are within the user-selected range(s)
 N I,RETURN,SCORE S RETURN=1 ;default is set to 'within range'
 S I=0 F  S I=$O(RORDATA("RANGE",I)) Q:I=""  D
 . I $G(RORDATA("L",I))'="" D
 .. S SCORE=$G(RORDATA("SCORE",I))
 .. I $G(SCORE)="" S RETURN=0 Q
 .. I SCORE<RORDATA("L",I) S RETURN=0
 . I $G(RORDATA("H",I))'="" D
 .. S SCORE=$G(RORDATA("SCORE",I))
 .. I $G(SCORE)="" S RETURN=0 Q
 .. I SCORE>$G(RORDATA("H",I)) S RETURN=0
 ;
 Q RETURN
 ;
 ;************************************************************************
 ;ADD THE HEADERS TO THE REPORT (EXTRINISIC FUNCTION)
 ;
 ;INPUT
 ;  PARTAG  Reference IEN to the 'report' parent XML tag
 ;  PARAMS  Reference IEN to the 'params' parent XML tag
 ;
 ;OUTPUT
 ;  <0      error
 ;  >0      'Header' XML tag number or error code
 ;************************************************************************
HEADER(PARTAG,PARAMS) ;
 N HEADER,RC,COL,COLUMNS,TMP S RC=0
 ;call to $$HEADER^RORXU002 will populate the report created date, task number,
 ;last registry update, and last data extraction.
 S HEADER=$$HEADER^RORXU002(.RORTSK,PARTAG)
 Q:HEADER<0 HEADER
 ;manually build the table defintion(s) listed below
 ;PATIENTS(#,NAME,LAST4,DOD,TEST,DATE,RESULT,MELD,MELDNA,APRI,FIB4,ICN)
 S COLUMNS=$$ADDVAL^RORTSK11(RORTSK,"TBLDEF",,HEADER)
 D ADDATTR^RORTSK11(RORTSK,COLUMNS,"NAME","PATIENTS")
 D ADDATTR^RORTSK11(RORTSK,COLUMNS,"HEADER","1")
 D ADDATTR^RORTSK11(RORTSK,COLUMNS,"FOOTER","1")
 ;--- Required columns
 F COL="#","NAME","LAST4","DOD","TEST","DATE","RESULT"  D
 . S TMP=$$ADDVAL^RORTSK11(RORTSK,"COLUMN",,COLUMNS)
 . D ADDATTR^RORTSK11(RORTSK,TMP,"NAME",COL)
 ;--- Additional columns
 I RORDATA("IDLST")[1 D
 . S TMP=$$ADDVAL^RORTSK11(RORTSK,"COLUMN",,COLUMNS)
 . D ADDATTR^RORTSK11(RORTSK,TMP,"NAME","MELD")
 I RORDATA("IDLST")[2 D
 . S TMP=$$ADDVAL^RORTSK11(RORTSK,"COLUMN",,COLUMNS)
 . ;D ADDATTR^RORTSK11(RORTSK,TMP,"NAME","MELDNA")
 . ;note: the column name length above was causing problems in the
 . ;XSL diaglog file entry 7981019.001, so we shortened it to just "NA".
 . D ADDATTR^RORTSK11(RORTSK,TMP,"NAME","NA")
 I RORDATA("IDLST")[3 D
 . S TMP=$$ADDVAL^RORTSK11(RORTSK,"COLUMN",,COLUMNS)
 . D ADDATTR^RORTSK11(RORTSK,TMP,"NAME","APRI")
 I RORDATA("IDLST")[4 D
 . S TMP=$$ADDVAL^RORTSK11(RORTSK,"COLUMN",,COLUMNS)
 . D ADDATTR^RORTSK11(RORTSK,TMP,"NAME","FIB4")
 I $$PARAM^RORTSK01("PATIENTS","ICN") D
 . S TMP=$$ADDVAL^RORTSK11(RORTSK,"COLUMN",,COLUMNS)
 . D ADDATTR^RORTSK11(RORTSK,TMP,"NAME","ICN")
 ;--- LOINC codes
 N LTAG S LTAG=$$ADDVAL^RORTSK11(RORTSK,"LOINC_CODES",,PARTAG)
 N CTAG S CTAG=$$ADDVAL^RORTSK11(RORTSK,"CODE",,LTAG)
 D ADDATTR^RORTSK11(RORTSK,CTAG,"CODE","ALT: 1742-6, 16325-3")
 N CTAG S CTAG=$$ADDVAL^RORTSK11(RORTSK,"CODE",,LTAG)
 D ADDATTR^RORTSK11(RORTSK,CTAG,"CODE","AST: 1916-6, 1920-8, 127344-1")
 N CTAG S CTAG=$$ADDVAL^RORTSK11(RORTSK,"CODE",,LTAG)
 D ADDATTR^RORTSK11(RORTSK,CTAG,"CODE","Billirubin: 14631-6, 1975-2")
 N CTAG S CTAG=$$ADDVAL^RORTSK11(RORTSK,"CODE",,LTAG)
 D ADDATTR^RORTSK11(RORTSK,CTAG,"CODE","Creatinine: 15045-8, 21232-4, 2160-0")
 N CTAG S CTAG=$$ADDVAL^RORTSK11(RORTSK,"CODE",,LTAG)
 D ADDATTR^RORTSK11(RORTSK,CTAG,"CODE","INR: 34714-6, 6301-6")
 N CTAG S CTAG=$$ADDVAL^RORTSK11(RORTSK,"CODE",,LTAG)
 D ADDATTR^RORTSK11(RORTSK,CTAG,"CODE","Platelets: 777-3, 778-1, 26515-7")
 N CTAG S CTAG=$$ADDVAL^RORTSK11(RORTSK,"CODE",,LTAG)
 D ADDATTR^RORTSK11(RORTSK,CTAG,"CODE","Sodium: 2947-0, 2951-2, 32717-1")
 ;
 ;Add ULNAST value if passed in
 I $G(RORTSK("PARAMS","ULNAST")) D
 . N ULNAST S ULNAST=$$ADDVAL^RORTSK11(RORTSK,"ULNAST",,PARAMS)
 . D ADDATTR^RORTSK11(RORTSK,ULNAST,"VALUES",$G(RORDATA("ULNAST")))
 ;
 Q $S(RC<0:RC,1:HEADER)
 ;
