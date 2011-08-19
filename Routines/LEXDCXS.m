LEXDCXS ; ISL Default Context - Select             ; 09-23-96
 ;;2.0;LEXICON UTILITY;;Sep 23, 1996
 ;
 ; Special Look-up in file 757.41 Shortcut Context
 ;
 ; Entry:  S X=$$EN^LEXDCXS
 ;
 ; Function returns a two piece string
 ;  
 ; $P 1    Pointer to file 757.41, and a valid
 ;         value for LEXCTX (context user default)
 ;         This will be null if input is "^"
 ;  
 ; $P 2    Name of context selected.  This will
 ;         be null only when user input is "^^"
 ;   
 ; LEX    Array containing pointers to 757.41
 ; LEXA   Users answer to selection
 ; LEXC   Counter
 ; LEXE   Edit/non-edit Counter
 ; LEXF   Re-display starting from #LEXF
 ; LEXI   Incremental Counter
 ; LEXL   Last entry displayed
 ; LEXR   Internal Entry Number (Record) in #757.41
 ; LEXT   Re-display up through #LEXT
 ; LEXX   Returned value
 ;  
EN(LEXX) ; Entry:  S X=$$EN^LEXDCXS
 N X,Y,LEX,LEXC,LEXL,LEXR,LEXA,LEXE S LEXE=$$CNT D TOT
 S LEXA="",(LEXX,LEXC,LEXR)=0
 F  S LEXR=$O(^LEX(757.41,LEXR)) Q:+LEXR=0!(LEXA["^")!(+LEXX>0)  D
 . I $D(LEXEDIT),$P($G(^LEX(757.41,LEXR,0)),"^",2)'=1 Q
 . S LEXC=LEXC+1,LEXL=LEXC
 . S LEX(LEXC)=LEXR,LEX(0)=LEXC
 . D:LEXE>1 W(LEXC,LEXR)
 . D:LEXE=1 WO(LEXR)
 ; D ASK
 D ASK I LEXA["^" D UOUT Q LEXX
 D VAL Q LEXX
ASK ; Ask for user input
 Q:+LEXX>0  Q:LEXA["^"  Q:+LEXR>0&(LEXC#5'=0)
 Q:+LEXR=0&(LEXC#5=0)
 D SEL Q:+LEXA'>0  Q:LEXA>LEXE  S LEXX=$G(LEX(+LEXA))
 Q
SEL ; Select from list
 I LEXE=1 D ONE Q
 W ! N X,Y,DIR,DIRUT,DTOUT,DUOUT,DIROUT
 S DIR(0)="NAO^1:"_LEXC
 S DIR("A")="Select SHORTCUT CONTEXT 1-"_LEXC_":  //  "
 S (DIR("?"),DIR("??"))="^D SH^LEXDCXS"
 D ^DIR S LEXA=Y
 Q
ONE ;
 W ! N X,Y,DIR,DIRUT,DTOUT,DUOUT,DIROUT
 S DIR(0)="YAO"
 S DIR("A")="  Ok?  //  "
 S (DIR("?"),DIR("??"))="^D SO^LEXDCXS"
 D ^DIR S LEXA=$S(+Y>0:1,1:0)
 Q
UOUT ; Up Arrow detected
 S:LEXA="^^" LEXX="^"
 S:LEXA="^" LEXX="^No context selected"
 Q
VAL ; No Un Arrow (value)
 I +LEXX>0 D  Q
 . I $D(^LEX(757.41,+LEXX)) D  Q
 . . S LEXX=LEXX_"^"_$P($G(^LEX(757.41,+LEXX,0)),"^",1)
 . S LEXX="^No context selected"
 S LEXX="^No context selected"
 Q
SH ; Show help
 N LEXR S LEXR=+($E(X,2,$L(X)))
 I $E(X,1)="?",LEXR>0,LEXR<(LEX(0)+1) D
 . S LEXR=LEX(LEXR) D:'$D(^LEX(757.41,LEXR,1,1)) NODES,STD
 . Q:'$D(^LEX(757.41,LEXR,1,1))  D DES
 D:$E(X,1)="?"&(LEXR<1!(LEXR>LEX(0))) STD
 D:$E(X,1)'="?" STD D RD
 Q
SO ; Show one help
 N LEXR S LEXR=1
 I $E(X,1)="?",LEXR>0,LEXR<(LEX(0)+1) D
 . S LEXR=LEX(LEXR) D:'$D(^LEX(757.41,LEXR,1,1)) NODES,STDO
 . Q:'$D(^LEX(757.41,LEXR,1,1))  D DES
 D:$E(X,1)'="?" STDO D RDO
 Q
STD ; Standard Help
 W !!,"Enter 1-",LEXC," to select a Shortcut Context, "
 W "or ""?"" for help, or ""?#"" for descriptive"
 W !,"help on an entry flagged with an ""*"", or ""^"" "
 W "to exit or <Return> for more."
 Q
STDO ; Standard Help - One
 W !!,"One Shortcut Context available to edit, "
 W "enter ""Yes"" to select, or ""^"" to exit."
 Q
DES ; Description Help
 N LEXI S LEXI=0 W !!,?2,$P(^LEX(757.41,LEXR,0),"^",1),!
 F  S LEXI=$O(^LEX(757.41,LEXR,1,LEXI)) Q:+LEXI=0  D
 . W !,?4,^LEX(757.41,LEXR,1,LEXI,0)
 W ! Q
NODES ; No Description Available
 W !!,?2,$P(^LEX(757.41,LEXR,0),"^",1)
 W " does not have a description",! Q
RD ; Re-Display List (MULTIPLE)
 N LEXF,LEXT S LEXT=+($G(LEXL)),LEXF=(+(LEXT#5)-1)
 S:LEXF<0 LEXF=4 S LEXF=LEXT-LEXF,LEXF=LEXF-1
 F  S LEXF=$O(LEX(LEXF)) Q:+LEXF=0!(LEXF'<(LEXT+1))  D
 . W:LEXF=1 ! D W(LEXF,LEX(LEXF))
 Q
RDO ; Re-Display List (ONE)
 N LEXR S LEXR=LEX(1) W ! D WO(LEXR)
 Q
W(LEXC,LEXR) ; Write entry
 W !,$J(LEXC,4),".  ",$P(^LEX(757.41,LEXR,0),"^",1)
 W $S($D(^LEX(757.41,LEXR,1)):"  *",1:"") Q
WO(LEXR) ; Write one entry
 W !,$P(^LEX(757.41,LEXR,0),"^",1) W $S($D(^LEX(757.41,LEXR,1)):"  *",1:"") Q
TOT ; Total Context
 N LEXR,LEXC S (LEXR,LEXC)=0 F  S LEXR=$O(^LEX(757.41,LEXR)) Q:+LEXR=0  D
 . Q:$D(LEXEDIT)&($P($G(^LEX(757.41,LEXR,0)),"^",2)'=1)  S LEXC=LEXC+1
 I $D(LEXEDIT) D  Q
 . W:LEXC>1 !!,LEXC," SHORTCUT CONTEXT(s) found which can be edited",!
 . W:LEXC=1 !!,"Only ",LEXC," SHORTCUT CONTEXT found which can be edited",!
 W:LEXC>1 !!,LEXC," SHORTCUT CONTEXT(s) found",! W:LEXC=1 !!,"Only ",LEXC," SHORTCUT CONTEXT found",!
 Q
CNT(X) ; Count
 N LEXR,LEXC S (LEXR,LEXC)=0 F  S LEXR=$O(^LEX(757.41,LEXR)) Q:+LEXR=0  D
 . Q:$D(LEXEDIT)&($P($G(^LEX(757.41,LEXR,0)),"^",2)'=1)  S LEXC=LEXC+1
 S X=LEXC Q X
