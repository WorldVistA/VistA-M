LEXDFLS ; ISL Default Filter - Select              ; 09-23-96
 ;;2.0;LEXICON UTILITY;;Sep 23, 1996
 ;
 ; Special Look-up in file 757.3 Screens
 ; Entry:  S X=$$EN^LEXDFLS
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
 ; LEX    Array containing pointers to 757.3
 ; LEXA   Users answer to selection
 ; LEXC   Counter
 ; LEXD   Display
 ; LEXF   Re-display starting from #LEXF
 ; LEXI   Incremental Counter
 ; LEXL   Last entry displayed
 ; LEXLN  Line counter
 ; LEXR   Internal Entry Number (Record) in #757.3
 ; LEXS   Selection
 ; LEXT   Re-display up through #LEXT
 ;  
EN(LEXX) ; Select a predefined filter string
 N X,Y,LEX,LEXC,LEXL,LEXR,LEXA,LEXD D TOT
 S LEXD="",(LEXA,LEXX,LEXC,LEXR)=0
 F  S LEXD=$O(^LEX(757.3,"B",LEXD)) Q:LEXD=""!(LEXA["^")!(+LEXX>0)  D
 . S LEXR=0
 . F  S LEXR=$O(^LEX(757.3,"B",LEXD,LEXR)) Q:+LEXR=0!(LEXA["^")!(+LEXX>0)  D
 . . Q:$P($G(^LEX(757.3,LEXR,0)),"^",2)'="U"
 . . S LEXC=LEXC+1,LEXL=LEXC
 . . S LEX(LEXC)=LEXR,LEX(0)=LEXC
 . . D W(LEXC,LEXR)
 . . D ASK
 D ASK S LEXX=+LEXX K LEX
 I +LEXX>0 S LEXX=$G(^LEX(757.3,+LEXX,1))_"^"_$P($G(^LEX(757.3,+LEXX,0)),"^",1) Q LEXX
 S:LEXA'["^^" LEXX="^No filter selected" S:LEXA["^^" LEXX="^"
 Q LEXX
ASK ;
 ;I LEXC#5=0,+LEXX=0 S LEXA=$$SEL S:+LEXA>0&(+LEXA<(LEXC+1)) LEXX=+LEXA
 ;I +LEXX=0,LEXA'["^",LEXC#5'=0 S LEXA=$$SEL S:+LEXA>0&(+LEXA<(LEXC+1)) LEXX=+LEXA
 Q:+LEXX>0  Q:LEXA["^"  Q:+LEXR>0&(LEXC#5'=0)
 Q:+LEXR=0&(LEXC#5=0)
 D SEL Q:+LEXA'>0  Q:LEXA>LEXC  S LEXX=$G(LEX(+LEXA))
 Q
SEL ; Select from list
 W ! N X,Y,DIR,DIRUT,DTOUT,DUOUT,DIROUT
 S DIR(0)="NAO^1:"_LEXC
 S DIR("A")="Select FILTER 1-"_LEXC_":  "
 S (DIR("?"),DIR("??"))="^D SH^LEXDFLS"
 D ^DIR S LEXA=Y
 Q
UOUT ; Up Arrow detected
 S:LEXA="^^" LEXX="^"
 S:LEXA="^" LEXX="^No filter selected"
 Q
VAL ; No Un Arrow (value)
 I +LEXX>0 D  Q
 . I $D(^LEX(757.41,+LEXX)) D  Q
 . . S LEXX=LEXX_"^"_$P($G(^LEX(757.41,+LEXX,0)),"^",1)
 . S LEXX="^No filter selected"
 S LEXX="^No filter selected"
 Q
SH ; Show help
 N LEXR S LEXR=+($E(X,2,$L(X))) I $E(X,1)="?",LEXR>0,LEXR<(LEX(0)+1) D
 . S LEXR=LEX(LEXR) D:'$D(^LEX(757.3,LEXR,2,1)) NODES,STD Q:'$D(^LEX(757.3,LEXR,2,1))  D DES
 D:$E(X,1)="?"&(LEXR<1!(LEXR>LEX(0))) STD D:$E(X,1)'="?" STD D RD
 Q
STD ; Standard Help
 W !!,"Enter 1-",LEXC," to select a filter, or ""?"" for help, or ""?#"" for descriptive"
 W !,"help on an entry flagged with an ""*"", or ""^"" to exit or <Return> for more."
 Q
DES ; Description Help
 N LEXLN,LEXI S (LEXLN,LEXI)=0 W !!,?2,$P(^LEX(757.3,LEXR,0),"^",1),!
 F  S LEXI=$O(^LEX(757.3,LEXR,2,LEXI)) Q:+LEXI=0  D
 . W !,?4,^LEX(757.3,LEXR,2,LEXI,0) S LEXLN=LEXLN+1
 D:LEXLN>4 EOP W ! Q
NODES ; No Description Help Available
 W !!,?2,$P(^LEX(757.3,LEXR,0),"^",1)," does not have a description",! Q
RD ; Re-Display List
 N LEXF,LEXT S LEXT=+($G(LEXL)),LEXF=(+(LEXT#5)-1)
 S:LEXF<0 LEXF=4 S LEXF=LEXT-LEXF S LEXF=LEXF-1
 F  S LEXF=$O(LEX(LEXF)) Q:+LEXF=0!(LEXF'<(LEXT+1))  D
 . W:LEXF=1 ! D W(LEXF,LEX(LEXF))
 Q
TOT ; Total Filters
 N LEXD,LEXR,LEXC S LEXD="",LEXC=0
 F  S LEXD=$O(^LEX(757.3,"B",LEXD)) Q:LEXD=""  S LEXR=0 D
 . F  S LEXR=$O(^LEX(757.3,"B",LEXD,LEXR)) Q:+LEXR=0  D
 . . Q:$P($G(^LEX(757.3,LEXR,0)),"^",2)'="U"
 . . S LEXC=LEXC+1
 W !!,LEXC," Filters found",! Q
W(LEXC,LEXR) ; Write entry
 W !,$J(LEXC,4),".  ",$P(^LEX(757.3,LEXR,0),"^",1)
 W $S($D(^LEX(757.3,LEXR,2,1)):"  *",1:"") Q
EOP ; End of Page 
 W ! N X,Y,DIR,DTOUT,DUOUT,DIRUT,DIROUT S DIR(0)="E" D ^DIR S:X[U LEXA="^" W ! Q
