IBCRBEI ;ALB/ARH - RATES: BILL ENTER/EDIT (RS/CS) SCREEN - BI ; 10-OCT-1998
 ;;2.0;INTEGRATED BILLING;**106**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; this routines is used for those Billing Rates and Charge Setes that have items that are Unassociated.
 ; this means is no billable item on the bill for the auto calculator to calculate charges for
 ; the user must select the items they want to bill from the list of Miscellaneous items,
 ; then the charge will be calculated and added to the bill.
 ;
SELITEMS(IBIFN,IBURSARR,IBUCHGAR) ; ask user to select items to bill, only Charges Sets with Billable Item of UNASSOCIATED allowed
 ; Output:  IBUCHGAR(RS,CS,x) = item ptr+ ^ date ^ units ^ division ^ rev code
 ;          returns count of unassociated items selected
 N IBRS,IBCS,IBCS0,IBBEVNT,IBCNT,IBFND,IBITCHG K IBUCHGAR S (IBFND,IBCNT)=0
 ;
 S IBRS=0 F  S IBRS=$O(IBURSARR(IBRS)) Q:'IBRS  S IBCS=0 F  S IBCS=$O(IBURSARR(IBRS,IBCS)) Q:'IBCS  D
 . S IBCS0=$G(^IBE(363.1,+IBCS,0)),IBBEVNT=$$EMUTL^IBCRU1(+$P(IBCS0,U,3))
 . ;
 . I IBBEVNT'["UNASSOCIATED" Q
 . S IBFND=IBFND+1
 . ;
 . W @IOF,!!,"Select items from "_$P(IBCS0,U,1)_" to add to the bill's charges:"
 . W !,"------------------------------------------------------------------------------"
 . F  S IBITCHG=$$ITEM(IBIFN,IBRS,IBCS) Q:IBITCHG<0  D  W !
 .. I +IBITCHG S IBCNT=+$G(IBUCHGAR)+1,IBUCHGAR=IBCNT,IBUCHGAR(IBRS,IBCS,IBCNT)=IBITCHG
 ;
 I +IBFND,'$$DISPLAY(.IBUCHGAR) K IBUCHGAR S IBCNT=0
 Q IBCNT
 ;
DISPLAY(IBUCHGAR) ; prints items selected then ask if user wants to add these charges to the bill, return true if yes
 N IBS,IBI,IBJ,IBK,IBLINE,DIR,DIRUT,DTOUT,DUOUT,X,Y S IBS=0
 ;
 I '$G(IBUCHGAR) W @IOF S DIR("A")="No items selected, press return to continue",DIR(0)="E" D ^DIR G DISPQ
 ;
 W @IOF,!,"The following items have been selected to add to the bill's charges:"
 W !!!,?5,"Item",?35,"Date",?48,"Units",?60,"Division"
 W !,"-------------------------------------------------------------------------------"
 ;
 S IBI=0 F  S IBI=$O(IBUCHGAR(IBI)) Q:'IBI  S IBJ=0 F  S IBJ=$O(IBUCHGAR(IBI,IBJ)) Q:'IBJ  D
 . S IBK=0 F  S IBK=$O(IBUCHGAR(IBI,IBJ,IBK)) Q:'IBK  S IBLINE=$G(IBUCHGAR(IBI,IBJ,IBK)) I IBLINE'=""  D
 .. W !,?3,$$EXPAND^IBCRU1(363.2,.01,$P(IBLINE,U,1)),?35,$$DATE^IBCRU1(+$P(IBLINE,U,2)),?48,$J($P(IBLINE,U,3),4),?60,$P($G(^DG(40.8,+$P(IBLINE,U,4),0)),U,2)
 ;
 W !! S DIR(0)="YO",DIR("A")="Add these Charges to the Bill" D ^DIR K DIR S:Y=1 IBS=1 I 'Y!$D(DIRUT) S IBS=0
 ;
DISPQ Q IBS
 ;
ITEM(IBIFN,IBRS,IBCS) ; ask user for one item to charge from the Charge Set
 ; returns:  item ptr+ ^ date ^ units ^ division ^ rev code, -1 if no item or null if data missing
 N IBBDIV,IBEVDT,IBBEG,IBEND,IBCS0,IBITEM,IBDT,IBUNITS,IBDV,IBRVCD,IBCOST,IBLINE S IBLINE=""
 ;
 S IBBDIV=$G(^DGCR(399,+IBIFN,0)),IBEVDT=$P(IBBDIV,U,3),IBBDIV=$P(IBBDIV,U,22)
 S IBBEG=$G(^DGCR(399,+IBIFN,"U")),IBEND=$P(IBBEG,U,2),IBBEG=+IBBEG I IBEVDT<IBBEG S IBEVDT=IBBEG
 S IBCS0=$G(^IBE(363.1,+IBCS,0))
 ;
 S IBITEM=$$GETITEM^IBCRU1(IBCS) I IBITEM'>0 S IBLINE=-1 G ITEMQ
 S IBITEM=+IBITEM_$P(IBITEM,U,3)
 ;
 S IBDT=$$GETDT^IBCRU1(IBEVDT,"Service Date",IBBEG,IBEND) G:IBDT'?7N ITEMQ
 ;
 S IBUNITS=$$UNITS G:'IBUNITS ITEMQ
 ;
 S IBDV="" I +$P(IBCS0,U,7) S IBDV=$$DIV(+$P(IBCS0,U,7),IBBDIV) G:'IBDV ITEMQ
 ;
 S IBRVCD=$$RVCD(IBCS,IBITEM,IBDT) G:'IBRVCD ITEMQ
 ;
 S IBCOST=+$$ITCOST^IBCRCI(IBRS,IBCS,IBITEM,IBDT,"",IBDV,1) W !,"Charge: ",$J(IBCOST,10,2)
 ;
 W !,"Total:  ",$J((IBUNITS*IBCOST),10,2)
 ;
 S IBLINE=IBITEM_U_IBDT_U_IBUNITS_U_IBDV_U_IBRVCD
 ;
