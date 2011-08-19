IBCEP ;ALB/TMP - Functions for PROVIDER ID MAINT - INS CO PARAMS ;11-02-00
 ;;2.0;INTEGRATED BILLING;**137,232,320,348,349**;21-MAR-94;Build 46
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
EN ; -- main entry point for IBCE PRV INS PARAMS
 N IBINS,IBCUINC ; Variable should be available throughout actions
 D FULL^VALM1
 D EN^VALM("IBCE PRV INS PARAMS")
 Q
 ;
HDR ; -- header code
 K VALMHDR
 I $G(IBINS) S VALMHDR(1)="INSURANCE CO: "_$P($G(^DIC(36,+IBINS,0)),U)
 Q
 ;
INIT ; Initialization
 N DIR,DIC,DA,X,Y,DTOUT,DUOUT
 S DIC(0)="AEMQ",DIC="^DIC(36," D ^DIC
 I Y'>0 D
 . S VALMQUIT=1
 E  D
 . S DIR="YA",DIR("A")="DO YOU WANT TO INCLUDE ANY CARE UNIT DETAIL?: ",DIR("?",1)="If you want to see the specific care unit defined for the insurance co",DIR("?")="you should respond yes here"
 . W ! D ^DIR K DIR W !
 . I $D(DTOUT)!$D(DUOUT) S VALMQUIT=1 Q
 . S IBCUINC=(Y=1)
 . S IBINS=+Y D BLD(IBINS,IBCUINC)
 Q
 ;
