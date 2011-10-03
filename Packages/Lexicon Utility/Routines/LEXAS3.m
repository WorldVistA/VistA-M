LEXAS3 ; ISL Look-up Check Input (SHIFT)          ; 09-23-96
 ;;2.0;LEXICON UTILITY;;Sep 23, 1996
 ;
SHIFT(LEXX) ; Letters are shifted out of position
 ;
 ; LEXORG( Array of characters in the ORiGinal string
 ; LEXORD( Array of characters in the $O variable
 ; LEXE    $E string
 ; LEXL    Length
 ; LEXD    Flag - Difference of strings
 ; LEXOK   Flag - Shifted string is ok to use
 ; LEXO    $O variable
 ; LEXI    Incremental counter
 ; LEXX    Returned value
 ;
 ;
 Q:$L(LEXX)<5 LEXX
 N LEXT,LEXE,LEXL,LEXO,LEXOK,LEXORG,LEXORD
 S LEXT=LEXX,LEXOK=0
 F LEXL=1:1:3 D SHF Q:LEXOK  S LEXT=$E(LEXT,1,($L(LEXT)-1))
 K LEXORG,LEXORD
 S LEXX=LEXT
 Q LEXX
 ;
SHF ; Shift letters in arrays
 K LEXORG D ORG(LEXT)
 S LEXE=$E(LEXT,1,2),LEXO=$$SCH^LEXAS6(LEXE)
 F  S LEXO=$O(^LEX(757.01,"AWRD",LEXO)) Q:LEXO=""!(LEXO'[LEXE)!(LEXOK)  D  Q:LEXOK
 . Q:$L(LEXO)<$L(LEXT)!($L(LEXO)>($L(LEXT)+1))
 . N LEXD D ORD(LEXO) S LEXD=$$COMP
 . I LEXD S LEXOK=0 Q
 . I 'LEXD S LEXT=LEXO,LEXOK=1 Q
 Q
 ;
ORG(LEXX) ; Original tolken
 K LEXORG N LEXI
 F LEXI=1:1:$L(LEXX) D
 . I $D(LEXORG($E(LEXX,LEXI))) D  Q
 . . S LEXORG($E(LEXX,LEXI))=LEXORG($E(LEXX,LEXI))+1
 . S LEXORG($E(LEXX,LEXI))=1
 Q
ORD(LEXO) ; Ordered tolken
 K LEXORD N LEXI
 F LEXI=1:1:$L(LEXO) D
 . I $D(LEXORD($E(LEXO,LEXI))) D  Q
 . . S LEXORD($E(LEXO,LEXI))=LEXORD($E(LEXO,LEXI))+1
 . S LEXORD($E(LEXO,LEXI))=1
 Q
COMP(LEXX) ; Compare Original to Ordered
 N LEXI,LEXD S LEXI="",LEXD=1
 F  S LEXI=$O(LEXORG(LEXI)) Q:LEXI=""  D  Q:'LEXD
 . I '$D(LEXORD(LEXI)) S LEXD=0 Q
 . I LEXORG(LEXI)>LEXORD(LEXI) S LEXD=0
 I LEXD=0 K LEXORD Q 1
 S LEXI="",LEXD=1
 F  S LEXI=$O(LEXORD(LEXI)) Q:LEXI=""  D  Q:'LEXD
 . ;I '$D(LEXORG(LEXI)) Q
 . I LEXORD(LEXI)>($G(LEXORG(LEXI))+1) S LEXD=0
 I LEXD=0 K LEXORD Q 1
 K LEXORD Q 0
