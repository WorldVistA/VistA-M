IBCSC5B ;ALB/ARH - ADD/ENTER PROSTHETIC ITEMS ;12/28/93
 ;;2.0;INTEGRATED BILLING;**4,52,260,339,389**;21-MAR-94;Build 6
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;
EN ; add/edit prosthetic items for a bill, IBIFN required
 N IBX,DFN,IBDT1,IBDT2,IBACTION,BIFN,APROS,ALPROS,ABILL,ALBILL
 S IBX=$$BILL(IBIFN) Q:'IBIFN  S DFN=+IBX,IBDT1=$P(IBX,U,2),IBDT2=$P(IBX,U,3)
 ;
EN1 D PISET(DFN,IBDT1,IBDT2,.APROS,.ALPROS) D SET(IBIFN,.ABILL,.ALBILL,+$G(APROS))
 D PIDISP(.APROS,.ALPROS,.ABILL) D DISP(.ABILL,.ALBILL) S BIFN=""
 ;
 S IBACTION=$$SELECT(.ALPROS,.ALBILL) Q:'IBACTION
 I +IBACTION=1 S BIFN=$$ADD(IBIFN,$P(IBACTION,U,2),$P(IBACTION,U,3)) G EN1
 I +IBACTION=2 S BIFN=+$G(ABILL(+$P(IBACTION,U,2),$P(IBACTION,U,3)))
 I +IBACTION=3 S IBX=$$ASKITM(IBDT1,IBDT2) I +IBX S BIFN=$$ADD(IBIFN,+IBX,,$P(IBX,U,2))
 I +BIFN D EDIT(BIFN)
 ;
 G EN1
 Q
 ;
SELECT(ALPROS,ALBILL) ; get which item to add/edit, select from Patient Prosthetics, Bill Items, or add a new one
 ; returns 1 ^ PD DEL DATE ^ PI IFN - ALPROS(selected item) if item from Prosthetics selected
 ;         2 ^ PD DEL DATE ^ X      - ALBILL(selected item) if item existing on bill selected
 ;         3 if add new item, "" if exit, -1 if redo
 N IBX,IBY,IBZ,DIR,DTOUT,DUOUT,DIRUT,X,Y S IBY=""
 S DIR("?")="Select the Prosthetics Item to Add or Edit."
 S DIR("?",1)="Enter the number preceding the Item to Add or Edit."
 S DIR("?",2)="Or enter the Item name to add an item not in the list and not in Prosthetics.",DIR("?",3)=" "
 ;
 S DIR("A")="Select Prosthetics Item",DIR(0)="FO^1:20^K:X?1N1P.NP X" D ^DIR S IBX=Y I $D(DIRUT) G SELECTQ
 ;
 S IBZ=$G(ALPROS(IBX)) I +IBZ W "  adding ",IBX S IBY="1^"_IBZ G SELECTQ
 S IBZ=$G(ALBILL(IBX)) I +IBZ W "  editing ",IBX S IBY="2^"_IBZ G SELECTQ
 ;
 S DIR(0)="YO",DIR("A")="Add a New Item",DIR("B")="YES" D ^DIR K DIR S IBY=-1 I Y=1,'$D(DIRUT) S IBY=3
 ;
SELECTQ Q IBY
 ;
ASKITM(IBDT1,IBDT2) ; Ask for new item data when adding an item not in Prosthetics
 ; returns:  delivery date ^ prosthetic item name (from 661.1, .02)
 N DIR,DIC,DIE,DTOUT,DUOUT,DIRUT,X,Y,IBX,IBY S (IBX,IBY)="" I '$G(IBDT1)!'$G(IBDT2) G ASKITMQ
 ;
 W !!,"Enter a Prosthetics Item that does not have a Prosthetics Patient record.",!
 S DIR("A")="Select ITEM DELIVERY DATE",DIR(0)="DO^"_IBDT1_":"_IBDT2_":EX" D ^DIR S IBX=Y I Y'?7N G ASKITMQ
 ;
 S DIC="^RMPR(661.1,",DIC(0)="AENOQMZ",DIC("S")="I +$P(^(0),U,5)",DIC("A")="Select PROSTHETICS ITEM: " D ^DIC
 ;
 I +Y>0,+IBX S IBY=IBX_U_$P($G(Y(0)),U,2)
 ;
ASKITMQ Q IBY
 ;
