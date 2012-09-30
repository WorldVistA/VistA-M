LEX2081P ;ISL/KER - LEX*2.0*81 Pre/Post Install ;08/17/2011
 ;;2.0;LEXICON UTILITY;**81**;Sep 23, 1996;Build 1
 ;               
 ; Global Variables
 ;    ^%ZOSF("PROD")      ICR  10096
 ;    ^%ZOSF("UCI")       ICR  10096
 ;    ^TMP("LEXKID",$J)   SACC 2.3.2.5.1
 ;    ^TMP("LEXMSG",$J)   SACC 2.3.2.5.1
 ;               
 ; External References
 ;    ^DIC                ICR  10006
 ;    $$GET1^DIQ          ICR   2056
 ;    $$FMTE^XLFDT        ICR  10103
 ;    $$NOW^XLFDT         ICR  10103
 ;    ^XMD                ICR  10070
 Q
PRE ; Pre-Install
 Q
POST ; Post-Install
 ;            
 ; From IMP in the Environment Check
 ;            
 ;      LEXBUILD   Build Name          LEX*2.0*81
 ;      LEXPTYPE   Patch Type          Emergency Patch (Remedy Ticket Fixes)
 ;      LEXFY      Fiscal Year         N/A
 ;      LEXQTR     Quarter             N/A
 ;      LEXIGHF    Name of Host File   N/A
 ;      LEXLREV    Revision            81
 ;      LEXREQP    Required Builds     LEX*2.0*73^3110628
 ;            
 N LEXEDT,LEXPTYPE,LEXLREV,LEXREQP,LEXBUILD,LEXIGHF,LEXFY,LEXQTR,LEXB,LEXCD,LEXSTR,LEXLAST,LEXOK,X,Y S LEXOK=0 D IMP
 D:LEXOK>0 POST^LEX2081A,INS
 Q
INS ; Install Message
 K ^TMP("LEXKID",$J),LEXSCHG N LEXA,LEXAC,LEXAO,LEXB,LEXBUILD,LEXH,LEXIN,LEXS,LEXT,LEXU
 S LEXBUILD="LEX*2.0*81",LEXS="Emergency Patch LEX*2.0*81 Installation" H 2 D BL,TL((" "_LEXS)),TL(" ======================================="),BL
 S LEXAO="   As of:       "_$$ED($$NOW^XLFDT) D TL(LEXAO) S LEXAC=""
 S LEXA=$$UCI S:$L($P(LEXA,"^",1)) LEXAC="   In Account:  " S LEXAC=LEXAC_$S($L($P(LEXA,"^",1)):"[",1:"")_$P(LEXA,"^",1)_$S($L($P(LEXA,"^",2)):"]",1:"")
 S:$L($P(LEXA,"^",2)) LEXAC=LEXAC_"  "_$P(LEXA,"^",2) D TL(LEXAC) S LEXU=$$USR
 S:$L($P(LEXU,"^",1)) LEXU="   Maint By:    "_$P(LEXU,"^",1)_"   "_$P(LEXU,"^",2) D TL(LEXU)
 S LEXB="   Build:       "_LEXBUILD D TL(LEXB)
 D:+($G(^TMP("LEXKID",$J,0)))>0 MAIL K ^TMP("LEXKID",$J)
 Q
MAIL ;   Mail global array in message
 N DIFROM,LEXPRI,LEXADR,LEXI,LEXM,LEXSUB,XCNP,XMDUZ,XMSCR,XMSUB,XMTEXT,XMY,XMZ,LEXPTYPE,LEXLREV,LEXREQP,LEXBUILD,LEXIGHF,LEXFY,LEXQTR
 D IMP K ^TMP("LEXMSG",$J) S LEXSUB="Lexicon/ICD/CPT Installation" S:$L($G(LEXBUILD)) LEXSUB=$G(LEXBUILD)_" Installation"
 S LEXPRI=$$ADR G:'$L(LEXPRI) MAILQ S LEXPRI="G.LEXINS@"_LEXPRI S LEXADR=$$GET1^DIQ(200,+($G(DUZ)),.01) G:'$L(LEXADR) MAILQ
 S XMSUB=LEXSUB S LEXI=0 F  S LEXI=$O(^TMP("LEXKID",$J,LEXI)) Q:+LEXI=0  D
 . S LEXM=+($O(^TMP("LEXMSG",$J," "),-1))+1,^TMP("LEXMSG",$J,LEXM,0)=$E($G(^TMP("LEXKID",$J,LEXI)),1,79),^TMP("LEXMSG",$J,0)=LEXM
 K ^TMP("LEXKID",$J) G:'$D(^TMP("LEXMSG",$J)) MAILQ G:+($G(^TMP("LEXMSG",$J,0)))'>0 MAILQ S XMY(LEXPRI)="",XMY(LEXADR)=""
 S XMTEXT="^TMP(""LEXMSG"",$J,",XMDUZ=.5 D ^XMD
MAILQ ;   Quit Mail
 D KILL K XCNP,XMSCR,XMDUZ,XMY,XMZ,XMSUB,XMY,XMTEXT,XMDUZ
 Q
 ;            
 ; Miscellaneous
ADR(LEX) ;   Mailing Address
 N DIC,DTOUT,DUOUT,X,Y
 S DIC="^DIC(4.2,",DIC(0)="M",(LEX,X)="FO-SLC.DOMAIN.EXT" D ^DIC Q:+Y>0 LEX
 S DIC="^DIC(4.2,",DIC(0)="M",(LEX,X)="FO-SLC.DOMAIN.EXT" D ^DIC Q:+Y>0 LEX
 S DIC="^DIC(4.2,",DIC(0)="M",(LEX,X)="ISC-SLC.DOMAIN.EXT" D ^DIC Q:+Y>0 LEX
 Q "ISC-SLC.DOMAIN.EXT"
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
KILL ;   Kill all ^TMP(
 K ^TMP("LEXMSG",$J),^TMP("LEXKID",$J)
 Q
BL ;   Blank Line
 D TL(" ")
 Q
TL(X) ;   Text Line
 N LEXI S LEXI=$O(^TMP("LEXKID",$J," "),-1),LEXI=LEXI+1,^TMP("LEXKID",$J,LEXI)=$G(X),^TMP("LEXKID",$J,0)=LEXI
 Q
PIEN(X) ;   Package IEN
 N DIC,DTOUT,DTOUT,Y S X=$G(X),DIC="^DIC(9.4,",DIC(0)="B" D ^DIC S X=+Y
 Q X
IMP ;   Call IMP in Environment Check
 K LEXBUILD,LEXFY,LEXIGHF,LEXLREV,LEXPTYPE,LEXQTR,LEXREQP N LEXF
 S LEXF=$P($T(+1)," ",1) S:$E(LEXF,$L(LEXF))="P" LEXF=$E(LEXF,1,($L(LEXF)-1)) Q:'$L(LEXF)
 S LEXF="IMP^"_LEXF Q:'$L($T(@LEXF))  D @LEXF S:$L(LEXBUILD) LEXOK=1
 Q
