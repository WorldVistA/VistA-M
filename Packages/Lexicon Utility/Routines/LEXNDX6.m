LEXNDX6 ;ISL/KER - Set/kill indexes (Misc) ;12/19/2014
 ;;2.0;LEXICON UTILITY;**80,86**;Sep 23, 1996;Build 1
 ;               
 ; Global Variables
 ;    ^LEX(757.4)         N/A
 ;    ^TMP("LEXTKN")      SACC 2.3.2.5.1
 ;               
 ; External References
 ;    $$UP^XLFSTR         ICR  10103
 ;               
 ; NEWed/KILLed by FileMan
 ;    DA
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
 . . . I '$D(LEXRECAL) D  Q
 . . . . S LEXT=0 I $D(^LEX(757.01,"ASL",LEXS)) D
 . . . . . S LEXT=$O(^LEX(757.01,"ASL",LEXS,0))
 . . . . S LEXNT=LEXT+1 Q:LEXNT'>0
 . . . . K ^LEX(757.01,"ASL",LEXS)
 . . . . S ^LEX(757.01,"ASL",LEXS,LEXNT)=""
 . . . ; Re-indexing One Entry of the file
 . . . S LEXNT=$$FRE(LEXS) Q:LEXNT'>0
 . . . K ^LEX(757.01,"ASL",LEXS)
 . . . S ^LEX(757.01,"ASL",LEXS,LEXNT)=""
 S X=LEXE K ^TMP("LEXTKN",$J) N DICNT,DIKDASV,DIKSAVE K LEXRECAL
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
 N LEX,LEXA,LEXE,LEXIT,LEXM,LEXN,LEXO,LEXOUT,LEXP,LEXRT,LEXRT2,LEXS,LEXT,LEXTKN
 S LEXS=$$UP^XLFSTR($G(X)) Q:'$L(LEXS) 0  S LEXRT="" S:$D(^LEX(757.01,"AWRD")) LEXRT="^LEX(757.01,""AWRD"","
 Q:'$L(LEXRT) 0  S (LEXA,LEXN,LEXT)=0
 S:$L(LEXS)>1 LEXO=$E(LEXS,1,($L(LEXS)-1))_$C(($A($E(LEXS,$L(LEXS)))-1))_"~"
 S:$L(LEXS)=1 LEXO=$C(($A(LEXS)-1))_"~" S LEXIT=0
 F  S LEXO=$O(@(LEXRT_""""_LEXO_""")")) D  Q:LEXIT>0
 . S:'$L(LEXO) LEXIT=1 S:$E(LEXO,1,$L(LEXS))'=LEXS LEXIT=1
 . Q:LEXIT>0  N LEXM S LEXM=0 F  S LEXM=$O(@(LEXRT_""""_LEXO_""","_LEXM_")")) Q:+LEXM'>0  D
 . . N LEXE,LEXRT2 S LEXE=0,LEXRT2=LEXRT_""""_LEXO_""","_LEXM_","
 . . F  S LEXE=$O(@(LEXRT2_LEXE_")")) Q:+LEXE'>0  S LEXT=LEXT+1,LEXA=LEXA+1
 I $TR(LEXS,".","")?1N.N,$L(LEXS,".")'>2  I +LEXS=LEXS D
 . N LEXFC S LEXFC=$E(LEXS,1) S:$E(LEXS,1)?1N LEXO=LEXS-.000000001
 . S:$E(LEXS,1)="." LEXO=.000000001 S LEXIT=0
 . F  S LEXO=$O(@(LEXRT_+LEXO_")")) D  Q:LEXIT>0  Q:'$L(LEXO)
 . . S:LEXFC?1N&($E(LEXO,1)'?1N) LEXIT=1
 . . S:LEXFC?1P&($E(LEXO,1)'?1P) LEXIT=1 Q:LEXIT>0
 . . Q:'$L(LEXO)  Q:$E(LEXO,1,$L(LEXS))'=LEXS  N LEXM S LEXM=0
 . . F  S LEXM=$O(@(LEXRT_+LEXO_","_LEXM_")")) Q:+LEXM'>0  D
 . . . N LEXE,LEXRT2 S LEXE=0,LEXRT2=LEXRT_+LEXO_","_LEXM_","
 . . . F  S LEXE=$O(@(LEXRT2_LEXE_")")) Q:+LEXE'>0  S LEXT=LEXT+1,LEXN=LEXN+1
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
