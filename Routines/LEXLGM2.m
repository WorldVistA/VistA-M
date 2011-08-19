LEXLGM2 ; ISL Lexicon Survey (GBL/DEF/XT/OPT/RTN) ; 09-23-96
 ;;2.0;LEXICON UTILITY;;Sep 23, 1996
 ;
 Q
POST D OGBL,NGBL,UDEF,MTLU,OOPT,NOPT,SPLL,PLRTN
 Q
OGBL ; Old Globals
 N LEXS S LEXS=""
 S:$D(^GMP(757.01,0)) LEXS="    ^GMP Global not Deleted"
 I $D(^GMPT(757.2,0)),LEXS="" D  Q
 . S LEXS="    ^GMPT Global not Deleted" D:$L($G(LEXS)) SET^LEXLGM($G(LEXS))
 I $D(^GMPT(757.2,0)),LEXS'="" D  Q
 . S LEXS="    ^GMP and ^GMPT not Deleted" D:$L($G(LEXS)) SET^LEXLGM($G(LEXS))
 I LEXS="" S LEXS="    Old Globals were Deleted"
 D:$L($G(LEXS)) SET^LEXLGM($G(LEXS)) Q
NGBL ; New Globals
 N LEXS S LEXS=""
 I $D(^LEX),$D(^LEXT) D  Q
 . S LEXS="    New Globals are Installed" D SET2^LEXLGM($G(LEXS))
 I $D(^LEX),'$D(^LEXT) D  Q
 . S LEXS="    Only ^LEX was Installed" D SET2^LEXLGM($G(LEXS))
 I '$D(^LEX),$D(^LEXT) D  Q
 . S LEXS="    Only ^LEXT was Installed" D SET2^LEXLGM($G(LEXS))
 I '$D(^LEX),'$D(^LEXT) D  Q
 . S LEXS="    New Globals were not Installed" D SET2^LEXLGM($G(LEXS))
 D:$L($G(LEXS)) SET2^LEXLGM($G(LEXS)) Q
 Q
UDEF ; User Defaults
 N LEXS S LEXS=""
 I $D(^LEXT(757.2,1,200))!($D(^LEXT(757.2,4,200))) D
 . S LEXS="    User Defaults Transferred" D SET^LEXLGM(LEXS)
 I LEXS="" S LEXS="    User Defaults not found" D SET^LEXLGM(LEXS)
 Q
 ;
MTLU ; Multi-Term Lookup Utility
 N LEXS S LEXS=""
 I $D(^XT(8984.4)),'$D(^XT(8984.4,757.01)) D  Q
 . S LEXS="    Lexicon removed from MTLU" D SET2^LEXLGM(LEXS)
 I $D(^XT(8984.4)),$D(^XT(8984.4,757.01)) D  Q
 . S LEXS="    Lexicon was not removed from MTLU" D SET2^LEXLGM(LEXS)
 S LEXS="    Status of MTLU Unknown" D SET2^LEXLGM(LEXS)
 Q
 ;
OOPT ; Old Options
 N LEXS S LEXS=""
 I $O(^DIC(19,"B","GMPT "))["GMPT " S LEXS="    Old Options were not Deleted" D:$L(LEXS) SET^LEXLGM(LEXS) Q
 I $O(^DIC(19,"B","GMPT "))'["GMPT " S LEXS="    Old Options were Deleted"
 D:$L(LEXS) SET^LEXLGM(LEXS) Q
 ;
NOPT ; New Options
 N LEXS S LEXS=""
 I $O(^DIC(19,"B","LEX "))["LEX " S LEXS="    New Options are Installed" D:$L(LEXS) SET2^LEXLGM(LEXS) Q
 I $O(^DIC(19,"B","LEX "))'["LEX " S LEXS="    New Options are not Installed"
 D:$L(LEXS) SET2^LEXLGM(LEXS) Q
 ;
SPLL ; Special Lookup
 N LEXS S LEXS="" S LEXS=$G(^DD(757.01,0,"DIC"))
 S:LEXS'="" LEXS="    Special Lookup is "_LEXS
 D:$L(LEXS) SET^LEXLGM(LEXS) Q
 ;
PLRTN ; Problem List Routines
 N LEXS,LEXCHK,LEXSTAT S LEXSTAT=""
 F LEXCHK="GMPLBLDC^LEX(757.01","GMPLENFM^LEX(757.01","GMPLHIST^LEX(757.01","GMPLUTL1^LEX(757.01","GMPLX^LEX(757.01" S LEXSTAT=LEXSTAT_$$CHKR(LEXCHK)
 S LEXS=$S(LEXSTAT="11111":"    Problem List calls ^LEX     ",1:"    Problem List calls ^GMP     ")
 D SET2^LEXLGM(LEXS) S:LEXSTAT'="11111" LEXQ=1 Q
CHKR(LEXCHK) ; Check routines for LEX
 N LEXRTN,LEXS,LEXI,LEXOK
 S LEXRTN=$P(LEXCHK,"^",1),LEXS=$P(LEXCHK,"^",2),LEXOK=0
 F LEXI=1:1 Q:'$L($T(+LEXI^@LEXRTN))  I $T(+LEXI^@LEXRTN)[LEXS S LEXOK=1
 S LEXCHK=LEXOK Q LEXCHK
