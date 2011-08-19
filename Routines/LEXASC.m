LEXASC ; ISL/KER Look-up by Shortcuts ; 05/14/2003
 ;;2.0;LEXICON UTILITY;**25**;Sep 23, 1996
 ;
 ; ^TMP("LEXFND",$J)  Entries found
 ; ^TMP("LEXHIT",$J)  Entries returned
 ;
 ; LEXSCH   User input string to search for
 ; LEXVDT   Date is used to screen out inactive codes
 ;
 ; LEXC     Pointer to Shortcut Context  in file 757.41
 ; LEXS     Pointer to Shortcut in file 757.4
 ; LEXE     Pointer to expression in 757.01
 ; LEXM     Pointer to Major Concept in 757.01
 ;
 ; LEXDSP   Source Display string
 ; LEXDES   Flag - has (*) or doesn't have () a description
 ; LEXSHOW  Display string from Application/User defaults
 ; LEXX     Returned variable from functions
 ;
EN(LEXSCH,LEXC,LEXVDT) ; Check Shortcuts file 757.4 for LEXSCH
 S LEXC=+($G(LEXC))
 Q:'$L(LEXSCH)!(LEXC=0) 0
 Q:'$D(^LEX(757.41,LEXC)) 0
 Q:$L(LEXSCH)<2!($L(LEXSCH)>63) 0
 Q:'$D(^LEX(757.4,"ARA",LEXSCH,LEXC)) 0
 N LEXS S LEXS=0
 F  S LEXS=$O(^LEX(757.4,"ARA",LEXSCH,LEXC,LEXS)) Q:+LEXS=0  D
 . N LEXE,LEXDES,LEXDSP
 . S LEXE=+($G(^LEX(757.4,LEXS,0))) Q:LEXE'>0
 . ; Filter
 . S LEXFILR=$$EN^LEXAFIL($G(LEXFIL),LEXE) Q:LEXFILR=0
 . ; Deactivated Term
 . Q:+($P($G(^LEX(757.01,LEXE,1)),"^",5))=1
 . Q:+($$SUB(LEXE))=0
 . S LEXDES=$$DES(LEXE)
 . S LEXDSP="",LEXSHOW=$G(^TMP("LEXSCH",$J,"DIS",0)) S:$L($G(LEXSHOW)) LEXDSP=$$DSP(LEXE,$G(LEXSHOW),$G(LEXVDT))
 . D ADDL^LEXAL(LEXE,LEXDES,LEXDSP)
 I $D(^TMP("LEXFND",$J)) D BEG^LEXAL
 I '$D(^TMP("LEXFND",$J)) D
 . K LEX,^TMP("LEXFND",$J),^TMP("LEXHIT",$J) S LEX=0
 . S:+($G(^TMP("LEXSCH",$J,"UNR",0)))>0&($L($G(^TMP("LEXSCH",$J,"NAR",0)))) LEX("NAR")=$G(^TMP("LEXSCH",$J,"NAR",0))
 Q:$D(^TMP("LEXHIT",$J)) 1
 Q 0
DES(LEXX) ; Get description flag
 N LEXDES,LEXE,LEXM S LEXDES="",LEXE=+LEXX
 S LEXM=$P($G(^LEX(757.01,+($G(LEXX)),1)),"^",1)
 S LEXM=+($G(^LEX(757,+($G(LEXM)),0)))
 S:$D(^LEX(757.01,LEXM,3)) LEXDES="*"
 S LEXX=$G(LEXDES) Q LEXX
TERM(LEXX) ; Get expression
 Q $G(^LEX(757.01,LEXX,0))
DSP(LEXX,LEXDSP,LEXVDT) ; Return displayable text
 S LEXX=$$SO^LEXASO(LEXX,LEXDSP,1,$G(LEXVDT)) Q LEXX
SUB(LEXX) ;
 Q:$G(^TMP("LEXSCH",$J,"GBL",0))'="^LEX(757.21," 1
 Q:'$L($G(^TMP("LEXSCH",$J,"IDX",0))) 1
 N LEXIDX,LEXSS,LEXSN S LEXIDX=$G(^TMP("LEXSCH",$J,"IDX",0))
 S LEXSS=$E(LEXIDX,2,$L(LEXIDX))
 S LEXSN=$O(^LEXT(757.2,"AA",LEXSS,0))
 Q:+($G(LEXSN))=0 1
 N LEXOK,LEXR S (LEXR,LEXOK)=0
 F  S LEXR=$O(^LEX(757.21,"B",LEXX,LEXR)) Q:+LEXR=0  D
 . I $P($G(^LEX(757.21,LEXR,0)),"^",2)=LEXSN S LEXOK=1
 S LEXX=LEXOK Q LEXX
