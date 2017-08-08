LEXQWS ;ISL/KER - Query - Words - Supplemental Keywords ;05/23/2017
 ;;2.0;LEXICON UTILITY;**103**;Sep 23, 1996;Build 2
 ;               
 ; Global Variables
 ;    ^TMP("LEXSUP",$J)   SACC 2.3.2.5.1
 ;               
 ; External References
 ;    ^DIC                ICR  10006
 ;    $$FMTE^XLFDT        ICR  10103
 ;              
EN ; Supplemental Keywords
 N LEXENV S LEXENV=$$EV^LEXQM Q:+LEXENV'>0  N LEXEXIT S LEXEXIT=0 W ! F  D SUPL Q:+LEXEXIT>0
 Q
SUPL ;   Supplemental Keyword - Lookup
 N LEXEFF,LEXEXS,LEXID,LEXIEN,LEXINA,LEXINS,LEXLEN,LEXTAB,LEXWRD
 S LEXID="LEXSUP" K ^TMP(LEXID,$J),LEXA
 S LEXLEN=$$KL,LEXTAB=3,LEXIEN=$$SUPA S:+LEXIEN'>0 LEXEXIT=1 Q:LEXEXIT>0
 S LEXWRD=$P($G(^LEX(757.071,+LEXIEN,0)),"^",1) Q:'$L(LEXWRD)
 S LEXEFF=$P($G(^LEX(757.071,+LEXIEN,0)),"^",2) Q:LEXEFF'?7N
 S LEXINA=$P($G(^LEX(757.071,+LEXIEN,0)),"^",3)
 S LEXINS=$P($G(^LEX(757.071,+LEXIEN,0)),"^",4) Q:'$L(LEXINS)
 S LEXEXS=$P($G(^LEX(757.071,+LEXIEN,0)),"^",5)
 S LEXT=" Keyword:    "_LEXWRD
 S LEXO=$O(^TMP(LEXID,$J," "),-1)+1 S ^TMP(LEXID,$J,LEXO)=LEXT
 S LEXT="",LEXO=$O(^TMP(LEXID,$J," "),-1)+1 S ^TMP(LEXID,$J,LEXO)=LEXT
 S LEXT=" Effective:  "_$$FMTE^XLFDT(LEXEFF,"5Z")
 I LEXINA?7N D
 . S LEXT=LEXT_$J(" ",(35-$L(LEXT)))_"Inactivated:  "_$$FMTE^XLFDT(LEXINA,"5Z")
 S LEXO=$O(^TMP(LEXID,$J," "),-1)+1 S ^TMP(LEXID,$J,LEXO)=LEXT
 S LEXT="",LEXO=$O(^TMP(LEXID,$J," "),-1)+1 S ^TMP(LEXID,$J,LEXO)=LEXT
 S LEXT=" Used with expressions that:"
 S LEXO=$O(^TMP(LEXID,$J," "),-1)+1 S ^TMP(LEXID,$J,LEXO)=LEXT
 S LEXT="",LEXO=$O(^TMP(LEXID,$J," "),-1)+1 S ^TMP(LEXID,$J,LEXO)=LEXT
 F LEXI=1:1 Q:'$L($P(LEXINS,";",LEXI))  D
 . N LEXT,LEXPH,LEXLDR S LEXPH=$P(LEXINS,";",LEXI),LEXLDR="             "
 . S:LEXI=1 LEXLDR="   Include   "
 . S LEXT=LEXLDR_LEXPH
 . S LEXO=$O(^TMP(LEXID,$J," "),-1)+1 S ^TMP(LEXID,$J,LEXO)=LEXT
 F LEXI=1:1 Q:'$L($P(LEXEXS,";",LEXI))  D
 . N LEXT,LEXPH,LEXLDR S LEXPH=$P(LEXEXS,";",LEXI),LEXLDR="             "
 . S:LEXI=1 LEXLDR="   Exclude   "
 . S LEXT=LEXLDR_LEXPH
 . S LEXO=$O(^TMP(LEXID,$J," "),-1)+1 S ^TMP(LEXID,$J,LEXO)=LEXT
 D DSP^LEXQO(LEXID) W !
 Q
