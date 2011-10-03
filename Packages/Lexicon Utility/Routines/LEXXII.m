LEXXII ;ISL/KER - Lexicon Status (Install Info) ;01/03/2011
 ;;2.0;LEXICON UTILITY;**32,46,49,50,41,59,73**;Sep 23, 1996;Build 10
 ;              
 ; Variables NEWed or KILLed Elsewhere
 ;   LEXACCT  NEWed by LEXXFI sending message
 ;   LEXID    NEWed by LEXXFI sending message
 ;   LEXCRE   NEWed by LEXXGI loading data
 ;   LEXIGHF  NEWed by Post Install routine LEX20nnP
 ;   XPDA     NEWed by KIDS during Install
 ;              
 ; Global Variables
 ;   DBIA 10096  ^%ZOSF("PROD"
 ;   DBIA 10096  ^%ZOSF("UCI"
 ;   DBIA 10060  ^VA(200
 ;   ^LEXM(0
 ;   ^TMP("LEX*",$J    SACC 2.3.2.5.1
 ;              
 ; External References
 ;   DBIA 10103  $$FMTE^XLFDT
 ;   DBIA 10103  $$NOW^XLFDT
 ;   DBIA 10103  $$FMDIFF^XLFDT
 ;   DBIA  2056  $$GET1^DIQ (file #200)
 ;   DBIA  2051  FIND^DIC
 ;   DBIA  2056  GETS^DIQ
 ;              
EN ; Main Entry
 N LEXSUB S LEXSUB=$G(LEXID) S:LEXSUB="" LEXSUB="LEXXII" K ^TMP(LEXSUB,$J) D II
 Q
 ;                               
II ; Install Information
 N LEXT,LEXA,LEXACT,LEXB,LEXD,LEXE,LEXL,LEXU,LEXN,LEXP,LEXPROF,LEXDA H 2
 S LEXA="",LEXACT=$G(LEXACCT),LEXPRO=$G(LEXPRO),LEXPRON=$G(LEXPRON)
 S:'$L(LEXPRON) LEXPRON="LEXICAL SERVICES UPDATE" S:'$L(LEXPRO) LEXPRO=$G(^LEXM(0,"PRO")) S:+LEXPRO>0 LEXPRO=$$ED(LEXPRO)
 S LEXT="Lexicon/ICD/CPT Installation" D TL(LEXT)
 S LEXT="============================" D TL(LEXT),BL
 S LEXD=$$ASOF,LEXA=$$UCI,LEXU=$$USR,LEXN=$P(LEXU,"^",1)
 S:$L($P(LEXACT,"^",1))&($L($P(LEXACT,"^",1))) LEXA=LEXACT
 S LEXP=$P(LEXU,"^",2),LEXN=$$PM^LEXXFI7(LEXN)
 S:$L(LEXD) LEXT="  As of:       "_LEXD
 D:$L(LEXD) TL(LEXT)
 S LEXT="" S:$L(LEXA) LEXT="  In Account:  "_$S($L($P(LEXA,"^",1)):"[",1:"")_$P(LEXA,"^",1)_$S($L($P(LEXA,"^",2)):"]",1:"")
 S:$L(LEXT)&($L($P(LEXA,"^",2))) LEXT=LEXT_"  "_$P(LEXA,"^",2)
 D:$L(LEXA) TL(LEXT)
 S LEXT="" S:$L(LEXU) LEXT="  Maint By:    "
 S:$L(LEXN) LEXT=LEXT_LEXN
 S:$L(LEXP)&($L(LEXN)) LEXT=LEXT_"   "_LEXP
 D:$L(LEXT)&(LEXT'["UNKNOWN") TL(LEXT)
 S LEXT="" S:$L($G(LEXBUILD)) LEXT="  Build:       "_$G(LEXBUILD)
 D:$L(LEXT) TL(LEXT)
 S LEXT="" S:$L($G(LEXIGHF)) LEXT="  Host File:   "_$G(LEXIGHF)
 S:$L(LEXT)&($L($G(LEXCRE)))&($P($G(LEXCRE),".",1)?7N) LEXT=LEXT_" (Created "_$$ED($G(LEXCRE))_")"
 S:'$L(LEXT)&($L($G(LEXCRE)))&($P($G(LEXCRE),".",1)?7N) LEXT="  Created:     "_$$ED($G(LEXCRE))
 D:$L(LEXT) TL(LEXT)
 S LEXT="" I $O(LEXPROC(" "),-1)'>1,$L($G(LEXPRO))&($L($G(LEXPRON))),$O(LEXPROC(" "),-1)'>1 D
 . S LEXT="  Protocol:    "_LEXPRON D BL,TL(LEXT)
 . S LEXT="  Invoked:     "_LEXPRO D TL(LEXT)
 . K LEXPRO,LEXPRON,^LEXM(0,"PRO")
 I $O(LEXPROC(" "),-1)>1 D
 . N LEXT,LEXI,LEXC,LEXT S LEXT=$$TRIM($G(LEXPROC(1))) Q:'$L(LEXT)  D BL,TL(("  "_LEXT))
 . S LEXC=0,LEXI=1 F  S LEXI=$O(LEXPROC(LEXI)) Q:+LEXI'>0  D
 . . N LEXT S LEXT=$$TRIM($TR($G(LEXPROC(LEXI)),"'","")) Q:'$L(LEXT)  S LEXC=LEXC+1 D TL(("     "_LEXT))
 S LEXB=$$SS($G(LEXBUILD)),LEXE=$P(LEXB,"^",2),LEXL=$P(LEXB,"^",3),LEXB=$P(LEXB,"^",1)
 I $P(LEXB,".",1)?7N!($P(LEXB,".",2)?7N)!($P(LEXB,".",3)[":") D
 . D BL
 . I $P(LEXB,".",1)?7N D
 . . S LEXT="" S LEXT="  Started:     "_$$ED($G(LEXB)) D TL(LEXT)
 . I $P(LEXE,".",1)?7N D
 . . S LEXT="" S LEXT="  Finished:    "_$$ED($G(LEXE)) D TL(LEXT)
 . I $L(LEXL) D
 . . S LEXT="" S LEXT="  Elapsed:     "_$$ED($G(LEXL)) D TL(LEXT)
 I $L($G(LEXRES)) D
 . S LEXT="" S LEXT="  Data:        "_$G(LEXRES) D BL,TL(LEXT)
 D BL
 Q
 ;                             
 ; Miscellaneous
UCI(X) ;   UCI where Lexicon is installed
 N LEXU,LEXP,LEXT,Y X ^%ZOSF("UCI") S LEXU=Y,LEXP="" S:LEXU=^%ZOSF("PROD")!($P(LEXU,",",1)=^%ZOSF("PROD")) LEXP=" (Production)"
 S:LEXU'=^%ZOSF("PROD")&($P(LEXU,",",1)'=^%ZOSF("PROD")) LEXP=" (Test)" S X="",$P(X,"^",1)=LEXU,$P(X,"^",2)=LEXP
 Q X
USR(LEX) ;   User/Person
 N LEXDUZ,LEXPH,LEXNM
 S LEX=+($G(DUZ)),LEXNM=$$GET1^DIQ(200,+LEX,.01) Q:'$L(LEXNM) "UNKNOWN^"
 S LEXDUZ=LEX S LEXPH=$$GET1^DIQ(200,+LEXDUZ,.132) S:LEXPH="" LEXPH=$$GET1^DIQ(200,+LEXDUZ,.131)
 S:LEXPH="" LEXPH=$$GET1^DIQ(200,+LEXDUZ,.133) S:LEXPH="" LEXPH=$$GET1^DIQ(200,+LEXDUZ,.134)
 S LEXDUZ=$$GET1^DIQ(200,+LEX,.01),LEX=LEXDUZ_"^"_LEXPH Q LEX
SS(LEX) ;   Start/Stop Times
 N LEXDA,LEXOUT,LEXIENS,LEXB,LEXBUILD,LEXB,LEXE,LEXL
 S LEXBUILD=$G(LEX),LEXD=0 S:$L(LEXBUILD) LEXD=$$DDA(LEXBUILD)
 S LEXDA=+($G(XPDA))
 I +LEXDA>0 D
 . S LEXIENS=LEXDA_"," D GETS^DIQ(9.7,LEXIENS,"11;17","I","LEXOUT")
 . S LEXL=0,LEXB=$G(LEXOUT(9.7,LEXIENS,11,"I"))
 . S:$L($G(LEXSTART))&($P($G(LEXSTART),".",1)?7N) LEXB=$G(LEXSTART)
 . S LEXE=$$NOW^XLFDT S:+LEXB>0&(+LEXE>0) LEXL=$$EP(LEXB,LEXE)
 . S LEX=LEXB_"^"_LEXE S:$L(LEXL) $P(LEX,"^",3)=LEXL
 I +LEXDA=0 D
 . S LEX="" S LEXDA=+($G(LEXD)) S LEXL="",LEXB=$P($G(LEXD),"^",2)
 . S:$L($G(LEXSTART))&($P($G(LEXSTART),".",1)?7N) LEXB=$G(LEXSTART)
 . S LEXE=$$NOW^XLFDT S:+LEXB>0&(+LEXE>0) LEXL=$$EP(LEXB,LEXE)
 . S LEX=LEXB_"^"_LEXE S:$L(LEXL) $P(LEX,"^",3)=LEXL
 Q LEX
DDA(LEX) ;   Get Default DA of Build LEX
 N LEXB,LEXE,LEXOUT,LEXMSG,LEXI S LEXB=$G(LEX) Q:'$L(LEXB) ""
 D FIND^DIC(9.7,,"11I;17I","BP",LEXB,,"B",,,"LEXOUT","LEXMSG")
 S LEXI=+($O(LEXOUT("DILIST"," "),-1))
 S LEXB=$G(LEXOUT("DILIST",+LEXI,0))
 S LEXI=$P(LEXB,"^",1),LEXE=$P(LEXB,"^",4),LEXB=$P(LEXB,"^",3)
 Q:+($G(LEXI))'>0 ""  Q:+($G(LEXB))'>0 ""  S:+LEXE'>0 LEXE=$$NOW^XLFDT
 S LEX=LEXI_"^"_LEXB_"^"_LEXE
 Q LEX
ASOF(LEX) ;   As of date/time
 S X=$$ED($$NOW^XLFDT) Q X
ED(LEX) ;   External Date MM/DD/YYYY TT:TT
 S LEX=$$FMTE^XLFDT($G(LEX),"1Z")
 S:LEX["@" LEX=$P(LEX,"@",1)_"  "_$P(LEX,"@",2,299) Q LEX
 Q LEX
EP(X,Y) ;   Elapsed Time (Begin, End)
 N LEXTIM,LEXBEG,LEXEND
 S LEXBEG=$G(X),LEXEND=$G(Y) Q:+LEXBEG'>0 ""  Q:+LEXEND'>0 ""
 S LEXTIM=$$FMDIFF^XLFDT(LEXEND,LEXBEG,2) Q:+LEXTIM'>0 "00:00:00"
 S LEXTIM=$$TIM(LEXTIM)
 Q LEXTIM
TIM(X) ;   Format Time Elapsed
 N LEXD,LEXH,LEXM,LEXS,LEXT,LEXV S X=+($G(X)) Q:X'>0 "00:00:00"
 S LEXD=X\86400 S LEXV=LEXD*86400 S:+LEXV>0&(LEXV<X) X=X-LEXV
 S LEXH=X\3600 S LEXV=LEXH*3600 S:+LEXV>0&(LEXV<X) X=X-LEXV
 S:$L(LEXH)<2 LEXH="0"_LEXH S:$L(LEXH)<2 LEXH="0"_LEXH
 S LEXM=X\60 S LEXV=LEXM*60 S:+LEXV>0&(LEXV<X) X=X-LEXV
 S:$L(LEXM)<2 LEXM="0"_LEXM S:$L(LEXM)<2 LEXM="0"_LEXM
 S LEXS=X S:$L(LEXS)<2 LEXS="0"_LEXS S:$L(LEXS)<2 LEXS="0"_LEXS
 S LEXT="" S:+LEXD>0 LEXT=+LEXD_" day"_$S(+LEXD>1:"s",1:"")_" "
 S LEXT=LEXT_LEXH_":"_LEXM_":"_LEXS,X=LEXT
 Q X
BL ;   Blank Line
 D TL("") Q
TL(LEXX) ;   Text Line
 S LEXSUB=$G(LEXSUB) S:'$L(LEXSUB) LEXSUB="LEXXII"
 I '$D(^TMP(LEXSUB,$J,1)) S ^TMP(LEXSUB,$J,1)=" ",^TMP(LEXSUB,$J,0)=1
 N LEXNX S LEXNX=$O(^TMP(LEXSUB,$J," "),-1),LEXNX=LEXNX+1
 S ^TMP(LEXSUB,$J,LEXNX)=" "_$G(LEXX),^TMP(LEXSUB,$J,0)=LEXNX
 Q
ST ;   Show Temp Array
 S LEXSUB=$G(LEXSUB) S:'$L(LEXSUB) LEXSUB="LEXXII"
 N LEXN,LEXC S LEXN="^TMP("""_LEXSUB_""","_$J_")",LEXC="^TMP("""_LEXSUB_""","_$J_","
 F  S LEXN=$Q(@LEXN) Q:LEXN=""!(LEXN'[LEXC)  D
 . Q:LEXN[",0)"  W !,@LEXN
 Q
TRIM(X) ;   Trim Spaces
 S X=$G(X) Q:X="" X F  Q:$E(X,1)'=" "  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=" "  S X=$E(X,1,($L(X)-1))
 Q X
