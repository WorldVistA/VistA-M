LEX2073P ;ISL/KER - LEX*2.0*73 Pre/Post Install ;01/03/2011
 ;;2.0;LEXICON UTILITY;**73**;Sep 23, 1996;Build 10
 ;               
 ; Global Variables
 ;    ^%ZOSF("PROD")      ICR  10096
 ;    ^%ZOSF("UCI")       ICR  10096
 ;    ^ORD(101,           ICR    872
 ;    ^TMP("LEXKID")      SACC 2.3.2.5.1
 ;               
 ; External References
 ;    $$GET1^DIQ          ICR   2056
 ;    $$FMTE^XLFDT        ICR  10103
 ;    $$NOW^XLFDT         ICR  10103
 ;    BMES^XPDUTL         ICR  10141
 ;    MES^XPDUTL          ICR  10141
 ;    EN^XQOR             ICR  10101
 ;               
 ; Deletion of Unversioned Fields Patch Numbers
 ;               
 ;   LEX*2.0*73   
 ;     ICPT*6.0*46   
 ;     ICD*18.0*40   
 ;
 Q
PRE ; LEX*2.0*73 Pre-Install
 Q
POST ; LEX*2.0*73 Post-Install
 N LEX1,LEX2,LEX3,LEXA,LEXAC,LEXAO,LEXB,LEXBUILD,LEXDUZ,LEXFI,LEXH,LEXI,LEXID,LEXIN,LEXNM,LEXP,LEXPH,LEXPRO,LEXS
 N LEXSCHG,LEXT,LEXU,LEXUSR,X,Y D CON,POST^LEX2073A,INS
 Q
 ;             
INS ; Install Message
 K ^TMP("LEXKID",$J),LEXSCHG N LEXA,LEXAC,LEXAO,LEXB,LEXBUILD,LEXH,LEXIN,LEXPRO,LEXS,LEXT,LEXU
 S LEXBUILD="LEX*2.0*73",LEXPRO=$$NOT,LEXS="LEX*2.0*73 Installation" H 2 D BL,TL((" "_LEXS)),TL(" ======================="),BL
 S LEXAO="   As of:       "_$$ED($$NOW^XLFDT) D TL(LEXAO) S LEXAC=""
 S LEXA=$$UCI S:$L($P(LEXA,"^",1)) LEXAC="   In Account:  " S LEXAC=LEXAC_$S($L($P(LEXA,"^",1)):"[",1:"")_$P(LEXA,"^",1)_$S($L($P(LEXA,"^",2)):"]",1:"")
 S:$L($P(LEXA,"^",2)) LEXAC=LEXAC_"  "_$P(LEXA,"^",2) D TL(LEXAC) S LEXU=$$USR
 S:$L($P(LEXU,"^",1)) LEXU="   Maint By:    "_$P(LEXU,"^",1)_"   "_$P(LEXU,"^",2) D TL(LEXU)
 S LEXB="   Build:       "_LEXBUILD D TL(LEXB) S LEXIN=$P($G(LEXPRO),"^",1) I LEXIN>0 D
 . S LEXT="   Protocol:    "_"LEXICAL SERVICES UPDATE" D BL,TL(LEXT) S LEXT="   Invoked:     "_$$ED(LEXIN) D TL(LEXT),BL
 D:+($G(^TMP("LEXKID",$J,0)))>0 MAIL^LEX2073 K ^TMP("LEXKID",$J)
 Q
NOT(X) ; Notify by Protocol
 N LEXIN,LEXFI,LEXID,LEXP,Y K LEXSCHG S LEXFI=0,LEXIN="",LEXSCHG("LEX")=""
 S LEXP=+($O(^ORD(101,"B","LEXICAL SERVICES UPDATE",0))) Q:LEXP=0 ""  S X=LEXP_";ORD(101," D EN^XQOR
 S:$P($G(LEXSCHG("LEX")),".",1)?7N LEXIN=$G(LEXSCHG("LEX"))
 D:+LEXIN>0 BMES^XPDUTL(("  Protocol 'LEXICAL SERVICES UPDATE' invoked  "_$$ED(LEXIN))),MES^XPDUTL(" ") S X=LEXIN
 Q X
 ;            
 ; Miscellaneous
ED(X) ;   External Date
 N Y S Y=$$FMTE^XLFDT($G(X)) S:Y["@" Y=$P(Y,"@",1)_"  "_$P(Y,"@",2,299) S:$L(Y) X=Y
 Q X
UCI(X) ;   UCI where Lexicon is installed
 N LEXU,LEX1,LEX2,LEX3,LEXP,LEXT,Y X ^%ZOSF("UCI") S LEXU=Y,LEXP="",LEX1=$P(Y,",",1),LEX2=$P(Y,",",2,299),LEX3=$G(^%ZOSF("PROD"))
 S:$L(LEX3)&(LEXU=LEX3!(LEX1=LEX3)!(LEX2=LEX3)) LEXP=" (Production)" S:'$L(LEXP) LEXP=" (Test)"
 S:$L(LEX1)>5&($L(LEX2)>5)&(LEX1=LEX2) LEXU=LEX1 S X="",$P(X,"^",1)=LEXU,$P(X,"^",2)=LEXP
 Q X
USR(X) ;   User/Person Installing
 N LEXDUZ,LEXUSR,LEXPH,LEXNM S LEXDUZ=+($G(DUZ)) Q:+LEXDUZ'>0 "UNKNOWN^"  S LEXNM=$$GET1^DIQ(200,+LEXDUZ,.01) Q:'$L(LEXNM) "UNKNOWN^"
 S LEXUSR=LEXDUZ S LEXPH=$$GET1^DIQ(200,+LEXUSR,.132) S:LEXPH="" LEXPH=$$GET1^DIQ(200,+LEXUSR,.131)
 S:LEXPH="" LEXPH=$$GET1^DIQ(200,+LEXUSR,.133) S:LEXPH="" LEXPH=$$GET1^DIQ(200,+LEXUSR,.134)
 S LEXUSR=$$GET1^DIQ(200,+LEXDUZ,.01),X=LEXUSR_"^"_LEXPH
 Q X
CON ;   Conversion of Data
 D BM(" Re-building Mapping File 757.33") N IEN,DIK,DA,CT S (CT,IEN)=0 W ! F  S IEN=$O(^LEX(757.33,IEN)) Q:+IEN'>0  D
 . S DA=+IEN,DIK="^LEX(757.33," D IX1^DIK S CT=CT+1 W:(CT#238)'>0 ?4,"."
 Q
BL ;   Blank Line
 D TL(" ")
 Q
TL(X) ;   Text Line
 N LEXI S LEXI=$O(^TMP("LEXKID",$J," "),-1),LEXI=LEXI+1,^TMP("LEXKID",$J,LEXI)=$G(X),^TMP("LEXKID",$J,0)=LEXI
 Q
M(X) ;   Blank/Text
 D MES^XPDUTL($G(X)) Q
BM(X) ;   Blank/Text
 D BMES^XPDUTL($G(X)) Q
