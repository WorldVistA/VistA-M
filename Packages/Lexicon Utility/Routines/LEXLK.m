LEXLK ; ISL Demo Look Up                         ; 09-23-96
 ;;2.0;LEXICON UTILITY;;Sep 23, 1996
 ;
EN ; Initialize variables
 W @IOF N LEXSF,LEXCONT,LEXCLAS,LEXDEF,LEXDIS,LEXEXP,LEXFORM
 N LEXFM,LEXMC,LEXCODE,LEXSRC,LEXSO,LEXLINE,LEXSPC,LEXNOM
 N LEXX,LEXY,LEXYPE,LEXEMP,LEXCHK,X,Y,LEXAP S LEXSF=1
 W @IOF D LOOK G EXIT
LOOK ; Look-up term
 W !! K X S LEXAP=1 D ^LEXA1 K DIC D:+($$Y) MORE
AGAIN ; Try again?
 W !,"Try another" S %=$S(+($$X):1,1:2)
 D YN^DICN I %=-1!(%=2) Q
 I '% W !!,"You have searched for a term in the Lexicon, do you want to" G AGAIN
 I +($$X)&(%=1) G LOOK
 I '+($$X)&(%=1) G LOOK
 I (+($$X)&(%=2))!('+($$X)&(%=1)) Q
 G LOOK Q
MORE ; Do you want more information?
 W !!,"Do you want more information" S %=1 D YN^DICN Q:%=-1
 I '% D  G MORE
 . W !!,"The Lexicon also contains definitions (on most major concepts),"
 . W !,"codes (from major coding systems, i.e., ICD, CPT, NANDA, etc.),"
 . W !,"synonyms, lexical variants, and semantic classifications for each"
 . W !,"term by class and type."
 Q:%=2  D:%=1 DISP
 Q
DISP ; If requested, get and display information
 Q:'+($$Y)  D GET^LEXLK2(Y) Q:'$G(LEX(0))
 D LIST^LEXLK2
 Q
EXIT ; Clean up environment and quit
 K %,DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,LEX,LEXB,LEXC,LEXCHK,LEXCL
 K LEXCLAS,LEXCODE,LEXCT,LEXCONT,LEXDEF,LEXDIS,LEXE,LEXEMP
 K LEXEXP,LEXF,LEXFM,LEXFORM,LEXLC,LEXLINE,LEXLN,LEXMC,LEXMCE
 K LEXNOM,LEXSCP,LEXSF,LEXSO,LEXSPC,LEXSPCR,LEXSR,LEXSRC
 K LEXSTR,LEXT,LEXTT,LEXX,LEXY,LEXYPE,X,Y
 Q
X(LEX) ; Evaluate X
 Q:$L($G(X)) 1  Q 0
Y(LEX) ; Evaluate Y
 Q:+($G(Y))>1 1  Q 0
