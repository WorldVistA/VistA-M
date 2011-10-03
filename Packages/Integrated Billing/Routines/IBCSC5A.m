IBCSC5A ;ALB/ARH - ADD/ENTER PRESCRIPTION FILLS ; 12/27/93
 ;;2.0;INTEGRATED BILLING;**27,52,106,51,160,137,245,309,347,405**;21-MAR-94;Build 4
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
EN ;add/edit prescription fills for a bill, IBIFN required
 S IBX=$$BILL(IBIFN) Q:'IBIFN  S DFN=+IBX,IBDT1=$P(IBX,U,2),IBDT2=$P(IBX,U,3),IBRXALL=$P(IBX,U,4)
 D SET(IBIFN,.IBRXA,"")
 D RXDISP^IBCSC5C(DFN,IBDT1,IBDT2,.IBPR,.IBPRO,.IBRXA,IBRXALL) I +$P($G(IBPRO),U,2) D NEWRX^IBCSC5C(+IBPRO) I +$G(IBLIST) D ADDNEW^IBCSC5C(IBIFN,IBLIST,.IBPR,.IBPRO) S DGRVRCAL=1
 S IBRXAP=+$G(IBPRO) D SET(IBIFN,.IBRXA,.IBRXAP),DISP(.IBRXA,.IBRXAP)
E1 S IBPIFN=0,IBRX=$$ASKRX(.IBRXAP,.IBPRO) G:IBRX="" EXIT S IBDT=$P(IBRX,U,2),IBRX=$P(IBRX,U,1),DGRVRCAL=1
 I 'IBDT S IBDT=$O(IBRXA(IBRX,0)) S:'IBDT IBDT=$O(IBPR(IBRX,0)) S IBDT=$$ASKDT(IBDT1,IBDT2,IBDT) G:'IBDT E1
 I +$$RXDUP^IBCU3(IBRX,IBDT,IBIFN,1),'$D(IBRXA(IBRX,IBDT)) G E1
 I '$D(IBPR(IBRX,IBDT)) W !,"This rx fill does not exist in Pharmacy for this patient!",!
 S IBPIFN=$G(IBRXA(IBRX,IBDT)),IBDRG=$P(IBPIFN,U,2)
 I 'IBPIFN S IBX=$G(IBPR(IBRX,IBDT)),IBPIFN=$$ADD(IBRX,IBIFN,IBDT,$P(IBX,U,3),$P(IBX,U,1),$P(IBX,U,4,6),$P(IBX,U,2)) D  G:'IBPIFN E1
 . I 'IBPIFN W " ??" Q
 . W "  ... ADDED"
 D EDIT(+IBPIFN,$P(IBPIFN,U,7)) S IBRXAP=+$G(IBPRO) D SET(IBIFN,.IBRXA,.IBRXAP) G E1
 ;
EXIT ;
 K IBPIFN,IBRX,IBDRG,IBX,IBDT1,IBDT2,IBRXA,IBPR,IBDT,IBLIST,IBPRO,IBRXAP,IBRXALL
 Q
 ;
