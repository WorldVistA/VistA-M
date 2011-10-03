VALMD ;MJK/ALB - List Manager Demo Routine; APR 2, 1992 ;06/26/2006
 ;;1.0;List Manager;**8**;Aug 13, 1993;Build 1
 ;
EN ; -- option entry point
 K XQORS,VALMEVL
 D EN^VALM("VALM DEMO APPLICATION")
ENQ Q
 ;
 ;
INIT ; -- build array
 W ! S DIC("A")="Select Package: ",DIC="^DIC(9.4,",DIC(0)="AEMQ" D ^DIC K DIC
 I Y<0 S VALMQUIT="" G INITQ
PKG ; -- entry pt if package known
 N VALMX,VALMCNTI,VALMPRO,VALMIFN,X,VALMPRE,Z
 S VALMPKG=+Y
 D CLEAN^VALM10
 S (VALMCNTI,VALMCNT)=0,(VALMPRE,VALMPRO)=$P($G(^DIC(9.4,VALMPKG,0)),U,2)
 F  S VALMPRO=$O(^ORD(101,"B",VALMPRO)) Q:$E(VALMPRO,1,$L(VALMPRE))'=VALMPRE  S VALMIFN=0 F  S VALMIFN=$O(^ORD(101,"B",VALMPRO,VALMIFN)) Q:'VALMIFN  I $D(^ORD(101,VALMIFN,0)) S VALMX=^(0) D
 .S VALMCNTI=VALMCNTI+1 W:(VALMCNTI#10)=0 "."
 .S X=$$SETFLD^VALM1(VALMCNTI,"","NUMBER")
 .S X=$$SETFLD^VALM1($P(VALMX,U),X,"NAME")
 .S X=$$SETFLD^VALM1($P(VALMX,U,2),X,"TEXT") K Z S $E(Z,$L(X)+1,240)=""
 .S VALMCNT=VALMCNT+1
 .D SET^VALM10(VALMCNT,$E(X_Z,1,240),VALMCNTI) ; set text
 .S ^TMP("VALMZIDX",$J,VALMCNTI)=VALMCNT_U_VALMIFN
 .D:'(VALMCNT#9) FLDCTRL^VALM10(VALMCNT)     ; defaults for all fields
 .D FLDCTRL^VALM10(VALMCNT,"NUMBER")       ; default for 1 field
 .D:'(VALMCNT#5) FLDCTRL^VALM10(VALMCNT,"NAME",IOUON,IOUOFF) ; adhoc
 D NUL:'VALMCNT
INITQ Q
 ;
HDR ; -- demo header
 N VALMX
 S VALMX=$G(^DIC(9.4,VALMPKG,0)),X="    Package: "_$P(VALMX,U)
 S VALMHDR(1)=$$SETSTR^VALM1("Prefix: "_$P(VALMX,U,2),X,63,15)
 S VALMHDR(2)="Description: "_$E($P(VALMX,U,3),1,65)
 Q
 ;
NUL ; -- set nul message
 I 'VALMCNT D
 .F X=" ","    No protocols to list." S VALMCNT=VALMCNT+1 D SET^VALM10(VALMCNT,X)
 .S ^TMP("VALMZIDX",$J,1)=1,^(2)=2
 Q
 ;
FNL ; -- clean up
 K DIE,DIC,DR,DA,DE,DQ,VALMY,VALMPKG,^TMP("VALMZIDX",$J)
 D CLEAN^VALM10
 Q
 ;
EXP ; -- expand action
 D FULL^VALM1
 N VALMI,VALMAT,VALMY
 D EN^VALM2(XQORNOD(0),"O") S VALMI=0
 F  S VALMI=$O(VALMY(VALMI)) Q:'VALMI  D
 .S VALMAT=$G(^TMP("VALMZIDX",$J,VALMI))
 .W !!,@VALMAR@(+VALMAT,0),!
 .S DA=+$P(VALMAT,U,2),DIC="^ORD(101,",DR="0" D EN^DIQ,PAUSE^VALM1
 S VALMBCK="R",VALMSG="'Expand' was last action picked."
 Q
 ;
EDIT ; -- edit action
 N VALMA,VALMP,VALMI,VALMAT,VALMY
 D MSG^VALM10("'Edit' action...")
 D EN^VALM2(XQORNOD(0),"O") S VALMI=0 ; all the user to "O"ptionally answer
 F  S VALMI=$O(VALMY(VALMI)) Q:'VALMI  D
 .D SELECT^VALM10(VALMI,1) ; -- 'select' line
 .S VALMAT=$G(^TMP("VALMZIDX",$J,VALMI))
 .W !!,@VALMAR@(+VALMAT,0)
 .S DA=+$P(VALMAT,U,2),VALMP=$G(^ORD(101,DA,0)),DIE=101,DR="1" D ^DIE K DIE,DR
 .S VALMA=$G(^ORD(101,DA,0))
 .I $P(VALMP,U,2)'=$P(VALMA,U,2) D UPD($P(VALMA,U,2),"TEXT",.VALMAT)
 .D SELECT^VALM10(VALMI,0) ; -- 'de-select' line
 D MSG^VALM10("")
 S VALMBCK=$S(VALMCC:"",1:"R")
 Q
 ;
DESC ; -- display description action
 N VALMI,VALMY,VALMAT
 D EN^VALM2(XQORNOD(0),"OS") S VALMI=0 ; select only a "S"ingle protocol
 F  S VALMI=$O(VALMY(VALMI)) Q:'VALMI  D
 .S VALMAT=+$P($G(^TMP("VALMZIDX",$J,VALMI)),U,2)
 .I '$D(^ORD(101,VALMAT,1)) W !!,"No Description entered." D PAUSE^VALM1 Q
 .D WP^VALM("^ORD(101,"_VALMAT_",1)",$P($G(^ORD(101,VALMAT,0)),U))
 S VALMBCK="R"
 Q
 ;
UPD(TEXT,FLD,VALMAT) ; -- update data for screen
 D:VALMCC FLDCTRL^VALM10(+VALMAT,.FLD,.IOINHI,.IOINORM,1)
 D FLDTEXT^VALM10(+VALMAT,.FLD,.TEXT)
 Q
 ;
CHG ; -- change package action
 K X I $D(XQORNOD(0)) S X=$P($P(XQORNOD(0),U,4),"=",2)
 I X="" R !!,"Select Package: ",X:DTIME
 S DIC="^DIC(9.4,",DIC(0)="EMQ" D ^DIC K DIC G CHG:X["?"
 I Y<0 D  G CHGQ
 .W !!,*7,"Package has not been changed."
 .W ! S DIR(0)="E" D ^DIR K DIR
 .S VALMBCK=""
 D PKG,HDR S VALMBCK="R" S VALMBG=1
CHGQ Q
