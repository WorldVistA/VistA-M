ORCDPS1 ;SLC/MKB-Pharmacy dialog utilities ;11/12/14  15:03
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**94,117,141,149,195,215,243,280,337,311,350**;Dec 17, 1997;Build 77
 ;
 ; DBIA 2418   START^PSSJORDF   ^TMP("PSJMR",$J)
 ; DBIA 3166   EN^PSSDIN        ^TMP("PSSDIN",$J)
 ; DBIA 2534   SC^PSOCP
 ; DBIA 3237   ^PSOSIG
 ; DBIA 3278   ^PSOSIGDS
 ; DBIA 3423   ^PSSGS0
 ; DBIA 3233   ^PSSORUTL
 ; DBIA 3239   ^PSSUTIL1
 ; DBIA 3373   ^PSSUTLA1
 ;
EN(TYPE) ; -- entry action for Meds dialogs
 S ORINPT=$$INPT^ORCD,ORCAT=$G(TYPE)
 I 'ORINPT,ORCAT="I" D IMOLOC^ORIMO(.ORINPT,+ORL,+ORVP) S:ORINPT<0 ORINPT=0 ;allow inpt meds at this location?
 I ORCAT="" D
 . I $G(ORENEW)!$G(OREWRITE)!$D(OREDIT),$L($P($G(OR0),U,12)) S ORCAT=$P(OR0,U,12) Q  ;use value from order, via ORCACT4
 . S ORCAT=$S(ORINPT:"I",1:"O")
 S ORDG=+$O(^ORD(100.98,"B",$S(ORCAT="I":"UD RX",1:"O RX"),0))
 K ^TMP("PSJMR",$J),^TMP("PSJNOUN",$J),^TMP("PSJSCH",$J)
 I $G(ORENEW)!$G(OREWRITE)!$G(OREDIT)!$G(ORXFER) D  Q:$G(ORQUIT)
 . I 'ORINPT,ORCAT="I" D  Q:$G(ORQUIT)
 .. N OI S OI=+$O(^OR(100,+$G(ORIFN),.1,"B",0)) Q:OI<1
 .. I '$O(^ORD(101.43,OI,9,"B","IVM RX",0)) S ORQUIT=1 W $C(7),!!,"This order may not be placed at this location!" Q
 . K ORDIALOG($$PTR("START DATE/TIME"),1)
 . K ORDIALOG($$PTR("NOW"),1) Q:ORCAT'="O"
 . N WP S WP=$$PTR("WORD PROCESSING 1")
 . I '$G(ORXFER),'$$DRAFT^ORWDX2($G(ORIFN)) K ORDIALOG(WP,1),^TMP("ORWORD",$J,WP)
 . I $G(OREDIT),'$O(ORDIALOG($$PTR^ORCD("OR GTX INSTRUCTIONS"),0)) K ^TMP("ORWORD",$J)
 I ORINPT,ORCAT="O" W $C(7),!!,"NOTE: This will create an outpatient prescription for an inpatient!",!
 Q
 ;
EN1 ; -- setup Meds dialog for quick order editor using ORDG
 N DG S DG=$P($G(^ORD(100.98,+$G(ORDG),0)),U,3)
 I $P(DG," ")="O"!(DG="SPLY") S ORINPT=0,ORCAT="O"
 E  S ORINPT=1,ORCAT="I"
 K ^TMP("PSJMR",$J),^TMP("PSJNOUN",$J),^TMP("PSJSCH",$J)
 Q
 ;
ENOI ; -- setup OI prompt
 N D S D=$G(ORDIALOG(PROMPT,"D"))
 S:D="S.RX" ORDIALOG(PROMPT,"D")=$S(ORCAT="I":"S.UD RX",1:"S.O RX")
 I ORCAT="I",'ORINPT,D="S.UD RX" D  ;limit to IV meds for outpt's
 . S ORDIALOG(PROMPT,"D")="S.IVM RX" ;ORDG=+$O(^ORD(100.98,"B","O RX",0))
 . S ORDIALOG(PROMPT,"?")="Enter the IV medication you wish to order for this patient."
 Q
 ;
DEA ; -- ck DEA# of ordering provider if SchedII drug
 Q:$G(ORTYPE)="Z"  N DEAFLG,PSOI
 S PSOI=+$P($G(^ORD(101.43,+$G(Y),0)),U,2) Q:PSOI'>0
 S DEAFLG=$$OIDEA^PSSUTLA1(PSOI,ORCAT) Q:DEAFLG'>0  ;ok
 I $G(ORNP),'$L($P($G(^VA(200,+ORNP,"PS")),U,2)),'$L($P($G(^("PS")),U,3)) W $C(7),!,$P($G(^(0)),U)_" must have a DEA# or VA# to order this drug!" K DONE Q
 I DEAFLG=1 W $C(7),!,"This order will require a wet signature!"
 Q
 ;