ASKRX(IBRXAP,IBPRO) ;
 N X,Y,IBY,IBX W ! S IBX=""
 I +$G(IBIFN) S DIR("?")="The prescription number for the fill.  "_$$HTEXT^IBCSC5C,DIR("??")="^D HELP^IBCSC5A("_IBIFN_")"
 S DIR("A")="Select RX FILL",DIR(0)="FO^1:11^K:X'?.UN X" D ^DIR I $D(DIRUT)!(Y'?.AN) S Y="" K DIR,DIRUT G ARX1E
 S IBX=Y I $D(IBRXAP)<10,$D(IBPRO)<10 G ARX1E
 ;
 S IBY=$G(IBRXAP(IBX)) S:IBY="" IBY=$G(IBPRO(IBX)) I IBY="" G ARX1E
 W ! S DIR(0)="YO",DIR("A")="ADD/EDIT RX FILL "_$P(IBY,U,1)_" FOR "_$$FMTE^XLFDT($P(IBY,U,2))_" CORRECT",DIR("B")="YES"
 D ^DIR K DIR I Y=1,'$D(DIRUT) S IBX=IBY
ARX1E Q IBX
 ;
ASKDT(IBDT1,IBDT2,IBDT) ;
 S DIR("A")="Select RX FILL DATE",DIR(0)="DO^"_IBDT1_":"_IBDT2_":EX",DIR("B")=$$FMTE^XLFDT(IBDT) D ^DIR K DIR,DTOUT,DIRUT
 Q $S(Y?7N:Y,1:0)
 ;
ADD(RX,IFN,IBDT,DRUG,PIFN,OTHER,IBRF) ;
 N IBX,X,Y,DD,DO,DA,DIC,DLAYGO
 S IBX=0 S DRUG=$$DRUG($G(DRUG)) G:'DRUG ADDE
 S DIC="^IBA(362.4,",DIC(0)="AQL",X=RX,DLAYGO=362.4 D FILE^DICN
 I Y>0 D
 . S DIE=DIC,(IBX,DA)=+Y,DR=".02////"_IFN_";.03////"_IBDT_";.04////"_DRUG_";.05////"_+PIFN_";.06////"_$P(OTHER,U,1)_";.07////"_$P(OTHER,U,2)_";.08////"_$P(OTHER,U,3) S:$L($G(IBRF)) DR=DR_";.1////"_IBRF D ^DIE K DIE,DIC,DA,DR
 . S DGRVRCAL=1
ADDE Q IBX
 ;
EDIT(PIFN,REVIEN) ;
 N IBCHG,DIE,DR,DA,DIC,DIDEL
 S DIDEL=362.4,DIE="^IBA(362.4,"
 S DR=".01;.03;.04;.06;.07;.08;.09;.1"
 S DA=PIFN D ^DIE
 I '$D(^IBA(362.4,PIFN,0)),$G(REVIEN) D  ; Deleted RX - delete related rev code/CPT code
 . I $P($G(^DGCR(399,IBIFN,"RC",REVIEN,0)),U,15) S DA(1)=IBIFN,DA=$P(^(0),U,15),DIK="^DGCR(399,"_DA(1)_",""CP""," D ^DIK
 . S DA=REVIEN,DA(1)=IBIFN,DIK="^DGCR(399,"_DA(1)_",""RC""," D ^DIK
 . S DGRVRCAL=1
 Q
 ;
SET(IFN,RXARR,RXARRP) ;setup array of all rx fills for bill, array name should be passed by reference
 ;returns: RXARR(RX #, FILL DT)=RX IFN (362.4) ^ DRUG ^ DAYS SUPPLY ^ QTY ^ NDC # ^ Charge if known ^ ien of associated rev code multiple, if known ^ NDC FORMAT INDICATOR (1-4)
 ;         RXARR=BILL IFN ^ RX count
 N CNT,IBX,IBY,IBZ,PIFN,IBC,IBCNT,IBRC S IBCNT=+$G(RXARRP),IBC="AIFN"_$G(IFN) K RXARR,RXARRP
 ;
 D RCITEM(IFN,"IBRC",3)
 S (CNT,IBX)=0 F  S IBX=$O(^IBA(362.4,IBC,IBX)) Q:IBX=""  S PIFN=0 F  S PIFN=$O(^IBA(362.4,IBC,IBX,PIFN)) Q:'PIFN  D
 .S IBY=$G(^IBA(362.4,PIFN,0)) Q:IBY=""  S CNT=CNT+1,RXARR($P(IBY,U,1),+$P(IBY,U,3))=PIFN_U_$P(IBY,U,4)_U_$P(IBY,U,6,8),$P(RXARR($P(IBY,U),+$P(IBY,U,3)),U,6)=$$CHG^IBCF4(PIFN,3,.IBRC)
 . I $G(IFN) S $P(RXARR($P(IBY,U),+$P(IBY,U,3)),U,7)=$$FINDREV(IFN,3,PIFN)
 . S $P(RXARR($P(IBY,U),+$P(IBY,U,3)),U,8)=$P(IBY,U,9)
 ;
 S RXARR=$G(IFN)_"^"_CNT
 S IBX=0 F  S IBX=$O(RXARR(IBX)) Q:IBX=""  S IBY=0 F  S IBY=$O(RXARR(IBX,IBY)) Q:'IBY  S IBCNT=IBCNT+1,RXARRP(IBCNT)=IBX_"^"_IBY_"^"_$P(RXARR(IBX,IBY),U,7)
 Q
 ;
DISP(RXARR,RXARRP) ;screen display of existing fills for a bill: input should be print order array returned by SET^IBCSC5A: RXARR(RX,DT)=RX IFN (362.4) ^ DRUG, passed by reference
 N IBX,IBY,IBZ,IBS,IBP,IBIFN
 W !!,?5,"-----------------  Existing Prescriptions on Bill  -----------------",!
 S IBIFN=+$G(RXARR)
 S IBI=0 F  S IBI=$O(RXARRP(IBI)) Q:IBI=""  S IBX=$P(RXARRP(IBI),U,1),IBY=$P(RXARRP(IBI),U,2) I $D(RXARR(IBX,IBY)) D
 . S IBS=$$RXSTAT^IBCU1(+$P(RXARR(IBX,IBY),U,2),+$P($G(^IBA(362.4,+RXARR(IBX,IBY),0)),U,5),IBY)
 . D ZERO^IBRXUTL(+$P(RXARR(IBX,IBY),U,2))
 . S IBZ=$G(^TMP($J,"IBDRUG",+$P(RXARR(IBX,IBY),U,2),.01)),IBP=$$PRVNM(+RXARR(IBX,IBY))
 . K ^TMP($J,"IBDRUG")
 . W !,$J(IBI,2),")",?5,IBX,?19,$E(IBZ,1,25),?46,$$DATE^IBCSC5C(IBY),?56,$P(IBS,U,1),?61,$P(IBS,U,2),?69,$P(IBS,U,3)
 . S IBZ=$$RXDUP^IBCU3(IBX,IBY,IBIFN) I +IBZ W ?73,$P($G(^DGCR(399,+IBZ,0)),U,1)
 . S IBZ=$G(^DGCR(399,IBIFN,"RC",+$P(RXARR(IBX,IBY),U,7),0))
 . W !,?5,$E(IBP,1,25),?35,"(Rx Procedure ",$S($P(IBZ,U,15):"#"_$P(IBZ,U,15)_" "_$$CPTNM^IBCRBH1(IBIFN,4,$P(IBZ,U,15)),1:"Missing"),"  Rev Code ",$S(IBZ:"#"_+$P(RXARR(IBX,IBY),U,7)_" "_$P($G(^DGCR(399.2,+IBZ,0)),U),1:"Missing"),")"
 W !
 Q
 ;
HELP(IFN) ;called for help from rx enter to display existing rx, displays rx' from 52 and 399
 I +$G(IFN) N IBX,IBRXA S IBX=$$BILL(IFN) I +IBX D SET(IFN,.IBRXA,""),RXDISP^IBCSC5C($P(IBX,U,1),$P(IBX,U,2),$P(IBX,U,3),.IBPR,.IBPRO,.IBRXA,$P(IBX,U,4)) S IBRXAP=+IBPRO D SET(IFN,.IBRXA,.IBRXAP),DISP(.IBRXA,.IBRXAP)
 Q
BILL(IBIFN) ; return data on a bill 'patient ifn ^ from dt ^ to dt ^ true if add original rx'
 N IBX,IBY
 S IBX=$G(^DGCR(399,+$G(IBIFN),0)),IBY=$P(IBX,U,2)
 I '$$PERDIEM^IBCRU3(+$P(IBX,U,7),+$P(IBX,U,5),+$P(IBX,U,3)) S $P(IBY,U,4)=1
 S IBX=$G(^DGCR(399,+IBIFN,"U")),$P(IBY,U,2)=+IBX,$P(IBY,U,3)=+$P(IBX,U,2)
 Q IBY
DRUG(IBD) ; get drug
 N X,Y S IBD=+$G(IBD) S DIC(0)="VQ",DIC="^PSDRUG(" D DIC^PSSDI(50,"PS",.DIC,IBD,) I +Y<0  S IBD=0,DIC="^PSDRUG(",DIC(0)="AEQ" D DIC^PSSDI(50,"PS",.DIC,,) K DIC I +Y>0 S IBD=+Y
 Q IBD
 ;
RCITEM(IBIFN,ARRAY,TYPE) ; Pull off all item charges from RC multiple 
 ;  for item TYPE on bill IBIFN, return array ARRAY
 ; If type = "ALL", pull off all types
 ;Set up @ARRAY@(type,item reference,ct)=# units^unit charge
 ; If no pointer to an item, this was a manually entered charge and
 ;  will only 'associate' with the items found in the appropriate
 ;  item source file that are not referenced by an item in the revenue
 ;  code multiple in a sequential fashion (first unassociated 'RC' will
 ;  correlate to the first unassociated entry found for the bill in source file)
 N Z,Z0,Z1
 S Z=0
 F  S Z=$O(^DGCR(399,IBIFN,"RC",Z)) Q:'Z  S Z0=$G(^(Z,0)) I $S(TYPE="ALL":1,1:$P(Z0,U,10)=TYPE) I $P(Z0,U,10)'="" S Z1=$S($P(Z0,U,11)="":0,1:$P(Z0,U,11)),@ARRAY@($P(Z0,U,10),Z1,Z)=$P(Z0,U,3)_U_$P(Z0,U,2)
 Q
 ;
FINDREV(IBIFN,TYP,PTR) ; Finds the first revenue code that matches the
 ; same item type and item pointer
 ;
 N REVIEN,Z,Z0
 S Z=0
 F  S Z=$O(^DGCR(399,IBIFN,"RC",Z)) Q:'Z  S Z0=$G(^(Z,0)) I $P(Z0,U,10)=TYP,$P(Z0,U,11)=PTR S REVIEN=Z Q
 Q $G(REVIEN)
 ;
NDCNUM(IBNDC) ; Returns the format of the NDC # IBNDC, if possible
 N Z
 S Z=$TR(IBNDC,"-")
 Q $S(IBNDC?4N1"-"4N1"-"2N:1,IBNDC?5N1"-"3N1"-"2N:2,IBNDC?5N1"-"4N1"-"1N:3,IBNDC?5N1"-"4N1"-"2N!($L(Z)=11):4,IBNDC'="":1,1:"")
 ;
PRVNM(PIFN) ; return provider name for an rx, if one defined or null
 N IBX,IBPRV,IBRXIFN S IBPRV=""
 S IBRXIFN=$P($G(^IBA(362.4,+$G(PIFN),0)),U,5) I +IBRXIFN S IBX=$$FILE^IBRXUTL(IBRXIFN,4) I +IBX S IBPRV=$P($G(^VA(200,+IBX,0)),U,1)
 Q IBPRV
