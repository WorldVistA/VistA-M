LEXPL ;ISL/KER - Problem List Survey ;01/03/2011
 ;;2.0;LEXICON UTILITY;**25,73**;Sep 23, 1996;Build 10
 ;
 ; Entry Points
 ;
 ;    EN^LEXPL   Task Survey and Sends Mailman Message to ISC-IRMFO
 ;    SV^LEXPL   Performs Survey (no task) and displays results
 ;
EN ; Tasked Survey
 S ZTRTN="SV^LEXPL",ZTDESC="Problem List Survey",ZTIO="",ZTDTH=$H D ^%ZTLOAD D HOME^%ZIS K %X,%Y,Y,ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN Q
SV ; Operational Survey
 K ^TMP("LEXS",$J) D UD,PLUR,SG,SEND K:'$D(ZTQUEUED) ^TMP("LEXS",$J) S:$D(ZTQUEUED) ZTREQ="@" Q
UD ; UCI/Date
 N %,%H,%I,X,Y X ^%ZOSF("UCI") D SET("Problem List Survey"),BL S X="  UCI:  "_Y
 D:Y=$G(^%ZOSF("PROD")) SET((X_" (Production)")) D:Y'=$G(^%ZOSF("PROD")) SET((X_" (Test)"))
 S X=$$DT Q:X=""  D SET(("  ON:   "_$P(X,"^",1)_" at "_$P(X,"^",2))),BL Q
