LEXDDSS ; ISL Display Defaults - Single User Save  ; 09-23-96
 ;;2.0;LEXICON UTILITY;;Sep 23, 1996
 ;
 ; Saves default elements into the local array LEX
 ;
BLB(LEXX) ; General blank - line - blank
 N LEXS S LEXS=LEXX D BL,TL,BL Q
LB(LEXX) ; General line - blank
 N LEXS S LEXS=LEXX D TL,BL Q
NAME(LEXX) ; Name
 N LEXS S LEXS="User defaults for:  "_LEXX D BL,TL,BL Q
VOC(LEXX) ; Vocabulary name
 N LEXS S LEXS="1.  Vocabulary:  "_LEXX D TL,BL Q
DIS(LEXX) ; Display name
 N LEXS S LEXS="2.  Display:  "_LEXX D TL,BL Q
DISE(LEXX) ; Display element
 N LEXS,LEXCTL,LEXN S LEXCTL=LEXX
 F  S LEXCTL=$O(^LEX(757.03,"B",LEXCTL)) Q:LEXCTL=""!(LEXCTL'[LEXX)  D
 . S LEXN=$O(^LEX(757.03,"B",LEXCTL,0))
 . S LEXN=$E($P($G(^LEX(757.03,LEXN,0)),"^",3),1,63)
 . S LEXS="      "_LEXX_"  "_LEXN D TL
 Q
FIL(LEXX) ; Filter name
 N LEXS S LEXS="3.  Filter:  "_LEXX D TL,BL Q
FIE(LEXI,LEXE) ; Filter element (include/exclude)
 N LEXS,LEXSPC S LEXSPC="                                        "
 S LEXS="      "_$G(LEXI)
 I $L($G(LEXE)) S LEXS=LEXS_$E(LEXSPC,$L(LEXS),$L(LEXSPC))_LEXXE
 D TL Q
CON(LEXX) ; Shortcut Context name
 N LEXS S LEXS="4.  Shortcuts:  "_LEXX D TL,BL Q
TL Q:'$D(LEXS)  N LEXLN S LEXLN=+($G(LEX(0))),LEXLN=LEXLN+1,LEX(LEXLN)=LEXS,LEX(0)=LEXLN Q
BL N LEXLN S LEXLN=+($G(LEX(0))),LEXLN=LEXLN+1,LEX(LEXLN)="",LEX(0)=LEXLN Q
