LEX10CX2 ;ISL/KER - ICD-10 Cross-Over - Source (get) ;04/21/2014
 ;;2.0;LEXICON UTILITY;**80**;Sep 23, 1996;Build 1
 ;               
 ; Global Variables
 ;    ^TMP("LEXFND")      SACC 2.3.2.5.1
 ;    ^TMP("LEXHIT")      SACC 2.3.2.5.1
 ;    ^TMP("LEXSCH")      SACC 2.3.2.5.1
 ;               
 ; External References
 ;    ^DIC                ICR  10006
 ;    $$DT^XLFDT          ICR  10103
 ;    $$FMADD^XLFDT       ICR  10103
 ;               
 ; Local Variables NEWed or KILLed Elsewhere
 ;    None
 ;               
SRA(LEXSO,LEXSAB,LEXA) ; Source Array from Code/SAB
 ;
 ; Input
 ; 
 ;     LEXSO   Code
 ;     LEXSAB  Source Abbreviation file 757.01, field .01
 ;     LEXA    Local Array (passed by reference)
 ; 
 ; Output
 ; 
 ;     X       Three piece "^" delimited string
 ;               1  Pointer to Expression file
 ;               2  Expression
 ;               3  Code
 ;              
 ;     LEXA    Local Array (if passed by reference)
 ; 
 ;               LEXA(0)=Number of entries in array
 ;               LEXA(1)=Expression of selected Major Concept
 ;               LEXA(2)=Expression of synonym #1
 ;               LEXA(3)=Expression of synonym #2
 ;               LEXA(n)=Expression of synonym #n
 ;               LEXA("SEG",1)=Segment 1
 ;               LEXA("SEG",2)=Segment 2
 ;               LEXA("SEG",n)=Segment n
 ;               LEXA("SOURCE","EXP")=Expression
 ;               LEXA("SOURCE","EXI")=Expression (internal)
 ;               LEXA("SOURCE","SOE")=Code (external)
 ;               LEXA("SOURCE","SOI")=Code (internal)
 ;               LEXA("SOURCE","SAB")=Source Abbreviation
 ;               LEXA("SOURCE","SRC")=Source Nomenclature
 ;               LEXA("SOURCE","SRI")=Source (Internal)
 ;               LEXA("SOURCE","Y")=DIC lookup value for Y
 ;
 N LEXEIEN,LEXI,LEXMC,LEXNOM,LEXEXP,LEXPIEN,LEXSIEN,LEXSRC,LEXLA
 N LEXSRI,LEXSTA,LEXT,X,Y S (X,Y)=-1,LEXSO=$G(LEXSO)
 Q:'$D(^LEX(757.02,"CODE",(LEXSO_" "))) X
 S LEXSAB=$G(LEXSAB) Q:'$L(LEXSAB) X
 Q:'$D(^LEX(757.03,"ASAB",LEXSAB)) X
 S LEXSRI=$O(^LEX(757.03,"ASAB",LEXSAB,0))
 Q:+LEXSRI'>0!('$D(^LEX(757.03,+LEXSRI,0))) X
 S LEXNOM=$P($G(^LEX(757.03,+LEXSRI,0)),"^",2)
 Q:'$L(LEXNOM) X  S LEXSTA=$$STATCHK^LEXSRC2(LEXSO,,,LEXSAB)
 S LEXSIEN=$P(LEXSTA,"^",2) Q:+LEXSIEN'>0 X
 S LEXPIEN=+($P($G(^LEX(757.02,+LEXSIEN,0)),"^",1)) Q:+LEXPIEN'>0 X
 Q:'$D(^LEX(757.01,LEXPIEN,0)) X
 S LEXMC=+($G(^LEX(757.01,LEXPIEN,1))) Q:+LEXMC'>0 X
 S (LEXEXP,LEXA(1))=$G(^LEX(757.01,LEXPIEN,0)),LEXA(0)=1,LEXEIEN=0
 F  S LEXEIEN=$O(^LEX(757.01,"AMC",LEXMC,LEXEIEN)) Q:+LEXEIEN'>0  D
 . Q:LEXEIEN=LEXPIEN  N LEXT,LEXI
 . S LEXT=$G(^LEX(757.01,LEXEIEN,0)) Q:'$L(LEXT)
 . S LEXI=$O(LEXA(" "),-1)+1
 . S LEXA(LEXI)=LEXT,LEXA(0)=LEXI
 S LEXA("SOURCE","EXP")=LEXEXP
 S:+($G(LEXPIEN))>0 LEXA("SOURCE","EXI")=+($G(LEXPIEN))
 S LEXA("SOURCE","SOE")=LEXSO
 S:+($G(LEXSIEN))>0 LEXA("SOURCE","SOI")=+($G(LEXSIEN))
 S LEXA("SOURCE","SAB")=LEXSAB
 S LEXA("SOURCE","SRC")=LEXNOM
 S:+($G(LEXSRI))>0 LEXA("SOURCE","SRI")=+($G(LEXSRI))
 S (X,LEXA("SOURCE","Y"))=LEXPIEN_"^"_LEXEXP_"^"_LEXSO
 D SEG^LEX10CX5(,.LEXA)
 Q X
