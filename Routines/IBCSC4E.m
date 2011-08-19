IBCSC4E ;ALB/ARH - ADD/ENTER PTF/OE DIAGNOSIS ;3/2/94
 ;;2.0;INTEGRATED BILLING;**8,106,121,124,210,266,403**;21-MAR-94;Build 24
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
DXINPT(IBIFN) ; display and ask user to select PTF diagnosis
 N IBLIST,IBPTFDX
 D PTFDSP(IBIFN),PTFASK I $D(IBLIST) D PTFADD(IBIFN,IBLIST) S POAEDIT=1
 ; get POA indicators from QuadraMed for UB-04 inpatient claims
 I $$FT^IBCEF(IBIFN)=3 D SETPOA^IBCSC4F(IBIFN)
 K ^TMP($J,"IBDX")
 Q
 ;
PTFASK ;
 D PTF Q:$G(IBPTFDX)'>0  N X,Y,DIR,DIRUT K IBLIST W !
PTFASK1 S DIR("A")="SELECT DIAGNOSIS FROM THE PTF RECORD TO INCLUDE ON THE BILL"
 S DIR("?",1)="Enter the alphanumeric preceding the diagnosis you want added to the bill.",DIR("?",2)=""
 S DIR("?",3)="To enter more than one separate them by a comma or within a movement use a"
 S DIR("?",4)="range separated by a dash.  * indicates the diagnosis is already on the bill."
 S DIR("?")="The print order for each diagnosis will be determined by the order in this list."
 S DIR(0)="FO^^D ITPTF^IBCSC4E" D ^DIR K DIR Q:$D(DIRUT)!(Y="")
 ;
 S X=Y D ITPTF S IBLIST=X,DIR("A",1)="YOU HAVE SELECTED "_X_" TO BE ADDED TO THE BILL",DIR("A")="IS THIS CORRECT",DIR("B")="YES"
 S DIR(0)="YO" D ^DIR K DIR I $D(DIRUT) K IBLIST Q
 I 'Y K IBLIST G PTFASK1
 Q
 ;
PTF ;
 Q:'$D(^TMP($J,"IBDX","S"))  N IBX,IBY,IBZ,IBORD,IBNUM K IBPTFDX S IBORD="",IBPTFDX=0
 S IBX="" F  S IBX=$O(^TMP($J,"IBDX","S",IBX)) Q:IBX=""  D
 . S IBZ=+$G(^TMP($J,"IBDX","S",IBX)) Q:'IBZ
 . S IBORD=$E(IBX) Q:IBORD'?1A  S IBNUM=+$E(IBX,2,999) Q:IBNUM'>0
 . I IBNUM>$G(IBPTFDX(IBORD)) S IBPTFDX(IBORD)=IBNUM
 . I '$D(^IBA(362.3,"AIFN"_+$G(IBIFN),+IBZ)) S IBPTFDX=IBPTFDX+1
 Q
 ;
