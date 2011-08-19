LEXAB ; ISL/KER Look-up Exact Match "B" index ; 05/14/2003
 ;;2.0;LEXICON UTILITY;**25**;Sep 23, 1996
 ;
 ; External References
 ;   DBIA 10104  $$UP^XLFSTR
 ;                   
 ; Exact match  S X=$$EN^LEXAB("LEXSCH",LEXVDT)
 ;                   
 ;   INPUT
 ;     LEXSCH  User input string to search for
 ;     LEXVDT  Date used to screen out inactive codes
 ;                   
 ;   Notes:
 ;                   
 ;     1.  If an exact match is found, it is placed at
 ;         the top of the selection list at 
 ;         ^TMP("LEXFND",$J)
 ;                   
 ;     2.  Returns
 ;                   
 ;         0 - Exact match not found
 ;         1 - Exact match found
 ;                   
EN(LEXSCH,LEXVDT) ; Check "B" index for exact match
 Q:'$L(LEXSCH) 0
 N LEXLKGL,LEXEM,LEXEMC S LEXLKGL=$G(^TMP("LEXSCH",$J,"GBL",0)),LEXEMC=0
 Q:$G(LEXLKGL)'["757.01" 0
 N LEXSHOW S LEXSHOW=$G(^TMP("LEXSCH",$J,"DIS",0))
 N LEXO,LEXE,LEXOK,LEXDES,LEXDSP
 S (LEXE,LEXOK)=0,LEXO=$$SCH(LEXSCH)
 F  S LEXO=$O(^LEX(757.01,"B",LEXO)) Q:LEXO=""!(LEXSCH'[LEXO)  D
 . S (LEXE,LEXOK)=0
 . F  S LEXE=$O(^LEX(757.01,"B",LEXO,LEXE)) Q:+LEXE=0  D
 . . Q:+($P($G(^LEX(757.01,LEXE,1)),"^",5))=1
 . . I $$UP^XLFSTR(LEXSCH)=$$UP^XLFSTR($G(^LEX(757.01,LEXE,0))) D
 . . . S LEXEMC=+($G(LEXEMC)),LEXEMC=LEXEMC+1,LEXEM=LEXE
 S:+($G(LEXEMC))=1 LEXOK=$G(LEXEM) S:+($G(LEXEMC))'=1 LEXOK=0
 ; Exact Match Found
 I +LEXOK>0 D
 . S LEXE=LEXOK
 . ; Filter
 . S LEXFILR=$$EN^LEXAFIL($G(LEXFIL),LEXE) Q:LEXFILR=0
 . ; Deactivated
 . Q:+($P($G(^LEX(757.01,LEXE,1)),"^",5))=1
 . S LEXDES=$$DES(LEXE)
 . S LEXDSP="" S:$L($G(LEXSHOW)) LEXDSP=$$DSP(LEXE,$G(LEXSHOW),$G(LEXVDT))
 . D ADDE^LEXAL(LEXE,LEXDES,LEXDSP)
 . S ^TMP("LEXSCH",$J,"EXM",0)=LEXE
 . S ^TMP("LEXSCH",$J,"EXM",1)=$G(^LEX(757.01,+LEXE,0))
 . I '$D(^LEX(757,"B",LEXE)) D
 . . N LEXME,LEXM S LEXM=+($G(^LEX(757.01,LEXE,1))) Q:LEXM=0
 . . S LEXME=+($G(^LEX(757,LEXM,0))) Q:LEXM=0  Q:LEXE=LEXME
 . . I +($G(^LEX(757.01,LEXME,1)))=LEXM D
 . . . S LEXDES=$$DES(LEXME),LEXDSP="" S:$L($G(LEXSHOW)) LEXDSP=$$DSP(LEXE,$G(LEXSHOW),$G(LEXVDT))
 . . . D ADDEM^LEXAL(LEXME,LEXDES,LEXDSP)
 . . . S ^TMP("LEXSCH",$J,"EXC",0)=LEXME
 . . . S ^TMP("LEXSCH",$J,"EXC",1)=$G(^LEX(757.01,+LEXME,0))
 Q:$D(^TMP("LEXFND",$J)) 1
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
 N LEXMCE S LEXMCE=+($G(^LEX(757,+($G(^LEX(757.01,LEXX,1))),0)))
 I +LEXMCE>0,$D(^LEX(757.01,+LEXMCE,0)) S LEXX=$$SO^LEXASO(+LEXMCE,LEXDSP,1,$G(LEXVDT)) Q LEXX
 S LEXX=$$SO^LEXASO(LEXX,LEXDSP,1,$G(LEXVDT)) Q LEXX
SCH(LEXX) ; Search for LEXX a $Orderable variable
 S LEXX=$$UP^XLFSTR($E(LEXX,1,63))
 S LEXX=$E(LEXX,1,($L(LEXX)-1))_$C($A($E(LEXX,$L(LEXX)))-1)_"~" Q LEXX
