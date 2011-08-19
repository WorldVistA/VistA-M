LEXQID4 ;ISL/KER - Query - ICD Diagnosis - Save ;10/30/2008
 ;;2.0;LEXICON UTILITY;**62**;Sep 23, 1996;Build 16
 ;               
 ; Global Variables
 ;    ^ICD9(              ICR   4485
 ;    ^TMP("LEXQID")      SACC 2.3.2.5.1
 ;    ^TMP("LEXQIDO")     SACC 2.3.2.5.1
 ;               
 ; External References
 ;    $$UP^XLFSTR         ICR  10104
 ;               
 ; Local Variables NEWed or KILLed Elsewhere
 ;     LEXIEN             CPT Internal Entry Number
 ;     LEXLEN             Offset Length
 ;     LEXGET             Array of Non-Versioned Data
 ;     LEXST              CPT Status and Effective Dates
 ;     LEXSD              Versioned Short Description
 ;     LEXLD              Versioned Long Description
 ;     LEXLX              Versioned Lexicon Term
 ;     LEXWN              Warning
 ;     LEXCC              Code CC Status
 ;     LEXMC              Major Diagnostic Category
 ;     LEXELDT            External Last Date
 ;              
EN ; Main Entry Point
 K ^TMP("LEXQIDO",$J) Q:'$L($G(LEXELDT))  I +($G(LEXST))<0 D FUT D:$D(^TMP("LEXQIDO",$J)) DSP^LEXQO("LEXQIDO") Q
 D FUL D:$D(^TMP("LEXQIDO",$J)) DSP^LEXQO("LEXQIDO")
 Q
FUT ; Future Activation
 N LEX1,LEX2,LEX3,LEXEFF,LEXI,LEXL,LEXNAM,LEXSO,LEXSTA S LEXI=+($G(LEXIEN)) Q:+LEXI'>0  Q:'$D(^ICD9(+LEXI,0))  S LEXL=+($G(LEXLEN)) Q:+LEXL'>0
 S:LEXL>62 LEXL=62 S LEXSO=$G(LEXGET(80,(+LEXI_","),.01,"E")) Q:'$L(LEXSO)  S LEXNAM=$G(LEXGET(80,(+LEXI_","),"B")) Q:'$L(LEXNAM)
 S LEXSTA=$G(LEXST),LEXEFF=$P(LEXSTA,"^",5),LEXSTA=$P(LEXSTA,"^",4) Q:'$L(LEXSTA)  Q:'$L(LEXEFF)  S (LEX1,LEX2,LEX3)=""
 D BOD(LEXELDT),COD(LEXSO,LEXNAM,+($G(LEXL))),STA(.LEXST,+($G(LEXL)))
 Q
BOD(X) ;   Based on Date
 N LEXBOD S LEXBOD=$G(X),X="Display based on date:  "_LEXBOD D BL,TL(X)
 Q
COD(X,Y,LEXLEN) ;   Code Line
 N LEXC,LEXN,LEXT S LEXC=$G(X),LEXN=$G(Y),LEXT="Code:  "_LEXC,LEXT=LEXT_$J(" ",((79-+($G(LEXLEN)))-$L(LEXT)))_LEXN D BL,TL(LEXT)
 Q
STA(X,LEXLEN) ;   Status Line
 N LEX,LEXC,LEXX,LEXE,LEXI,LEXN,LEXS,LEXT,LEXW,LEXEFF,LEXSTA
 S LEXX=$G(X),LEXSTA=$P(LEXX,"^",4),LEXEFF=$P(LEXX,"^",5),LEXEFF=$TR(LEXEFF,"()",""),LEXW=$P(LEXX,"^",6)
 S LEXT="  Status:  ",LEXT=LEXT_$J(" ",((79-+($G(LEXLEN)))-$L(LEXT)))_LEXSTA
 S LEXT=LEXT_$J(" ",(35-$L(LEXT)))_"Effective:  "_$$UP^XLFSTR($E(LEXEFF,1))_$E(LEXEFF,2,$L(LEXEFF)) D BL,TL(LEXT)
 I $L(LEXW) D
 . N LEX,LEXT,LEXC,LEXI,LEXN S LEX(1)=LEXW D PR^LEXQM(.LEX,(LEXLEN-7)) Q:+($O(LEX(" "),-1))'>0
 . S LEXT=$J(" ",((79-+($G(LEXLEN)))))
 . S (LEXC,LEXI)=0 F  S LEXI=$O(LEX(LEXI)) Q:+LEXI'>0  D
 . . N LEXN S LEXN=$$TM^LEXQM($G(LEX(LEXI))) S:$L(LEXN) LEXC=LEXC+1 D:LEXC=1 BL D TL((LEXT_LEXN))
 Q
FUL ; Full Display
 N LEXFUL,LEX,LEXL S LEXL=+($G(LEXLEN)) S:LEXL>62 LEXL=62
 S LEXFUL=""  D FUT
 D LIM(+($G(LEXIEN)),+($G(LEXL))),SD(.LEXSD,+($G(LEXL))),LD(.LEXLD,+($G(LEXL))),LX(.LEXLX,+($G(LEXL))),WN(.LEXWN,+($G(LEXL)))
 D:$L($G(LEXCC(1)))!($L($G(LEXMC(1)))) BL D CC(.LEXCC,+($G(LEXL))),MC(.LEXMC,+($G(LEXL))),DRG(+($G(LEXL)))
 D NOT(+($G(LEXL))),REQ(+($G(LEXL))),NCC(+($G(LEXL)))
 Q
LIM(X,LEXLEN) ;   Limitations - Age Low, Age High and Sex
 N LEXC,LEXI,LEXH,LEXL,LEXS,LEXT,LEXU,LEXP S LEXC=0,LEXI=+($G(X)),LEXL=$G(LEXGET(80,(+LEXI_","),14,"E")) S:'$L(LEXL) LEXL="N/A"
 S LEXH=$G(LEXGET(80,(+LEXI_","),15,"E")) S:'$L(LEXH) LEXH="N/A" S LEXS=$G(LEXGET(80,(+LEXI_","),9.5,"E")) S:'$L(LEXS) LEXS="N/A"
 I (LEXH_LEXL_LEXS)'="N/AN/AN/A" D
 . S LEXT="  Limitations: ",LEXT=LEXT_$J(" ",((79-+($G(LEXLEN)))-$L(LEXT)))_"Age Low:  "_LEXL
 . S LEXT=LEXT_$J(" ",(35-$L(LEXT)))_"Age High:  "_LEXH,LEXT=LEXT_$J(" ",(56-$L(LEXT)))_"Sex:  "_LEXS D BL,TL(LEXT) S LEXC=1
 S LEXU=$G(LEXGET(80,(+LEXI_","),101,"E")),LEXP=$G(LEXGET(80,(+LEXI_","),101,"I"))
 I LEXU="YES",+LEXP>0 D
 . S LEXT="  Limitations: " S:(LEXH_LEXL_LEXS)'="N/AN/AN/A" LEXT=""
 . S LEXT=LEXT_$J(" ",((79-+($G(LEXLEN)))-$L(LEXT)))_"Principal DX:     Code is unacceptable as a principal DX" D:+LEXC'>0 BL D TL(LEXT)
 Q
SD(X,LEXLEN) ;   Short Description
 N LEXI,LEXH,LEXE,LEXN,LEXT Q:'$D(X(1))  S LEXN=$G(X(1)),LEXT="  Short Name: ",LEXT=LEXT_$J(" ",((79-+($G(LEXLEN)))-$L(LEXT)))_LEXN D BL,TL(LEXT)
 S LEXE=$G(X(0)),LEXT="    "_LEXE,LEXN=$G(X(2)),LEXT=LEXT_$J(" ",((79-+($G(LEXLEN)))-$L(LEXT)))_LEXN D TL(LEXT)
 Q
LD(X,LEXLEN) ;   Long Description
 N LEXI,LEXH,LEXE,LEXN,LEXT Q:'$D(X(1))  S LEXN=$G(X(1)),LEXT="  Description: ",LEXT=LEXT_$J(" ",((79-+($G(LEXLEN)))-$L(LEXT)))_LEXN D BL,TL(LEXT)
 S LEXE=$G(X(0)),LEXT="    "_LEXE,LEXN=$G(X(2)),LEXT=LEXT_$J(" ",((79-+($G(LEXLEN)))-$L(LEXT)))_LEXN D TL(LEXT)
 S LEXT=$J(" ",((79-+($G(LEXLEN))))) S LEXI=2 F  S LEXI=$O(X(LEXI)) Q:+LEXI'>0  S LEXN=LEXT_$G(X(LEXI)) D TL(LEXN)
 Q
LX(X,LEXLEN) ;   Lexicon Expression
 N LEXI,LEXH,LEXE,LEXN,LEXT Q:'$D(X(1))  S LEXN=$G(X(1)),LEXT="  Lexicon Term:",LEXT=LEXT_$J(" ",((79-+($G(LEXLEN)))-$L(LEXT)))_LEXN D BL,TL(LEXT)
 S LEXE=$G(X(0)),LEXT="    "_LEXE,LEXN=$G(X(2)),LEXT=LEXT_$J(" ",((79-+($G(LEXLEN)))-$L(LEXT)))_LEXN D TL(LEXT)
 S LEXT=$J(" ",((79-+($G(LEXLEN))))),LEXI=2 F  S LEXI=$O(X(LEXI)) Q:+LEXI'>0  S LEXN=LEXT_$G(X(LEXI)) D TL(LEXN)
 Q
WN(X,LEXLEN) ;   Warning
 N LEXI,LEXH,LEXE,LEXN,LEXT,LEXC Q:'$D(X(1))  S LEXC=0,LEXN=$G(X(1)),LEXT="",LEXT=LEXT_$J(" ",((79-+($G(LEXLEN)))-$L(LEXT)))_LEXN D BL,TL(LEXT)
 S LEXT=$J(" ",((79-+($G(LEXLEN))))),LEXI=1 F  S LEXI=$O(X(LEXI)) Q:+LEXI'>0  S LEXN=LEXT_$G(X(LEXI)) D TL(LEXN)
 Q
CC(X,LEXLEN) ;   Complication/Comorbidity
 N LEXI,LEXH,LEXE,LEXN,LEXT Q:'$D(X(1))  S LEXN=$G(X(1)),LEXE=$G(X(0)),LEXT="  CC:",LEXT=LEXT_$J(" ",((79-+($G(LEXLEN)))-$L(LEXT)))_LEXN
 S LEXT=LEXT_$J(" ",(66-$L(LEXT)))_LEXE D TL(LEXT)
 Q
MC(X,LEXLEN) ;   Major Diagnostic Category
 N LEXI,LEXH,LEXE,LEXN,LEXT Q:'$D(X(1))  S LEXN=$G(X(1)),LEXE=$G(X(0)),LEXT="  MDC:",LEXT=LEXT_$J(" ",((79-+($G(LEXLEN)))-$L(LEXT)))_LEXN
 S LEXT=LEXT_$J(" ",(66-$L(LEXT)))_LEXE D TL(LEXT)
 Q
MD(X,LEXLEN) ;   CPT Modifiers
 N LEXI,LEXH,LEXE,LEXN,LEXT Q:'$D(X(1))  S LEXE=$G(X(0)),LEXN=$G(X(1)),LEXT="  Modifiers:",LEXT=LEXT_$J(" ",((79-+($G(LEXLEN)))-$L(LEXT)))_LEXN D BL,TL(LEXT)
 S LEXT="    "_LEXE,LEXN=$G(X(2)),LEXT=LEXT_$J(" ",((79-+($G(LEXLEN)))-$L(LEXT)))_LEXN D TL(LEXT)
 S LEXT=$J(" ",((79-+($G(LEXLEN))))),LEXI=2 F  S LEXI=$O(X(LEXI)) Q:+LEXI'>0  D
 . S LEXN=LEXT_$G(X(LEXI)) D TL(LEXN)
 Q
DRG(LEXLEN) ;   Diagnosis Related Groups
 Q:$O(^TMP("LEXQID",$J,"DRG",3,0))'>0  Q:'$D(^TMP("LEXQID",$J,"DRG",3,1))  Q:'$D(^TMP("LEXQID",$J,"DRG",1,1))
 Q:'$D(^TMP("LEXQID",$J,"DRG",1,2))  Q:'$D(^TMP("LEXQID",$J,"DRG",2,1))  N LEXI,LEXH,LEXE,LEXN,LEXT
 S LEXT="  "_$G(^TMP("LEXQID",$J,"DRG",1,1))_":",LEXN=$G(^TMP("LEXQID",$J,"DRG",2,1)) S LEXT=LEXT_$J(" ",((79-+($G(LEXLEN)))-$L(LEXT)))_LEXN D BL,TL(LEXT)
 S LEXE=$G(^TMP("LEXQID",$J,"DRG",1,2)),LEXT="    "_LEXE,LEXN=$G(^TMP("LEXQID",$J,"DRG",3,1)) S LEXT=LEXT_$J(" ",((79-+($G(LEXLEN)))-$L(LEXT)))_LEXN D TL(LEXT)
 S LEXT=$J(" ",((79-+($G(LEXLEN))))),LEXI=2 F  S LEXI=$O(^TMP("LEXQID",$J,"DRG",3,LEXI)) Q:+LEXI'>0  D
 . S LEXN=LEXT_$G(^TMP("LEXQID",$J,"DRG",3,LEXI)) D TL(LEXN)
 K ^TMP("LEXQID",$J,"DRG")
 Q
NOT(LEXLEN) ;   ICD codes not used with
 Q:'$L($O(^TMP("LEXQID",$J,"NOT",3,"")))  Q:'$D(^TMP("LEXQID",$J,"NOT",1,1))  Q:'$D(^TMP("LEXQID",$J,"NOT",2,1))
 N LEXI,LEXH,LEXE,LEXN,LEXT S LEXT="  "_$G(^TMP("LEXQID",$J,"NOT",1,1))_":",LEXN=$G(^TMP("LEXQID",$J,"NOT",2,1))
 S LEXT=LEXT_$J(" ",((79-+($G(LEXLEN)))-$L(LEXT)))_LEXN D BL,TL(LEXT)
 S LEXT=$J(" ",((79-+($G(LEXLEN))))),LEXN=$$TM^LEXQM($G(^TMP("LEXQID",$J,"NOT",2,2))) I $L(LEXN) D TL((LEXT_LEXN))
 S LEXI=" " F  S LEXI=$O(^TMP("LEXQID",$J,"NOT",3,LEXI)) Q:'$L(LEXI)  D
 . S LEXN=$G(^TMP("LEXQID",$J,"NOT",3,LEXI)) D TL((LEXT_LEXN))
 K ^TMP("LEXQID",$J,"NOT")
 Q
REQ(LEXLEN) ;   ICD codes requried with
 Q:'$L($O(^TMP("LEXQID",$J,"REQ",3,"")))  Q:'$D(^TMP("LEXQID",$J,"REQ",1,1))  Q:'$D(^TMP("LEXQID",$J,"REQ",2,1))
 N LEXI,LEXH,LEXE,LEXN,LEXT S LEXT="  "_$G(^TMP("LEXQID",$J,"REQ",1,1))_":",LEXN=$G(^TMP("LEXQID",$J,"REQ",2,1))
 S LEXT=LEXT_$J(" ",((79-+($G(LEXLEN)))-$L(LEXT)))_LEXN D BL,TL(LEXT)
 S LEXT=$J(" ",((79-+($G(LEXLEN))))),LEXN=$$TM^LEXQM($G(^TMP("LEXQID",$J,"REQ",2,2))) I $L(LEXN) D TL((LEXT_LEXN))
 S LEXI=" " F  S LEXI=$O(^TMP("LEXQID",$J,"REQ",3,LEXI)) Q:'$L(LEXI)  D
 . S LEXN=$G(^TMP("LEXQID",$J,"REQ",3,LEXI)) D TL((LEXT_LEXN))
 K ^TMP("LEXQID",$J,"REQ")
 Q
NCC(LEXLEN) ;   Not CC with
 Q:'$L($O(^TMP("LEXQID",$J,"NCC",3,"")))  Q:'$D(^TMP("LEXQID",$J,"NCC",1,1))  Q:'$D(^TMP("LEXQID",$J,"NCC",2,1))
 N LEXI,LEXH,LEXE,LEXN,LEXT S LEXT="  "_$G(^TMP("LEXQID",$J,"NCC",1,1))_":",LEXN=$G(^TMP("LEXQID",$J,"NCC",2,1))
 S LEXT=LEXT_$J(" ",((79-+($G(LEXLEN)))-$L(LEXT)))_LEXN D BL,TL(LEXT)
 S LEXT=$J(" ",((79-+($G(LEXLEN))))),LEXN=$$TM^LEXQM($G(^TMP("LEXQID",$J,"NCC",2,2))) I $L(LEXN) D TL((LEXT_LEXN))
 S LEXI=" " F  S LEXI=$O(^TMP("LEXQID",$J,"NCC",3,LEXI)) Q:'$L(LEXI)  D
 . S LEXN=$G(^TMP("LEXQID",$J,"NCC",3,LEXI)) D TL((LEXT_LEXN))
 K ^TMP("LEXQID",$J,"NCC")
 Q
 ;
 ; Miscellaneous
BL ;   Blank Line
 D TL(" ") Q
TL(X) ;   Text Line
 I $D(LEXTEST) W !,$G(X) Q
 N LEXI S LEXI=+($O(^TMP("LEXQIDO",$J," "),-1))+1 S ^TMP("LEXQIDO",$J,LEXI)=$G(X),^TMP("LEXQIDO",$J,0)=LEXI
 Q
CLR ;   Clear
 K LEXCC,LEXELDT,LEXGET,LEXIEN,LEXLD,LEXLX,LEXMC,LEXSD,LEXST,LEXTEST,LEXWN
 Q
