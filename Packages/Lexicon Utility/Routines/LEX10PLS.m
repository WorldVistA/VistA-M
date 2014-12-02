LEX10PLS ;ISL/KER - ICD-10 Procedure Lookup Selection ;04/21/2014
 ;;2.0;LEXICON UTILITY;**80**;Sep 23, 1996;Build 1
 ;               
 ; Global Variables
 ;    ^LEX(757.033        N/A
 ;    ^UTILITY($J         ICR  10011
 ;               
 ; External References
 ;    ENDR^%ZISS          ICR  10088
 ;    KILL^%ZISS          ICR  10088
 ;    ^DIR                ICR  10026
 ;    ^DIWP               ICR  10011
 ;               
 ; Local Variables NEWed or KILLed Elsewhere
 ;     LEXPCDAT
 ;               
SEL(X) ; Select from List
 ;
 ; Input   
 ; 
 ;    X        Origninal Value
 ;    
 ;    Needs LEXPCDAT array
 ;                  
 ;             LEXPCDAT=1
 ;             LEXPCDAT("NEXLEV","6","DESC")="Cerebral Ventricle"
 ;             LEXPCDAT("NEXLEV","U","DESC")="Spinal Canal"
 ;             LEXPCDAT("LEXLEV",<character>,"DESC")=Description of Character
 ;             
 ; Output
 ;               
 ;    $$SEL  Next Character or -1
 ;               
 ; Creates Selection Array LEX
 ; 
 ;             LEX(0)=3
 ;             LEX(1)="6^   1.  ("_$c(27)_"[1m6"_$c(27)_"[m)  Cerebral Ventricle"
 ;             LEX(2)="U^   2.  ("_$c(27)_"[1mU"_$c(27)_"[m)  Spinal Canal"
 ;             LEX(2)=<character>^<menu text>
 ;             LEX("B",1)=1
 ;             LEX("B",2)=2
 ;             LEX("B",<menu item>)=<menu item>
 ;             LEX("B",6)=1
 ;             LEX("B","U")=2
 ;             LEX("B",<character>)=<menu item>
 ;
 N DIR,DIRB,LEX,LEXCUR,LEXE,LEXFI,LEXHLP,LEXI,LEXIT,LEXL,LEXLAST
 N LEXMAX,LEXOUT,LEXS,LEXSS,LEXTOT,LEXTXT,LEXX K DTOUT,DUOUT,DIROUT,DIRUT
 N LEXIT,LEXL,LEXTOT,LEX S LEXTXT=$G(X),LEXIT=0,LEXTOT=$$FND Q:+LEXTOT'>0 "^"
 K X S:+LEXTOT=1 X=$$ONE S:+LEXTOT>1 X=$$MUL(LEXTXT) N LEXTEST
 Q X
ONE(X) ; One Entry Found
 Q:+($G(LEXIT))>0 "^^"  S X=$$GETO
 Q X
MUL(X) ; Multiple Entries Found
 Q:+($G(LEXIT))>0 "^^"  N LEX,LEXE,LEXI,LEXL,LEXMAX,LEXP,LEXSS,LEXX
 S LEXTXT=$G(X) D BUILD
 S LEXMAX=$G(LEXTOT),(LEXSS,LEXIT)=0,U="^" G:LEXMAX'>1 MULQ
 D:$L($G(LEXTXT)) CUR^LEX10PL(LEXTXT) W !
 W:$D(LEXTEST) !," Next character:  ",!
 S LEXI=0 F  S LEXI=$O(LEX(LEXI)) Q:+LEXI'>0  D
 . W !,?1,$G(LEX(+LEXI))
 W ! S LEXSS=$$MULS S:LEXSS["^" LEXIT=1
 S X=LEXSS
MULQ ;   Multiple Entries - Quit
 K LEX
 Q X
MULS(X) ;   Multiple Entries - Select
 K DTOUT,DUOUT,DIROUT,DIRUT
 N DIR,DIRB,LEXFI,LEXHLP,LEXLAST,LEXS S LEXMAX=+($G(LEXMAX)),LEXTXT=$G(LEXTXT)
 Q:+($G(LEXIT))>0 "^^" Q:LEXMAX'>1 ""
 S DIR("A")=" Select Next Character 1-"_LEXMAX_": "
 S LEXHLP=" Answer must be from 1 to "_LEXMAX_" or a character."
 S DIR("PRE")="S X=$$MULSP^LEX10PLS(X)"
 S (DIR("?"),DIR("??"))="^D MULSH^LEX10PLS"
 S DIR(0)="FAO^1:3" D ^DIR I X["^^"!($D(DTOUT))!($D(DIROUT)) S LEXIT=1,X="^^" Q X
 Q:X["^"!($D(DIRUT))!($D(DUOUT)) "^"  Q:'$L(X) ""
 I +Y>0,$L($G(LEX("E",+Y))) S X=$G(LEX("E",+Y)) Q X
 Q X
MULSH ;   Multiple Entries - Selection Help
 I $L($G(LEXHLP)) W !,$G(LEXHLP) Q
 Q
MULSP(X) ;   Multiple Entries - Pre-Process
 N LEXM,LEXP1,LEXP2,LEXO,LEXN,LEXA S (LEXM,X)=$$UP^XLFSTR($G(X)) Q:'$L(X) X
 S LEXP1=$E(LEXM,1),LEXP2=$E(LEXM,2,$L(LEXM)),LEXA="" S:$L(LEXP2) LEXA=$G(LEX("E",LEXP2))
 I $D(LEX("B",LEXM)) S X=LEXM Q X
 I $D(LEX("C",LEXM)) S X=$G(LEX("C",LEXM)) Q X
 S:$L(LEXM)=1 LEXO=$C($A(LEXM)-1)_"~"
 S:$L(LEXM)>1 LEXO=$E(LEXM,1,($L(LEXM)-1))_$C($A($E(LEXM,$L(LEXM)))-1)_"~"
 S LEXN="" S:$L(LEXO) LEXN=$O(LEX("D",LEXO)) S:$E(LEXN,1,$L(LEXM))'=LEXM LEXN=""
 I $L(LEXN) I $L($G(LEX("D",LEXN))) S X=$G(LEX("D",LEXN)) Q X
 I LEXP1="?",$L(LEXP2),$L(LEXA)=1 I $D(LEX("F",LEXA)) D MULSEH S X="??" Q X
 Q:LEXM["?" "??"  Q:'$L(LEXM) ""  Q:LEXM["^^" "^^"  Q:LEXM["^" "^"
 S:'$D(LEX("B",X)) X="??"
 Q X
MULSEH ; Extended Help
 N LEXT,LEXD,LEXE,LEXI,LEXP,LEXII,LEXIC S LEXA=$G(LEXA) Q:$L(LEXA)'=1  Q:'$D(LEX("F",LEXA))
 S LEXT=$G(LEX("F",LEXA,"DESC"))
 S LEXD=$G(LEX("F",LEXA,"META","Definition"))
 S LEXE=$G(LEX("F",LEXA,"META","Explanation"))
 S LEXY=$G(LEX("F",LEXA,"META","Includes/Examples",1))
 S LEXC=0 I $L(LEXT) S LEXC=LEXC+1 W:LEXC=1 ! W !," ",LEXT
 K LEXT S LEXT(1)=LEXD I $L(LEXT(1)) D
 . N LEXI D PR(.LEXT,(79-15)) Q:'$L($G(LEXT(1)))
 . W !!," Definition:",?15,$G(LEXT(1)) S LEXC=LEXC+1
 . S I=1 F  S I=$O(LEXT(I)) Q:+I'>0  W !,?15,$G(LEXT(I))
 K LEXT S LEXT(1)=LEXE I $L(LEXT(1)) D
 . N LEXI D PR(.LEXT,(79-15)) Q:'$L($G(LEXT(1)))
 . W !!," Explanation:",?15,$G(LEXT(1)) S LEXC=LEXC+1
 . S I=1 F  S I=$O(LEXT(I)) Q:+I'>0  W !,?15,$G(LEXT(I))
 S (LEXII,LEXIC)=0
 F  S LEXII=$O(LEX("F",LEXA,"META","Includes/Examples",LEXII)) Q:+LEXII'>0  D
 . N LEXY,LEXT,LEXI S LEXY=$G(LEX("F",LEXA,"META","Includes/Examples",LEXII))
 . S LEXT(1)=LEXY D PR(.LEXT,(79-15)) Q:'$L($G(LEXT(1)))
 . S LEXIC=LEXIC+1 W:LEXIC=1 !!," Include(s):" W:LEXIC'=1 ! W ?15,$G(LEXT(1))
 . S LEXI=1 F  S LEXI=$O(LEXT(LEXI)) Q:+LEXI'>0  W !,?15,$G(LEXT(LEXI))
 I LEXC>0 S LEXC=$$CONT W !
 W:$L($G(IOF)) @IOF
 D:$L($G(LEXTXT)) CUR^LEX10PL(LEXTXT) W !
 W:$D(LEXTEST) !," Next character:  ",!
 S LEXI=0 F  S LEXI=$O(LEX(LEXI)) Q:+LEXI'>0  D
 . W !,?1,$G(LEX(+LEXI))
 Q
 ; 
 ; Miscellaneous
CUR(X) ;   Current Array
 K CUR N INP,PSN
 S INP=$G(X) Q:'$L(INP)  Q:'$D(^LEX(757.033,"AFRAG",31,(INP_" ")))
 S CUR=INP F PSN=1:1:$L(INP)  D
 . N SEC,CHR S SEC=$E(INP,1,PSN),CHR=$E(INP,PSN)
 Q
CL ;   Clear
 K LEXIT
 Q
BUILD ;   Build Selection Array
 D ATTR I LEXTOT'>15 D
 . K LEX N LEXI,LEXC S LEXC=0,LEXI=""
 . F  S LEXI=$O(LEXPCDAT("NEXLEV",LEXI)) Q:'$L(LEXI)  D
 . . N LEXT,LEXH S LEXT=$G(LEXPCDAT("NEXLEV",LEXI,"DESC"))
 . . Q:$L(LEXI)'=1  Q:'$L(LEXT)
 . . S LEXH=$S($D(LEXPCDAT("NEXLEV",LEXI,"META")):" *",1:"")
 . . S LEXC=LEXC+1 S LEX(LEXC)=$J(LEXC,4)_".  ("_BOLD_LEXI_NORM_")  "_LEXT_LEXH
 . . S:$L(LEXI) LEX("C",$$UP^XLFSTR(LEXI))=LEXC
 . . S:$L(LEXT) LEX("D",$$UP^XLFSTR(LEXT))=LEXC
 . . S LEX("B",LEXC)=LEXI
 . . S LEX("E",LEXC)=$$UP^XLFSTR(LEXI)
 . . S LEX(0)=LEXC
 . . I $D(LEXPCDAT("NEXLEV",LEXI,"META")) M LEX("F",LEXC)=LEXPCDAT("NEXLEV",LEXI)
 I LEXTOT>15 D
 . K LEX N LEXI,LEXN,LEXC,LEXD,LEXOFF,LEXXE,LEXXC S LEXOFF=(LEXTOT\2)+(LEXTOT#2) S LEXC=0,LEXI=""
 . S LEXXE=36+($L($G(BOLD)))+($L($G(NORM))),LEXXC=38+($L($G(BOLD)))+($L($G(NORM)))
 . F LEXN=1:1:LEXOFF D
 . . N LEXT,LEXN1,LEXN2,LEXC1,LEXC2,LEXT1,LEXT2,LEXP1,LEXP2,LEXH1,LEXH2
 . . S LEXN1=LEXN,LEXN2=LEXN+LEXOFF,(LEXP1,LEXP2)=""
 . . S LEXC1=$$CD(LEXN1),LEXC2=$$CD((LEXN2))
 . . S LEXT1=$P(LEXC1,"^",2),LEXT2=$P(LEXC2,"^",2)
 . . S:$L(LEXT1)>28 LEXT1=$$SH^LEX10PLA(LEXT1,28)
 . . S:$L(LEXT2)>28 LEXT2=$$SH^LEX10PLA(LEXT2,28)
 . . S LEXC1=$P(LEXC1,"^",1),LEXC2=$P(LEXC2,"^",1)
 . . S LEXP1="" I LEXN1>0,$L(LEXC1),$L(LEXT1) D
 . . . S LEXH1="" S:$D(LEXPCDAT("NEXLEV",LEXC1,"META")) LEXH1=" *"
 . . . S LEXP1=$J(LEXN1,2)_". ("_$G(BOLD)_LEXC1_$G(NORM)_") "_LEXT1_LEXH1
 . . S LEXP2="" I LEXN2>0,$L(LEXC2),$L(LEXT2) D
 . . . S LEXH2="" S:$D(LEXPCDAT("NEXLEV",LEXC2,"META")) LEXH2=" *"
 . . . S LEXP2=$J(LEXN2,2)_". ("_$G(BOLD)_LEXC2_$G(NORM)_") "_LEXT2_LEXH1
 . . S LEXT=$E(LEXP1,1,LEXXE),LEXT=LEXT_$J(" ",(LEXXC-$L(LEXT)))_$E(LEXP2,1,LEXXE)
 . . S LEXC=LEXC+1 S LEX(LEXC)=LEXT
 . . ; Column 1
 . . I +($G(LEXN1))>0,$L(LEXC1)=1 D
 . . . S LEX("B",LEXN1)=LEXN1
 . . . S:$L(LEXC1) LEX("C",$$UP^XLFSTR(LEXC1))=LEXN1,LEX("E",LEXN1)=$$UP^XLFSTR(LEXC1)
 . . . S:$L(LEXT1) LEX("D",$$UP^XLFSTR(LEXT1))=LEXN1
 . . I $L(LEXC1),LEXN1>0 I $D(LEXPCDAT("NEXLEV",LEXC1,"META")) M LEX("F",LEXC1)=LEXPCDAT("NEXLEV",LEXC1)
 . . ; Column 2
 . . I +($G(LEXN2))>0,$L(LEXC2)=1 D
 . . . S LEX("B",LEXN2)=LEXN2
 . . . S:$L(LEXC2) LEX("C",$$UP^XLFSTR(LEXC2))=LEXN2,LEX("E",LEXN2)=$$UP^XLFSTR(LEXC2)
 . . . S:$L(LEXT2) LEX("D",$$UP^XLFSTR(LEXT2))=LEXN2
 . . . ;S LEX("B",LEXN2)=LEXC2,LEX("B",LEXC2)=LEXC2
 . . I $L(LEXC2),LEXN2>0 I $D(LEXPCDAT("NEXLEV",LEXC2,"META")) M LEX("F",LEXC2)=LEXPCDAT("NEXLEV",LEXC2)
 . . S LEX(0)=LEXC
 D KATTR
 Q
CD(X) ;  Character/Description
 N LEXN,LEXI,LEXC,LEXC,LEXE S LEXN=$G(X) Q:+LEXN'>0  S LEXE=0,LEXC="",LEXD="",X=""
 F LEXI=1:1:LEXN Q:LEXE  D  Q:LEXE
 . S LEXC=$O(LEXPCDAT("NEXLEV",LEXC)) I '$L(LEXC) S LEXD="",LEXE=1 Q
 . S LEXD=$G(LEXPCDAT("NEXLEV",LEXC,"DESC"))
 S X=LEXC_"^"_LEXD
 Q X
SH(X) ;   Shorten Text
 S X=$G(X) N LEXR,LEXW
 S LEXR=" and ",LEXW=" & " S:X[LEXR X=$P(X,LEXR,1)_LEXW_$P(X,LEXR,2,299)
 S LEXR=" Systems",LEXW=" Sys" S:X[LEXR X=$P(X,LEXR,1)_LEXW_$P(X,LEXR,2,299)
 S LEXR=" System",LEXW=" Sys" S:X[LEXR X=$P(X,LEXR,1)_LEXW_$P(X,LEXR,2,299)
 ;S LEXR=" Upper ",LEXW=" Up " S:X[LEXR X=$P(X,LEXR,1)_LEXW_$P(X,LEXR,2,299)
 S LEXR="Anatomical ",LEXW="Anat. " S:X[LEXR X=$P(X,LEXR,1)_LEXW_$P(X,LEXR,2,299)
 S LEXR="Subcutaneous",LEXW="Subcut." S:X[LEXR X=$P(X,LEXR,1)_LEXW_$P(X,LEXR,2,299)
 S LEXR="Extremities",LEXW="Extrem." S:X[LEXR X=$P(X,LEXR,1)_LEXW_$P(X,LEXR,2,299)
 Q X
ATTR ;   Screen Attributes
 N X,IOINHI,IOINORM S X="IOINHI;IOINORM" D ENDR^%ZISS S BOLD=$G(IOINHI),NORM=$G(IOINORM)
 Q
KATTR ;   Kill Screen Attributes
 D KILL^%ZISS K BOLD,NORM
 Q
TEST ; Test Array Building
 K LEX N LEXC,LEXDT,LEXHLP,LEXI,LEXIT,LEXM,LEXMAX,LEXP1,LEXP1,LEXPCDAT,LEXSS,LEXTOT,LEXTXT,LEXUP,LEXY,LEXCHR,LEXIT
 S LEXTXT="0CDXXZ",LEXDT=3141010
 S LEXTXT="0C",LEXDT=3141010
 D LOOK^LEX10PL
 Q
FND(X) ;   Found
 N LEXI S X=0,LEXI="" F  S LEXI=$O(LEXPCDAT("NEXLEV",LEXI)) Q:'$L(LEXI)  S X=X+1
 Q X
GETO(X) ;   Get One
 S X=$O(LEXPCDAT("NEXLEV",""))
 Q X
PR(LEX,X) ;   Parse Array
 N DIW,DIWF,DIWI,DIWL,DIWR,DIWT,DIWTC,DIWX,DN,Z,LEXC,LEXI,LEXL
 K ^UTILITY($J,"W") Q:'$D(LEX)  S LEXL=+($G(X)) S:+LEXL'>0 LEXL=79
 S LEXC=+($G(LEX)) S:+($G(LEXC))'>0 LEXC=$O(LEX(" "),-1) Q:+LEXC'>0
 S DIWL=1,DIWF="C"_+LEXL S LEXI=0
 F  S LEXI=$O(LEX(LEXI)) Q:+LEXI=0  S X=$G(LEX(LEXI)) D ^DIWP
 K LEX S (LEXC,LEXI)=0
 F  S LEXI=$O(^UTILITY($J,"W",1,LEXI)) Q:+LEXI=0  D
 . S LEX(LEXI)=$$TM($G(^UTILITY($J,"W",1,LEXI,0))," "),LEXC=LEXC+1
 S:$L(LEXC) LEX=LEXC K ^UTILITY($J,"W")
 Q
TM(X,Y) ;   Trim Character Y - Default " "
 S X=$G(X) Q:X="" X S Y=$G(Y) S:'$L(Y) Y=" "
 F  Q:$E(X,1)'=Y  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=Y  S X=$E(X,1,($L(X)-1))
 Q X
CONT(X) ;   Ask to Continue
 N DIR,DIROUT,DIRUT,DUOUT,DTOUT,Y S DIR(0)="EAO",DIR("A")="     Press Enter to continue"
 S DIR("PRE")="S:X[""?"" X=""??"" S:X[""^"" X=""^""",(DIR("?"),DIR("??"))="^D CONTH^LEX10PLS"
 W ! D ^DIR
 Q ""
CONTH ;      Ask to Continue Help
 W !,"       Press Enter to continue" Q
