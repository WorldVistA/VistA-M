ICPTCOD ;ALB/DEK/KER - CPT CODE APIS ;11/29/2007
 ;;6.0;CPT/HCPCS;**6,12,13,14,16,19,40**;May 19, 1997;Build 6
 ;
 ; External References
 ;   DBIA  10103  $$DT^XLFDT
 ;                         
 Q
CPT(CODE,CDT,SRC,DFN) ; returns basic info on CPT/HCPCS code
 ;
 ; Input:   CODE   CPT/HCPCS or IEN (Required)
 ;          CDT    Date  (default = TODAY)
 ;          SRC    Screen source
 ;                   If '$G(SRC), check Level I and II codes only
 ;                   If $G(SRC), check Level I, II, and III codes
 ;          DFN    Not in use, future need
 ; 
 ; Output:  Returns a 10 piece string delimited ^
 ; 
 ;            1  IEN of code in ^ICPT
 ;            2  CPT Code (.01 field)
 ;            3  Versioned Short Name (from #61 multiple)
 ;            4  Category IEN (#3 field)
 ;            5  Source (#6 field) C:CPT; H:HCPCS; L:VA LOCAL
 ;            6  Effective Date (from #60 multiple)
 ;            7  Status (from #60 multiple)
 ;            8  Inactivation Date (from #60 multiple)
 ;            9  Activation Date (from #60 multiple)
 ;           10  Message (CODE TEXT MAY BE INACCURATE)
 ; 
 ;            or 
 ; 
 ;           -1^Error Description
 ; 
 N DATA,EFF,STR,VCPT
 I $G(CODE)="" S STR="-1^NO CODE SELECTED" G CPTQ
 S CODE=$G(CODE),CODE=$S(CODE?1.N:+CODE,1:$$CODEN(CODE))
 I CODE<1!'$D(^ICPT(CODE)) S STR="-1^NO SUCH ENTRY" G CPTQ
 I '$G(SRC),$P(^ICPT(CODE,0),"^",6)="L" S STR="-1^VA LOCAL CODE SELECTED" G CPTQ
 S DATA=$G(^ICPT(CODE,0))
 I '$L(DATA) S STR="-1^NO DATA" G CPTQ
 S CDT=$S($G(CDT)="":$$DT^XLFDT,1:$$DTBR^ICPTSUPT(CDT))
 S VCPT=$$VSTCP(CODE,CDT)
 S STR=CODE_"^"_DATA,$P(STR,"^",5)=$P(STR,"^",7),STR=$P(STR,"^",1,5)
 S EFF=$$EFF^ICPTSUPT(81,CODE,CDT) S:EFF<1 $P(EFF,"^",2)=0
 S STR=STR_"^"_EFF_"^"_$$MSG^ICPTSUPT(CDT) S:$L(VCPT) $P(STR,"^",3)=VCPT
CPTQ Q STR
 ;
CPTD(CODE,OUTARR,DFN,CDT) ; Returns CPT description
 ;
 ; Input:   CODE   CPT/HCPCS code or IEN (Required)
 ;          OUTARR Output Array Name for description
 ;                   e.g. "ABC" or "ABC("TEST")" 
 ;                   Default = ^TMP("ICPTD",$J)
 ;          DFN    Not in use, future need
 ;          CDT    Date (default = TODAY)
 ; 
 ; Output:  #      Number of lines in description
 ; 
 ;          @OUTARR(1:n) - Versioned Description (lines 1-n) (from the 62 multiple)
 ;          @OUTARR(n+1) - blank
 ;          @OUTARR(n+1) - a message stating: CODE TEXT MAY BE INACCURATE
 ; 
 ;           or
 ; 
 ;          -1^Error Description
 ;
 ; ** NOTE - User must initialize ^TMP("ICPTD",$J), if used **
 ;
 N ARR,END,I,N,CTV
 I $G(CODE)="" S N="-1^NO CODE SELECTED" G CPTDQ
 I $G(OUTARR)="" S OUTARR="^TMP(""ICPTD"",$J,"
 I OUTARR'["(" S OUTARR=OUTARR_"("
 I OUTARR[")" S OUTARR=$P(OUTARR,")")
 S END=$E(OUTARR,$L(OUTARR)) I END'="("&(END'=",") S OUTARR=OUTARR_","
 I OUTARR="^TMP(""ICPTD"",$J," K ^TMP("ICPTD",$J)
 S CODE=$S(CODE?1.N:+CODE,1:$$CODEN(CODE)),I=0,N=0
 I CODE<1!'$D(^ICPT(CODE)) S N="-1^NO SUCH CODE" G CPTDQ
 S CDT=$S($G(CDT)="":$$DT^XLFDT,1:$$DTBR^ICPTSUPT(CDT))
 D VLTCP(+CODE,CDT,.CTV) S (N,I)=0 F  S I=$O(CTV(I)) Q:+I=0  D
 . S N=N+1,ARR=OUTARR_N_")",@ARR=$$TRIM($G(CTV(I)))
 I +N>0 S N=N+1,ARR=OUTARR_N_")",@ARR=" ",N=N+1,ARR=OUTARR_N_")",@ARR=$$MSG^ICPTSUPT(CDT,1)
 I +N'>0 S N="-1^VERSIONED DESCRIPTION NOT FOUND FOR MODIFIER "_$P($G(^DIC(81.3,+CODE,0)),"^",1)
CPTDQ Q N
 ;
CODM(CODE,OUTARR,SRC,CDT,DFN) ; returns list of modifiers for a code
 ; 
 ; Input:   CODE  CPT/HCPCS code, Internal or External Format (Required)
 ;          ARY   Array Name for list returned
 ;                  e.g. "ABC" or "ABC("TEST")"
 ;                  Default = ^TMP("ICPTM",$J)
 ;          SRC   Source Screen
 ;                  If 0 or Null, check Level I/II code/modifiers
 ;                  If >0, check Level I/II/III code/modifiers
 ;          CDT   Date (default = TODAY)
 ;          DFN   Not in use, future need
 ; 
 ; Output:  #     Number of modifiers that apply
 ; 
 ;          OUTARR Array in the format: 
 ; 
 ;                 ARY(Mod) = Versioned Name^Mod IEN 
 ; 
 ;                 Where
 ;                   Mod is the .01 field)
 ;                   Versioned Name is 1 field of the 61 multiple
 ; 
 ;           or 
 ; 
 ;           -1^Error Description
 ; 
 ;   ** NOTE - User must initialize ^TMP("ICPTM",$J) array if used **
 ;
 N ARR,CODI,CODA,BR,END,ER,MD,MDST,MI,MN,STR,CODEC,ACTMD,MVST
 S CDT=$G(CDT)
 I $G(CODE)="" S STR="-1^NO CPT SELECTED" G CODMQ
 I $G(OUTARR)="" S OUTARR="^TMP(""ICPTM"",$J,"
 S STR=0,CODI=$S(CODE?1.N:+CODE,1:$$CODEN(CODE))
 I CODI<1!'$D(^ICPT(CODI,0)) S STR="-1^NO SUCH CODE" G CODMQ
 I '$G(SRC),$P(^ICPT(CODI,0),"^",6)="L" S STR="-1^VA LOCAL CODE SELECTED" G CODMQ
 S CODEC=$$CODEC(CODI),CODA=$$NUM^ICPTAPIU(CODEC)
 I OUTARR'["(" S OUTARR=OUTARR_"("
 I OUTARR[")" S OUTARR=$P(OUTARR,")")
 S END=$E(OUTARR,$L(OUTARR)) I END'="("&(END'=",") S OUTARR=OUTARR_","
 I OUTARR="^TMP(""ICPTM"",$J," K ^TMP("ICPTM",$J)
 S:$G(CDT)]"" CDT=$$DTBR^ICPTSUPT(CDT)
 S BR="" F  S BR=$O(^DIC(81.3,"M",BR)) Q:BR>CODA!'BR  D
 .S ER="" F  S ER=$O(^DIC(81.3,"M",BR,ER)) Q:'ER  I CODA'>ER D
 ..S MI=0 F  S MI=$O(^DIC(81.3,"M",BR,ER,MI)) Q:'MI  D
 ...N MDPS
 ...S MDST=$G(^DIC(81.3,MI,0)) Q:'$L(MDST)
 ...S MDPS=$$MODP^ICPTMOD(CODE,+MI,"I",$G(CDT),$G(SRC)) Q:+MDPS'>0
 ...I '$G(SRC) Q:$P(MDST,"^",4)="V"
 ...I $G(CDT) S ACTMD="",ACTMD=$$MOD^ICPTMOD(MI,"I",CDT,$G(SRC)) Q:($P(ACTMD,"^")=-1)!($P(ACTMD,"^",7)=0)
 ...S MD=$P(MDST,"^",1,2),MN=$P(MD,"^")
 ...I $L(MN)'=2 Q
 ...S MVST=$$VSTCM^ICPTMOD(MI,CDT)
 ...S ARR=OUTARR_""""_MN_""")",@ARR=MVST_"^"_MI,STR=STR+1
 I 'STR S STR=0
CODMQ Q STR
 ;
CODEN(CODE) ; Rreturn the IEN of a CPT/HCPCS code
 ;
 ;   Input:  CPT/HCPCS code
 ;  Output:  ien of code
 ;
 I $G(CODE)="" Q -1
 N COD
 S COD=+$O(^ICPT("B",CODE,0))
 Q $S(COD>0:COD,1:-1)
 ;
CODEC(CODE) ; Return the CPT/HCPCS Code
 ;
 ;  Input: IEN of CPT/HCPCS code
 ; Output: CPT/HCPCS code
 ;
 I $G(CODE)="" Q -1
 N Y
 S Y=$P($G(^ICPT(CODE,0)),"^")
 Q $S(Y="":-1,1:Y)
 ;
VALCPT(CODE,CDT,SRC,DFN) ;check if CPT code is valid for selection
 ;
 ; Input:
 ;
 ;    CODE - CPT or HCPCS code, ien or .01 format, REQUIRED
 ;    CTD  - Date, default = today
 ;    SRC  - SCREEN SOURCE
 ;              '$G(SRC) level 1, Level 2 only
 ;              $G(SRC) include level 3
 ;    DFN  - not in use, future need
 ;
 ; Output: STR:  1                  if valid code for selection
 ;              -1^error message    if not selectable
 ;
 N STR
 S CODE=$G(CODE),SRC=$G(SRC),DFN=$G(DFN)
 S CDT=$S($G(CDT)="":$$DT^XLFDT,1:$$DTBR^ICPTSUPT(CDT)) ;date business rules
 S STR=$$CPT(CODE,CDT,SRC,DFN)
 I STR<0 G VALCPTQ
 I '$P(STR,"^",7) S STR="-1^INACTIVE CODE"
 I STR>0 S STR=1
VALCPTQ Q STR
 ;
 ;
 Q
VST(IEN,VDATE,TYPE)     ; Versioned Short Text
 Q:TYPE["ICPT(" $$VSTCP($G(IEN),$G(VDATE))
 Q:TYPE["DIC(81.3" $$VSTCM^ICPTMOD($G(IEN),$G(VDATE))
 Q ""
VSTCP(IEN,VDATE) ; Versioned Short Text (CPT Procedure)
 N CPT0,CPTC,CPTI,CPTSTD,CPTSTI,CPTVDT,CPTTXT
 S CPTI=+($G(IEN)) Q:+CPTI'>0 ""  Q:'$D(^ICPT(+CPTI)) ""
 S CPTVDT=$G(VDATE) S:'$L(CPTVDT)!(+CPTVDT'>0) CPTVDT=$$DT^XLFDT Q:CPTVDT\1'?7N ""
 S CPT0=$G(^ICPT(+CPTI,0)),CPTC=$P(CPT0,"^",1) Q:'$L(CPTC) ""
 S CPTSTD=$O(^ICPT("AST",(CPTC_" "),(CPTVDT+.000001)),-1)
 I +CPTSTD>0 D  Q:$L($G(CPTTXT)) $G(CPTTXT)
 . S CPTSTI=$O(^ICPT("AST",(CPTC_" "),CPTSTD,+CPTI," "),-1),CPTTXT=$$TRIM($P($G(^ICPT(+CPTI,61,+CPTSTI,0)),"^",2))
 S CPTSTD=$O(^ICPT(+CPTI,61,"B",0)) I +CPTSTD>0 D  Q:$L($G(CPTTXT)) $G(CPTTXT)
 . S CPTSTI=$O(^ICPT(+CPTI,61,"B",CPTSTD,0)),CPTTXT=$$TRIM($P($G(^ICPT(+CPTI,61,+CPTSTI,0)),"^",2))
 Q $$TRIM($P(CPT0,"^",2))
VLTCP(IEN,VDATE,ARY) ; Versioned Description - Long Text (CPT Procedure)
 N CPT0,CPTC,CPTI,CPTSTD,CPTSTI,CPTVDT,CPTTXT,CPTD,CPTT,CPTE
 S CPTI=+($G(IEN)) Q:+CPTI'>0  Q:'$D(^ICPT(+CPTI))
 S CPTVDT=$G(VDATE) S:'$L(CPTVDT)!(+CPTVDT'>0) CPTVDT=$$DT^XLFDT Q:CPTVDT\1'?7N
 S CPT0=$G(^ICPT(+CPTI,0)),CPTC=$P(CPT0,"^",1) Q:'$L(CPTC)
 S CPTSTD=$O(^ICPT("ADS",(CPTC_" "),(CPTVDT+.000001)),-1)
 I +CPTSTD>0 D  Q:+($O(ARY(0)))>0
 . S CPTSTI=$O(^ICPT("ADS",(CPTC_" "),CPTSTD,+CPTI," "),-1)
 . S (CPTD,CPTT)=0 F  S CPTD=$O(^ICPT(+CPTI,62,CPTSTI,1,CPTD)) Q:+CPTD=0  D
 . . S CPTT=CPTT+1,ARY(CPTT)=$$TRIM($G(^ICPT(+CPTI,62,+CPTSTI,1,+CPTD,0))),ARY(0)=CPTT
 S CPTSTD=$O(^ICPT(+CPTI,62,"B",0)) I +CPTSTD>0 D  Q:+($O(ARY(0)))>0
 . S CPTSTI=$O(^ICPT(+CPTI,62,"B",CPTSTD,0))
 . S (CPTD,CPTT)=0 F  S CPTD=$O(^ICPT(+CPTI,62,CPTSTI,1,CPTD)) Q:+CPTD=0  D
 . . S CPTT=CPTT+1,ARY(CPTT)=$$TRIM($G(^ICPT(+CPTI,62,+CPTSTI,1,+CPTD,0))),ARY(0)=CPTT
 K ARY S (CPTD,CPTT)=0 F  S CPTD=$O(^ICPT(CPTI,"D",CPTD)) Q:+CPTD=0  D
 . S CPTT=CPTT+1,ARY(CPTT)=$$TRIM($G(^ICPT(CPTI,"D",CPTD,0))),ARY(0)=CPTT
 Q
TRIM(X) ; Trim Spaces
 S X=$G(X) Q:X="" X F  Q:$E(X,1)'=" "  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=" "  S X=$E(X,1,($L(X)-1))
 F  Q:X'["  "  S X=$P(X,"  ",1)_" "_$P(X,"  ",2,229)
 Q X