PLUR ; Survey
 N LEXD,LEXCE,LEXCI,LEXICD,LEXIIC,LEXLC,LEXPE,LEXLI,LEXLU,LEXPU,LEXUC,LEXUI,LEXCU,LEXUU,LEXTMP,X
 S:$D(ZTQUEUED) LEXCE=$$EN2^LEXPLEM,LEXCI=$$EN2^LEXPLIA,LEXCU=$$EN2^LEXPLUP
 S (LEXD,LEXUU,LEXUI,LEXUC,LEXLU,LEXLI,LEXLC,LEXPU)=0
 S LEXPU=+($$CODEN^ICDCODE(799.9)) Q:LEXPU=0
 F  S LEXD=$O(^AUPNPROB(LEXD)) Q:+LEXD=0  D
 . N LEXTMP,LEXIST S LEXICD=+($G(^AUPNPROB(LEXD,0))),LEXPE=+($G(^AUPNPROB(LEXD,1)))
 . S LEXTMP=$$ICDDX^ICDCODE(LEXICD,$G(DT)),LEXIST=+($P(LEXTMP,"^",10)),LEXIIC=$S(LEXIST>0:0,1:1)
 . S:LEXPE>1&(LEXICD=LEXPU) LEXLU=LEXLU+1
 . S:LEXPE=1&(LEXICD=LEXPU) LEXUU=LEXUU+1
 . S:LEXPE=1&(LEXICD'=LEXPU)&(LEXIIC=0) LEXUC=LEXUC+1
 . S:LEXPE>1&(LEXICD'=LEXPU)&(LEXIIC=0) LEXLC=LEXLC+1
 . S:LEXPE=1&(LEXICD'=LEXPU)&(LEXIIC=1) LEXUI=LEXUI+1
 . S:LEXPE>1&(LEXICD'=LEXPU)&(LEXIIC=1) LEXLI=LEXLI+1
 ;
 ; Titles
 ;
 D SET("    "),SET2(""),SET2("Inactive"),SET2("Active")
 D SET("    "),SET2("Uncoded"),SET2("ICD Code"),SET2("ICD Code"),SET2("Total"),BL
 ;
 ; Unresolved
 ;
 D SET("    Unresolved Narratives")
 D SET2(LEXUU) D SET2(LEXUI)
 D SET2(LEXUC) D SET2((LEXUU+LEXUC+LEXUI))
 ;
 ; Lexicon
 ;
 D SET("    Lexicon Terms")
 D SET2(LEXLU) D SET2(LEXLI)
 D SET2(LEXLC) D SET2((LEXLU+LEXLC+LEXLI))
 ;
 ; Total
 ;
 D SET("    ---------------------------------------------------------------------")
 D SET("    Total Problems")
 D SET2(LEXUU+LEXLU),SET2(LEXUI+LEXLI)
 D SET2(LEXUC+LEXLC),SET2((LEXUU+LEXUC+LEXUI+LEXLU+LEXLC+LEXLI))
 ;
 I +($G(LEXCE))>0!(+($G(LEXCI))>0)!(+($G(LEXCU))>0) D
 . D BL N LEXD S LEXCE=+($G(LEXCE)),LEXCI=+($G(LEXCI)),LEXCU=+($G(LEXCU))
 . S LEXD=$L(LEXCE) S:$L(LEXCI)>LEXD LEXD=$L(LEXCI) S:$L(LEXCU)>LEXD LEXD=$L(LEXCU) S LEXD=LEXD+1
 . I LEXCE>0 D SET(($J(LEXCE,LEXD)_" Exact match unresolved narratives resolved to to the Lexicon"))
 . I LEXCI>0 D SET(($J(LEXCI,LEXD)_" Inactive ICD codes/6 digit codes re-coded to an active ICD Code"))
 . I LEXCU>0 D SET(($J(LEXCU,LEXD)_" Uncoded Lexicon terms re-coded to an ICD code other than 799.9"))
 . D BL
 K LEXD,LEXCE,LEXCI,LEXICD,LEXIIC,LEXLC,LEXPE,LEXLI,LEXLU,LEXPU,LEXUC,LEXUI,LEXCU,LEXUU,X
 Q
SG ; Show survey
 Q:$D(ZTQUEUED)  N LEXD S LEXD=0
 F  S LEXD=$O(^TMP("LEXS",$J,LEXD)) Q:+LEXD=0  W !,^TMP("LEXS",$J,LEXD)
 W !! Q
SEND ; Mailman
 N DIFROM,LEXADR Q:'$D(ZTQUEUED)  S LEXADR=$$ADR^LEXU Q:'$L(LEXADR)
 K XMZ S XMSUB="Lexicon/Problem List Survey"
 S XMY(("G.LEXICON@"_LEXADR))=""
 S XMTEXT="^TMP(""LEXS"","_$J_",",XMDUZ=.5
 D ^XMD K ^TMP("LEXS",$J),XCNP,XMDUZ,XMY,XMZ,XMSUB,XMTEXT,XMDUZ
 S:$D(ZTQUEUED) ZTREQ="@" Q
BL ; Blank
 D SET("") Q
SET(X) ; Column 1
 S X=$G(X),^TMP("LEXS",$J,0)=+($G(^TMP("LEXS",$J,0)))+1,^TMP("LEXS",$J,+($G(^TMP("LEXS",$J,0))))=X Q
SET2(X) ; Column X
 S X=$G(X),X=$$L($G(^TMP("LEXS",$J,+($G(^TMP("LEXS",$J,0))))))_"    "_$J(X,8),^TMP("LEXS",$J,+($G(^TMP("LEXS",$J,0))))=X Q
L(X) ; Lengthen text
 F  Q:$L(X)=25!($L(X)>25)  S X=X_" "
 Q X
T(X) ; Trim text
 S X=$G(X) F  Q:$E(X,1)'=" "  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=" "  S X=$E(X,1,($L(X)-1))
 Q X
DT(X) ; Date and time
 N %,%H,%I,X,Y D NOW^%DTC Q:+($G(X))=0 "" S X=$$FMTE^XLFDT(%,"1P") Q:$L(X," ")'=5 "" Q:$P(X," ",4)'[":" "" Q:$P(X," ",5)'["m" ""
 S X=$P(X," ",1,3)_"^"_$P($P(X," ",4),":",1,2)_" "_$P(X," ",5)
 Q X
