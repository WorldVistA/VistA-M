IBCNSU2 ;ALB/NLR - INSURANCE PLAN LOOK-UP UTILITY ; 18-NOV-94
 ;;Version 2.0 ; INTEGRATED BILLING ;**28,62**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
LKP(IBCNS,IBIND,IBMULT,IBSEL,IBALR,IBW) ; Look-up Utility for Insurance Plans
 ;  Input:    IBCNS  --  Pointer to the ins. company in file #36
 ;            IBIND  --  Include Individual Plans?  (1 - Yes | 0 - No)
 ;           IBMULT  --  If set to 1, allows multiple plans to be chosen
 ;            IBALR  --  May be set to point to plan in file #355.3
 ;                       to be excluded from selection
 ;              IBW  --  If set to 1, allows inactive plans to be chosen
 ; Output:    IBSEL  --  Set to the pointer to the plan in file #355.3
 ;                       if only a single plan is to be selected.
 ;
 ;                       The array ^TMP($J,"IBSEL",ptr)="" is returned
 ;                       (where 'ptr' points to the plan in file
 ;                       #355.3) if multiple plans are to be selected.
 ;
 I '$G(IBCNS) G LKPQ
 N VALMY,VALMHDR
 S IBIND=$G(IBIND)>0,IBW=$G(IBW)>0,IBMULT=+$G(IBMULT),IBSEL=0
 D EN^VALM("IBCNS PLAN LOOKUP")
LKPQ Q
 ;
INIT ; Build the list of plans.
 N IBP,IBCPOLD,X
 K ^TMP("IBCNSJ",$J)
 S VALMCNT=0,VALMBG=1
 S IBP=0 F  S IBP=$O(^IBA(355.3,"B",+IBCNS,IBP)) Q:'IBP  D
 .S IBCPOLD=$G(^IBA(355.3,+IBP,0))
 .I 'IBIND,'$P(IBCPOLD,"^",2) Q  ;    exclude individual plans
 .I 'IBW,$P(IBCPOLD,"^",11) Q  ;      plan is inactive
 .;
 .S VALMCNT=VALMCNT+1
 .S X=$$SETFLD^VALM1(VALMCNT,"","NUMBER")
 .I '$P(IBCPOLD,"^",2) S $E(X,4)="+"
 .S X=$$SETFLD^VALM1($P(IBCPOLD,"^",3),X,"GNAME")
 .I $P(IBCPOLD,"^",11) S $E(X,24)="*"
 .S X=$$SETFLD^VALM1($P(IBCPOLD,"^",4),X,"GNUM")
 .S X=$$SETFLD^VALM1($$EXPAND^IBTRE(355.3,.09,$P(IBCPOLD,"^",9)),X,"TYPE")
 .S X=$$SETFLD^VALM1($$YN^IBCNSM($P(IBCPOLD,"^",5)),X,"UR")
 .S X=$$SETFLD^VALM1($$YN^IBCNSM($P(IBCPOLD,"^",6)),X,"PREC")
 .S X=$$SETFLD^VALM1($$YN^IBCNSM($P(IBCPOLD,"^",7)),X,"PREEX")
 .S X=$$SETFLD^VALM1($$YN^IBCNSM($P(IBCPOLD,"^",8)),X,"BENAS")
 .;
 .S ^TMP("IBCNSJ",$J,VALMCNT,0)=X
 .S ^TMP("IBCNSJ",$J,"IDX",VALMCNT,VALMCNT)=IBP
 ;
 I '$D(^TMP("IBCNSJ",$J)) S VALMCNT=2,^TMP("IBCNSJ",$J,1,0)=" ",^TMP("IBCNSJ",$J,2,0)="   No plans were identified for this company."
 Q
 ;
HDR ; Build the list header.
 N IBCNS0,IBCNS11,IBCNS13,IBLEAD,X,X1,X2
 S IBCNS0=$G(^DIC(36,+IBCNS,0)),IBCNS11=$G(^(.11)),IBCNS13=$G(^(.13))
 S X2=$S(IBW:"",1:"Active ")
 S IBLEAD=$S(IBIND:"All "_X2,1:X2_"Group ")_"Plans for: "
 S X="Phone: "_$S($P(IBCNS13,"^")]"":$P(IBCNS13,"^"),1:"<not filed>")
 S VALMHDR(1)=$$SETSTR^VALM1(X,IBLEAD_$P(IBCNS0,"^"),81-$L(X),40)
 S X1="Precerts: "_$S($P(IBCNS13,"^",3)]"":$P(IBCNS13,"^",3),1:"<not filed>")
 S X=$TR($J("",$L(IBLEAD)),""," ")_$S($P(IBCNS11,"^")]"":$P(IBCNS11,"^"),1:"<no street address>")
 S VALMHDR(2)=$$SETSTR^VALM1(X1,X,81-$L(X1),40)
 S X=$S($P(IBCNS11,"^",4)]"":$P(IBCNS11,"^",4),1:"<no city>")_", "
 S X=X_$S($P(IBCNS11,"^",5):$P($G(^DIC(5,$P(IBCNS11,"^",5),0)),"^",2),1:"<no state>")_"  "_$E($P(IBCNS11,"^",6),1,5)_$S($E($P(IBCNS11,"^",6),6,9)]"":"-"_$E($P(IBCNS11,"^",6),6,9),1:"")
 S VALMHDR(3)=$$SETSTR^VALM1(X,"",$L(IBLEAD)+1,80)
 S X="#" I $G(IBIND) S X="#  + => Indiv. Plan"
 I $G(IBW) S X=$E(X_$J("",23),1,23)_"* => Inactive Plan"
 S VALMHDR(4)=$$SETSTR^VALM1("Pre-  Pre-  Ben",X,64,17)
 Q
 ;
FNL ; Exit action.
 K ^TMP("IBCNSJ",$J),VALMBCK
 D CLEAN^VALM10,CLEAR^VALM1
 Q
 ;
SP ; 'Select Plan' Action
 N DIR,DIRUT,DUOUT,DTOUT,DIROUT,IBOK,IBQUIT,IBX,Y
 D EN^VALM2($G(XQORNOD(0)),"O"),FULL^VALM1
 S IBX=$O(VALMY(0)),VALMBCK="R"
 I 'IBX W !!,"No plan selected!" G SPQ
 I 'IBMULT D  G SPQ
 .I $O(VALMY(IBX)) W !!,*7,"You may only select a single plan!" Q
 .I $G(IBALR),+$G(^TMP("IBCNSJ",$J,"IDX",IBX,IBX))=IBALR W !!,*7,"This plan is not allowed for selection!" Q
 .D OK^IBCNSM3
 .I IBQUIT S VALMBCK="Q" Q
 .I IBOK S IBSEL=+$G(^TMP("IBCNSJ",$J,"IDX",IBX,IBX)),VALMBCK="Q"
 ;
 S IBX=0 F  S IBX=$O(VALMY(IBX)) Q:'IBX  S ^TMP($J,"IBSEL",+$G(^TMP("IBCNSJ",$J,"IDX",IBX,IBX)))=""
 S DIR(0)="Y",DIR("B")="NO",DIR("A")="Would you like to select any other plans"
 S DIR("?")="If you wish to select plans from other screens, please answer 'YES'.  Otherwise, answer 'NO'."
 D ^DIR K DIR I Y<1!($D(DIRUT)) S VALMBCK="Q"
 ;
SPQ I '$O(IBSEL(0)),VALMBCK="R" D PAUSE^VALM1
 Q
