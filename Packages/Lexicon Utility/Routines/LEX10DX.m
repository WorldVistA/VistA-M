LEX10DX ;ISL/KER - ICD-9 Diagnosis ;04/21/2014
 ;;2.0;LEXICON UTILITY;**80**;Sep 23, 1996;Build 1
 ;               
 ; Global Variables
 ;    ^TMP("LEXDX"        SACC 2.3.2.5.1
 ;    ^TMP("LEXFND"       SACC 2.3.2.5.1
 ;    ^TMP("LEXHIT"       SACC 2.3.2.5.1
 ;    ^TMP("LEXSCH"       SACC 2.3.2.5.1
 ;               
 ; External References
 ;    ^DIM                ICR  10016
 ;    $$ICDDATA^ICDXCODE  ICR   5699
 ;    $$DT^XLFDT          ICR  10103
 ;               
 Q
I9T(X,LEXA,LEXD,LEXL,LEXF) ; ICD-9 DX Text Lookup (Pruned)
 ;
 ; Input
 ;   X       Diagnostic Text      Required
 ;  .LEXA    Local Array (by Ref) Required
 ;   LEXD    Date (FM Format)     Optional (Default TODAY)
 ;   LEXL    Maximum to Return    Optional (Default = 30)
 ;   LEXF    Filter               Optional (Default ICD)
 ;  
 ; Output
 ; 
 ;   LEXA(0)=# ^ PI  No to exceed 30
 ;   LEXA(#)=<code ien>_"^"_<code>_"^"_<activation date>
 ;   LEXA(#,0)=<expression ien>_"^"_<expression>
 ; 
 ;   Note:  Second piece of LEXA(0) is the pruning 
 ;          indicator and set to "1" if pruning
 ;          occurred
 ;          
 ; See DX^LEX10DP for DX Code Lookup (Pruned)
 ; 
 K ^TMP("LEXSCH",$J),^TMP("LEXFND",$J),^TMP("LEXHIT",$J)
 N DIC,LEXFIL,LEXLEN,LEXLI,LEXCDT,LEXVDT,LEXX,LEXPR,LEX
 S LEXX=$G(X) Q:'$L(LEXX)  S LEXCDT=$G(LEXD),LEXFIL=$G(LEXF)
 S:LEXCDT'?7N LEXCDT=$G(DT) S:LEXCDT'?7N LEXCDT=$$DT^XLFDT
 S LEXLEN=$G(LEXL) S:+LEXLEN'>0 LEXLEN=30 S LEXPR=0
 S:'$L(LEXFIL) LEXFIL="I $$SO^LEXU(Y,""ICD"",+($G(LEXCDT)))"
 S DIC("S")=LEXFIL D CONFIG^LEXSET("ICD","ICD",LEXCDT)
 S (DIC("S"),^TMP("LEXSCH",$J,"FIL",0))=LEXFIL
 S ^TMP("LEXSCH",$J,"FIL",1)="Diagnosis"
 S ^TMP("LEXSCH",$J,"DIS",0)="ICD/10D/DS4/SCC/NAN/SCT"
 S ^TMP("LEXSCH",$J,"DIS",1)="Diagnosis"
 K LEX D LOOK^LEXA(LEXX,"ICD",+LEXLEN,"ICD",LEXCDT)
 S:+($G(LEX("LIST",0)))=LEXLEN&($O(^TMP("LEXFND",$J,0),-1)<0) LEXPR=1
 K ^TMP("LEXSCH",$J),^TMP("LEXFND",$J),^TMP("LEXHIT",$J)
 S LEXLI=0 F  S LEXLI=$O(LEX("LIST",LEXLI)) Q:+LEXLI'>0  D
 . N LEXAI,LEXCODE,LEXEFF,LEXEIEN,LEXEXP,LEXND,LEXSI,LEXSIEN,LEXSRC
 . S LEXEIEN=+($G(LEX("LIST",LEXLI)))
 . Q:LEXEIEN'>0
 . S LEXEXP=$G(^LEX(757.01,+LEXEIEN,0))
 . S LEXSI=0,(LEXSIEN,LEXCODE,LEXEFF)=""
 . F  S LEXSI=$O(^LEX(757.02,"B",LEXEIEN,LEXSI)) Q:+LEXSI'>0  D
 . . N LEXD,LEXH,LEXND,LEXS Q:+($G(LEXSIEN))>0  S LEXND=$G(^LEX(757.02,LEXSI,0))
 . . Q:$P(LEXND,"^",3)'=1  S LEXD=$O(^LEX(757.02,LEXSI,4,"B",(LEXCDT+.001)),-1)
 . . Q:LEXD'?7N  S LEXH=$O(^LEX(757.02,LEXSI,4,"B",LEXD," "),-1) Q:LEXH'?1N.N
 . . S LEXS=$P($G(^LEX(757.02,LEXSI,4,LEXH,0)),"^",2)
 . . S:LEXS>0 LEXSIEN=LEXSI,LEXEFF=LEXD,LEXCODE=$P(LEXND,"^",2)
 . I +LEXSIEN'>0,LEXEIEN>0 D
 . . N LEXMC,LEXSI,LEXSA S LEXMC=$P($G(^LEX(757.01,+LEXEIEN,1)),"^",1) Q:+LEXMC'>0
 . . S LEXSI=0 F  S LEXSI=$O(^LEX(757.02,"AMC",LEXMC,LEXSI)) Q:+LEXSI'>0  D
 . . . N LEXND,LEXH,LEXS,LEXC S LEXND=$G(^LEX(757.02,+LEXSI,0)) Q:$P(LEXND,"^",3)>2
 . . . S LEXH=$O(^LEX(757.02,LEXSI,4,"B",(+($G(LEXCDT))+.001)),-1)
 . . . S LEXH=$O(^LEX(757.02,LEXSI,4,"B",+LEXH," "),-1)
 . . . S LEXH=$G(^LEX(757.02,LEXSI,4,+LEXH,0)) Q:$P(LEXH,"^",2)'>0
 . . . Q:$P(LEXND,"^",5)'>0  S LEXC=$O(LEXSA(" "),-1)+1
 . . . S LEXSA(LEXC)=(LEXSI_"^"_$P(LEXH,"^",1)),LEXSA(0)=LEXC
 . . I LEXSA(0)=1,+($G(LEXSA(1)))>0,$O(LEXSA(1))'>0 D
 . . . N LEXSI,LEXEI,LEXEF S LEXSI=+($G(LEXSA(1))),LEXEF=$P($G(LEXSA(1)),"^",2)
 . . . S LEXEI=+($G(^LEX(757.02,+LEXSI,0))) Q:+LEXEI'>0  Q:LEXEF'?7N
 . . . S LEXSIEN=LEXSI,LEXEIEN=LEXEI,LEXEFF=LEXEF
 . Q:+LEXSIEN'>0  Q:LEXEFF'?7N  Q:+LEXEIEN'>0
 . S LEXND=$G(^LEX(757.02,LEXSIEN,0)) Q:+LEXEIEN'=+LEXND
 . S LEXEXP=$G(^LEX(757.01,+LEXEIEN,0)) Q:'$L(LEXEXP)
 . Q:$P($G(^LEX(757.01,+LEXEIEN,1)),"^",5)>0
 . S LEXSRC=$P(LEXND,"^",3) Q:LEXSRC'=1  S LEXCODE=$P(LEXND,"^",2)
 . Q:'$L(LEXCODE)  S LEXAI=$O(LEXA(" "),-1)+1
 . S LEXA(LEXAI)=LEXSIEN_"^"_LEXCODE_"^"_LEXEFF
 . S LEXA(LEXAI,0)=LEXEIEN_"^"_LEXEXP
 . S LEXA(0)=$O(LEXA(" "),-1)
 S:+($G(LEXA(0)))'>0 LEXA(0)=-1 Q:+($G(LEXA(0)))'>0
 K LEX S:LEXPR>0&(+($G(LEXA(0)))>0) $P(LEXA(0),"^",2)=LEXPR
 Q
 ;
NEXT(LEXC,LEXA,LEXD) ; Next Character
 ;
 ; Input
 ; 
 ;   LEXC    Partial Dx Code      Required
 ;  .LEXA    Local Array (by Ref) Required
 ;   LEXD    Date (FM Format)     Optional (Default TODAY)
 ;  
 ; Output
 ; 
 ;   LEXA(<input>,0)= # of characters
 ;   LEXA(<input>,<character>)=""
 ; 
 N LEX1,LEX2,LEXCDT,LEXCHK,LEXCHR,LEXCT,LEXE,LEXLEN,LEXID,LEXNC,LEXNN
 N LEXOR,LEXPRE,LEXS,LEXSO S LEXC=$$TM(LEXC)
 S:$L(LEXC)=3&(LEXC'[".") LEXC=LEXC_"." S (LEXID,LEXSO)=LEXC
 S LEXCDT=$G(LEXD) S:LEXCDT'?7N LEXCDT=$$DT^XLFDT S LEXLEN=$L(LEXC)
 Q:LEXLEN>6 "-1^Max length reached, no next character available"
 I LEXLEN>1 D
 . S LEXOR=$E(LEXSO,1,($L(LEXSO)-1))_$C($A($E(LEXSO,$L(LEXSO)))-1)_"~"
 S:LEXLEN=1 LEXOR=$C($A(LEXSO)-1)_"~" S:LEXLEN'>0 LEXOR="/~"
 S LEXCHK=0 S:LEXLEN'>0 LEXCHK=1 S:LEXLEN>0&(LEXLEN<3) LEXCHK=LEXLEN+1
 S:LEXLEN=3 LEXCHK=LEXLEN+2 S:LEXLEN>3 LEXCHK=LEXLEN+1
 Q:+LEXCHK'>0 "-1^Character position not specified"
 S:LEXLEN=0 LEXID="<null>" S:'$L(LEXID) LEXID="<unknown>"
 S LEXNN="^LEX(757.02,""ADX"","""_LEXOR_" "")"
 S LEXNC="^LEX(757.02,""ADX"","""_LEXSO,LEXCT=0
 F  S LEXNN=$Q(@LEXNN) Q:'$L(LEXNN)!(LEXNN'[LEXNC)  D
 . N LEXC,LEXD,LEXE,LEXS,LEX1,LEX2
 . S LEXC=$P(LEXNN,",",3),LEXC=$TR(LEXC,"""",""),LEXC=$$TM(LEXC)
 . S LEXD=+($P(LEXNN,",",4)) Q:LEXD'?7N  Q:(LEXCDT+.001)'>LEXD
 . I $E(LEXC,1,$L(LEXSO))=LEXSO,$L(LEXC)'<LEXCHK D  Q
 . . N LEXCHR S LEXCHR=$E(LEXC,LEXCHK) Q:'$L(LEXCHR)
 . . I '$D(LEXA(LEXID,LEXCHR)) D
 . . . S LEXA(LEXID,LEXCHR)="",LEXCT=LEXCT+1
 . . S LEXOR=$E(LEXC,1,LEXCHK)_"~"
 . . S LEXNN="^LEX(757.02,""ADX"","""_LEXOR_" "")"
 S:+($G(LEXCT))>0 LEXA(LEXID)=+($G(LEXCT))
 Q +($G(LEXCT))
 ;
 ; Miscellaneous
TM(X,Y) ;   Trim Character Y - Default " "
 S X=$G(X) Q:X="" X  S Y=$G(Y) S:'$L(Y) Y=" "
 F  Q:$E(X,1)'=Y  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=Y  S X=$E(X,1,($L(X)-1))
 Q X
