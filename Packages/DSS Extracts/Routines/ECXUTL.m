ECXUTL ;ALB/JAP - Utilities for DSS Extracts ; 11/23/10 1:58pm
 ;;3.0;DSS EXTRACTS;**1,5,8,84,90,127**;Dec 22, 1997;Build 36
 ;
ECXYM(ECXFMDT) ;extrinsic function
 ;converts any FM internal format date or date/time to a 6-character string
 ;
 ;   input
 ;   ECXFMDT = date or date/time; FM internal format (required)
 ;   output
 ;   ECXYM = YYYYMM string
 ;
 N MONTH,YEAR,CENTURY,ECXYM
 ;
 ;error checks
 I +ECXFMDT'=ECXFMDT S ECXYM="000000" Q ECXYM
 I $L($P(ECXFMDT,"."))'=7 S ECXYM="000000" Q ECXYM
 I +$E(ECXFMDT,4,5)<1!(+$E(ECXFMDT,4,5)>12) S ECXYM="000000" Q ECXYM
 ;
 S MONTH=$E(ECXFMDT,4,5),YEAR=$E(ECXFMDT,2,3),CENTURY=$E(ECXFMDT,1)+17
 S ECXYM=CENTURY_YEAR_MONTH
 Q ECXYM
 ;
ECXYMX(ECXYM) ;extrinsic function
 ;converts a 6-character numeric string of format YYYYMM
 ;to a FM external format date
 ;
 ;   input
 ;   ECXYM = YYYYMM string (required)
 ;   output
 ;   ECXYMX = FM external format date;
 ;            SEP 1997
 ;   error code
 ;   if input problem, then "000000" returned
 ;
 N Y,%DT,CENTURY,FMCENT,ECXYMX
 ;
 ;error checks
 I ECXYM="" S ECXYMX="000000" Q ECXYMX
 I +ECXYM'=ECXYM S ECXYMX="000000" Q ECXYMX
 I $L(ECXYM)'=6 S ECXYMX="000000" Q ECXYMX
 I +$E(ECXYM,1,4)<1800 S ECXYMX="000000" Q ECXYMX
 I +$E(ECXYM,5,6)<1!(+$E(ECXYM,5,6)>12) S ECXYMX="000000" Q ECXYMX
 ;
 S CENTURY=$E(ECXYM,1,2)
 S FMCENT=CENTURY-17
 S Y=FMCENT_$E(ECXYM,3,6) D DD^%DT S ECXYMX=Y
 ;
 ;error checks
 I $L(ECXYMX)'=8 S ECXYMX="000000"
 I "JAN FEB MAR APR MAY JUN JUL AUG SEP OCT NOV DEC"'[$E(ECXYMX,1,3) S ECXYMX="000000"
 Q ECXYMX
 ;
ECXDATE(ECXFMDT,ECXYM) ;extrinsic function
 ;converts any FM internal format date or date/time to a 8-character string
 ;
 ;   input
 ;   ECXFMDT = date or date/time; FM internal format (required)
 ;   ECXYM = YYYYMM; year/month 6-character string (required)
 ;   output
 ;   ECXDATE = YYYYMMDD string
 ;   error code
 ;   "000000" returned, if problem with input
 ;
 N MONTH,YEAR,CENTURY,DAY,ECXDATE
 ;
 ;error checks
 I +ECXYM'=ECXYM S ECXDATE="000000" Q ECXDATE
 I $L(ECXYM)'=6 S ECXDATE="000000" Q ECXDATE
 I +$E(ECXYM,1,4)<1800 S ECXDATE="000000" Q ECXDATE
 I +$E(ECXYM,5,6)<1!($E(ECXYM,5,6)>12) S ECXDATE="000000" Q ECXDATE
 ;special case where ecxfmdt is null; default to year/month of ecxym
 I ECXFMDT="" S ECXDATE=ECXYM_"01" Q ECXDATE
 ;error checks
 I +ECXFMDT'=ECXFMDT S ECXDATE=ECXYM_"01" Q ECXDATE
 I $L(ECXFMDT)<7 S ECXDATE=ECXYM_"01" Q ECXDATE
 I +$E(ECXFMDT,4,5)>12 S ECXDATE=ECXYM_"01" Q ECXDATE
 I +$E(ECXFMDT,6,7)>31 S ECXFMDT=$E(ECXFMDT,1,5)_"01"
 ;default to 1st day of month
 S DAY=$E(ECXFMDT,6,7) S:DAY="00" DAY="01"
 ;default to month of ecxym
 S MONTH=$E(ECXFMDT,4,5) S:MONTH="00" MONTH=$E(ECXYM,5,6)
 S YEAR=$E(ECXFMDT,2,3)
 S CENTURY=$E(ECXFMDT,1)+17
 S ECXDATE=CENTURY_YEAR_MONTH_DAY
 Q ECXDATE
 ;
