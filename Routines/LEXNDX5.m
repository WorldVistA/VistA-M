LEXNDX5 ; ISL Set/kill indexes (Part 5) Link       ; 09-23-96
 ;;2.0;LEXICON UTILITY;;Sep 23, 1996
 ;
EXCL ; Is a term used with an "Exclusive" meaning?
 Q:'$D(LEXREP)!('$D(LEXBY))
 S LEXEXCL=1 I $D(^LEX(757.01,"AWRD",LEXREP)) D
 . W !,LEXREP," is used as follows:  ",!
 . S (LEXCTR,LEXREC)=0 F  S LEXREC=$O(^LEX(757.01,"AWRD",LEXREP,LEXREC)) Q:+LEXREC=0  D
 . . S LEXCTR=LEXCTR+1 W !,$J(LEXCTR,4),": ",^LEX(757.01,LEXREC,0)
 . . I LEXCTR#16=0 D CONT
ASKEX . ; Ask, "is it exclusive?"
 . W !!,"Based on the reference",$S(LEXCTR>1:"s",1:"")," shown above, does ",LEXREP
 . W !,"exclusively refer to ",LEXBY
ASKEX2 . ; Get response
 . S %=2 D YN^DICN S LEXEXCL=$S(%=2:0,%=-1:0,1:%) Q:%'=0
 . I '% D EXCLHLP G ASKEX2
 . G ASKEX
 Q
EXCLHLP ; Help to decide if the term use is "Exclusive"
 W !!,"If ",LEXREP," exclusively refers to ",LEXBY,", answer"
 W !,"""Yes"" and ",LEXREP," will always be replaced by",LEXBY,"."
 W !!,"If ",LEXREP," refers to concepts other than",LEXBY,", answer"
 W !,"""No"" and begin linking ",LEXREP," to ",LEXBY," (in each"
 W !,"occurrence where the two terms have the same meaning)"
 W !!,"Is ",LEXREP," used exclusively"
 Q
CONT ; Continue?
 W ! N X,Y,DTOUT,DUOUT,DIRUT,DIROUT S DIR("A")="Press <Return> to continue  ",DIR("?")="Additional information is available, press <Return> to continue ",DIR(0)="EA" D ^DIR K DIR W ! Q
ANYWAY ; Term was not found, ask to link the term anyway
 Q:'$D(LEXREP)!('$D(LEXBY))  Q:$D(^LEX(757.01,"AWRD",LEXREP))  N LEXANYW S LEXEXCL=0
 W !!,LEXREP," was not found in the Lexicon"
ANY2 ; Get response
 W !,"Do you wish to link ",LEXREP," to terms",!,"containing ",LEXBY
 S %=1,LEXEXCL=0 D YN^DICN S:%=-1!(%=2) LEXEXCL=1 Q:%'=0
 I '% D ANYHLP G ANY2
 W ! G ANY2
ANYHLP ; Help to decide whether to continue with the linkage
 W !!,"Linking ",LEXREP," to ",LEXREP," will cause the "
 W !,"look-up to include all linked occurences of ",LEXREP
 W !,"to be listed when searching for ",LEXREP,!
 Q
