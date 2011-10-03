IBCRBH1 ;ALB/ARH - RATES: BILL HELP DISPLAYS - CHARGES ; 10-OCT-1998
 ;;2.0;INTEGRATED BILLING;**106,245,370**;21-MAR-94;Build 5
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
DISPCHG(IBIFN) ; display a bills items and their charges, display only, does not change the charges on the bill
 ;
 D BILL(IBIFN,1),SORTCI(IBIFN),DSPCHRG(1) ;     display auto add charges
 K ^TMP($J,"IBCRCC"),^TMP($J,"IBCRCSX"),^TMP($J,"IBCRCSXR"),^TMP($J,"IBCRCSXN")
 D BILL(IBIFN,""),SORTCI(IBIFN),DSPCHRG("") ;   display non-auto add charges
 K ^TMP($J,"IBCRCC"),^TMP($J,"IBCRCSX"),^TMP($J,"IBCRCSXR"),^TMP($J,"IBCRCSXN")
 D NOTES(IBIFN,1)
 Q
 ;
BILL(IBIFN,IBAA,IBRSARR) ; given a bill number calculate charges using schedules that match the auto add flag
 ; if IBRSARR is defined it will be used to create charges rather than the standard set for the bills Rate Type
 ; Output:  ^TMP($J,"IBCRCC" - same as would be calculated if the charges were being added to bill
 ;
 N IB0,IBU,IBBRT,IBBTYPE,IBCTYPE,IBRS,IBCS,IBBEVNT Q:'$G(IBIFN)
 K ^TMP($J,"IBCRCC")
 ;
 S IB0=$G(^DGCR(399,+IBIFN,0)) Q:IB0=""  S IBU=$G(^DGCR(399,+IBIFN,"U")) Q:'IBU
 S IBBRT=+$P(IB0,U,7),IBBTYPE=$S($P(IB0,U,5)<3:1,1:3),IBCTYPE=+$P(IB0,U,27)
 ;
 ; get standard set of all rate schedules and charge sets available for the bill
 I '$D(IBRSARR) D RT^IBCRU3(IBBRT,IBBTYPE,$P(IBU,U,1,2),.IBRSARR,"",IBCTYPE) I 'IBRSARR G END
 ;
 ; process charge sets - set all charges for the bill into array
 S IBRS=0 F  S IBRS=$O(IBRSARR(IBRS)) Q:'IBRS  D
 . S IBCS=0 F  S IBCS=$O(IBRSARR(IBRS,IBCS)) Q:'IBCS  I IBRSARR(IBRS,IBCS)=IBAA D
 .. S IBBEVNT=+$P($G(^IBE(363.1,+IBCS,0)),U,3) Q:'IBBEVNT  S IBBEVNT=$$EMUTL^IBCRU1(IBBEVNT) Q:IBBEVNT=""
 .. ;
 .. I IBBEVNT["INPATIENT BEDSECTION STAY" D INPTBS^IBCRBC1(IBIFN,IBRS,IBCS)
 .. I IBBEVNT["INPATIENT DRG" D INPTDRG^IBCRBC11(IBIFN,IBRS,IBCS)
 .. I IBBEVNT["OUTPATIENT VISIT DATE" D OPTVST^IBCRBC1(IBIFN,IBRS,IBCS)
 .. I IBBEVNT["PRESCRIPTION" D RX^IBCRBC1(IBIFN,IBRS,IBCS)
 .. I IBBEVNT["PROSTHETICS" D PI^IBCRBC1(IBIFN,IBRS,IBCS)
 .. I IBBEVNT["PROCEDURE" D CPT^IBCRBC1(IBIFN,IBRS,IBCS)
 ;
END Q
 ;
 ;
SORTCI(IBIFN) ; process charge array - create new array in sorted order with items combined, if possible
 ; if bs, rv cd, charge, cpt, div, item type, item ptr and component all match then charge is combined
 ; Input:  TMP($J,"IBCRCC",X) = ...  (from IBCRBC2)
 ; Output: TMP($J,"IBCRCSX",X) = 
 ;         RV CD ^ BS ^ CHG ^ UNITS ^ CPT ^ DIV ^ ITM TYPE ^ ITM PTR ^ CHRG CMPNT ^ CHRG SET ^ EVNT DT ^ ITM NAME
 ;         TMP($J,"IBCRCSX",X,"CC",Y) = charge adjustment messages
 ;         TMP($J,"IBCRCSXR",BS,RV CD,X) = ""
 ;         TMP($J,"IBCRCSXN",DATE,ITEM NAME,X) = ""
 ;
 N IBI,IBLN,IBRVCD,IBBS,IBCHG,IBUNITS,IBCPT,IBDV,IBIT,IBIP,IBCMPT,IBCS,IBDT,IBNM,IBTUNITS,IBK,IBJ,IBX,IBY
 K ^TMP($J,"IBCRCSX"),^TMP($J,"IBCRCSXR"),^TMP($J,"IBCRCSXN")
 ;
 S IBI=0 F  S IBI=$O(^TMP($J,"IBCRCC",IBI)) Q:'IBI  D
 . ;
 . S IBLN=^TMP($J,"IBCRCC",IBI)
 . S IBRVCD=$P(IBLN,U,6),IBBS=$P(IBLN,U,7),IBCHG=+$FN($P(IBLN,U,12),"",2),IBUNITS=$P(IBLN,U,13)
 . S IBCPT=$P(IBLN,U,14),IBDV=$P(IBLN,U,15),IBIT=$P(IBLN,U,16),IBIP=$P(IBLN,U,17),IBCMPT=$P(IBLN,U,18)
 . S IBCS=$P(IBLN,U,2),IBDT=$P(IBLN,U,8),IBNM=$$ITMNM($G(IBIFN),IBBS,IBIT,IBIP,IBCPT)
 . ;
 . ; combine like charges, unless there are comments
 . S (IBTUNITS,IBK,IBJ)=0 F  S IBJ=$O(^TMP($J,"IBCRCSXR",+IBBS,+IBRVCD,IBJ)) Q:'IBJ  S IBK=IBJ D  Q:+IBTUNITS
 .. I $D(^TMP($J,"IBCRCC",IBI,"CC")) Q
 .. S IBX=$G(^TMP($J,"IBCRCSX",IBJ))
 .. I IBCHG=$P(IBX,U,3),IBCPT=$P(IBX,U,5),IBDV=$P(IBX,U,6),IBIT=$P(IBX,U,7),IBIP=$P(IBX,U,8),IBCMPT=$P(IBX,U,9) D
 ... S IBTUNITS=$P(IBX,U,4),IBDT=$P(IBX,U,11)
 . ;
 . I 'IBTUNITS S IBK=IBI ; no combination, new line item charge
 . S IBTUNITS=IBTUNITS+IBUNITS
 . ;
 . S ^TMP($J,"IBCRCSXR",+IBBS,+IBRVCD,IBK)=""
 . S ^TMP($J,"IBCRCSXN",IBDT_" ",IBNM_" ",IBK)=""
 . S ^TMP($J,"IBCRCSX",IBK)=IBRVCD_U_+IBBS_U_IBCHG_U_IBTUNITS_U_IBCPT_U_IBDV_U_IBIT_U_IBIP_U_IBCMPT_U_IBCS_U_IBDT_U_IBNM
 . S IBY=0 F  S IBY=$O(^TMP($J,"IBCRCC",IBI,"CC",IBY)) Q:'IBY  S ^TMP($J,"IBCRCSX",IBK,"CC",IBY)=^TMP($J,"IBCRCC",IBI,"CC",IBY)
 Q
 ;
DSPCHRG(AA) ; display charges
 ; Input: TMP($J,"IBCRCSx",...) = ... (from SORTCI)
 ;
 N IBX,IBI,IBJ,IBK,IBLN,IBCNT,IBRVCD,IBCHG,IBUNITS,IBDV,IBCMPT,IBCS,IBDT,IBNM,IBTOTAL,IBQUIT,IBY S (IBTOTAL,IBQUIT)=0
 ;
 D DSPHDR(AA) S IBCNT=4
 ;
 S IBI="" F  S IBI=$O(^TMP($J,"IBCRCSXN",IBI)) Q:IBI=""  D  Q:IBQUIT
 . S IBJ="" F  S IBJ=$O(^TMP($J,"IBCRCSXN",IBI,IBJ)) Q:IBJ=""  D  Q:IBQUIT
 .. S IBK=0 F  S IBK=$O(^TMP($J,"IBCRCSXN",IBI,IBJ,IBK)) Q:'IBK  D  Q:IBQUIT
 ... S IBLN=$G(^TMP($J,"IBCRCSX",IBK)) Q:IBLN=""
 ... ;
 ... ; add charges to RC multiple
 ... S IBRVCD=$P(IBLN,U,1),IBCHG=$P(IBLN,U,3),IBUNITS=$P(IBLN,U,4),IBDV=$P(IBLN,U,6)
 ... S IBCMPT=$P(IBLN,U,9),IBCS=$P(IBLN,U,10),IBDT=$P(IBLN,U,11),IBNM=$P(IBLN,U,12)
 ... S IBTOTAL=IBTOTAL+(IBCHG*IBUNITS),IBCNT=IBCNT+1
 ... ;
 ... S IBX=IBRVCD_U_IBCHG_U_IBUNITS_U_IBCMPT_U_IBCS_U_IBDT_U_IBDV_U_IBNM D DSPLN(IBX)
 ... ;
 ... S IBY=0 F  S IBY=$O(^TMP($J,"IBCRCSX",IBK,"CC",IBY)) Q:'IBY  D
 .... S IBX=$G(^TMP($J,"IBCRCSX",IBK,"CC",IBY)) I IBX'="" D DISPLNC(IBX) S IBCNT=IBCNT+1
 ... I $O(^TMP($J,"IBCRCSX",IBK,"CC",0)) D DISPLNC("") S IBCNT=IBCNT+1
 ... ;
 ... I IBCNT>20 S IBQUIT=$$PAUSE(IBCNT) Q:IBQUIT  D DSPHDR(AA) S IBCNT=4
 ;
 I +IBTOTAL W !,?72,"--------",!,?70,$J(IBTOTAL,10,2) S IBCNT=IBCNT+2
 I 'IBQUIT S IBQUIT=$$PAUSE(IBCNT)
 Q
 ;
DSPHDR(AA) ;
 W @IOF,!,"Items and Charges on this Bill ("_$S('AA:"NOT ",1:"")_"Auto Add)"
 W !,"Item",?18,"Date",?28,"Charge Set",?40,"Div",?47,"Type",?52,"RvCd",?57,"Units",?64,"Charge",?75,"Total"
 W !,"--------------------------------------------------------------------------------"
 Q
 ;
DSPLN(LN) ;
 N CS,DIV,CMP,RVCD,ITM,CHG,UNIT S LN=$G(LN)
 S CS=$P(LN,U,5) I +CS S CS=$P($G(^IBE(363.1,+$P(LN,U,5),0)),U,1)
 S DIV=$P($G(^DG(40.8,+$P(LN,U,7),0)),U,2)
 S CMP=$S($P(LN,U,4)=1:"INST",$P(LN,U,4)=2:"PROF",1:"")
 S RVCD=$P($G(^DGCR(399.2,+LN,0)),U,1)
 S ITM=$P(LN,U,8),CHG=+$P(LN,U,2),UNIT=$P(LN,U,3)
 W !,$E(ITM,1,15),?18,$$DATE($P(LN,U,6)),?28,$E(CS,1,7),?40,DIV,?47,CMP,?52,RVCD,?57,$J(UNIT,3),?62,$J(CHG,8,2),?71,$J((UNIT*CHG),9,2)
 Q
 ;
DISPLNC(LN) ; display charge adjustment commenmts
 W !,?18,$G(LN)
 Q
 ;
DATE(X) ;
 S X=$G(X),X=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3)
 Q X
 ;
PAUSE(CNT) ;
 N IBI F IBI=CNT:1:22 W !
 N DIR,DUOUT,DTOUT,DIRUT,IBX,X,Y S IBX=0,DIR(0)="E" D ^DIR K DIR I $D(DIRUT) S IBX=1
 Q IBX
 ;
ITMNM(IBIFN,IBBS,IBIT,IBIP,IBCPT) ; return external form of the item name
 N ITM S ITM="",IBBS=$G(IBBS),IBIT=$G(IBIT),IBIP=$G(IBIP),IBCPT=$G(IBCPT)
 I +IBIP S ITM=$$NAME^IBCSC61(IBIT,IBIP)
 I ITM="",+IBIT=4,+$G(IBIFN) S ITM=$$CPTNM(IBIFN,IBIT,IBIP)
 I ITM="",+IBCPT S ITM=$P($$CPT^ICPTCOD(+IBCPT,DT),U,2)
 I ITM="" S ITM=$$EMUTL^IBCRU1(IBBS)
 Q ITM
 ;
CPTNM(IBIFN,TYPE,ITEM) ; retrurn external name of the charge item if it is a CPT item (type=399,42,.1)
 N IBX,NAME S IBX=0,NAME=""
 I +$G(TYPE)=4 S IBX=$G(^DGCR(399,+$G(IBIFN),"CP",+$G(ITEM),0))
 I +IBX S NAME=$P($$CPT^ICPTCOD(+$P(IBX,U,1),DT),U,2)
 I +IBX S IBX=$$GETMOD^IBEFUNC(+$G(IBIFN),+$G(ITEM),1) I IBX'="" S NAME=NAME_"-"_IBX
 Q NAME
 ;
 ;
 ;
 ;
NOTES(IBIFN,PAUSE) ; compile and print charge notes for a bill
 ;
 ; Current Checks are for those Treating Specialties that should not be billed using DRG:
 ; - Inpatient Institutional Reasonable Charges bill contains SNF Treating Specialty
 ; - Inpatient Institutional Reasonable Charges bill contains Observation Treating Specialty
 ;
 I $D(ZTQUEUED)!(+$G(IBAUTO)) Q
 N IB0,IBU,PTF,BEG,END,IBMVLN,IBENDDT,IBMDRG,IBFND,IBMSG,IBX S IBFND=0 K ^TMP($J,"IBCRC-PTF")
 S IB0=$G(^DGCR(399,+$G(IBIFN),0)) Q:IB0=""  S IBU=$G(^DGCR(399,+$G(IBIFN),"U")) Q:'IBU
 ;
 I '$$BILLRATE^IBCRU3($P(IB0,U,7),$P(IB0,U,5),$P(IB0,U,3),"RC") Q  ; not Reasonable Charges bill
 ;
 ; Outpatient Freestanding bill: display message if this is a non-provider based freestanding bill
 I $P(IB0,U,5)=3,$P(IB0,U,3)'<$$VERSDT^IBCRU8(2),$P($$RCDV^IBCRU8(+$P(IB0,U,22)),U,3)=3 D
 . S IBFND=IBFND+1,IBX=">>> Bill Division is Freestanding Non-Provider with Professional Charges only.",IBMSG(IBFND)=IBX
 ;
 ; Inpatient Institutional bill: check for treating specialties that should not be billed by DRG
 I +$P(IB0,U,8),$P(IB0,U,5)<3,$P(IB0,U,27)<2 D
 . ;
 . S PTF=+$P(IB0,U,8),BEG=+$P(IBU,U,1)\1,END=$S(+$P(IBU,U,2):+$P(IBU,U,2)\1,1:DT)
 . ;
 . D PTF^IBCRBG(PTF)
 . ;
 . S IBENDDT=BEG F  S IBENDDT=$O(^TMP($J,"IBCRC-PTF",IBENDDT)) Q:'IBENDDT  D  I IBENDDT>END Q
 .. I (IBENDDT\1)=BEG,BEG'=END Q
 .. ;
 .. S IBMVLN=$G(^TMP($J,"IBCRC-PTF",IBENDDT)),IBMVLN=+$P(IBMVLN,U,6) Q:'IBMVLN
 .. S IBMDRG=$$NODRG^IBCRBG2(IBMVLN) Q:'IBMDRG
 .. ;
 .. S IBFND=IBFND+1,IBX=">>> "_$P(IBMDRG,U,2)_" ("_$$FMTE^XLFDT(IBENDDT,2)_") not billed using DRG"
 .. S:IBMDRG["Nursing" IBX=IBX_", use SNF." S:IBMDRG["Observa" IBX=IBX_", use Procedures."
 .. S IBMSG(IBFND)=$G(IBX)
 ;
 I +IBFND D  I +$G(PAUSE) S IBFND=$$PAUSE(21)
 . W ! S IBX="" F  S IBX=$O(IBMSG(IBX)) Q:IBX=""  W !,IBMSG(IBX)
 K ^TMP($J,"IBCRC-PTF")
 Q
