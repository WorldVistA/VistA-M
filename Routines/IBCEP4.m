IBCEP4 ;ALB/TMP - EDI UTILITIES for provider ID ;29-SEP-00
 ;;2.0;INTEGRATED BILLING;**137,320,348,349,377**;21-MAR-94;Build 23
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
EN ; -- main entry point
 N IBINS,IBALL,IB95
 D ENX
 Q
 ;
EN1(IBINS) ; -- Entry point from provider number maintenence
 N IBPRV,IBALL,IB95
 S VALMBCK="R"
 D ENX
 Q
 ;
ENX ; Common call to list template for dual entry points
 N IBSLEV,DIR,Y
 K IBFASTXT
 D FULL^VALM1
 S DIR(0)="SA^1:Performing Provider Care Units;2:Billing Provider Care Units"
 S DIR("A")="Enter Type of Care Unit: ",DIR("B")=$P($P(DIR(0),":",2),";",1)
 W ! D ^DIR K DIR W !
 I Y'>0 Q
 S IBSLEV=+Y
 I IBSLEV=2 D EN^VALM("IBCE 2ND PRVID CARE UNIT MAINT") Q
 D EN^VALM("IBCE PRVCARE UNIT MAINT")
 Q
 ;
HDR ; -- header
 K VALMHDR
 S VALMHDR(1)=" "
 S VALMHDR(2)="Insurance Co: "_$S('$G(IBALL)&$G(IBINS):$P($G(^DIC(36,+IBINS,0)),U),1:"ALL")
 Q
 ;
INIT ; -- init variables, list array
 N Z,IB,IBLCT,IBENT,IBNM,IB0,Z0,Z1,IBQ,DIR,Y,X
 I $G(IBINS) S Y=IBINS ; For entrypoint from provider number maintenance
 ;
 I '$G(IBINS) D
 . S DIR(0)="PA^DIC(36,:AEMQ",DIR("A")="Select INSURANCE CO: ",DIR("?")="Select an INSURANCE CO to display its care units"
 . D ^DIR K DIR
 . I $D(DTOUT)!$D(DUOUT) S Y=-2 Q
 . I Y>0 S IBINS=+Y Q
 ;
 I Y'=-2 D
 . D BLD
 E  D
 . S VALMQUIT=1
 Q
 ;
BLD ;  Bld display  - IBINS must = ien of file 36
 K ^TMP("IBPRV_CU",$J)
 ;
 I $G(IBSLEV)=2 Q
 ;
 S (IBENT,IBLCT)=0,IBNM=""
 F  S IBNM=$O(^IBA(355.95,"C",IBINS,IBNM)) Q:IBNM=""  S Z=0 F  S Z=$O(^IBA(355.95,"C",IBINS,IBNM,Z)) Q:'Z  S IB=$G(^IBA(355.95,Z,0)) I IB'="",$P(IB,U,4)="" D
 . S IBLCT=IBLCT+1,IBENT=IBENT+1
 . I '$D(^IBA(355.96,"AUNIQ",IBINS,Z)) D SET^VALM10(IBLCT,$E(IBENT_"    ",1,4)_$E($P(IB,U)_$J("",30),1,30)_"  "_$E($P(IB,U,2)_$J("",20),1,20)_" (NO COMBINATIONS FOUND)",IBENT) Q
 . D SET^VALM10(IBLCT,$E(IBENT_"    ",1,4)_$E($P(IB,U)_$J("",30),1,30)_"  "_$E($P(IB,U,2)_$J("",20),1,20),IBENT)
 . S ^TMP("IBPRV_CU",$J,"ZIDX",IBENT)=Z
 . S Z0=0 F  S Z0=$O(^IBA(355.96,"AE",Z,Z0)) Q:'Z0  S Z1=0 F  S Z1=$O(^IBA(355.96,"AE",Z,Z0,Z1)) Q:'Z1  S IB0=$G(^IBA(355.96,Z1,0)) I IB0'="" D
 .. S IBLCT=IBLCT+1
 .. S IBQ=$J("",28)_"o "_$E($$EXPAND^IBTRE(355.96,.06,+$P(IB0,U,6))_$J("",20),1,20)
 .. S IBQ=IBQ_"  "_$E($P("Both form types^UB-04 Only^CMS-1500 Only",U,$P(IB0,U,4)+1)_$J("",15),1,15)_"  "_$E($P("Inpt/Outpt^Inpt Only^Outpt Only^RX Only",U,+$P(IB0,U,5)+1)_$J("",10),1,10)
 .. D SET^VALM10(IBLCT,IBQ,IBENT)
 ;
 I 'IBLCT D SET^VALM10(1,"No CARE UNITs Found"_$S('$G(IBINS):"",1:" for Insurance Co")) S IBLCT=1
 S VALMCNT=IBLCT,VALMBG=1
 Q
 ;
