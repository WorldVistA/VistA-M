RORX019A ;BPOIFO/ACS - LIVER SCORE BY RANGE (CONT.) ;11/1/09
 ;;1.5;CLINICAL CASE REGISTRIES;**10,13,14**;Feb 17, 2006;Build 24
 ;
 ; This routine uses the following IAs:
 ;
 ; #10105 $$LN^XLFMTH (supported)
 ; #3556  GCPR^LA7QRY (supported)
 ; #10061 DEM^VADPT   (supported)
 ;
 ;******************************************************************************
 ;******************************************************************************
 ;                 --- ROUTINE MODIFICATION LOG ---
 ;        
 ;PKG/PATCH    DATE        DEVELOPER    MODIFICATION
 ;-----------  ----------  -----------  ----------------------------------------
 ;ROR*1.5*10   MAR  2010   A SAUNDERS   Routine created
 ;ROR*1.5*13   DEC  2010   A SAUNDERS   Moved tag CALCMLD to this routine
 ;ROR*1.5*14   APR  2011   A SAUNDERS   Added logic to calculate the APRI and
 ;                                      FIB4 scores.
 ;                                      
 ;******************************************************************************
 ;******************************************************************************
 Q
 ;
 ;*****************************************************************************
 ;OUTPUT REPORT 'RANGE' PARAMETERS, SET UP REPORT ID LIST (EXTRINISIC FUNCTION)
 ;
 ; PARTAG        Reference (IEN) to the parent tag
 ;
 ; Return Values:
 ;        RORDATA("IDLST") - list of IDs for tests requested
 ;       <0  Error code
 ;        0  Ok
 ;*****************************************************************************
