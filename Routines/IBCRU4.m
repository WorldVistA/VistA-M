IBCRU4 ;ALB/ARH - RATES: UTILITIES (RG/BILL/CI) ; 16-MAY-1996
 ;;2.0;INTEGRATED BILLING;**52,106,245**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
 ;
RGEXT(RG) ; returns regions in external format (NAME ^ DIV1 ^ DIV 2 ^ ...)
 N IBX,IBY,IBZ,IBI,IBC S IBY="",IBX=0,IBC=""
 I +$G(RG) S IBZ=$P($G(^IBE(363.31,+RG,0)),U,1) I IBZ'="" S IBY=IBZ_U
 I IBY'="" S IBX=$$RGDV(+RG)
 I +IBX F IBI=1:1 S IBZ=$P(IBX,U,IBI) Q:'IBZ  S IBY=IBY_IBC_$P($G(^DG(40.8,+IBZ,0)),U,1),IBC=", "
 Q IBY
 ;
RGDV(RG,DV) ; returns a Billing Regions Divisions (363.31):  div1 ^ div2 ^ ...
 ; if DV is passed in and covered by region it will be the first division in the set
 N IBX,IBI S IBX=""
 I +$G(RG),$G(^IBE(363.31,+RG,0))'="" D
 . I +$G(DV),$D(^IBE(363.31,+RG,11,"B",DV)) S IBX=DV_U
 . S IBI=0 F  S IBI=$O(^IBE(363.31,+RG,11,"B",IBI)) Q:'IBI  I $G(DV)'=IBI S IBX=IBX_IBI_U
 Q IBX
 ;
BILLCPT(IBIFN) ; returns true if any of the charges on the bill may be based on CPT
 ; ie. one of the Billing Rates of one of the Charge Sets defined for the Rate Type of the bill
 ; has a Billable Item of CPT
 ;
 N IBX,IB0,IBU,IBI,IBJ,IBBR,IBRSARR S IBX=0,IBRSARR=0
 S IB0=$G(^DGCR(399,+$G(IBIFN),0)),IBU=$G(^DGCR(399,+$G(IBIFN),"U"))
 I IB0'="",+IBU D RT^IBCRU3($P(IB0,U,7),$P(IB0,U,5),$P(IBU,U,1,2),.IBRSARR)
 I +IBRSARR S IBI=0 F  S IBI=$O(IBRSARR(IBI)) Q:'IBI  D  Q:IBX
 . S IBJ=0 F  S IBJ=$O(IBRSARR(IBI,IBJ)) Q:'IBJ  D  Q:IBX
 .. S IBBR=$P($G(^IBE(363.1,IBJ,0)),U,2) I $P($G(^IBE(363.3,IBBR,0)),U,4)=2 S IBX=1
 Q IBX
 ;
BILLDV(IBIFN) ; returns true if one of the Billing Rates of the Charge Sets defined for the Rate Type of the bill
 ; is modifiable by Region and therefore may need division,  ie. has a Region defined
 ;
 N IBX,IB0,IBU,IBI,IBJ,IBCS0,IBRSARR S IBX=0,IBRSARR=0
 S IB0=$G(^DGCR(399,+$G(IBIFN),0)),IBU=$G(^DGCR(399,+$G(IBIFN),"U"))
 I IB0'="",+IBU D RT^IBCRU3($P(IB0,U,7),$P(IB0,U,5),$P(IBU,U,1,2),.IBRSARR)
 I +IBRSARR S IBI=0 F  S IBI=$O(IBRSARR(IBI)) Q:'IBI  D  Q:IBX
 . S IBJ=0 F  S IBJ=$O(IBRSARR(IBI,IBJ)) Q:'IBJ  D  Q:IBX
 .. S IBCS0=$G(^IBE(363.1,IBJ,0)) I +$P(IBCS0,U,7) S IBX=1
 Q IBX
 ;
 ;