SUPALL ;   Supplemental Keyword - All
 N LEXKEY,LEXKEYL,LEXINCL,LEXEXCL,LEXID S (LEXINCL,LEXEXCL)=0 S LEXKEYL=$$KL,LEXID="LEXSUP"
 K ^TMP(LEXID,$J) S LEXKEY="" F  S LEXKEY=$O(^LEX(757.071,"B",LEXKEY)) Q:'$L(LEXKEY)  D
 . N LEXT,LEXIEN,LEXICT,LEXECT,LEXIN,LEXEX
 . S LEXT=LEXKEY
 . S (LEXICT,LEXECT,LEXIEN)=0 F  S LEXIEN=$O(^LEX(757.071,"B",LEXKEY,LEXIEN)) Q:+LEXIEN'>0  D
 . . N LEXND,LEXEFF,LEXIAN,LEXINC,LEXINCP,LEXEXC,LEXEXCP,LEXPIE,LEXCT,LEXIN,LEXEX
 . . S LEXND=$G(^LEX(757.071,+LEXIEN,0))
 . . S LEXEFF=$P(LEXND,"^",2)
 . . S LEXIAN=$P(LEXND,"^",3)
 . . S LEXINC=$P(LEXND,"^",4) Q:'$L(LEXINC)
 . . S LEXEXC=$P(LEXND,"^",5)
 . . F LEXPIE=1:1 S LEXINCP=$P(LEXINC,";",LEXPIE) Q:'$L(LEXINCP)  D
 . . . N LEXI S LEXI=$O(LEXIN(" "),-1)+1,LEXIN(LEXI)=LEXINCP
 . . F LEXPIE=1:1 S LEXEXCP=$P(LEXEXC,";",LEXPIE) Q:'$L(LEXEXCP)  D
 . . . N LEXI S LEXI=$O(LEXEX(" "),-1)+1,LEXEX(LEXI)=LEXEXCP
 . . S LEXT=LEXKEY
 . . S LEXT=LEXT_$J(" ",((LEXKEYL+2)-$L(LEXT)))_$G(LEXIN(1)) D IL(LEXT,LEXID)
 . . S LEXPIE=1 F  S LEXPIE=$O(LEXIN(LEXPIE)) Q:LEXPIE'>0  D
 . . . N LEXD S LEXD=$G(LEXIN(LEXPIE)) Q:'$L(LEXD)
 . . . S LEXT="",LEXT=LEXT_$J(" ",((LEXKEYL+2)-$L(LEXT)))_LEXD
 . . . D IL(LEXT,LEXID)
 . . I $L($G(LEXEX(1))) D
 . . . S LEXT="",LEXT=LEXT_$J(" ",((LEXKEYL+2)-$L(LEXT)))_"Excludes:"
 . . . S LEXT=LEXT_$J(" ",((LEXKEYL+13)-$L(LEXT)))_$G(LEXEX(1))
 . . . D EL(LEXT,LEXID)
 . . . S LEXPIE=1 F  S LEXPIE=$O(LEXEX(LEXPIE)) Q:LEXPIE'>0  D
 . . . . N LEXD,LEXS S LEXS="           ",LEXD=$G(LEXEX(LEXPIE)) Q:'$L(LEXD)
 . . . . S LEXT="",LEXT=LEXT_$J(" ",((LEXKEYL+2)-$L(LEXT)))_LEXS_LEXD
 . . . . D EL(LEXT,LEXID)
 N CAP D DSP^LEXQO(LEXID)
 Q
SUPA(X) ;   Supplemental Keyword - Ask
 N DIC,DTOUT,DUOUT,Y S DIC="^LEX(757.071,",DIC(0)="AEQM"
 D ^DIC Q:$D(DTOUT)!($D(DUOUT)) "^"  S X=+Y
 Q X
ABROK(X) ;   Supplemental Keyword - OK
 N LEXI,LEXA,LEXO S LEXI=+($G(X)),LEXO=0,LEXA="" F  S LEXA=$O(^LEX(757.07,"ABBR",LEXA)) Q:'$L(LEXA)  D
 . S:$D(^LEX(757.07,"ABBR",LEXA,+LEXI)) LEXO=1
 S X=LEXO
 Q X
 ; 
 ; Miscellaneous
IL(X,Y) ;   Include Text Line
 N LEXT,LEXL,LEXI S LEXT=$G(X),LEXI=$G(Y) Q:'$L(LEXI)  S LEXL=$O(^TMP(LEXI,$J," "),-1)+1
 I $D(CAP) D  Q
 . I $E(LEXT,1)'=" " D
 . . S LEXT=$$TM(LEXT),^TMP(LEXID,$J,LEXL)=($P(LEXT," ",1)_"~"_$$TM($P(LEXT," ",2,4000)))
 . I $E(LEXT,1)=" " D
 . . S LEXT=$$TM(LEXT),^TMP(LEXID,$J,LEXL)=$E(("~"_LEXT),1,79)
 I '$D(CAP) D  Q
 . S ^TMP(LEXID,$J,LEXL)=$E((" "_LEXT),1,79)
 Q
EL(X,Y) ;   Exclude Text Line
 N LEXT,LEXL,LEXI S LEXT=$G(X),LEXI=$G(Y) Q:'$L(LEXI)  S LEXL=$O(^TMP(LEXI,$J," "),-1)+1
 I $D(CAP) D  Q
 . I $E(LEXT,1)=" ",LEXT["Excludes:" D
 . . S LEXT=$$TM(LEXT),^TMP(LEXID,$J,LEXL)=$E(("~"_$P(LEXT," ",1)_"~"_$$TM($P(LEXT," ",2,4000))),1,79)
 . I $E(LEXT,1)=" ",LEXT'["Excludes:" D
 . . S LEXT=$$TM(LEXT),^TMP(LEXID,$J,LEXL)=$E(("~~"_LEXT),1,79)
 I '$D(CAP) D  Q
 . S ^TMP(LEXID,$J,LEXL)=$E((" "_LEXT),1,79)
 Q
KL(X) ;   Maximum Keyword Length
 N LEX S X=0,LEX="" F  S LEX=$O(^LEX(757.071,"B",LEX)) Q:'$L(LEX)  S:$L(LEX)>X X=$L(LEX)
 Q X
TM(X,Y) ;   Trim Character Y - Default " "
 S X=$G(X) Q:X="" X  S Y=$G(Y) S:'$L(Y) Y=" "
 F  Q:$E(X,1)'=Y  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=Y  S X=$E(X,1,($L(X)-1))
 Q X
