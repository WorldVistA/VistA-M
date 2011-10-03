LEXMTLU ; ISL Setup Appl/User Defaults for Look-up ; 05/25/1998
 ;;2.0;LEXICON UTILITY;**11**;Sep 23, 1996
 ;
EN ; X not set
 D MTLU^LEXSET5 S X=$$TERM Q:X=""!(X["^")
 I $D(X),$G(X)'[U,$G(X)'="",$G(X)'=" " D XTLK
 Q
XTLK ;
 N LEXQ S LEXQ=0 D MTLU^LEXSET5
 I '$D(X)!($G(X)[U)!($G(X)="")!($G(X)=" ") S X=$$TERM
 Q:X=""!(X["^")  S XTLKX=X D ^XTLKKWL
 K DIC,LEXAP,LEXLL,LEXSHOW,LEXSUB,LEXUN
 K XTLKKSCH,XTLKSAY,XTLKWD2,XTLKX,XTLKHLP S:+Y'>0 X=""
 Q
TERM(X) ; Get expression
 N DIR,Y S DIR("A")="Enter an expression:  "
 S DIR("?")="    "_$$SQ^LEXHLP  ; PCH 11
 S DIR("??")="^D TERMHLP^LEXMTLU" N Y S DIR(0)="FAO^2:245" D ^DIR
 S DIC="^LEX(757.01," S:X[U&(X'["^^") X=U S:X["^^" X="^^" Q:X[U "^"
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
DD ; Display Defaults in ^TMP("LEXSCH",$J)
 N LEXNODE S LEXNODE="^TMP(""LEXSCH"","_$J_")"
 N LEXOK S LEXOK=1 F  S LEXNODE=$Q(@LEXNODE) Q:'LEXOK  D  Q:'LEXOK
 . I LEXNODE'["LEXSCH" S LEXOK=0 Q
 . I LEXNODE'[$J S LEXOK=0 Q
 . W !,LEXNODE,"=",@LEXNODE
 Q
