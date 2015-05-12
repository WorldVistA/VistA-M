LEX10DL ;ISL/KER - ICD-10 Diagnosis Lookup ;12/19/2014
 ;;2.0;LEXICON UTILITY;**80,86**;Sep 23, 1996;Build 1
 ;               
 ; Global Variables
 ;    ^%ZOSF("TEST")      ICR  10096
 ;    ^LEX(757.033        N/A
 ;    ^XTMP(              SACC 2.3.2.5.2
 ;               
 ; External References
 ;    HOME^%ZIS           ICR  10086
 ;    ^DIM                ICR  10016
 ;    $$GET1^DIQ          ICR   2056
 ;    ^DIR                ICR  10026
 ;    $$ICDDX^ICDEX       ICR   5747
 ;    $$IMP^ICDEX         ICR   5747
 ;    $$DT^XLFDT          ICR  10103
 ;    $$FMADD^XLFDT       ICR  10103
 ;    $$FMDIFF^XLFDT      ICR  10103
 ;    $$FMTE^XLFDT        ICR  10103
 ;    $$NOW^XLFDT         ICR  10103
 ;    $$UP^XLFSTR         ICR  10103
 ;               
EN ; Main Entry Point
 ; 
 ; Input   
 ; 
 ;   None
 ; 
 ; Output
 ; 
 ;   Y          2 Piece "^" delimited string
 ;                 1   IEN to the Expression File 757.01
 ;                 2   Expression Display Text
 ;                 
 ;   Y("ICD")   2 Piece "^" delimited string
 ;                 1   IEN to the ICD DIAGNOSIS File #80
 ;                 2   ICD Code
 ; 
 N LEXENV S LEXENV=$$ENV Q:+LEXENV'>0
 N DTOUT,DUOUT,DIRUT,DIROUT,LEXDT,LEXIM,LEXMAX,LEXFRQ,LEXCONT,X
 S LEXDT=$G(LEXVDT) S:LEXDT'?7N LEXDT=$$DT^XLFDT S LEXMAX=$$MAX^LEXU(30)
 S LEXIM=$$IMP^ICDEX(30) S:LEXDT'>LEXIM LEXDT=LEXIM S LEXCONT=1
X ; Get user input
 K DIROUT,DUOUT,DTOUT,DIRUT
 S X=$$SO Q:X["^"  S LEXFRQ=$$FREQ^LEXU(X)
 I LEXFRQ>LEXMAX D  Q:$D(DIRUT)  Q:$D(LEXCONT)["^"  G:LEXCONT'>0 X
 . N LEXX S LEXX=X S LEXCONT=$$CONT^LEX10DLS(LEXX,LEXFRQ) W !
 K Y,LEXY D:$L(X)&(X'["^") BEG I $D(DUOUT)&'$D(DIROUT) W ! G X
 N LEXTEST
 Q 
BEG ; Begin Recursive Loop
 K DIROUT,DUOUT,DTOUT,DIRUT
 N LEXIT,LEXVDT,LEXTXT,LEXUP,LEXY,LEXX
 N LEXBEG,LEXEND,LEXELP,LEXSEC
 K Y S Y=-1,U="^",LEXTXT=$G(X) Q:'$L(LEXTXT)
 S LEXVDT=$G(LEXDT),LEXIT=0
LOOK ;   Lookup
 Q:+($G(LEXIT))>0  K LEXY S LEXBEG=$$NOW^XLFDT
 S LEXY=$$DIAGSRCH^LEX10CS(LEXTXT,.LEXY,LEXVDT,30)
 S LEXEND=$$NOW^XLFDT,LEXELP=$$FMDIFF^XLFDT(LEXEND,LEXBEG,3)
 S LEXSEC=$$FMDIFF^XLFDT(LEXEND,LEXBEG,2)
 S:$L(LEXELP,":")=3 LEXELP=$TR(LEXELP," ","0")
 S:$L(LEXELP,":")'=3!(LEXSEC'>0) LEXELP="00:00:00"
 I $D(LEXTEST) D
 . W ! W !,"   Search for:     ",LEXTXT
 . W !,"   Begin Search:   ",$$FMTE^XLFDT(LEXBEG,"5Z")
 . W !,"   Finish Search:  ",$$FMTE^XLFDT(LEXBEG,"5Z")
 . W !,"   Elapsed Time:   ",LEXELP W !
 S:$O(LEXY(" "),-1)>0 LEXY=+LEXY
 I +LEXY'>0 W !,"  No data found",! K X Q
 S LEXX=$$SEL^LEX10DLS(.LEXY,8)
 I $D(DUOUT)&('$D(DIROUT)) K:'$D(LEXNT) X Q
 I $D(DTOUT)&('$D(DIROUT)) S LEXIT=1 K X Q
 I $D(DIROUT) S LEXIT=1 K X Q
 ;     Quit if
 ;       Timed out or user enters "^^"
 I $D(DTOUT)!($D(DIROUT)) S LEXIT=1 K X Q
 ;       Up one level (LEXUP) if user enters "^"
 ;       Quit if already at top level and user enters "^"
 I $D(DUOUT),'$D(DIROUT),$L($G(LEXUP)) K X Q
 ;       No Selection Made
 I '$D(DUOUT),LEXX=-1 S LEXIT=1
 ;       Code Found and Selected
 I $P(LEXX,";")'="99:CAT" D  Q
 . N LEXIEN,LEXCODE,LEXTERM,LEXICD
 . S LEXIEN=$P($P(LEXX,"^"),";",1),LEXCODE=$P($P(LEXX,"^"),";",2)
 . S LEXTERM=$P(LEXX,"^",2) S:$L(LEXTERM)&($L(LEXCODE)) LEXTERM=LEXTERM_" (ICD-10-CM "_LEXCODE_")"
 . S LEXICD=+$$ICDDX^ICDEX(LEXCODE,,30),LEXIT=1
 . S Y=LEXIEN_"^"_LEXTERM,Y("ICD")=LEXICD_"^"_LEXCODE
 ;       Category Found and Selected
 D NXT G:+($G(LEXIT))'>0 LOOK
 Q
NXT ;   Next
 Q:+($G(LEXIT))>0  N LEXNT,LEXND,LEXXX
 S LEXNT=$G(LEXTXT),LEXND=$G(LEXVDT),LEXXX=$G(LEXX)
 N LEXTXT,LEXVDT S LEXTXT=$P($P(LEXXX,"^"),";",2),LEXVDT=LEXND
 G LOOK
 Q
 ;     
SO(X) ; Enter a Code/Code Fragment
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,DIRB,LEXTD,Y,LEX,LEXCOM,LEXERR,LEXSBR
 S LEXTD=$G(LEXVDT) S:LEXTD'?7N LEXTD=$$DT^XLFDT
 S LEXCOM="Enter Diagnosis, a Code or a Code Fragment"
 S DIR(0)="FAO^1:30",DIR("A")=" "_LEXCOM_":  "
 S (LEXSBR,DIRB)=$$RET("LEX10DL","SO",+($G(DUZ)),LEXCOM)
 S DIR("PRE")="S X=$$SOP^LEX10DL(X) W:X[""??"" ""  ??"""
 S (DIR("?"),DIR("??"))="^D SOH^LEX10DL" D ^DIR
 Q:$D(DTOUT) "^"  Q:'$L(X)!('$L(Y)) "^"
 S:$D(DUOUT) X="^" S:$D(DIROUT) X="^^"  Q:$G(X)["^" "^"
 S (LEX,X)=$G(Y) D:$L(LEX)&(LEX'["^") SAV("LEX10DL","SO",+($G(DUZ)),LEXCOM,LEX)
 Q X
SOH ;   Select a Code Help
 W:$L($G(LEXERR)) !,"     ",LEXERR,!
 W !,"     Enter either: "
 W !,"                                            Example"
 W !,"       ICD-10 Diagnosis code                S62.131K"
 W !,"       Partial ICD-10 Diagnosis code        S62.131"
 W !,"       ICD-10 Diagnosis sub-category        S62.131"
 W !,"       ICD-10 Diagnosis category            S62."
 W !,"       Partial ICD-10 Diagnosis category    S6"
 W !,"       Diagnostic Text                      Diabetes Mellitus",!
 W !,"     Must have at least 2 characters.  If a code is entered"
 W !,"     it may not exceed 7 characters.  Enter return or ""^"" "
 W !,"     to exit, ""Space-Bar-Return"" to select previous"
 W !,"     search parameter.",!
 K LEXERR
 Q
SOP(X) ;   Code Pre-Processing
 N LEX,LEXO,LEXR,LEXB,LEXOK,LEXSTB,LEXSO S LEXSO=0
 S (LEX,X)=$$UP^XLFSTR($G(X)),LEXSTB=$E(LEX,1,3),LEXB=$G(DIR("B"))
 I ($L(LEX)&($E(LEX,1)=" "))&($L($G(LEXSBR))) D  Q X
 . S (LEX,X)=$G(LEXSBR) W "  ",X
 Q:LEX["?" "??"  S:LEX["^^" (LEX,X)="^^",DUOUT=1,DIROUT=1
 S:LEX["^"&(LEX'["^^") (LEX,X)="^",DUOUT=1
 Q:LEX["^" X  S:'$L(LEX)&($L(LEXB)) (LEX,X)=$G(LEXB)
 Q:'$L(LEX) ""  S LEXR=LEX S:$L(LEXR) LEXR=" ("_LEXR_")"
 S LEXSO=0 I $L(LEXSTB) D
 . S:$O(^LEX(757.02,"ADX",(LEXSTB_" ")))[LEXSTB LEXSO=1
 I 'LEXSO Q X
 S:$L(LEX)'>1 LEXERR="Input must be at least 2 characters"_LEXR
 S:$L(LEX)>8 LEXERR="Input can not exceed 8 characters"_LEXR
 Q:$L(LEX)'>1!($L(LEX)>8) "??"
 S:$L(LEX)>3&($E(LEX,4)'=".") LEXERR="Fourth character position must be a decimal"_LEXR
 Q:$L(LEX)>3&($E(LEX,4)'=".") "??"  S LEXOK=0
 S LEXO=$E(LEX,1,($L(LEX)-1))_$C($A($E(LEX,$L(LEX)))-1)_"~"
 S:$L(LEX)=3&(LEX'[".") (LEX,X)=LEX_"."
 S:$D(^LEX(757.02,"ADX",(LEX_" "))) LEXOK=1
 S:$O(^LEX(757.02,"ADX",(LEXO_" ")))[LEX LEXOK=1
 S:$D(^LEX(757.033,"AFRAG",30,(LEX_" "))) LEXOK=1
 S:$O(^LEX(757.033,"AFRAG",30,(LEXO_" ")))[LEX LEXOK=1
 S:'LEXOK LEXERR="Input is not a code or category"_LEXR
 S:'LEXOK (LEX,X)="??"
 Q X
 ;               
 ; Miscellaneous
SAV(X,Y,LEXN,LEXC,LEXV) ;   Save Defaults
 N LEXRTN,LEXTAG,LEXUSR,LEXCOM,LEXVAL,LEXNM,LEXID,LEXTD,LEXFD,LEXKEY S LEXRTN=$G(X) Q:+($$ROK(LEXRTN))'>0  S LEXTAG=$G(Y) Q:+($$TAG((LEXTAG_"^"_LEXRTN)))'>0
 S LEXUSR=+($G(LEXN)),LEXVAL=$G(LEXV) Q:LEXUSR'>0  Q:'$L(LEXVAL)  S LEXCOM=$G(LEXC) Q:'$L(LEXCOM)  S LEXKEY=$E(LEXCOM,1,13) F  Q:$L(LEXKEY)>12  S LEXKEY=LEXKEY_" "
 S LEXNM=$$GET1^DIQ(200,(LEXUSR_","),.01) Q:'$L(LEXNM)  S LEXTD=$$DT^XLFDT,LEXFD=$$FMADD^XLFDT(LEXTD,30),LEXID=LEXRTN_" "_LEXUSR_" "_LEXKEY
 S ^XTMP(LEXID,0)=LEXFD_"^"_LEXTD_"^"_LEXCOM,^XTMP(LEXID,LEXTAG)=LEXVAL
 Q
RET(X,Y,LEXN,LEXC) ;   Retrieve Defaults
 N LEXRTN,LEXTAG,LEXUSR,LEXCOM,LEXNM,LEXID,LEXTD,LEXFD,LEXKEY S LEXRTN=$G(X) Q:+($$ROK(LEXRTN))'>0 ""
 S LEXTAG=$G(Y) Q:+($$TAG((LEXTAG_"^"_LEXRTN)))'>0 ""  S LEXUSR=+($G(LEXN)) Q:LEXUSR'>0 ""
 S LEXCOM=$G(LEXC) Q:'$L(LEXCOM) ""  S LEXKEY=$E(LEXCOM,1,13) F  Q:$L(LEXKEY)>12  S LEXKEY=LEXKEY_" "
 S LEXNM=$$GET1^DIQ(200,(LEXUSR_","),.01) Q:'$L(LEXNM) ""  S LEXTD=$$DT^XLFDT,LEXFD=$$FMADD^XLFDT(LEXTD,30),LEXID=LEXRTN_" "_LEXUSR_" "_LEXKEY
 S X=$G(^XTMP(LEXID,LEXTAG))
 Q X
ROK(X) ;   Routine OK
 S X=$G(X) Q:'$L(X) 0  Q:$L(X)>8 0  X ^%ZOSF("TEST") Q:$T 1  Q 0
TAG(X) ;   Sub-Routine OK
 N LEXT,LEXE,LEXL S X=$G(X) Q:'$L(X) 0  Q:X'["^" 0
 Q:'$L($P(X,"^",1)) 0  Q:$L($P(X,"^",1))>8 0  Q:$E($P(X,"^",1),1)'?1U 0
 Q:'$L($P(X,"^",2)) 0  Q:$L($P(X,"^",2))>8 0  Q:$E($P(X,"^",2),1)'?1U 0
 S LEXL=0,LEXT=X,(LEXE,X)="S LEXL=$L($T("_X_"))" D ^DIM X:$D(X) LEXE
 S X=$S(LEXL>0:1,1:0)
 Q X
ENV(X) ;   Check environment
 N LEX S DT=$$DT^XLFDT D HOME^%ZIS S U="^" I +($G(DUZ))=0 W !!,?5,"DUZ not defined" Q 0
 S LEX=$$GET1^DIQ(200,(DUZ_","),.01) I '$L(LEX) W !!,?5,"DUZ not valid" Q 0
 Q 1
