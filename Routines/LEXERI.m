LEXERI ; ISL Exc/Rep Word Input Transformations   ; 09-23-96
 ;;2.0;LEXICON UTILITY;;Sep 23, 1996
 Q
 ;
EXC ; Input transformation for ^LEX(757.04, - .01
 Q:'$D(X)  S LEXX=X
 I LEXX[" " D  K X Q
 . W !,$C(34),X,$C(34)," contains a space"
 S LEXX=$$CVT(LEXX)
 I $D(^LEX(757.04,"AB",$E(LEXX,1,40))) D  Q
 . N LEXDA S LEXDA=$G(DA) I +LEXDA>0,$D(^LEX(757.04,"AB",$E(LEXX,1,40),LEXDA)) Q
 . W !,$C(34),LEXX,$C(34)," is already defined as an excluded word" K X
 I $D(^LEX(757.05,"AB",$E(LEXX,1,40))) D  Q
 . W !,$C(34),LEXX,$C(34)," has been defined as a replacement word (file #757.05)"
 . W !!,"You can not exclude a word from a search which is to be replaced"
 . W !,"by another expression prior to performing the search"
 I $D(^LEX(757.05,"C",$E($$UP^XLFSTR(LEXX),1,40))) D  K X Q
 . W !,$C(34),LEXX,$C(34)," has been defined as a replacement word (file #757.05)"
 . W !!,"You can not exclude a word from a search which is to be inserted"
 . W !,"as replacement text prior to performing the search"
 S X=LEXX
 Q
REP ; Input Transformation for ^LEX(757.05, - .01
 Q:'$D(X)  S LEXX=X
 N LEXOK,LEXPSN S LEXOK=1 F LEXPSN=1:1:$L(LEXX) D
 . I $E(LEXX,LEXPSN)'?1A&($E(LEXX,LEXPSN)'="/") S LEXOK=0
 I 'LEXOK D  K X Q
 . W !,"Alpha-numeric expression.  The only punctuation allowed is the slash ""/"""
 S LEXX=$$CVT(LEXX)
 I $D(^LEX(757.04,"AB",$E(X,1,40))) N LEX S LEX=0 D  I 'LEX K X Q
 . W !!,$C(7),$C(34),LEXX,$C(34)," already exist in the Excluded Words file."
 . W !,"Do you want to delete it from the Excluded Words file"
 . W !,"and continue to add it as a replacement word?  No//  "
REP2 . R LEX:300 I '$T!(LEX="")!(LEX[U) S LEX=0 Q
 . I LEX["?" D  G REP2
 . . W !!,"Yes",!,"Add ",LEXX," to the Replacement Words file and delete it",!,"from the Excluded Words file"
 . . W !!,"No",!,"Do not add ",LEXX," to the Replacement Words file and ",!,"retain it in the Excluded Words file"
 . . W !!,"",!,"Delete?  No//  "
 . I $E(LEX,1)'="Y"&($E(LEX,1)'="N")&($E(LEX,1)'="y")&($E(LEX,1)'="n") W !!,"",!,"Delete?  No//  " G REP2
 . I $E(LEX,1)="Y"!($E(LEX,1)="y") S LEX=1 D  Q
 . . S ZTSAVE("X")="",ZTRTN="DEXC^LEXERI",ZTDESC="Deleting "_X_" from Excluded Words file #757.04"
 . . S ZTIO="",ZTDTH=$H D ^%ZTLOAD,HOME^%ZIS W:$D(ZTSK) !!,"Deleting "_X_" from Excluded Words file #757.04" K Y,ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN
 . S LEX=0
 I $D(^LEX(757.05,"AB",$E(X,1,40))) D  K:+($G(LEX)) LEX,LEXR Q
 . I $O(^LEX(757.05,"AB",$E(X,1,40),0))=+DA Q
 . S (LEX,LEXR)=0 F  S LEXR=$O(^LEX(757.05,"AB",$E(X,1,40),LEXR)) D  Q:+LEXR=0
 . . I +LEXR>0,$D(^LEX(757.05,LEXR,0)),$P(^LEX(757.05,LEXR,0),"^",3)="R" D  S LEXR=0
 . . . W !!,$C(34),LEXX,$C(34)," already exist in the Replacement Words file (#757.05)"
 . . . W !,"as a (R)eplaced word.  You may alter the original entry to be a"
 . . . W !,"(L)inked word, but you can not (R)eplace ",$C(34),LEXX,$C(34)," with multiple"
 . . . W !,"expressions/concepts",!!
 . . . S LEX=1
 S X=LEXX
 Q
DEXC ; Delete entry from Excluded Words file #757.04
 Q:'$D(X)  Q:'$D(^LEX(757.04,"AB",$E(X,1,40)))  S DA=$O(^LEX(757.04,"AB",$E(X,1,40),0)),DIK="^LEX(757.04," D ^DIK K DA,DIK S:$D(ZTQUEUED) ZTREQ="@" Q
REPBY ; Input Transformation for ^LEX(757.05, - 1
 Q:'$D(X)  N LEXX S LEXX=$$CVT(X)
 Q:$D(^LEX(757.05,"C",$E(LEXX,1,40),DA))
 I '+($$EXIST^LEXERF(LEXX)) D  K X,LEXX Q
 . W !!,$C(34),LEXX,$C(34)," does not exist in the Lexicon.  You"
 . W !,"may not replace a word with text not found in the Lexicon,"
 . W !,"resulting in unsuccessful searches."
 N LEXOK,LEXJ,LEXI S (LEXOK,LEXJ)=1,LEXI=""
 F  S LEXI=$P(LEXX," ",LEXJ) D  S LEXJ=LEXJ+1 I 'LEXOK!($P(LEXX," ",LEXJ)="") Q
 . I $D(^LEX(757.05,"AB",$E(LEXI,1,40))) D
 . . N LEXR S LEXR=0 W !,LEXI
 . . F  S LEXR=$O(^LEX(757.05,"AB",$E(LEXI,1,40),LEXR)) D  Q:+LEXR=0
 . . . I +LEXR'=0,$D(^LEX(757.05,LEXR,0)),$P(^LEX(757.05,LEXR,0),"^",3)="R" D  S LEXR=0
 . . . . W !!,"WARNING:  Your input contains the word ",$C(34),LEXI,$C(34)," which is"
 . . . . W !,"already defined in the Replacement Words file (#757.05) as a (R)eplaced"
 . . . . W !,"word.  This may cause problems (i.e., circular definition of a word) "
 . . . . W !,"resulting in an unsuccessful search in the Lexicon."
 . . . . W !!,"   Example of a circular definition:"
 . . . . W !!,"        Replace:  CA        with   CANCER          and"
 . . . . W !,"        Replace:  CALCIUM   with   CA         ",!!
 . . . . W !!,"   Searching for ",$C(34),"CALCIUM",$C(34)," may result in a listing of CANCER's,"
 . . . . W !,"   depending on the order of replacement."
 . . . . S LEXOK=0
 S X=LEXX K:'LEXOK X K LEXOK,LEXI,LEXJ,LEXR,LEXX
 Q
CVT(LEXX) ; Convert Text
 S LEXX=$$UP^XLFSTR(LEXX) N LEXI,LEXJ S LEXJ="" F LEXI=1:1:$L(LEXX) D
 . I $A($E(LEXX,LEXI))=47!($A($E(LEXX,LEXI))>64&($A($E(LEXX,LEXI))<91)) S LEXJ=LEXJ_$E(LEXX,LEXI)
 . E  S LEXJ=LEXJ_" "
 S LEXX=LEXJ K LEXI,LEXJ Q LEXX
