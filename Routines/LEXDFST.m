LEXDFST ; ISL Default Filter - Semantic Types      ; 09-23-96
 ;;2.0;LEXICON UTILITY;;Sep 23, 1996
 ;
 ; Entry:  S X=$$EN^LEXDFST
 ;
 ; LEXFIL    Filter (executable)
 ; LEXNAM    Filter Name
 ; LEXPRO    Y/N response to proceed with building filter
 ; LEXSTR    Filter parameters (string)
 ; LEXX      Filter returned
 ;
EN(LEXX) ; Entry point S X=$$EN^LEXDFST
 N LEXFIL,LEXPRO S LEXFIL=0 D INTRO S LEXPRO=$$PRO
 Q:LEXPRO["^" LEXPRO Q:LEXPRO'=1 "^No filter selected"
 S LEXX=$$EN^LEXDFSB Q:LEXX["^^" "^^"
 Q:$P(LEXX,"^",1)="" "^No filter selected"
 D:$P(LEXX,"^",1)'="" ASSEM
 Q LEXX
INTRO ; Introduction/Proceed
 W @IOF
 W !!,"You will be provided with ",($P(^LEX(757.11,0),U,4))-1," semantic classes.  By selecting a semantic"
 W !,"class, each term which is found during a search of the Lexicon, and belongs"
 W !,"to that class will be displayed for your selection.  Additionally, each"
 W !,"semantic class contains semantic types (or sub-category) which may be excluded"
 W !,"during the search.  Terms belonging to an ""included"" semantic class will be"
 W !,"displayed unless they also belong to an ""excluded"" semantic type."
 Q
PRO(LEXX) ; OK to proceed Y/N
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT W !!
 S DIR("A")="Do you wish to continue:  ",DIR("B")="YES"
 S DIR("?")="Answer Yes or No",DIR("??")="^D PROH^LEXDFST"
 S DIR(0)="YAO" D ^DIR S LEXX=Y Q LEXX
PROH ; Proceed help
 W !!,?2,"Answer"
 W !!,?4,"Yes     Continue to build a filter based on Semantic Types"
 W !,?4,"No      Exit without building a filter",! Q
ASSEM ; Assemble the return value FILTER^NAME
 N LEXNAM,LEXFIL S (LEXNAM,LEXFIL)="",LEXFIL=$P(LEXX,"^",1)
 I $L($G(LEXFIL)) S LEXFIL="I $$SC^LEXU(Y,"_""""_LEXFIL_""""_")"
 I LEXFIL[U S LEXNAM=$$NAME^LEXDM3 I LEXNAM="^^" S LEXX="^^"
 S:LEXX["^^" LEXFIL="",LEXNAM="^" S LEXX=LEXFIL_"^"_LEXNAM Q
