LEXASC ;ISL/KER - Look-up by Shortcuts ;05/23/2017
 ;;2.0;LEXICON UTILITY;**25,80,103**;Sep 23, 1996;Build 2
 ;               
 ; Global Variables
 ;    ^LEX(757            SACC 1.3
 ;    ^LEX(757.01         SACC 1.3
 ;    ^LEX(757.21         SACC 1.3
 ;    ^LEX(757.4          SACC 1.3
 ;    ^LEX(757.41         SACC 1.3
 ;    ^LEXT(757.2         SACC 1.3
 ;    ^TMP("LEXFND")      SACC 2.3.2.5.1
 ;    ^TMP("LEXHIT")      SACC 2.3.2.5.1
 ;    ^TMP("LEXSCH")      SACC 2.3.2.5.1
 ;               
 ; External References
 ;    None
 ;               
 ; Local Variables NEWed or KILLed Elsewhere
 ;     LEXAFMT            Output Format
 ;     LEXFIL             Filter
 ;     LEXSHOW            Display string (SABs)
 ;               
EN(LEXSCH,LEXC,LEXVDT) ; Check Shortcuts file 757.4 for LEXSCH
 ;     LEXSCH             User input string to search for
 ;     LEXVDT             Versioning Date
 ;     LEXC               Pointer to Shortcut file 757.41
 ;
 ; Disabled LEX*2.0*103
 Q 0
 ;
 S LEXC=+($G(LEXC)) Q:'$L(LEXSCH)!(LEXC=0) 0  Q:'$D(^LEX(757.41,LEXC)) 0  Q:$L(LEXSCH)<2!($L(LEXSCH)>63) 0
 Q:'$D(^LEX(757.4,"ARA",LEXSCH,LEXC)) 0  D VDT^LEXU N LEXS,LEXSOA S LEXS=0
 I $D(^TMP("LEXSCH",$J,"FMT",0)) S:'$D(LEXAFMT)!($G(LEXAFMT)'?1N) LEXAFMT=$G(^TMP("LEXSCH",$J,"FMT",0))
 F  S LEXS=$O(^LEX(757.4,"ARA",LEXSCH,LEXC,LEXS)) Q:+LEXS=0  D
 . N LEXE,LEXDES,LEXDSP,LEXLKT,LEXFILR S LEXLKT="ASC" S LEXE=+($G(^LEX(757.4,LEXS,0))) Q:LEXE'>0
 . S LEXFILR=$$EN^LEXAFIL($G(LEXFIL),LEXE) Q:LEXFILR=0
 . Q:'$D(LEXIGN)&(+($P($G(^LEX(757.01,LEXE,1)),"^",5))=1)  Q:+($$SUB(LEXE))=0  S LEXDES=$$DES(LEXE)
 . S LEXDSP="",LEXSHOW=$G(^TMP("LEXSCH",$J,"DIS",0)) S:$L($G(LEXSHOW)) LEXDSP=$$DSP(LEXE,$G(LEXSHOW),$G(LEXVDT))
 . D ADDL^LEXAL(LEXE,LEXDES,LEXDSP)
 D:$D(^TMP("LEXFND",$J)) BEG^LEXAL I '$D(^TMP("LEXFND",$J)) D
 . K LEX,^TMP("LEXFND",$J),^TMP("LEXHIT",$J) S LEX=0
 . S:+($G(^TMP("LEXSCH",$J,"UNR",0)))>0&($L($G(^TMP("LEXSCH",$J,"NAR",0)))) LEX("NAR")=$G(^TMP("LEXSCH",$J,"NAR",0))
 Q:$D(^TMP("LEXHIT",$J)) 1
 Q 0
 ; 
 ; Miscellaneous
DES(LEXX) ;   Get description flag
 N LEXDES,LEXE,LEXM S LEXDES="",LEXE=+LEXX
 S LEXM=$P($G(^LEX(757.01,+($G(LEXX)),1)),"^",1)
 S LEXM=+($G(^LEX(757,+($G(LEXM)),0)))
 S:$D(^LEX(757.01,LEXM,3)) LEXDES="*"
 S LEXX=$G(LEXDES) Q LEXX
TERM(LEXX) ;   Get expression
 Q $G(^LEX(757.01,LEXX,0))
DSP(X,Y,LEXVDT) ;   Return displayable text
 I +($G(LEXAFMT))'>0 S X=$$SO^LEXASO($G(X),$G(Y),1,$G(LEXVDT)) Q X
 I +($G(LEXAFMT))>0  S X=$$SOA^LEXASO($G(X),$G(Y),1,$G(LEXVDT),.LEXSOA) Q X
 Q ""
SUB(LEXX) ;   Subset
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
CLR ;   Clear
 N LEXIGN
 Q
