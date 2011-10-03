LEXAS2 ; ISL Look-up Check Input (ONE)            ; 09-23-96
 ;;2.0;LEXICON UTILITY;;Sep 23, 1996
 ;
ONE(LEXX) ; One letter missing/incorrect
 ;
 ; LEXRIM  Trimmed string
 ; LEXI    Character position
 ; LEXF    First portion
 ; LEXT    Trailing portion
 ; LEXTL   Trailing letter
 ; LEXNF   Strings found
 ; LEXO    $O variable
 ; LEXNT   Temporary string
 ; LEXX    String returned
 ;
 N LEXI,LEXF,LEXT,LEXTL,LEXNF,LEXO,LEXNT,LEXRIM
 S LEXTL=$E(LEXX,$L(LEXX)),LEXRIM=$$TRIM^LEXAS6(LEXX)
 S LEXF=$E(LEXRIM,1,($L(LEXRIM)-1)),LEXNF="",LEXKEY=$G(LEXKEY)
 F LEXI=1:1:$L(LEXX) D
 . S LEXF=$E(LEXX,1,LEXI)
 . S LEXT=$E(LEXX,(LEXI+1),$L(LEXX))
 . S LEXO=$$SCH^LEXAS6(LEXF)
 . F  S LEXO=$O(^LEX(757.01,"AWRD",LEXO)) Q:LEXO'[LEXF  D
 . . S LEXO=$E(LEXO,1,($L(LEXF)+1))
 . . Q:$L(LEXO)<($L(LEXF)+1)
 . . S LEXNT=LEXO_LEXT
 . . I $D(^LEX(757.01,"ASL",LEXNT)) D
 . . . S LEXNF=LEXNF_"/"_LEXNT
 . . S LEXNT=LEXO_$E(LEXT,2,$L(LEXT))
 . . I $D(^LEX(757.01,"ASL",LEXNT)) D
 . . . S LEXNF=LEXNF_"/"_LEXNT
 . . S LEXO=LEXO_"~"
 S:$E(LEXNF,1)="/" LEXNF=$E(LEXNF,2,$L(LEXNF))
 I LEXNF'="",LEXNF["/" D PICK
 I LEXNF'=""&(LEXNF'["/") S LEXRIM=LEXNF Q LEXRIM
 S LEXRIM=$$TRIM^LEXAS6(LEXRIM) Q LEXRIM
 Q LEXRIM
 ;
PICK ; Pick one string
 ;
 ; LEXNF   Strings found
 ; LEXAN   Array of strings by frequency
 ; LEXI    Position/Piece in string
 ; LEXIN   Position/Piece in altered string
 ; LEXEXP  Expression
 ; LEXES   Expresseion segment/string
 ; LEXKEY  Key for selecting string
 ; LEXKEYO $Orderable KEY
 ; LEXOK   Flag - Selection is OK
 ; LEXC    Control string
 ; LEXP    Character position in segment
 ; LEXR    Record number for expression
 ; LEXN    Altered string
 ; LEXM    Maximum string length
 ; LEXS    Shortest string length
 ;
 N LEXOK,LEXI,LEXC,LEXN,LEXS,LEXM S LEXI=0,LEXC=""
 S LEXS=$P(LEXNF,"/",1)
 F LEXI=1:1:$L(LEXNF,"/") D
 . S LEXN=$P(LEXNF,"/",LEXI) I LEXC="" S LEXC=LEXN Q
 . S LEXM=$S($L(LEXC)>$L(LEXN):$L(LEXC),1:$L(LEXN))
 . N LEXP F LEXP=LEXM:-1:1 Q:$E(LEXC,1,LEXP)=$E(LEXN,1,LEXP)
 . S:LEXP<$L(LEXS) LEXS=$E(LEXS,1,LEXP)
 S LEXC=$E(LEXX,($L(LEXS)+2),$L(LEXX)),LEXN=""
 ; Key supplied
 I $L($G(LEXKEY)) S LEXOK=0 D  Q:LEXOK
 . ; order through pieces
 . N LEXAN,LEXI
 . F LEXI=1:1:$L(LEXNF,"/") D  Q:LEXOK
 . . S LEXN=$P(LEXNF,"/",LEXI)
 . . ; order through expressions
 . . N LEXR,LEXKEYO S LEXR=0,LEXKEYO=$$SCH^LEXAS6(LEXKEY)
 . . F  S LEXKEYO=$O(^LEX(757.01,"AWRD",LEXKEYO)) Q:LEXKEYO=""!(LEXKEYO'[LEXKEY)!(LEXOK)  D
 . . . F  S LEXR=$O(^LEX(757.01,"AWRD",LEXKEYO,LEXR)) Q:+LEXR=0!(LEXOK)  D
 . . . . N LEXEXP S LEXEXP=$$UP^XLFSTR(^LEX(757.01,LEXR,0))
 . . . . N LEXIN,LEXES F LEXIN=1:1:$L(LEXEXP," ") D  Q:LEXOK
 . . . . . S LEXES=$P(LEXEXP," ",LEXIN)
 . . . . . Q:$E(LEXES,1)'=$E(LEXN,1)
 . . . . . Q:$E(LEXN,$L(LEXN))'=$E(LEXES,$L(LEXN))
 . . . . . N LEXP,LEXC S LEXC=0 F LEXP=1:1:$L(LEXN) D  Q:LEXOK
 . . . . . . I $E(LEXES,1,$L(LEXN))[$E(LEXN,LEXP) S LEXC=LEXC+1
 . . . . . S:LEXC>0 LEXAN(-(LEXC))=LEXN
 . S LEXN="" S:$O(LEXAN(-999999))<0 LEXN=$O(LEXAN(-999999)),LEXN=LEXAN(LEXN)
 . I LEXN'="" S LEXNF=LEXN,LEXOK=1
 ; No key supplied
 F LEXI=1:1:$L(LEXNF,"/") D  Q:LEXN[LEXC
 . S LEXN=$P(LEXNF,"/",LEXI)
 . I LEXN[LEXC,$E(LEXN,$L(LEXN))=LEXTL S LEXNF=LEXN
 Q