ITPTF ;
 N IBI,IB1,IB2,IB3,IBJ,IBX,IBY,IBZ,IBA
 S IBA="",IBX=X
 F IBI=1:1 S IBY=$P(IBX,",",IBI) Q:IBY=""  D  Q:'$D(X)  S X=IBA
 . I IBY["-" S IBZ=$P(IBY,"-",1),IB2=$P(IBY,"-",2) D  Q:'$D(X)
 .. I $E(IBZ,1)'=$E(IB2,1) K X Q
 .. S IBY="",IB1=$E(IBZ,2,999),IB2=$E(IB2,2,999),IBZ=$E(IBZ,1) I +IB2'>+IB1 K X Q
 .. F IBJ=IB1:1:IB2 S IBY=IBY_IBZ_IBJ_"-" I IBJ>$G(IBPTFDX(IBZ)) Q
 . F IBJ=1:1 S IB1=$P(IBY,"-",IBJ) Q:IB1=""  S IB2=$E(IB1,1),IB3=$E(IB1,2,99) D  Q:'$D(X)
 .. I IB1'?1U1.3N K X Q
 .. I IB2=""!'IB3 K X Q
 .. I '$D(IBPTFDX(IB2)) K X Q
 .. I IB3>+$G(IBPTFDX(IB2)) K X Q
 .. S IBA=IBA_IB2_IB3_","
 Q
 ;
PTFADD(IBIFN,LIST) ;
 Q:'$D(^TMP($J,"IBDX","S"))!($G(LIST)="")!('$G(IBIFN))  N IBX,IBY,IBI,IBCD,IBDX
 F IBI=1:1 S IBCD=$P(LIST,",",IBI) Q:IBCD=""  D
 . S IBDX=+$G(^TMP($J,"IBDX","S",IBCD)) Q:'IBDX
 . I ($$ICD9^IBACSV(+IBDX)'=""),'$D(^IBA(362.3,"AIFN"_IBIFN,+IBDX)) I $$ADD^IBCSC4D(+IBDX,IBIFN) W "."
 Q
 ;
PTFDSP(IBIFN) ; display PTF diagnosis within date range of the bill
 ; Output:  ^TMP($J,"IBDX") as defined by PTFDXDT^IBCSC4F   and
 ;          ^TMP($J,"IBDX","S",x) = DIAGNOSIS w/x=selection identifer for a dx
 N IB0,IBPTF,IBTF,IBU,IBFDT,IBTDT,IBDSCH,IBW,IBC,IBA,IBN,IBCNT,IBMCNT,IBMDT,IBMV,IBDT,IBLN,IBLABEL,IBDXCNT,IBI
 N IBDX,IBID,IBON,IBY,IBMDRG,X,IBDATE,IEN362,POA
 ;
 K ^TMP($J,"IBDX") S IBW=41
 ;
 S IBDATE=$$BDATE^IBACSV(IBIFN) ; The Event Date of the bill
 S IB0=$G(^DGCR(399,+$G(IBIFN),0)),IBPTF=$P(IB0,U,8),IBTF=$P(IB0,U,6) Q:'$G(IBPTF)
 S IBU=$G(^DGCR(399,+IBIFN,"U")),IBFDT=+IBU,IBTDT=$P(IBU,U,2) Q:$P(IB0,U,5)>2
 ;
 D PTFDXDT^IBCSC4F(IBPTF,IBFDT,IBTDT,IBTF) S IBDSCH=$P(+$P($G(^TMP($J,"IBDX","M")),U,3),".")
 ;
 F IBN="M","D" S (IBCNT,IBMCNT,IBMDT)="" F  S IBMDT=$O(^TMP($J,"IBDX",IBN,IBMDT)) Q:'IBMDT  S IBMCNT=IBMCNT+1 D
 . S IBMV=$G(^TMP($J,"IBDX",IBN,IBMDT)),IBDT=+IBMV,IBMDRG=$P(IBMV,U,4)
 . I IBN="M" S IBC=0,IBLABEL="Move",IBA=$C(64+IBMCNT) I 'IBDT S IBDT="D/C"
 . I IBN="D" S IBC=41,IBLABEL="Discharge",IBA="X" I 'IBDT S IBDT="NOT DISCHARGED"
 . ;
 . S IBLN=IBLABEL_": "_$S(+IBDT:$P($$FMTE^XLFDT(+IBDT,2),"@",1),1:IBDT)
 . S IBLN=IBLN_" "_$E($P($G(^DIC(42.4,+$P(IBMV,U,2),0)),U,1),1,12)
 . S IBLN=IBLN_" "_$J("",(29-$L(IBLN)))_$S(+$P(IBMV,U,3):"<SC>",1:"<NSC>")
 . ;
 . S IBCNT=IBCNT+1,X(IBCNT)=$G(X(IBCNT))_$J("",IBW)
 . S IBCNT=IBCNT+1,X(IBCNT)=$G(X(IBCNT))_$J("",IBW),X(IBCNT)=$E(X(IBCNT),1,IBC)_IBLN
 . ;
 . I '$O(^TMP($J,"IBDX",IBN,IBMDT,"")) S IBCNT=IBCNT+1,X(IBCNT)=$G(X(IBCNT))_$J("",IBW),X(IBCNT)=$E(X(IBCNT),1,IBC)_"  No DX Codes Entered For "_IBLABEL
 . ;
 . S (IBDXCNT,IBI)="" F  S IBI=$O(^TMP($J,"IBDX",IBN,IBMDT,IBI)) Q:'IBI  D
 .. S IBDX=^TMP($J,"IBDX",IBN,IBMDT,IBI),IBY=$$ICD9^IBACSV(+IBDX,IBDATE)
 .. S IEN362=$O(^IBA(362.3,"AIFN"_IBIFN,+IBDX,""))
 .. S IBDXCNT=IBDXCNT+1,IBID=IBA_IBDXCNT,IBON=$S(IEN362:"*",1:" ")
 .. S POA="" S:$P(IB0,U,19)=3 POA=$$GETPOA^IBCEU4(IEN362,1) S:POA'="" POA=" ("_POA_") "
 .. S IBLN=" "_IBON_IBID_" - "_$P(IBY,U,1)_POA_$J("",(7-$L($P(IBY,U,1))))_$E($P(IBY,U,3),1,23)
 .. S IBCNT=IBCNT+1,X(IBCNT)=$G(X(IBCNT))_$J("",IBW),X(IBCNT)=$E(X(IBCNT),1,IBC)_IBLN
 .. S ^TMP($J,"IBDX","S",IBID)=IBDX
 . ;
 . I 'IBMDRG,IBN="M" S IBLN="   *** No DRG for Charges ***",IBCNT=IBCNT+1,X(IBCNT)=$G(X(IBCNT))_$J("",IBW),X(IBCNT)=$E(X(IBCNT),1,IBC)_IBLN
 . I IBMDRG S IBLN=$P($$DRG^IBACSV(+IBMDRG,IBDATE),U,1)_" - "_$E($$DRGTD^IBACSV(+IBMDRG,IBDATE),1,30),IBCNT=IBCNT+1,X(IBCNT)=$G(X(IBCNT))_$J("",IBW),X(IBCNT)=$E(X(IBCNT),1,IBC)_IBLN
 ;
 I IBDSCH,IBTDT<IBDSCH S IBCNT=2,X(IBCNT)=$G(X(IBCNT))_$J("",IBW),X(IBCNT)=$E(X(IBCNT),1,IBW)_"Discharge: "_$$FMTE^XLFDT(+$P(IBDSCH,"."),2)_" Not In Bill Range"
 I 'IBDSCH,IBTDT<DT S IBCNT=2,X(IBCNT)=$G(X(IBCNT))_$J("",IBW),X(IBCNT)=$E(X(IBCNT),1,IBW)_"Discharge:  NOT DISCHARGED"
 ;
 W @IOF,"=============================== Diagnosis Screen ==============================="
 S IBI="" F  S IBI=$O(X(IBI)) Q:'IBI  W !,$E(X(IBI),1,80)
 Q
 ;
DELALL(IBIFN) ; ask/delete all diagnosis on a bill, including all CPT associated Diagnosis
 Q:'$O(^IBA(362.3,"AIFN"_+$G(IBIFN),0))
 ;
 N DIR,DIRUT,DUOUT,DTOUT,X,Y,DIK W !
 S DIR("?")="Enter Yes to delete all Diagnosis currently defined for a bill, including any CPT Associated Diagnosis.",DIR("??")="^D DISP1^IBCSC4D("_IBIFN_")"
 S DIR("A")="DELETE ALL DIAGNOSIS ON BILL, INCLUDING CPT ASSOCIATED DIAGNOSIS"
 S DIR(0)="YO",DIR("B")="NO" D ^DIR K DIR Q:Y'=1
 ;
 N IBPROC,IBPROCD,IBXRF,IBDX,IBDXI,DIE,DIC,DA,DR
 S IBPROC=0 F  S IBPROC=$O(^DGCR(399,IBIFN,"CP",IBPROC)) Q:'IBPROC  D
 . S IBPROCD=$G(^DGCR(399,IBIFN,"CP",IBPROC,0)) I "^^^"[$P(IBPROCD,U,11,14) Q
 . S DIE="^DGCR(399,"_IBIFN_",""CP"",",DA=IBPROC,DA(1)=IBIFN,DR="10///@;11///@;12///@;13///@" D ^DIE K DA,DIE,DR
 ;
 S IBXRF="AIFN"_+IBIFN
 S IBDX=0 F  S IBDX=$O(^IBA(362.3,IBXRF,IBDX)) Q:'IBDX  D
 . S IBDXI=0 F  S IBDXI=$O(^IBA(362.3,IBXRF,IBDX,IBDXI)) Q:'IBDXI  D
 .. S DIK="^IBA(362.3,",DA=IBDXI D ^DIK K DIK,DA
 W " .... deleted"
 Q
 ;
POAASK ; POA edit
 N DIR,DIRUT,DUOUT,DTOUT,DX,ORD,X,Y
 W !
 S DIR("?")="Enter Yes to edit POA indicators."
 S DIR("A")="Edit POA indicators"
 S DIR(0)="YO",DIR("B")="NO" D ^DIR K DIR Q:Y'=1
 S DIE="^IBA(362.3,",ORD="" F  S ORD=$O(^IBA(362.3,"AO",IBIFN,ORD)) Q:ORD=""  D  Q:$D(Y)  ;
 .S DA=$O(^IBA(362.3,"AO",IBIFN,ORD,"")),DX=$$GET1^DIQ(362.3,DA,.01),DR=".04 "_DX D ^DIE
 .Q
 K DA,DIE,DIR,DR
 D CLEAN^DILF
 Q
