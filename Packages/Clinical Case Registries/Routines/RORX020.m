RORX020 ;BPOIFO/ACS - RENAL FUNCTION BY RANGE ; 6/2/11 4:19pm
 ;;1.5;CLINICAL CASE REGISTRIES;**10,13,14,15**;Feb 17, 2006;Build 27
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
 ;ROR*1.5*15   JUN  2011   C RAY        Added calculation for eGRF by CKD-EPI
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
 ;--- If user selected eGFR by MDRD (ID=2) or eGFR by CKD-EPI (ID=3), create summary report
 I RORDATA("IDLST")[2!(RORDATA("IDLST")[3) S RC=$$SUMMARY^RORX020A(RORTSK,REPORT,.RORDATA)
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
 I $$CALCRF^RORX020B(DFN,.RORDATA,RORPTIEN,.RORLC)<0 Q 1  ;quit if patient data not available
 I '$$INRANGE^RORX020A(.RORDATA) Q 1  ;quit if score(s) out of requested range
 ;if eGFR by MDRD requested, add 1 to appropriate category count
 I RORDATA("IDLST")[2 D MDRDCAT^RORX020A(.RORDATA)
 ;if eGFR by CKD-EPI requested, add 1 to appropriate category count
 I RORDATA("IDLST")[3 D CKDCAT^RORX020A(.RORDATA)
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
 ;---  Calculated eGFR by MDRD
 I RORDATA("IDLST")[2 D ADDVAL^RORTSK11(RORTSK,"MDRD",$G(RORDATA("SCORE",2)),PTAG,3)
 ;---  Calculated eGFR by CKD-EPI
 I RORDATA("IDLST")[3 D ADDVAL^RORTSK11(RORTSK,"CKD",$G(RORDATA("SCORE",3)),PTAG,3)
 Q ($S(TTAG<0:TTAG,1:1))
 ;
