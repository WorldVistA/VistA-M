ORCDPSH ;SLC/CLA-Pharmacy dialog utilities-Non-VA Meds ; 09 April 2003 11:00 AM
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**190,215,243**;Dec 17, 1997;Build 242
 ;
 ; DBIA 2418   START^PSSJORDF   ^TMP("PSJMR",$J)
 ; DBIA 3166   EN^PSSDIN        ^TMP("PSSDIN",$J)
 ; 
EN(TYPE) ; -- entry action for Meds dialogs
 S ORDG=+$O(^ORD(100.98,"B","NV RX",0)),ORCAT="O"
 K ^TMP("PSJMR",$J),^TMP("PSJNOUN",$J),^TMP("PSJSCH",$J)
 I $G(ORENEW)!$G(OREWRITE)!$D(OREDIT)!$G(ORXFER) D
 . K ORDIALOG($$PTR("START DATE/TIME"),1)
 . K ORDIALOG($$PTR("NOW"),1)
 . I $D(OREDIT),'$O(ORDIALOG($$PTR^ORCD("OR GTX INSTRUCTIONS"),0)) K ^TMP("ORWORD",$J)
 Q
 ;
EN1 ; -- setup Non-VA Meds dialog for quick order editor using ORDG
 N DG S DG=$P($G(^ORD(100.98,+$G(ORDG),0)),U,3)
 S ORINPT=0,ORCAT="O"
 K ^TMP("PSJMR",$J),^TMP("PSJNOUN",$J),^TMP("PSJSCH",$J)
 Q
 ;
ENOI ; -- setup OI prompt
 S ORDIALOG(PROMPT,"D")="S.NV RX"
 Q
 ;
CHANGED(X) ; -- Kill dependent values when prompt X changes
 N PROMPTS,NAME,PTR,P,I
 S PROMPTS=X I X="OI" D
 . S PROMPTS="INSTRUCTIONS^ROUTE^SCHEDULE^START DATE/TIME^DOSE^DISPENSE DRUG^SIG^PATIENT INSTRUCTIONS"
 . K ORDRUG,ORDOSE,OROUTE,ORSCH,ORSD,ORDSUP,ORQTY,ORQTYUNT,OREFILLS,ORCOPAY
 . K ^TMP("PSJINS",$J),^TMP("PSJMR",$J),^TMP("PSJNOUN",$J),^TMP("PSJSCH",$J)
 F P=1:1:$L(PROMPTS,U) S NAME=$P(PROMPTS,U,P) D
 . S PTR=$$PTR(NAME) Q:'PTR
 . S I=0 F  S I=$O(ORDIALOG(PTR,I)) Q:I'>0  K ORDIALOG(PTR,I)
 . K ORDIALOG(PTR,"LIST"),^TMP("ORWORD",$J,PTR)
 Q
 ;
ORDITM(OI) ; -- Check OI inactive date & type, get dependent info
 Q:OI'>0  ;quit - no value
 N ORPS,PSOI S ORPS=$G(^ORD(101.43,+OI,"PS")),PSOI=+$P($G(^(0)),U,2)
 S ORIV=$S($P(ORPS,U)=2:1,1:0)
 I '$P(ORPS,U,7) W $C(7),!,"This drug may not be used in a non-VA med order." S ORQUIT=1 D WAIT Q
OI1 ; ck NF status (don't care if Non-VA Meds are formulary or not)
OI2 ; -get selectable routes, doses [also called from NF^ORCDPS]
 D:'$D(^TMP("PSJMR",$J)) START^PSSJORDF(PSOI,$G(ORCAT))  ;DBIA 2418
 I '$D(ORDOSE) D
 . D DOSE^PSSORUTL(.ORDOSE,PSOI,"X",+ORVP)
 . K:$G(ORDOSE(1))=-1 ORDOSE
 Q
 ;
NFI(OI) ; -- Show NFI restrictions, if exist
 N PSOI,I,J,LCNT,MAX,X,STOP
 S PSOI=+$P($G(^ORD(101.43,+$G(OI),0)),U,2)
 D EN^PSSDIN(PSOI,"") Q:'$D(^TMP("PSSDIN",$J,"OI",PSOI))  ;DBIA 3166
 S I=0,LCNT=0,MAX=$S($G(IOBM)&$G(IOTM):IOBM-IOTM+1,1:24) W !
 F  S I=$O(^TMP("PSSDIN",$J,"OI",PSOI,I)) Q:I'>0  D
 . S J=0 F  S J=$O(^TMP("PSSDIN",$J,"OI",PSOI,I,J)) Q:J'>0  S X=$G(^(J)) D  Q:$G(STOP)
 .. S LCNT=LCNT+1 I LCNT'<MAX S:'$$CONT STOP=1 Q:$G(STOP)  S LCNT=1
 .. W !,X
 W ! K ^TMP("PSSDIN",$J,"OI",PSOI)
 Q
 ;
CONT() ; -- Press return to cont or ^ to stop
 N X,Y,DIR,DUOUT,DTOUT,DIRUT,DIROUT S DIR(0)="EA"
 S DIR("A")="Press <return> to continue or ^ to stop ..."
 D ^DIR S:$D(DUOUT)!$D(DTOUT) Y=""
 Q +Y
 ;
WAIT ; -- Wait for user
 N X W !,"Press <return> to continue ..." R X:DTIME
 Q
 ;
ROUTES ; -- Get allowable med routes
 Q:$G(ORDIALOG(PROMPT,"LIST"))  N I,X,CNT S (I,CNT)=0
 F  S I=$O(^TMP("PSJMR",$J,I)) Q:I'>0  S X=^(I),CNT=CNT+1,ORDIALOG(PROMPT,"LIST",CNT)=$P(X,U,3)_U_$P(X,U,1,2),ORDIALOG(PROMPT,"LIST","B",$P(X,U))=$P(X,U,3)
 S:$G(CNT) ORDIALOG(PROMPT,"LIST")=CNT
 S REQD=0
 Q
 ;
DEFRTE ; -- Get default route
 N INST1 S INST1=$O(ORDIALOG(PROMPT,0)) S:INST1'>0 INST1=INST ;1st inst
 I INST1=INST S Y=+$P($G(^TMP("PSJMR",$J,1)),U,3) K:Y'>0 Y Q
 S Y=+$G(ORDIALOG(PROMPT,INST1)) K:Y'>0 Y S:$G(Y) EDITONLY=1
 Q
 ;
CKSCH ; -- validate schedule [Called from P-S Action]
 N ORX S ORX=ORDIALOG(PROMPT,ORI) Q:ORX=$G(ORESET)  K ORSD ;reset
 D EN^PSSGS0(.ORX,"X")
 I $D(ORX) S ORDIALOG(PROMPT,ORI)=ORX D CHANGED("QUANTITY") Q  ;ok
 W $C(7),!,"Enter a standard schedule for administering this medication or one of your own,",!,"up to 20 characters.",!
 K DONE
 Q
 ;
PTR(X) ; -- Return ptr to prompt OR GTX X
 Q +$O(^ORD(101.41,"AB","OR GTX "_X,0))
 ;
EXIT ; -- exit action for Meds dialogs
 S:$G(ORXNP) ORNP=ORXNP
 K ORXNP,ORINPT,ORCAT,ORPKG,OROI,ORIV,ORDRUG,ORDOSE,OROUTE,ORSCH,ORSD,ORDSUP,OREFILLS,ORQTY,ORQTYUNT,ORCOPAY,PSJNOPC,ORCOMPLX
 K ^TMP("PSJMR",$J),^TMP("PSJNOUN",$J),^TMP("PSJSCH",$J)
 Q
