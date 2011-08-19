LEXDVOS ; ISL Default Vocabulary - Select          ; 09-23-96
 ;;2.0;LEXICON UTILITY;;Sep 23, 1996
 ;
 ; Special Look-up in file 757.2 Subset Definitions
 ; Entry:  S X=$$EN^LEXDVOS
 ;
 ; Function returns a 2 piece string
 ;  
 ; $P 1    3 character subset mnemonic
 ;  
 ; $P 2    Name of the subset
 ;   
 ; LEX    Array containing pointers to 757.2
 ; LEXA   Users answer to selection
 ; LEXC   Counter
 ; LEXD   Display
 ; LEXF   Re-display starting from #LEXF
 ; LEXI   Incremental Counter
 ; LEXL   Last entry displayed
 ; LEXLN  Line counter
 ; LEXR   Internal Entry Number (Record) in #757.2
 ; LEXT   Re-display up through #LEXT
 ; LEXX   Return value
 ;
EN(LEXX) ; Select a Vocabulary/Subset
 N X,Y,LEX,LEXC,LEXL,LEXR,LEXA,LEXD D TOT
 S LEXD="",(LEXA,LEXX,LEXC,LEXR)=0
 F  S LEXD=$O(^LEXT(757.2,"AA",LEXD)) Q:LEXD=""!(LEXA["^")!(+LEXX>0)  D
 . S LEXR=0
 . F  S LEXR=$O(^LEXT(757.2,"AA",LEXD,LEXR)) Q:+LEXR=0!(LEXA["^")!(+LEXX>0)  D
 . . Q:$P($G(^LEXT(757.2,LEXR,0)),"^",2)=""
 . . Q:$L($P($G(^LEXT(757.2,LEXR,0)),"^",2))'=3
 . . S LEXC=LEXC+1,LEXL=LEXC
 . . S LEX(LEXC)=LEXR,LEX(0)=LEXC
 . . D W(LEXC,LEXR)
 . . D ASK
 D ASK S LEXX=+LEXX K LEX
 I +LEXX>0 S LEXX=$P($G(^LEXT(757.2,+LEXX,0)),"^",2)_"^"_$P($G(^LEXT(757.2,+LEXX,0)),"^",1) Q LEXX
 S:LEXA'["^^" LEXX="^No vocabulary selected" S:LEXA["^^" LEXX="^^"
 Q LEXX
ASK ; Ask for user input
 Q:+LEXX>0  Q:LEXA["^"  Q:+LEXR>0&(LEXC#5'=0)  Q:+LEXR=0&(LEXC#5=0)
 D SEL Q:+LEXA'>0  Q:LEXA>LEXC  S LEXX=$G(LEX(+LEXA))
 Q
SEL ; Select from list
 W ! N X,Y,DIR,DIRUT,DTOUT,DUOUT,DIROUT
 S DIR(0)="NAO^1:"_LEXC
 S DIR("A")="Select SUBSET 1-"_LEXC_":  "
 S (DIR("?"),DIR("??"))="^D SH^LEXDVOS"
 D ^DIR S LEXA=Y
 Q
UOUT ; Up Arrow detected
 S:LEXA["^^" LEXX="^^"
 S:LEXA="^" LEXX="^No vocabulary selected"
 Q
VAL ; No Un Arrow (value)
 I +LEXX>0 D  Q
 . I $D(^LEX(757.41,+LEXX)) D  Q
 . . S LEXX=LEXX_"^"_$P($G(^LEX(757.41,+LEXX,0)),"^",1)
 . S LEXX="^No vocabulary selected"
 S LEXX="^No vocabulary selected"
 Q
SH ; Show help
 N LEXR S LEXR=+($E(X,2,$L(X)))
 I $E(X,1)="?",LEXR>0,LEXR<(LEX(0)+1) D
 . S LEXR=LEX(LEXR) D:'$D(^LEXT(757.2,LEXR,100,1)) NODES,STD Q:'$D(^LEXT(757.2,LEXR,100,1))  D DES
 D:$E(X,1)="?"&(LEXR<1!(LEXR>LEX(0))) STD D:$E(X,1)'="?" STD D RD
 Q
STD ; Standard Help
 W !!,"Enter 1-",LEXC," to select a subset, or ""?"" for help, or ""?#"" for descriptive"
 W !,"help on an entry flagged with an ""*"", or ""^"" to exit or <Return> for more."
 Q
DES ; Description Help
 N LEXLN,LEXI S (LEXLN,LEXI)=0
 W !!,?2,$P(^LEXT(757.2,LEXR,0),"^",1),!
 F  S LEXI=$O(^LEXT(757.2,LEXR,100,LEXI)) Q:+LEXI=0  D
 . W !,?4,^LEXT(757.2,LEXR,100,LEXI,0) S LEXLN=LEXLN+1
 D:LEXLN>4 EOP W ! Q
NODES ; No Description Help Available
 W !!,?2,$P(^LEXT(757.2,LEXR,0),"^",1)," does not have a description",! Q
RD ; Re-Display List
 N LEXF,LEXT S LEXT=+($G(LEXL)),LEXF=(+(LEXT#5)-1)
 S:LEXF<0 LEXF=4 S LEXF=LEXT-LEXF S LEXF=LEXF-1
 F  S LEXF=$O(LEX(LEXF)) Q:+LEXF=0!(LEXF'<(LEXT+1))  D
 . W:LEXF=1 ! D W(LEXF,LEX(LEXF))
 Q
W(LEXC,LEXR) ; Write entry
 W !,$J(LEXC,4),".  ",$P(^LEXT(757.2,LEXR,0),"^",1)
 W $S($D(^LEXT(757.2,LEXR,100,1)):"  *",1:"") Q
TOT ; Total Subsets
 N LEXD,LEXR,LEXC S LEXD="",LEXC=0
 F  S LEXD=$O(^LEXT(757.2,"AA",LEXD)) Q:LEXD=""  S LEXR=0 D
 . F  S LEXR=$O(^LEXT(757.2,"AA",LEXD,LEXR)) Q:+LEXR=0  S LEXC=LEXC+1
 W !!,LEXC," Subsets found",!
 Q
EOP ; End of Page 
 W ! N X,Y,DIR,DTOUT,DUOUT,DIRUT,DIROUT S DIR(0)="E" D ^DIR S:X[U LEXA="^" W ! Q
