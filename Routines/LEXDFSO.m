LEXDFSO ; ISL Default Filter - Sources             ; 09-23-96
 ;;2.0;LEXICON UTILITY;;Sep 23, 1996
 ;
 ; Entry:  S X=$$EN^LEXDFSO
 ;
 ; LEXFIL    Filter (executable)
 ; LEXNAM    Filter Name
 ; LEXPRO    Y/N response to proceed with building filter
 ; LEXSTR    Filter parameters (string)
 ; LEXX      Filter returned
 ;
EN(LEXX) ; Entry point S X=$$EN^LEXDFSO
 N LEXFIL,LEXPRO S LEXFIL=0 D INTRO S LEXPRO=$$PRO
 Q:LEXPRO["^" LEXPRO Q:LEXPRO'=1 "^No filter selected"
 S LEXX=$$EN^LEXDCCC S:LEXX="^" LEXX="^^"
 Q:LEXX["^^" "^^"
 Q:$P(LEXX,"^",1)="" "^No filter selected"
 D:$P(LEXX,"^",1)'="" ASSEM
 Q LEXX
INTRO ; Introduction/Proceed
 N LEXSAB D SAB
 W !!,"You will be provided with ",LEXSAB," classifications systems to either include"
 W !,"or exclude during Lexicon look-up.  If you select a classification system"
 W !,"(i.e., ICD) to be included, any terms which qualify during the search and are"
 W !,"linked to an ""included"" classification code (example ICD code) will be "
 W !,"included in the selection list."
 Q
SAB N LEXI S LEXI="",LEXSAB=0
 F  S LEXI=$O(^LEX(757.03,"B",LEXI)) Q:LEXI=""  D
 . Q:'$D(^LEX(757.02,"ASRC",$E(LEXI,1,3)))
 . S:'$D(^TMP("LEXTSAB",$J,$E(LEXI,1,3))) ^TMP("LEXTSAB",$J,$E(LEXI,1,3))="",LEXSAB=LEXSAB+1
 K ^TMP("LEXTSAB",$J)
 Q
PRO(LEXX) ; OK to proceed Y/N
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT W !!
 S DIR("A")="Do you wish to continue:  ",DIR("B")="YES"
 S DIR("?")="Answer Yes or No",DIR("??")="^D PROH^LEXDFSO"
 S DIR(0)="YAO" D ^DIR S LEXX=Y Q LEXX
PROH ; Proceed help
 W !!,?2,"Answer"
 W !!,?4,"Yes     Continue to build a filter based on Classification Codes"
 W !,?4,"No      Exit without building a filter",! Q
ASSEM ; Assemble the return value FILTER^NAME
 N LEXNAM,LEXFIL S (LEXNAM,LEXFIL)="",LEXFIL=$P(LEXX,"^",1)
 I $L($G(LEXFIL)) S LEXFIL="I $$SO^LEXU(Y,"_""""_LEXFIL_""""_")"
 I LEXFIL[U S LEXNAM=$$NAME^LEXDM3 I LEXNAM="^^" S LEXX="^^"
 S:LEXX["^^" LEXFIL="",LEXNAM="^" S LEXX=LEXFIL_"^"_LEXNAM Q
