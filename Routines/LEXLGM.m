LEXLGM ; ISL Lexicon Survey (Post Inst/Oper)     ; 05/14/2003
 ;;2.0;LEXICON UTILITY;**25**;Sep 23, 1996
 ;
EN ; Operational Task
 K ^TMP("LEXMSG")
 S ZTRTN="OPR^LEXLGM",ZTDESC="Lexicon Terms in Problem List",ZTIO="",ZTDTH=$H
 D ^%ZTLOAD,HOME^%ZIS K %X,%Y,Y,ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN Q
 Q
EN2 ; Post-Install Task
 K ^TMP("LEXMSG")
 S ZTRTN="POST^LEXLGM",ZTDESC="Lexicon Installation",ZTIO="",ZTDTH=$H
 D ^%ZTLOAD,HOME^%ZIS K %X,%Y,Y,ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN Q
 Q
OPR ; Operational Survey
 K ^TMP("LEXMSG") N LEXTYPE S LEXTYPE="O"
 N LEXQ,LEXVERS,LEXFI,LEXDT,LEXS
 D DATE S:'$D(LEXDT) LEXDT="" S LEXVERS=$$VR
 D PLT^LEXLGM3,ASOF^LEXLGM3,PLUR^LEXLGM3,SG,SEND
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
POST ; Post-Install Survey
 K ^TMP("LEXMSG") N LEXTYPE,LEXQ,LEXVERS,LEXFI,LEXDT,LEXS
 S LEXTYPE="P" D DATE S:'$D(LEXDT) LEXDT="" S LEXVERS=$$VR
 D TITLE,INIT D:+LEXVERS>1 INST,ACCT,WHO D:+LEXVERS'>1 ATTPT,ACCT,WHO
 D BL,POST^LEXLGM2,PLUR^LEXLGM3,VER,SG,SEND
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
SG ; Show TMP Global
 N LEXI S LEXI=0 F  S LEXI=$O(^TMP("LEXMSG",LEXI)) Q:+LEXI=0  W:'$D(ZTQUEUED) !,^TMP("LEXMSG",LEXI)
 Q
SEND ; Create message to send to ISC-SLC
 N LEXADR,DIFROM Q:'$D(ZTQUEUED)  Q:'$L($G(LEXTYPE))  S LEXADR=$$ADR^LEXU Q:'$L(LEXADR)
 N LEXT S LEXT=$G(LEXTYPE) Q:"OP"'[LEXT
 K XMZ S:LEXT="P" XMSUB="Lexicon Installation" S:LEXT="O" XMSUB="Lexicon/Problem List Survey"
 S XMY(("G.LEXICON@"_LEXADR))=""
 S XMTEXT="^TMP(""LEXMSG"",",XMDUZ=.5 D ^XMD
 K ^TMP("LEXMSG"),XCNP,XMDUZ,XMY,XMZ,XMSUB,XMTEXT,XMDUZ,LEXT
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
TITLE N LEXS,LEXVERS S LEXS="Lexicon Installation"
 S LEXVERS=$P($G(^DD(757.01,0,"VR")),"^",1)
 S:+LEXVERS>1 LEXS=LEXS_" v"_LEXVERS D SET($G(LEXS)) Q
VER ; Verify
 I +($G(LEXQ))>0 D  Q
 . D BL S LEXS="Lexicon v 2.0 not completely installed"
 . S LEXQ=1 D SET($G(LEXS))
 D BL S LEXS="Lexicon v 2.0 installed" D SET($G(LEXS))
 Q
VR(LEXX) ; Version
 S LEXX=$P($G(^DD(757.01,0,"VR")),"^",1) Q LEXX
INIT ; Init/Install
 N LEXS,LEXR,LEX1,LEX2,LEX4 I $L($T(+2^LEXLGM))>2 D
 . S LEX1=$T(+2^LEXLGM)
 . S LEX1=$P(LEX1,";",3),LEXR="^DD(",LEX4=1
 . S LEX2="Lexicon Utility"
 . D BL S LEXS="    Installing Version:" D SET($G(LEXS))
 . S LEXS="    "_LEX1 D SET2($G(LEXS))
 Q
INST ; Installed on
 N LEXS
 I LEXDT'="" D  Q
 . S LEXS="    Installed on:" D SET($G(LEXS))
 . S LEXS="    "_LEXDT D SET2($G(LEXS))
 D:$L($G(LEXS)) SET($G(LEXS)) Q
