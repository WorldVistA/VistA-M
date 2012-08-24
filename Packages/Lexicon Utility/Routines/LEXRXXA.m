LEXRXXA ;ISL/KER - Re-Index Ask ;08/17/2011
 ;;2.0;LEXICON UTILITY;**81**;Sep 23, 1996;Build 1
 ;               
 ; Global Variables
 ;    ^LEX(               SACC 1.3 
 ;    ^LEXT(              SACC 1.3 
 ;               
 ; External References
 ;    ^DIC                ICR  10006
 ;    ^DIR                ICR  10026
 ;    $$UP^XLFSTR         ICR  10104
 ;               
 ; Local Variables NEWed or KILLed Elsewhere
 ;     LEXFI      File Number     NEWed/KILLed by ONE^LEXRX
 ;               
 Q
AMSO(X) ; All, Major, Supporting or One File
 N LEX,DIR,DTOUT,DUOUT,DIRUT,DIROUT,LEXB,LEXN,Y K LEX
 D AMSOF S LEX="" S LEXB=$$BOLD^LEXRXXM,LEXN=$$NORM^LEXRXXM
 S DIR(0)="SAO^A:All Lexicon Files;M:Major Lexicon Files"
 S DIR(0)=DIR(0)_";S:Supporting Lexicon Files;O:One Lexicon File"
 S (DIR("?"),DIR("??"))="^D AMSOH^LEXRXXA"
 S DIR("PRE")="S X=$$AMSOP^LEXRXXA($G(X))"
 S DIR("A")=" Select "_LEXB_"A"_LEXN_"ll, "_LEXB_"M"_LEXN_"ajor, "
 S DIR("A")=DIR("A")_LEXB_"S"_LEXN_"upporting or "_LEXB_"O"_LEXN
 S DIR("A")=DIR("A")_"ne Lexicon file(s):  (A/M/S/O)  "
 W ! D ^DIR S X=Y
 Q X
AMSOP(X) ;   All, Major, Supporting or One File - Pre-process
 N Y Q:'$L($G(X)) ""  Q:$G(X)["^" "^"  S X=$G(X)
 S Y=$$UP^XLFSTR($E(X,1)) S:"^A^M^S^O^?^"'[("^"_Y_"^") X="??"
 Q X
AMSOH ;   All, Major, Supporting or One File - Help
 W:$L($G(IOF))&($D(LEX)) @IOF D:$D(LEX) AMSOH2
AMSOF ;   All, Major, Supporting or One File - List Files
 W:$L($G(IOF))&('$D(LEX)) @IOF
 N LEXB,LEXN,LEXC,LEXT,LEXF,LEX1,LEX2,LEX3
 S LEXB=$$BOLD^LEXRXXM,LEXN=$$NORM^LEXRXXM
 S:'$D(LEX) (LEXB,LEXN)=""
 S LEX1=3,LEX2=6,LEX3=24 S:$D(LEX) LEX2=LEX2-1,LEX3=LEX3-1
 W !," Repair/Re-Index Lexicon Cross-References",!
 S LEXC="",LEXT="",LEXF=""
 W !,?LEX1,LEXC,?LEX2,LEXT,?LEX3,LEXF
 S LEXC=LEXB_"A"_LEXN
 S LEXT="All files"
 S LEXF="757*"
 W !,?LEX1,LEXC,?LEX2,LEXT,?LEX3,LEXF
 S LEXC="",LEXT="",LEXF=""
 S LEXC=LEXB_"M"_LEXN
 S LEXT="Major files"
 S LEXF="757, 757.001, 757.01, 757.02, 757.1, 757.21 and 757.33"
 W !,?LEX1,LEXC,?LEX2,LEXT,?LEX3,LEXF
 S LEXC="",LEXT="",LEXF=""
 S LEXC=LEXB_"S"_LEXN
 S LEXT="Supporting files"
 S LEXF="757.011, 757.014, 757.03, 757.04, 757.05, 757.06,"
 W !,?LEX1,LEXC,?LEX2,LEXT,?LEX3,LEXF
 S LEXC=LEXB_" "_LEXN
 S LEXT=""
 S LEXF="757.11, 757.12, 757.13, 757.14, 757.2, 757.3,"
 W !,?LEX1,LEXC,?LEX2,LEXT,?LEX3,LEXF
 S LEXC=LEXB_" "_LEXN
 S LEXT=""
 S LEXF="757.31, 757.4 and 757.41"
 W !,?LEX1,LEXC,?LEX2,LEXT,?LEX3,LEXF
 S LEXC="",LEXT="",LEXF=""
 S LEXC=LEXB_"O"_LEXN
 S LEXT="One file"
 S LEXF="Select a single Lexicon file"
 W !,?LEX1,LEXC,?LEX2,LEXT,?LEX3,LEXF
 Q
AMSOH2 ;   All, Major, Supporting or One File - Help
 N LEXB,LEXN S LEXB=$$BOLD^LEXRXXM,LEXN=$$NORM^LEXRXXM
 W !," The cross-references of the Major (larger) files"
 W " involved with the"
 W !," Lexicon Lookup will be repaired.  During the repair"
 W " process the "
 W !," cross-references are not deleted.  Only those cross-"
 W "reference nodes "
 W !," that fail verification will be deleted.  The Supporting"
 W " (smaller) files",!," will be re-indexed.",!,?1,"  "
 W !,?1,LEXB,"Users may remain on the system.",LEXN
 W !,?1,"  "
 Q
 ;                 
CO(X) ; Ask to Continue
 S LEXTY=$G(LEXTY) N DIR,DTOUT,DUOUT,DIRUT,DIROUT,Y
 S DIR(0)="YAO",(DIR("?"),DIR("??"))="^D COH^LEXRXXA"
 S DIR("A")=" Do you wish to continue?  (Y/N)  "
 S DIR("PRE")="S:X[""?"" X=""??""" W ! D ^DIR
 S X=+Y S:$D(DTOUT)!($D(DUOUT))!($D(DIRUT))!($D(DIROUT)) X="^"
 N LEXTY
 Q X
COH ;   Continue Help
 N LEXFN,LEXAC S LEXAC="repair/re-index"
 S:+($G(LEXTY))=1 LEXAC="repair" S:+($G(LEXTY))=2 LEXAC="re-index"
 I +($G(LEXTY))'>0 D
 . W !,"   Answer 'Yes' to ",LEXAC," the Lexicon's cross-references"
 I +($G(LEXTY))=1&(+($G(LEXFI))'>0) D
 . W !,"   Answer 'Yes' to ",LEXAC," the Lexicon's cross-references"
 . W " of the",!,"   larger files"
 I +($G(LEXTY))=2&(+($G(LEXFI))'>0) D
 . W !,"   Answer 'Yes' to ",LEXAC," the Lexicon's cross-references"
 . W " of the",!,"   smaller files"
 I +($G(LEXTY))=3&(+($G(LEXFI))'>0) D
 . W !,"   Answer 'Yes' to ",LEXAC," the cross-references of all"
 . W !,"   of the Lexicon's files"
 I +($G(LEXTY))>0&(+($G(LEXFI))>0) D
 . I $D(^LEX(+($G(LEXFI))))!($D(^LEXT(+($G(LEXFI))))) D  Q
 . . N LEXFN S LEXFN=$$FN^LEXRXXM(+($G(LEXFI)))
 . . I $L($G(LEXFN))&(+($G(LEXFI))>0) D
 . . . W !,"   Answer 'Yes' to ",LEXAC," the cross-references of "
 . . . W "the ",LEXFN,!,"   file #",$G(LEXFI)
 . . I '$L($G(LEXFN))&(+($G(LEXFI))>0) D
 . . . W !,"   Answer 'Yes' to ",LEXAC," the cross-references of "
 . . . W "file #",$G(LEXFI)
 . W !,"   Answer 'Yes' to ",LEXAC," the cross-references of "
 . W "the file(s)"
 Q
 ;              
FI(X) ; Select File
 N DIC,DTOUT,DUOUT,Y,LEX S DIC="^DIC(",DIC(0)="AEMQ"
 S DIC("A")=" Select Lexicon File:  "
 S DIC("S")="I +($$FV^LEXRXXM(+Y))>0"
 W ! D ^DIC K DIC("S") S LEX=+($$FV^LEXRXXM(+Y))
 Q:$D(DTOUT)!($D(DUOUT)) "^"  S X=+Y Q:LEX>0 X
 Q "^"
 ;              
 ; Miscellaneous
CLR ;   Clear
 K LEXFI
 Q
