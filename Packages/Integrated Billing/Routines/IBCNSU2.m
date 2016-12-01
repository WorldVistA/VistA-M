IBCNSU2 ;ALB/NLR - INSURANCE PLAN LOOK-UP UTILITY ; 20-OCT-2015
 ;;2.0;INTEGRATED BILLING;**28,62,497,549**;21-MAR-94;Build 54
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
LKP(IBCNS,IBIND,IBMULT,IBSEL,IBALR,IBW,IBTLE) ; Look-up Utility for
 ;IB*2.0*549 passing of new input variable IBTLE
 ; Insurance Company Plans
 ;
 ; IB*2.0*549 - Added 2 for IBW option to only allow inactive Plan selection
 ; Input:   IBCNS   - IEN of the Insurance Company (file 36)
 ;          IBIND   - Include Individual Plans?  (1 - Yes | 0 - No)
 ;          IBMULT  - If set to 1, allows multiple plans to be chosen
 ;          IBALR   - May be set to point to a plan in file #355.3
 ;                    to be excluded from selection
 ;          IBW     - 1 - Allow both inactive and active plans to be chosen
 ;                    2 - Only allow inactive plans
 ;                    0 - Only allow active plans
 ;                    Optional, defaults to 0
 ;          IBTLE   - If set, then change the variable VALM("TITLE") to
 ;                    contain the value of IBTLE (IB*2.0*549)
 ; Output:  IBSEL   - IEN of the plan in file #355.3 if only a single plan
 ;                     is to be selected.
 ;          ^TMP($J,"IBSEL,PIEN) - Array of selected plan iens (where PIEN
 ;                     is the plan IEN) is returned if multiple plans may
 ;                     be selected.
 ;
 Q:'$G(IBCNS)                               ; No Insurance Company
 N VALMY,VALMHDR
 S IBIND=$G(IBIND)>0
 S:'$D(IBW) IBW=0
 S:'$D(IBTLE) IBTLE=""
 S IBMULT=+$G(IBMULT),IBSEL=0
 D EN^VALM("IBCNS PLAN LOOKUP")
 Q
 ;
INIT ; Build the list of plans.
 N IBP,IBCPOLD,X,IBCPOLD2  ;WCJ;IB*2*497
 K ^TMP("IBCNSJ",$J)
 S VALMCNT=0,VALMBG=1
 S IBP=0
 F  S IBP=$O(^IBA(355.3,"B",+IBCNS,IBP)) Q:'IBP  D
 . S IBCPOLD=$G(^IBA(355.3,+IBP,0))
 . S IBCPOLD2=$G(^IBA(355.3,+IBP,2))        ; WCJ;IB*2.0*497
 . I 'IBIND,'$P(IBCPOLD,"^",2) Q            ; Exclude individual plans
 . I 'IBW,$P(IBCPOLD,"^",11) Q              ; Plan is inactive
 . ;
 . ; IB*2.0*549 - Added check to only display inactive plans
 . I IBW=2,$P(IBCPOLD,"^",11)'=1 Q          ; Plan is active
 . ;
 . S VALMCNT=VALMCNT+1
 . S X=$$SETFLD^VALM1(VALMCNT,"","NUMBER")
 . I '$P(IBCPOLD,"^",2) S $E(X,4)="+"
 . S X=$$SETFLD^VALM1($P(IBCPOLD2,"^",1),X,"GNAME")  ;WCJ;IB*2.0*497
 . I $P(IBCPOLD,"^",11) S $E(X,24)="*"
 . S X=$$SETFLD^VALM1($P(IBCPOLD2,"^",2),X,"GNUM")  ;WCJ;IB*2.0*497
 . S X=$$SETFLD^VALM1($$EXPAND^IBTRE(355.3,.09,$P(IBCPOLD,"^",9)),X,"TYPE")
 . S X=$$SETFLD^VALM1($$YN^IBCNSM($P(IBCPOLD,"^",5)),X,"UR")
 . S X=$$SETFLD^VALM1($$YN^IBCNSM($P(IBCPOLD,"^",6)),X,"PREC")
 . S X=$$SETFLD^VALM1($$YN^IBCNSM($P(IBCPOLD,"^",7)),X,"PREEX")
 . S X=$$SETFLD^VALM1($$YN^IBCNSM($P(IBCPOLD,"^",8)),X,"BENAS")
 . ;
 . S ^TMP("IBCNSJ",$J,VALMCNT,0)=X
 . S ^TMP("IBCNSJ",$J,"IDX",VALMCNT,VALMCNT)=IBP
 ;
 I '$D(^TMP("IBCNSJ",$J)) D
 . S VALMCNT=2,^TMP("IBCNSJ",$J,1,0)=" "
 . S ^TMP("IBCNSJ",$J,2,0)="   No plans were identified for this company."
 Q
 ;
HDR ; Build the list header.
 ; Input: IBTLE - If not null, then change the variable VALM("TITLE") to
 ;                contain the value of IBTLE (IB*2.0*549)
 N IBCNS0,IBCNS11,IBCNS13,IBLEAD,X,XX,X1,X2
 I IBTLE'="" S VALM("TITLE")=IBTLE      ; IB*2.0*549
 S IBCNS0=$G(^DIC(36,+IBCNS,0)),IBCNS11=$G(^(.11)),IBCNS13=$G(^(.13))
 S X2=$S(IBW=2:"Inactive ",IBW:"",1:"Active ")
 ;
 ; IB*2.0*549 changed 'Plans for' to 'Plans In' for Move Subscriber lookup
 S XX=$S(IBTLE="Group Plan Lookup":"Plans In: ",1:"Plans for: ")
 S IBLEAD=$S(IBIND:"All "_X2,1:X2_"Group ")_XX
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
 I 'IBX W !!,"No plan selected!" D SPQ Q
 I 'IBMULT D  G SPQ
 . I $O(VALMY(IBX)) W !!,*7,"You may only select a single plan!" Q
 . I $G(IBALR),+$G(^TMP("IBCNSJ",$J,"IDX",IBX,IBX))=IBALR D  Q
 . . W !!,*7,"This plan is not allowed for selection!"
 . D OK^IBCNSM3
 . I IBQUIT S VALMBCK="Q" Q
 . I IBOK S IBSEL=+$G(^TMP("IBCNSJ",$J,"IDX",IBX,IBX)),VALMBCK="Q"
 ;
 S IBX=0
 F  S IBX=$O(VALMY(IBX)) Q:'IBX  D
 . S ^TMP($J,"IBSEL",+$G(^TMP("IBCNSJ",$J,"IDX",IBX,IBX)))=""
 S DIR(0)="Y",DIR("B")="NO",DIR("A")="Would you like to select any other plans"
 S DIR("?")="If you wish to select plans from other screens, please answer 'YES'.  Otherwise, answer 'NO'."
 D ^DIR K DIR
 I Y<1!($D(DIRUT)) S VALMBCK="Q"
 ;
SPQ ;
 I '$O(IBSEL(0)),VALMBCK="R" D PAUSE^VALM1
 Q
