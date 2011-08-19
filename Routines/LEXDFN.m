LEXDFN ; ISL Default Names                        ; 10-15-97
 ;;2.0;LEXICON UTILITY;**6**;Sep 23, 1996
 ;
APPN(X) ; Application Name
 N LEXT,LEXA S (LEXA,LEXT)="",X=$G(X)
 I +X>0,$D(^LEXT(757.2,+X,0)) D
 . S LEXA=$P($G(^LEXT(757.2,+X,5)),"^",4)
 . Q:LEXA=""  Q:'$D(^LEXT(757.2,"APPS",LEXA))
 . S LEXT=$P($G(^LEXT(757.2,+X,0)),"^",1)
 S:X'=""&(LEXT="") X="Unknown Application" S:LEXT'="" X=LEXT Q X
DISN(X) ; Display Name
 N LEXT S LEXT="" S X=$G(X) I X'="" D
 . N LEXO,LEXC,LEXR S LEXC=$E(X,1,63),LEXO=$E(LEXC,1,($L(LEXC)-1))_$C($A($E(LEXC,$L(LEXC)))-1)_"~"
 . F  S LEXO=$O(^LEX(757.31,"ADSP",LEXO)) Q:LEXO=""!(LEXO'[LEXC)  D  Q:LEXT'=""
 . . S LEXR=0 F  S LEXR=$O(^LEX(757.31,"ADSP",LEXO,LEXR)) Q:+LEXR=0  D  Q:LEXT'=""
 . . . I $G(^LEX(757.31,LEXR,1))=X S LEXT=$P($G(^LEX(757.31,LEXR,0)),"^",1)
 S:X'=""&(LEXT="") X="User Defined Display" S:LEXT'="" X=LEXT Q X
FILN(X) ; Filter Name
 N LEXT S LEXT="" S X=$G(X) I X'="" D
 . N LEXO,LEXC,LEXR S LEXC=$E(X,1,63)
 . S LEXO=$E(LEXC,1,($L(LEXC)-1))_$C($A($E(LEXC,$L(LEXC)))-1)_"~"
 . F  S LEXO=$O(^LEX(757.3,"AS",LEXO)) Q:LEXT'=""!(LEXO'[LEXC)  D
 . . S LEXR=0 F  S LEXR=$O(^LEX(757.3,"AS",LEXO,LEXR)) Q:+LEXR=0!(LEXT'="")  D  Q:LEXT'=""
 . . . S:$G(^LEX(757.3,+LEXR,1))=X LEXT=$P($G(^LEX(757.3,+LEXR,0)),"^",1)
 S:X'=""&(LEXT="") X="User Defined Filter" S:LEXT'="" X=LEXT Q X
GBLN(X) ; Global Name
 S X=$G(X) Q:X="" "Unknown Global" Q:X'["^" "Unknown Global"
 Q:X'["(" "Unknown Global" N LEXT S LEXT=$G(@(X_"0)"))
 S LEXT=$P(LEXT,"^",1) Q:LEXT="" "Unknown Global"
 N LEXS,LEXK,LEXI S LEXS=""
 F LEXI=1:1:$L(LEXT," ") D
 . S LEXK=$$UP^XLFSTR($E($P(LEXT," ",LEXI),1))_$$LOW^XLFSTR($E($P(LEXT," ",LEXI),2,$L($P(LEXT," ",LEXI))))
 . S LEXS=LEXS_" "_LEXK
 S:$E(LEXS,1)=" " LEXS=$E(LEXS,2,$L(LEXS))
 S LEXT=LEXS Q:LEXT="" "Unknown Global"
 S X=LEXT_" Global" Q X
IDXN(X) ;
 S X=$G(X) Q:X="" "Unknown Index" N LEXT,LEXA S LEXT="",LEXA=$E(X,2,$L(X))
 Q:LEXA="" "Unknown Index" Q:'$D(^LEXT(757.2,"AA",LEXA)) "Unknown Index"
 N LEXR S LEXR=$O(^LEXT(757.2,"AA",LEXA,0))
 Q:+LEXR=0 "Unknown Index" Q:'$D(^LEXT(757.2,+LEXR)) "Unknown Index"
 S LEXT=$P($G(^LEXT(757.2,LEXR,0)),"^",1)
 I +LEXR=1,LEXT'="" S X="Main "_LEXT_" word index" Q X
 I +LEXR>1,LEXT'="" S X=LEXT_" subset word index" Q X
 Q X
OVRN(X) ; Overwrite
 S X=+($G(X)) Q:X=0 "Do not overwrite user defaults"
 Q "Overwrite user defaults"
 ;
SCTN(X) ; Shortcuts Context
 N LEXT,LEXA S (LEXA,LEXT)="",X=$G(X)
 I +X>0,$D(^LEX(757.41,+X,0)) D
 . S LEXA=$P($G(^LEX(757.41,+X,0)),"^",1) Q:LEXA=""  S LEXT=LEXA
 S:X'=""&(LEXT="") X="Unknown Shortcut Context" S:LEXT'="" X=LEXT Q X
 ;
UNRN(X) ; Unresolved Narratives
 S X=+($G(X)) Q:X=0 "Do not use unresolved narratives"
 Q "Use unresolved narratives"
 ;
MODI(X) ; Modifiers         PCH 6 (added)
 S X=+($G(X)) Q:X=0 "Do not use modifiers"
 Q "Use modifiers"
 ;
VOCN(X) ; Vocabulary
 N LEXT,LEXA,LEXR S LEXR=0,LEXT="",LEXA=X,X=""
 I +LEXA>0,$D(^LEXT(757.2,+LEXA)) D
 . S LEXT=$P($G(^LEXT(757.2,+LEXA,0)),"^",2) S:LEXT'="" LEXA=LEXT
 . S LEXT=$P($G(^LEXT(757.2,+LEXA,5)),"^",2) S:LEXT'="" LEXA=LEXT
 I $D(^LEXT(757.2,"AA",LEXA)) D  Q X
 . S LEXR=$O(^LEXT(757.2,"AA",LEXA,0)) I +LEXR=0 S X="Unknown Vocabulary" Q
 . S X=$P($G(^LEXT(757.2,+LEXR,0)),"^",1) I X="" S X="Unknown Vocabulary" Q
 I $D(^LEXT(757.2,"AB",LEXA)) D  Q X
 . S LEXR=$O(^LEXT(757.2,"AB",LEXA,0)) I +LEXR=0 S X="Unknown Vocabulary" Q
 . S LEXA=$P($G(^LEXT(757.2,+LEXR,5)),"^",2)
 . I LEXA="" S LEXA=$P($G(^LEXT(757.2,+LEXR,0)),"^",2)
 . I LEXA'="",$D(^LEXT(757.2,"AA",LEXA)) D
 . . S LEXR=$O(^LEXT(757.2,"AA",LEXA,0)) I +LEXR=0 S X="Unknown Vocabulary" Q
 . . S X=$P($G(^LEXT(757.2,+LEXR,0)),"^",1) I X="" S X="Unknown Vocabulary" Q
 . I X="" S X="Unknown Vocabulary"
 S:X="" X="Unknown Vocabulary" Q X
