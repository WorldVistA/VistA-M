LEXDFSS ; ISL Default Filter - Semantics/Sources   ; 09-23-96
 ;;2.0;LEXICON UTILITY;;Sep 23, 1996
 ;
 ; Entry:  S X=$$EN^LEXDFSS
 ;
 ; LEXFIL    Filter (executable)
 ; LEXNAM    Filter Name
 ; LEXPRO    Y/N response to proceed with building filter
 ; LEXSTR    Filter parameters (string)
 ; LEXSRC    Classification system (sources) portion of filter
 ; LEXSTY    Semantic Class/Type portion of filter
 ; LEXX      Filter returned
 ;
EN(LEXX) ; Entry point S X=$$EN^LEXDFSS
 N LEXSTY,LEXSRC,LEXFIL,LEXPRO
 S (LEXSTY,LEXSRC,LEXX)="",LEXFIL=0 D INTRO S LEXPRO=$$PRO
 Q:LEXPRO["^" LEXPRO Q:LEXPRO'=1 "^No filter selected"
 S LEXSTY=$$EN^LEXDFSB Q:LEXSTY["^^" "^^"
 S LEXFIL=0 S LEXSRC=$$EN^LEXDCCC Q:LEXSRC["^^" "^^"
 Q:$P(LEXSTY,"^",1)="" "^No filter selected"
 S LEXSTY=$P(LEXSTY,"^",1),LEXSRC=$P(LEXSRC,"^",1)
 Q:'$L((LEXSTY_LEXSRC)) "^No filter selected"
 S LEXFIL=1 I $L(LEXSTY),'$L(LEXSRC) D
 . N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT W !
 . S DIR("A",1)="You have selected semantic classes/types to Include/Exclude in your filter"
 . S DIR("A",2)="but have not selected any classification coding systems to include in the"
 . S DIR("A",3)="filter.  Do you want to contine to build the filter based solely on the"
 . S DIR("A")="semantic classes/types you selected?  "
 . S DIR("B")="YES",DIR("?")="Answer Yes or No",DIR(0)="YAO" D ^DIR
 . K DIR S LEXFIL=0,LEXX="^^" S:+Y>0 LEXFIL=+Y,LEXX=""
 D:LEXFIL ASSEM Q LEXX
INTRO ; Introduction/Proceed
 N LEXSAB D SAB W @IOF
 ;W !,"FILTER BY BOTH SEMANTIC CLASSES/TYPES AND CLASSIFICATION CODES"
 W !!,"This search filter is in two segments.  The first segment limits the search"
 W !,"based on the semantical classification of the terms.  The second segment "
 W !,"limits the search based on classification coding systems."
 W !!,"First, you will be provided with ",($P(^LEX(757.11,0),U,4))-1," semantic classes.  By selecting"
 W !,"a semantic class, each term which is found during a search of the "
 W !,"Lexicon, and belongs to that class, will be displayed for your selection."
 W !,"Additionally, each semantic class contains semantic types (or sub-categories)"
 W !,"which may be excluded during the search  Terms belonging to an ""included"" "
 W !,"semantic class will be displayed unless they also belong to an ""excluded"" "
 W !,"semantic type.  This segment is mandatory (can not be null)."
 ;
 W !!,"Secondly, you will be presented with ",LEXSAB," classification systems to include."
 W !,"By selecting a classification system to include (i.e., ICD), any term which"
 W !,"is linked to a code from that system will be displayed for selection.  "
 W !,"Inclusion by classification code will over ride ""exclusion by sematical"
 W !,"class or type"".  This segment is optional (may be null)."
  K LEXSAB
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
 S DIR("?")="Answer Yes or No",DIR("??")="^D PROH^LEXDFSS"
 S DIR(0)="YAO" D ^DIR S LEXX=Y Q LEXX
PROH ; Proceed help
 W !!,?2,"Answer"
 W !!,?4,"Yes     Build a filter based Semantic Types and Classification Codes"
 W !,?4,"No      Exit without building a filter",! Q
ASSEM ; Assemble the return value FILTER^NAME
 N LEXSTR,LEXNAM,LEXFIL S (LEXNAM,LEXFIL)=""
 I $L($G(LEXSTY)),$D(LEXSRC) D
 . S LEXSTR=LEXSTY
 . I $L($G(LEXSRC)),$G(LEXSRC)'[U S LEXSTR=LEXSTY_";"_LEXSRC
 . S LEXFIL="I $$SC^LEXU(Y,"_""""_LEXSTR_""""_")"
 I LEXFIL[U S LEXNAM=$$NAME^LEXDM3 I LEXNAM="^^" S LEXX="^^"
 S:LEXX["^^" LEXFIL="",LEXNAM="^" S LEXX=LEXFIL_"^"_LEXNAM Q
