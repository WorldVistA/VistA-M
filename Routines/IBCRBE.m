IBCRBE ;ALB/ARH - RATES: BILL ENTER/EDIT (RS/CS) SCREEN ; 22-MAY-1996
 ;;2.0;INTEGRATED BILLING;**52,106,245,287**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ; 
EDIT(IBIFN) ; ENTRY POINT from Enter/Edit a Bill option:  
 ; display available Schedules/Sets for a bill, allow the user to choose the ones to use,
 ; then recalculate the bills charges
 ;
 N IBSRTARR,IBCHGARR,IBUCHGAR I '$G(IBIFN) G EDITQ
 ;
 I '$$DISPLAY(IBIFN,.IBSRTARR) G EDITQ
 ;
 I '$$SELCT(IBIFN,.IBSRTARR,.IBCHGARR) G EDITQ
 ;
 I $O(IBCHGARR(0)) D BILL^IBCRBC(IBIFN,.IBCHGARR)
 ;
 I $O(IBCHGARR(0)),$$SELITEMS^IBCRBEI(IBIFN,.IBCHGARR,.IBUCHGAR) D BILLITEM^IBCRBC(IBIFN,.IBUCHGAR)
 ;
EDITQ Q
 ;
DISPLAY(IBIFN,IBSRTARR) ; get list of all RS/CS combinations available for use on the bill
 ; sort them in name order then display the results to the screen, returns 1 if some found
 N IB0,IBU,IBC,IBRSARR K IBSRTARR S IBC=1
 ;
 S IB0=$G(^DGCR(399,+$G(IBIFN),0)) I IB0="" S IBC=0 G DISPQ
 S IBU=$G(^DGCR(399,+$G(IBIFN),"U")) I 'IBU S IBC=0 G DISPQ
 D RT^IBCRU3($P(IB0,U,7),+$P(IB0,U,5),$P(IBU,U,1,2),.IBRSARR)
 ;
 I 'IBRSARR D NONE($P(IB0,U,1),$P(IB0,U,7),+$P(IB0,U,5),$P(IB0,U,3)),WAIT S IBC=0 G DISPQ
 ;
 D SORTBRS(.IBRSARR,.IBSRTARR,$P(IB0,U,27)),DISPRS($P(IB0,U,7),$P(IB0,U,5),.IBSRTARR)
 ;
DISPQ Q IBC
 ;
SORTBRS(IBRSARR,IBSRTARR,IBBCT) ; return array in rs name, cs name sorted order with external form of data
 ; input:   IBRSARR(rate sched IFN,charge set IFN) = true if auto add
 ; output:  IBSRTARR = CNT of RS/CS to be auto added ^ total CNT
 ;          IBSRTARR(CNT) = rs IFN ^ cs IFN ^ rs name ^ cs name ^ auto add ^ unassoc event ^ chg type ^ disp set
 ;
 N IBRS,IBCS,IBRSN,IBCSN,IBAA,IBUA,IBCT,IBTCNT,IBACNT,IBLN,IBS,ARRX K IBSRTARR S IBBCT=+$G(IBBCT)
 S IBRS=0 F  S IBRS=$O(IBRSARR(IBRS)) Q:'IBRS  D
 . S IBCS=0 F  S IBCS=$O(IBRSARR(IBRS,IBCS)) Q:'IBCS  D
 .. S IBAA=IBRSARR(IBRS,IBCS),IBRSN=$P($G(^IBE(363,+IBRS,0)),U,1),IBCSN=$P($G(^IBE(363.1,+IBCS,0)),U,1)
 .. S IBUA=$S($$CSBR^IBCRU3(IBCS)["UNASSOCIATE":1,1:0),IBCT=$P($G(^IBE(363.1,+IBCS,0)),U,4)
 .. S IBS=$S('IBAA:2,(+IBBCT&(IBBCT'=IBCT)):1,1:" ")_$S(IBCT=1:"I",IBCT=2:"P",1:" ")
 .. I IBRSN'="",IBCSN'="" S ARRX(IBS_IBRSN_IBRS_IBCS,IBCSN)=IBRS_U_IBCS_U_IBRSN_U_IBCSN_U_IBAA_U_IBUA_U_IBCT_U_IBS
 ;
 S (IBTCNT,IBACNT)=0,IBRSN="" F  S IBRSN=$O(ARRX(IBRSN)) Q:IBRSN=""  D
 . S IBCSN="" F  S IBCSN=$O(ARRX(IBRSN,IBCSN)) Q:IBCSN=""  D
 .. S IBLN=ARRX(IBRSN,IBCSN),IBTCNT=IBTCNT+1 I 'IBRSN S IBACNT=IBACNT+1
 .. S IBSRTARR(IBTCNT)=IBLN
 S IBSRTARR=IBACNT_U_IBTCNT
 Q
 ;
