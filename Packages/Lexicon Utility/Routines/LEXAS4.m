LEXAS4 ; ISL Look-up Check Input (DBL,REM)        ; 09-23-96
 ;;2.0;LEXICON UTILITY;;Sep 23, 1996
 ;
DBL(LEXX) ; Excessive Double Characters
 ;
 ; LEXI    Incremental counter
 ; LEXOK   Flag - found word yes/no
 ; LEXT    Temporary word
 ; LEXD    Temporary word (Double doubles)
 ; LEXX    Return string
 ;
 N LEXI,LEXOK,LEXT,LEXD S LEXOK=0,LEXD=""
 F LEXI=1:1:$L(LEXX) D  Q:LEXOK
 . S LEXT=LEXX I $E(LEXX,LEXI)=$E(LEXX,(LEXI+1)) D
 . . S LEXT=$E(LEXX,1,LEXI)_$E(LEXX,(LEXI+2),$L(LEXX))
 . . I $D(^LEX(757.01,"ASL",LEXT)) S LEXX=LEXT,LEXOK=1 Q
 . . Q:LEXI=1
 . . S LEXT=$E(LEXX,1,(LEXI-1))_$E(LEXX,(LEXI+2),$L(LEXX))
 . . I $D(^LEX(757.01,"ASL",LEXT)) S LEXX=LEXT,LEXOK=1 Q
 I LEXOK Q LEXX
 F LEXI=1:1:$L(LEXX) D
 . I $E(LEXX,LEXI)'=$E(LEXX,(LEXI+1)) D
 . . S LEXD=LEXD_$E(LEXX,LEXI)
 I $D(^LEX(757.01,"ASL",LEXD)) S LEXX=LEXD
 Q LEXX
 ;
REM(LEXX) ; Remove character
 ;
 ; LEXI    Incremental counter
 ; LEXOK   Flag - found word yes/no
 ; LEXF    First segment
 ; LEXT    Trailing segment
 ; LEXN    Altered tolken
 ; LEXTN   Temporary altered tolken
 ; LEXX    Return string
 ;
 N LEXI,LEXO,LEXCS,LEXCA,LEXTN,LEXOK,LEXF,LEXT,LEXN,LEXL
 S LEXOK=0,LEXO=LEXX
 F LEXI=2:1:$L(LEXO) D  Q:LEXOK
 . S LEXF=$E(LEXO,1,(LEXI-1)),LEXT=$E(LEXO,(LEXI+1),$L(LEXO))
 . I $D(^LEX(757.01,"AWRD",(LEXF_LEXT))),$O(^LEX(757.01,"ASL",(LEXF_LEXT),0))>1 D  Q
 . . S LEXX=LEXF_LEXT,LEXOK=1
 . S LEXN=$$REM2(LEXO,LEXI) I $D(^LEX(757.01,"AWRD",LEXN)) S LEXX=LEXN,LEXOK=1 Q
 . Q:$D(^LEX(757.01,"ASL",$E(LEXO,1,LEXI)))
 . S LEXF=$E(LEXO,1,(LEXI-1)),LEXT=$E(LEXO,(LEXI+1),$L(LEXO))
 . I '$D(^LEX(757.01,"ASL",LEXF)),$O(^LEX(757.01,"ASL",LEXF,0))>1 D  Q
 . . S LEXX=$E(LEXF,1,($L(LEXF)-1)),LEXOK=1
 . S LEXCA=LEXF_LEXT
 . S LEXCS=LEXF_$E(LEXT,1)
 . I $D(^LEX(757.01,"ASL",LEXCS)),$O(^LEX(757.01,"ASL",LEXCS,0))>1 D
 . . S LEXO=LEXCA,LEXI=LEXI+1 S:LEXI=$L(LEXO) LEXOK=1
 . S LEXTN=$$SHIFT^LEXAS3(LEXO)
 . I $D(^LEX(757.01,"AWRD",LEXTN)),$O(^LEX(757.01,"ASL",LEXTN,0))>1 S LEXX=LEXTN,LEXOK=1 Q
 . I $D(^LEX(757.01,"ASL",LEXO)),$O(^LEX(757.01,"ASL",LEXO,0))>1 S LEXX=LEXO,LEXOK=1
 Q LEXX
REM2(LEXO,LEXI) ; Remove character at position LEXI
 N LEXOK S LEXOK=0
 S LEXF=$E(LEXO,1,LEXI)_$E(LEXO,(LEXI+2),(LEXI+3))
 I $L(LEXF)>3 D
 . N LEXT,LEXN,LEXP1,LEXP2 S LEXT=$E(LEXX,($L(LEXX)-4),$L(LEXX))
 . S LEXN=$E(LEXF,1,($L(LEXF)-1))_$C($A($E(LEXF,$L(LEXF)))-1)_"~"
 . F  S LEXN=$O(^LEX(757.01,"AWRD",LEXN)) Q:LEXN=""!($E(LEXN,1,$L(LEXF))'=LEXF)!(LEXOK)  D
 . . S LEXP1=$E(LEXN,($L(LEXN)-($L(LEXT)-1)),$L(LEXN))
 . . I $E(LEXN,($L(LEXN)-($L(LEXT)-1)),$L(LEXN))=LEXT S LEXO=LEXN,LEXOK=1
 Q LEXO
