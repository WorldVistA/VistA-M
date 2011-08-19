LEXAS6 ; ISL/FJF Look-up Check Input (TRIM,EXP,TP,SCH); 12/07/2006
 ;;2.0;LEXICON UTILITY;**41**;Sep 23, 1996;Build 34
 ;
TRIM(LEXX) ; Trim string
 ;
 ; LEXOK   Flag - string is OK
 ; LEXF    Frequency
 ; LEXI    Incremental counter
 ; LEXT    Temporary string
 ; LEXX    Return string
 ;
 N LEXI,LEXOK,LEXT,LEXF S LEXF=1,LEXOK=0,LEXT=LEXX
 F  Q:$E(LEXX,1)'=" "  S LEXX=$E(LEXX,2,$L(LEXX))
 F LEXI=$L(LEXX):-1:1 Q:LEXOK  D  Q:LEXOK
 . S LEXT=$E(LEXT,1,($L(LEXT)-1))
 . I $L(LEXT)<3 S LEXOK=1 Q
 . I $D(^LEX(757.01,"ASL",LEXT)) S LEXF=$O(^LEX(757.01,"ASL",LEXT,0)) I +(LEXF)>1 S LEXOK=1
 S LEXX=LEXT
 Q LEXX
 ;
EXP3(LEXX) ; Expand string up to 3 characters
 N LEXT S LEXT=LEXX
 S LEXT=$$EXP(LEXT)
 I $L(LEXT)-$L(LEXX)'>3 S LEXX=LEXT
 Q LEXX
EXP(LEXX) ; Expand string
 ;
 ; LEXF    String found
 ; LEXC    Control string
 ; LEXCK   Check for string
 ; LEXI    Character position
 ; LEXLTR  Letter at character position
 ; LEXNT   Altered tolken
 ; LEXOK   Flag - 1 quit 0 keep checking
 ; LEXOKL  Flag - 1 add letter 0 do not add letter
 ; LEXX    Return expanded string
 ;
 Q:$D(^LEX(757.01,"AWRD",LEXX)) LEXX
 N LEXF,LEXC,LEXCK,LEXI,LEXLTR,LEXNT,LEXOK,LEXOKL
 S (LEXF,LEXC)=LEXX,LEXOK=0
 S LEXNT=$O(^LEX(757.01,"ASL",$$SCH(LEXF)))
 F LEXI=1:1:63 Q:LEXOK  D  Q:LEXOK!(LEXNT'[LEXC)
 . Q:LEXI'>$L(LEXC)
 . S LEXNT=$O(^LEX(757.01,"ASL",LEXNT)) Q:LEXNT=LEXF
 . S LEXLTR=$E(LEXNT,LEXI) Q:LEXLTR=""
 . S LEXOKL=1,LEXCK=$$SCH(LEXNT)
 . F  S LEXCK=$O(^LEX(757.01,"ASL",LEXCK)) Q:LEXCK=""!('LEXOKL)  D
 . . I $E(LEXCK,LEXI)'="",$E(LEXCK,LEXI)'=LEXLTR S LEXOKL=0 Q
 . . I LEXCK'[LEXC,$E(LEXCK,LEXI)'=LEXLTR S LEXCK="~~~~~~~~~~~" Q
 . S:LEXOKL LEXF=LEXF_LEXLTR S:'LEXOKL LEXOK=1
 . S:$D(^LEX(757.01,"AWRD",LEXF)) LEXOK=1
 S LEXX=LEXF Q LEXX
 ;
TP(LEXX) ; Transposed letters
 ;
 ; LEXF    Tolken found
 ; LEXO    Original tolken
 ; LEXN    Concatenated tolken
 ; LEXT    Temporary tolken
 ; LEXI    Character position
 ; LEXX    Return string
 ;
 N LEXO,LEXN,LEXI,LEXF,LEXT S (LEXF,LEXN)="",LEXO=LEXX
 F LEXI=2:1:$L(LEXX) Q:LEXF'=""  D  Q:LEXF'=""
 . S LEXN=$E(LEXX,1,(LEXI-1))_$E(LEXX,(LEXI+1))_$E(LEXX,LEXI)_$E(LEXX,(LEXI+2),$L(LEXX))
 . I $D(^LEX(757.01,"ASL",LEXN)) S LEXF=LEXN
 . S LEXT=$$ONE^LEXAS2(LEXN)
 . I $L(LEXT)=$L(LEXN),$D(^LEX(757.01,"ASL",LEXT)) S LEXF=LEXT
 S:LEXF'="" LEXX=LEXF
 S:LEXF="" LEXX=LEXO
 Q LEXX
SCH(LEXX) ; Create $O variable
 ;
 ; LEXX    Return $O variable
 ;
 S LEXX=$E(LEXX,1,($L(LEXX)-1))_$C($A($E(LEXX,$L(LEXX)))-1)_"~"
 Q LEXX