CHANGED(X) ; -- Kill dependent values when prompt X changes
 N PROMPTS,NAME,PTR,P,I
 S PROMPTS=X I X="OI" D
 . S PROMPTS="INSTRUCTIONS^ROUTE^SCHEDULE^START DATE/TIME^DURATION^AND/THEN^DOSE^DISPENSE DRUG^SIG^PATIENT INSTRUCTIONS^DAYS SUPPLY^QUANTITY^REFILLS^SERVICE CONNECTED"
 . K ORDRUG,ORDOSE,OROUTE,ORSCH,ORSD,ORDSUP,ORQTY,ORQTYUNT,OREFILLS,ORCOPAY
 . K ^TMP("PSJINS",$J),^TMP("PSJMR",$J),^TMP("PSJNOUN",$J),^TMP("PSJSCH",$J)
 I X="DS" S PROMPTS="QUANTITY^REFILLS" K OREFILLS
 F P=1:1:$L(PROMPTS,U) S NAME=$P(PROMPTS,U,P) D
 . S PTR=$$PTR(NAME) Q:'PTR
 . S I=0 F  S I=$O(ORDIALOG(PTR,I)) Q:I'>0  K ORDIALOG(PTR,I)
 . K ORDIALOG(PTR,"LIST"),^TMP("ORWORD",$J,PTR)
 Q
 ;
ORDITM(OI) ; -- Check OI, get dependent info
 Q:OI'>0  ;quit - no value
 N ORPS,ORPSOI S ORPS=$G(^ORD(101.43,+OI,"PS")),ORPSOI=+$P($G(^(0)),U,2)
 S ORIV=$S($P(ORPS,U)=2:1,1:0)
 I $G(ORCAT)="O",'$P(ORPS,U,2) W $C(7),!,"This drug may not be used in an outpatient order." S ORQUIT=1 D WAIT Q
 I $G(ORCAT)="I" D  Q:$G(ORQUIT)
 . I $G(ORINPT),'$P(ORPS,U) W $C(7),!,"This drug may not be used in an inpatient order." S ORQUIT=1 D WAIT Q
 . I '$G(ORINPT),'ORIV W $C(7),!,"This drug may not be ordered for an outpatient." S ORQUIT=1 D WAIT Q
 I $G(ORTYPE)="Q" D  I $G(ORQUIT) D WAIT Q
 . N DEAFLG S DEAFLG=$$OIDEA^PSSUTLA1(ORPSOI,ORCAT) Q:DEAFLG'>0  ;ok
 . I $G(ORNP),'$L($P($G(^VA(200,+ORNP,"PS")),U,2)),'$L($P($G(^("PS")),U,3)) W $C(7),!,$P($G(^(0)),U)_" must have a DEA# or VA# to order this drug!" S ORQUIT=1 Q
 . I DEAFLG=1 W $C(7),!,"This order will require a wet signature!"
OI1 ; -ck NF status
 I $P(ORPS,U,6),'$G(ORENEW) D  ;alternative
 . W !!,"*** This medication is not in the formulary! ***"
 . N PSX,CNT,ORX,DIR,X,Y,DTOUT,DUOUT
 . D EN1^PSSUTIL1(.ORPSOI,ORCAT) I '$O(ORPSOI(0)) D  Q
 .. W !,"    There are no formulary alternatives entered for this item."
 .. W !,"    Please consult with your pharmacy before ordering it."
 . S PSX=0,CNT=0 F  S PSX=$O(ORPSOI(PSX)) Q:PSX'>0  D
 .. S ORX=+$O(^ORD(101.43,"ID",PSX_";99PSP",0)) Q:ORX'>0
 .. S CNT=CNT+1,ORPSOI("OI",CNT)=ORX_U_PSX
 .. S DIR("A",CNT)=$J(CNT,3)_" "_$P($G(^ORD(101.43,ORX,0)),U)
 . S DIR(0)="NAO^1:"_CNT,DIR("A")="Select alternative (or <return> to continue): "
 . S DIR("?")="The medication selected is not in the formulary; you may select one of the above listed alternatives instead, or press <return> to continue processing this order."
 . Q:CNT'>0  W !,"    Formulary alternatives:" D ^DIR
 . I Y'>0 S:$D(DTOUT)!$D(DUOUT) ORQUIT=1 Q
 . D:OI'=+ORPSOI("OI",+Y) CHANGED("OI") ;reset parameters if different
 . S OI=+ORPSOI("OI",+Y),ORDIALOG(PROMPT,INST)=OI,OROI=OI
 . S ORPSOI=+$P(ORPSOI("OI",+Y),U,2)
