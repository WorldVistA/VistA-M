LEXAFIL ; ISL Lookup Filter                        ; 09-23-96
 ;;2.0;LEXICON UTILITY;;Sep 23, 1996
 ;
 ; S LEXFILR=$$EN^LEXAFIL(LEXFIL,LEXE)
 ;
 ;   LEXE    Internal Entry Number (IEN) for an Expression in #757.01
 ;   LEXFIL  DIC("S")
 ;
 ; Returns 1 (true) or 0 (false)
 ;
EN(LEXFIL,Y) ; Process Search Filter
 S LEXFIL=$G(LEXFIL),Y=+($G(Y))
 Q:'$L(LEXFIL) 1 Q:Y=0 0 Q:'$D(^LEX(757.01,Y,0)) 0
 X LEXFIL S Y=$T Q Y
