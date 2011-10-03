IBCNRPM2 ;BHAM ISC/CMW - Match Multiple Group Plans to a Pharmacy Plan ;10-MAR-2004
 ;;2.0;INTEGRATED BILLING;**251,276**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;; ;
EN(IBCNRP,IBCNRI,IBCNRGP) ; -- main entry point for IBCNR PAYERSHEET MATCH (LIST TEMPLATE)
 D EN^VALM("IBCNR GROUP PLAN MATCH")
 Q
 ;
HDR ; -- header code
 NEW IBCNR0,IBCNRID,IBCNRNM,IBCNR10,IBCNRPBM,IBCNRBIN,IBCNRPCN,IBLEAD
 NEW IBCNR3,IBCNRIN,NST,LST,X
 ; get pharmacy plan data
 S IBCNR0=$G(^IBCNR(366.03,+IBCNRP,0))
 S IBCNRID=$P(IBCNR0,"^",1) ;id
 S IBCNRNM=$P(IBCNR0,"^",2) ;name
 S IBCNR10=$G(^IBCNR(366.03,+IBCNRP,10))
 S IBCNRPBM=$P(IBCNR10,"^",1) ;pbm
 S IBCNRBIN=$P(IBCNR10,"^",2) ;bin
 S IBCNRPCN=$P(IBCNR10,"^",3) ;pcn
 S IBCNR3=$G(^IBCNR(366.03,+IBCNRP,3,1,0)) ; appl
 S NST=$S($P(IBCNR3,"^",2)=0:"Inactive ",1:"Active ")
 S LST=$S($P(IBCNR3,"^",3)=0:"Inactive ",1:"Active ")
 ; get insurance company name
 S IBCNRIN=$P($G(^DIC(36,IBCNRI,0)),U)
 ; row 1
 S IBLEAD="FOR PHARMACY PLAN: "
 S X=IBCNRNM_" - "_IBCNRID
 S VALMHDR(1)=$$SETSTR^VALM1(X,IBLEAD,$L(IBLEAD)+1,80)
 ; row 2
 S IBLEAD="BIN: "_IBCNRBIN
 S X="     PCN: "_IBCNRPCN_"     STATUS:  National "_NST_"/Local "_LST
 S VALMHDR(2)=$$SETSTR^VALM1(X,IBLEAD,$L(IBLEAD)+1,80)
 ; row 3
 ;S X="STATUS:  National "_NST_"/"
 ;S VALMHDR(3)=$$SETSTR^VALM1("Local "_LST,X,$L(X)+1,80)
 ; row 4
 S X="FOR INSURANCE COMPANY: "
 S VALMHDR(4)=$$SETSTR^VALM1(IBCNRIN,X,$L(X)+1,80)
 ;
 Q
 ;
INIT ; -- init variables and list array
 ;
 I '$D(^TMP("IBCNR",$J,"GP")) D  Q
 . S VALMCNT=0
 . W !,*7,"Warning: No Active Group Plans with Pharmacy Coverage Found."
 ;
 N GPIEN,IBGP0,IBCPOLD,X,IBCPD6,IBCNRPP,IBCOV,IBCRVD,LIM
 N IBGNA,IBGNM,IBCNA,IBCNM,IBDAT
 K ^TMP("IBCNR",$J,"PM")
 S VALMCNT=0,VALMBG=1,(IBCNA,IBCNM)=""
 S (IBIND,IBMULT,IBW)=1
 F  S IBCNA=$O(^TMP("IBCNR",$J,"GP",IBCNA)) Q:IBCNA=""  D
 . F  S IBCNM=$O(^TMP("IBCNR",$J,"GP",IBCNA,IBCNM)) Q:IBCNM=""  D
 .. ;get pharm plan id
 .. S GPIEN=$O(^TMP("IBCNR",$J,"GP",IBCNA,IBCNM,"")),IBDAT=^TMP("IBCNR",$J,"GP",IBCNA,IBCNM,GPIEN)
 .. ;set up list
 .. S VALMCNT=VALMCNT+1
 .. S X=$$SETFLD^VALM1(VALMCNT,"","NUMBER")
 .. ;
 .. ;group name
 .. S X=$$SETFLD^VALM1(IBCNA,X,"GNAME")
 .. ;
 .. ;group number
 .. S X=$$SETFLD^VALM1(IBCNM,X,"GNUM")
 .. ;
 .. ;group plan type
 .. S X=$$SETFLD^VALM1($$EXPAND^IBTRE(355.3,.09,$P(IBDAT,"^",2)),X,"GTYP")
 .. ;
 .. ;pharmacy plan
 .. S IBCNRPP=$P($G(IBDAT),U)
 .. I IBCNRPP'="" S IBCNRPP=$$GET1^DIQ(366.03,IBCNRPP_",",.02,"E")
 .. S X=$$SETFLD^VALM1(IBCNRPP,X,"PHRM")
 .. ;
 .. ; set up tmp for SEL
 .. S ^TMP("IBCNR",$J,"PM",VALMCNT,0)=X
 .. S ^TMP("IBCNR",$J,"PM","IDX",VALMCNT,VALMCNT)=GPIEN
 ;
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K ^TMP("IBCNR",$J,"PM"),VALMBCK,VALMY
 K IBIND,IBMULT,IBW,IBX
 D CLEAN^VALM10,CLEAR^VALM1
 Q
 ;
