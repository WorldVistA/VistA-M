LEX2073 ;ISL/KER - LEX*2.0*73 Env Check ;01/03/2011
 ;;2.0;LEXICON UTILITY;**73**;Sep 23, 1996;Build 10
 ;               
 ; Global Variables
 ;    ^TMP("LEXKID",$J)   SACC 2.3.2.5.1
 ;    ^TMP("LEXMSG",$J)   SACC 2.3.2.5.1
 ;               
 ; External References
 ;    ^DIC                ICR  10006
 ;    $$GET1^DIQ          ICR   2056
 ;    EN^DIQ1             ICR  10015
 ;    ^XMD                ICR  10070
 ;    $$PATCH^XPDUTL      ICR  10141
 ;    $$VERSION^XPDUTL    ICR  10141
 ;    BMES^XPDUTL         ICR  10141
 ;    MES^XPDUTL          ICR  10141
 ;               
 ; Local Variables NEWed or KILLed Elsewhere
 ;     XPDABORT,XPDDIQ,XPDENV,XPDQUIT
 ;               
ENV ; LEX*2.0*73 Environment Check
 ;   Checks
 N LEXPTYPE,LEXLREV,LEXREQP,LEXBUILD,LEXIGHF,LEXFY,LEXQTR,LEXG,LEXE,LEXSTR D IMP
 K XPDDIQ("XPZ1","B"),XPDDIQ("XPI1","B") S XPDDIQ("XPZ1","B")="NO",XPDDIQ("XPI1","B")="NO"
 S U="^"
 ;     User Variables
 D:+($$UR)'>0 ET("User not defined (DUZ)")
 ;     System Variables
 D:+($$SY)'>0 ET("Undefined IO variable(s)")
 I $D(LEXE) D ABRT Q
 ;     Version Number
 I $$VERSION^XPDUTL("LEX")'="2.0" D  D ABRT Q
 . D ET("Version 2.0 not found.  Please install Lexicon Utility v 2.0")
 ;     Required Patches
 D:'$L($G(LEXREQP)) IMP I $L(LEXREQP) D
 . N LEXPAT,LEXI,LEXPN,LEXP,LEXR,LEXC,LEXO,LEXC1,LEXC2,LEXC3 S (LEXR,LEXC)=0 S LEXC1=5,(LEXC2,LEXC3)=20
 . F LEXI=1:1 Q:'$L($P(LEXREQP,";",LEXI))  S LEXC=LEXC+1,LEXPAT=$P(LEXREQP,";",LEXI) S:$P(LEXPAT,"^",2)?7N LEXR=LEXR+1,LEXC3=LEXC2+13
 . F LEXI=1:1 Q:'$L($P(LEXREQP,";",LEXI))  S LEXPAT=$P(LEXREQP,";",LEXI) D
 . . N LEXREL,LEXINS,LEXINE S LEXREL=$P(LEXPAT,"^",2),LEXPAT=$P(LEXPAT,"^",1)
 . . S LEXPN=$$PATCH^XPDUTL(LEXPAT),LEXINS=$$INS(LEXPAT),LEXINE=$P(LEXINS,"^",2)
 . . W:LEXI=1 !,?3,"Checking for ",?LEXC2,$S(+($G(LEXR))>0:"Released",1:"")
 . . W !,?LEXC1,LEXPAT
 . . I LEXREL?7N W ?LEXC2,$TR($$FMTE^XLFDT(LEXREL,"5DZ"),"@"," ")
 . . I +LEXPN>0 H 1 S LEXO=+($G(LEXO))+1 W ?LEXC3,"Installed " W:$L($G(LEXINE)) LEXINE
 . . I +LEXPN'>0 D ET((" "_LEXPAT_" not found, please install "_LEXPAT_" before continuing"))
 . W:+($G(LEXO))'=LEXC !
 I $D(LEXE) D ABRT Q
 I '$D(LEXFULL)&(+($G(XPDENV))'=1) D QUIT Q
 ;   Quit, Exit or Abort
QUIT ;     Quit   Passed Environment Check
 K LEXFULL D OK
 Q
EXIT ;     Exit   Failed Environment Check
 D:$D(LEXE) ED S XPDQUIT=2 K LEXE,LEXFULL Q
ABRT ;     Abort  Failed Environment Check, KILL the distribution
 D:$D(LEXE) ED S XPDABORT=1,XPDQUIT=1,XPDQUIT("LEX*2.0*73")=1,XPDQUIT("ICD*18.0*40")=1,XPDQUIT("ICPT*6.0*46")=1
 K LEXE,LEXFULL
 Q
SY(X) ;   Check System variables
 Q:'$D(IO)!('$D(IOF))!('$D(IOM))!('$D(ION))!('$D(IOSL))!('$D(IOST)) 0
 Q 1
