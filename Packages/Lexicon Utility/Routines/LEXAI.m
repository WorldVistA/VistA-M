LEXAI ;ISL/KER - Look-up by IEN ;05/23/2017
 ;;2.0;LEXICON UTILITY;**103**;Sep 23, 1996;Build 2
 ;               
 ; Global Variables
 ;    ^LEX(757.01         SACC 1.3
 ;    ^TMP("LEXFND",$J)   SACC 2.3.2.5.1
 ;    ^TMP("LEXHIT",$J)   SACC 2.3.2.5.1
 ;    ^TMP("LEXSCH",$J)   SACC 2.3.2.5.1
 ;               
 ; External References
 ;    None
 ;               
 ; Local Variables NEWed or KILLed Elsewhere
 ;     LEX                Output Array
 ;     LEXAFMT            Output Format
 ;               
EN(LEXNAR,LEXVDT) ; Look-up by IEN
 S LEXNAR=$G(LEXNAR),LEXVDT=$G(LEXVDT) Q:$E(LEXNAR)'="`" 0  S LEXNAR=$E(LEXNAR,2,$L(LEXNAR)) Q:LEXNAR'?1N.N 0
 Q:'$D(^LEX(757.01,+LEXNAR,0)) 0  D VDT^LEXU N LEXE,LEXUN,LEXM,LEXL,LEXSOA,LEXLL
 S:$G(^TMP("LEXSCH",$J,"LEN",0))>0 LEXLL=$G(^TMP("LEXSCH",$J,"LEN",0)) S:$G(LEXLL)'>0 LEXLL=5
 I $D(^TMP("LEXSCH",$J,"FMT",0)) S:'$D(LEXAFMT)!($G(LEXAFMT)'?1N) LEXAFMT=$G(^TMP("LEXSCH",$J,"FMT",0))
 S LEXE=LEXNAR,LEXUN=+$G(^TMP("LEXSCH",$J,"UNR",0)) I +($G(LEXAFMT))'>0 D 
 . D ADDL^LEXAL(LEXE,$$DES^LEXASC(LEXE),$$SO^LEXASO(LEXE,$G(^TMP("LEXSCH",$J,"DIS",0)),1,$G(LEXVDT)))
 I +($G(LEXAFMT))>0 D
 . N LEXD,LEXT,LEXS S LEXSOA="" S LEXS=$$SOA^LEXASO(LEXE,$G(^TMP("LEXSCH",$J,"DIS",0)),1,$G(LEXVDT),.LEXSOA)
 . D ADDL^LEXAL(LEXE,$$DES^LEXASC(LEXE),"")
 I $D(^TMP("LEXFND",$J)) D BEG^LEXAL
 I $L($G(^TMP("LEXSCH",$J,"NAR",0))) S LEX("NAR")=$G(^TMP("LEXSCH",$J,"NAR",0))
 I $L($G(^LEX(757.01,+$G(LEXE),0))) S LEX("NAR")=$G(^LEX(757.01,+$G(LEXE),0))
 S:$L($G(LEX("NAR"))) ^TMP("LEXSCH",$J,"NAR",0)=$G(LEX("NAR"))
 S LEXM=$O(LEX("LIST"," "),-1),LEXL=$O(LEX("LIST",0))
 S:LEXM>0 LEX=LEXM,LEX("MAT")=(LEXM_" match"_$S(LEXM'>1:" ",1:"es ")_"found"),^TMP("LEXSCH",$J,"NUM",0)=LEXM
 S:LEXM>0&(LEXL>0) LEX("MAX")=LEXM,LEX("MIN")=LEXL,LEX("LIST",0)=(LEXM_"^"_LEXL)
 Q:$D(^TMP("LEXHIT",$J)) 1
 Q 0
