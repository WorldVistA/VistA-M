ICDEXD5 ;SLC/KER - ICD Extractor - DRG APIs (cont) ;12/19/2014
 ;;18.0;DRG Grouper;**57,67**;Oct 20, 2000;Build 1
 ;               
 ; Global Variables
 ;    ^DG(45.86)          ICR   5821
 ;    ^DGPT(              ICR   5822
 ;    ^ICD("ADS")         N/A
 ;    ^ICD("B")           N/A
 ;    ^TMP("DRGD")        SACC 2.3.2.5.1
 ;               
 ; External References
 ;    $$DT^XLFDT          ICR  10103
 ;    $$NOW^XLFDT         ICR  10103
 ;               
 Q
DRG(CODE,CDT)   ; Returns a string of information from the DRG file (#80.2)
 ;
 ; Input:
 ; 
 ;    CODE    DRG code, internal or external format (Required)
 ;    CDT     Date, FileMan format (default = TODAY)
 ;               If CDT < 10/1/1978, use 10/1/1978
 ;               If CDT > DT, validate with In/Activation Dates
 ;               If CDT is year only, use first of the year
 ;               If CDT is year and month, use first of the month
 ; 
 ; Output:  
 ; 
 ;           Returns an 22 piece string delimited by the 
 ;           up-arrow (^) the pieces are:
 ;           
 ;              1  DRG name (field #.01)
 ;              2  Weight (field #2)
 ;              3  Low Trim (days) (field #3)
 ;              4  High Trim (days) (field #4)
 ;              5  MDC (field #5)
 ;              6  Surgery Flag (field #.06)
 ;              7  <null>
 ;              8  Avg Length of Stay (days) (field 10)
 ;              9  Local Low Trim Days (field #11)
 ;             10  Local High Trim Days (field #12)
 ;             11  <null>
 ;             12  Local Breakeven (field #13)
 ;             13  Activation Date (.01 of the 66 multiple)
 ;             14  Status (.03 of the 66 multiple)
 ;             15  Inactivation Date (.01 of the 66 multiple)
 ;             16  Effective date (.01 of the 66 multiple)
 ;             17  Internal Entry Number (IEN)
 ;             18  Effective date (.01 of the 66 multiple)
 ;             19  Reference (field #900)
 ;             20  Weight (Non Affil) (field #7)
 ;             21  Weight (Int Affil) (field #7.5)
 ;             22  Message
 ; 
 ;              or 
 ; 
 ;             -1^Error Description
 ; 
 N D0,DCS,DFY,DFYINF,DCSINF,DMC1,D1,FYDT,FYMD,ICDFY,ICDIMP,STR
 S CDT=$P(CDT,".",1) S:CDT'?7N CDT=DT S CDT=$$DTBR^ICDEX(CDT,2)
 I $G(CODE)="" S STR="-1^NO CODE SELECTED",$P(STR,"^",14)=0 G DRGQ
 S CDT=CDT+.001
 S CODE=$G(CODE),CODE=$S(CODE:+CODE,1:$$DRGN^ICDEX(CODE)) ; GET ien
 I CODE<1!'$D(^ICD(CODE)) S STR="-1^NO SUCH ENTRY",$P(STR,"^",14)=0 G DRGQ
 S D0=^ICD(CODE,0)
 ; Get FY in YYY0000 format for the effective date
 S FYDT=$$EFM^ICDEX($$FY^ICDEX(CDT))+.001
 S DFY=$O(^ICD(CODE,"FY",FYDT),-1) S:DFY>0 DFYINF=^(DFY,0) I DFY'>0 D
 . S DFYINF=U_$P(D0,U,2,4)_U_U_$P(D0,U,9)_U_$P(D0,U,12)_U_$P(D0,U,7)_U_$P(D0,U,8)_U_$P(D0,U,11)
 S DCS=$O(^ICD(CODE,66,"B",CDT),-1),D1=$S(DCS'="":$O(^ICD(CODE,66,"B",DCS,0)),1:0) S DCSINF=$S(D1>0:^ICD(CODE,66,D1,0),1:"")
 ; If CSV does not exist, default to info
 ; at .01 level with status = inactive
 I DCSINF="" S DCSINF=U_U_"0"_U_U_$P(D0,U,5,6)
 ; Resolve using "B" cross reference and fiscal year
 ; If ICDFY is not resolved set it to current fiscal year
 S ICDFY=$O(^ICD(CODE,2,"B",CDT+.01),-1),DMC1=""
 S DMC1=$O(^ICD(CODE,2,"B",+$G(ICDFY),DMC1)),DMC1=$P($G(^ICD(CODE,2,+DMC1,0)),U,3)
 S STR=$P(D0,U)_U_$P(DFYINF,U,2,4)_U_$P(DCSINF,U,5,6)_U_U_$P(DFYINF,U,9)_U_$P(DFYINF,U,6,7)
 S STR=STR_U_U_$P(D0,U,12)_U_$P(D0,U,13)_U_$P(DCSINF,U,3)_U_$P(D0,U,15)_U_$P(DCSINF,U)_U_CODE_U_DCS_U_$P(DMC1,U)_U_$P(DFYINF,U,8)_U_$P(DFYINF,U,10)
 ;
DRGQ ; DRG Quit on Error
 Q STR
 Q
DRGDES(IEN,CDT,ARY,LEN) ; Returns DRG Description in Array
 ;
 ; Input: 
 ; 
 ;    IEN     Internal Entry Number of DRG file 80.2
 ;    CDT     Date to screen against (default = TODAY)
 ;   .ARY     Output Array passed by reference
 ;    LEN     Length of each array node
 ;              Missing        Defaults to 79
 ;              Less than 25   Defaults to 25
 ; Output:
 ; 
 ;    $$DRGD  Number of lines in description output array
 ;    
 ;    ARY     Description in array of length specified
 ;
 N ICDI,ICDED,ICDID,ICDD,ICDL,ICDN,ICDT,N
 K ARY S ICDL=$G(LEN) S:+ICDL'>0 ICDL=79 S:ICDL<25 ICDL=25
 S ICDI=+($G(IEN)) S:ICDI'>0 ICDI=$$DRGN^ICDEX(IEN)
 I +($G(IEN))'>0!('$D(^ICD(IEN))) S N="-1^DRG ENTRY NOT FOUND" G DRGDQ
 S ICDD=$S($G(CDT)="":$$DT^XLFDT,1:$$DTBR^ICDEX(CDT,2))
 S ICDED=$O(^ICD(+IEN,68,"B",(ICDD+.001)),-1)
 S ICDID=$O(^ICD(+IEN,68,"B",+ICDED," "),-1)
 S ICDN=0 F  S ICDN=$O(^ICD(+IEN,68,+ICDID,ICDN)) Q:+ICDN'>0  D
 . N ICDC S ICDT=$$TM($G(^ICD(+ICDI,68,+ICDID,1,+ICDN,0))) Q:'$L(ICDT)
 . S ICDC=$O(ARY(" "),-1)+1,ARY(ICDC)=ICDT,ARY(0)=ICDC
 D:+($G(ARY(0)))>0 PAR^ICDEX(.ARY,+($G(ICDL)))
 S:+($O(ARY(" "),-1))>0 ARY(0)=+($O(ARY(" "),-1))
 Q $G(ARY(0))
DRGD(CODE,OUTARR,CDT) ; returns CPT description in array
 ;
 ; Input: 
 ; 
 ;    CODE    ICD Code, Internal or External Format (required)
 ;    ARY     Output Array Name for description 
 ;              e.g. "ABC" or "ABC("TEST")" 
 ;              Default = ^TMP("DRGD",$J)
 ;    CDT     Date to screen against (default = TODAY)
 ;              If CDT < 10/1/1978, use 10/1/1978
 ;              If CDT > DT, use DT
 ;              If CDT is year only, use first of the year
 ;              If CDT is year/month only, use first of the month
 ; 
 ; Output:
 ; 
 ;    $$DRGD  Number of lines in description output array
 ;    
 ;    ARY     Description in array
 ;    
 ;              @ARY(1:n) - Description (lines 1-n) (field 68)
 ;              @ARY(n+1) - Blank
 ;              @ARY(n+1) - Message: CODE TEXT MAY BE INACCURATE
 ; 
 ;            or
 ; 
 ;              -1^Error Description
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
 S CODE=$G(CODE),IEN=$S(CODE:+CODE,1:$$DRGN^ICDEX(CODE)),I=0,N=0
 I +IEN<1!('$D(^ICD(IEN))) S N="-1^NO SUCH CODE" G DRGDQ
 S CDT=$S($G(CDT)="":$$DT^XLFDT,1:$$DTBR^ICDEX(CDT,2))
 D VLTDR(+IEN,CDT,.CTV) S (N,I)=0 F  S I=$O(CTV(I)) Q:+I=0  D
 . S N=N+1,ARR=OUTARR_N_")",@ARR=$$TM($G(CTV(I)))
 I +N>0 S N=N+1,ARR=OUTARR_N_")",@ARR=" ",N=N+1,ARR=OUTARR_N_")",@ARR=$$MSG^ICDEX(CDT,2)
 I +N'>0 S N="-1^VERSIONED DESCRIPTION NOT FOUND FOR "_CODE
DRGDQ ; DRG Description Quit
 Q N
 Q
GETDATE(IEN) ; Calculate Effective Date from the PTF
 ; 
 ;
 ;  Input: 
 ;  
 ;     IEN        Internal Entry Number of the PTF file #45
 ;     
 ;  Output:   
 ;  
 ;     $$GETDATE  Returns the correct "EFFECTIVE DATE" 
 ;                for a patient to uses retrieving and
 ;                calculating DRG/ICD/CPT data (default
 ;                TODAY)
 ;                
 ;                Derived from:
 ;                  Census Date      ^DGPT         0;13
 ;                  Discharge Date   ^DG(45.86     0;1
 ;                  Surgery Date     ^DGPT(D0,"S"  0;1
 ;                  Movement Date    ^DGPT(D0,"M"  0;10
 ;  
 N ICDI,ICDE,ICDP,ICDT S ICDT=$$NOW^XLFDT
 S ICDI=+($G(IEN)) Q:'$D(^DGPT(ICDI,0)) ICDT
 S ICDP=$P($G(^DGPT(ICDI,0)),U,13) I ICDP'="" D  Q:ICDE'="" ICDE
 . S ICDE=$P($G(^DG(45.86,ICDP,0)),U,1)
 S ICDE=$P($G(^DGPT(ICDI,70)),U,1) Q:ICDE'="" ICDE
 S ICDE=$P($G(^DGPT(ICDI,"S",1,0)),U,1) Q:ICDE'="" ICDE
 S ICDE=$P($G(^DGPT(ICDI,"M",1,0)),U,10)
 S:'$L(ICDE) ICDE=ICDT
 Q ICDE
VLTDR(IEN,CDT,ARY) ; Versioned Description - Long Text
 ;
 ; Input:
 ; 
 ;    IEN      Internal Entry Number file 80.2
 ;    CDT      Effective/Versioning date to be used
 ;    .ARY     Array for output, passed by reference
 ;
 ; Output:
 ; 
 ;    ARY()    Local array containing versioned description
 ;
 N ICD0,ICDC,ICDI,ICDSTD,ICDSTI,ICDVDT,ICDTXT,ICDD,ICDT,ICDE
 S ICDI=+($G(IEN)) Q:+ICDI'>0  Q:'$D(^ICD(+ICDI))
 S ICDVDT=$G(CDT) S:'$L(ICDVDT)!(+ICDVDT'>0) ICDVDT=$$DT^XLFDT Q:$P(ICDVDT,".",1)'?7N
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
TM(X) ; Trim Spaces
 S X=$G(X) Q:X="" X F  Q:$E(X,1)'=" "  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=" "  S X=$E(X,1,($L(X)-1))
 F  Q:X'["  "  S X=$P(X,"  ",1)_" "_$P(X,"  ",2,229)
 N ICDOP
 Q X
CARD(X) ; Implants/Insertion Cardio Device (EN1^ICDDRG5)
 N SO S X="^" S:$D(ICDOP(" 00.50")) $P(X,"^",2)=1 S:$D(ICDOP(" 00.52"))&($D(ICDOP(" 00.53"))) $P(X,"^",2)=1
 I $D(ICDOP(" 37.70"))!($D(ICDOP(" 37.71")))!($D(ICDOP(" 37.73"))) D  Q X
 . N SO F SO="37.80","37.81","37.82","37.85","37.86","37.87" S:$D(ICDOP((" "_SO))) $P(X,"^",2)=1
 I $D(ICDOP(" 37.72")) D  Q X
 . S:$D(ICDOP(" 37.80"))!($D(ICDOP(" 37.83"))) $P(X,"^",2)=1
 I $D(ICDOP(" 37.74")) D  Q X
 . N SO F SO="37.80","37.81","37.82","37.83","37.85","37.86","37.87" S:$D(ICDOP((" "_SO))) $P(X,"^",2)=1
 I $D(ICDOP(" 37.76")) D  Q X
 . N SO F SO="37.80","37.85","37.86","37.87" S:$D(ICDOP((" "_SO))) $P(X,"^",2)=1
 I $D(ICDOP(" 00.53")) D
 . N SO F SO="37.70","37.71","37.72","37.73","37.74","37.76" S:$D(ICDOP((" "_SO))) $P(X,"^",2)=1
 N SO F SO="00.54","37.95","37.96","37.97","37.98","00.52" S:$D(ICDOP((" "_SO))) $P(X,"^",1)=1
 Q X
SPIN(X) ; Paired Spinal Fusion Codes (EN1^ICDDRG8)
 N SP,ICDA,ICDB S (ICDA,ICDB,X)=0
 F SO="81.02","81.04","81.06","81.32","81.34","81.36" S:$D(ICDOP((" "_SO))) ICDA=1
 F SO="81.03","81.05","81.07","81.08","81.33","81.35","81.37","81.38" S:$D(ICDOP((" "_SO))) ICDB=1
 S:ICDA&(ICDB) X=1
 Q X
