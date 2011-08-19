IBDFUTL ;ALB/MAF - Maintenance Utility Routine - APR 20 1995
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**9,32,51**;APR 24, 1997
 ;
 ;  -- Set up variables for display by clinic/form/group
OUT S IBDFL=0  ;W !!,"Display output by: CLINICS// " D ZSET1 S X="" R X:DTIME G QUIT:X="^"!('$T) I X=""!("Cc"[X) S X="1"
 S DIR("B")="CLINICS",DIR(0)="SBM^C:CLINICS (Individual);G:GROUPS (Clinics);F:FORMS",DIR("A")="Sort by [C]linics, [G]roups, [F]orms" D ^DIR
 K DIR I $D(DIRUT)&('$D(IBDF1))!(Y<0) G EXIT
 I $D(DIRUT)&$D(IBDF1) G QUIT
 S X=$S("Gg"[X:2,"Ff"[X:3,"Ss"[X:4,1:1)
 ;I X="?" D ZSET1,HELP1 G OUT
 S IBDFSRT=$E(X)  ;D IN^DGHELP W ! I %=-1 D ZSET1,HELP1 G OUT
 S IBDFDIS=$S(IBDFSRT=1:"CLIN",IBDFSRT=2:"GROUP",IBDFSRT=3:"FORM",1:"QUIT")
 D @(IBDFDIS) S:Y=-1 IBDFNCNG=1 G:Y=-1 QUIT
 ;
 ;
OUT1 ;  -- Ask for what type of package interface
 S DIC="^IBE(357.6,",DIC(0)="AEMN"
 S DIC("S")="I $P(^(0),U,6)=3,$P(^(0),U,9)=1,$G(^(11))'="""""
 S DIC("A")="Select Type of Code to Display: " D ^DIC K DIC G QUIT:Y<0
 S IBDFINT=+Y
 ;
 S IBDFACT=2 ;default of Inactive
 S X=$E($G(^IBE(357.6,IBDFINT,11)),7,9)
 ;
 ; -- for cpt and icd codes, let them choose active or inactive
 I X="CPT"!(X="VST")!(X="ICD") D
 .S DIR("B")="ACTIVE"
 .S DIR(0)="SBM^A:ACTIVE;I:INACTIVE"
 .S DIR("A")="Display codes [A]ctive, [I]nactive"
 .D ^DIR K DIR
 .Q:$D(DIRUT)
 .S X=$S("Ii"[$E(X,1):2,1:1)
 .S IBDFACT=$E(X)
 I $D(DIRUT)&('$D(IBDF1))!(Y<0) G EXIT
 I $D(DIRUT)&$D(IBDF1) G QUIT
 ;
 I $D(IBDF1) D
 .K VAUTP F IBI=0:0 S IBI=$O(VAUTJ(IBI)) Q:IBI']""  S VAUTP(IBI)=$G(VAUTJ(IBI))
 I IBDFACT=1 D
 .;;I $E($G(^IBE(357.6,IBDFINT,11)),7,9)="CPT" S DIC="^ICPT(",IBDFCODE="CPT "
 .;;I $E($G(^IBE(357.6,IBDFINT,11)),7,9)="ICD" S DIC="^ICD9(",IBDFCODE="ICD-9 "
 .;;I $E($G(^IBE(357.6,IBDFINT,11)),7,9)="VST" S DIC="^IBE(357.69,",IBDFCODE="Type of Visit "
 .;
 .I $E($G(^IBE(357.6,IBDFINT,11)),7,9)="CPT" S DIC="^ICPT(",IBDFCODE="CPT ",DIC("S")="I $P($$CPT^ICPTCOD(Y),U,7)=1"
 .;
 .I $E($G(^IBE(357.6,IBDFINT,11)),7,9)="ICD" S DIC="^ICD9(",IBDFCODE="ICD-9 ",DIC("S")="I $P($$ICDDX^ICDCODE(Y),U,10)=1"
 .;
 .I $E($G(^IBE(357.6,IBDFINT,11)),7,9)="VST" S DIC="^IBE(357.69,",IBDFCODE="Type of Visit ",DIC("S")="I $P($$CPT^ICPTCOD(Y),U,7)=1"
 .;
 .I $G(DIC)]"" S VAUTVB="VAUTJ",VAUTNI=2,VAUTSTR=IBDFCODE_"code" S VAUTNALL=1 D FIRST^VAUTOMA
 ;
 I (Y<0)&$D(IBDF1) D  K VAUTP G QUIT
 .F IBI=0:0 S IBI=$O(VAUTP(IBI)) Q:IBI']""  S VAUTJ(IBI)=$G(VAUTP(IBI))
 I IBDFACT=1,Y<0,'$D(IBDF1) G EXIT
 ;
 I '$D(IBDF1) K XQORS,VALMEVL  D EN^VALM("IBDF UTIL PRIMARY SCREEN")
 I $D(IBDF1) D HDR,KILL,INIT S VALMBCK="R",VALMBG=1
 Q
 ;
HDR ; -- header code
 I IBDFACT=1 D
 .S VALMHDR(1)="This screen lists Active codes on Encounter Forms."
 I IBDFACT'=1 D
 .S VALMHDR(1)="This screen lists Inactive codes on  Encounter Forms."
 Q
 ;
 ;  -- Set up list
INIT D FULL^VALM1 S (IBDCNT,IBDCNT1,VALMCNT)=0
 K ^TMP("CPT",$J),^TMP("CPTIDX",$J) D KILL^VALM10()
 S IBDFCNT1=0 D @(IBDFDIS_"1^IBDFUTL1")
 I '$D(^TMP("CPT",$J)) D NUL
 Q
 ;
 ;  -- Ask for clinics one/many/all
CLIN S VAUTVB="VAUTC",DIC="^SC(",DIC("S")="I $P(^(0),U,3)=""C""",VAUTSTR="Clinic",VAUTNI=2 D FIRST^VAUTOMA K DIC S:Y=-1 IBDFL=1 Q:IBDFL
 Q
 ;
 ;  -- Ask for forms one/many/all
FORM S VAUTVB="VAUTF",DIC="^IBE(357,",VAUTSTR="Form",VAUTNI=2 D FIRST^VAUTOMA S:Y=-1 IBDFL=1 Q:IBDFL
 Q
 ;
 ;  -- Ask for clinic groups one/many/all
GROUP S VAUTVB="VAUTG",DIC="^IBD(357.99,",VAUTSTR="Clinic Group",VAUTNI=2 D FIRST^VAUTOMA S:Y=-1 IBDFL=1 Q:IBDFL
 Q
 ;
 ; -- Ask for divisions one/many/all
DIV S IBDFL=0 D DIVISION^VAUTOMA
 S:Y=-1 IBDFL=1 Q:IBDFL
 Q
 ;  -- Help for display choices
HELP1 W !!,"Choose a number or first initial :" F K=2:1:4 W !?15,$P(Z,"^",K)
 W ! Q
 ;
 ;  -- Listing of selections
ZSET1 S Z="^1 [C]LINICS (Individual)^2 [G]ROUPS (CLINIC)^3 [F]ORMS^" Q
 ;
 ;
QUIT ;  -- Kill variables and reset to last display if no change has been taken place.
 I $D(IBDF1) S IBDFDIS=IBDFDIS1,IBDFINT=IBDFINT1,IBDFACT=IBDFACT1
 I '$D(IBDF1) G EXIT
 D KILL,INIT K IBDFNCNG S VALMBCK="R",VALMBG=1
 Q
 ;
 ;
KILL ;  -- Kill extra array variables
 N IBDFXX
 S IBDFXX=$S(IBDFDIS="FORM":"VAUTF",IBDFDIS="GROUP":"VAUTG",1:"VAUTC")
 I IBDFXX="VAUTF" K VAUTG,VAUTC,^TMP("CLN",$J),^TMP("CLN1",$J),^TMP("GRP",$J),^TMP("GRP1",$J)
 I IBDFXX="VAUTC" K VAUTG,VAUTF,^TMP("FRM",$J),^TMP("FRM1",$J),^TMP("GRP1",$J)
 I IBDFXX="VAUTG" K VAUTC,VAUTF,^TMP("FRM",$J),^TMP("FRM1",$J),^TMP("CLN",$J),^TMP("CLN1",$J)
 Q
 ;
 ;
EXIT ;  -- Code executed at action exit
 K IBDFDIS,IBDFINT,VAUTC,VAUTF,VAUTG,VAUTJ,VAUTP,IBDFINT1,IBDFDIS1,^TMP("CLN",$J),IBDFCODE,IBI,IBDFACT1
EXIT1 K DIC,IBDBLK,IBDCLN,IBDCLNM,IBDCNODE,IBDCNT,IBDCNT1,IBDF,IBDFBK,IBDFCIFN,IBDFCLIN,IBDFL,IBDFLG,IBDFN,IBDFNAME,IBDFNM,IBDFNODE,IBDFORM1,IBDFRM,IBDFSEL,IBDFSRT,IBDFTMP,IBDFVAL
 K IBDFX,IBDORM,IBDVAL,IBDVAL1,IBDFCNT1,Z,IBDFRNM,IBDFX1,IBDFX2,IBDFX3
 K IBCLN,IBDFCLN,IBDFCLNM,IBDFDIV,IBDFGIFN,IBDFGN,IBDFGNM,IBDIV,IBDNAM,IBDNAME,IEN,^TMP("IBDF",$J),^TMP("UTIL",$J),^TMP("CPT",$J),^TMP("CPTIDX",$J),DIVISION,IBDF,IBDFACT,VAUTNALL Q
 ;
 ;
HLP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
 ;
EXP ; -- expand code
 Q
NUL ; -- NULL MESSAGE
 S ^TMP("CPT",$J,1,0)=" ",^TMP("CPT",$J,2,0)="There are no "_$S(IBDFACT=1:"active",1:"inactive")_" codes on any forms.",^TMP("CPTIDX",$J,1)=1,^TMP("CPTIDX",$J,2)=2
 Q
