LEXDFLT ; ISL Default Filter - Filter Type         ; 09-23-96
 ;;2.0;LEXICON UTILITY;;Sep 23, 1996
 ;
 ; Entry:  S X=$$EN^LEXDFLT
 ;
 ; Function returns
 ;
 ;     "^"     Up-arrow
 ;     "^^"    Double up-arrow
 ;      0      None
 ;      1      Filter by Semantic Types
 ;      2      Filter by Classification Codes
 ;      3      Filter by Semantic Types and Classification Codes
 ;
EN(LEXX) ;
 ;
 N DIR,X,Y,DIRUT,DTOUT,DUOUT,DIROUT
 S DIR("A",1)="Filter based on:"
 S DIR("A",3)="   1.  Semantic Types"
 S DIR("A",4)="   2.  Classification Coding Systems"
 S DIR("A",5)="   3.  Semantic Types and Classification Codes"
 S (DIR("A",2),DIR("A",6))="  "
 S DIR(0)="SAO^1:Filter on Semantic Types;2:Filter on Classification Codes;3:Filter on both Semantic Types and Classification Codes"
 S DIR("A")="Select:  "
 D ^DIR S LEXX=+X S:Y["^" LEXX=Y Q LEXX
