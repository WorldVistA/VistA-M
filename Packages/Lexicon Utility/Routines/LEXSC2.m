LEXSC2 ; ISL Shortcuts Add/Delete                 ; 05/25/1998
 ;;2.0;LEXICON UTILITY;**11**;Sep 23, 1996
 ;
WRT(LEXSTR) ;
 W ! N LEXI,LEXLEN S LEXLEN=70 F  D  Q:$L(LEXSTR)<LEXLEN
 . F LEXI=(LEXLEN+1):-1:0 Q:$E(LEXSTR,LEXI)=" "!(LEXI=0)
 . I LEXI>0 W !,?2,$E(LEXSTR,1,(LEXI-1)) S LEXSTR=$E(LEXSTR,(LEXI+1),$L(LEXSTR)) Q
 . I LEXI=0 W:$L(LEXSTR) !,?2,LEXSTR S LEXSTR=""
 I $L(LEXSTR) W !,?2,LEXSTR
 W !
 Q
DELOK(X) ; Ok to delete?
 N DIR,Y,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR("A")="Delete current shortcut:  ",DIR("B")="NO",DIR(0)="YAO" D ^DIR
 S:X[U LEXRP=U S:X["^^" LEXRP="^^" W ! S X=$S(+($G(Y))=1:1,1:0) Q X
 Q
ADDOK(X) ; Ok to add?
 N DIR,Y,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR("A")="Add shortcut:  ",DIR("B")="NO",DIR(0)="YAO" D ^DIR
 S:X[U LEXRP=U S:X["^^" LEXRP="^^" W ! S X=$S(+($G(Y))=1:1,1:0) Q X
SC(X) ; Get shortcut
 S DIR("A")="Enter shortcut keyword(s):  "
 S DIR("?")="Enter one or more words (up to 63 characters) to use as a shortcut for a term"
 S DIR("??")="^D SCHLP^LEXSC2" N Y S DIR(0)="FAO^2:63" D ^DIR
 S:X="" LEXRP=U S:X[U LEXRP=U S:X["^^" LEXRP="^^" F  Q:$E(X,1)'=" "  S X=$E(X,2,$L(X))
 W:$D(DTOUT) !,"Try later.",! S:$D(DTOUT) X="",LEXRP=U
 S:X[U DUOUT=1 K DIR,DIRUT,DIROUT
 Q X
SCHLP ; Look-up help
 W !!,"Enter one or more words (up to 63 characters) to use as a shortcut to quickly"
 W !,"locate a single term without conducting a word search.  This shortcut should"
 W !,"be unique to the term as used in the context """,LEXCXN,""""
 Q
TERM(X) ; Get expression
 N DIR,Y S DIR("A")="Select a term for the shortcut:  "
 S DIR("?")="    "_$$SQ^LEXHLP  ; PCH 11
 S DIR("??")="^D TERMHLP^LEXSC2" N Y S DIR(0)="FAO^2:245" D ^DIR
 S DIC="^LEX(757.01," S:X[U LEXRP=U S:X["^^" LEXRP="^^" Q:LEXRP[U "^"
 I X=" ",+($G(^DISV(DUZ,DIC)))>0 S X=@(DIC_+($G(^DISV(DUZ,DIC)))_",0)") W " ",X
 F  Q:$E(X,1)'=" "  S X=$E(X,2,$L(X))
 W:$D(DTOUT) !,"Try later.",! S:$D(DTOUT) X=""
 S:X[U DUOUT=1 K DIR,DIRUT,DIROUT Q X
TERMHLP ; Look-up help  PCH 11
 N X S X="" S:$L($G(DIR("?"))) X=$G(DIR("?")) S:'$L(X) X="    "_$$SQ^LEXHLP
 W:$L(X) !!,X,!
 W !,"    Best results occur using one to three full or partial words without"
 W !,"    a suffix (i.e., ""DIABETES"",""DIAB MELL"",""DIAB MELL INSUL"") or"
 W !,"    a classification code (ICD, CPT, HCPCS, etc)"
 Q
