LEXDCCS ; ISL Default Display - Select             ; 09-23-96
 ;;2.0;LEXICON UTILITY;;Sep 23, 1996
 ;
 ; Special Look-up in file 757.31 Display formats
 ; Entry:  S X=$$EN^LEXDCCS
 ;
 ; Function returns a two piece string
 ;  
 ; $P 1    String of classifications coding 
 ;         system mnemonics, i.e., "ICD/CPT",
 ;         and a legitimate value for LEXSHOW.
 ;         This will be null if input is "^"
 ;  
 ; $P 2    Name of display string selected i.e., 
 ;         "ICD/CPT only"  This will be null only
 ;         when user input is "^^"
 ;   
 ; LEX    Array containing pointers to 757.31
 ; LEXA   Users answer to selection
 ; LEXC   Counter
 ; LEXD   Display
 ; LEXF   Re-display starting from #LEXF
 ; LEXI   Incremental Counter
 ; LEXL   Last entry displayed
 ; LEXLN  Line counter
 ; LEXR   Internal Entry Number (Record) in #757.31
 ; LEXS   Selection
 ; LEXT   Re-display up through #LEXT
 ;  
EN(LEXX) ; Select a predefined display string
 N X,Y,LEX,LEXC,LEXL,LEXR,LEXA,LEXD D TOT
 S LEXD="",(LEXA,LEXX,LEXC,LEXR)=0
 F  S LEXD=$O(^LEX(757.31,"B",LEXD)) Q:LEXD=""!(LEXA["^")!(+LEXX>0)  D
 . S LEXR=0
 . F  S LEXR=$O(^LEX(757.31,"B",LEXD,LEXR)) Q:+LEXR=0!(LEXA["^")!(+LEXX>0)  D
 . . S LEXC=LEXC+1,LEXL=LEXC
 . . S LEX(LEXC)=LEXR,LEX(0)=LEXC
 . . D W(LEXC,LEXR)
 . . I LEXC#5=0,+LEXX=0 S LEXA=$$SEL S:+LEXA>0&(+LEXA<(LEXC+1)) LEXX=+LEXA
 I +LEXX=0,LEXA'["^",LEXC#5'=0 S LEXA=$$SEL S:+LEXA>0&(+LEXA<(LEXC+1)) LEXX=+LEXA
 S LEXX=+LEXX S:LEXX'=0&($D(LEX(LEXX))) LEXX=LEX(LEXX) K LEX
 I +LEXX>0 S LEXX=$G(^LEX(757.31,+LEXX,1))_"^"_$P($G(^LEX(757.31,+LEXX,0)),"^",1) Q LEXX
 S:LEXA'["^^" LEXX="^No display selected" S:LEXA["^^" LEXX="^^"
 Q LEXX
SEL(LEXS) ; Select from the array
 S LEXS="" W ! N X,Y,DIRUT,DTOUT,DUOUT,DIROUT,DIR
 S DIR(0)="NAO^1:"_LEXC
 S DIR("A")="Select 1-"_LEXC_":  ",(DIR("?"),DIR("??"))="^D SH^LEXDCCS"
 D ^DIR W:$G(X)="" ! S LEXS=$S(X["^"&(X'["^^"):"^",X["^^":"^^",X'["^"&(+Y=0):"",1:+Y) Q LEXS
SH ; Show help
 I X'["?" D STD Q
 N LEXR S LEXR=+($E(X,2,$L(X))) I $E(X,1)="?",LEXR>0,LEXR<(LEX(0)+1) D
 . S LEXR=LEX(LEXR) D:'$D(^LEX(757.31,LEXR,2,1)) NODES,STD Q:'$D(^LEX(757.31,LEXR,2,1))  D DES
 D:$E(X,1)="?"&(LEXR<1!(LEXR>LEX(0))) STD D:$E(X,1)'="?" STD D RD
 Q
STD ; Standard Help
 W !!,"Enter 1-",LEXC," to select a Shortcut Context, or ""?"" for help, or ""?#"" for descriptive"
 W !,"help on an entry flagged with an ""*"", or ""^"" to exit or <Return> for more."
 Q
DES ; Description Help
 N LEXLN,LEXI S (LEXLN,LEXI)=0 W !!,?2,$P(^LEX(757.31,LEXR,0),"^",1),!
 F  S LEXI=$O(^LEX(757.31,LEXR,2,LEXI)) Q:+LEXI=0  D
 . W !,?4,^LEX(757.31,LEXR,2,LEXI,0) S LEXLN=LEXLN+1
 D:LEXLN>4 EOP W ! Q
NODES ; No Description Help Available
 W !!,?2,$P(^LEX(757.31,LEXR,0),"^",1)," does not have a description",! Q
RD ; Re-Display List
 N LEXF,LEXT S LEXT=+($G(LEXL)),LEXF=(+(LEXT#5)-1)
 S:LEXF<0 LEXF=4 S LEXF=LEXT-LEXF S LEXF=LEXF-1
 F  S LEXF=$O(LEX(LEXF)) Q:+LEXF=0!(LEXF'<(LEXT+1))  D
 . W:LEXF=1 ! D W(LEXF,LEX(LEXF))
 Q
W(LEXC,LEXR) ; Write entry
 W !,$J(LEXC,4),".  ",$P(^LEX(757.31,LEXR,0),"^",1)
 W $S($D(^LEX(757.31,LEXR,2,1)):"  *",1:"") Q
TOT ; Total displays
 N LEXD,LEXR,LEXC S LEXD="",LEXC=0
 F  S LEXD=$O(^LEX(757.31,"B",LEXD)) Q:LEXD=""  S LEXR=0 D
 . F  S LEXR=$O(^LEX(757.31,"B",LEXD,LEXR)) Q:+LEXR=0  S LEXC=LEXC+1
 W !!,LEXC," Displays found",!
 Q
EOP ; End of Page 
 W ! N X,Y,DIR,DTOUT,DUOUT,DIRUT,DIROUT S DIR(0)="E" D ^DIR S:X[U LEXA="^" W ! Q