OI2 ; -get routes, doses [also called from NF^ORCDPS]
 D:'$D(^TMP("PSJMR",$J)) START^PSSJORDF(ORPSOI,$G(ORCAT))  ;DBIA 2418
 I '$D(ORDOSE) D
 . D DOSE^PSSORUTL(.ORDOSE,ORPSOI,$S($G(ORCAT)="I":"U",1:"O"),+ORVP)
 . K:$G(ORDOSE(1))=-1 ORDOSE Q:'$D(ORDOSE)
 . S ORDOSE("LOCAL")=0
 . N DOSAGE
 . S DOSAGE=0 F  S DOSAGE=$O(ORDOSE(DOSAGE)) Q:+$G(DOSAGE)=0  D
 . . S:+$P(ORDOSE(DOSAGE),U,1)=0 ORDOSE("LOCAL")=1
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
CONT() ; -- Cont or stop?
 N X,Y,DIR,DUOUT,DTOUT,DIRUT,DIROUT S DIR(0)="EA"
 S DIR("A")="Press <return> to continue or ^ to stop ..."
 D ^DIR S:$D(DUOUT)!$D(DTOUT) Y=""
 Q +Y
 ;
WAIT ; -- Wait for user
 N X W !,"Press <return> to continue ..." R X:DTIME
 Q
 ;
ROUTES ; -- Get med routes
 Q:$G(ORDIALOG(PROMPT,"LIST"))  N I,X,CNT S (I,CNT)=0
 F  S I=$O(^TMP("PSJMR",$J,I)) Q:I'>0  S X=^(I),CNT=CNT+1,ORDIALOG(PROMPT,"LIST",CNT)=$P(X,U,3)_U_$P(X,U,1,2),ORDIALOG(PROMPT,"LIST","B",$P(X,U))=$P(X,U,3)
 S:$G(CNT) ORDIALOG(PROMPT,"LIST")=CNT
 S:$G(ORTYPE)'="Z" REQD=$S(ORCAT="I":1,$P($G(^ORD(101.43,+$G(OROI),"PS")),U,5):0,1:1)
 Q
 ;
DEFRTE ; -- Get default route
 N INST1 S INST1=$O(ORDIALOG(PROMPT,0)) S:INST1'>0 INST1=INST
 I INST1=INST S Y=+$P($G(^TMP("PSJMR",$J,1)),U,3) K:Y'>0 Y Q
 S Y=+$G(ORDIALOG(PROMPT,INST1)) K:Y'>0 Y S:$G(Y) EDITONLY=1
 Q
 ;
CKSCH ; -- validate schedule [Called from P-S Action]
 N ORX S ORX=ORDIALOG(PROMPT,ORI) Q:ORX=$G(ORESET)  K ORSD
 D EN^PSSGS0(.ORX,$G(ORCAT))
 I $D(ORX) S ORDIALOG(PROMPT,ORI)=ORX D CHANGED("QUANTITY") Q  ;ok
 W $C(7),!,"Enter a standard schedule for administering this medication"
 K DONE I $G(ORCAT)="I" W ".",! Q
 W " or one of your own,",!,"up to 20 characters.",!
 Q
 ;