EXPND ; -- expand code
 Q
 ;
SEL ;  Select Plan
 ;
 D S1
 ;
 I 'IBX Q  ; no group selected
 ;
 N DA,DIC,DIE,DR,D,IBSEL
 S IBX=0
 F  S IBX=$O(VALMY(IBX)) Q:IBX=""  D
 . S IBSEL=+$G(^TMP("IBCNR",$J,"PM","IDX",IBX,IBX))
 . S DA=IBSEL,DIC="^IBA(355.3,",DIE=DIC,DR="6.01////^S X="_IBCNRP
 . D ^DIE
 D GIPF^IBCNRPM1
 D INIT
 ;
 S IBX=0 F  S IBX=$O(VALMY(IBX)) Q:'IBX  D
 . S ^TMP($J,"IBSEL",+$G(^TMP("IBCNR",$J,"PM","IDX",IBX,IBX)))=""
 ;
 Q
 ;
DEL ; remove a plan from a group
 D S1
 ;
 I 'IBX Q  ; no group selected
 ;
 NEW DA,DIC,DIE,DR,IBSEL
 S IBX=0
 F  S IBX=$O(VALMY(IBX)) Q:IBX=""  D
 . S IBSEL=+$G(^TMP("IBCNR",$J,"PM","IDX",IBX,IBX))
 . S DA=IBSEL,DIC="^IBA(355.3,",DIE=DIC,DR="6.01///@"
 . D ^DIE
 D GIPF^IBCNRPM1
 D INIT
 ;
 S IBX=0 F  S IBX=$O(VALMY(IBX)) Q:'IBX  S ^TMP($J,"IBDEL",+$G(^TMP("IBCNR",$J,"PM","IDX",IBX,IBX)))=""
 ;
 Q
 ;
S1 N DIR,DIRUT,DUOUT,DTOUT,DIROUT,IBOK,IBQUIT,Y,X
 D EN^VALM2($G(XQORNOD(0))),FULL^VALM1
 S IBX=$O(VALMY(0)),VALMBCK="R"
 ;
 I 'IBX W !!,"No group selected!" D PAUSE^VALM1 Q
 I 'IBMULT D  G SPQ
 . D OK^IBCNSM3
 . I IBQUIT S VALMBCK="Q" Q
 . I IBOK S IBSEL=+$G(^TMP("IBCNR",$J,"PM","IDX",IBX)),VALMBCK="Q"
 ;
 ;S IBSEL=+$G(^TMP("IBCNR",$J,"PM","IDX",IBX))
 ;Q
 ;
SPQ ;
 S DIR(0)="SB^Y:YES;N:NO",DIR("B")="NO",DIR("A")="OK to Continue? "
 D ^DIR K DIR
 I $G(Y)="^" S IBX="" Q
 I $G(Y(0))="NO" S IBX=""
 Q
