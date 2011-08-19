RORX020 ;BPOIFO/ACS - RENAL FUNCTION BY RANGE ; 3/31/11 2:21pm
 ;;1.5;CLINICAL CASE REGISTRIES;**10,13,14**;Feb 17, 2006;Build 24
 ;
 ; This routine uses the following IAs:
 ;
 ; #4290         ^PXRMINDX(120.5 (controlled)
 ; #3647         $$EN^GMVPXRM (controlled)
 ; #10061        DEM^VADPT (supported)
 ; #10105        PWR^XLFMTH (supported)
 ; #5047         $$GETIEN^GMVGETVT (supported)
 ; #3556         GCPR^LA7QRY (supported)
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
 ;ROR*1.5*14   APR  2011   A SAUNDERS   CALCRF: Age calculation now uses 
 ;                                      $$AGE^RORX019A.
 ;******************************************************************************
 ;******************************************************************************
 Q
 ;
 ;************************************************************************
 ;COMPILE THE "RENAL FUNCTION BY RANGE" REPORT
 ;REPORT CODE: 020
 ;
 ;Called by entry "Renal Function by Range" in ROR REPORT PARAMETERS (#799.34)
 ;
 ;INPUT
 ;  RORTSK     Task number and task parameters
 ;  
 ;  Below is a sample RORTSK input array for utilization in 2003, most recent
 ;  scores, CrCL range from 20 to 50, eGFR range from 30 to 60:
 ;  
 ;  RORTSK=nnn   (the task number)
 ;  RORTSK("EP")="$$RFRANGE^RORX020"
 ;  RORTSK("PARAMS","DATE_RANGE_3","A","END")=3031231
 ;  RORTSK("PARAMS","DATE_RANGE_3","A","START")=3030101
 ;  RORTSK("PARAMS","ICD9FILT","A","FILTER")="ALL"
 ;  RORTSK("PARAMS","LRGRANGES","C",1)=""
 ;  RORTSK("PARAMS","LRGRANGES","C",1,"H")=50
 ;  RORTSK("PARAMS","LRGRANGES","C",1,"L")=20
 ;  RORTSK("PARAMS","LRGRANGES","C",2)=""
 ;  RORTSK("PARAMS","LRGRANGES","C",2,"H")=60
 ;  RORTSK("PARAMS","LRGRANGES","C",2,"L")=30
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
 ;************************************************************************
RFRANGE(RORTSK) ;
 N RORDATA       ; array to hold ROR data and summary totals
 N RORREG        ; Registry IEN
 N RORSDT        ; report start date
 N ROREDT        ; report end date
 N RORPTIEN      ; IEN of patient in the ROR registry
 N DFN           ; DFN of patient in the PATIENT file (#2)
 N RORLC         ; sub-file and array of LOINC codes to search Lab data
 N RORCDLIST     ; Flag to indicate whether a clinic or division list exists
 N RORCDSTDT     ; Start date for clinic/division utilization search
 N RORCDENDT     ; End date for clinic/division utilization search
 ;
 N REPORT,RC,I,SFLAGS,PARAMS
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
 S RC=$$PARAMS^RORX020A(PARAMS,.RORDATA) Q:RC<0 RC
 ;
 ;--- Put report header data into output:
 ;report creation date, task number, last registry update date, and
 ;last data extraction date
 S RC=$$HEADER^RORX020A(REPORT,.RORTSK) Q:RC<0 RC
 ;
 ;--- Get Renal ranges requested
 ;I=1 ==> report = CrCL      I=2 ==> report = eGFR by MDRD
 S I=0 F  S I=$O(RORTSK("PARAMS","LRGRANGES","C",I)) Q:I=""  D
 . S RORDATA("L",I)=$G(RORTSK("PARAMS","LRGRANGES","C",I,"L")) ;low range
 . S RORDATA("H",I)=$G(RORTSK("PARAMS","LRGRANGES","C",I,"H")) ;high range
 ;
 ;--- Get GMRV VITAL TYPE pointer for HEIGHT
 S RORDATA("HGTP")=$$GETIEN^GMVGETVT("HEIGHT",1)
 I '$G(RORDATA("HGTP")) Q -1
 ;
 ;--- Get Max Date  OUTPUT: RORDATA("DATE")  - Max Date for test scores
 S RORDATA("DATE")=$$PARAM^RORTSK01("OPTIONS","MAX_DATE")
 I $G(RORDATA("DATE"))="" S RORDATA("DATE")=DT
 ;
 ;--- Summary vs. complete report requested
 S RORDATA("COMPLETE")=0 ;default to 'summary' only
 I $$PARAM^RORTSK01("OPTIONS","COMPLETE") S RORDATA("COMPLETE")=1
 ;
 ;--- Set the number of Renal ranges and initialize their values to 0
 S RORDATA("RCNT")=5 D INIT^RORX020A(.RORDATA)
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
 ;--- LOINC codes for Creatinine
 ;create list for future comparison
 S RORDATA("LOINC")=";15045-8;21232-4;2160-0;"
 ;set up array for future call to Lab API
 S RORLC="CH" ;chemistry sub-file to search in #63
 S RORLC(1)="15045-8^LN" ;Creatinine LOINC
 S RORLC(2)="21232-4^LN" ;Creatinine LOINC
 S RORLC(3)="2160-0^LN"  ;Creatinine LOINC
 ;
 ;--- RACE code 2054-5 = 'black or african american' in RACE file (IEN=9)
 S RORDATA("BAM")=";9;"
 ;
 ;=== Set up Clinic/Division list parameters
 S RORCDLIST=$$CDPARMS^RORXU001(.RORTSK,.RORCDSTDT,.RORCDENDT,1)
 ;
 ;--- Get registry records
 N RCC,FLAG,SKIP,TMP
 S (CNT,RORPTIEN,RC)=0
 S FLAG=$G(RORTSK("PARAMS","ICD9FILT","A","FILTER"))
 F  S RORPTIEN=$O(^RORDATA(798,"AC",RORREG,RORPTIEN))  Q:RORPTIEN'>0  D  Q:RC<0
 . ;--- Calculate 'progress' for the GUI display
 . S TMP=$S(RORPTCNT>0:CNT/RORPTCNT,1:"")
 . S RC=$$LOOP^RORTSK01(TMP)  Q:RC<0
 . S CNT=CNT+1
 . ;--- Get the patient DFN
 . S DFN=$$PTIEN^RORUTL01(RORPTIEN)  Q:DFN'>0
 . ;--- Check for patient list and quit if not on list
 . I $D(RORTSK("PARAMS","PATIENTS","C")),'$D(RORTSK("PARAMS","PATIENTS","C",DFN)) Q
 . ;--- Check if the patient should be skipped
 . Q:$$SKIP^RORXU005(RORPTIEN,SFLAGS,SKIPSDT,SKIPEDT)
 . ;--- Check if patient has passed the ICD9 filter
 . S RCC=0
 . I FLAG'="ALL" D
 . . S RCC=$$ICD^RORXU010(DFN,RORREG)
 . I (FLAG="INCLUDE")&(RCC=0) Q
 . I (FLAG="EXCLUDE")&(RCC=1) Q
 . ;
 . ;--- Check for Clinic or Division list and quit if not in list
 . I RORCDLIST,'$$CDUTIL^RORXU001(.RORTSK,DFN,RORCDSTDT,RORCDENDT) Q
 . ;
 . ;--- Check for utilization in the corresponding 'utilization' date range
 . S SKIP=0 I $G(UTSDT)>0 D
 .. N UTIL K TMP S TMP("ALL")=1
 .. S UTIL=+$$UTIL^RORXU003(UTSDT,UTEDT,DFN,.TMP)
 .. I 'UTIL S SKIP=1
 . ;--- Skip the patient if they have no utilization in the range
 . I $G(SKIP) Q
 . ;
 . ;--- For each patient, process the registry record and create report
 . I $$PATIENT(DFN,RORBODY,.RORDATA,RORPTIEN,.RORLC)<0 S ECNT=ECNT+1 ;error count
 ;
 ;--- If user selected eGFR by MDRD (ID=2), create summary report
 I RORDATA("IDLST")[2 S RC=$$SUMMARY^RORX020A(RORTSK,REPORT,.RORDATA)
 Q:RC<0 RC
 K ^TMP("RORX020",$J),^TMP("ROROUT",$J)
 Q $S(RC<0:RC,ECNT>0:-43,1:0)
 ;
 ;************************************************************************
 ;ADD THE PATIENT DATA TO THE REPORT
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
 ;calculate Renal Function scores
 I $$CALCRF(DFN,.RORDATA,RORPTIEN,.RORLC)<0 Q 1  ;quit if patient data not available
 I '$$INRANGE^RORX020A(.RORDATA) Q 1  ;quit if score(s) out of requested range
 ;if eGFR by MDRD requested, add 1 to appropriate category count
 I RORDATA("IDLST")[2 D EGFRCAT^RORX020A(.RORDATA)
 Q:'RORDATA("COMPLETE") 1  ;continue only if 'complete' report is requested
 ;--- Get patient data and put into the report
 N VADM,VA,RORDOD,TTAG,RTAG
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
 ;--- RENAL DATA tag
 S RTAG=$$ADDVAL^RORTSK11(RORTSK,"RNLDATA",,PTAG)
 Q:RTAG<0 RTAG
 ;---  CR Test Tag
 S TTAG=$$ADDVAL^RORTSK11(RORTSK,"TEST",,RTAG)
 Q:TTAG<0 TTAG
 ;---  Date Cr Test Taken
 D ADDVAL^RORTSK11(RORTSK,"DATE",$G(RORDATA("CRDATE")),TTAG)
 ;---  Cr Test Value
 D ADDVAL^RORTSK11(RORTSK,"RESULT",$G(RORDATA("CR")),TTAG)
 ;--- Height tag
 S TTAG=$$ADDVAL^RORTSK11(RORTSK,"HEIGHT",,RTAG)
 Q:TTAG<0 TTAG
 ;---  Date Height Taken
 D ADDVAL^RORTSK11(RORTSK,"DATE",$G(RORDATA("HDATE")),TTAG)
 ;---  Height value
 D ADDVAL^RORTSK11(RORTSK,"RESULT",$G(RORDATA("HGT")),TTAG)
 ;---  Calculated CRCL
 I RORDATA("IDLST")[1 D ADDVAL^RORTSK11(RORTSK,"CRCL",$G(RORDATA("SCORE",1)),PTAG,3)
 ;---  Calculated eGFR
 I RORDATA("IDLST")[2 D ADDVAL^RORTSK11(RORTSK,"EGFR",$G(RORDATA("SCORE",2)),PTAG,3)
 ;
 Q ($S(TTAG<0:TTAG,1:1))
 ;
 ;************************************************************************
 ;CALCULATE THE RENAL FUNCTION VALUE(S)
 ;Note1: If no range has been passed in and a patient has a Creatinine 
 ;       result > 12, the patient will be listed on the report with an 
 ;       asterisk (*) next to the test result value, but no scores will be 
 ;       calculated.
 ;Note2: If no range has been passed in and a patient has an invalid Height
 ;       result, the patient will be listed on the report with an asterisk (*)
 ;       next to the test result value, but no CrCl score will be calculated. 
 ;Note3: If a range has been passed in and the patient has a Creatinine result 
 ;       >12, the patient will NOT be listed on the report.
 ;
 ;INPUT
 ;  DFN      Patient DFN in PATIENT file (#2)
 ;  RORDATA  Array with ROR data
 ;           RORDATA("BAM") - 'black' or 'african american' race pointers
 ;  RORPTIEN Patient IEN in the ROR registry
 ;  RORLC    sub-file and LOINC codes to search for
 ;  
 ;OUTPUT
 ;  RORDATA  Array with ROR data
 ;  1        Patient will be listed on report
 ; -1        Patient will not be listed on report
 ;************************************************************************
CALCRF(DFN,RORDATA,RORPTIEN,RORLC) ;
 N RORID,RORST,ROREND,RORLAB,RORMSG,RC
 S RORDATA("CALC")=1 ;default - the score for this patient should be calculated
 K RORDATA("SCORE",1),RORDATA("SCORE",2) ;test scores
 K RORDATA("CVAL"),RORDATA("CINV"),RORDATA("CR"),RORDATA("CRDATE") ;Cr data
 K RORDATA("HGT"),RORDATA("HDATE") ;height data
 ;get patient ICN or SSN
 S RORID=$$PTID^RORUTL02(DFN)
 Q:'$G(RORID) -1
 ;---SET UP LAB API INPUT/OUTPUT PARMS---
 S RORST="2000101^CD" ;start date 1/1/1900
 S ROREND=$G(RORDATA("DATE"))\1 ;end date
 ;add 1 to the end date so the Lab API INCLUDES tests on that date
 N X1,X2,X3 S X1=ROREND,X2=1 D C^%DTC S ROREND=X K X,X1,X2
 S ROREND=ROREND_"^CD"
 S RORLAB=$NA(^TMP("ROROUT",$J)) ;lab API output global
 K RORMSG,@RORLAB ;initialize prior to call
 ;---CALL LAB API USING COLLECTION DATE AND LOINC CODE LIST---
 S RC=$$GCPR^LA7QRY(RORID,RORST,ROREND,.RORLC,"*",.RORMSG,RORLAB)
 I $G(RC)="",$D(RORMSG)>1  D  ;quit if error returned
 . N ERR,I,LST,TMP
 . S (ERR,LST)=""
 . F I=1:1  S ERR=$O(RORMSG(ERR))  Q:ERR=""  D
 . . S LST=LST_","_ERR,TMP=RORMSG(ERR)
 . . K RORMSG(ERR)  S RORMSG(I)=TMP
 . S LST=$P(LST,",",2,999)  Q:(LST=3)!(LST=99)
 . S RC=$$ERROR^RORERR(-27,,.RORMSG,RORPTIEN)
 I RC<0 Q -1
 ;Note: the Lab API returns data in the form of HL7 segments
 N TMP,RORSPEC,RORVAL,RORNODE,RORSEG,SEGTYPE,RORLOINC,RORDONE,RORDATE,FS
 S FS="|" ;default HL7 field separator for lab data
 S RORDONE=0 ;flag to indicate if 'valid' data has been found
 S RORNODE=0 F  S RORNODE=$O(^TMP("ROROUT",$J,RORNODE)) Q:((RORNODE="")!(RORDONE))  D
 . S RORSEG=$G(^TMP("ROROUT",$J,RORNODE)) ;get entire HL7 segment
 . S SEGTYPE=$P(RORSEG,FS,1) ;get segment type (PID,OBR,OBX,etc.)
 . Q:SEGTYPE'="OBX"  ;we want OBX segments only
 . S RORSPEC=$P($P(RORSEG,FS,4),U,2) ;specimen type string (urine, serum, etc.)
 . S RORSPEC=":"_RORSPEC_":" ;append ":" as prefix and suffix
 . I ((RORSPEC[":UA:")!(RORSPEC[":UR:")) Q  ;quit if specimen type is urine
 . S RORLOINC=$P($P(RORSEG,FS,4),"^",1) ;get LOINC code
 . Q:(RORDATA("LOINC")'[(";"_RORLOINC_";"))  ;LOINC must match Creatinine
 . ;test result found
 . S RORVAL=$P(RORSEG,FS,6) ;Creatinine test result value
 . Q:($G(RORVAL)'>0)  ;quit if no value
 . S RORDATE=$$HL7TFM^XLFDT($P(RORSEG,FS,15)) ;get date collected
 . S RORDATE=RORDATE\1
 . ;store 'valid' (12 or less) value if no 'valid' value has been stored yet
 . I RORVAL'>12,$O(RORDATA("CVAL",0))="" S RORDATA("CVAL",RORDATE)=RORVAL,RORDONE=1 Q
 . ;store 'invalid' (>12) value if no other value has been stored
 . I RORVAL>12,$O(RORDATA("CVAL",0))="",$O(RORDATA("CINV",0))="" D
 .. S RORDATA("CINV",RORDATE)=$G(RORVAL)_"*" ;mark as 'invalid' value
 ;
 ;quit if patient had no Creatinine results (valid or invalid)
 Q:(($D(RORDATA("CVAL"))'>1)&($D(RORDATA("CINV"))'>1)) -1
 ;
 ;--- set Creatinine result and date into data array
 N DATE
 S DATE=$O(RORDATA("CVAL",0)) ;'valid' Cr date
 I $G(DATE)="" D  ;if no 'valid' Cr value, get 'invalid' value
 . S DATE=$O(RORDATA("CINV",0))
 . S RORDATA("CVAL",DATE)=$G(RORDATA("CINV",DATE))
 . S RORDATA("CALC")=0 ;no score calculations can be done on 'invalid' data
 S RORDATA("CR")=$G(RORDATA("CVAL",DATE))
 ;S RORDATA("CRDATE")=$P((9999999-$G(DATE)),".",1)
 S RORDATA("CRDATE")=DATE\1
 ;
 ;--- get height date and height IEN
 N RORHTDT,RORHTIEN,RORARY
 S RORDATE=RORDATA("DATE")
 S RORHTDT=$O(^PXRMINDX(120.5,"PI",DFN,RORDATA("HGTP"),RORDATE),-1) ;height date
 Q:$G(RORHTDT)="" -1
 S RORHTIEN=$O(^PXRMINDX(120.5,"PI",DFN,RORDATA("HGTP"),RORHTDT,0)) ;height IEN
 Q:$G(RORHTIEN)="" -1
 ;--- call API to get get height measurement
 K RORARY D EN^GMVPXRM(.RORARY,RORHTIEN,"I")
 S RORDATA("HGT")=$G(RORARY(7)),RORDATA("HDATE")=$P(RORHTDT,".",1)
 I ($G(RORDATA("HGT"))'>0) Q -1  ;quit if height not > 0
 ;strip out characters "IN", ",E"
 I ((RORDATA("HGT")["IN")!(RORDATA("HGT")[",E")) S RORDATA("HGT")=+RORDATA("HGT")
 ;mark as 'invalid' if height contains "CM", or "'" or double quote
 I ((RORDATA("HGT")["CM")!(RORDATA("HGT")["'")!(RORDATA("HGT")["""")) D
 . I RORDATA("IDLST")[1 S RORDATA("CALC")=0 ;no CrCl calculations can be done on 'invalid' data
 . S RORDATA("HGT")=RORDATA("HGT")_"*" ;mark as 'invalid' value
 ;set CALC flag to 0 and add "*" if invalid height: not between 36 and 96 inches
 I ((RORDATA("HGT")'["*")&((RORDATA("HGT")<36)!(RORDATA("HGT")>96))) D
 . I RORDATA("IDLST")[1 S RORDATA("CALC")=0 ;no CrCl calculations can be done on 'invalid' data
 . S RORDATA("HGT")=RORDATA("HGT")_"*" ;mark as 'invalid' value
 ;
 ;include patient on reports but don't calculate score if no high/low
 ;range passed in and invalid CR data exists
 I RORDATA("CR")["*",RORDATA("RANGE")=0 Q 1
 ;don't include patient on report if range IS passed in and invalid Cr data
 ;exists since neither score can't be calculated
 I RORDATA("CR")["*",RORDATA("RANGE")=1 Q -1
 ;
 ;---CALCULATE RENAL TEST SCORES USING VALID CR VALUE
 ;
 ;--- get patient race, gender, age, and dob using DEM^VADPT
 N RORDEM,RORGENDER,RORRACE,RORM,RORF,RORAGE,VAROOT
 S (RORF,RORM)=0
 S VAROOT="RORDEM" D DEM^VADPT
 S RORGENDER=$P($G(RORDEM(5)),U,1) ;M or F
 Q:$G(RORGENDER)="" -1
 S:RORGENDER="F" RORF=1 S:RORGENDER="M" RORM=1
 ;--- get age
 ;if 'most recent' date, use age returned from DEM^VADPT
 ;if not 'most recent', calculate age
 I $$PARAM^RORTSK01("OPTIONS","MOST_RECENT") S RORAGE=RORDEM(4)
 E  S RORAGE=$$AGE^RORX019A(DFN,RORDATE)
 ;
 ;--- Cockcroft-Gault CrCl ---
 ;Calculation: (140-age) x ideal weight in kg (*.85 if female)/(creatinine*72)
 ;Ideal weight in kg:
 ;  males   = 51.65+(1.85*(height-60))
 ;  females = 48.67+(1.65*(height-60))
 ;  
 N RORMIW,RORFIW,MULT2,TMP
 D
 . ;if male, use this calculation
 . I RORM=1 D  ;get male ideal weight in kg 
 .. S MULT2=1 ;no additional multiplier if male
 .. Q:RORDATA("HGT")["*"  ;quit if invalid height value
 .. S RORMIW=51.65+(1.85*(RORDATA("HGT")-60)) ;male ideal weight
 .. S TMP=(140-RORAGE)*RORMIW/(RORDATA("CR")*72) ;CrCl score
 . ;if female, use this calculation
 . I RORF=1 D
 .. S MULT2=.742 ;set multiplier for eGFR calculation if female
 .. Q:RORDATA("HGT")["*"  ;quit if invalid height value
 .. S RORFIW=48.67+(1.65*(RORDATA("HGT")-60)) ;female ideal weight
 .. S TMP=(140-RORAGE)*RORFIW*.85/(RORDATA("CR")*72) ;CrCl score
 . ;
 . I RORDATA("IDLST")[1 S RORDATA("SCORE",1)=$S($G(TMP)>0:$J($G(TMP),0,0),1:"") ;round CrCl score to whole number
 ;
 ;--- eGFR by MDRD ---
 ;default race multiplier set to 1 (i.e. no multiplier)
 N RORCNT,MULT1,I S MULT1=1
 D
 . ;get count of race values (could be more than 1 entry)
 . S RORCNT=$G(RORDEM(12)) I RORCNT>0 D
 .. ;check each race value for match on 'black or 'african american'
 .. F I=1:1:RORCNT D  Q:MULT1=1.212
 ... S RORRACE=$P($G(RORDEM(12,I)),U,1) ;race pointer value
 ... ;if any of the race values are black or african american, set multiplier
 ... I $G(RORDATA("BAM"))[(";"_$G(RORRACE)_";") S MULT1=1.212
 . ;--- calculate eGFR by MDRD score  Calculation:
 . ;(175 * (creatinine ^ -1.154) * (age ^ -.203) *1.212 (if black) * .742 (if female)
 . S TMP=175*($$PWR^XLFMTH(RORDATA("CR"),-1.154))*($$PWR^XLFMTH(RORAGE,-0.203))*MULT1*MULT2 ;eGFR
 . ;
 . I RORDATA("IDLST")[2 S RORDATA("SCORE",2)=$J($G(TMP),0,0) ;round eGFR score to whole number
 ;
 Q 1
