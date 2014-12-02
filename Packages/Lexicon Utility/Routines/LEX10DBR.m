LEX10DBR ;ISL/KER - ICD-10 Diagnosis Lookup by Root ;04/21/2014
 ;;2.0;LEXICON UTILITY;**80**;Sep 23, 1996;Build 1
 ;               
 ; Global Variables
 ;    ^LEX(757.033)       N/A
 ;    ^TMP("LEXDX")       SACC 2.3.2.5.1
 ;    ^TMP("LEXSCH")      Suggest SACC 2.3.2.5.1
 ;               
 ; External References
 ;    $$ICDDX^ICDEX       ICR 5747
 ;    $$LD^ICDEX          ICR 5747
 ;    $$SD^ICDEX          ICR 5747
 ;               
 Q
MAJ(X,LEXA,LEXVDT) ; Lookup by Root, Major Categories (3 digit/decimal)
 K ^TMP("LEXSCH",$J) N LEXC,LEXO,LEXT,LEXCT,LEXFND,LEXTOT S LEXCT=0
 D GETCAT($G(X),$G(LEXVDT)),GETCOD($G(X),$G(LEXVDT)) S LEXFND=+($G(LEXCT))
 D ARY^LEX10DU S LEXC=+($O(LEXA(" "),-1)) S:LEXC'>0 LEXC=-1 S LEXA(0)=LEXC
 K ^TMP("LEXSCH",$J) S:LEXC>0 $P(LEXA(0),"^",2)=1
 Q
GETCAT(X,LEXVDT) ; Get Categories
 N LEXC,LEXCTL,LEXO S LEXC=$E(X,1,2) Q:$L(LEXC)'=2  S (LEXCTL,LEXO)=LEXC,LEXO=LEXO_" "
 F  S LEXO=$O(^LEX(757.033,"AFRAG",30,LEXO)) Q:'$L(LEXO)!($E(LEXO,1,$L(LEXCTL))'=LEXCTL)  D
 . N LEXQ,LEXE,LEXI,LEXNE,LEXNI,LEXN,LEXIS,LEXCN,LEX
 . S LEXQ=$TR(LEXO," ","")
 . S:$L(LEXQ)=3&(LEXQ'[".") LEXQ=LEXQ_"."
 . Q:$L(LEXQ)'=4
 . S LEXE=$P($O(^LEX(757.033,"AFRAG",30,(LEXQ_" ")," "),-1),".",1)
 . Q:LEXE'?7N  I $P($G(LEXVDT),".",1)?7N Q:LEXE>LEXVDT
 . S LEXI=$O(^LEX(757.033,"AFRAG",30,(LEXQ_" "),LEXE," "),-1)
 . S LEXNE=$O(^LEX(757.033,+LEXI,2,"B",(LEXVDT+.0001)),-1)
 . S LEXNI=$O(^LEX(757.033,+LEXI,2,"B",+LEXNE," "),-1)
 . I LEXNI'>0 D  Q:LEXNI'>0
 . . S LEXNE=$O(^LEX(757.033,+LEXI,2,"B",9999999),-1)
 . . S LEXNI=$O(^LEX(757.033,+LEXI,2,"B",+LEXNE," "),-1)
 . S LEXN=$G(^LEX(757.033,LEXI,2,LEXNI,1)) Q:'$L(LEXN)
 . S LEXCN=$$CODES^LEX10DU(LEXQ),LEX="^"_LEXE_"^"_LEXN
 . S:+LEXCN>0 $P(LEX,"^",4)=+LEXCN
 . S ^TMP("LEXDX",$J,(LEXQ_" "))=LEX S LEXCT=LEXCT+1
 Q
GETCOD(X,LEXVDT) ; Get Codes
 N LEXC,LEXCTL,LEXO S LEXC=$E(X,1,2) Q:$L(LEXC)'=2  S (LEXCTL,LEXO)=LEXC,LEXO=LEXO_" "
 F  S LEXO=$O(^LEX(757.02,"ADX",LEXO)) Q:'$L(LEXO)!($E(LEXO,1,$L(LEXCTL))'=LEXCTL)  D
 . N LEXQ,LEXE,LEXI,LEXN,LEXSTA,LEX,LEXT
 . S LEXQ=$TR(LEXO," ","") S:$L(LEXQ)=3&(LEXQ'[".") LEXQ=LEXQ_"." Q:$L(LEXQ)'=4
 . S LEXSTA=$$STATCHK^LEXSRC2(LEXQ,$G(LEXVDT),,30) Q:+LEXSTA'>0
 . S LEXE=$P(LEXSTA,"^",3),LEXI=$P(LEXSTA,"^",2) Q:+LEXI'>0
 . S LEXT=+($G(^LEX(757.02,+LEXI,0))) Q:+LEXT'>0
 . Q:LEXE'?7N  I $P($G(LEXVDT),".",1)?7N Q:LEXE>LEXVDT
 . S LEXN=$P($G(^LEX(757.01,+LEXT,0)),"^",1) Q:'$L(LEXN)
 . S ^TMP("LEXDX",$J,(LEXQ_" "))=LEXI_"^"_LEXE_"^"_LEXN S LEXCT=LEXCT+1
 Q
ST ;
 N LEXNN,LEXNC
 S LEXNN="^TMP(""LEXSCH"","_$J_")",LEXNC="^TMP(""LEXSCH"","_$J_","
 F  S LEXNN=$Q(@LEXNN) Q:'$L(LEXNN)!(LEXNN'[LEXNC)  D
 . W !,LEXNN,"=",@LEXNN
 Q
TM(X,Y) ;   Trim Character Y - Default " "
 S X=$G(X) Q:X="" X  S Y=$G(Y) S:'$L(Y) Y=" "
 F  Q:$E(X,1)'=Y  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=Y  S X=$E(X,1,($L(X)-1))
 Q X