DISPRS(RT,BT,IBSRTARR) ; display available rate schedules and charge sets for a bill
 N RTN,IBCNT,IBLN,IBLAST S RTN=$P($G(^DGCR(399.3,+$G(RT),0)),U,1),BT=$G(BT)
 W @IOF,!?5,"Rate Schedules available for an "_$S(BT>2:"Outpatient ",BT>0:"Inpatient ",1:"")_$E(RTN,1,27)_" bill"
 W !,"------------------------------------------------------------------------------"
 ;
 S IBCNT=0 F  S IBCNT=$O(IBSRTARR(IBCNT)) Q:'IBCNT  D
 . S IBLN=$G(IBSRTARR(IBCNT)) I +$P(IBLN,U,8)'=+$G(IBLAST) W ! S IBLAST=+$P(IBLN,U,8)
 . W !,?3,IBCNT,")",?8,$P(IBLN,U,3),?31,$P(IBLN,U,4),?69,$S(+$P(IBLN,U,7)=1:"INST",$P(IBLN,U,7)=2:"PROF",1:""),?75,$S(+$P(IBLN,U,6):"s",1:""),?77,$S('$P(IBLN,U,5):"*",1:"")
 ;
 Q
 ;
SELCT(IBIFN,IBSRTARR,IBCHGARR) ; get the user selection of rs/cs charges to add to the bill
 ; input:   IBSRTARR = CNT of RS/CS to be auto added ^ total CNT
 ;          IBSRTARR(CNT) = rs IFN ^ cs IFN ^ rs name ^ cs name ^ Auto Add ^ unassoc event ^ chg type ^ disp set
 ; output:  IBCHGARR(rate sched IFN,charge set IFN) = 1 - add charges for rs/cs
 ;
 N IBCHNG,IBSEL,IBI,IBS,IBX,IBLN,DIR,DIRUT,DUOUT,DTOUT,X,Y K IBCHGARR S IBCHNG=0 I '$G(IBIFN) G SELCTQ
 I '$O(IBSRTARR(0)) G SELCTQ
 ;
 S DIR("?")="Enter the number (1-"_+$P(IBSRTARR,U,2)_") preceding the Rate Schedule/Charge Sets that apply to this bill.  All associated charges will be added to the bill."
 S DIR("?",1)="* - these charges are available to be added to this bill if selected here,"
 S DIR("?",2)="    but will not be added when the bills charges are automatically calculated."
 S DIR("?",3)="s - the items these charges are associated with must be specifically"
 S DIR("?",4)="    selected here, they do not relate to any item on the bill.",DIR("?",5)=" "
 S DIR("?",6)="If the bill's charge type is exclusively institutional or professional then"
 S DIR("?",7)="only sets of charges with a corresponding type will be added when the bills"
 S DIR("?",8)="charges are automatically calculated.  On this screen, these charges will be"
 S DIR("?",9)="displayed in the first set and used as the selection default.",DIR("?",10)=" "
 S DIR("??")="^D HELP^IBCRBE("_IBIFN_")"
 S DIR("A")="Select Schedule Charges to ADD to the bill: " I +IBSRTARR S DIR("B")="1-"_+IBSRTARR
 ;
 W !! S DIR(0)="LOA^1:"_+$P(IBSRTARR,U,2) D ^DIR K DIR I 'Y!$D(DIRUT) G SELCTQ
 ;
 S IBX="" F  S IBX=$O(Y(IBX)) Q:IBX=""  D
 . S IBSEL=Y(IBX) F IBI=1:1:100 S IBS=$P(IBSEL,",",IBI) Q:'IBS  D
 .. I $D(IBSRTARR(IBS)) S IBCHNG=1,IBLN=IBSRTARR(IBS),IBCHGARR(+IBLN,$P(IBLN,U,2))=1
 ;
SELCTQ Q IBCHNG
 ;
NONE(IBBN,RT,BT,EVDT) ; write message indicating no rate schedules defined for this bill
 N IBRTN S BT=+$G(BT),EVDT=$G(EVDT),IBRTN=$P($G(^DGCR(399.3,+$G(RT),0)),U,1)
 W !,?7 I +EVDT W !,?7,"On ",$$DATE^IBCRU1(+EVDT),", there are "
 W "No Rate Schedules with charges defined "
 I IBRTN'="" W:+EVDT !,?20 W "for ",$S(BT>2:"Outpatient ",BT>0:"Inpatient ",1:""),IBRTN
 I $G(IBBN)'="" W !!,?7,"Therefore, charges can not be calculated for this bill (",IBBN,") "
 W !
 Q
 ;
WAIT N DIR,DIRUT,DUOUT,DTOUT,Y,X S DIR("A")="Press RETURN to continue",DIR(0)="E" D ^DIR K DIR
 Q
 ;
HELP(IBIFN) ; display rs/cs for the bill - used as help text
 N IBX I +$G(IBIFN) S IBX=$$DISPLAY(IBIFN)
 Q