ADD(IBIFN,IBDT,PIFN,IBPNAME) ; Add new Item to Bill (#362.5)
 N IBX,IBY,IBDX,IBHCPCS,DIC,DIE,DA,DR,DLAYGO,X,Y S IBY=0,PIFN=+$G(PIFN) I ($G(IBDT)'?7N)!('$G(IBIFN)) G ADDQ
 ;
 I $G(PIFN),$$ONBILLPI(IBIFN,PIFN) G ADDQ ; don't add duplicates
 I $G(IBPNAME)="" S IBPNAME=$P($$PIN(PIFN),U,2) I IBPNAME="" G ADDQ
 ;
 S DIC="^IBA(362.5,",DIC(0)="AQL",DLAYGO=362.5,X=IBDT K DA,DO D FILE^DICN K DA,DO,X
 I Y>0 S (IBY,DA)=+Y,DIE=DIC,DR=".02////"_IBIFN_";.04////"_+PIFN_";.05///^S X=IBPNAME" D ^DIE K DIE,DA,DR W "... ADDED"
 ;
 ;add dx if known
 I +IBY,+PIFN F IBX=1:1:4 S IBDX=+$G(^RMPR(660,PIFN,"BA"_IBX)) I IBDX,'$O(^IBA(362.3,"AIFN"_IBIFN,IBDX)) D
 . S DIC="^IBA(362.3,",DIC(0)="L",DLAYGO=362.3,X=IBDX,DIC("DR")=".02////"_IBIFN K DD,DO D FILE^DICN S IBDX(+Y)=""
 ;add hcpcs if known ;S IBHCPCS=$P($G(^RMPR(660,PIEN,0)),"^",22) I IBHCPCS
 ;
ADDQ Q IBY
 ;
EDIT(BIFN) ;
 N DIDEL,DIE,DIC,DR,DA,X,Y Q:'$G(BIFN)  W ! S DIDEL=362.5,DIE="^IBA(362.5,",DR=".01;.05",DA=BIFN D ^DIE
 Q
 ;
SET(IBIFN,ARRB,ARRBL,PICNT) ; setup array of all prosthetic devices on bill (#362.5), array names should be passed by reference
 ; input:   PICNT - the number of items found in prosthetics (PISET)
 ; output:  ARRB(PD DELIV DATE, X) = PD IFN (362.5 ptr) ^ Cost,  ARRB = BILL IFN ^ count of items on bill
 ;          ARRBL(PICNT + count of item on bill) = PD DELIV DATE ^ X
 ;          where X is the IFN of the Patient Item (660 ptr) or if not defined then a number_"Z"
 N CNT,IBX,IBY,BIFN,RIFN,IBC,IBRC K ARRB,ARRBL S IBC="AIFN"_$G(IBIFN),ARRB="^0" Q:'$G(IBIFN)
 D RCITEM^IBCSC5A(IBIFN,"IBRC",5) S CNT=0
 ;
 S IBX=0 F  S IBX=$O(^IBA(362.5,IBC,IBX)) Q:'IBX  S BIFN=0 F  S BIFN=$O(^IBA(362.5,IBC,IBX,BIFN)) Q:'BIFN  D
 . S IBY=$G(^IBA(362.5,BIFN,0)) Q:IBY=""  S CNT=CNT+1,RIFN=+$P(IBY,U,4),RIFN=$S(+RIFN:+RIFN,1:CNT_"Z")
 . S ARRB(+IBY,RIFN)=BIFN_U_$$CHG^IBCF4(BIFN,5,.IBRC),ARRB=$G(ARRB)+1
 S ARRB=IBIFN_U_+$G(ARRB)
 ;
 S CNT=+$G(PICNT),IBX=0 F  S IBX=$O(ARRB(IBX)) Q:'IBX  S IBY=0 F  S IBY=$O(ARRB(IBX,IBY)) Q:'IBY  S CNT=CNT+1,ARRBL(CNT)=IBX_U_IBY
 Q
 ;
DISP(ABILL,ALBILL) ;screen display of existing prosthetic devices for a bill, arrays should be passed by reference
 ; input:  ABILL (from SET) list of bill items
 ;         ALBILL (from SET) list of bill items, in count order
 N IBC,IBI,BIFN,BIFN0,DDT
 ;
 W !!,?5,"-----------------  Existing Prosthetic Items for Bill  -----------------",!
 S IBC=0 F  S IBC=$O(ALBILL(IBC)) Q:'IBC  D
 . S DDT=+ALBILL(IBC),IBI=$P(ALBILL(IBC),U,2),BIFN=+$G(ABILL(DDT,IBI)),BIFN0=$G(^IBA(362.5,BIFN,0))
 . W !,?1,$J(IBC,2),")",?6,$$DATE(DDT),?16,$E($P(BIFN0,U,5),1,60)
 W !
 Q
 ;
PISET(DFN,DT1,DT2,ARRP,ARRPL) ; get all prosthetic items (660) for a patient and date range, arrays should pass by ref.
 ; input:   DFN = patient, DT1-DT2 range of dates to search for items
 ; output:  ARRP(PD DEL DATE (660,10), PI IFN (660 ptr)) = PI IFN (660 ptr),  ARRP = count of items
 ;          ARRPL(count) = PD DEL DATE (660,10) ^ PI IFN (660 ptr)
 ;
 N PIFN,DDT,IBX,IBY,CNT K ARRP,ARRPL Q:'$G(DFN)  S DT1=$G(DT1)-.0001,DT2=$G(DT2) S:'DT2 DT2=9999999
 S PIFN=0 F  S PIFN=$O(^RMPR(660,"C",DFN,PIFN)) Q:'PIFN  D
 . S IBX=$G(^RMPR(660,PIFN,0)) Q:IBX=""  S DDT=+$P(IBX,U,12)\1 I (DDT<DT1)!(DDT>DT2) Q
 . S ARRP(DDT,PIFN)=PIFN,ARRP=+$G(ARRP)+1
 ;
 S (CNT,IBX)=0 F  S IBX=$O(ARRP(IBX)) Q:'IBX  S IBY=0 F  S IBY=$O(ARRP(IBX,IBY)) Q:'IBY  S CNT=CNT+1,ARRPL(CNT)=IBX_U_IBY
 Q
 ;
PIDISP(APROS,ALPROS,ABILL) ; display all prosthetic items (#660) for a patient and date range, arrays passed by reference, not changed
 ; input:  APROS (from PISET) patient's prosthetic items
 ;         ALPROS (from PISET) patient's prosthetics items, in count order
 ;         ABILL (from SET) list of bill's prosthetics items, only to check if item on bill
 N IBC,DDT,PIFN,PNAME,IBY,IBX,IBICD,IBP,IBEX
 ;
 W @IOF,?33,"PROSTHETICS SCREEN"
 W !,"================================================================================",!
 S IBC=0 F  S IBC=$O(ALPROS(IBC)) Q:'IBC  D
 . S DDT=+ALPROS(IBC),PIFN=$P(ALPROS(IBC),U,2)
 . S PNAME=$$PIN(PIFN),IBY=$G(^RMPR(660,PIFN,"AM")),IBX=$G(^RMPR(660,PIFN,0)) K IBEX
 . ;
 . F IBICD=1:1:4 Q:$D(IBEX)  I $D(^RMPR(660,PIFN,"BA"_IBICD)) F IBP=2:1:8 I $P(^RMPR(660,PIFN,"BA"_IBICD),"^",IBP) S IBEX="("_$P($T(EXEMPT+(IBP-1)),";",3)_")" Q  ; look for exemption info
 . ;
 . W !,$S($D(ABILL(+DDT,PIFN)):"*",1:"")
 . W ?1,$J(IBC,2),")",?6,$$DATE(DDT),?16,$E($P(PNAME,U,2),1,27),?45,"("_$P(PNAME,U,3),")",?53,$G(IBEX),?59,$E($$EXSET^IBEFUNC($P(IBX,U,14),660,12),1,4),?64,$$EXSET^IBEFUNC($P(IBY,U,3),660,62),?71,$J(+$P(IBX,U,16),8,2)
 Q
 ;
PIN(P660,P6611) ; given Prosthetic record (#660) or PSAS HCPCS (#661.1) return Item Name
 ; returns PSAS HCPSC ptr (661.1) ^ SHORT DESCRIPTION (661.1, .02) ^ HCPCS (661.1, .01)
 N IBX,IBY S IBY=""
 I +$G(P660) S P6611=+$P($G(^RMPR(660,+P660,1)),U,4)
 I +$G(P6611) S IBX=$G(^RMPR(661.1,+P6611,0)) I IBX'="" S IBY=P6611_U_$P(IBX,U,2)_U_$P(IBX,U,1)
 Q IBY
 ;
PINB(P3625) ; given the bill prosthetics item (#362.5) return Item Name (.05)
 N IBY S IBY=$P($G(^IBA(362.5,+$G(P3625),0)),U,5)
 Q IBY
 ;
BILL(IBIFN) ; get bill data: returns DFN ^ Statement Covers From ^ Statement Covers To
 N IBX,IBY S IBIFN=+$G(IBIFN) S IBX=$G(^DGCR(399,IBIFN,0)),IBY=$P(IBX,U,2)
 S IBX=$G(^DGCR(399,IBIFN,"U")),$P(IBY,U,2)=+IBX,$P(IBY,U,3)=+$P(IBX,U,2)
 Q IBY
 ;
ONBILLPI(IBIFN,PIFN) ; return Bill Item ptr (#362.5) if the Prosthetics Item (#660) is already assigned to the bill
 ; input:  PIFN = Patient Prosthetics Item (ptr to 660)
 ; output: BIFN = Bill Prosthetics Item (ptr to 362.5) or null if not found
 N IBC,IBX,IBY,BIFN S IBY="" S IBC="AIFN"_$G(IBIFN)
 S IBX=0 F  S IBX=$O(^IBA(362.5,IBC,IBX)) Q:'IBX  S BIFN=0 F  S BIFN=$O(^IBA(362.5,IBC,IBX,BIFN)) Q:'BIFN  D
 . I +$G(PIFN),$P($G(^IBA(362.5,BIFN,0)),U,4)=PIFN S IBY=BIFN
 Q IBY
 ;
DATE(X) ;
 Q $E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3)
 ;
EXEMPT ; exemption reasons
 ;;AO
 ;;IR
 ;;SC
 ;;SWA
 ;;MST
 ;;HNC
 ;;CV
 ;
