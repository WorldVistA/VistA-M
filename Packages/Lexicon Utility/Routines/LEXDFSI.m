LEXDFSI ; ISL Default Filter - Include Semantics   ; 09-23-96
 ;;2.0;LEXICON UTILITY;;Sep 23, 1996
 ;
 ;
 ; Called from LEXDFSB (set the INCLUDE/EXCLUDE string)
 ;
 ; LEXC      Counter
 ; LEXCC     Semantic Class Mnemonic
 ; LEXCCN    Semantic Class Counter
 ; LEXCCOK   Semantic Class OK (Y/N)
 ; LEXCCR    Semantic Class Pointer in #757.11
 ; LEXF      Flag for user input
 ; LEXS      Semantic Type Sources from #757.03
 ; LEXX      String returned to LEXDSTS
 ;
EN(LEXX) ; Semantic Type string INCLUDE/EXCLUDE
 K LEXA N LEXF S LEXX="",LEXF=1
 D CLASS Q LEXX
 ;
CLASS ; Semantic Classes
 N LEXCCOK,LEXCC,LEXCCR,LEXCCN S (LEXCCOK,LEXCC)=""
 F  S LEXCC=$O(^LEX(757.11,"B",LEXCC)) Q:LEXCC=""!(LEXCCOK[U)  D
 . S LEXCCOK=0 I LEXCC'="UNK" D  Q:LEXCCOK[U
 . . S LEXCCR=$$IEN(LEXCC),LEXCCN=+($G(LEXCCN))+1
 . . W !!,$J(LEXCCN,2),": ",$$CC(LEXCCR),"   ",$$NAME(LEXCCR),!
 . . D SY(LEXCCR),CAT(LEXCCR)
 . . D:+($G(LEXF)) INCLUDE I LEXCCOK D SAVE(LEXCCR)
 . Q:LEXCCOK["^"  I LEXCCOK D EXCLUDE
 I +($G(LEXF))>0 S LEXX=LEXCCOK
 Q
 ;
SY(LEXX) ; List Classification Systems
 N LEXS,LEXC Q:'$D(^LEX(757.11,LEXX,2,"B"))  S LEXS="",LEXC=0
 W !!,?4,"This Semantic Class contains terms from, or mapped to,"
 W !,?4,"the following classification systems:  ",!
 F  S LEXS=$O(^LEX(757.11,LEXX,2,"B",LEXS)) Q:LEXS=""  D
 . S LEXC=LEXC+1 W:LEXC=1 ! W:LEXC=1 ?8,LEXS
 . W:LEXC=2 ?32,LEXS W:LEXC=3 ?56,LEXS S:LEXC=3 LEXC=0
 W ! Q
CAT(LEXX) ; List semantic types
 N LEXC S LEXC=0 Q:'$D(^LEX(757.11,LEXX,1,0))
 W !!,?4,"Semantic Types:  ",!
 F  S LEXC=$O(^LEX(757.11,LEXX,1,LEXC)) Q:+LEXC=0  D
 . W !,?4,^LEX(757.11,LEXX,1,LEXC,0)
 Q
CC(LEXX) ; Semantic Class Mnemonic
 Q $P(^LEX(757.11,LEXX,0),U,1)
NAME(LEXX) ; Semantic Class Name
 Q $P(^LEX(757.11,LEXX,0),U,2)
IEN(LEXX) ; Internal Entry number based on Semantic Class
 S LEXX=$O(^LEX(757.11,"B",LEXX,0)) Q LEXX
 ;
INCLUDE ; Include a Semantic Classes
 W ! N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR("A")="Include this class:  "
 S (DIR("??"),DIR("?"))="^D INH^LEXDFSI"
 S DIR("B")="YES",DIR(0)="YAO"
 D ^DIR K DIR S LEXCCOK=Y Q
 ;
INH ; Include help
 W !!,"    Semantic Class:  "
 W $$CC(LEXCCR)," - ",$$NAME(LEXCCR) Q
 ;
EXCLUDE ; Exclude Semantic Types
 W ! N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR("A",1)="Do you want to ""exclude"" any of"
 S DIR("A")="the semantic types listed above:  "
 S DIR("B")="NO",(DIR("?"),DIR("??"))="^D EXH^LEXDFSI",DIR(0)="YAO"
 D ^DIR K DIR S LEXCCOK=0 S:Y["^^" LEXCCOK=Y D:+Y>0 EN^LEXDFSE(LEXCCR) Q
EXH ; Exclude help
 W !!,"By including the semantical class ",$$CC(LEXCCR)
 W " you will also be including"
 W !,"all of the semantical types contained within the class." Q
 ;
SAVE(LEXX) ; Save Semantic Class
 Q:LEXCCOK[U  N LEXC S LEXCCOK=1,LEXC=$G(LEXA(0))+1
 S LEXA(0)=LEXC,LEXA(LEXC,0)=$$CC(LEXX),LEXA(LEXC,1,0)=0,LEXA(LEXC,2,0)=0 Q