PARAMS(PARTAG,RORDATA,RORTSK) ;
 N PARAMS,DESC,TMP,RC S RC=0
 ;--- Lab test ranges
 S RORDATA("RANGE",1)=0 ;initialize MELD to 'no range passed in'
 S RORDATA("RANGE",2)=0 ;initialize MELD Na to 'no range passed in'
 S RORDATA("RANGE",3)=0 ;initialize APRI to 'no range passed in'
 S RORDATA("RANGE",4)=0 ;initialize FIB4 to 'no range passed in'
 I $D(RORTSK("PARAMS","LRGRANGES","C"))>1  D  Q:RC<0 RC
 . N GRC,ELEMENT,NODE,RTAG,RANGE
 . S NODE=$NA(RORTSK("PARAMS","LRGRANGES","C"))
 . S RTAG=$$ADDVAL^RORTSK11(RORTSK,"LRGRANGES",,PARTAG)
 . S (GRC,RC)=0
 . F  S GRC=$O(@NODE@(GRC))  Q:GRC'>0  D  Q:RC<0
 .. S RANGE=0,DESC=$$RTEXT(GRC,.RORDATA,.RORTSK) ;get range description
 .. S ELEMENT=$$ADDVAL^RORTSK11(RORTSK,"LRGRANGE",DESC,RTAG) ;add desc to output
 .. I ELEMENT<0 S RC=ELEMENT Q
 .. D ADDATTR^RORTSK11(RORTSK,ELEMENT,"ID",GRC)
 .. ;add test ID to the test ID 'list'
 .. S RORDATA("IDLST")=$G(RORDATA("IDLST"))_$S($G(RORDATA("IDLST"))'="":","_GRC,1:GRC)
 .. ;--- Process the range values
 .. S TMP=$G(@NODE@(GRC,"L"))
 .. I TMP'="" D  S RANGE=1
 ... D ADDATTR^RORTSK11(RORTSK,ELEMENT,"LOW",TMP) S RORDATA("RANGE",GRC)=1
 .. S TMP=$G(@NODE@(GRC,"H"))
 .. I TMP'="" D  S RANGE=1
 ... D ADDATTR^RORTSK11(RORTSK,ELEMENT,"HIGH",TMP) S RORDATA("RANGE",GRC)=1
 .. I RANGE D ADDATTR^RORTSK11(RORTSK,ELEMENT,"RANGE",1)
 ;if user didn't select any tests, default to both tests
 ;I $G(RORDATA("IDLST"))="" S RORDATA("IDLST")="1,2" ;user must select a report in PATCH 12
 ;--- Success
 Q RC
 ;
 ;*****************************************************************************
 ;RETURN RANGE TEXT, ADD RANGE VALUES TO RORDATA (EXTRINISIC FUNCTION)
 ;
 ;INPUT:
 ;  GRC   Test ID number
 ;        ID=1: MELD
 ;        ID=2: MELD-Na
 ;        ID=3: APRI
 ;        ID=4: FIB4
 ;  RORDATA - Array with ROR data
 ;  RORTSK  - Task parameters
 ;
 ;OUTPUT:
 ;  RORDATA(ID,"L") - test ID low range
 ;  RORDATA(ID,"H") - test ID high range
 ;  Description - <range>
 ;*****************************************************************************
RTEXT(GRC,RORDATA,RORTSK) ;
 N RANGE,TMP
 S RANGE=""
 ;--- Range
 I $D(RORTSK("PARAMS","LRGRANGES","C",GRC))>1 D
 . ;--- Low
 . S TMP=$G(RORTSK("PARAMS","LRGRANGES","C",GRC,"L"))
 . S RORDATA(GRC,"L")=$G(TMP)
 . S:TMP'="" RANGE=RANGE_" not less than "_TMP
 . ;--- High
 . S TMP=$G(RORTSK("PARAMS","LRGRANGES","C",GRC,"H"))
 . S RORDATA(GRC,"H")=$G(TMP)
 . I TMP'=""  D:RANGE'=""  S RANGE=RANGE_" not greater than "_TMP
 . . S RANGE=RANGE_" and"
 ;--- Description
 S TMP=$G(RORTSK("PARAMS","LRGRANGES","C",GRC))
 S:TMP="" TMP="Unknown ("_GRC_")"
 Q TMP_" - "_$S(RANGE'="":"numeric results"_RANGE,1:"all results")
 ;
 ;************************************************************************
 ;CALCULATE THE MELD SCORE(S) - MELD AND MELD-NA
 ;
 ;INPUT
 ;  DFN      Patient DFN in LAB DATA file (#63)
 ;  PTAG     Reference IEN to the 'body' parent XML tag
 ;  RORDATA  Array with ROR data
 ;           RORDATA("FIELDS") - Field list for retrieving the test results
 ;  RORPTIEN Patient IEN in the ROR registry
 ;  RORLC    sub-file and LOINC codes to search for
 ;           
 ;OUTPUT
 ;  RORDATA  Array with ROR data
 ;           RORDATA("BILI")=RESULT^DATE   - Bilirubin result and date
 ;           RORDATA("CR")=RESULT^DATE     - Creatinine result and date
 ;           RORDATA("INR")=RESULT^DATE    - INR result and date
 ;           RORDATA("NA")=RESULT^DATE     - Sodium result and date
 ;           RORDATA("SCORE",1)            - MELD score
 ;           RORDATA("SCORE",2)            - MELD-Na score
 ;
 ;    1      Patient should appear on report
 ;   -1      Patient should NOT appear on report
 ;   
 ;   NOTE: the 'invalid' results will be stored as 'backup' results, in
 ;   case no valid result is found for Creatinine or Sodium.  An invalid
 ;   creatinine result is >12.  An invalid Sodium result is <100 or >180.
 ;   These results will be displayed on the report if no MELD range was 
 ;   specifically requested by the user, but the score will not be calculated.
 ;   They will not be displayed on the report if the user requested a MELD
 ;   range.
 ;************************************************************************
CALCMLD(DFN,PTAG,RORDATA,RORPTIEN,RORLC) ;
 N RORID,RORST,ROREND,RORLAB,RORMSG,RC
 S RORDATA("CALC")=0,RORDATA("CALCNA")=0 ;don't automatically calculate scores
 K RORDATA("SCORE",1),RORDATA("SCORE",2) ;calculated test scores
 K RORDATA("BVAL"),RORDATA("CVAL"),RORDATA("IVAL"),RORDATA("SVAL") ;test results
 K RORDATA("CINV"),RORDATA("SINV") ;test results
 K RORDATA("BILI"),RORDATA("CR"),RORDATA("INR"),RORDATA("NA") ;test result&date
 ;get patient ICN or SSN
 S RORID=$$PTID^RORUTL02(DFN)
 Q:'$G(RORID) -1
 ;---SET UP LAB API INPUT/OUTPUT PARMS---
 S RORST="2000101^CD" ;start date 1/1/1900
 S ROREND=$G(RORDATA("DATE"))\1 ;end date
 ;add 1 to the end date so the Lab API INCLUDES the end date correctly
 N X1,X2,X3 S X1=ROREND,X2=1 D C^%DTC S ROREND=X K X,X1,X2
 S ROREND=ROREND_"^CD"
 S RORLAB=$NA(^TMP("ROROUT",$J)) ;lab API output global
 K RORMSG,@RORLAB ;initialize prior to call
 ;---CALL LAB API---
 S RC=$$GCPR^LA7QRY(RORID,RORST,ROREND,.RORLC,"*",.RORMSG,RORLAB)
 I RC="",$D(RORMSG)>1  D  ;quit if error returned
 . N ERR,I,LST,TMP
 . S (ERR,LST)=""
 . F I=1:1  S ERR=$O(RORMSG(ERR))  Q:ERR=""  D
 . . S LST=LST_","_ERR,TMP=RORMSG(ERR)
 . . K RORMSG(ERR)  S RORMSG(I)=TMP
 . S LST=$P(LST,",",2,999)  Q:(LST=3)!(LST=99)
 . S RC=$$ERROR^RORERR(-27,,.RORMSG,RORPTIEN)
 I RC<0 Q -1
 ;Note: the Lab API returns data in the form of HL7 segments
 N TMP,RORSPEC,RORVAL,RORNODE,RORSEG,SEGTYPE,RORLOINC,RORDONE,RORDATE,RORTEST
 N RORCR,RORBIL,RORSOD,RORINR,FS
 S FS="|" ;HL7 field separator for lab data
 S (RORCR,RORBIL,RORSOD,RORINR,RORDONE,RORNODE)=0
 F  S RORNODE=$O(^TMP("ROROUT",$J,RORNODE)) Q:((RORNODE="")!(RORDONE))  D
 . S RORSEG=$G(^TMP("ROROUT",$J,RORNODE)) ;get entire HL7 segment
 . S SEGTYPE=$P(RORSEG,FS,1) ;get segment type (PID,OBR,OBX,etc.)
 . Q:SEGTYPE'="OBX"  ;we want OBX segments only
 . S RORSPEC=$P($P(RORSEG,FS,4),U,2) ;specimen type string (urine, serum, etc.)
 . S RORSPEC=":"_RORSPEC_":" ;append ":" as prefix and suffix
 . I ((RORSPEC[":UA:")!(RORSPEC[":UR:")) Q  ;quit if specimen type is urine
 . S RORLOINC=$P($P(RORSEG,FS,4),U,1) ;get LOINC code for test
 . S RORVAL=$P(RORSEG,FS,6) ;test result value
 . S RORVAL=$TR(RORVAL,"""","") ;get rid of double quotes around values
 . Q:($G(RORVAL)'>0)  ;quit if no value
 . S RORDATE=$$HL7TFM^XLFDT($P(RORSEG,FS,15)) ;get date collected
 . S RORDATE=RORDATE\1
 . ;---check for Creatinine match on LOINC---
 . I 'RORCR,RORDATA("CR_LOINC")[(";"_RORLOINC_";") D  Q
 .. ;store 'valid' value (12 or less) if no 'valid' value has been stored yet
 .. I RORVAL'>12,$O(RORDATA("CVAL",0))="" S RORDATA("CVAL",RORDATE)=RORVAL,RORCR=1 Q
 .. ;store 'invalid' value (>12) if no other value has been stored
 .. I RORVAL>12,$O(RORDATA("CVAL",0))="",$O(RORDATA("CINV",0))="" D
 ... S RORDATA("CINV",RORDATE)=$G(RORVAL)_"*" ;mark as 'invalid' value
 . ;---check for Sodium match on LOINC---
 . I 'RORSOD,RORDATA("SOD_LOINC")[(";"_RORLOINC_";") D  Q
 .. ;store 'valid' value (100 to 180) if no other 'valid' value has been stored
 .. I RORVAL'<100,RORVAL'>180,$O(RORDATA("SVAL",0))="" D  Q
 ... S RORDATA("SVAL",RORDATE)=$G(RORVAL),RORSOD=1
 .. ;store 'invalid' value (<100 or >180) if no other value has been stored yet
 .. I ((RORVAL<100)!(RORVAL>180)),$O(RORDATA("SVAL",0))="",$O(RORDATA("SINV",0))="" D  Q
 ... S RORDATA("SINV",RORDATE)=RORVAL_"*" Q   ;mark as 'invalid' value
 . ;---check for Bilirubin match on LOINC---
 . I 'RORBIL,RORDATA("BIL_LOINC")[(";"_RORLOINC_";") D  Q
 .. ;store first Bilirubin value
 .. I $O(RORDATA("BVAL",0))="" S RORDATA("BVAL",RORDATE)=RORVAL,RORBIL=1
 . ;---check for INR match on LOINC---
 . I 'RORINR,RORDATA("INR_LOINC")[(";"_RORLOINC_";") D  Q
 .. ;store first INR value
 .. I $O(RORDATA("IVAL",0))="" S RORDATA("IVAL",RORDATE)=RORVAL,RORINR=1
 . ;set flags to indicate if MELD/MELD-NA scores are ready to be calculated for this patient
 . I RORCR,RORBIL,RORINR S RORDATA("CALC")=1 D
 .. I RORDATA("IDLST")=1 S RORDONE=1 Q
 .. I RORSOD S RORDATA("CALCNA")=1,RORDONE=1
 ;
 ;if patient doesn't have data for either score, don't put them on report
 I '$G(RORDATA("CALC")),'$G(RORDATA("CALCNA")) Q -1
 ;--- put test result and test date into RORDATA(<test_name>)=result^date
 N DATE
 S DATE=$O(RORDATA("BVAL",0)) ;Bilirubin
 S RORDATA("BILI")=$S($G(DATE)="":U,1:$G(RORDATA("BVAL",DATE))_U_$G(DATE))
 S DATE=$O(RORDATA("CVAL",0)) ;Creatinine
 I $G(DATE)="" D  ;if regular Creatinine value is null, take invalid value
 . S DATE=$O(RORDATA("CINV",0)) I $G(DATE)>0 S RORDATA("CVAL",DATE)=$G(RORDATA("CINV",DATE))
 S RORDATA("CR")=$S($G(DATE)="":U,1:$G(RORDATA("CVAL",DATE))_U_$G(DATE))
 S DATE=$O(RORDATA("IVAL",0)) ;INR
 S RORDATA("INR")=$S($G(DATE)="":U,1:$G(RORDATA("IVAL",DATE))_U_$G(DATE))
 S DATE=$O(RORDATA("SVAL",0)) ;Sodium
 I $G(DATE)="" D  ;if regular Sodium value is null, take invalid value
 . S DATE=$O(RORDATA("SINV",0)) I $G(DATE)>0 S RORDATA("SVAL",DATE)=$G(RORDATA("SINV",DATE))
 S RORDATA("NA")=$S($G(DATE)="":U,1:$G(RORDATA("SVAL",DATE))_U_$G(DATE))
 ;
 N TEST,BILI,CR,INR,NA
 ;set lower limits for Bili, Cr, and INR to 1 if there's a value in there
 F TEST="BILI","CR","INR" D
 . S @TEST=$P($G(RORDATA(TEST)),U,1) Q:$G(@TEST)["*"  I $G(@TEST),@TEST<1 S @TEST=1
 ;for valid creatinine, use max=4 for calculations
 I $G(CR)'["*" D
 . I $G(CR)>4 S CR=4
 S NA=$P($G(RORDATA("NA")),U,1)
 ;for valid sodium, use min=120, max=135 for calculations
 I $G(NA)'["*" D
 . I $G(NA)>135 S NA=135 Q
 . I $G(NA)'="" I NA<120 S NA=120
 ;
 N TMP1,TMP2
 ;RORDATA("SCORE",1) will hold the calculated MELD score
 ;RORDATA("SCORE",2) will hold the calculated MELD Na score
 S (RORDATA("SCORE",1),RORDATA("SCORE",2))="" ;init calculated scores to null
 D
 . Q:($G(CR)["*")  ;quit if no calculation should occur
 . I $G(BILI),$G(CR),$G(INR) D
 .. ;MELD forumula: (.957*lne(Cr) + .378*lne(Bili) + 1.120*lne(Inr) + .643) * 10
 .. S TMP1=(.957*($$LN^XLFMTH(CR))+(.378*($$LN^XLFMTH(BILI)))+(1.120*($$LN^XLFMTH(INR)))+.643)*10
 .. S RORDATA("SCORE",1)=$J($G(TMP1),0,0) ;round MELD to whole number
 .. Q:($G(NA)["*")  ;quit if no calculation should occur
 .. ;if meld NA requested, sodium test must have a valid value
 .. I $G(NA),RORDATA("SCORE",1),RORDATA("IDLST")[2 D
 ... ;MELD-Na forumula: MELD + (1.59 *(135-Na))
 ... S TMP2=$G(RORDATA("SCORE",1))+(1.59*(135-NA))
 ... S RORDATA("SCORE",2)=$J($G(TMP2),0,0)
 Q 1
 ;************************************************************************
 ;CALCULATE THE FIBROSIS SCORE(S) - APRI and FIB4
 ;
 ;INPUT
 ;  DFN      Patient DFN in LAB DATA file (#63)
 ;  PTAG     Reference IEN to the 'body' parent XML tag
 ;  RORDATA  Array with ROR data
 ;           RORDATA("FIELDS") - Field list for retrieving the test results
 ;  RORPTIEN Patient IEN in the ROR registry
 ;  RORLC    sub-file and LOINC codes to search for
 ;           
 ;OUTPUT
 ;  RORDATA  Array with ROR data
 ;           RORDATA("AST")=RESULT^DATE   - AST result and date
 ;           RORDATA("PLAT")=RESULT^DATE  - Platelet result and date
 ;           RORDATA("ALT")=RESULT^DATE   - ALT result and date
 ;           RORDATA("SCORE",3)           - calculated APRI score
 ;           RORDATA("SCORE",4)           - calculated FIB4 score
 ;    1      Patient should appear on report
 ;   -1      Patient should NOT appear on report
 ;   
 ;************************************************************************
CALCFIB(DFN,PTAG,RORDATA,RORPTIEN,RORLC) ;
 N RORID,RORST,ROREND,RORLAB,RORMSG,RC
 S RORDATA("CALCAPRI")=0,RORDATA("CALCFIB4")=0 ;don't automatically calculate scores
 K RORDATA("SCORE",3),RORDATA("SCORE",4) ;calculated test scores
 K RORDATA("SVAL"),RORDATA("PVAL"),RORDATA("LVAL") ;test results
 K RORDATA("ALT"),RORDATA("PLAT"),RORDATA("AST") ; tes result and date
 ;get patient ICN or SSN
 S RORID=$$PTID^RORUTL02(DFN)
 Q:'$G(RORID) -1
 ;---SET UP LAB API INPUT/OUTPUT PARMS---
 S RORST="2000101^CD" ;start date 1/1/1900
 S ROREND=$G(RORDATA("DATE"))\1 ;end date
 ;add 1 to the end date so the Lab API INCLUDES the end date correctly
 N X1,X2,X3 S X1=ROREND,X2=1 D C^%DTC S ROREND=X K X,X1,X2
 S ROREND=ROREND_"^CD"
 S RORLAB=$NA(^TMP("ROROUT",$J)) ;lab API output global
 K RORMSG,@RORLAB ;initialize prior to call
 ;---CALL LAB API TO GET TEST RESULTS---
 S RC=$$GCPR^LA7QRY(RORID,RORST,ROREND,.RORLC,"*",.RORMSG,RORLAB)
 I RC="",$D(RORMSG)>1  D  Q -1 ;quit if error returned
 . N ERR,I,LST,TMP
 . S (ERR,LST)=""
 . F I=1:1  S ERR=$O(RORMSG(ERR))  Q:ERR=""  D
 . . S LST=LST_","_ERR,TMP=RORMSG(ERR)
 . . K RORMSG(ERR)  S RORMSG(I)=TMP
 . S LST=$P(LST,",",2,999)  Q:(LST=3)!(LST=99)
 . S RC=$$ERROR^RORERR(-27,,.RORMSG,RORPTIEN)
 I RC<0 Q -1
 ;Note: the Lab API returns data in the form of HL7 segments
 N TMP,RORSPEC,RORVAL,RORNODE,RORSEG,SEGTYPE,RORLOINC,RORDONE,RORDATE,RORTEST
 N RORAST,RORPLAT,RORALT,FS
 S FS="|" ;HL7 field separator for lab data
 S (RORAST,RORPLAT,RORALT,RORDONE,RORNODE)=0
 F  S RORNODE=$O(^TMP("ROROUT",$J,RORNODE)) Q:((RORNODE="")!(RORDONE))  D
 . S RORSEG=$G(^TMP("ROROUT",$J,RORNODE)) ;entire HL7 segment
 . S SEGTYPE=$P(RORSEG,FS,1) ;segment type (PID,OBR,OBX,etc.)
 . Q:SEGTYPE'="OBX"  ;test results are in the OBX segment
 . S RORSPEC=$P($P(RORSEG,FS,4),U,2) ;specimen type (urine, serum, etc.)
 . S RORSPEC=":"_RORSPEC_":" ;append ":" as prefix and suffix
 . I ((RORSPEC[":UA:")!(RORSPEC[":UR:")) Q  ;quit if specimen type is urine
 . S RORLOINC=$P($P(RORSEG,FS,4),U,1) ;LOINC code for test
 . S RORVAL=$P(RORSEG,FS,6) ;test result value
 . S RORVAL=$TR(RORVAL,"""","") ;get rid of double quotes around values
 . Q:($G(RORVAL)'>0)  ;quit if no value
 . S RORDATE=$$HL7TFM^XLFDT($P(RORSEG,FS,15)) ;get date collected
 . S RORDATE=RORDATE\1
 . ;test results will be stored in RORDATA("SVAL"),RORDATA("PVAL"), and RORDATA("LVAL")
 . ;---check for AST match on LOINC if not yet found and store it---
 . I 'RORAST,RORDATA("AST_LOINC")[(";"_RORLOINC_";") D  Q
 .. S RORDATA("SVAL",RORDATE)=RORVAL,RORAST=1 Q
 . ;---check for Platelet match on LOINC if not yet found and store it---
 . I 'RORPLAT,RORDATA("PLAT_LOINC")[(";"_RORLOINC_";") D  Q
 .. S RORDATA("PVAL",RORDATE)=$G(RORVAL),RORPLAT=1
 . ;---check for ALT match on LOINC if not yet found and store it---
 . I 'RORALT,RORDATA("ALT_LOINC")[(";"_RORLOINC_";") D  Q
 .. S RORDATA("LVAL",RORDATE)=RORVAL,RORALT=1
 . ;set flags to indicate if APRI/FIB4 scores are ready to be calculated for this patient
 . I RORAST,RORPLAT S RORDATA("CALCAPRI")=1 D
 .. I RORDATA("IDLST")=3 S RORDONE=1 ;done if APRI is the only score requested
 .. I RORALT S RORDATA("CALCFIB4")=1,RORDONE=1
 ;
 ;if patient doesn't have data for either score, then they shouldn't show up on report
 I '$G(RORDATA("CALCAPRI")),'$G(RORDATA("CALCFIB4")) Q -1
 ;--- put test result and test date into RORDATA(<test_name>)=result^date
 N DATE
 S DATE=$O(RORDATA("SVAL",0)) ;AST
 S RORDATA("AST")=$S($G(DATE)="":U,1:$G(RORDATA("SVAL",DATE))_U_$G(DATE))
 S DATE=$O(RORDATA("PVAL",0)) ;Platelet
 S RORDATA("PLAT")=$S($G(DATE)="":U,1:$G(RORDATA("PVAL",DATE))_U_$G(DATE))
 S DATE=$O(RORDATA("LVAL",0)) ;ALT
 S RORDATA("ALT")=$S($G(DATE)="":U,1:$G(RORDATA("LVAL",DATE))_U_$G(DATE))
 ;--- get just the test result values from array
 N TEST,AST,PLAT,ALT
 F TEST="AST","PLAT","ALT" S @TEST=$P($G(RORDATA(TEST)),U,1)
 ;--- calculate APRI/FIB4 scores
 N TMP1,TMP2
 ;RORDATA("SCORE",3) will hold the calculated APRI score
 ;RORDATA("SCORE",4) will hold the calculated FIB4 score
 S (RORDATA("SCORE",3),RORDATA("SCORE",4))="" ;init calculated scores to null
 S RC=1
 I $G(AST),$G(PLAT) D
 . I RORDATA("IDLST")[3 D  ;calculate APRI score: [AST/ULNAST/PLAT] * 100
 .. S TMP1=(AST/RORDATA("ULNAST")/PLAT)*100
 .. S RORDATA("SCORE",3)=$J($G(TMP1),0,2) ;round to 2 decimal points
 . I $G(ALT),RORDATA("IDLST")[4 D  ;calculate FIB4 score: (AGE*AST)/[(PLAT*ALT) to 1/2 power]
 .. N AGE S AGE=$$AGE(DFN,RORDATA("DATE")) ;get patient age
 .. I '$G(AGE) S RC=-1 Q  ;quit if age can't be calculated
 .. S TMP2=(AGE*AST)/$$PWR^XLFMTH((PLAT*ALT),.5)
 .. S RORDATA("SCORE",4)=$J($G(TMP2),0,0) ;round to whole number
 Q RC
 ;
 ;************************************************************************
 ;CALCULATE PATIENT AGE - EXTRINSIC FUNCTION
 ;
 ;INPUT
 ;  DFN      Patient DFN in PATIENT file (#2)
 ;  DATE     user-selected date for report calculations
 ;
 ;OUTPUT
 ;  Patient age is returned
 ;************************************************************************
AGE(DFN,DATE) ;
 ;--- get patient dob and dod using DEM^VADPT
 N RORDEM,RORDOB,RORDOD,RORAGE,VAROOT
 S VAROOT="RORDEM" D DEM^VADPT
 S RORDOB=$P($G(RORDEM(3)),U,1) ;date of birth
 S RORAGE=$P($G(RORDEM(4)),U,1) ;age as of today (DT)
 S RORDOD=$P($G(RORDEM(6)),U,1) ;date of death
 I DATE=DT Q $G(RORAGE)  ;if 'most recent' date, return age in API results
 ;compare DOD and user-selected 'as of' DATE
 I $G(RORDOD),$G(RORDOD)<DATE S DATE=RORDOD\1 ;use DOD if earlier than DATE
 S RORAGE=DATE-RORDOB ;calculate age
 S RORAGE=$S($L(RORAGE)=6:$E($G(RORAGE),1,2),1:$E($G(RORAGE),1,3))
 Q $G(RORAGE)