HELP ; -- help
 ;
 I $G(IBSLEV)=2 Q
 ;
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit
 D CLEAN^VALM10
 K ^TMP("IBPRV_CU",$J),IBINS,IBALL
 Q
 ;
EXPND ;
 Q
 ;
SEL(IBDA,MANY) ; Select from care unit list
 ; IBDA is passed by reference and IBDA(1) returned containing
 ;  ien's of the care unit selected (file 355.95).
 ; If > 1 entry can be selected, MANY is set to 1
 N Z
 S IBDA=0
 D EN^VALM2($G(XQORNOD(0)),$S($G(MANY):"",1:"S"))
 S Z=0 F  S Z=$O(VALMY(Z)) Q:'Z  S IBDA=IBDA+1,IBDA(IBDA)=+$G(^TMP("IBPRV_CU",$J,"ZIDX",Z))
 Q
 ;
DISP(IBVAR,IBINS,IBPTYP,IBFT,IBCT,START,END) ; Set up display array for
 ; provider id
 N Z
 S START=$S($G(START):START,1:1)
 S (Z,END)=$G(START)
 S @IBVAR@(START)="INSURANCE: "_$S(IBINS:$P($G(^DIC(36,+IBINS,0)),U),1:"ALL INSURANCE")
 S @IBVAR@(START+1)="PROV TYPE: "_$$EXPAND^IBTRE(355.96,.06,IBPTYP)
 S @IBVAR@(START+2)="FORM TYPE: "_$$EXPAND^IBTRE(355.96,.04,IBFT)
 S @IBVAR@(START+3)="CARE TYPE: "_$$EXPAND^IBTRE(355.96,.05,IBCT)
 S END=$G(START)+3
 Q
 ;
CAREUOK(IBIFN,IBCU,IBTYPE,IBSEQ) ; Returns 1 if care unit is appropriate 
 ; for bill based on provider type, care type, bill type and insurance co
 ; IBIFN = ien of bill (file 399)
 ; IBCU = the ien of the care unit (file 355.96)
 ; IBTYPE = type of ID being checked (1=performing, 2=EMC)
 ; IBSEQ = the COB seq being checked (1-3)
 N Z,IBOK,IBINS,IBCT,IBFT,IBPTYP,IBRX
 S IBOK=0
 S IBINS=+$$FINDINS^IBCEF1(IBIFN,+IBSEQ),IBFT=$S($$FT^IBCEF(IBIFN)=2:2,1:1)
 S IBPTYP=+$S(IBTYPE=1:$$PPTYP^IBCEP0(IBINS),1:$$EMCID^IBCEP())
 S IBRX=$$ISRX^IBCEF1(IBIFN)
 S IBCT=$S('IBRX:$S($$INPAT^IBCEF(IBIFN,1):1,1:2),1:3)
 ;Check from most general to most specific
 I $D(^IBA(355.96,"AD",IBINS,0,0,IBPTYP,IBCU)) S IBOK=1 G CAREOKQ
 I 'IBRX,$D(^IBA(355.96,"AD",IBINS,IBFT,0,IBPTYP,IBCU)) S IBOK=1 G CAREOKQ
 I $D(^IBA(355.96,"AD",IBINS,0,IBCT,IBPTYP,IBCU)) S IBOK=1 G CAREOKQ
 I $D(^IBA(355.96,"AD",IBINS,IBFT,IBCT,IBPTYP,IBCU)) S IBOK=1 G CAREOKQ
 ;
CAREOKQ Q IBOK
 ;