ATTPT ; Attempted install on
 N LEXS I $G(LEXDT)'="" D
 . S LEXS="    Installation Attempted on:" D SET($G(LEXS))
 . S LEXS=LEXDT D SET2($G(LEXS))
 Q
ACCT ; Account
 N LEXS,LEXA X ^%ZOSF("UCI") S LEXA=Y
 S:Y=^%ZOSF("PROD") LEXA=LEXA_" (Production)"
 S:Y'=^%ZOSF("PROD") LEXA=LEXA_" (Test)"
 S LEXS="    Installation in account:" D SET($G(LEXS))
 S LEXS="    "_LEXA D SET2($G(LEXS))
 Q
WHO ; Installed by
 N LEXDUZ,LEXPH S LEXDUZ=+($G(DUZ)) I +LEXDUZ<1 S LEXDUZ="UNKNOWN",LEXPH="" G W2
 I '$D(^VA(200,LEXDUZ)) S LEXDUZ="UNKNOWN",LEXPH="" G W2
 S LEXPH=$P($G(^VA(200,LEXDUZ,.13)),"^",2)
 S:LEXPH="" LEXPH=$P($G(^VA(200,LEXDUZ,.13)),"^",1)
 S:LEXPH="" LEXPH=$P($G(^VA(200,LEXDUZ,.13)),"^",3)
 S:LEXPH="" LEXPH=$P($G(^VA(200,LEXDUZ,.13)),"^",4)
 S LEXDUZ=$P(^VA(200,LEXDUZ,0),"^",1) S:LEXDUZ="" LEXDUZ="UNKNOWN"
W2 S LEXS="    Installation by (POC):" D SET($G(LEXS))
 S LEXS="    "_LEXDUZ S:LEXPH'="" LEXS=LEXS_"  ("_LEXPH_")"
 D SET2($G(LEXS))
 Q
BL ; Blank Line
 D SET("") Q
SET(X) ; Set text in ^TMP (col 1)
 S X=$G(X) N LEXLC S LEXLC=+($G(^TMP("LEXMSG",0))),LEXLC=LEXLC+1
 S ^TMP("LEXMSG",0)=LEXLC,^TMP("LEXMSG",LEXLC)=X
 Q
SET2(X) ; Set text in ^TMP (col 2)
 S X=$G(X) N LEXL,LEXLC,LEX1 S LEXL=32
 S LEXLC=+($G(^TMP("LEXMSG",0))),LEX1=$G(^TMP("LEXMSG",LEXLC))
 F  Q:$L(LEX1)=LEXL!($L(LEX1)>LEXL)  S LEX1=LEX1_" "
 S X=$$TRIM(X),^TMP("LEXMSG",LEXLC)=LEX1_"  "_X
 Q
TRIM(X) ; Remove spaces from text
 S X=$G(X) F  Q:$E(X,1)'=" "  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=" "  S X=$E(X,1,($L(X)-1))
 Q X
DATE ; Installation Date and Time
 N %,%H,X,LEXP,LEXMO,LEXDA,LEXYR,LEXHR,LEXMN,LEXSC D NOW^%DTC Q:+($G(%))=0
 N LEXP,LEXMO,LEXDA,LEXYR,LEXHR,LEXMN,LEXSC S LEXYR=1700+($E(%,1,3)),LEXP=+($E(%,4,5)),LEXDA=+($E(%,6,7)),LEXHR=$E($P(%,".",2),1,2),LEXMN=$E($P(%,".",2),3,4),LEXSC=$E($P(%,".",2),5,6)
 S LEXMO=$S(+LEXP=1:"January",+LEXP=2:"February",+LEXP=3:"March",+LEXP=4:"April",+LEXP=5:"May",+LEXP=6:"June",+LEXP=7:"July",+LEXP=8:"August",+LEXP=9:"September",+LEXP=10:"October",+LEXP=11:"November",+LEXP=12:"December",1:"")
 S:$L(LEXSC)=1 LEXSC=LEXSC_"0" I LEXMO'="" S LEXDT=LEXMO_" "_LEXDA_", "_LEXYR_" at "_LEXHR_":"_LEXMN_":"_LEXSC
 Q