ECXDATEX(ECXDATE) ;extrinsic function
 ;converts an 8-character numeric string of format YYYYMMDD
 ;to a FM external format date
 ;
 ;   input
 ;   ECXDATE = YYYYMMDD string (required)
 ;   output
 ;   ECXDATEX = FM external format date;
 ;              SEP 12, 1997
 ;   error code
 ;   if input problem, then "000000" returned
 ;
 N Y,%DT,CENTURY,FMCENT,ECXDATEX
 ;
 ;error checks
 I +ECXDATE'=ECXDATE S ECXDATEX="000000" Q ECXDATEX
 I $L(ECXDATE)'=8 S ECXDATEX="000000" Q ECXDATEX
 I +$E(ECXDATE,7,8)>31 S ECXDATEX="000000" Q ECXDATEX
 ;
 S CENTURY=$E(ECXDATE,1,2)
 S FMCENT=CENTURY-17
 S Y=FMCENT_$E(ECXDATE,3,8) D DD^%DT S ECXDATEX=Y
 ;
 ;error checks
 I $L(ECXDATEX)'=12 S ECXDATEX="000000"
 I "JAN FEB MAR APR MAY JUN JUL AUG SEP OCT NOV DEC"'[$E(ECXDATEX,1,3) S ECXDATEX="000000"
 Q ECXDATEX
 ;
ECXDOB(ECXFMDT) ;extrinsic function
 ;converts a FM internal format date or date/time to a 6-character string
 ;if ecxfmdt is null, the function returns 19420101
 ;   input
 ;   ECXFMDT = date or date/time (required); 
 ;             must be valid FM internal format 
 ;   output
 ;   ECXDOB = YYYYMMDD string (required);
 ;            defaults to 19420101
 ;
 N MONTH,YEAR,CENTURY,DAY,ECXDOB
 ;only consider date portion
 S ECXFMDT=$P(ECXFMDT,".",1)
 ;special case where ecxfmdt is null
 I ECXFMDT="" S ECXDOB="19420101" Q ECXDOB
 ;error checks - return default
 I +ECXFMDT'=ECXFMDT S ECXDOB="19420101" Q ECXDOB
 I $L(ECXFMDT)<7 S ECXDOB="19420101" Q ECXDOB
 I +ECXFMDT>DT S ECXDOB="19420101" Q ECXDOB
 ;default to 1st day of month
 S DAY=$E(ECXFMDT,6,7) S:DAY="00"!(+DAY>31) DAY="01"
 ;default to 1st month of year
 S MONTH=$E(ECXFMDT,4,5) S:MONTH="00"!(+MONTH>12) MONTH="01",DAY="01"
 S YEAR=$E(ECXFMDT,2,3)
 S CENTURY=$E(ECXFMDT,1)+17
 S ECXDOB=CENTURY_YEAR_MONTH_DAY
 Q ECXDOB
 ;