FINDCI(CS,ITEM,EFDT,MOD,RVCD,CHG,INAC,ARR,BASE) ; find charge item entries for a billable item (exact match on date)
 ; Input:  CS, ITEM, EFDT required, if the others are defined they will be used in the match (ARR-pass by ref)
 ; Output: returns string off all CI IFNs that match
 ;         ARR = count of matchs found
 ;         ARR(CI) = 0 node record of CI from 363.2
 N IBX,IBXRF,IBEFDT,IBCI,IBLN K ARR S ARR=0,IBX="",EFDT=$G(EFDT)\1 I '$G(CS)!'$G(ITEM)!(EFDT'?7N) G FINDCIQ
 ;
 S IBXRF="AIVDTS"_CS,IBEFDT=-EFDT
 ;
 S IBCI=0 F  S IBCI=$O(^IBA(363.2,IBXRF,ITEM,IBEFDT,IBCI)) Q:'IBCI  D
 . ;
 . S IBLN=$G(^IBA(363.2,IBCI,0))
 . I $D(INAC),INAC'=$P(IBLN,U,4) Q
 . I $D(CHG),+CHG'=+$P(IBLN,U,5) Q
 . I $D(RVCD),RVCD'=$P(IBLN,U,6) Q
 . I $D(MOD),MOD'=$P(IBLN,U,7) Q
 . I $D(BASE),+BASE'=+$P(IBLN,U,8) Q
 . S IBX=IBX_IBCI_U,ARR=+$G(ARR)+1,ARR(IBCI)=IBLN
 ;
FINDCIQ Q IBX
 ;
FNDCI(CS,ITEM,EFDT,ARR,MOD) ; find charge item entries effective for a billable item on a given date
 ; Input:  CS, ITEM, EFDT required, if MOD defined it will be used in the match (ARR-pass by ref)
 ; Output: returns string of all CI IFNs that are effective for item on date
 ;         ARR = count of effective charge items found
 ;         ARR(CI) = 0 node record of CI from 363.2
 N IBX,IBXRF,IBEFDT,IBCI,IBLN,IBITMFND K ARR S ARR=0,IBX="",EFDT=$G(EFDT)\1
 I '$G(CS)!'$G(ITEM)!(EFDT'?7N) G FNDCIQ
 ;
 S IBXRF="AIVDTS"_CS,IBITMFND=0
 S IBEFDT=-(EFDT+.01) F  S IBEFDT=$O(^IBA(363.2,IBXRF,ITEM,IBEFDT)) Q:'IBEFDT  D  Q:IBITMFND
 . S IBCI=0 F  S IBCI=$O(^IBA(363.2,IBXRF,ITEM,IBEFDT,IBCI)) Q:'IBCI  D
 .. ;
 .. S IBLN=$G(^IBA(363.2,IBCI,0))
 .. I $D(MOD),MOD'=$P(IBLN,U,7) Q  ; charge item modifier does not match modifier passed in
 .. S IBITMFND=1 ; item found
 .. I +$P(IBLN,U,4),+$P(IBLN,U,4)<EFDT Q  ; charge is inactive on date
 .. I +$P(IBLN,U,5) S IBX=IBX_IBCI_U,ARR=+$G(ARR)+1,ARR(IBCI)=IBLN
 ;
FNDCIQ Q IBX
 ;
INACTCI(CI) ; returns date Charge Item becomes inactive: either Inactive Date or replaced (ie last active date)
 ; returns: -1: not found, 0: not inactive, Date: date inactive or last active date before replaced
 ;
 N IBX,IBCI0,IBEFDT,IBITEM,IBXRF,IBNEXT,IBNCI,IBNCI0,IBINDT1,IBINDT2 S (IBINDT1,IBINDT2,IBX)=0
 S IBCI0=$G(^IBA(363.2,+$G(CI),0)) I IBCI0="" S IBX=-1 G ACTCIQ
 ;
 S IBINDT1=+$P(IBCI0,U,4) ; charge item inactive date
 ;
 ; check previous entries for the item to see if it has been replaced
 S IBEFDT=$P(IBCI0,U,3),IBITEM=+IBCI0,IBXRF="AIVDTS"_+$P(IBCI0,U,2)
 S IBNEXT=-IBEFDT F  S IBNEXT=$O(^IBA(363.2,IBXRF,IBITEM,IBNEXT),-1) Q:'IBNEXT  D  Q:+IBINDT2
 . S IBNCI=0 F  S IBNCI=$O(^IBA(363.2,IBXRF,IBITEM,IBNEXT,IBNCI)) Q:'IBNCI  D  Q:+IBINDT2
 .. S IBNCI0=$G(^IBA(363.2,IBNCI,0)) I '$P(IBNCI0,U,3) Q
 .. I $P(IBCI0,U,7)=$P(IBNCI0,U,7) S IBINDT2=$$FMADD^XLFDT(+$P(IBNCI0,U,3),-1)
 ;
 S IBX=IBINDT1 I 'IBX S IBX=IBINDT2
 I +IBINDT2,+IBINDT1,IBINDT2<IBINDT1 S IBX=IBINDT2
 ;
ACTCIQ Q IBX
 ;
ITMUNIT(ITM,UNIT,CT) ; return true if the Item has the requested type of units or Charge Method
 ; Input: ITM  - pointer to Item Code
 ;        UNIT - Number of type of unit, or Charge Method, 4 - Miles, etc
 ;        CT   - Charge Type (optional) 1 for Inst, 2 for Prof (363.1,.04)
 ;
 N IBFND,IBCS,IBCSN S IBFND=0 S ITM=+$G(ITM),UNIT=+$G(UNIT)
 ;
 I +ITM,+UNIT S IBCS=0 F  S IBCS=$O(^IBE(363.1,IBCS)) Q:'IBCS  D  I +IBFND Q
 . S IBCSN=$G(^IBE(363.1,IBCS,0))
 . ;
 . I +$G(CT),+$P(IBCSN,U,4),$P(IBCSN,U,4)'=CT Q
 . I +$P($G(^IBE(363.3,+$P(IBCSN,U,2),0)),U,5)'=UNIT Q
 . ;
 . I $O(^IBA(363.2,"AIVDTS"_IBCS,+ITM,"")) S IBFND=1
 ;
 Q IBFND
