ICDGTDRG  ;ALB/ADL/KER - COLLECTION OF DRG APIS ; 04/18/2004
 ;;18.0;DRG Grouper;**7,12,14,17**;Oct 20, 2000
 ;   Collection of API's for accessing new "DRG" level
 ;   of files #80, #80.1, and #80.2.  These new levels
 ;   were added for the Code Set Versioning Project
 ;
GETDRG(CODE,DGNDT,FILE)      ; Get DRG or DRG string associated with a Code
 ;  Input:
 ;     CODE  - IEN number
 ;     DRGDT - Effective date of the Code
 ;     FILE  - File to check : 9 - ICD9 (file #80)
 ;                                   0 - ICD0 (file 80.1)
 ;  Output:
 ;     DRGS - DRG or string of DRG's (delimited
 ;            by "^") or -1 if not defined
 ;
 ;            Effective date or error message; 
 ;            status flag (1=Active;0=Inactive)
 ;            Delimited by ";" because DRG's can be
 ;            multiple and are already delimited by "^"
 ;
 N DRG0,D1,DCS,DCSINF,DRGS,DCSV,DAMDC,DRGFY,DRG,DRGS,DADRGFY,MDC
 S (DRG0,DRGFY,DRGS,DRG,MDC,DAMDC,DADRGFY,DRG0)=""
 I $G(CODE)="" S DRGS="-1;NO CODE SELECTED;0" G GETDRGQ
 I $G(FILE)="" S DRGS="-1;NO FILE INPUT;0" G GETDRGQ
 I $G(DGNDT)="" S DGNDT=DT
 I FILE'=9,FILE'=0 S DRGS="-1;INVALID FILE INPUT;0" G GETDRGQ
 S DGNDT=DGNDT+.001
 ;  ICD Operations/Procedures
 I FILE=0 D
 . I CODE<1!'$D(^ICD0(CODE)) S DRGS="-1;NO SUCH ENTRY;0" Q
 . S DRGFY=$O(^ICD0(CODE,2,"B",+DGNDT),-1),DADRGFY=$O(^ICD0(CODE,2,"B",+$G(DRGFY),DADRGFY)),DAMDC=$O(^ICD0(CODE,2,+DADRGFY,1,"B",ICDMDC,DAMDC))
 . ;If no entry check previous FY
 . I DAMDC'>0 D GETPVMDC^ICDREF
 . F  S DRG=$O(^ICD0(CODE,2,+DADRGFY,1,+DAMDC,1,"B",DRG)) Q:DRG=""  S DRG0=DRG0_DRG_U
 . I DRG0="" S DRGS="-1;NO DRG LEVEL;0"
 . S DRGS=DRG0_";"_DRGFY
 ;  ICD Diagnosis
 I FILE=9 D
 . I CODE<1!'$D(^ICD9(CODE)) S DRGS="-1;NO SUCH ENTRY;0" Q
 . S DRGFY=$O(^ICD9(CODE,3,"B",+DGNDT+.01),-1),DADRGFY=$O(^ICD9(CODE,3,"B",+$G(DRGFY),DADRGFY))
 . F  S DRG=$O(^ICD9(CODE,3,+DADRGFY,1,"B",DRG)) Q:DRG=""  S DRG0=DRG0_DRG_U
 . I DRG0="" S DRGS="-1;NO DRG LEVEL;0"
 . S DRGS=DRG0_";"_DRGFY
 ;
GETDRGQ Q DRGS  ; Exit API GETDRG
 ;