ECXTIME(ECXFMDT) ;extrinsic function
 ;converts Fileman internal date/time to 6-character time string
 ;format HHMMSS
 ;
 ;   input
 ;   ECXFMDT = date or date/time (required); 
 ;             must be valid FM internal format
 ;   output
 ;   ECXTIME = 6-character numeric string;
 ;             format HHMMSS; string length always 6
 ;
 N J,JJ,TIME,HH,MM,SS,ECXTIME
 ;if any non-numerics, set default
 I +ECXFMDT=0 S ECXTIME="000300" Q ECXTIME
 ;use only time portion of fileman internal format
 S TIME=$P(ECXFMDT,".",2),TIME=$E(TIME,1,6)
 ;if time unknown, set default
 I TIME="" S ECXTIME="000300" Q ECXTIME
 ;be sure time is 6 characters
 S TIME=$$LJ^XLFSTR(TIME,6,0)
 ;error checks -- set default
 S HH=$E(TIME,1,2),MM=$E(TIME,3,4),SS=$E(TIME,5,6)
 I +HH>23 S ECXTIME="000300" Q ECXTIME
 I +MM>59 S MM="59"
 I +SS>59 S SS="59"
 S ECXTIME=HH_MM_SS
 Q ECXTIME
 ;
ECXTIMEX(ECXTIME,ECXMIL) ;extrinsic function
 ;converts a 6-character time string to external, user readable format
 ;used as output transform for time fields in many dss extract files
 ;   input
 ;   ECXTIME = 6-character numeric string (required); 
 ;   ECXMIL = if "1", then return military time (optional)          
 ;   output
 ;   ECXTIMEX = character string;
 ;              if ECXMIL=1, format HH:MM:SS
 ;              otherwise, hours:mins AM/PM
 ;   error code
 ;   if input problem, then "000000" returned
 ;              
 N TIME,HH,MM,SS,ECXTIMEX,J,JJ
 ;error checks
 I $L(ECXTIME)'=6 S ECXTIMEX="000000" Q ECXTIMEX
 F J=1:1:6 S JJ=$E(ECXTIME,J) I $A(JJ)<48!($A(JJ)>57) S ECXTIMEX="000000" Q
 I $D(ECXTIMEX) Q ECXTIMEX
 S HH=$E(ECXTIME,1,2),MM=$E(ECXTIME,3,4),SS=$E(ECXTIME,5,6)
 I +HH>23!(+MM>59)!(+SS>59) S ECXTIMEX="000000" Q ECXTIMEX
 ;if ecxmil=1, return military time
 I $G(ECXMIL) S ECXTIMEX=HH_":"_MM_":"_SS Q ECXTIMEX
 ;otherwise, use am/pm format
 S X="0."_ECXTIME
 S X=$E($P(X,".",2)_"0000",1,4),%=X>1159 S:X>1259 X=X-1200
 S X=X\100_":"_$E(X#100+100,2,3)_" "_$E("AP",%+1)_"M"
 S ECXTIMEX=X
 Q ECXTIMEX
 ;
AOIRPOW(ECXDFN,ECXAIP) ;get data on ao, ir, pow status
 ;
 ;   input
 ;   ECXDFN = ien in file #2 (required)
 ;   ECXAIP = array for returned data (required)
 ;            (passed by reference)
 ;
 ;   output
 ;   ECXAIP("AO") = agent orange status
 ;   ECXAIP("IR") = ion. radiation status
 ;   ECXAIP("POW") = pow status
 ;   ECXAIP("POWL") = pow location/period
 ;
 N J
 S ECXAIP("AO")="",ECXAIP("IR")="",ECXAIP("POW")="",ECXAIP("POWL")=""
 S ECXAIP("AO")=$P($G(^DPT(ECXDFN,.321)),U,2),ECXAIP("IR")=$P($G(^(.321)),U,3)
 S ECXAIP("POW")=$P($G(^DPT(ECXDFN,.52)),U,5),ECXAIP("POWL")=$P($G(^(.52)),U,6)
 F J="AO","IR","POW" I ECXAIP(J)="" S ECXAIP(J)="U"
 I ECXAIP("POWL"),ECXAIP("POW")'="Y" S ECXAIP("POWL")=""
 Q
 ;
PRVCLASS(PERS,DATE) ;determine the person class and return va code
 ;   input
 ;   PERS  = pointer to file #200 (required)
 ;   DATE  = date on which person class must be active (required)
 ;           (internal Fileman format)
 ;   output
 ;   VACODE = VA code field from file #8932.1
 ;            (exactly 7 characters in length)
 N ECX,VACODE
 S VACODE=""
 S ECHEAD=$G(ECHEAD)
 S ECX=$$GET^XUA4A72(PERS,DATE)
 ;if no person class use alternate date to resolve person class
 I +ECX'>0 D
 .N DATE
 .S DATE=$S(ECHEAD="LAB":$P(EC1,U,14),ECHEAD="LAR":$P(EC1,U,4),ECHEAD="PRE":$P(ECDATA,U,13),ECHEAD="RAD":$P($G(^RAO(75.1,+$G(ECXIEN),0)),U,16),1:"")
 .S ECX=$$GET^XUA4A72(PERS,DATE)
 .Q
 S VACODE=$P(ECX,U,7) I $L(VACODE)'=7 S VACODE=""
 Q VACODE
 ;
PATCAT(DFN) ; Extrinsic function to return OTHER ELIGIBILITY CODE 
 ;            in patcat field in the extract file if the PATIENT TYPE 
 ;            = active duty, retire, tricare
 ;  INPUT DFN - ien in file #2 (required)
 ; OUTPUT PATCAT - Patient Category mapping to be filed in extracts
 ;
 N ELIG,I,PATCAT,PCAT,TYPE
 S PATCAT=""
 I '$G(DFN) Q PATCAT
 S TYPE=$$TYPE^ECXUTL5(DFN)
 I (TYPE="MI")!(TYPE="AC")!(TYPE="TR") D
 .;get first other eligibilty code that matches in list, if it exists
 .S ELIG=0 F  S ELIG=$O(^DPT(DFN,"E",ELIG)) Q:(ELIG'>0)!((ELIG>0)&(PATCAT'=""))  D
 ..; if get last code, use line below
 ..;S ELIG=0 F  S ELIG=$O(^DPT(DFN,"E",ELIG)) Q:(ELIG'>0)  D
 ..S PCAT=$$GET1^DIQ(8,ELIG,.01)
 ..F I=1:1 Q:$T(ELIGCDS+I)=" Q"  I PCAT=$P($T(ELIGCDS+I),";;",2) S PATCAT=$P($T(ELIGCDS+I),";;",3)
 Q PATCAT
 ;
ORDPROV(DFN,ON,PSJTMP) ; get provider using order reference number
 ;  input:  
 ;    dfn
 ;    on     - order reference number
 ;    psjtmp - 1 if temp global node = PSJ1, else global node = PSJ
 ;
 ;  output:
 ;    Provider IEN from PARMACY PATIENT File (#55) (1st piece ^TMP( )
 ;
 ;  NOTE:  Don't kill ^TMP here, used in ECXBCM, killed there
 ;
 I $G(DFN)']"" Q 0
 I $G(ON)']"" Q 0
 D EN^PSJBCMA1(DFN,ON,PSJTMP) ;IA#2829
 Q +($G(^TMP("PSJ",$J,1)))
 ;
ELIGCDS ;
 ;;AD-ACTIVE DUTY;;AD
 ;;REC-RECRUIT;;REC
 ;;ADD-ACTIVE DUTY DEPENDENT;;ADD
 ;;FNRS-NON REMARRIED SPOUSE;;FNRS
 ;;RET-RETIREE;;RET
 ;;RETD-RETIREE DEPENDENT;;RETD
 ;;RES-RESERVIST;;RES
 ;;TFL-TRICARE FOR LIFE;;TFL
 ;;TDRL-TEMPORARY DISABILITY;;TDRL
 Q
