LEXNDX6 ;ISL/KER - Set/kill indexes (Misc) ;04/21/2014
 ;;2.0;LEXICON UTILITY;**80**;Sep 23, 1996;Build 1
 ;               
 ; Global Variables
 ;    ^LEX(757.4)         N/A
 ;    ^TMP("LEXTKN")      SACC 2.3.2.5.1
 ;               
 ; External References
 ;    $$UP^XLFSTR         ICR  10103
 ;               
SRA ; Set Shortcut index
 Q:'$D(X)!('$D(DA))!('$D(DA(1)))  N LEXKW S LEXKW=$P($G(^LEX(757.4,DA(1),1,DA,0)),U,1) S:$L(LEXKW) ^LEX(757.4,"ARA",$E($$UP^XLFSTR(LEXKW),1,63),X,DA(1),DA)="" Q
KRA ; Kill Shortcut index
 Q:'$D(X)!('$D(DA))!('$D(DA(1)))  N LEXKW S LEXKW=$P($G(^LEX(757.4,DA(1),1,DA,0)),U,1) K:$L(LEXKW) ^LEX(757.4,"ARA",$E($$UP^XLFSTR(LEXKW),1,63),X,DA(1),DA) Q
 ;
SSF ; Set String Frequency
 Q:'$L($G(X))  N LEXIDX,LEXE
 S LEXIDX="",LEXE=X,X=$$UP^XLFSTR(X) D PTX^LEXTOKN
 I $D(^TMP("LEXTKN",$J,0)),^TMP("LEXTKN",$J,0)>0 D
 . N LEXNT,LEXT,LEXW,LEXI,LEXP,LEXS S LEXI=""
 . S LEXI=0 F  S LEXI=$O(^TMP("LEXTKN",$J,LEXI)) Q:+LEXI'>0  D
 . . S LEXW=$O(^TMP("LEXTKN",$J,LEXI,"")) Q:'$L(LEXW)
 . . F LEXP=1:1:$L(LEXW) D
 . . . S LEXS=$E(LEXW,1,LEXP)
 . . . ; Re-indexing All Entries of the file
 . . . I $D(DICNT)!($D(DIKDASV))!($D(DIKSAVE)) D  Q
 . . . . S LEXT=0 I $D(^LEX(757.01,"ASL",LEXS)) D
 . . . . . S LEXT=$O(^LEX(757.01,"ASL",LEXS,0))
 . . . . S LEXNT=LEXT+1 Q:LEXNT'>0
 . . . . K ^LEX(757.01,"ASL",LEXS)
 . . . . S ^LEX(757.01,"ASL",LEXS,LEXNT)=""
 . . . ; Re-indexing One Entry of the file
 . . . S LEXNT=$$FRE(LEXS) Q:LEXNT'>0
 . . . K ^LEX(757.01,"ASL",LEXS)
 . . . S ^LEX(757.01,"ASL",LEXS,LEXNT)=""
 S X=LEXE K ^TMP("LEXTKN",$J) N DICNT,DIKDASV,DIKSAVE
 Q
KSF ; Kill String Frequency
 Q:'$L($G(X))  N LEXIDX,LEXE
 S LEXIDX="",LEXE=X,X=$$UP^XLFSTR(X) D PTX^LEXTOKN
 I $D(^TMP("LEXTKN",$J,0)),^TMP("LEXTKN",$J,0)>0 D
 . N LEXNT,LEXT,LEXW,LEXI,LEXP,LEXS S LEXI=""
 . S LEXI=0 F  S LEXI=$O(^TMP("LEXTKN",$J,LEXI)) Q:+LEXI'>0  D
 . . S LEXW=$O(^TMP("LEXTKN",$J,LEXI,""))
 . . I $L(LEXW) F LEXP=1:1:$L(LEXW) D
 . . . S LEXS=$E(LEXW,1,LEXP),LEXT=0
 . . . I $D(^LEX(757.01,"ASL",LEXS)) D
 . . . . S LEXT=$O(^LEX(757.01,"ASL",LEXS,0))
 . . . S LEXNT=LEXT-1
 . . . I LEXNT'>0 K ^LEX(757.01,"ASL",LEXS) Q
 . . . K ^LEX(757.01,"ASL",LEXS)
 . . . S ^LEX(757.01,"ASL",LEXS,LEXNT)=""
 . . . 
 S X=LEXE K ^TMP("LEXTKN",$J)
 Q
FRE(X) ; Frequency Counter of String
 N LEXC,LEXTK,LEXTKN,LEXO,LEXT,LEXS,LEXP
 S (LEXC,LEXTK)=$$UP^XLFSTR($G(X)),LEXT=0  Q:'$L(LEXTK) 0
 S:$L(LEXTK)>1 LEXO=$E(LEXTK,1,($L(LEXTK)-1))_$C(($A($E(LEXTK,$L(LEXTK)))-1))_"~"
 S:$L(LEXTK)=1 LEXO=$C(($A(LEXTK)-1))_"~"
 F  S LEXO=$O(^LEX(757.01,"AWRD",LEXO)) Q:'$L(LEXO)  Q:$E(LEXO,1,$L(LEXC))'=LEXC  D
 . N LEXM S LEXM=0 F  S LEXM=$O(^LEX(757.01,"AWRD",LEXO,LEXM)) Q:+LEXM'>0  D
 . . N LEXE S LEXE=0 F  S LEXE=$O(^LEX(757.01,"AWRD",LEXO,LEXM,LEXE)) Q:+LEXE'>0  D
 . . . S LEXT=LEXT+1
 S X=LEXT
 Q X
 ;
SSUP ; Set Supplemental Words
 N LEXX,LEXDA1,LEXDA,LEXMC
 S LEXX=$G(X) Q:'$L(LEXX)  S LEXDA1=+($G(DA(1)))
 Q:LEXDA1=0  S LEXDA=+($G(DA)) Q:LEXDA=0
 S LEXMC=$$MC(LEXDA1) Q:LEXMC=0
 S ^LEX(757.01,"AWRD",$$UP^XLFSTR(LEXX),LEXDA1,LEXMC,LEXDA)=""
 Q
KSUP ; Kill Supplemental Words
 N LEXX,LEXDA1,LEXDA,LEXMC
 S LEXX=$G(X) Q:'$L(LEXX)  S LEXDA1=+($G(DA(1))) Q:LEXDA1=0  S LEXDA=+($G(DA)) Q:LEXDA=0
 S LEXMC=$$MC(LEXDA1) Q:LEXMC=0
 K ^LEX(757.01,"AWRD",LEXX,LEXDA1,LEXMC,LEXDA)
 K ^LEX(757.01,"AWRD",$$UP^XLFSTR(LEXX),LEXDA1,LEXMC,LEXDA)
 Q
 ; 
 ; Miscellaneous
MC(X) ; Major Concept IEN
 N LEXX S LEXX=+($G(X)) Q:LEXX=0 0
 S LEXX=+($G(^LEX(757.01,LEXX,1))) Q:LEXX=0 0
 S LEXX=+($G(^LEX(757,LEXX,0))) Q:LEXX=0 0
 S X=LEXX Q X
