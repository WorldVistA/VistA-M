IBCRCC ;ALB/ARH - RATES: CALCULATION OF ITEM CHARGE ;22-MAY-1996
 ;;2.0;INTEGRATED BILLING;**52,80,106,138,245,223,309,347,370,383,427,455,447**;21-MAR-94;Build 80
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; ITMCHG and RATECHG are basic item/set/rate charge functions, IBCRCI contains more standard callable functions
 ;
ITMCHG(CS,ITEM,EVDT,MOD,ARR) ; get the base unit charges for a specific item, given a charge set, item and date
 ; this is the primary function to get an item charge and works for all Charge Methods, given an Item
 ; returns ARR = count of items in array ^ total charge for item ^ total base charge
 ;         ARR(x) = charge item IFN (if any) ^ rev code (if any) ^ $ charge ^ $ base charge
 ; checks Item effective and inactive dates, modifier match, and only sets array if the charge is non-zero
 ; each item will be passed back separately in the array, no combination of charges
 ;
 N IBCSBR,IBEVDT,IBEFDT,IBXREF,IBITEM,IBDA,IBLN,IBCHRG,IBITMFND K ARR S ARR=0
 S CS=+$G(CS),IBEVDT=$S(+$G(EVDT):+EVDT,1:DT),IBITEM=+$G(ITEM),MOD=$G(MOD) I 'CS!'IBITEM Q
 S IBCSBR=$$CSBR^IBCRU3(CS)
 ;
 ; va cost
 I $P(IBCSBR,U,5)=2 D  Q  ; va cost
 . I $P(IBCSBR,U,1)["PROSTHETICS" S IBCHRG=$$PICOST(IBITEM)  I +IBCHRG D SETARR(0,0,+IBCHRG,.ARR) Q
 . I $P(IBCSBR,U,1)["PRESCRIPTION" S IBCHRG=$$RXCOST(IBITEM) I +IBCHRG D SETARR(0,0,+IBCHRG,.ARR) Q
 ;
 ; all others - have Charge Item entries
 ;
 ; find most recent Charge Item for the item, search until modifiers match (only BI=CPT should have mods defined)
 S IBXREF="AIVDTS"_CS,IBITMFND=0
 S IBEFDT=-(IBEVDT+.01) F  S IBEFDT=$O(^IBA(363.2,IBXREF,IBITEM,IBEFDT)) Q:'IBEFDT  D  Q:IBITMFND
 . S IBDA=0 F  S IBDA=$O(^IBA(363.2,IBXREF,IBITEM,IBEFDT,IBDA)) Q:'IBDA  D
 .. S IBLN=$G(^IBA(363.2,IBDA,0))
 .. I +$P(IBLN,U,7)'=+MOD Q  ; charge item modifier does not match modifier passed in
 .. S IBITMFND=1 ; item found
 .. I +$P(IBLN,U,4),+$P(IBLN,U,4)<IBEVDT Q  ; charge is inactive on event date
 .. ; START IB*2.0*447 BI ZERO DOLLAR CHANGES
 .. ;I +$P(IBLN,U,5) D SETARR(IBDA,+$P(IBLN,U,6),+$P(IBLN,U,5),.ARR,$P(IBLN,U,8))
 .. D SETARR(IBDA,+$P(IBLN,U,6),+$P(IBLN,U,5),.ARR,$P(IBLN,U,8))
 .. ; END IB*2.0*447 BI ZERO DOLLAR CHANGES
 Q
 ;
SETARR(CI,RVCD,CHRG,ARR,CHRGB) ; set charges into an array, does not allow zero charge, a new entry is created each time,
 ; no attempt to combine like items, the new item charge is added to any that may already be in the array 
 ; returns ARR = count of items in array ^ total charge for item
 ;         ARR(x) = charge item IFN (if any) ^ item rev code (if any) ^ $ charge
 ;
 N CNT,TCHRG,TCHRGB
 S CNT=+$G(ARR)+1,TCHRG=$P($G(ARR),U,2)+$G(CHRG) I +$G(CHRGB) S TCHRGB=+$P($G(ARR),U,3)+CHRGB
 ; START IB*2.0*447 BI ZERO DOLLAR CHANGES
 ;I +$G(CHRG) S ARR=CNT_U_+TCHRG_U_$G(TCHRGB),ARR(CNT)=$G(CI)_U_+$G(RVCD)_U_+CHRG_U_$G(TCHRGB)
 S ARR=CNT_U_+TCHRG_U_$G(TCHRGB),ARR(CNT)=$G(CI)_U_+$G(RVCD)_U_+CHRG_U_$G(TCHRGB)
 ; END IB*2.0*447 BI ZERO DOLLAR CHANGES
 Q
 ;
PICOST(PI) ; returns (PI=ptr 362.5): total VA cost of an item (660,14) ^ quantity (660,5) from prosthetics ^ bill IFN
 ;
 N IBPIP,IBLN,IBX,IBIFN S (IBPIP,IBX)=0
 I +$G(PI) S IBLN=$G(^IBA(362.5,+PI,0)),IBPIP=$P(IBLN,U,4),IBIFN=$P(IBLN,U,2)
 I +IBPIP S IBLN=$G(^RMPR(660,+IBPIP,0)) I IBLN'="" S IBX=$P(IBLN,U,16)_U_$P(IBLN,U,7)_U_IBIFN
 Q IBX
 ;
RATECHG(RS,CHG,EVDT,FEE) ; returns modifed item charge based on rate schedule:  check effective dates, apply adjustment
 ; adjusted amount ^ comment (if there is an adjustment)
 ; if FEE passed by reference, returns disp fee^admin fee
 ;
 N IBX,IBRS0,IBRS10,IBEFDT,IBINADT,IBRTY,X S IBRTY=""
 S IBX=+$G(CHG),IBRS0=$G(^IBE(363,+$G(RS),0)),IBRS10=$G(^IBE(363,+$G(RS),10))
 S EVDT=$S(+$G(EVDT):EVDT,1:DT),IBEFDT=$P(IBRS0,U,5),IBINADT=$P(IBRS0,U,6)
 I +IBEFDT>EVDT!(+IBINADT&(IBINADT<EVDT)) S IBX=0
 I +IBX,IBRS10'="" S X=IBX X IBRS10 S IBX=X,IBRTY="^Rate Schedule Adjustment ("_$J(CHG,"",2)_")"
 S FEE=$P($G(^IBE(363,+$G(RS),1)),"^",1,2)
 Q IBX_IBRTY
 ;
RXCOST(RX) ; returns (RX=ptr 362.4): VA Cost of an Rx - Per Unit Cost ^ bill IFN
 ; w/ Per Unit Cost = Refill (Current Unit Price of Drug - 52.1,1.2) or RX (Unit Price of Drug - 52,17) or Drug (Price Per Dispense Unit - 50,16)
 ;
 N IBRXP,IBDGP,IBLN,IBX,IBIFN,IBDT,IBY
 S (IBRXP,IBX,IBDGP,IBDT,IBIFN)=0,IBY=""
 ; fill number (362.4,.1)
 I +$G(RX) S IBLN=$G(^IBA(362.4,+RX,0)),IBRXP=$P(IBLN,U,5),IBDGP=$P(IBLN,U,4),IBIFN=$P(IBLN,U,2),IBDT=$P(IBLN,U,3),IBY=$P(IBLN,U,10)
 I IBY="" S IBY=$$RFLNUM^IBRXUTL(IBRXP,IBDT)
 ;
 I IBRXP,IBY S IBX=$$SUBFILE^IBRXUTL(IBRXP,+IBY,52,1.2)_U_IBIFN
 I IBRXP,'IBX S IBX=$$FILE^IBRXUTL(IBRXP,17)_U_IBIFN
 I 'IBRXP,IBDGP D DATA^IBRXUTL(+IBDGP) S IBLN=$G(^TMP($J,"IBDRUG",0)) I IBLN'="" S IBX=$G(^TMP($J,"IBDRUG",+IBDGP,16))_U_IBIFN
 ;
 ; penny drug cost is 0
 I $P(IBX,U,1)=0 S IBX=$$DRGCT(IBDGP)_U_IBIFN
 K ^TMP($J,"IBDRUG")
 Q IBX
 ;
 ;
DRGCT(IBDGP) ;Penny drug cost calculation
 ; Input - IEN
 ; Output - true value of unit price (50-13/15)
 N IBCUT,IBX,IBY S IBCUT=0
 G:'IBDGP DRGCTQ
 D:'$D(^TMP($J,"IBDRUG")) DATA^IBRXUTL(+IBDGP)
 S IBX=$G(^TMP($J,"IBDRUG",+IBDGP,13))
 S IBY=$G(^TMP($J,"IBDRUG",+IBDGP,15))
 I IBX,IBY S IBCUT=$J(IBX/IBY,1,4),IBCUT=$S(IBCUT>0:IBCUT,1:0.0001)
DRGCTQ Q IBCUT
 ;
PRVCHG(CS,CHG,PRV,EVDT,ITEM) ; return discounted amount, based on total charge for a the care, the provider and Charge Set (BR)
 ; if no discount record found for the Charge Set or the provider then returns original amount
 ; no provider discount for Lab charges (80000-89999)
 ;   discounted amount ^ comment (if discounted) ^ percent discount
 ;
 N IBPC,IBSGFN,IBSG,IBPDFN,IBPD0,IBPDTY,IBI,IBX,IBY S IBX=+$G(CHG),(IBSGFN,IBPDTY)="" I '$G(EVDT) S EVDT=DT
 I +$G(ITEM),ITEM>79999,ITEM<90000 S (CS,PRV)=""
 I +$G(CS) S IBSGFN=+$$CSSG^IBCRU6(+CS,"",2,.IBSG)
 I +$G(PRV),+IBSGFN S IBPC=$$GET^XUA4A72(PRV,EVDT)
 ;
 S IBI=0 F  S IBI=$O(IBSG(IBI)) Q:'IBI  S IBSGFN=+IBSG(IBI) I +IBSGFN D
 . S IBPDFN=0 F  S IBPDFN=$O(^IBE(363.34,"C",+IBSGFN,IBPDFN)) Q:'IBPDFN  D  Q:IBPDTY'=""
 .. I '$O(^IBE(363.34,+IBPDFN,11,"B",+IBPC,0)) Q
 .. S IBPD0=$G(^IBE(363.34,+IBPDFN,0)),IBY=$P(IBPD0,U,3) Q:IBY=""
 .. S IBY=+IBY/100,IBX=IBY*IBX
 .. S IBPDTY=U_$P($G(^VA(200,+PRV,0)),U,1)_" - "_$P(IBPD0,U,1)_" "_$P(IBPD0,U,3)_"% of "_$J(CHG,0,2)_U_+IBY
 Q IBX_IBPDTY
 ;
MODCHG(CS,CHG,MODS) ; return adjusted amount due to RC modifier adjustment
 ; straight adjustment for RC Physician charges by modifier, if no modifier adjustment returns original amount
 ; Input:  Charge Set, Procedure Charge, Modifiers - list with modifier IEN's separated by ','
 ; Output: discounted amount ^ comment (if discounted) ^ percent discount
 ;
 N IBCS0,IBBR0,IBMOD,IBMODS,IBMODE,IBDSCNT,IBPDTY,IBI,IBX,IBY
 S CHG=+$G(CHG),MODS=$G(MODS),(IBBR0,IBPDTY,IBMODS)="",IBDSCNT=1,IBX=+CHG
 I +$G(CS) S IBCS0=$G(^IBE(363.1,+CS,0)),IBBR0=$G(^IBE(363.3,+$P(IBCS0,U,2),0))
 I $P(IBBR0,U,1)'["RC PHYSICIAN" S MODS="" ; professional charge only
 I $P(IBBR0,U,4)'=2 S MODS="" ; CPT item only
 I 'CHG S MODS=""
 ;
 I +MODS F IBI=1:1 S IBMOD=$P(MODS,",",IBI) Q:'IBMOD  S IBY=0 D
 . I IBMOD=3 S IBMODE=22,IBY=1.3,IBX=IBX*IBY ; modifier 22 at 120% adjustment
 . I IBMOD=10 S IBMODE=50,IBY=1.54,IBX=IBX*IBY ; modifier 50 at 154% adjustment
 . I +IBY S IBMODS=IBMODS_$S(IBMODS="":"",1:",")_IBMODE,IBDSCNT=IBDSCNT*IBY ; allow for multiple discounts
 I IBMODS'="" S IBPDTY=U_"Modifier "_IBMODS_" Adjustment "_(IBDSCNT*100)_"% of "_$J(CHG,0,2)_U_+IBDSCNT
 Q IBX_IBPDTY
 ;
HRUNIT(HRS) ; returns Hour Units based on the Hours passed in
 ; Hour Units are the hours rounded to the nearest whole hour (less than 30 minutes is 0 units)
 N IBX S IBX=0 I +$G(HRS) S IBX=$J(HRS,0,0)
 Q IBX
 ;
MLUNIT(MLS) ; returns Miles Units based on the Miles passed in
 ; Mile Units are the miles rounded to the nearest whole mile
 N IBX S IBX=0 I +$G(MLS) S IBX=$J(MLS,0,0) I 'IBX S IBX=1
 Q IBX
 ;
MNUNIT(MNS) ; return Minute Units based on the Minutes passed in
 ; Minute Units are 15 minute intervals, rounded up after any minutes
 N IBX S IBX=0 I +$G(MNS) S IBX=(MNS\15) S:+(MNS#15) IBX=IBX+1 I 'IBX S IBX=1
 Q IBX