DRG(CODE,EDT)   ; Returns a string of information from the DRG file (#80.2)
 ; Input:   CODE   DRG code, internal or external format (Required)
 ;          CDT    Date to check status for, FileMan format (default = TODAY)
 ;                   If CDT < 10/1/1978, use 10/1/1978
 ;                   If CDT > DT, validate with In/Activation Dates
 ;                   If CDT is year only, use first of the year
 ;                   If CDT is year and month, use first of the month
 ; 
 ; Output:  Returns an 22 piece string delimited by the up-arrow (^), where the
 ;          pieces are:
 ;            1  DRG name (field #.01)
 ;            2  Weight (field #2)
 ;            3  Low Trim (days) (field #3)
 ;            4  High Trim (days) (field #4)
 ;            5  MDC (field #5)
 ;            6  Surgery Flag (field #.06)
 ;            7  <null>
 ;            8  Avg Length of Stay (days) (field 10)
 ;            9  Local Low Trim Days (field #11)
 ;           10  Local High Trim Days (field #12)
 ;           11  <null>
 ;           12  Local Breakeven (field #13)
 ;           13  Activation Date (.01 field of the 66 multiple)
 ;           14  Status (.03 field of the 66 multiple)
 ;           15  Inactivation Date (.01 field of the 66 multiple)
 ;           16  Effective date (.01 field of the 66 multiple)
 ;           17  Internal Entry Number (IEN)
 ;           18  Effective date of CSV (.01 field of the 66 multiple)
 ;           19  Reference (field #900)
 ;           20  Weight (Non Affil) (field #7)
 ;           21  Weight (Int Affil) (field #7.5)
 ;           22  Message
 ; 
 ;            or 
 ; 
 ;           -1^Error Description
 ; 
 N D0,DCS,DFY,DFYINF,DCSINF,DMC1,D1,FYDT,FYMD,ICDFY
 I $G(CODE)="" S STR="-1^NO CODE SELECTED",$P(STR,"^",14)=0 G DRGQ
 I $G(EDT)="" S EDT=DT  ; No date, use today
 S EDT=$$DTBR^ICDAPIU(EDT,2)  ; Verify that date is not earlier that the earliest allowed date per the bus. rule
 S EDT=EDT+.001
 S CODE=$G(CODE),CODE=$S(CODE:+CODE,1:$$CODEN(CODE)) ; GET ien
 I CODE<1!'$D(^ICD(CODE)) S STR="-1^NO SUCH ENTRY",$P(STR,"^",14)=0 G DRGQ
 S D0=^ICD(CODE,0)
 S FYDT=$$DGY2K^DGPTOD0($$FY^DGPTOD0(EDT))+.001 ; get the correct FY in YYY0000 format for the effective date
 S DFY=$O(^ICD(CODE,"FY",FYDT),-1) S:DFY>0 DFYINF=^(DFY,0) I DFY'>0 D  ;date stored in YYY0000 w/YYY = Fiscal Year
 . S DFYINF=U_$P(D0,U,2,4)_U_U_$P(D0,U,9)_U_$P(D0,U,12)_U_$P(D0,U,7)_U_$P(D0,U,8)_U_$P(D0,U,11)
 S DCS=$O(^ICD(CODE,66,"B",EDT),-1),D1=$S(DCS'="":$O(^ICD(CODE,66,"B",DCS,0)),1:0) S DCSINF=$S(D1>0:^ICD(CODE,66,D1,0),1:"")
 I DCSINF="" S DCSINF=U_U_"0"_U_U_$P(D0,U,5,6)  ;if CSV level does not exist, default to info at .01 level with status = inactive
 ;Resolve reference table using "B" cross reference and fiscal year
 ;If ICDFY is not resolved set it to current fiscal year
 S ICDFY=$O(^ICD(CODE,2,"B",EDT+.01),-1),DMC1=""
 S DMC1=$O(^ICD(CODE,2,"B",+$G(ICDFY),DMC1)),DMC1=$P($G(^ICD(CODE,2,+DMC1,0)),U,3)
 S STR=$P(D0,U)_U_$P(DFYINF,U,2,4)_U_$P(DCSINF,U,5,6)_U_U_$P(DFYINF,U,9)_U_$P(DFYINF,U,6,7)
 S STR=STR_U_U_$P(D0,U,12)_U_$P(D0,U,13)_U_$P(DCSINF,U,3)_U_$P(D0,U,15)_U_$P(DCSINF,U)_U_CODE_U_DCS_U_$P(DMC1,U)_U_$P(DFYINF,U,8)_U_$P(DFYINF,U,10)
 ;
DRGQ Q STR
 ;
CODEI(CODE)     ; Returns the IEN of an ICD code
 Q +$O(^ICD9("BA",+CODE,0))
 ;
GETDATE(PATNUM) ; Find the correct "EFFECTIVE DATE" for locating the DRG/ICD/CPT codes
 ;
 ;  Input:    PATNUM - PTF Record Number
 ;  Output:   "effective date" to use
 ;
 N EFFD,PTR
 ;  Census Date
 S PTR=$P($G(^DGPT(PATNUM,0)),U,13) I PTR'="" S EFFD=$P($G(^DG(45.86,PTR,0)),U,1) G:EFFD'="" GDOUT
 ;  Discharge Date
 S EFFD=$P($G(^DGPT(PATNUM,70)),U,1) G:EFFD'="" GDOUT
 ;  Surgery Date
 S EFFD=$P($G(^DGPT(PATNUM,"S",1,0)),U,1) G:EFFD'="" GDOUT
 ;  Movement Date
 S EFFD=$P($G(^DGPT(PATNUM,"M",1,0)),U,10)
 ;  Default TODAY
 I EFFD="" S EFFD=DT
GDOUT Q EFFD
 ;
ISVALID(CODE,EDATE,FILE) ; Is an ICD/CPT code Valid
 ; This is a function call to be used in DIC("S") FileMan
 ; calls to check the validation of a ICD/CPT code
 ; Input:
 ;    CODE   - ICD/CPT code (ien)
 ;    EDATE  - Effective date to be used
 ;    FILE   - File to use: 0 - ICD0; 9 - ICD9
 ;
 ; Output:
 ;    OUT    - 1 if valid; 0 if not
 ;
 N OUT,TEMP
 S OUT=0
 I FILE=0 S TEMP=$$ICDOP^ICDCODE(CODE,EDATE) I TEMP>0,$P(TEMP,U,10) S OUT=1
 I FILE=9 S TEMP=$$ICDDX^ICDCODE(CODE,EDATE) I TEMP>0,$P(TEMP,U,10) S OUT=1
 Q OUT
 ;
DRGD(CODE,OUTARR,DFN,CDT) ; returns CPT description in array
 ; Input:   CODE   ICD Code, Internal or External Format (required)
 ;          ARY    Output Array Name for description 
 ;                   e.g. "ABC" or "ABC("TEST")" 
 ;                   Default = ^TMP("DRGD",$J)
 ;          DFN    Not in use but included in anticipation of future need
 ;          CDT    Date to screen against (default = TODAY)
 ;                   If CDT < 10/1/1978, use 10/1/1978
 ;                   If CDT > DT, use DT
 ;                   If CDT is year only, use first of the year
 ;                   If CDT is year and month only, use first of the month
 ; 
 ; Output:  #      Number of lines in description output array
 ;          @ARY(1:n) - Versioned Description (lines 1-n) (from the 68 multiple)
 ;          @ARY(n+1) - Blank
 ;          @ARY(n+1) - A message stating: CODE TEXT MAY BE INACCURATE
 ; 
 ;           or
 ; 
 ;          -1^Error Description
 ; 
 ; ** NOTE - USER MUST INITIALIZE ^TMP("DRGD",$J), IF USED **
 ;
 N ARR,END,I,N,CTV,IEN
 I $G(CODE)="" S N="-1^NO CODE SELECTED" G DRGDQ
 I $G(OUTARR)="" S OUTARR="^TMP(""DRGD"",$J,"
 I OUTARR'["(" S OUTARR=OUTARR_"("
 I OUTARR[")" S OUTARR=$P(OUTARR,")")
 S END=$E(OUTARR,$L(OUTARR)) I END'="("&(END'=",") S OUTARR=OUTARR_","
 K:OUTARR="^TMP(""DRGD"",$J," ^TMP("DRGD",$J)
 S CODE=$G(CODE),IEN=$S(CODE:+CODE,1:$$CODEN(CODE)),I=0,N=0
 I +IEN<1!('$D(^ICD(IEN))) S N="-1^NO SUCH CODE" G DRGDQ
 S CDT=$S($G(CDT)="":$$DT^XLFDT,1:$$DTBR^ICDAPIU(CDT,2))
 D VLTDR(+IEN,CDT,.CTV) S (N,I)=0 F  S I=$O(CTV(I)) Q:+I=0  D
 . S N=N+1,ARR=OUTARR_N_")",@ARR=$$TRIM($G(CTV(I)))
 I +N>0 S N=N+1,ARR=OUTARR_N_")",@ARR=" ",N=N+1,ARR=OUTARR_N_")",@ARR=$$MSG^ICDAPIU(CDT,2)
 I +N'>0 S N="-1^VERSIONED DESCRIPTION NOT FOUND FOR "_CODE
DRGDQ Q N
 ;
VLTDR(IEN,VDATE,ARY) ; Versioned Description - Long Text
 ; Input:
 ;    IEN    - Internal Entry Number file 80.2
 ;    VDATE  - Effective/Versioning date to be used
 ;    .ARY   - Array for output, passed by reference
 ;
 ; Output:
 ;    ARY()  - Local array containing versioned description
 ;
 N ICD0,ICDC,ICDI,ICDSTD,ICDSTI,ICDVDT,ICDTXT,ICDD,ICDT,ICDE
 S ICDI=+($G(IEN)) Q:+ICDI'>0  Q:'$D(^ICD(+ICDI))
 S ICDVDT=$G(VDATE) S:'$L(ICDVDT)!(+ICDVDT'>0) ICDVDT=$$DT^XLFDT Q:$P(ICDVDT,".",1)'?7N
 S ICD0=$G(^ICD(+ICDI,0)),ICDC=$P(ICD0,"^",1) Q:'$L(ICDC)
 S ICDSTD=$O(^ICD("ADS",(ICDC_" "),(ICDVDT+.000001)),-1)
 I +ICDSTD>0 D  Q:+($O(ARY(0)))>0
 . S ICDSTI=$O(^ICD("ADS",(ICDC_" "),ICDSTD,+ICDI," "),-1)
 . S (ICDD,ICDT)=0 F  S ICDD=$O(^ICD(+ICDI,68,ICDSTI,1,ICDD)) Q:+ICDD=0  D
 . . S ICDT=ICDT+1,ARY(ICDT)=$G(^ICD(+ICDI,68,+ICDSTI,1,+ICDD,0)),ARY(0)=ICDT
 S ICDSTD=$O(^ICD(+ICDI,68,"B"," "),-1) I +ICDSTD>0 D  Q:+($O(ARY(0)))>0
 . S ICDSTI=$O(^ICD(+ICDI,68,"B",ICDSTD,0))
 . S (ICDD,ICDT)=0 F  S ICDD=$O(^ICD(+ICDI,68,ICDSTI,1,ICDD)) Q:+ICDD=0  D
 . . S ICDT=ICDT+1,ARY(ICDT)=$G(^ICD(+ICDI,68,+ICDSTI,1,+ICDD,0)),ARY(0)=ICDT
 K ARY S (ICDD,ICDT)=0 F  S ICDD=$O(^ICD(ICDI,1,ICDD)) Q:+ICDD=0  D
 . S ICDT=ICDT+1,ARY(ICDT)=$G(^ICD(ICDI,1,ICDD,0)),ARY(0)=ICDT
 Q
TRIM(X) ; Trim Spaces
 S X=$G(X) Q:X="" X F  Q:$E(X,1)'=" "  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=" "  S X=$E(X,1,($L(X)-1))
 F  Q:X'["  "  S X=$P(X,"  ",1)_" "_$P(X,"  ",2,229)
 Q X
CODEN(CODE) ; Return the IEN of DRG
 ;   Input:  DRG code
 ;  Output:  IEN of code
 ;
 Q:$G(CODE)="" -1  N COD S COD=+$O(^ICD("B",CODE,0)) Q $S(COD>0:COD,1:-1)