UR(X) ;   Check User variables
 Q:'$L($G(DUZ(0))) 0
 Q:+($G(DUZ))=0!($$NOTDEF(+$G(DUZ))) 0
 Q 1
ET(X) ;   Error Text
 N LEXI S LEXI=+($G(LEXE(0))),LEXI=LEXI+1,LEXE(LEXI)="    "_$G(X),LEXE(0)=LEXI
 Q
ED ;   Error Display
 N LEXI S LEXI=0 F  S LEXI=$O(LEXE(LEXI)) Q:+LEXI=0  D M(LEXE(LEXI))
 D M(" ") K LEXE Q
NOTDEF(IEN) ;   Check to see if user is defined
 N DA,DR,DIQ,LEX,DIC S DA=IEN,DR=.01,DIC=200,DIQ="LEX" D EN^DIQ1 Q '$D(LEX)
OK ;   Environment is OK
 N LEXPTYPE,LEXLREV,LEXREQP,LEXBUILD,LEXIGHF,LEXFY,LEXQTR,LEXT
 D IMP S LEXT="  Environment "_$S($L(LEXBUILD):("for patch/build "_LEXBUILD_" "),1:"")_"is ok"
 D BM(LEXT),M(" ")
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
ADR(LEX) ;   Mailing Address
 N DIC,DTOUT,DUOUT,X,Y S DIC="^DIC(4.2,",DIC(0)="M",(LEX,X)="FO-SLC.MED.VA.GOV" D ^DIC Q:+Y>0 LEX
 S DIC="^DIC(4.2,",DIC(0)="M",(LEX,X)="ISC-SLC.MED.VA.GOV" D ^DIC Q:+Y>0 LEX
 Q "ISC-SLC.VA.GOV"
KILL ;   Kill all ^TMP(
 K ^TMP("LEXMSG",$J),^TMP("LEXKID",$J)
 Q
INS(X) ;   Installed on
 N DA,LEXDA,LEXE,LEXI,LEXMSG,LEXNS,LEXOUT,LEXPI,LEXPN,LEXSCR,LEXVI,LEXVR S LEXNS=$P(X,"*",1),LEXVR=$P(X,"*",2),LEXPN=$P(X,"*",3)
 Q:'$L(LEXNS) ""  S LEXVR=+LEXVR Q:LEXVR'>0 ""  S LEXPN=+LEXPN Q:+LEXPN'>0 ""  S:LEXVR'["." LEXVR=LEXVR_".0"
 S LEXSCR="I $G(^DIC(9.4,+($G(Y)),""VERSION""))="""_LEXVR_""""
 D FIND^DIC(9.4,,.01,"O",LEXNS,10,"C",LEXSCR,,"LEXOUT","LEXMSG")
 S LEXPI=$G(LEXOUT("DILIST",2,1)) K LEXOUT,LEXMSG Q:+LEXPI'>0 ""  Q:'$D(@("^DIC(9.4,"_LEXPI_",22)")) ""
 K DA S DA(1)=LEXPI S LEXDA=$$IENS^DILF(.DA)
 D FIND^DIC(9.49,LEXDA,.01,"O",LEXVR,10,"B",,,"LEXOUT","LEXMSG")
 S LEXVI=$G(LEXOUT("DILIST",2,1)) K LEXOUT,LEXMSG Q:+LEXVI'>0 ""  Q:'$D(@("^DIC(9.4,"_LEXPI_",22,"_LEXVI_",""PAH"")")) ""
 K DA S DA(2)=LEXPI,DA(1)=LEXVI S LEXDA=$$IENS^DILF(.DA)
 S LEXSCR="I $G(^DIC(9.4,"_LEXPI_",22,"_LEXVI_",""PAH"",+($G(Y)),0))[""SEQ #"""
 D FIND^DIC(9.4901,LEXDA,".01;.02I",,LEXPN,10,"B",LEXSCR,,"LEXOUT","LEXMSG")
 S LEXI=$G(LEXOUT("DILIST","ID",1,.02)) Q:'$L(LEXI) ""  Q:$P(LEXI,".",1)'?7N ""
 S LEXE=$TR($$FMTE^XLFDT(LEXI,"5DZ"),"@"," ") Q:'$L(LEXE) ""  S X=LEXI_"^"_LEXE
 Q X
BM(X) ;   Blank Line with Message
 D BMES^XPDUTL($G(X)) Q
M(X) ;   Message
 D MES^XPDUTL($G(X)) Q
TRIM(X) ;   Trim Spaces
 S X=$G(X) F  Q:$E(X,1)'=" "  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=" "  S X=$E(X,1,($L(X)-1))
 Q X
IMP ;   Import names
 S LEXPTYPE="Code Set Field Deletions",LEXLREV="73"
 ;S LEXREL=3101006
 S LEXREQP="LEX*2.0*72^3101006"
 S LEXBUILD="LEX*2.0*73",LEXIGHF="",LEXFY="",LEXQTR=""
 Q