ITEMQ Q IBLINE
 ;
UNITS() ; ask user for number of units, return number of units or 0
 N IBUNIT,DIR,DIRUT,DTOUT,DUOUT,X,Y S IBUNIT=0
 S DIR("?")="Enter the number of units of service (accommodation days, miles, treatments, etc.) rendered to or for this patient for this service."
 S DIR("?",1)="This is the number times this service was provided to the patient."
 S DIR("?",2)="This number will be multiplied by the service CHARGE to determine"
 S DIR("?",3)="the TOTAL charges for this service.  Enter a positive whole number.",DIR("?",4)=""
 ;
 S DIR("B")=1,DIR("A")="Number of Units: ",DIR(0)="NOA^1::0" D ^DIR S:+Y>0 IBUNIT=+Y  I 'Y!$D(DIRUT) S IBUNIT=0
 Q IBUNIT
 ;
DIV(IBCSRG,IBBDIV) ; ask user for division, return Division IFN or 0, only divisions within the CS region allowed
 N IBDV,IBDDV,DIR,DIRUT,DTOUT,DUOUT,X,Y S IBCSRG=$G(IBCSRG),IBBDIV=$G(IBBDIV),IBDV=0
 S IBDDV=$G(^DG(40.8,+$G(^IBE(363.31,+IBCSRG,11,1,0)),0))
 I +IBBDIV S IBBDIV=$G(^DG(40.8,+IBBDIV,0))
 ;
 S DIR("?")="Enter the division where this service took place."
 S DIR("?",1)="This Charge Set has a Billing Region, therefore all services must be"
 S DIR("?",2)="associated with one of that region's divisions for a charge to be applied.",DIR("?",3)=" "
 S DIR("?",4)="Only Divisions associated with the Charge Sets Billing Region"
 S DIR("?",5)=$P($$RGEXT^IBCRU4(+IBCSRG),U,1)_" will be allowed.  If the correct division is not in the"
 S DIR("?",6)="list then this service does not have a charge in this set, enter '^'.",DIR("?",7)=" "
 I IBBDIV'="" S DIR("?",8)="The bills Default Division is: "_$P(IBBDIV,U,1)_"  "_$P(IBBDIV,U,2),DIR("?",9)=" "
 ;
 S DIR("B")=$P(IBDDV,U,2),DIR("S")="I $D(^IBE(363.31,"_+IBCSRG_",11,""B"",Y))"
 S DIR("A")="DIVISION",DIR(0)="PO^40.8:AEMQ" D ^DIR K DIR S:+Y>0 IBDV=+Y I 'Y!$D(DIRUT) S IBDV=0
 Q IBDV
 ;
RVCD(IBCS,IBITEM,IBEFDT) ; ask user for a specific revenue code, return Rev Code IFN or 0
 N IBCI,IBIDRV,IBSDRV,IBC,IBRVCD,DIR,DIRUT,DTOUT,DUOUT,X,Y S (IBIDRV,IBSDRV)="",(IBRVCD,IBC)=0
 ;
 I +$$FNDCI^IBCRU4(+$G(IBCS),+$G(IBITEM),+$G(IBEFDT),.IBCI) S IBCI=$O(IBCI(0))
 I +$G(IBCI) S IBIDRV=$P(IBCI(IBCI),U,6) I +IBIDRV S IBIDRV=$G(^DGCR(399.2,+IBIDRV,0))
 I +$G(IBCS) S IBSDRV=$P($G(^IBE(363.1,+$G(IBCS),0)),U,5) I +IBSDRV S IBSDRV=$G(^DGCR(399.2,+IBSDRV,0))
 ;
 S DIR("?")="Enter the Revenue Code to associate with this charge on the bill."
 I +IBSDRV S IBC=IBC+1,DIR("?",IBC)="The Charge Set Default Revenue Code is "_$P(IBSDRV,U,1)_" "_$P(IBSDRV,U,2)
 I +IBIDRV S IBC=IBC+1,DIR("?",IBC)="The Charge Item Default Revenue Code is "_$P(IBIDRV,U,1)_" "_$P(IBIDRV,U,2)
 S IBC=IBC+1,DIR("?",IBC)=" "
 ;
 S DIR("B")=$S(IBIDRV'="":$P(IBIDRV,U,1),IBSDRV'="":$P(IBSDRV,U,1),1:""),DIR("S")="I +$P(^(0),U,3)"
 S DIR("A")="Revenue Code",DIR(0)="PO^399.2:AEMQ" D ^DIR K DIR S:+Y>0 IBRVCD=+Y I 'Y!$D(DIRUT) S IBRVCD=0
 Q IBRVCD
