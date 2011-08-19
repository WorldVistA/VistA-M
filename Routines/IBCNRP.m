IBCNRP ;DAOU/ALA - Plan Match ListMan ;13-NOV-2003
 ;;2.0;INTEGRATED BILLING;**251**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;; ;
EN ; -- main entry point for IBCNR PLAN MATCH
 D EN^VALM("IBCNR PLAN MATCH")
 Q
 ;
HDR ; -- header code
 NEW IBCNS0,IBCNS11,IBCNS13,IBLEAD,X,X1,X2
 S IBCNS0=$G(^DIC(36,+IBCNSP,0))
 S IBCNS11=$G(^DIC(36,+IBCNSP,.11))
 S IBCNS13=$G(^DIC(36,+IBCNSP,.13))
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
 S VALMHDR(4)=$$SETSTR^VALM1(" ",X,64,17)
 Q
 ;
INIT ; -- init variables and list array
 NEW IBGP0,IBCPOLD,X,IBCPD6,IBCNRPP,IBCOV,IBCRVD,LIM
 K ^TMP("IBCNR",$J)
 S VALMCNT=0,VALMBG=1
 S IBGP0=^IBA(355.3,+IBCNGP,0)
 I $G(IBGP0) D
 . ;S IBCPD6=$G(IBGP0,U,6)) ;chk pre-cert
 . ;I 'IBIND,'$P(IBGP0,"^",2) Q  ;    exclude individual plans
 . ;I 'IBW,$P(IBGP0,"^",11) Q  ;      plan is inactive
 . ;
 . S VALMCNT=VALMCNT+1
 . S X=$$SETFLD^VALM1(VALMCNT,"","NUMBER")
 . ;
 . I '$P(IBGP0,"^",2) S $E(X,4)="+"
 . S X=$$SETFLD^VALM1($P(IBGP0,"^",3),X,"GNAME")
 . ;
 . I $P(IBGP0,"^",11) S $E(X,24)="*"
 . S X=$$SETFLD^VALM1($P(IBGP0,"^",4),X,"GNUM")
 . ;
 . S X=$$SETFLD^VALM1($$EXPAND^IBTRE(355.3,.09,$P(IBGP0,"^",9)),X,"TYPE")
 . ;
 . S IBCNRPP=$$GET1^DIQ(355.3,IBCNGP_",",6.01,"I")
 . I IBCNRPP'="" S IBCNRPP=$$GET1^DIQ(366.03,IBCNRPP_",",.02,"E")
 . S X=$$SETFLD^VALM1(IBCNRPP,X,"PHARM")
 . ;
 . S IBCOV=$O(^IBE(355.31,"B","PHARMACY",""))
 . S LIM="",IBCVRD=0
 . F  S LIM=$O(^IBA(355.32,"B",IBCNGP,LIM)) Q:LIM=""  D
 .. I $P(^IBA(355.32,LIM,0),U,2)=IBCOV S IBCVRD=$P(^IBA(355.32,LIM,0),U,4)
 . S X=$$SETFLD^VALM1($S(IBCVRD=0:"NO",1:"YES"),X,"COV")
 . ;
 . S ^TMP("IBCNR",$J,VALMCNT,0)=X
 . S ^TMP("IBCNR",$J,"IDX",VALMCNT,VALMCNT)=IBCNGP
 . I '$D(^TMP("IBCNR",$J)) S VALMCNT=2,^TMP("IBCNR",$J,1,0)=" ",^TMP("IBCNR",$J,2,0)="   No plans were identified for this company."
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K ^TMP("IBCNR",$J),VALMBCK,VALMY
 D CLEAN^VALM10,CLEAR^VALM1
 Q
 ;
EXPND ; -- expand code
 Q
 ;
SEL ; -- select plan
 D S1
 I 'IBX Q  ; no group selected
 ;
 NEW DA,DIC,DIE,DR,D,IBPLN
 S DIC="^IBCNR(366.03,",DIC(0)="AEMNZ" D ^DIC
 I +Y<1 S D="F" D IX^DIC
 I +Y<1 G SPQ
 S IBPLN=+Y K Y,X
 D PLCK  ; check plan status
 S DA=IBSEL,DIC="^IBA(355.3,",DIE=DIC,DR="6.01////^S X="_IBPLN
 D ^DIE
 D INIT
 ;
 S IBX=0 F  S IBX=$O(VALMY(IBX)) Q:'IBX  S ^TMP($J,"IBSEL",+$G(^TMP("IBCNR",$J,"IDX",IBX,IBX)))=""
 ;
 D SPQ
 Q
 ;
PLCK ; -- check plan status
 NEW ARRAY
 D STCHK^IBCNRU1(IBPLN,.ARRAY)
 I $G(ARRAY(1))'="A" D
 . W !!,"WARNING....PLAN NOT ACTIVE!"
 ;
 Q
 ;
DEL ; -- remove a plan from a group
 D S1
 ;
 NEW DA,DIC,DIE,DR
 S DA=IBSEL,DIC="^IBA(355.3,",DIE=DIC,DR="6.01///@"
 D ^DIE
 D INIT
 ;
 S IBX=0 F  S IBX=$O(VALMY(IBX)) Q:'IBX  S ^TMP($J,"IBSEL",+$G(^TMP("IBCNR",$J,"IDX",IBX,IBX)))=""
 ;
 D SPQ
 Q
 ;
S1 ;
 NEW DIR,DIRUT,DUOUT,DTOUT,DIROUT,IBOK,IBQUIT,Y
 D EN^VALM2($G(XQORNOD(0)),"S"),FULL^VALM1
 S IBX=$O(VALMY(0)),VALMBCK="R"
 ;
 I 'IBX W !!,"No group selected!" G SPQ
 I 'IBMULT D  G SPQ
 . I $O(VALMY(IBX)) W !!,*7,"You may only select a single plan!" Q
 . I $G(IBALR),+$G(^TMP("IBCNR",$J,"IDX",IBX,IBX))=IBALR W !!,*7,"This plan is not allowed for selection!" Q
 . D OK^IBCNSM3
 . I IBQUIT S VALMBCK="Q" Q
 . I IBOK S IBSEL=+$G(^TMP("IBCNR",$J,"IDX",IBX,IBX)),VALMBCK="Q"
 ;
 S IBSEL=+$G(^TMP("IBCNR",$J,"IDX",IBX,IBX))
 Q
 ;
SPQ ;
 I '$O(IBSEL(0)),VALMBCK="R" D PAUSE^VALM1
 Q
