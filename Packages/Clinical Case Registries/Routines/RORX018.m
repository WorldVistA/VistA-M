RORX018 ;BPOIFO/ACS - BMI BY RANGE REPORT ;11/1/09
 ;;1.5;CLINICAL CASE REGISTRIES;**10,13,19,21**;Feb 17, 2006;Build 45
 ;
 ;
 ; This routine uses the following IAs:
 ;
 ; #4290  ^PXRMINDX(120.5 (controlled)
 ; #3647   $$EN^GMVPXRM (controlled)
 ; #5047   $$GETIEN^GMVGETVT (supported)
 ;
 ;******************************************************************************
 ;******************************************************************************
 ;                 --- ROUTINE MODIFICATION LOG ---
 ;        
 ;PKG/PATCH    DATE        DEVELOPER    MODIFICATION
 ;-----------  ----------  -----------  ----------------------------------------
 ;ROR*1.5*10   MAR  2010   A SAUNDERS   Routine created
 ;ROR*1.5*13   DEC  2010   A SAUNDERS   User can select specific patients,
 ;                                      clinics, or divisions for the report.
 ;                                      Modified XML tags for sort.
 ;ROR*1.5*19   FEB  2012   K GUPTA      Support for ICD-10 Coding System
 ;ROR*1.5*21   SEP 2013    T KOPP       Add ICN column if Additional Identifier
 ;                                       requested.
 ;                                      
 ;******************************************************************************
 ;******************************************************************************
 Q
 ;*****************************************************************************
 ;COMPILE THE "BMI BY RANGE" REPORT
 ;REPORT CODE: 018
 ;
 ;Called by entry "BMI by Range" in ROR REPORT PARAMETERS (#799.34)
 ;
 ;INPUT
 ;  RORTSK     Task number and task parameters
 ;
 ;  Below is a sample RORTSK input array for utilization in 2003, most recent
 ;  scores, BMI range from 30 to 45:
 ;
 ;  RORTSK=nnn   (task number)
 ;  RORTSK("EP")="$$BMIRANGE^RORX018"
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
 ;OUTPUT
 ;  <0  Error code
 ;   0  Ok
 ;*****************************************************************************
BMIRANGE(RORTSK) ;
 N RORDATA       ; array to hold ROR data and summary totals
 N RORREG        ; Registry IEN
 N RORSDT        ; report start date
 N ROREDT        ; report end date
 N RORPTIEN      ; IEN of patient in the ROR registry
 N DFN           ; DFN of patient in the PATIENT file (#2)
 N RORCDLIST     ; Flag to indicate whether a clinic or division list exists
 N RORCDSTDT     ; Start date for clinic/division utilization search
 N RORCDENDT     ; End date for clinic/division utilization search
 ;
 N REPORT,PARAMS,SFLAGS,RC,CNT,ECNT,UTSDT,UTEDT,SKIPSDT,SKIPEDT,RORBODY,RORPTN
 N RCC,FLAG,TMP,DFN,SKIP
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
 S RC=$$PARAMS(PARAMS,.RORDATA) Q:RC<0 RC
 ;
 ;--- Put report header data into output:
 ;report creation date, task number, last registry update date, and
 ;last data extraction date
 S RC=$$HEADER(REPORT) Q:RC<0 RC
 ;
 ;--- Set the number of BMI ranges and initialize their values to 0
 S RORDATA("RCNT")=6 D INIT(.RORDATA)
 ;
 ;--- Get GMRV VITAL TYPE pointer for HEIGHT and WEIGHT
 S RORDATA("HGTP")=$$GETIEN^GMVGETVT("HEIGHT",1)
 S RORDATA("WGTP")=$$GETIEN^GMVGETVT("WEIGHT",1)
 I '$G(RORDATA("HGTP")) Q -1
 I '$G(RORDATA("WGTP")) Q -1
 ;
 ;--- 'Most recent' vs. max date requested
 S RORDATA("DATE")=0
 I $$PARAM^RORTSK01("OPTIONS","MOST_RECENT") S RORDATA("DATE")=DT_.9
 I '$G(RORDATA("DATE")) S RORDATA("DATE")=$$PARAM^RORTSK01("OPTIONS","MAX_DATE")_.9
 ;
 ;--- Summary vs. complete report requested
 S RORDATA("SUMMARY")=0
 I $$PARAM^RORTSK01("OPTIONS","SUMMARY") S RORDATA("SUMMARY")=1
 ;
 ;--- Get BMI range requested (there is currently only 1 BMI test)
 S I=0 F  S I=$O(RORTSK("PARAMS","LRGRANGES","C",I)) Q:I=""  D
 . S RORDATA("L",I)=$G(RORTSK("PARAMS","LRGRANGES","C",I,"L")) ;low BMI range
 . S RORDATA("H",I)=$G(RORTSK("PARAMS","LRGRANGES","C",I,"H")) ;high BMI range
 ;
 ;--- Create 'patients' table
 S RORBODY=$$ADDVAL^RORTSK11(RORTSK,"PATIENTS",,REPORT)
 D ADDATTR^RORTSK11(RORTSK,RORBODY,"TABLE","PATIENTS")
 ;
 ;--- Get utilization date range (always sent in)
 S (CNT,ECNT,RC)=0,SKIPEDT=ROREDT,SKIPSDT=RORSDT
 S UTSDT=$$PARAM^RORTSK01("DATE_RANGE_3","START")\1
 S UTEDT=$$PARAM^RORTSK01("DATE_RANGE_3","END")\1
 ; Combined date range
 S SKIPSDT=$$DTMIN^RORUTL18(SKIPSDT,$G(UTSDT))
 S SKIPEDT=$$DTMAX^RORUTL18(SKIPEDT,$G(UTEDT))
 ;
 ;--- Number of patients in the registry - used for calculating the
 ;task progress percentage - shown on the GUI screen
 S RORPTN=$$REGSIZE^RORUTL02(+RORREG) S:RORPTN<0 RORPTN=0
 ;
 ;=== Set up Clinic/Division list parameters
 S RORCDLIST=$$CDPARMS^RORXU001(.RORTSK,.RORCDSTDT,.RORCDENDT,1)
 ;
 ;--- Get registry records
 S (CNT,RORPTIEN,RC)=0
 S FLAG=$G(RORTSK("PARAMS","ICDFILT","A","FILTER"))
 F  S RORPTIEN=$O(^RORDATA(798,"AC",RORREG,RORPTIEN))  Q:RORPTIEN'>0  D  Q:RC<0
 . ;--- Calculate 'progress' for the GUI display
 . S TMP=$S(RORPTN>0:CNT/RORPTN,1:"")
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
 . Q:$G(SKIP)
 . ;
 . ;--- For each patient, process the registry record
 . I $$PATIENT(DFN,RORBODY,.RORDATA)<0 S ECNT=ECNT+1 ;error count
 ;
 ;--- Always create BMI summary report
 S RC=$$SUMMARY(RORTSK,REPORT,.RORDATA) Q:RC<0 RC
 K ^TMP("RORX018",$J)
 Q $S(RC<0:RC,ECNT>0:-43,1:0)
 ;
 ;*****************************************************************************
 ;ADD THE PATIENT DATA TO THE REPORT
 ;
 ;INPUT
 ;  DFN      Patient DFN in PATIENT file (#2)
 ;  PTAG     Reference IEN to the 'body' parent XML tag
 ;  RORDATA  Array with ROR data
 ;
 ;OUTPUT
 ;  1        ok
 ; <0        error
 ;*****************************************************************************
PATIENT(DFN,PTAG,RORDATA) ;
 I $$CALCBMI(DFN,PTAG,.RORDATA)<0 Q 0  ;calculate the BMI
 I '$$INRANGE(.RORDATA) Q 0 ;if range sent, BMI must be in the requested range
 D BMICAT(.RORDATA) ;add 1 to appropriate category count
 Q:RORDATA("SUMMARY") 1  ;stop if only the 'summary' report was requested
 ;
 ;--- Get patient data and put into the report
 N VADM,VA,RORDOD,BTAG,HTAG,WTAG
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
 ;--- 'BMIDATA' tag
 S BTAG=$$ADDVAL^RORTSK11(RORTSK,"BMIDATA",,PTAG)
 Q:BTAG<0 BTAG
 ;--- Height tag
 S HTAG=$$ADDVAL^RORTSK11(RORTSK,"HEIGHT",,BTAG)
 Q:HTAG<0 HTAG
 ;---  Date Height Taken
 D ADDVAL^RORTSK11(RORTSK,"DATE",$G(RORDATA("HDATE")),HTAG)
 ;---  Height value
 D ADDVAL^RORTSK11(RORTSK,"RESULT",$G(RORDATA("HGT")),HTAG)
 ;---  Weight tag
 S WTAG=$$ADDVAL^RORTSK11(RORTSK,"WEIGHT",,BTAG)
 Q:WTAG<0 WTAG
 ;---  Date Weight Taken
 D ADDVAL^RORTSK11(RORTSK,"DATE",$G(RORDATA("WDATE")),WTAG)
 ;---  Weight value
 D ADDVAL^RORTSK11(RORTSK,"RESULT",$G(RORDATA("WGT")),WTAG)
 ;---  Calculated BMI value goes on PATIENT tag
 D ADDVAL^RORTSK11(RORTSK,"BMI",$G(RORDATA("SCORE",1)),PTAG,3)
 ; --- ICN if selected must be last column on report
 I $$PARAM^RORTSK01("PATIENTS","ICN") D ICNDATA^RORXU006(.RORTSK,DFN,PTAG)
 ;
 Q 1
 ;
 ;*****************************************************************************
 ;CALCULATE THE BMI FOR CURRENT PATIENT
 ;
 ;INPUT
 ;  DFN      Patient DFN in PATIENT file (#2)
 ;  PTAG     Reference IEN to the 'body' parent XML tag
 ;  RORDATA  Array with ROR data
 ;  
 ;OUTPUT
 ;  1        BMI calculated successfully
 ; -1        Patient does not have vital measurements or BMI is out of range
 ;  RORDATA  Array with ROR data:
 ;           RORDATA("WGT")   - weight measurement
 ;           RORDATA("WDATE") - date of weight measurement
 ;           RORDATA("HGT")   - height measurement
 ;           RORDATA("HDATE") - date of height measurement
 ;           RORDATA("SCORE",N) - calculated BMI value for test N
 ;*****************************************************************************
CALCBMI(DFN,PTAG,RORDATA) ;
 ;-- get vital measurements for BMI calculation
 S RORDATA("CALC")=1 ;default - the score for this patient should be calculated
 N RORDATE,I,RORVMDT,RORVMIEN,RORARY,TMP1,TMP2,TMP3
 K RORDATA("HGT"),RORDATA("WGT"),RORDATA("SCORE",1)
 S RORDATE=RORDATA("DATE")
 F I="HGTP","WGTP" D  ;height and weight pointers
 . ;get vital measurement date and IEN
 . S RORVMDT=$O(^PXRMINDX(120.5,"PI",DFN,RORDATA(I),RORDATE),-1) ;vm date
 . Q:$G(RORVMDT)=""
 . S RORVMIEN=$O(^PXRMINDX(120.5,"PI",DFN,RORDATA(I),RORVMDT,0)) ;vm IEN
 . Q:$G(RORVMIEN)=""
 . ;call API to get patient's vital measurement value
 . K RORARY D EN^GMVPXRM(.RORARY,RORVMIEN,"I")
 . ; set values into RORDATA("WGT"), ("HGT"), ("WDATE"), & ("HDATE")
 . S RORDATA($E(I,1,3))=$G(RORARY(7)),RORDATA($E(I,1)_"DATE")=$P(RORVMDT,".",1)
 ;quit if height or weight is not > 0
 I (($G(RORDATA("HGT"))'>0)!($G(RORDATA("WGT"))'>0)) Q -1
 ;strip out characters "IN", ",E"
 I ((RORDATA("HGT")["IN")!(RORDATA("HGT")[",E")) S RORDATA("HGT")=+RORDATA("HGT")
 ;mark as 'invalid' if height not between 36 and 96 inches
 I ((RORDATA("HGT")<36)!(RORDATA("HGT")>96)) D  Q 1
 . S RORDATA("CALC")=0 ;no score calculations can be done on 'invalid' data
 . S RORDATA("HGT")=RORDATA("HGT")_"*"
 ;mark as 'invalid' if height contains "CM", or "'" or double quote
 I ((RORDATA("HGT")["CM")!(RORDATA("HGT")["'")!(RORDATA("HGT")["""")) D  Q 1
 . S RORDATA("CALC")=0 ;no score calculations can be done on 'invalid' data
 . S RORDATA("HGT")=RORDATA("HGT")_"*"
 ;
 ;BMI calculation: (weight * 703) / (height*height)
 S TMP1=703*($G(RORDATA("WGT")))
 S TMP2=$G(RORDATA("HGT"))*($G(RORDATA("HGT")))
 S TMP3=TMP1/TMP2
 S RORDATA("SCORE",1)=$J(TMP3,0,1) ;round to 1 decimal point
 Q 1
 ;
 ;************************************************************************
 ;DETERMINE IF THE SCORE IS WITHIN THE REQUESTED RANGE
 ;
 ;INPUT:
 ;  RORDATA  RORDATA("SCORE",I) contains computed test score for test ID 'I'
 ;
 ;OUTPUT:
 ;  1  computed test score in range
 ;  0  computed test score not in range
 ;************************************************************************
INRANGE(RORDATA) ;
 ;if range exists for the test, and any result is considered 'invalid',
 ;then skip the range check and exclude data from report
 I $G(RORDATA("RANGE")),'$G(RORDATA("CALC")) Q 0
 ;if range does not exist for test, and any result is considered 'invalid',
 ;then skip the range check and include data in the report
 I '$G(RORDATA("RANGE")),'$G(RORDATA("CALC")) Q 1
 ;
 N I,RETURN S RETURN=1 ;default is set to 'within range'
 S I=0
 F  S I=$O(RORDATA("SCORE",I)) Q:I=""  D
 . I $G(RORDATA("L",I))'="" D
 .. I $G(RORDATA("SCORE",I))<RORDATA("L",I) S RETURN=0
 . I $G(RORDATA("H",I))'="" D
 .. I $G(RORDATA("SCORE",I))>RORDATA("H",I) S RETURN=0
 Q RETURN
 ;
 ;*****************************************************************************
 ;ADD 1 TO APPROPRIATE BMI CATEGORY
 ;
 ;INPUT
 ;  RORDATA  Array with ROR data
 ;           RORDATA("SCORE",N) - calculated BMI value for test N
 ;OUTPUT
 ;  RORDATA("NP",N) - incremented by 1 if BMI in Nth range
 ;           
 ;*****************************************************************************
BMICAT(RORDATA) ;
 I '$G(RORDATA("SCORE",1)) Q
 I $G(RORDATA("SCORE",1))<18.5 S RORDATA("NP",1)=$G(RORDATA("NP",1))+1 Q
 I $G(RORDATA("SCORE",1))<25 S RORDATA("NP",2)=$G(RORDATA("NP",2))+1 Q
 I $G(RORDATA("SCORE",1))<30 S RORDATA("NP",3)=$G(RORDATA("NP",3))+1 Q
 I $G(RORDATA("SCORE",1))<35 S RORDATA("NP",4)=$G(RORDATA("NP",4))+1 Q
 I $G(RORDATA("SCORE",1))<40 S RORDATA("NP",5)=$G(RORDATA("NP",5))+1 Q
 I $G(RORDATA("SCORE",1))>39 S RORDATA("NP",6)=$G(RORDATA("NP",6))+1 Q
 Q
 ;
 ;*****************************************************************************
 ;ADD THE SUMMARY DATA TO THE REPORT
 ;
 ;INPUT
 ;  RORTSK   Task number and task parameters
 ;  REPORT   'Report' XML tag number
 ;  RORDATA  Array with summary data:
 ;           RORDATA("NP",N) - total count of patients in Nth range
 ;
 ;OUTPUT
 ;  DATA     'Data' XML tag number or error code
 ;*****************************************************************************
SUMMARY(RORTSK,REPORT,RORDATA) ; Add the summary values to the report
 N SUMMARY,I,STAG,RORCATNUM,RORNAME,RORRANGE
 S SUMMARY=$$ADDVAL^RORTSK11(RORTSK,"SUMMARY",,REPORT)
 Q:SUMMARY<0 SUMMARY
 ;add data for the summary entries
 F I=1:1:RORDATA("RCNT")  D  Q:STAG<0
 . S STAG=$$ADDVAL^RORTSK11(RORTSK,"DATA",,SUMMARY)
 . Q:STAG<0
 . ;get each value
 . S RORCATNUM="S"_I S RORNAME=$P($T(@RORCATNUM),";;",2)
 . S RORRANGE=$P($T(@RORCATNUM),";;",3)
 . D ADDVAL^RORTSK11(RORTSK,"DESC",$G(RORNAME),STAG) ;severity
 . D ADDVAL^RORTSK11(RORTSK,"VALUES",$G(RORRANGE),STAG) ;range
 . D ADDVAL^RORTSK11(RORTSK,"NP",$G(RORDATA("NP",I)),STAG) ;count
 Q STAG
 ;
 ;*****************************************************************************
 ;OUTPUT THE REPORT 'RANGE' PARAMETERS
 ;
 ; PARTAG        Reference (IEN) to the parent tag
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;*****************************************************************************
PARAMS(PARTAG,RORDATA) ;
 N PARAMS,TMP,RC S RC=0
 S RORDATA("RANGE")=0 ;initialize to 'no range passed in'
 ;--- Lab test ranges
 I $D(RORTSK("PARAMS","LRGRANGES","C"))>1  D  Q:RC<0 RC
 . N GRC,ELEMENT,NODE,RTAG,RANGE
 . S NODE=$NA(RORTSK("PARAMS","LRGRANGES","C"))
 . S RTAG=$$ADDVAL^RORTSK11(RORTSK,"LRGRANGES",,PARTAG)
 . S (GRC,RC)=0
 . F  S GRC=$O(@NODE@(GRC))  Q:GRC'>0  D  Q:RC<0
 . . S RANGE=0,TMP=$$RTEXT(GRC)
 . . S ELEMENT=$$ADDVAL^RORTSK11(RORTSK,"LRGRANGE",TMP,RTAG)
 . . I ELEMENT<0  S RC=ELEMENT  Q
 . . D ADDATTR^RORTSK11(RORTSK,ELEMENT,"ID",GRC)
 . . ;--- Process the range values
 . . S TMP=$G(@NODE@(GRC,"L"))
 . . I TMP'=""  D  S RANGE=1
 . . . D ADDATTR^RORTSK11(RORTSK,ELEMENT,"LOW",TMP)
 . . S TMP=$G(@NODE@(GRC,"H"))
 . . I TMP'=""  D  S RANGE=1
 . . . D ADDATTR^RORTSK11(RORTSK,ELEMENT,"HIGH",TMP)
 . . I RANGE D
 . . . D ADDATTR^RORTSK11(RORTSK,ELEMENT,"RANGE",1)
 . . . S RORDATA("RANGE")=1 ;range exists
 ;--- Success
 Q RC
 ;
 ;*****************************************************************************
 ;RETURN RANGE TEXT
 ;
 ; GRC   Test ID
 ;
 ; Return Values:
 ;       Description - <range>
 ;*****************************************************************************
RTEXT(GRC) ;
 N RANGE,TMP
 S RANGE=""
 ;--- Range
 I $D(RORTSK("PARAMS","LRGRANGES","C",GRC))>1 D
 . ;--- Low
 . S TMP=$G(RORTSK("PARAMS","LRGRANGES","C",GRC,"L"))
 . S:TMP'="" RANGE=RANGE_" not less than "_TMP
 . ;--- High
 . S TMP=$G(RORTSK("PARAMS","LRGRANGES","C",GRC,"H"))
 . I TMP'=""  D:RANGE'=""  S RANGE=RANGE_" not greater than "_TMP
 . . S RANGE=RANGE_" and"
 ;--- Description
 S TMP=$G(RORTSK("PARAMS","LRGRANGES","C",GRC))
 S:TMP="" TMP="Unknown ("_GRC_")"
 Q TMP_" - "_$S(RANGE'="":"numeric results"_RANGE,1:"all results")
 ;
 ;*****************************************************************************
 ;ADD THE HEADERS TO THE REPORT
 ;
 ;INPUT
 ;  PARTAG  Reference IEN to the 'report' parent XML tag
 ;
 ;OUTPUT
 ;  <0      error
 ;  >0      'Header' XML tag number or error code
 ;*****************************************************************************
HEADER(PARTAG) ;
 ;;PATIENTS(#,NAME,LAST4,DOD,VITAL,DATE,RESULT,BMI,ICN)
 ;
 N HEADER,RC
 ;call to $$HEADER^RORXU002 will populate the report created date, task number,
 ;last registry update, and last data extraction.
 S HEADER=$$HEADER^RORXU002(.RORTSK,PARTAG)
 Q:HEADER<0 HEADER
 ;automatically build the table defintion(s) listed under the header tag above
 S RC=$$TBLDEF^RORXU002("HEADER^RORX018",HEADER)
 Q $S(RC<0:RC,1:HEADER)
 ;
 ;*****************************************************************************
 ;INITIALIZE THE NUMBER OF PATIENTS IN EACH CATEGORY TO 0
 ;
 ;INPUT
 ;  RORDATA  Array with ROR data
 ;           RORDATA("RCNT") Number of categories to initialize
 ;*****************************************************************************
INIT(RORDATA) ;
 I $G(RORDATA("RCNT"))="" Q
 F I=1:1:RORDATA("RCNT") D
 . S RORDATA("NP",I)=0
 Q
 ;
 ;*****************************************************************************
 ;BMI Categories and Values for the summary table.
 ;NOTE: the number of entries below must match the value of RORDATA("RCNT")
 ;*****************************************************************************
S1 ;;Underweight;;<18.5
S2 ;;Normal weight;;18.5-24.9
S3 ;;Overweight;;25.0-29.99
S4 ;;Class I Obesity;;30.0-34.9
S5 ;;Class II Obesity;;35-39.9
S6 ;;Class III Obesity;;>=40
