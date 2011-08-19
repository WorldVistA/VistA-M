LEXDFLC ; ISL Default Filter - Create              ; 09-23-96
 ;;2.0;LEXICON UTILITY;;Sep 23, 1996
 ;
 ; Entry:  S X=$$EN^LEXDFLC
 ;
 ; Function returns a multi piece string
 ;  
 ; $Piece  1-X
 ;
 ;         Executable MUMPS code to be used as
 ;         a filter (screen DIC("S") during
 ;         searches
 ;  
 ; $Piece  Last piece
 ;
 ;         Name of the filter selected i.e., 
 ;         "Problem List"  This will be null only
 ;         when user input is "^^"
 ;
EN(LEXX) ; Entry point S X=$$EN^LEXDFLC
 N LEXFLT S LEXFLT=$$EN^LEXDFLT,LEXX=""
 Q:LEXFLT["^^" "^^" Q:LEXFLT["^" "^"
 Q:LEXFLT=0 "^No filter created"
 S:LEXFLT=1 LEXX=$$EN^LEXDFST
 S:LEXFLT=2 LEXX=$$EN^LEXDFSO
 S:LEXFLT=3 LEXX=$$EN^LEXDFSS
 Q:LEXX["^^" "^No filter created"
 Q:LEXX="" "I 1^User Defined"
 Q LEXX
