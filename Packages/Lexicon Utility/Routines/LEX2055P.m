LEX2055P ;ISL/KER - LEX*2.0*55 Pre/Post Install ;11/30/2008
 ;;2.0;LEXICON UTILITY;**55**;Sep 23, 1996;Build 11
 ;               
 ; Integration Control Registrations/Standards and Conventions
 ;               
 ;    ^LEX(757            N/A  Major Concept Map
 ;    ^LEX(757.001)       N/A  Concept Usage
 ;    ^LEX(757.01         N/A  Expressions
 ;    ^LEX(757.02)        N/A  Codes
 ;    ^LEX(757.03)        N/A  Coding System
 ;    ^LEX(757.1)         N/A  Semantic Map
 ;    ^LEX(757.11)        N/A  Semantic Class
 ;    ^LEX(757.12)        N/A  Semantic Type
 ;    ^LEX(757.13)        N/A  Source Categories
 ;    ^LEX(757.14)        N/A  Source
 ;    ^LEXT(757.2)        N/A  Subset Definition
 ;               
 ;    ^TMP(               SACC 2.3.2.5.1
 ;    ^%ZOSF("TEST")      ICR  10096
 ;    ^%ZOSF("DEL")       ICR  10096
 ;    ^DIK                ICR  10013
 ;    IX1^DIK             ICR  10013
 ;    $$GET1^DIQ          ICR   2056
 ;    $$DT^XLFDT          ICR  10103
 ;    $$NOW^XLFDT         ICR  10103
 ;    $$FMTE^XLFDT        ICR  10103
 ;    $$DTIME^XUP         ICR   4490
 ;    MES^XPDUTL          ICR  10141
 ;    HOME^%ZIS           ICR  10086
 ;               
 ; Local Variables NEWed or KILLed Elsewhere
 ;     DT,DTIME,DUZ,U,XPDABORT,XPDQUIT
 ;            
ENV ;   Environment Check
 N LEXREQP,LEXPAT,LEXI,LEXPN,LEXBUILD S LEXPAT="LEX*2.0*56",LEXBUILD="LEX*2.0*55"
 S LEXPN=$$PATCH^XPDUTL(LEXPAT) W !,"    Checking for ",LEXPAT I +LEXPN>0 H 1 W " - installed"
 I +LEXPN'>0 D ET(" "),ET((LEXPAT_" not found, please install "_LEXPAT_" before continuing"))
 I $D(LEXE) D ABRT Q
 Q
POK(X) ;   Patch is OK
 N LEXPAT S LEXPAT=$G(X) Q:'$L(LEXPAT) 1
 S X=+($$PATCH^XPDUTL(LEXPAT))
 Q X
ET(X) ;   Error Text
 N LEXI S LEXI=+($G(LEXE(0))),LEXI=LEXI+1,LEXE(LEXI)="    "_$G(X),LEXE(0)=LEXI
 Q
ED ;   Error Display
 N LEXI S LEXI=0 F  S LEXI=$O(LEXE(LEXI)) Q:+LEXI=0  D MES^XPDUTL(LEXE(LEXI))
 D MES^XPDUTL(" ") K LEXE
 Q
QUIT ;     Quit   Passed Environment Check
 K LEXFULL D OK
 Q
EXIT ;     Exit   Failed Environment Check
 D:$D(LEXE) ED S XPDQUIT=2 K LEXE,LEXFULL Q
ABRT ;     Abort  Failed Environment Check, KILL the distribution
 D:$D(LEXE) ED S XPDABORT=1,XPDQUIT=1,XPDQUIT("LEX*2.0*55")=1
 K LEXE,LEXFULL
 Q
OK ;   Environment is OK
 N LEXT S LEXT="  Environment "_$S($L(LEXBUILD):("for patch/build "_LEXBUILD_" "),1:"")_"is ok"
 D BMES^XPDUTL(LEXT),MES^XPDUTL(" ")
 Q
POST ; LEX*2.0*55 Post-Install
 N ENV,EXC,LEXBEG,LEXBLD,LEXBUILD,LEXELP,LEXEND,LEXFC,LEXI,LEXID,LEXMOD,LEXMUL,LEXNM,LEXPOST,LEXRTN
 N LEXSHORT,LEXSUB,LEXT,LEXTCS,LEXTND,X,ZTQUEUED,ZTREQ
 S ENV=$$SET Q:'ENV  S LEXBEG=$$NOW^XLFDT
 K ^TMP("LEXCS",$J),^TMP("LEXCNT",$J),^TMP("LEXI",$J),^TMP("LEXMSG",$J),^TMP("LEXINS",$J),^TMP("LEXKID",$J)
 D INST I $D(^%ZOSF("DEL")) F LEXRTN="LEX2055A","LEX2055B","LEX2055C","LEX2055D","LEX2055E","LEX2055F","LEX2055G","LEX2055H","LEX2055I" D
 . N EXC,X,Y I +($$ROK(LEXRTN))>0 S (EXC,X)=$G(^%ZOSF("DEL")) D ^DIM I $D(X) S X=LEXRTN X EXC
 S LEXSHORT=1,(LEXID,LEXSUB)="LEXKID",(LEXBUILD,LEXBLD)="LEX*2.0*55",LEXPOST=1
 S LEXEND=$$NOW^XLFDT,LEXELP=$$EP^LEXXII(LEXBEG,LEXEND)
 D MSG
 Q
MSG ;   Send a Install Message
 S:$D(ZTQUEUED) ZTREQ="@"  N LEXFC,LEXMOD,LEXMUL,LEXTCS,LEXTND,ZTQUEUED,LEXT,LEXI S LEXMUL=1,(LEXTND,LEXTCS,LEXMOD,LEXFC,ZTQUEUED)=0
 D HDR^LEXXFI,EN^LEXXII I $L($G(LEXID)) S LEXI=0 F  S LEXI=$O(^TMP(LEXID,$J,LEXI)) Q:+LEXI'>0  D
 . S:$G(^TMP(LEXID,$J,LEXI))=" Lexicon/ICD/CPT Installation" ^TMP(LEXID,$J,LEXI)=" BI-RADS Mammography Assessment Code Set",^TMP(LEXID,$J,(LEXI+1))=" ======================================="
 I $G(LEXBEG)?7N1".".N S LEXT="" S LEXT="  Started:     "_$TR($$FMTE^XLFDT($G(LEXBEG),"1Z"),"@"," ") D TL^LEXXII(LEXT)
 I $G(LEXEND)?7N1".".N S LEXT="" S LEXT="  Finished:    "_$TR($$FMTE^XLFDT($G(LEXEND),"1Z"),"@"," ") D TL^LEXXII(LEXT)
 I $G(LEXBEG)?7N1".".N!$G(LEXEND)?7N1".".N!($L($G(LEXELP))&($G(LEXELP)[":")) S LEXT="" S LEXT="  Elapsed:     "_$$ED^LEXXII($G(LEXELP)) D TL^LEXXII(LEXT),BL^LEXXII
 D MAIL^LEXXFI,KILL^LEXXFI
 Q
INST ; Install Patch LEX*2.0*55
 D:+($$ROK("LEX2055A"))>0 INST^LEX2055A D CON
 Q
ROK(X) ; Routine OK
 S X=$G(X) Q:'$L(X) 0  Q:$L(X)>8 0  X ^%ZOSF("TEST") Q:$T 1
 Q 0
CON ; Data Convversion
 N LEX55W S LEX55W="BARRES~" F  S LEX55W=$O(^LEX(757.01,"AWRD",LEX55W)) Q:'$L(LEX55W)  Q:LEX55W'["BARRET"  D
 . N LEX55C S LEX55C=0 F  S LEX55C=$O(^LEX(757.01,"AWRD",LEX55W,LEX55C)) Q:+LEX55C'>0  D
 . . N LEX55E S LEX55E=0 F  S LEX55E=$O(^LEX(757.01,"AWRD",LEX55W,LEX55C,LEX55E)) Q:+LEX55E'>0  D
 . . . N DA,DIK S DA=LEX55E,DIK="^LEX(757.01," D IX1^DIK
 Q
SET(X) ; Setup Environment
 D HOME^%ZIS S U="^",DT=$$DT^XLFDT,LEXNM=$$GET1^DIQ(200,+($G(DUZ)),.01),DTIME=$$DTIME^XUP(+($G(DUZ))) Q:+($G(DUZ))'>0!('$L(LEXNM)) 0
 Q 1