BLD(IBINS,IBCUINC) ; Build display for ins co level provider ID parameters
 ; IBINS = ien of ins co (file 36)
 ; IBCUINC = flag:
 ;    = 1 if care unit list should be included  or 0 if not
 N A,A0,A1,A2,A3,Z0,IB1,IB12,IB4,IBLCT,IBPTYP
 S IBLCT=0
 S IB4=$G(^DIC(36,IBINS,4))
 K ^TMP("IBPRV_INS_ID_PARAMS",$J)
 ;
 S Z0="Perf Prov Secondary ID Type (1500): "_$E($$EXPAND^IBTRE(36,4.01,+$P(IB4,U))_$J("",20),1,20) D SET1(.IBLCT,Z0)
 S Z0="Perf Prov Secondary ID Type (UB04): "_$E($$EXPAND^IBTRE(36,4.02,+$P(IB4,U,2))_$J("",20),1,20) D SET1(.IBLCT,Z0)
 S Z0=$J("",20)_"Required: "_$$EXPAND^IBTRE(36,4.03,$P(IB4,U,3)) D SET1(.IBLCT,Z0)
 S Z0=$J("",10)_"Care Unit Name: "_$$EXPAND^IBTRE(36,4.09,$P(IB4,U,9)) D SET1(.IBLCT,Z0)
 S Z0=""  D SET1(.IBLCT,Z0)
 ;
 I '$D(^IBA(355.96,"D",IBINS)) D  G BLDQ ;No care unit needed
 . S Z0=$J("",7)_"*** NO CARE UNITS DEFINED FOR THIS INS CO PROVIDER SECONDARY ID ***" D SET1(.IBLCT,Z0)
 ;
 S Z0=$J("",17)_"VALID CARE UNITS FOR THIS INSURANCE COMPANY" D SET1(.IBLCT,Z0),CNTRL^VALM10(IBLCT,18,46,IORVON,IORVOFF)
 S A=0
 F  S A=$O(^IBA(355.96,"AC",IBINS,A)) Q:'A  S IBPTYP=$P($G(^IBE(355.97,A,0)),U) I IBPTYP'="" D
 . S A2=IBPTYP_U_A,^TMP("IBPRV_INS_ID_PARAMS_SORT",$J,A2)=""
 . S A0=0 F  S A0=$O(^IBA(355.96,"AC",IBINS,A,A0)) Q:'A0  S A1=$G(^IBA(355.96,A0,0)) D
 .. I '$G(IBCUINC) S:'$D(^TMP("IBPRV_INS_ID_PARAMS_SORT",$J,A2,$P(A1,U,4)_U_$P(A1,U,5))) ^($P(A1,U,4)_U_$P(A1,U,5))="" Q
 .. I $P(A1,U,4)'="",$P(A1,U,5)'="" D
 ... S A3=$E($P($G(^IBE(355.95,+A1,0)),U)_$J("",1,30),1,30)_U_$S($P($G(^(0)),U,2)'="":$P(^(0),U,2),1:"<No description available>")
 ... I '$D(^TMP("IBPRV_INS_ID_PARAMS_SORT",$J,A2,$P(A1,U,4)_U_$P(A1,U,5),$P(A3,U))) S ^($P(A3,U))=$P(A3,U,2)
 . ; records are fully sorted
 S A=""
 F  S A=$O(^TMP("IBPRV_INS_ID_PARAMS_SORT",$J,A)) Q:'A  S A2="PROVIDER ID TYPE: "_$P(A,U),IB1=1 D:'IB1 SET1(.IBLCT,"") D SET1(.IBLCT,A2) S IB12=1 S:$G(IBCUINC) IB1=0 D
 . S A0="" F  S A0=$O(^TMP("IBPRV_INS_ID_PARAMS_SORT",$J,A,A0)) Q:A0=""  D
 .. S Z0=$J("",5)_"FORM TYPE: "_$E($$EXPAND^IBTRE(355.96,.04,$P(A0,U))_$J("",25),1,25)_"  CARE TYPE: "_$E($$EXPAND^IBTRE(355.96,.05,$P(A0,U,2))_$J("",25),1,25)
 .. D:'IB12 SET1(.IBLCT,"") D SET1(.IBLCT,Z0)
 .. Q:'$G(IBCUINC)
 .. S IB12=0
 .. S A1="" F  S A1=$O(^TMP("IBPRV_INS_ID_PARAMS_SORT",$J,A,A0,A1)) Q:A1=""  S Z0=$J("",10)_A1_$G(^(A1)) D SET1(.IBLCT,Z0)
 ;
BLDQ K ^TMP("IBPRV_INS_ID_PARAMS_SORT",$J)
 S VALMCNT=IBLCT,VALMBG=1
 Q
 ;
SET1(IBLCT,Z0) ;
 S IBLCT=IBLCT+1 D SET^VALM10(IBLCT,Z0)
 Q
 ;
EXPND ;
 Q
 ;
HELP ;
 Q
 ;
EXIT ;
 K ^TMP("IBPRV_INS_ID_PARAMS",$J)
 D CLEAN^VALM10
 Q
 ;
EDIT ; Entrypoint called from IBCSCE to invoke provider id edit functions
 Q
 ;
EDIT1 ; Edit parameters
 N IB,IBY,IBCNS,DIE,DR,X,Y
 D FULL^VALM1
 S IBCNS=IBINS,IBY=12
 D MAIN^IBCNSC1
 S VALMBCK="R"
 Q
 ;
NETID() ; Returns the ien of the entry in file 355.97 that is designated as the
 ; NETWORK ID
 N Z S Z=0 F  S Z=$O(^IBE(355.97,Z)) Q:'Z  Q:$P($G(^(Z,1)),U,6)
 Q Z
 ;
EMCID() ; Returns the ien of the entry in file 355.97 that is designated as the
 ; EMC ID
 N Z S Z=0 F  S Z=$O(^IBE(355.97,Z)) Q:'Z  Q:$P($G(^(Z,1)),U,5)
 Q Z
 ;
UPIN() ; Returns the ien of the entry in file 355.97 that is designated as the
 ; UPIN ID
 Q +$O(^IBE(355.97,"B","UPIN",0))
 ;
EDITID(IBCNS) ; Edit provider id's from insurance co enter/edit
 ; IBCNS = ien of file 36
 Q   ; WCJ 12/30/2005
 N X,Y,Z4,DIR
 S Z4=$G(^DIC(36,IBCNS,4))
 I 'Z4,'$P(Z4,U,2) Q
 S DIR("A",1)="USE PROVIDER ID MAINTENANCE TO ENTER/EDIT PROV SECONDARY ID'S FOR THIS CO.",DIR("A")="PRESS RETURN TO CONTINUE: ",DIR(0)="EA" W ! D ^DIR K DIR
 Q
 ;
