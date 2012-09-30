RORX020B ;BPOIFO/ACS - RENAL FUNCTION BY RANGE RPT (cont) ; 9/1/11 2:13pm
 ;;1.5;CLINICAL CASE REGISTRIES;**15**;Feb 17, 2006;Build 27
 ;
 ; This routine uses the following IAs:
 ;
 ; #4290         ^PXRMINDX(120.5 (controlled)
 ; #3647         $$EN^GMVPXRM (controlled)
 ; #10061        DEM^VADPT (supported)
 ; #3556         GCPR^LA7QRY (supported)
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
 N RORXXX,RORRACES
 S RORDATA("CALC")=1 ;default - the score for this patient should be calculated
 K RORDATA("SCORE",1),RORDATA("SCORE",2),RORDATA("SCORE",3) ;test scores
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
 ;---  construct race array
 K RORRACES
 S RORCNT=$G(RORDEM(12)) I RORCNT>0 D
 .F RORXXX=1:1:RORCNT D
 ..S RORRACES($P($G(RORDEM(12,RORXXX)),U,1))=""
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
 ;---  eGFR by CKD-EPI ---
 ;141*MIN(RORDATA("CR")/(.7 if female;.9 if male))**(-0.329 if female; -0.411 if male)*max(RORDATA("CR")/(.7 if female;.9 if male))**AGE*(1.018 if female)*(1.159 if black)
 I RORDATA("IDLST")[3 D
 .N RORFX
 .S RORFX(1)=$S(RORGENDER="F":.7,1:.9)
 .S RORFX(2)=$S(RORGENDER="F":-.329,1:-.411)
 .S RORFX(3)=$S(RORGENDER="F":1.018,1:1)
 .S RORFX(4)=$S($D(RORRACES(9)):1.159,1:1)
 .S RORFX(5)=RORDATA("CR")/RORFX(1)
 .S TMP=141*($$PWR^XLFMTH($$MIN^XLFMTH(RORFX(5),1),RORFX(2)))*($$PWR^XLFMTH($$MAX^XLFMTH(RORFX(5),1),-1.209))*($$PWR^XLFMTH(.993,RORAGE))*(RORFX(3))*(RORFX(4))
 .S RORDATA("SCORE",3)=$J($G(TMP),0,0)
 ;
 Q 1
