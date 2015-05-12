LEX10PL ;ISL/KER - ICD-10 Procedure Lookup ;12/19/2014
 ;;2.0;LEXICON UTILITY;**80,86**;Sep 23, 1996;Build 1
 ;               
 ; Global Variables
 ;    ^%ZOSF("TEST"       ICR  10096
 ;    ^LEX(757.033        N/A
 ;    ^XTMP(              SACC 2.3.2.5.2
 ;               
 ; External References
 ;    HOME^%ZIS           ICR  10086
 ;    ENDR^%ZISS          ICR  10088
 ;    KILL^%ZISS          ICR  10088
 ;    ^DIM                ICR  10016
 ;    $$GET1^DIQ          ICR   2056
 ;    ^DIR                ICR  10026
 ;    $$ICDOP^ICDEX       ICR   5747
 ;    $$IMP^ICDEX         ICR   5747
 ;    $$DT^XLFDT          ICR  10103
 ;    $$FMADD^XLFDT       ICR  10103
 ;    $$UP^XLFSTR         ICR  10104
 ;               
EN ; Main Entry Point
 ; 
 ; Input   
 ; 
 ;   None
 ; 
 ; Output
 ; 
 ;   Y         2 Piece "^" delimited string
 ;               1   IEN to the Expression File 757.01
 ;               2   Expression Display Text
 ;                 
 ;   Y("ICD")  2 Piece "^" delimited string
 ;               1   IEN ICD OPERATION/PROCEDURE File #80.1
 ;               2   ICD Code
 ; 
 N LEXENV S LEXENV=$$ENV Q:+LEXENV'>0  N X,LEXDT,LEXIM
 N BOLD,DIR,DIRB,DIROUT,DIRUT,DTOUT,DUOUT,IOINHI,IOINORM,LEX
 N LEXA,LEXB,LEXC,LEXCHR,LEXCODE,LEXCOM,LEXDT,LEXE,LEXEFF
 N LEXENV,LEXERR,LEXFD,LEXI,LEXICD,LEXID,LEXIEN,LEXIM,LEXIN
 N LEXIT,LEXKEY,LEXL,LEXN,LEXNAM,LEXND,LEXNM,LEXNT,LEXO
 N LEXOFF,LEXOK,LEXPCDAT,LEXPSN,LEXR,LEXRTN,LEXS,LEXSBR
 N LEXSEC,LEXSIEN,LEXSTA,LEXT,LEXTAG,LEXTD,LEXTERM,LEXTOT
 N LEXTXT,LEXUP,LEXUSR,LEXV,LEXVAL,LEXVDT,LEXX,LEXY,NORM,X
X ; Get user input
 K DIROUT,DIRUT,DTOUT,DUOUT
 S LEXDT=$G(LEXVDT) S:LEXDT'?7N LEXDT=$$DT^XLFDT
 S LEXIM=$$IMP^ICDEX(30) S:LEXDT'>LEXIM LEXDT=LEXIM S X=$$SO Q:X["^"
 K Y,LEXY D:$L(X)&(X'["^") BEG I $D(DUOUT)&'$D(DIROUT) W ! G X
 N LEXTEST
 Q 
BEG ; Begin Recursive Loop
 K DIROUT,DIRUT,DTOUT,DUOUT N LEXIT,LEXVDT,LEXTXT,LEXUP,LEXY,LEXX
 N LEXBEG,LEXEND,LEXELP,LEXSEC
 K Y S Y=-1,U="^",LEXTXT=$G(X) Q:'$L(LEXTXT)
 S LEXVDT=$G(LEXDT),LEXIT=0
LOOK ;   Lookup
 Q:+($G(LEXIT))>0  K LEXY
 S LEXY=$$PCSDIG^LEX10CS(LEXTXT,LEXDT),LEXTOT=$$FND
 S:$L(LEXTXT)>0 LEXUP=$E(LEXTXT,1,($L(LEXTXT)-1))
 I $L($O(LEXPCDAT("NEXLEV",""))) S LEXCHR=$$SEL^LEX10PLS(LEXTXT)
 S LEXCHR=$G(LEXCHR)
 ;     Quit if
 ;       Timed out or user enters "^^"
 I $D(DTOUT)!($D(DIROUT)) S LEXIT=1 K X Q
 ;       Up one level (LEXUP) if user enters "^"
 ;       Quit if already at top level and user enters "^"
 I $D(DUOUT),'$D(DIROUT),$D(DIRUT),$L($G(LEXTXT))=1 D  Q
 . K X,LEXUP,LEXNT S LEXIT=1,(LEXCHR,LEXTXT,X)=""
 I $D(DUOUT),'$D(DIROUT),$D(DIRUT),$L($G(LEXUP)) D  G:'LEXIT LOOK Q:LEXIT
 . K X S (X,LEXTXT)=LEXUP I '$L(X) S LEXIT=1 K X S LEXTXT=""
 . S:$L($G(LEXNT))>1 LEXNT=$E($G(LEXNT),1,($L($G(LEXNT))-1))
 I $D(DUOUT),'$D(DIROUT),$D(DIRUT),'$L($G(LEXUP)) S LEXIT=1 K X S LEXTXT="" Q
 I $D(DUOUT)&('$D(DIROUT)) K:'$D(LEXNT) X Q
 ;       No Selection Made
 I '$D(DUOUT),LEXCHR="" S LEXIT=1
 ;       Character Found and Selected
 I $L(LEXCHR),LEXCHR'["^",(LEXCHR?1N!(LEXCHR?1U)) D  Q:+($G(Y))>0
 . K Y S LEXTXT=LEXTXT_LEXCHR Q:$L(LEXTXT)<7
 . N LEXSTA,LEXSIEN,LEXIEN,LEXCODE,LEXEFF,LEXTERM,LEXND,LEXICD
 . S LEXSTA=$$STATCHK^LEXSRC2(LEXTXT,$G(LEXDT),,31)
 . S LEXSIEN=$P(LEXSTA,"^",2)
 . S LEXEFF=$P(LEXSTA,"^",3)
 . S LEXSTA=$P(LEXSTA,"^",1)
 . S LEXND=$G(^LEX(757.02,+LEXSIEN,0))
 . S LEXCODE=$P(LEXND,"^",2),LEXIEN=+LEXND
 . S LEXTERM=$G(^LEX(757.01,+LEXIEN,0))
 . S LEXICD=+$$ICDOP^ICDEX(LEXCODE,,31),LEXIT=1
 . S Y=LEXIEN_"^"_LEXTERM,Y("ICD")=LEXICD_"^"_LEXCODE
 . D END(LEXCODE,LEXTERM)
 ;       Category Found and Selected
 I $L(LEXCHR),LEXCHR'["^",(LEXCHR?1N!(LEXCHR?1U)) D  G:+($G(LEXIT))'>0 LOOK
 . D NXT I $G(Y)="^" D
 . . Q:'$L(LEXTXT)  S LEXTXT=$E(LEXTXT,1,($L(LEXTXT)-1)) Q:'$L(LEXTXT)
 . . F  S LEXTXT=$E(LEXTXT,1,($L(LEXTXT)-1)) Q:$$TOT($E(LEXTXT,1,($L(LEXTXT)-1)),LEXDT)>0
 Q
NXT ;   Next
 Q:+($G(LEXIT))>0  N LEXNT,LEXND
 S LEXNT=$G(LEXTXT),LEXND=$G(LEXDT)
 N LEXTXT,LEXDT S LEXTXT=LEXNT,LEXDT=LEXND
 G LOOK
 Q
TOT(X,Y) ; Total Possible
 N LEXPCDAT,LEXDT,LEXY S X=$G(X) Q:'$L(X) 0  S LEXDT=$G(Y)
 S LEXY=$$PCSDIG^LEX10CS(X,LEXDT),X=$$FND
 Q X
 ;     
SO(X) ; Enter a Code/Code Fragment
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,DIRB,LEXTD,Y,LEX,LEXCOM,LEXERR,LEXSBR
 S LEXTD=$G(LEXVDT) S:LEXTD'?7N LEXTD=$$DT^XLFDT
 S LEXCOM="Enter a Procedure Code/Code Fragment"
 S DIR(0)="FAO^1:30",DIR("A")=" "_LEXCOM_":  "
 S (LEXSBR,DIRB)=$$RET("LEX10PL","SO",+($G(DUZ)),LEXCOM)
 S DIR("PRE")="S X=$$SOP^LEX10PL(X) W:X[""??"" ""  ??"""
 S (DIR("?"),DIR("??"))="^D SOH^LEX10PL" D ^DIR
 Q:$D(DTOUT) "^"  Q:'$L(X)!('$L(Y)) "^"  Q:$D(DUOUT) "^" Q:$D(DIROUT) "^"  Q:$G(X)["^" "^"
 S (LEX,X)=$G(Y) D:$L(LEX)&(LEX'["^") SAV("LEX10PL","SO",+($G(DUZ)),LEXCOM,LEX)
 Q X
SOH ;   Select a Code Help
 W:$L($G(LEXERR)) !,"     ",LEXERR,!
 W !,"     Enter either: "
 W !,"                                            Example"
 W !,"       ICD-10 Procedure code                04LE0CT"
 W !,"       Partial ICD-10 Procedure code        00C6",!
 W !,"     May not exceed 7 characters.  Enter return or ""^"""
 W !,"     to exit."
 K LEXERR
 Q
SOP(X) ;   Code Pre-Processing
 N LEX,LEXO,LEXR,LEXB,LEXOK K LEXERR Q:'$L($G(X)) ""
 S (LEX,X)=$$UP^XLFSTR($G(X)) Q:'$L(LEX) "??"
 Q:LEX["?" "??"  S:LEX["^^" (LEX,X)="^^",DUOUT=1,DIROUT=1
 S:LEX["^"&(LEX'["^^") (LEX,X)="^",DUOUT=1 Q:LEX["^" X  Q:'$L(LEX) ""
 I LEX["." S LEXERR="Procedure codes do not have decimal places" Q "??"
 I $E(LEX,1)="Z" S LEXERR="First character must not contain ""Z""" Q "??"
 S (LEXC,LEXO,LEXR)=$E(LEX,1),LEXO=$C($A(LEXO)-1)_"~ ",LEXN=($O(^LEX(757.02,"APR",LEXO)))
 I (LEXR'?1U&(LEXR'?1N)) S LEXERR="First character must be uppercase or numeric" Q "??"
 I $E(LEXN,1,$L(LEXC))'=LEXC S LEXERR="First character """_$E(LEX,1)_""" is not valid" Q "??"
 I $L(LEX)'>1 S X=LEX Q X
 S (LEXC,LEXO)=$E(LEX,1,2),LEXR=$E(LEX,2),LEXO=$E(LEXO,1,($L(LEXO)-1))_$C($A($E(LEXO,$L(LEXO)))-1)_"~"
 S LEXN=($O(^LEX(757.02,"APR",LEXO)))
 I (LEXR'?1U&(LEXR'?1N)) S LEXERR="Second character must be uppercase or numeric" Q "??"
 I $L(LEX)>1 I $E(LEXN,1,$L(LEXC))'=LEXC S LEXERR="Second character """_LEXR_""" is not valid" Q "??"
 I $L(LEX)'>2 S X=LEX Q X
 S (LEXC,LEXO)=$E(LEX,1,3),LEXR=$E(LEX,3),LEXO=$E(LEXO,1,($L(LEXO)-1))_$C($A($E(LEXO,$L(LEXO)))-1)_"~"
 S LEXN=($O(^LEX(757.02,"APR",LEXO)))
 I (LEXR'?1U&(LEXR'?1N))!(LEXR="Z") S LEXERR="Third character must not contain ""Z""" Q "??"
 I (LEXR'?1U&(LEXR'?1N)) S LEXERR="Third character must be uppercase or numeric" Q "??"
 I $L(X)>1 I $E(LEXN,1,$L(LEXC))'=LEXC S LEXERR="Third character """_LEXR_""" is not valid" Q "??"
 I $L(LEX)'>3 S X=LEX Q X
 S (LEXC,LEXO)=$E(LEX,1,4),LEXR=$E(LEX,4),LEXO=$E(LEXO,1,($L(LEXO)-1))_$C($A($E(LEXO,$L(LEXO)))-1)_"~"
 S LEXN=($O(^LEX(757.02,"APR",LEXO)))
 I (LEXR'?1U&(LEXR'?1N)) S LEXERR="Fourth character must be uppercase or numeric" Q "??"
 I $L(X)>1 I $E(LEXN,1,$L(LEXC))'=LEXC S LEXERR="Fourth character """_LEXR_""" is not valid" Q "??"
 I $L(LEX)'>4 S X=LEX Q X
 S (LEXC,LEXO)=$E(LEX,1,5),LEXR=$E(LEX,5),LEXO=$E(LEXO,1,($L(LEXO)-1))_$C($A($E(LEXO,$L(LEXO)))-1)_"~"
 S LEXN=($O(^LEX(757.02,"APR",LEXO)))
 I (LEXR'?1U&(LEXR'?1N)) S LEXERR="Fifth character must be uppercase or numeric" Q "??"
 I $L(X)>1 I $E(LEXN,1,$L(LEXC))'=LEXC S LEXERR="Fifth character """_LEXR_""" is not valid" Q "??"
 I $L(LEX)'>5 S X=LEX Q X
 S (LEXC,LEXO)=$E(LEX,1,6),LEXR=$E(LEX,6),LEXO=$E(LEXO,1,($L(LEXO)-1))_$C($A($E(LEXO,$L(LEXO)))-1)_"~"
 S LEXN=($O(^LEX(757.02,"APR",LEXO)))
 I (LEXR'?1U&(LEXR'?1N)) S LEXERR="Sixth character must be uppercase or numeric" Q "??"
 I $L(X)>1 I $E(LEXN,1,$L(LEXC))'=LEXC S LEXERR="Sixth character """_LEXR_""" is not valid" Q "??"
 I $L(LEX)'>6 S X=LEX Q X
 S (LEXC,LEXO)=$E(LEX,1,7),LEXR=$E(LEX,7),LEXO=$E(LEXO,1,($L(LEXO)-1))_$C($A($E(LEXO,$L(LEXO)))-1)_"~"
 S LEXN=($O(^LEX(757.02,"APR",LEXO)))
 I (LEXR'?1U&(LEXR'?1N)) S LEXERR="Seventh character must be uppercase or numeric" Q "??"
 I $L(X)>1 I $E(LEXN,1,$L(LEXC))'=LEXC S LEXERR="Seventh character """_LEXR_""" is not valid" Q "??"
 S X=LEX
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
END(X,Y) ;   End Search, display results
 N LEXCODE,LEXTERM,LEXC,LEXI,LEXS S LEXCODE=$G(X),LEXTERM(1)=$G(Y) Q:$L(LEXCODE)'=7  Q:'$L(LEXTERM(1))
 D PR^LEX10PLS(.LEXTERM,69),GCUR($G(LEXCODE),.LEXC)
 S LEXS="",$P(LEXS,"-",$L(LEXC))="-" S LEXC=$J(" ",1)_LEXC,LEXS=$J(" ",1)_LEXS
 W:$L($G(IOF)) @IOF S LEXI=0 F  S LEXI=$O(LEXTERM(LEXI)) Q:+LEXI'>0  D
 . W !,?2,$G(LEXTERM(LEXI))
 W ! D ATTR W !,$G(BOLD),$G(LEXC),$G(NORM),!," ",$G(LEXS) D KATTR
 S LEXI=0 F  S LEXI=$O(LEXC(LEXI)) Q:+LEXI'>0  W !," ",$G(LEXC(LEXI))
 W !!
 Q
CUR(X) ;   Current Array
 N LEXC,LEXS,LEXI K LEXC D GCUR($G(X),.LEXC)  Q:'$D(LEXC)  S LEXC=$TR(LEXC," ","") Q:'$L($G(LEXC))  Q:$O(LEXC(0))'>0
 N LEXS,LEXI S LEXS="",$P(LEXS,"-",$L(LEXC))="-" S LEXC=$J(" ",1)_LEXC,LEXS=$J(" ",1)_LEXS
 W:$L($G(IOF)) @IOF D ATTR W !,$G(BOLD),$G(LEXC),$G(NORM),!,$G(LEXS) D KATTR
 S LEXI=0 F  S LEXI=$O(LEXC(LEXI)) Q:+LEXI'>0  W !,$G(LEXC(LEXI))
 Q
GCUR(X,LEXA) ;   Get Current Array
 K LEXA N LEXIN,LEXPSN,LEXOFF,LEXOK D ATTR
 S LEXIN=$TR($G(X)," ",""),LEXOFF=$L(LEXIN)+2 Q:'$L(LEXIN)  Q:'$D(^LEX(757.033,"AFRAG",31,(LEXIN_" ")))
 S LEXOK=1,LEXA=$J(" ",1)_LEXIN F LEXPSN=1:1:$L(LEXIN)  D
 . N LEXTXT,LEXSEC,LEXCHR,LEXNAM S LEXSEC=$E(LEXIN,1,LEXPSN),LEXCHR=$E(LEXIN,LEXPSN),LEXNAM=$$NAM(LEXSEC)
 . I '$L(LEXSEC)!('$L(LEXCHR))!('$L(LEXNAM)) S LEXOK=0 Q
 . S LEXTXT=$J(" ",LEXPSN)_$G(BOLD)_LEXCHR_$G(NORM)
 . S LEXTXT=LEXTXT_$J(" ",(LEXOFF-LEXPSN))_LEXNAM
 . S LEXA(LEXPSN)=LEXTXT
 D KATTR
 K:'LEXOK LEXA
 Q
NAM(X) ;   Descriptive Dane
 N LEXIN,LEXDT,LEXEFF,LEXIEN S LEXIN=$G(X) Q:'$L(LEXIN) ""  Q:'$D(^LEX(757.033,"AFRAG",31,(LEXIN_" "))) ""
 S LEXDT=$G(LEXVDT) S:LEXDT'?7N LEXDT=$$IMP^ICDEX(31)
 S LEXEFF=$O(^LEX(757.033,"AFRAG",31,(LEXIN_" "),(LEXDT+.001)),-1) Q:LEXEFF'?7N ""
 S LEXIEN=$O(^LEX(757.033,"AFRAG",31,(LEXIN_" "),LEXEFF," "),-1) Q:+LEXIEN'>0 ""
 S X=$$SN(LEXIEN)
 Q X
SN(X,EFF) ; Short Name
 N IEN,CDT,IMP,EFF,HIS S IEN=+($G(X)),CDT=$G(LEXVDT) S:$G(EFF)?7N CDT=$G(EFF)
 S IMP=$$IMP^ICDEX(31) S:CDT'?7N CDT=$$DT^XLFDT S:CDT'>IMP&(IMP?7N) CDT=IMP
 S EFF=$O(^LEX(757.033,+IEN,2,"B",(CDT+.001)),-1)
 S HIS=$O(^LEX(757.033,+IEN,2,"B",+EFF," "),-1)
 S X=$G(^LEX(757.033,+IEN,2,+HIS,1))
 Q X
FND(X) ;   Found
 N LEXI S X=0,LEXI="" F  S LEXI=$O(LEXPCDAT("NEXLEV",LEXI)) Q:'$L(LEXI)  S X=X+1
 Q X
GETO(X) ;   Get One
 S X=$O(LEXPCDAT("NEXLEV",""))
 Q X
ATTR ;   Screen Attributes
 N X,IOINHI,IOINORM S X="IOINHI;IOINORM" D ENDR^%ZISS S BOLD=$G(IOINHI),NORM=$G(IOINORM)
 Q
KATTR ;   Kill Screen Attributes
 D KILL^%ZISS K BOLD,NORM
 Q
ENV(X) ;   Check environment
 N LEX S DT=$$DT^XLFDT D HOME^%ZIS S U="^" I +($G(DUZ))=0 W !!,?5,"DUZ not defined" Q 0
 S LEX=$$GET1^DIQ(200,(DUZ_","),.01) I '$L(LEX) W !!,?5,"DUZ not valid" Q 0
 Q 1
