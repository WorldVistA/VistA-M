ICPTMOD ;ALB/DEK/KER - CPT MODIFIER APIS ;08/18/2007
 ;;6.0;CPT/HCPCS;**6,12,13,14,19,30,37**;May 19, 1997;Build 25
 ;             
 ; Global Variables
 ;    ^DIC(81.3
 ;    ^TMP("ICPTD"     SACC 2.3.2.5.1
 ;             
 ; External References
 ;    $$DT^XLFDT       DBIA  10103
 ;             
 ; External References
 ;
 Q
MOD(MOD,MFT,MDT,SRC,DFN) ;  returns basic info on CPT MODIFIERs
 ;
 ; Input:   MOD   Modifier, Internal or External (Required)
 ;          MFT   Format  "I"=IEN  "E"=.01 field (Default)
 ;          MDT   Version Date, FileMan format (default = TODAY)
 ;          SRC   Source Screen
 ;                  If 0 or Null, Level I and II only
 ;                  If >0, Level I, II, and III
 ;          DFN   Not used
 ; 
 ; Output:  10 piece string delimited by the up-arrow (^)
 ; 
 ;            1  IEN
 ;            2  Modifier (0;1)
 ;            3  Versioned Name (61, 0;1)
 ;            4  Code (0;3)
 ;            5  Source (0;4)
 ;            6  Effective Date (60, 0;1)
 ;            7  Status (60, 0;2) 0:inactive; 1:active
 ;            8  Inactivation Date (60, 0;1)
 ;            9  Activation Date (60, 0;1)
 ;           10  Message
 ;        or 
 ;           -1^Error
 ; 
 N DATA,EFF,EFFX,EFFS,STR,MODN,MODST
 I $G(MOD)="" S STR="-1^NO MODIFIER SELECTED" G MODQ
 I $G(MFT)="" S MFT="E"
 I "E^I"'[MFT S STR="-1^INVALID MODIFIER FORMAT" G MODQ
 S MDT=$S($G(MDT)="":$$DT^XLFDT,1:$$DTBR^ICPTSUPT(MDT))
 I MFT="E" S MODN=$O(^DIC(81.3,"B",MOD,0)) I $O(^(MODN)) S STR="-1^Multiple modifiers w/same name.  Select IEN: " D MULT G MODQ
 I MFT="E" S MOD=MODN
 S MOD=+MOD
 I 'MOD!'$D(^DIC(81.3,MOD)) S STR="-1^NO SUCH MODIFIER" G MODQ
 S DATA=$G(^DIC(81.3,MOD,0))
 S MODST=$$VSTCM(MOD,MDT)
 I '$L(DATA) S STR="-1^NO DATA" G MODQ
 S STR=MOD_"^"_$P(DATA,"^",1,4)
 I '$G(SRC),$P(STR,"^",5)="V" Q "-1^VA LOCAL MODIFIER SELECTED"
 S EFF=$$EFF^ICPTSUPT(81.3,MOD,MDT)
 I EFF<1 S $P(EFF,"^",2)=0
 S STR=STR_"^"_EFF_"^"_$$MSG^ICPTSUPT(MDT)
 S:$L(MODST) $P(STR,"^",3)=MODST
MODQ ; Modifier Quit
 Q STR
 ;
MODD(CODE,OUTARR,DFN,CDT)       ; returns CPT description in array
 ;
 ; Input:   CODE   CPT Modifier, internal or external (Required)
 ;          ARY    Output Array Name
 ;                   e.g. "ABC" or "ABC("TEST")" 
 ;                   Default = ^TMP("ICPTD",$J)
 ;          DFN    Not used
 ;          CDT    Versioning Date (default = TODAY)
 ;                   If prior to 1/1/1989, 1/1/1989 will be used
 ;                   If year only, use first of that year
 ;                   If month/year only, use first of the month
 ;                   If later than today, TODAY will be used
 ; 
 ; Output:  #      Number of lines in description
 ; 
 ;          @ARY(1:n) - Versioned Description (multiple 62)
 ;          @ARY(n+1) - blank
 ;          @ARY(n+1) - message: CODE TEXT MAY BE INACCURATE
 ;      or
 ;          -1^Error
 ; 
 ;  ** User must initialize ^TMP("ICPTD",$J), if used **
 ; 
 N ARR,END,CTV,I,N
 I $G(CODE)="" S N="-1^NO CODE SELECTED" G MODDQ
 I $G(OUTARR)="" S OUTARR="^TMP(""ICPTD"",$J,"
 I OUTARR'["(" S OUTARR=OUTARR_"("
 I OUTARR[")" S OUTARR=$P(OUTARR,")")
 S END=$E(OUTARR,$L(OUTARR)) I END'="("&(END'=",") S OUTARR=OUTARR_","
 I OUTARR="^TMP(""ICPTD"",$J," K ^TMP("ICPTD",$J)
 S CODE=$S(CODE?1.N:+CODE,1:$$CODEN(CODE)),I=0,N=0
 I CODE<1!'$D(^DIC(81.3,CODE)) S N="-1^NO SUCH CODE" G MODDQ
 S CDT=$S($G(CDT)="":$$DT^XLFDT,1:$$DTBR^ICPTSUPT(CDT))
 D VLTCM(+CODE,CDT,.CTV)
 S (N,I)=0 F  S I=$O(CTV(I)) Q:+I=0  D
 . S N=N+1,ARR=OUTARR_N_")",@ARR=$$TRIM($G(CTV(I)))
 I +N>0 D
 . S N=N+1,ARR=OUTARR_N_")",@ARR=" "
 . S N=N+1,ARR=OUTARR_N_")",@ARR=$$MSG^ICPTSUPT(CDT,1)
 I +N'>0 S N="-1^VERSIONED DESCRIPTION NOT FOUND FOR MODIFIER "_$P($G(^DIC(81.3,+CODE,0)),"^",1)
MODDQ ; Modifier Description Quit
 Q N
 ;
MODA(CODE,VDT,ARY) ; Return an array of Modifiers for a CPT Code
 D MODA^ICPTMOD2 Q
MODP(CODE,MOD,MFT,MDT,SRC,DFN) ;  Check if modifier can be used with code
 Q $$MODP^ICPTMOD2($G(CODE),$G(MOD),$G(MFT),$G(MDT),$G(SRC),$G(DFN))
MODC(MOD) ; Checks modifier for range including code
 D MODC^ICPTMOD2($G(MOD))
 Q
MULT ; Finds Duplicate Modifiers
 D MULT^ICPTMOD2 Q
CODEN(CODE)    ; Return the IEN of a CPT modifier CODE
 Q:$G(CODE)="" -1
 N COD S COD=+$O(^DIC(81.3,"BA",(CODE_" "),0))
 Q $S(COD>0:COD,1:-1)
VSTCM(IEN,VDATE) ; Versioned Short Text (CPT Modifier)
 N CPT0,CPTC,CPTI,CPTSTD,CPTSTI,CPTVDT,CPTTXT,CPTTD,CPTTI
 S CPTI=+($G(IEN)) Q:+CPTI'>0 ""  Q:'$D(^DIC(81.3,+CPTI)) ""
 S CPTVDT=$G(VDATE) S:'$L(CPTVDT)!(+CPTVDT'>0) CPTVDT=$$DT^XLFDT Q:$P(CPTVDT,".",1)'?7N ""
 S CPT0=$G(^DIC(81.3,+CPTI,0)),CPTC=$P(CPT0,"^",1) Q:'$L(CPTC) ""
 S CPTSTD=0 S CPTTD=CPTVDT+.000001 F  S CPTTD=$O(^DIC(81.3,"AST",(CPTC_" "),CPTTD),-1) Q:+CPTTD=0  Q:+CPTSTD>0  D
 . S CPTTI=$O(^DIC(81.3,"AST",(CPTC_" "),CPTTD," "),-1) S:CPTTI=CPTI CPTSTD=CPTTD
 I +CPTSTD>0 D  Q:$L($G(CPTTXT)) $G(CPTTXT)
 . S CPTSTI=$O(^DIC(81.3,"AST",(CPTC_" "),CPTSTD,+CPTI," "),-1),CPTTXT=$P($G(^DIC(81.3,+CPTI,61,+CPTSTI,0)),"^",2)
 S CPTSTD=$O(^DIC(81.3,+CPTI,61,"B",0)) I +CPTSTD>0 D  Q:$L($G(CPTTXT)) $G(CPTTXT)
 . S CPTSTI=$O(^DIC(81.3,+CPTI,61,"B",CPTSTD,0)),CPTTXT=$P($G(^DIC(81.3,+CPTI,61,+CPTSTI,0)),"^",2)
 Q $$TRIM($P(CPT0,"^",2))
VLTCM(IEN,VDATE,ARY) ; Versioned Description - Long Text (CPT Modifier)
 N CPT0,CPTC,CPTD,CPTI,CPTSTD,CPTSTI,CPTT,CPTVDT,CPTTXT,CPTTD,CPTTI
 S CPTI=+($G(IEN)) Q:+CPTI'>0  Q:'$D(^DIC(81.3,+CPTI))
 S CPTVDT=$G(VDATE) S:'$L(CPTVDT)!(+CPTVDT'>0) CPTVDT=$$DT^XLFDT Q:$P(CPTVDT,".",1)'?7N
 S CPT0=$G(^DIC(81.3,+CPTI,0)),CPTC=$P(CPT0,"^",1) Q:'$L(CPTC)
 S CPTSTD=0 S CPTTD=CPTVDT+.000001 F  S CPTTD=$O(^DIC(81.3,"ADS",(CPTC_" "),CPTTD),-1) Q:+CPTTD=0  Q:+CPTSTD>0  D
 . S CPTTI=$O(^DIC(81.3,"ADS",(CPTC_" "),CPTTD," "),-1) S:CPTTI=CPTI CPTSTD=CPTTD
 I +CPTSTD>0 D  Q:+($O(ARY(0)))>0
 . S CPTSTI=$O(^DIC(81.3,"ADS",(CPTC_" "),CPTSTD,+CPTI," "),-1)
 . S (CPTD,CPTT)=0 F  S CPTD=$O(^DIC(81.3,+CPTI,62,CPTSTI,1,CPTD)) Q:+CPTD=0  D
 . . S CPTT=CPTT+1,ARY(CPTT)=$$TRIM($G(^DIC(81.3,+CPTI,62,+CPTSTI,1,+CPTD,0))),ARY(0)=CPTT
 S CPTSTD=$O(^DIC(81.3,+CPTI,62,"B",0)) I +CPTSTD>0 D  Q:+($O(ARY(0)))>0
 . S CPTSTI=$O(^DIC(81.3,+CPTI,62,"B",CPTSTD,0))
 . S (CPTD,CPTT)=0 F  S CPTD=$O(^DIC(81.3,+CPTI,62,CPTSTI,1,CPTD)) Q:+CPTD=0  D
 . . S CPTT=CPTT+1,ARY(CPTT)=$$TRIM($G(^DIC(81.3,+CPTI,62,+CPTSTI,1,+CPTD,0))),ARY(0)=CPTT
 K ARY S (CPTD,CPTT)=0 F  S CPTD=$O(^DIC(81.3,CPTI,"D",CPTD)) Q:+CPTD=0  D
 . S CPTT=CPTT+1,ARY(CPTT)=$$TRIM($G(^DIC(81.3,CPTI,"D",CPTD,0))),ARY(0)=CPTT
 Q
TRIM(X) ; Trim Spaces
 S X=$G(X) Q:X="" X F  Q:$E(X,1)'=" "  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=" "  S X=$E(X,1,($L(X)-1))
 F  Q:X'["  "  S X=$P(X,"  ",1)_" "_$P(X,"  ",2,229)
 Q X
MO(X) ; Modifier             X = Modifier IEN
 Q $P($G(^DIC(81.3,+($G(X)),0)),"^",1)
