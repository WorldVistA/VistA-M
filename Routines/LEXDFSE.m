LEXDFSE ; ISL Default Filter - Exclude Semantics   ; 09-23-96
 ;;2.0;LEXICON UTILITY;;Sep 23, 1996
 ;
 ; Called from LEXDFSI (set the EXCLUDE string)
 ;
 ; LEXC      Counter
 ; LEXCCOK   Semantic Class OK (Y/N)
 ; LEXCCR    Semantic Class Pointer in # 757.11
 ; LEXCLS    Semantic Class
 ; LEXCMN    Semantic Class Mnemonic
 ; LEXCT     Semantic Type Mnemonic (IEN)
 ; LEXCTN    Semantic Type Counter
 ; LEXCTOK   Semantic Type OK (Y/N)
 ; LEXCTR    Semantic Type Pointer in # 757.12
 ; LEXF      Flag for user input
 ; LEXI      Incremental counter
 ; LEXLST    Array (list) of examples
 ; LEXMC     Pointer to Major Concept in # 757
 ; LEXS      Semantic Type Sources from #757.03
 ; LEXSPL    Sample Term of a Semantic Type
 ; LEXX      String returned to LEXDSTI
 ;
EN(LEXCCR) ; Exclude types
 N LEXF S LEXF=1 D TYPES(LEXCCR) Q
TYPES(LEXCCR) ; Semantic Types
 N LEXCTOK,LEXCT,LEXCTR,LEXCTN,LEXCMN,LEXCLS
 S LEXCTOK="",LEXCT=0,LEXCMN=$$MNEMONIC(LEXCCR)
 F  S (LEXCT,LEXCTR)=$O(^LEX(757.12,"C",LEXCMN,LEXCT)) Q:+LEXCT=0!(LEXCTOK[U)  D  Q:LEXCTOK[U
 . Q:'$D(^LEX(757.12,LEXCTR,1,"B"))
 . Q:'$D(^LEX(757.12,LEXCTR,0))  S LEXCTN=$S('$D(LEXCTN):1,1:LEXCTN+1)
 . W !!,"Semantic Type:  ",$P(^LEX(757.12,LEXCTR,0),U,2)
 . D STYPE(LEXCTR),EXAMPLE(LEXCTR) D:+($G(LEXF)) EXCLUDE
 Q
STYPE(LEXCTR) ; Sources of Semantic Type
 I '$D(^LEX(757.12,LEXCTR,1,"B")) D  Q
 . W !!,?5,"There are no terms with this Semantic Type in "
 . W "the Lexicon"
 W !!,?5,"This Semantic Type contains terms from, or mapped to,"
 W !,?5,"the following classification systems:  ",!
 N LEXS,LEXC S LEXS="",LEXC=0
 F  S LEXS=$O(^LEX(757.12,LEXCTR,1,"B",LEXS)) Q:LEXS=""  D
 . S LEXC=LEXC+1 W:LEXC=1 !,?9,LEXS W:LEXC=2 ?33,LEXS
 . W:LEXC=3 ?57,LEXS S:LEXC=3 LEXC=0
 Q
EXAMPLE(LEXX) ; List examples
 W !!,?5,"Examples of Semantic Type:   ",$$NAME(LEXX),!
 I '$D(^LEX(757.1,"ASTT",LEXX)) D  Q
 . W !,?8,"No examples found"
 N LEXI,LEXSPL,LEXMC,LEXC S LEXMC="",LEXC=0
 F LEXI=1:1:10 D  Q:+LEXC>2
 . S LEXMC=$O(^LEX(757.1,"ASTT",LEXX,LEXMC)) Q:+LEXMC'>0
 . S LEXSPL=$$SAMPLE(LEXMC)
 . I '$D(LEXLST($$UP^XLFSTR(LEXSPL))) D
 . . S LEXC=LEXC+1 W !,?5,$J(LEXC,2),": ",LEXSPL
 . S LEXLST($$UP^XLFSTR(LEXSPL))=""
 K LEXLST
 Q
MNEMONIC(LEXX) ; Semantic Class Mnemonic
 Q $P(^LEX(757.11,LEXX,0),U,1)
CLSNAME(LEXX) ; Semantic Class Name
 Q $P(^LEX(757.11,LEXX,0),U,2)
NAME(LEXX) ; Semantic Type Name
 Q $P($G(^LEX(757.12,LEXX,0)),"^",2)
SAMPLE(LEXX) ; Sample term of a Semantic Type
 N LEXS S LEXS=$E(^LEX(757.01,+(^LEX(757,LEXX,0)),0),1,70)
 S:LEXS[" (" LEXS=$P(LEXS," (",1)
 S:LEXS[" <" LEXS=$P(LEXS," <",1)
 S LEXX=LEXS Q LEXX
EXCLUDE ; Exclude Semantic Type?  (Y/N)
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT W !
 S DIR("A")="Exclude this type:  "
 S DIR("B")="NO",(DIR("?"),DIR("??"))="^D EXH^LEXDFSE"
 S DIR(0)="YAO" D ^DIR K DIR S:Y["^" LEXCTOK=U
 S:Y["^^" (LEXCCOK,LEXCTOK)="^^" Q:Y["^^"  Q:LEXCTOK[U
 D:+Y>0 REM D:+Y'>0 SAV Q
EXH ; Exclude help
 W !!,?4,"Include semantic class:       "
 W $$MNEMONIC(LEXCCR)," - ",$$CLSNAME(LEXCCR)
 W !,?4,"Excluding the semantic type:  ",$$NAME(LEXCTR) Q
REM ; Remove Semantic Type from the list (excluded)
 Q:+($G(LEXA(0)))=0  S LEXCTOK=0
 N LEXC S LEXC=+($G(LEXA(0)))
 S LEXA(LEXC,2,0)=$S('$D(LEXA(LEXC,2,0)):1,1:LEXA(LEXC,2,0)+1)
 S LEXA(LEXC,2,LEXA(LEXC,2,0),0)=LEXCTR Q
SAV ; Save the Semantic Type (included)
 Q:+($G(LEXA(0)))=0  S LEXCTOK=1 D 
 N LEXC S LEXC=+($G(LEXA(0)))
 S LEXA(LEXC,1,0)=$S('$D(LEXA(LEXC,1,0)):1,1:LEXA(LEXC,1,0)+1)
 S LEXA(LEXC,1,LEXA(LEXC,1,0),0)=LEXCTR Q
