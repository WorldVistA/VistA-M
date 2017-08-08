LEXINF4 ;ISL/KER - Information - Lookup ;05/23/2017
 ;;2.0;LEXICON UTILITY;**103**;Sep 23, 1996;Build 2
 ;               
 ; Global Variables
 ;    ^LEX(757.02         SACC 1.3
 ;    ^LEX(757.03         SACC 1.3
 ;    ^TMP("LEXINFLK"     SACC 2.3.2.5.1
 ;    ^TMP("LEXINFS"      SACC 2.3.2.5.1
 ;               
 ; External References
 ;    FIND^DIC            ICR   2051
 ;    ^DIR                ICR  10026
 ;    ^LEXA1              Special Lookup
 ;    $$DT^XLFDT          ICR  10103
 ;    $$UP^XLFSTR         ICR  10104
 ;               
TERM(X) ; Get Term
 ; 
 ; Input
 ; 
 ;   X       Date, optional, default is TODAY
 ;   
 ; Output
 ; 
 ;   $$TERM  2 piece "^" delimited string
 ;             1    Pointer to Expression file #757.01
 ;             2    Expression
 ;               
 N DIC,LEXVDT,Y S LEXVDT=$$DT^XLFDT S:$G(X)?7N LEXVDT=$G(X) K X S DIC("S")="I 1" D ^LEXA1
 S X=Y
 Q X
CODE(X) ; Get Code
 ; 
 ; Input
 ; 
 ;   None
 ;   
 ; Output
 ; 
 ;   $$CODE  6 piece "^" delimited string
 ;             1    Code
 ;             2    Coding System
 ;             3    Expression
 ;             4    Pointer to CODES file 757.02
 ;             5    Pointer to CODING SYSTEM file 757.03
 ;             6    Pointer to EXPRESSIONS file 757.01
 ;    
 N DIR,DTOUT,DUOUT,DIRUT,DIROUT,DIC,DTOUT,DUOUT
 S DIR(0)="FAO^2:40",DIR("PRE")="S X=$$CODEP^LEXINF4($G(X))",DIR("A")=" Select Code:  "
 S (DIR("?"),DIR("??"))="^D CODEH^LEXINF4" D ^DIR Q:'$L(X)&('$D(DTOUT)) "-1^Valid code not entered"
 Q:$D(DTOUT) "-1^Timed out"  Q:X["^"&(X'["^^") "-1^Exit without entering a valid code"
 Q:X["^^" "-1^Abort without entering a valid code" S X=$$CODELK(Y)
 Q X
CODEP(X) ;   Code Preprocessing
 N LEXINP,LEXO,LEXCTL,LEXSBS,LEXOK,LEXSRS S LEXINP=$G(X)
 Q:'$L(LEXINP) ""  Q:LEXINP="^" "^"  Q:LEXINP["^"&(LEXINP'["^^") "^"  Q:LEXINP["^^" "^^"
 Q:LEXINP["?" "??"  Q:$L(LEXINP)'>1 "??"
 S LEXSRS="^1^30^2^31^3^4^57^6^17^56^"
 S LEXO=$E(LEXINP,1,($L(LEXINP)-1))_$C($A($E(LEXINP,$L(LEXINP)))-1)_"~ ",LEXCTL=LEXINP,LEXOK=0
 F  S LEXO=$O(^LEX(757.02,"CODE",LEXO)) Q:'$L(LEXO)!($E(LEXO,1,$L(LEXCTL))'=LEXCTL)  Q:LEXOK  D  Q:LEXOK
 . N LEXSIEN S LEXSIEN=0 F  S LEXSIEN=$O(^LEX(757.02,"CODE",LEXO,LEXSIEN)) Q:+LEXSIEN'>0  D
 . . N LEXND S LEXND=$G(^LEX(757.02,+LEXSIEN,0)) Q:$P(LEXND,"^",5)'>0  Q:LEXSRS'[("^"_$P(LEXND,"^",3)_"^")  S LEXOK=1
 Q:LEXOK'>0 "??"  S X=LEXINP
 Q X
CODEH ;   Code Help
 W !,?5,"Enter a full or partial code from one of the following"
 W !,?5,"coding systems:",!
 W !,?10,"ICD   ICD-9-CM          10D   ICD-10-CM"
 W !,?10,"ICP   ICD-9 Proc        10P   ICD-10-PCS"
 W !,?10,"CPT   CPT-4             CPC   HCPCS"
 W !,?10,"DS4   DSM-IV            SCC   TITLE 38"
 W !,?10,"SCT   SNOMED CT         BIR   BI-RADS"
 Q
CODELK(X) ;   Lookup Code
 K ^TMP("LEXINFLK",$J) N LEXVAL,LEXI,LEXIDX,LEXMSG,LEXTAR,LEXCT,DIR,DTOUT,DUOUT,DIROUT,DIRUT
 S LEXVAL=$G(X),LEXCT=0 Q:'$L(LEXVAL) 0  S LEXIDX="CODE",LEXTAR="^TMP(""LEXINFLK"",$J)"
 D FIND^DIC(757.02,,".01EI;1EI;2EI",,LEXVAL,,LEXIDX,"I $$DICS^LEXINF4(+Y)>0",,LEXTAR,"LEXMSG")
 K ^TMP("LEXINFS",$J) S LEXI=0 F  S LEXI=$O(^TMP("LEXINFLK",$J,"DILIST","ID",LEXI)) Q:+LEXI'>0  D
 . N LEXEX,LEXSO,LEXSR,LEXSAB,LEXSRC,LEXNOM,LEXCODE,LEXEXP,LEXA,LEXSTR,LEXSIEN
 . S LEXSIEN=+($G(^TMP("LEXINFLK",$J,"DILIST",2,LEXI)))
 . S (LEXA(1),LEXEXP)=$G(^TMP("LEXINFLK",$J,"DILIST","ID",LEXI,.01,"E"))
 . S LEXEX=$G(^TMP("LEXINFLK",$J,"DILIST","ID",LEXI,.01,"I"))
 . S LEXCODE=$G(^TMP("LEXINFLK",$J,"DILIST","ID",LEXI,1,"E"))
 . S LEXSO=$G(^TMP("LEXINFLK",$J,"DILIST","ID",LEXI,1,"I"))
 . S LEXSAB=$G(^TMP("LEXINFLK",$J,"DILIST","ID",LEXI,2,"E"))
 . S LEXSR=$G(^TMP("LEXINFLK",$J,"DILIST","ID",LEXI,2,"I"))
 . S:$L(LEXSAB) LEXSRC=$O(^LEX(757.03,"ASAB",LEXSAB,0))
 . S:+LEXSRC>0 LEXNOM=$P($G(^LEX(757.03,+LEXSRC,0)),"^",2)
 . S:$L(LEXNOM) ^TMP("LEXINFLK",$J,"DILIST","ID",LEXI,2)=LEXNOM
 . S ^TMP("LEXINFS",$J,LEXI,0)=LEXSIEN
 . S ^TMP("LEXINFS",$J,LEXI,"SO")=LEXCODE
 . S ^TMP("LEXINFS",$J,LEXI,"EX")=LEXEX_"^"_LEXEXP
 . S ^TMP("LEXINFS",$J,LEXI,"SR")=LEXSR_"^"_LEXNOM
 . S ^TMP("LEXINFS",$J,LEXI,"OUT")=LEXCODE_"^"_LEXNOM_"^"_LEXEXP_"^"_LEXSIEN_"^"_LEXSR_"^"_LEXEX
 . S LEXLEN=$L(LEXCODE)+$L(LEXNOM)+6 D PR^LEXU(.LEXA,(70-LEXLEN))
 . S LEXSTR=LEXCODE_"  ("_LEXNOM_")  "_LEXA(1)
 . S ^TMP("LEXINFLK",$J,"DILIST","ID","LEX",LEXI,1)=LEXSTR
 . S ^TMP("LEXINFS",$J,LEXI,"A",1)=LEXSTR
 . S LEXCT=LEXCT+1
 . K LEXA(1) I $D(LEXA) D PR^LEXU(.LEXA,56) D
 . . N LEXL S LEXL=0 F  S LEXL=$O(LEXA(LEXL)) Q:+LEXL'>0  D
 . . . N LEXT,LEXS S LEXT=$G(LEXA(LEXL)) Q:'$L(LEXT)
 . . . S LEXT="         "_LEXT
 . . . S LEXS=$O(^TMP("LEXINFLK",$J,"DILIST","ID","LEX",LEXI," "),-1)+1
 . . . S ^TMP("LEXINFLK",$J,"DILIST","ID","LEX",LEXI,LEXS)=LEXT
 . . . S ^TMP("LEXINFS",$J,LEXI,"A",LEXS)=LEXT
 . S ^TMP("LEXINFLK",$J,"DILIST","ID","MAT")=LEXCT
 . S ^TMP("LEXINFS",$J,0)=LEXCT
 K ^TMP("LEXINFLK",$J),LEXMSG,LEXTAR
 S X=$$CODEASK
 Q X
CODEASK(X) ;   Ask for Selection
 N LEXIT,LEXL,LEXTOT,DTOUT,DUOUT,DIROUT,DIRUT S LEXL=+($G(X)) S:LEXL'>0 LEXL=5
 S LEXTOT=+($G(^TMP("LEXINFS",$J,0))),LEXIT=0 Q:+LEXTOT'>0 "^"
 K X S:+LEXTOT=1 X=$$CODEO(LEXL) S:+LEXTOT>1 X=$$CODEM(LEXL) Q:+X<0 X
 I +X>0,$L($P(X,"^",2)),$L($P(X,"^",3)) D
 . S X=$P(X,"^",2,4000) W "    ",$P(X,"^",2)," code ",$P(X,"^",1),!
 Q X
CODEO(X,LEX) ;     One Code Found
 Q:+($G(LEXIT))>0 "-1^Exit"  N DIR,LEXI,LEXS,LEXC S DIR("A",1)=" One match found",DIR("A",2)=" " S LEXC=2
 S LEXI=1,LEXS=0 Q:'$D(^TMP("LEXINFS",$J,LEXI,"A",1)) "-1^Nothing found"
 F  S LEXS=$O(^TMP("LEXINFS",$J,LEXI,"A",LEXS)) Q:+LEXS'>0  D
 . N LEXT S LEXT=$G(^TMP("LEXINFS",$J,LEXI,"A",LEXS)) S LEXC=LEXC+1
 . S:LEXC=3 DIR("A",LEXC)=("   "_LEXT) S:LEXC>3 DIR("A",LEXC)=("     "_LEXT)
 S LEXC=LEXC+1,DIR("A",LEXC)=" "
 S DIR("A")="  OK? (Yes/No)  ",DIR("B")="Yes",DIR(0)="YAO" W !
 D ^DIR S:X["^^"!($D(DTOUT)) LEXIT=1 S:$D(DTOUT) LEXIT=1 S:$D(DUOUT)!($D(DIROUT))!($D(DIRUT)) LEXIT=1
 S:+$G(Y)'>0 LEXIT=1 Q:$D(DTOUT) "-1^Timed out"  Q:$D(DUOUT)!($D(DIROUT))!($D(DIRUT)) "-1^Exit without selection"
 Q:+$G(Y)'>0 "-1^No selection made" Q:X["^^"!(+($G(LEXIT))>0) "-1^Aborted^"
 S X=$S(+Y>0:$$OUT(1),1:"-1^Selection not made")
 Q X
CODEM(X) ;     Multiple Codes Found
 Q:+($G(LEXIT))>0 "^^"  N LEXI,LEXS,LEXL,LEXNM,LEXMAX,LEXLAST,LEXSS,LEXX,Y
 S (LEXMAX,LEXIT)=0,LEXL=+($G(X)),U="^" S:+($G(LEXL))'>0 LEXL=5 S LEXLAST=$O(^TMP("LEXINFS",$J," "),-1)
 S LEXX=+($G(^TMP("LEXINFS",$J,0))),LEXSS=0 G:+LEXX<2 CODEMQ W ! W:+LEXX>1 !," ",LEXX," matches found" S (LEXNM,LEXI)=0
 F  S LEXI=$O(^TMP("LEXINFS",$J,LEXI)) Q:+LEXI'>0  Q:+LEXSS>0  Q:LEXIT>0  D  Q:LEXIT>0  Q:+LEXSS>0
 . W:LEXI#LEXL=1 ! D CODEMW
 . S LEXMAX=LEXI W:LEXI#LEXL=0 !
 . S:LEXI#LEXL=0 LEXSS=$$CODEMS(LEXMAX) Q:LEXIT>0
 . I LEXMAX=LEXLAST,LEXI#LEXL'=0,+LEXSS'<0 D  Q:LEXIT>0
 . . W ! S LEXSS=$$CODEMS(LEXMAX)
 G CODEMQ
 Q X
CODEMW ;       Write Multiple
 N LEXS S LEXI=+($G(LEXI)),LEXS=0 F  S LEXS=$O(^TMP("LEXINFS",$J,LEXI,"A",LEXS)) Q:+LEXS'>0  D
 . N LEXT S LEXT=$G(^TMP("LEXINFS",$J,LEXI,"A",LEXS)) S:LEXS=1 LEXT=$J(+LEXI,5)_".  "_LEXT
 . S:LEXS>1 LEXT="          "_LEXT W !,LEXT
 Q
CODEMS(X) ;       Select from Multiple Entries
 N DIR,DIRB,LEXFI,LEXHLP,LEXLAST,LEXMAX,LEXS
 Q:+($G(LEXIT))>0 "-1^Exit"
 S LEXMAX=+($G(X)) Q:LEXMAX=0 "-1^No matches found"
 S LEXLAST=$O(^TMP("LEXINFS",$J," "),-1)
 I +($O(^TMP("LEXINFS",$J,LEXMAX)))>0 D
 . S DIR("A")=" Press <RETURN> for more, ""^"" to exit, or Select 1-"_LEXMAX_": "
 I +($O(^TMP("LEXINFS",$J,LEXMAX)))'>0 D
 . S DIR("A")=" Select 1-"_LEXMAX_": "
 S LEXHLP=" Answer must be from 1 to "_LEXMAX_", or <Return> to continue"
 S DIR("PRE")="S:X[""?"" X=""??"""
 S (DIR("?"),DIR("??"))="^D CODEMSH^LEXINF4"
 S DIR(0)="NAO^1:"_LEXMAX_":0" D ^DIR
 I (LEXLAST>LEXMAX) S:'$L(X)&($D(DTOUT)) LEXIT=1 Q:'$L(X)&($D(DTOUT)) "-1^Timed out"
 Q:'$L(X)&(LEXLAST>LEXMAX)&('$D(DTOUT)) "" Q:'$L(X)&(LEXLAST'>LEXMAX)&('$D(DTOUT)) "-1^No selection made"
 S:X["^^" LEXIT=1 S:$D(DTOUT) LEXIT=1 S:$D(DUOUT)!($D(DIROUT))!($D(DIRUT)) LEXIT=1 S:+$G(Y)'>0 LEXIT=1
 Q:X["^^" "-1^Aborted without selection" Q:$D(DTOUT) "-1^Timed out"
 Q:$D(DUOUT)!($D(DIROUT))!($D(DIRUT)) "-1^Exit without selection"
 Q:+$G(Y)'>0 "-1^No selection made" Q:X["^^"!(+($G(LEXIT))>0) "-1^Aborted^"
 Q $S(+Y>0:$$OUT(+Y),1:"")
CODEMSH ;       Select from Multiple Entries Help
 I $L($G(LEXHLP)) W !,$G(LEXHLP) Q
 Q
CODEMQ ;       Quit Multiple
 S X=$G(LEXSS) S:+($G(LEXSS))'>0 X="-1^No selection made" S:+($G(LEXSS))<0&($L($P($G(LEXSS),"^",2))) X=LEXSS
 Q X
 ; 
 ; Miscellaneous
OUT(X) ;   Output Selection
 N LEXFND,LEXCODE,LEXEXP,LEXNOM,LEXOUT,LEXI,LEXS,LEXC S LEXFND=+($G(X)) Q:LEXFND'>0 -1  Q:'$D(^TMP("LEXINFS",$J,LEXFND))
 S LEXSO=$G(^TMP("LEXINFS",$J,LEXFND,0)),LEXEXP=$P($G(^TMP("LEXINFS",$J,LEXFND,"EX")),"^",2),LEXEX=$P($G(^TMP("LEXINFS",$J,LEXFND,"EX")),"^",1)
 S LEXCODE=$G(^TMP("LEXINFS",$J,LEXFND,"SO")),LEXNOM=$P($G(^TMP("LEXINFS",$J,LEXFND,"SR")),"^",2),LEXSR=$P($G(^TMP("LEXINFS",$J,LEXFND,"SR")),"^",1)
 S:$L(LEXCODE) LEXOUT=LEXCODE_"^"_LEXNOM_"^"_LEXEXP_"^"_LEXSO_"^"_LEXSR_"^"_LEXEX S:'$L(LEXCODE) LEXOUT=$G(^TMP("LEXINFS",$J,LEXI,"OUT")) Q:'$L($P(LEXOUT,"^",1)) -1
 S X=LEXFND_"^"_LEXOUT
 Q X
CONT(X,Y) ;   Ask to Continue
 K DTOUT,DUOUT,DIRUT,DIROUT N LEXX,LEXFQ,LEXW,LEXI,LEXC,DIR
 S LEXX=$$UP^XLFSTR($G(X)),LEXFQ=$G(Y) Q:'$L(LEXX) 1  Q:LEXFQ'>0 1
 S LEXW(1)="Searching for """_LEXX_""" requires inspecting "
 S LEXW(2)=LEXFQ_" records to determine if they match the "
 S LEXW(3)="search criteria.  This could take quite some time."
 S LEXW(4)="Suggest refining the search by further specifying "
 S LEXW(5)=""""_LEXX_"."""
 D PR^LEXU(.LEXW,60) S (LEXC,LEXI)=0 F  S LEXI=$O(LEXW(LEXI)) Q:+LEXI'>0  D
 . Q:'$L($G(LEXW(LEXI)))  S LEXC=LEXC+1 S DIR("A",LEXC)="   "_$G(LEXW(LEXI))
 I LEXC>0 S LEXC=LEXC+1,DIR("A",LEXC)=" "
 S DIR("A")=" Do you wish to continue?  (Y/N)  ",DIR("B")="No"
 S DIR(0)="YAO",(DIR("?"),DIR("??"))="^D COH^LEXINF4"
 S DIR("PRE")="S:X[""?"" X=""??""" W ! D ^DIR
 S X=+Y S:$D(DTOUT)!($D(DUOUT))!($D(DIRUT))!($D(DIROUT)) X="^"
 Q X
COH ;   Continue Help
 I $L($G(LEXX))>0 D
 . W !,"   Enter   To"
 . W !,"   'Yes'   continue searching for """,LEXX,"""."
 . W !,"   'No'    refine the search (further specify)"
 . W !,"   '^'     discontinue the search and exit"
 I '$L($G(LEXX))>0 D
 . W !,"   Enter   To"
 . W !,"   'Yes'   continue the search"
 . W !,"   'No'    refine the search (further specify)"
 . W !,"   '^'     discontinue the search and exit"
 Q
DICW(X) ;   DIC Write
 N LEXSIEN,LEXSRC,LEXNOM
 S LEXSIEN=+($G(Y)),LEXSRC=$P($G(^LEX(757.02,+LEXSIEN,0)),"^",3),LEXNOM=$P($G(^LEX(757.03,+LEXSRC,0)),"^",2)
 Q:'$L(LEXNOM) ""  S X="   ("_LEXNOM_")"
 Q X
DICS(X) ;   DIC Screen
 N LEXSIEN S LEXSIEN=+($G(X)) Q:$$PREOK(LEXSIEN)'>0 0  Q:$$SABOK(LEXSIEN)'>0 0
 Q 1
PREOK(X) ;   Preferred Term OK
 N LEXSIEN,LEXPRE S LEXSIEN=+($G(X)),LEXPRE=+($P($G(^LEX(757.02,+LEXSIEN,0)),"^",5)) Q:+LEXPRE'>0 0
 Q 1
SABOK(X) ;   Source OK
 N LEXSIEN,LEXSBS,LEXSRC S LEXSIEN=+($G(X)),LEXSRC=+($P($G(^LEX(757.02,+LEXSIEN,0)),"^",3)),LEXSAB=$P($G(^LEX(757.03,+LEXSRC,0)),"^",1) Q:'$L(LEXSAB) 0
 S LEXSBS="^ICD^10D^ICP^10P^CPT^CPC^BIR^DS4^SCC^SCT^" Q:LEXSBS'[("^"_LEXSAB_"^") 0
 Q 1
TM(X,Y) ;   Trim Character Y - Default " "
 S X=$G(X) Q:X="" X  S Y=$G(Y) S:'$L(Y) Y=" "
 F  Q:$E(X,1)'=Y  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=Y  S X=$E(X,1,($L(X)-1))
 Q X
