IBDFUTL ;ALB/MAF - Maintenance Utility Routine ;04/20/95
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**9,32,51,63,70**;APR 24, 1997;Build 46
 ;
 ;ICRs 
 ; Reference to LS^ICDEX supported by ICR #5747
 ; Reference to CSI^ICDEX supported by ICR #5747
 ;
EN ;IBD*3.0*70 - New Maintenance Utility Option Entry Point
 ;Check if ^XTMP global exists. If so, Give user the option to use the last report or run a new one
 N IBDLR,IBDFDIS,IBDFINT,IBDDUZ,IBDN,IBDIA,IBDST,IBDFACT,IBDSTR,IBDAI,IBDF
 L +^XTMP("IBDRPT"):$G(DILOCKTM,5) I '$T W !!,"The Maintenance Utility is locked by another user or currently running in the background. Please try again later.",! Q
 I '$D(^XTMP("IBDRPT",0))!('$D(^XTMP("IBDRPT",1)))!('$D(^XTMP("IBDRPT",2))) W !,"The Maintenance Utility must be run." D OUT Q
 S IBDLR=$P($G(^XTMP("IBDRPT",0)),U,2) I IBDLR D
 .S IBDFDIS=$P(^XTMP("IBDRPT",1),U,2),IBDFINT=$P(^XTMP("IBDRPT",1),U,3),IBDAI=$P(^IBE(357.6,IBDFINT,0),U),IBDDUZ=$P(^XTMP("IBDRPT",1),U),IBDN=$S(^XTMP("IBDRPT",2):"all",1:"select")
 .S IBDIA=$S($P(^XTMP("IBDRPT",1),U,4)=1:"ACTIVE",$P(^XTMP("IBDRPT",1),U,4)=2:"INACTIVE",1:"")
 .W ! F IBDSTR=1:1:80 W "*"
 .W !,"The current report on file was run by ",$$GET1^DIQ(200,IBDDUZ,.01)," on ",$$FMTE^XLFDT(IBDLR),"."
 .W !,"It is for ",IBDAI," and sorted by ",$S(IBDFDIS="CLIN":"CLINIC",1:IBDFDIS)
 .W !,"The report contains ",IBDIA," codes."
 .W:IBDN'="" !,"The report is for ",$S(IBDN="all":"all "_$S(IBDFDIS="CLIN":"CLINIC",1:IBDFDIS)_"S.",1:"the following "_$S(IBDFDIS="CLIN":"CLINIC",1:IBDFDIS)_"S.") I IBDN'="all" D
 ..S IBDST=0 F  S IBDST=$O(^XTMP("IBDRPT",2,IBDST)) Q:'IBDST  W !,^XTMP("IBDRPT",2,IBDST)
 .W ! F IBDSTR=1:1:80 W "*"
 .S DIR(0)="Y",DIR("A")="Would you like to view this report",DIR("B")="Yes" D ^DIR I Y K XQORS,VALMEVL D SETIBDF(.IBDF) S IBDFACT=$P(^XTMP("IBDRPT",1),U,4) D SETSRT(IBDFDIS) D EN^VALM("IBDF UTIL PRIMARY SCREEN") Q
 .Q:$D(DIRUT)  S DIR(0)="Y",DIR("A")="This will delete the current report and run a new one. Are you sure" D ^DIR I Y D OUT Q
 .W !,"The Maintenance Utility will not be run." Q
 Q
 ;
 ;  -- Set up variables for display by clinic/form/group
OUT S IBDFL=0  ;W !!,"Display output by: CLINICS// " D ZSET1 S X="" R X:DTIME G QUIT:X="^"!('$T) I X=""!("Cc"[X) S X="1"
 S DIR("B")="CLINICS"
 ;S DIR(0)="SBM^C:CLINICS (Individual);G:GROUPS (Clinics);F:FORMS"
 S DIR(0)="SA^C:CLINICS (Individual);G:GROUPS (Clinics);F:FORMS"
 S DIR("A")="Sort by [C]linics, [G]roups, [F]orms: " D ^DIR
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
 N IBDTEMPY,IBDQUIT,IBDFINT,IBDCOUNT,IBDAUTO,IBDX,IBDQUI2,ZTRTN,ZTDESC,ZTSAVE,IBDQUE
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
 .;S DIR(0)="SBM^A:ACTIVE;I:INACTIVE"
 .S DIR(0)="SA^A:ACTIVE;I:INACTIVE"
 .S DIR("A")="Display codes [A]ctive, [I]nactive: "
 .D ^DIR K DIR
 .Q:$D(DIRUT)
 .S X=$S("Ii"[$E(X,1):2,1:1)
 .S IBDFACT=$E(X)
 I $D(DIRUT)&('$D(IBDF1))!(Y<0) G EXIT
 I $D(DIRUT)&$D(IBDF1) G QUIT
 ;IBD*3.0*70 - set up XTMP global with Report Info
 K ^XTMP("IBDRPT"),^XTMP("CPTIDX"),^XTMP("IBDCPT"),^XTMP("IBDF")
 S ^XTMP("IBDRPT",0)=$$FMADD^XLFDT(DT,30)_U_DT_U_"Maintenance utility rpt global",^XTMP("IBDRPT",1)=DUZ_U_IBDFDIS_U_IBDFINT_U_IBDFACT
 S ^XTMP("CPTIDX",0)=$$FMADD^XLFDT(DT,30)_U_DT_U_"Maintenance utility CPTIDX global"
 S ^XTMP("IBDCPT",0)=$$FMADD^XLFDT(DT,30)_U_DT_U_"Maintenance utility IBDCPT global"
 S ^XTMP("IBDF",0)=$$FMADD^XLFDT(DT,30)_U_DT_U_"Maintenance utility IBDF global"
 S IBDTYP=$S($D(VAUTC):"VAUTC",$D(VAUTF):"VAUTF",$D(VAUTG):"VAUTG",1:"") S ^XTMP("IBDRPT",2)=@IBDTYP I ^XTMP("IBDRPT",2)=0 M ^XTMP("IBDRPT",2)=@IBDTYP
 ;cannot use this option before ICD-10 impelemenation 
 ;
 I $E($G(^IBE(357.6,IBDFINT,11)),7,9)="ICD",DT<$$IMPDATE^IBDUTICD(30),$$GETCODSY(IBDFINT)["ICD-10",IBDFACT=1 D  G:IBDQUI2<0 EXIT S:IBDQUI2="I" IBDFACT=2
 . F  D  Q:IBDQUI2'="A"
 .. W !!,"ICD-10 codes cannot be selected for this option before ICD-10 activation.",!
 .. S DIR(0)="FAO",DIR("A")="Press RETURN to continue..." D ^DIR K DIR
 .. S IBDQUI2=$$ACTPRMT^IBDUTICD()
 ;
 I $D(IBDF1) D
 .K VAUTP F IBI=0:0 S IBI=$O(VAUTJ(IBI)) Q:IBI']""  S VAUTP(IBI)=$G(VAUTJ(IBI))
 ;
 ;
 ;
 I IBDFACT=1 D
 .;;I $E($G(^IBE(357.6,IBDFINT,11)),7,9)="CPT" S DIC="^ICPT(",IBDFCODE="CPT "
 .;;I $E($G(^IBE(357.6,IBDFINT,11)),7,9)="ICD" S DIC="^ICD9(",IBDFCODE="ICD-9 "
 .;;I $E($G(^IBE(357.6,IBDFINT,11)),7,9)="VST" S DIC="^IBE(357.69,",IBDFCODE="Type of Visit "
 .;
 .I $E($G(^IBE(357.6,IBDFINT,11)),7,9)="CPT" S DIC="^ICPT(",IBDFCODE="CPT ",DIC("S")="I $P($$CPT^ICPTCOD(Y),U,7)=1"
 .;
 .;Change variable IBDFCODE to "ICD-9" or "ICD-10"
 .I $E($G(^IBE(357.6,IBDFINT,11)),7,9)="ICD" D  ;
 ..S IBDFCODE=$$GETCODSY(IBDFINT)
 ..S DIC="^ICD9("
 .;
 .I $E($G(^IBE(357.6,IBDFINT,11)),7,9)="VST" S DIC="^IBE(357.69,",IBDFCODE="Type of Visit ",DIC("S")="I $P($$CPT^ICPTCOD(Y),U,7)=1"
 .;
 .;ICD-9 only
 .I $G(DIC)]"",$G(IBDFCODE)["ICD-9" D  Q
 ..N IBDICD9D ;ICD9 date
 ..S IBDICD9D=$$IMPDATE^IBDUTICD(1)
 ..S DIC("S")="I $$LS^ICDEX(80,+Y,IBDICD9D)>0,$$CSI^ICDEX(80,+Y)=1"
 ..D EN1^IBDVAUT1("VAUTJ",2,IBDFCODE_"code",1)
 .;ICD-10 only
 .I $G(DIC)]"",$G(IBDFCODE)["ICD-10" S VAUTVB="VAUTJ",IBDTEMPY=Y D ICD10 S Y=IBDTEMPY Q
 .;
 .;CPT and VST only
 .I $G(DIC)]"" S VAUTVB="VAUTJ",VAUTNI=2,VAUTSTR=IBDFCODE_"code" S VAUTNALL=1 D FIRST^VAUTOMA
 ;
 I IBDFACT=2 D
 .S IBDFCODE=$$GETCODSY(IBDFINT)
 I (Y<0)&$D(IBDF1) D  K VAUTP G QUIT
 .F IBI=0:0 S IBI=$O(VAUTP(IBI)) Q:IBI']""  S VAUTJ(IBI)=$G(VAUTP(IBI))
 I IBDFACT=1,Y<0,'$D(IBDF1) G EXIT
 I IBDFACT=1,$G(IBDQUIT) G EXIT
 ;
 ;Allow Report to be Queued - IBD*3.0*70 
 L -^XTMP("IBDRPT")
 S DIR(0)="Y",DIR("A")="Would you like to queue this report and run it in the background",DIR("B")="Yes" D ^DIR
 I Y S IBDQUE=1,ZTRTN="OUT2^IBDFUTL",ZTDESC="Maintenance Utility background job",ZTSAVE("*")="",ZTIO="NULL" D ^%ZTLOAD Q
OUT2 ;Tasked entry point
 L +^XTMP("IBDRPT"):$G(DILOCKTM,5) Q:'$T
 I $G(IBDQUE) S VALMEVL=$S($D(VALMEVL):VALMEVL+1,1:0) D INIT S VALMBCK="R",VALMBG=1 Q
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
 N IBDX
 D KILL^VALM10()
 I '$O(^XTMP("IBDCPT",0)) S IBDFCNT1=0 D @(IBDFDIS_"1^IBDFUTL1")
 I '$O(^XTMP("IBDCPT",0)) D NUL
 I $O(^XTMP("IBDCPT",0)),'$G(VALMCNT) K ^TMP("IBDCPT1",$J) S VALMCNT=0,IBDX=0 F  S IBDX=$O(^XTMP("IBDCPT",IBDX)) Q:'IBDX  S VALMCNT=VALMCNT+1 D
 .S ^TMP("IBDCPT1",$J,VALMCNT,0)=^XTMP("IBDCPT",IBDX,0) M ^TMP("IBDCPT1",$J,"IDX",VALMCNT)=^XTMP("IBDCPT","IDX",IBDX)
 I $D(^TMP("IBDCPT1",$J)) K ^XTMP("IBDCPT") M ^XTMP("IBDCPT")=^TMP("IBDCPT1",$J) K ^TMP("IBDCPT1",$J)
 I '$D(^XTMP("IBDCPT",0)) S ^XTMP("IBDCPT",0)=$$FMADD^XLFDT(DT,30)_U_DT_U_"Maintenance utility IBDCPT global"
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
 K IBCLN,IBDFCLN,IBDFCLNM,IBDFDIV,IBDFGIFN,IBDFGN,IBDFGNM,IBDIV,IBDNAM,IBDNAME,IEN,^TMP("IBDF",$J),^TMP("UTIL",$J),DIVISION,IBDF,IBDFACT,VAUTNALL
 K ^TMP("IBDFUTL_SELECTED",$J),^TMP("IBDFUTL_TEMP",$J),^TMP("IBDFUTL_WCSEARCH",$J)
 L -^XTMP("IBDRPT")
 Q
 ;
HLP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
 ;
EXP ; -- expand code
 Q
NUL ; -- NULL MESSAGE
 S ^XTMP("IBDCPT",1,0)=" ",^XTMP("IBDCPT",2,0)="There are no "_$S(IBDFACT=1:"active",1:"inactive")_" codes on any forms.",^XTMP("CPTIDX",1)=1,^XTMP("CPTIDX",2)=2
 Q
 ;--------- new code for ICD-10 
ICD10 ; Wildcard search for ICD-10 codes
 ;
 N %,DIR,IBDANS,IBDGOBAK,IBDTEXT,IBDWORD,IBDY,Y
 W !
 S IBDCOUNT=$G(IBDCOUNT)+1
 S IBDTEXT=$S(IBDCOUNT>1:"another "_IBDFCODE,1:IBDFCODE)
 S (IBDQUIT,IBDGOBAK)=0
 S IBDAUTO=$G(IBDAUTO)
 S DIR("A")="Select "_IBDTEXT_"code"
 S DIR(0)="FO^3:8"
 S DIR("?")="Enter 3 to 8 characters or '??' for more help"
 S DIR("??")="^D HELP^IBDFN4A"
 D ^DIR K DIR
 I Y=""!($G(DTOUT))!(Y="^") D  Q
 .I '$D(^TMP("IBDFUTL_TEMP",$J)),'IBDAUTO S IBDQUIT=1
 S IBDANS=$P(Y,U)
 ;Do wildcard search.
 K ^TMP("IBDFUTL_WCSEARCH",$J)
 S IBDAUTO=1
 S IBDY=$$CODELIST^IBDUTICD("10D",IBDANS,"IBDFUTL_WCSEARCH",DT,"",1)
 I +IBDY<1 D 
 .S IBDWORD=$P($P(IBDY,U,2)," ")
 .S IBDWORD=$TR($E(IBDWORD,1),"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")_$E(IBDWORD,2,99) ;Capitalize first character of text message.
 .S $P(IBDY,U,2)=IBDWORD_" "_$P(IBDY," ",2,99)
 .W !!,$P(IBDY,U,2)_"."
 I +IBDY<1 S:IBDCOUNT=1 IBDCOUNT=0 S IBDAUTO=0 G ICD10
 I $P(IBDY,U,2)=0 D  G ICD10
 .W !!,"No data found for selected search, please enter partial code'*' for"
 .W !,"additional selections e.g. E11* ."
 .S:IBDCOUNT=1 IBDCOUNT=0 S IBDAUTO=0
 I +IBDY'<1 D  ;
 .S %=1
 .I $P(IBDY,U,2)>1 D
 ..W !!,"There are "_$P(IBDY,U,2)_" ICD-10-CM diagnosis codes that begin with "_IBDANS_". Do you wish to"
 ..W !,"automatically see all of these diagnosis codes on this list"
 ..S %=2 D YN^DICN
 .I $G(DTOUT)!(%=-1) S IBDQUIT=1 Q
 .I %=2 S IBDAUTO=0 K % W !!,"Continue to select from the (# of items in list) ICD-10 diagnoses" S %=2 D YN^DICN I $G(DTOUT)!(%=-1) S IBDQUIT=1 Q
 .I %=2 S IBDGOBAK=1 Q
 .D WCSEARCH(IBDAUTO,.IBDQUIT)
 I IBDGOBAK S IBDCOUNT=0 G ICD10
 I IBDQUIT Q
 I '$D(^TMP("IBDFUTL_TEMP",$J)),'IBDAUTO S IBDCOUNT=0
 K ^TMP("IBDFUTL_SELECTED",$J)
 G ICD10
 Q
 ;
 ;Loop through wildcard search.
WCSEARCH(IBDAUTO,IBDQUIT) ;
 ;
 N IBDBEGN,IBDCNT,IBDCODE,IBDCONTU,IBDNDEX,IBDNOE,IBDSEL,IBDX
 W !
 S (IBDNDEX,IBDCNT,IBDQUIT,IBDBEGN,IBDNO)=0
 S IBDCONTU=1
 F  S IBDNDEX=$O(^TMP("IBDFUTL_WCSEARCH",$J,IBDNDEX)) Q:IBDNDEX=""!(IBDQUIT)!('IBDCONTU)!(IBDNO)  D  ;
 .S IBDNOE=^TMP("IBDFUTL_WCSEARCH",$J,0)  ;Number of entries in wildcard search.
 .S IBDCODE=^TMP("IBDFUTL_WCSEARCH",$J,IBDNDEX,1)
 .S IBDIEN=+$P(IBDCODE,U) ;+ to resolve both direct and variable pointers
 .S IBDCODE=$P(IBDCODE,U,2)
 .S IBDX=$P($$GETIDX^IBDFN4("10D",IBDCODE,DT),U,2)
 .S IBDCNT=IBDCNT+1
 .I IBDCNT=1 S IBDBEGN=1 I IBDNOE>5,'IBDAUTO W @IOF
 .I IBDAUTO D  Q  ;User chose to automatically add ICD-10 codes or user only chose 1 ICD code so SELECT tag is by-passed.
 ..S ^TMP("IBDFUTL_TEMP",$J,IBDIEN)=IBDCODE  ;Needed for validation check in SET^IBDFUTL1
 ..I IBDNOE=1 D OKPROMPT(1,IBDCODE,IBDX,.IBDQUIT,.IBDNO)  ;W !?4,IBDCODE,?15,IBDX
 .;User chose to select which ICD-10 codes he/she wants to add to form.
 .;Set ^TMP global for ICD selections.
 .S ^TMP("IBDFUTL_SELECTED",$J,IBDCNT)=IBDIEN_U_IBDCODE_U_IBDX
 .W !,IBDCNT_".",?4,IBDCODE,?15,IBDX  ;Display wildcard selected ICD codes
 .I IBDCNT#22=0 D  Q  ;Display every 22 ICD codes to user.
 ..D SELECT(IBDBEGN,IBDCNT,.IBDQUIT,.IBDNDEX,.IBDSEL,.IBDCONTU)
 ..S IBDBEGN=IBDCNT+1
 ..;I IBDSEL="",$O(^TMP("IBDFUTL_WCSEARCH",$J,IBDNDEX))'="",'IBDQUIT,IBDCONTU W @IOF
 I IBDAUTO!(IBDQUIT)!('IBDCONTU) Q
 D SELECT(IBDBEGN,IBDCNT,.IBDQUIT,IBDNDEX,.IBDSEL,.IBDCONTU) ;Less than 22 ICD codes displayed.
 Q
 ;
 ;Allow user to select a range of ICD codes.
SELECT(IBDBEGN,IBDCNT,IBDQUIT,IBDNDEX,IBDSEL,IBDCONTU) ;
 N IBDCODE,IBDI,IBDNEXT,IBDNODE,IBDSELN,IBDSKIP,IBDTEXT,IBDTEMP,IBDTEMPY,IBDX
 S IBDSKIP=0
 S IBDSEL=$G(IBDSEL)
 I IBDNDEX'="" S IBDNEXT=$O(^TMP("IBDFUTL_WCSEARCH",$J,IBDNDEX))
 K Y
 S DIR("A")="Select ICD-10 DIAGNOSIS CODE or '?' for more help"
 S DIR("?")="press <RETURN> for more or '^' to exit."
 S DIR("?",1)="Enter a single number from the list or range (e.g., 1,3,5 or 2-4,8) or"
 I IBDBEGN'=IBDCNT S DIR(0)="LO^"_IBDBEGN_":"_IBDCNT D ^DIR K DIR
 I $D(DTOUT),'$D(^TMP("IBDFUTL_TEMP")) S IBDQUIT=1 Q
 I $D(DTOUT),$D(^TMP("IBDFUTL_TEMP")) S IBDCONTU=0 Q
 I Y="",$G(IBDNEXT) W @IOF Q 
 I Y="^" S IBDSKIP=1  ;User chose to exit out of selection list. Skip next question.
 S IBDTEMPY=Y
 I Y'="^",Y'="" S IBDTEMP=Y
 K Y
 I $G(IBDNEXT),'IBDSKIP D
 .S DIR("A")="Save selections and continue to (# of remaining items) in list"
 .S DIR(0)="Y",DIR("B")="YES" D ^DIR K DIR
 .I Y,$D(IBDNEXT) W @IOF
 .I Y=0 S IBDTEMP=""
 S Y=$G(Y)
 I $D(DTOUT) S IBDQUIT=1 Q
 I Y="^"!(Y=0) D
 .I IBDSEL="" S IBDCONTU=0
 Q:'IBDCONTU
 I IBDTEMPY="^",IBDSEL="" S IBDCONTU=0 Q
 I Y'="^",$G(IBDTEMP)'="" S IBDSEL=$G(IBDSEL)_IBDTEMP I $G(IBDNEXT) Q
 I IBDSEL="" Q
 S IBDTEXT=$S($L(IBDSEL,",")=2:"this diagnosis",1:"these diagnoses")
 W !,"Do you really want to select "_IBDTEXT
 S %=2 D YN^DICN
 I $G(DTOUT)!(%=2)!(%=-1) S IBDCONTU=0 Q
 W !
 F IBDI=1:1 Q:$P(IBDSEL,",",IBDI)=""  D
 .S IBDSELN=$P(IBDSEL,",",IBDI)
 .S IBDNODE=^TMP("IBDFUTL_SELECTED",$J,IBDSELN)
 .S IBDIEN=$P(IBDNODE,U)
 .S IBDCODE=$P(IBDNODE,U,2)
 .S IBDX=$P(IBDNODE,U,3)
 .S ^TMP("IBDFUTL_TEMP",$J,IBDIEN)=IBDCODE  ;Needed for validation check in SET^IBDFUTL1
 S IBDCONTU=0
 Q
 ;Ask user with 'OK? Yes' prompt
OKPROMPT(IBDONE,IBDCODE,IBDX,IBDQUIT,IBDNO) ;
 N DIR,IBDI
 I '$D(IBDONE) S IBDONE=0
 S DIR("A")="OK? (Yes/No) "
 F IBDI=1:1:4 D
 .I IBDONE D
 ..I IBDI=1 S DIR("A",1)="One code found."
 ..I IBDI=2 S DIR("A",2)=" "
 ..I IBDI=3 S DIR("A",3)=IBDCODE_"  "_IBDX
 ..I IBDI=4 S DIR("A",4)=" "
 .I 'IBDONE D
 ..I IBDI=1 S DIR("A",1)=" "
 ..I IBDI=2 S DIR("A",2)=IBDCODE_"  "_IBDX
 ..I IBDI=3 S DIR("A",3)=" "
 S DIR(0)="YAO",DIR("B")="Yes" D ^DIR K DIR
 W !
 I $D(DUOUT)!($D(DTOUT)) S IBDQUIT=1 Q
 I Y=0 S IBDNO=1 W !,"Code unselected from list."
 Q
 ;
 ;determine coding system 
 ; return ICD-9 or ICD-10 or null
GETCODSY(IBDFINT) ;
 Q $S($P($G(^IBE(357.6,IBDFINT,0)),"^")["ICD-9":"ICD-9 ",$P($G(^IBE(357.6,IBDFINT,0)),"^")["ICD-10":"ICD-10 ",1:"")
 ;IBDFUTL
SETSRT(IBDFDIS) ;IBD*3.0*70 - Set VA variables
 S:IBDFDIS="CLIN" VAUTC=^XTMP("IBDRPT",2)
 S:IBDFDIS="GROUP" VAUTG=^XTMP("IBDRPT",2)
 S:IBDFDIS="FORM" VAUTF=^XTMP("IBDRPT",2)
 Q
SETIBDF(IBDF) ;Set up IBDF array from ^XTMP("IBDF") global, IBD*3.0*70
 N IBDX
 S IBDX=0 F  S IBDX=$O(^XTMP("IBDF",IBDX)) Q:IBDX=""  S IBDF(IBDX)=^XTMP("IBDF",IBDX)
 Q