DEFCONJ ; -- Set default conjuction for previous instance [P-S Action]
 N LAST,DUR,CONJ
 S LAST=$O(ORDIALOG(PROMPT,ORI),-1) Q:LAST'>0  ;first instance
 S CONJ=$$PTR("AND/THEN") Q:$L($G(ORDIALOG(CONJ,LAST)))
 S DUR=$G(ORDIALOG($$PTR("DURATION"),LAST))
 S ORDIALOG(CONJ,LAST)=$S(+DUR'>0:"A",1:"T")
 Q
 ;
ENCONJ ; -- Get allowable values, if req'd for INST
 N P S P=$$PTR("INSTRUCTIONS")
 S:$G(ORTYPE)'="Z" REQD=$S($O(ORDIALOG(P,INST)):1,1:0) ;DJE/VM *350 quick orders should not require this field
 S ORDIALOG(PROMPT,"A")="And/then"_$S(ORCAT="O":"/except: ",1:": ")
 S $P(ORDIALOG(PROMPT,0),U,2)="A:AND;T:THEN;"_$S(ORCAT="O":"X:EXCEPT;",1:"")
 Q
 ;
INPCONJ ;
 N LETTER,DUR
 I $G(X)="" Q
 S LETTER=$$UP^XLFSTR($E(X,1))
 I LETTER'="T" Q
 S DUR=$$PTR("DURATION") I '$L($G(ORDIALOG(DUR,INST))) D
 .W !,"A duration is required when using a 'Then' conjunction."
 .K X
 Q
 ;
DSUP ; -- Get max/default days supply
 N ORX,Y
 S ORX("PATIENT")=+$G(ORVP),ORX("DRUG")=+$G(ORDRUG)
 D DSUP^PSOSIGDS(.ORX) S Y=+$G(ORX("DAYS SUPPLY")) S:Y'>0 Y=90
 ;S $P(ORDIALOG(PROMPT,0),U,2)="1:"_Y ;max allowed
 I '$G(ORDIALOG(PROMPT,1)),$G(ORTYPE)'="Z" S ORDIALOG(PROMPT,1)=Y
 Q
 ;
QTY() ; -- Return default quantity [Expects ORDSUP]
 N INSTR,DOSE,DUR,SCH,I,ORX,X,Y
 S Y="" I $G(ORDSUP)'>0!'$G(ORDRUG) G QTYQ ;need days supply, disp drug
 S INSTR=$$PTR("INSTRUCTIONS")
 S DOSE=$$PTR("DOSE"),CONJ=$$PTR("AND/THEN")
 S DUR=$$PTR("DURATION"),SCH=$$PTR("SCHEDULE")
 S I=0 F  S I=$O(ORDIALOG(INSTR,I)) Q:I'>0  D  Q:'$D(ORX)
 . S X=$P($G(ORDIALOG(DOSE,I)),"&",3) I X'>0 K ORX Q
 . S ORX("DOSE ORDERED",I)=X,ORX("SCHEDULE",I)=$G(ORDIALOG(SCH,I))
 . S X=$G(ORDIALOG(DUR,I)),ORX("DURATION",I)=$$HL7DUR^ORMBLDPS
 . S ORX("CONJUNCTION",I)=$G(ORDIALOG(CONJ,I))
 G:'$D(ORX) QTYQ ;no doses
 S ORX("PATIENT")=+$G(ORVP),ORX("DRUG")=+$G(ORDRUG)
 S ORX("DAYS SUPPLY")=+$G(ORDSUP)
 D QTYX^PSOSIG(.ORX) S Y=$G(ORX("QTY"))
QTYQ Q Y
 ;
MAXREFS ; -- Get max refills allowed [Entry Action]
 Q:$G(ORCAT)'="O"  N ORX,X
 S ORX("ITEM")=+$P($G(^ORD(101.43,+$G(OROI),0)),U,2)
 S ORX("DRUG")=+$G(ORDRUG),ORX("PATIENT")=+$G(ORVP)
 I $G(OREVENT),$$TYPE^OREVNTX(OREVENT)="D" S ORX("DISCHARGE")=1
 S ORX("DAYS SUPPLY")=$G(ORDSUP) D MAX^PSOSIGDS(.ORX)
 S OREFILLS=$G(ORX("MAX")),X=$G(ORDIALOG(PROMPT,INST))
 I OREFILLS'>0 S ORDIALOG(PROMPT,INST)=0 W !,"No refills allowed." Q
 S $P(ORDIALOG(PROMPT,0),U,2)="0:"_OREFILLS
 S ORDIALOG(PROMPT,"A")="Refills (0-"_OREFILLS_"): "
 I X,X>OREFILLS S ORDIALOG(PROMPT,INST)=OREFILLS
 Q
 ;
ASKSC() ; -- Return 1 or 0, if SC prompt should be asked
 I $$SC^PSOCP(+ORVP,+$G(ORDRUG)) Q 0
 ;I $$RXST^IBARXEU(+ORVP)>0 Q 0 ;exempt from copay
 Q 1
 ;
PTR(X) ; -- Return ptr to prompt OR GTX X
 Q +$O(^ORD(101.41,"AB","OR GTX "_X,0))
 ;
EXIT ; -- exit action for Meds
 S:$G(ORXNP) ORNP=ORXNP
 K ORXNP,ORINPT,ORCAT,ORPKG,OROI,ORIV,ORDRUG,ORDOSE,OROUTE,ORSCH,ORSD,ORDSUP,OREFILLS,ORQTY,ORQTYUNT,ORCOPAY,PSJNOPC,ORCOMPLX
 K ^TMP("PSJMR",$J),^TMP("PSJNOUN",$J),^TMP("PSJSCH",$J)
 Q