SRL(LEXSAB,LEXA) ; Source Array from Lookup
 ;
 ; Input
 ; 
 ;     LEXA   Local Array (passed by reference)
 ;     LEXS   Source Abbreviation file 757.01, field .01
 ; 
 ; Output     Same as $$SRA
 ; 
 N DIC,DO,LEXCDT,LEXEFF,LEXEX,LEXH,LEXI,LEXIEN,LEXILA,LEXLA
 N LEXNOM,LEXQUIET,LEXS,LEXSO,LEXSRI,LEXSTA,LEXTD,LEXTX,LEXVDT
 N X,Y K LEXA S LEXSAB=$G(LEXSAB) Q:$L(LEXSAB)'=3 -1
 S LEXSRI=$O(^LEX(757.03,"ASAB",LEXSAB,0))
 Q:+LEXSRI'>0!('$D(^LEX(757.03,+LEXSRI,0))) -1  S LEXTD=$$DT^XLFDT
 S LEXNOM=$P($G(^LEX(757.03,+LEXSRI,0)),"^",2)
 Q:'$L(LEXNOM) -1  S DIC("A")=" Enter "_LEXNOM_" code or text:  "
 S DIC("S")="I $$SO^LEXU(Y,"""_LEXSAB_""",+($G(LEXICCD)))"
 S LEXCDT=$$FMADD^XLFDT($$IMPDATE^LEXU("10D"),-3)
 S:"^ICD^ICP^DS3^DS4^"'[("^"_LEXSAB_"^") LEXCDT=LEXTD
 K ^TMP("LEXFND",$J),^TMP("LEXHIT",$J),^TMP("LEXSCH",$J)
 D CONFIG^LEXSET(LEXSAB,LEXSAB,LEXCDT)
 S ^TMP("LEXSCH",$J,"DIS",0)=LEXSAB
 S ^TMP("LEXSCH",$J,"FIL",0)=DIC("S")
 S DIC(0)="AEQMZ",DIC="^LEX(757.01," K X
 S LEXQUIET=1 D ^DIC Q:+Y'>0 -1 S X="" I +Y>0 D
 . N LEXILA,LEXIEN,LEXLA,LEXSO,LEXTX,LEXS,LEXIEN,LEXEX
 . N LEXH,LEXEX,LEXI,LEXSTA,LEXSIEN S LEXSO=$G(Y(1)),LEXIEN=+Y
 . S:'$L(LEXSO) LEXSO=$$SO^LEX10CX5(LEXIEN,LEXSAB,LEXCDT) Q:'$L(LEXSO)
 . S LEXSTA=$$STATCHK^LEXSRC2(LEXSO,$G(LEXCDT),,$G(LEXSAB))
 . S LEXSIEN=$P(LEXSTA,"^",2) Q:+LEXSIEN'>0
 . S LEXTX=$G(Y(0)) Q:'$L(LEXTX)  S LEXILA=$$LA^LEX10CX5(LEXSO,LEXSAB),LEXS=0
 . F  S LEXS=$O(^LEX(757.02,"CODE",(LEXSO_" "),LEXS)) Q:+LEXS'>0  D
 . . N LEXI Q:$P($G(^LEX(757.02,+LEXS,0)),"^",3)'=LEXSRI
 . . S LEXLA="",LEXH=0
 . . F  S LEXH=$O(^LEX(757.02,+LEXS,4,LEXH)) Q:+LEXH'>0  D
 . . . N LEXEFF,LEXSTA
 . . . S LEXEFF=$P($G(^LEX(757.02,+LEXS,4,+LEXH,0)),"^",1)
 . . . S LEXSTA=$P($G(^LEX(757.02,+LEXS,4,+LEXH,0)),"^",2)
 . . . S:LEXSTA>0 LEXLA=LEXEFF
 . . Q:LEXLA'?7N  Q:LEXILA'?7N  Q:LEXILA>LEXLA
 . . S LEXEX=+($P($G(^LEX(757.02,+LEXS,0)),"^",1))
 . . S LEXEX=$G(^LEX(757.01,+LEXEX,0)) Q:'$L(LEXEX)
 . . Q:$D(LEXA("B",LEXEX))  S LEXI=$O(LEXA(" "),-1)+1
 . . S LEXA(LEXI)=LEXEX,LEXA("B",LEXEX)="",LEXA(0)=LEXI
 . K LEXA("B")
 . I +($G(LEXA(0)))>0,+($G(Y))>0,$L($P($G(Y),"^",2)) D
 . . N LEXPIEN
 . . S LEXPIEN=+($G(^LEX(757.02,+($G(LEXSIEN)),0)))
 . . S LEXA("SOURCE","SOE")=LEXSO
 . . S:+($G(LEXSIEN))>0 LEXA("SOURCE","SOI")=+($G(LEXSIEN))
 . . S LEXA("SOURCE","Y")=$G(Y)
 . . S LEXA("SOURCE","EXP")=LEXTX
 . . S:+($G(LEXPIEN))>0 LEXA("SOURCE","EXI")=+($G(LEXPIEN))
 . . S:$L($G(LEXSAB))=3 LEXA("SOURCE","SAB")=$G(LEXSAB)
 . . S:$L($G(LEXNOM)) LEXA("SOURCE","SRC")=$G(LEXNOM)
 . . S:+($G(LEXSRI))>0 LEXA("SOURCE","SRI")=+($G(LEXSRI))
 . . S X=Y_"^"_LEXSO
 K ^TMP("LEXFND",$J),^TMP("LEXHIT",$J),^TMP("LEXSCH",$J)
 K LEXVDT
 Q X
