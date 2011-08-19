LEXQHLM ;ISL/KER - Query History - Extract Misc ;10/30/2008
 ;;2.0;LEXICON UTILITY;**62**;Sep 23, 1996;Build 16
 ;;
 ;               
 ; Global Variables
 ;    ^ICD0(              ICR   4485
 ;    ^TMP("LEXQHO")      SACC 2.3.2.5.1
 ;    ^UTILITY($J         ICR  10011
 ;               
 ; External References
 ;    ^DIWP               ICR  10011
 ;    $$FMTE^XLFDT        ICR  10103
 ;               
 ; Local Variables NEWed or KILLed Elsewhere
 ;     LEXTEST
 ;               
 Q
 ; Miscellaneous
BL ;   Blank Line
 D TL(" ")
 Q
TL(X) ;   Text Line
 I $D(LEXTEST) W !,$G(X) Q
 N LEXI S LEXI=$O(^TMP("LEXQHO",$J," "),-1)+1,^TMP("LEXQHO",$J,LEXI)=$G(X),^TMP("LEXQHO",$J,0)=LEXI
 Q
SD(X) ;   Short Date
 Q $TR($$FMTE^XLFDT(+($G(X)),"5DZ"),"@"," ")
IA(X) ;   Initial Activation
 N LEXEF,LEXH,LEXN,LEXS,LEXE,LEXIEN S LEXIEN=+($G(X)),LEXE="" Q:+LEXIEN'>0 ""  Q:'$D(^ICD0(+LEXIEN,66,0)) ""  S LEXEF="" F  S LEXEF=$O(^ICD0(+LEXIEN,66,"B",LEXEF)) Q:'$L(LEXEF)  D  Q:$G(LEXE)?7N
 . S LEXH=0 F  S LEXH=$O(^ICD0(+LEXIEN,66,"B",LEXEF,LEXH)) Q:+LEXH'>0  S LEXN=$G(^ICD0(+LEXIEN,66,+LEXH,0)) S:+($P(LEXN,U,2))>0 LEXE=$P(LEXN,U,1) Q:$G(LEXE)?7N
 S X="" S:$G(LEXE)?7N X=$G(LEXE)
 Q X
MS(X,Y) ;   Date Message
 Q:$G(X)'>2781001&($G(Y)=0) " (business rule date used)"
 Q:$G(X)'>2890101&($G(Y)=1) " (business rule date used)"
 Q ""
PR(LEX,X) ;   Parse Array
 N DIW,DIWF,DIWI,DIWL,DIWR,DIWT,DIWTC,DIWX,DN,LEXI,LEXLEN,LEXC K ^UTILITY($J,"W") Q:'$D(LEX)
 S LEXLEN=+($G(X)) S:+LEXLEN'>0 LEXLEN=79 S LEXC=+($G(LEX)) S:+($G(LEXC))'>0 LEXC=$O(LEX(" "),-1) Q:+LEXC'>0
 S DIWL=1,DIWF="C"_+LEXLEN S LEXI=0 F  S LEXI=$O(LEX(LEXI)) Q:+LEXI=0  S X=$G(LEX(LEXI)) D ^DIWP
 K LEX S (LEXC,LEXI)=0 F  S LEXI=$O(^UTILITY($J,"W",1,LEXI)) Q:+LEXI=0  D
 . S LEX(LEXI)=$$TM($G(^UTILITY($J,"W",1,LEXI,0))," "),LEXC=LEXC+1
 S:$L(LEXC) LEX=LEXC K ^UTILITY($J,"W")
 Q
HD(X) ;   Header
 Q:+($G(X))=1 "Status"  Q:+($G(X))=2 "Operation/Procedure"  Q:+($G(X))=3 "Description"  Q:+($G(X))=4 "Major Diagnostic Category/DRG Groups"
 Q ""
AND(X) ;   Substitute 'and'
 S X=$G(X) Q:$L(X,", ")'>1 X
 S X=$P(X,", ",1,($L(X,", ")-1))_" and "_$P(X,", ",$L(X,", "))
 Q X
CS(X) ;   Trim Comma/Space
 S X=$$TM($G(X),","),X=$$TM($G(X)," "),X=$$TM($G(X),","),X=$$TM($G(X)," ")
 Q X
CL ;   Clear
 K LEXTEST
 Q X
TM(X,Y) ;   Trim Character Y - Default " "
 S X=$G(X) Q:X="" X  S Y=$G(Y) S:'$L(Y) Y=" "
 F  Q:$E(X,1)'=Y  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=Y  S X=$E(X,1,($L(X)-1))
 Q X
