IBCRED ;ALB/ARH - RATES: CM DELETE CHARGE ITEMS OPTION ; 22-MAY-1996
 ;;2.0;INTEGRATED BILLING;**52,106,148,307**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
ENTER ; OPTION ENTRY POINT:  delete charge items for a specific charge set, may be inactive by a date or all
 ;
 W @IOF W !,?12,"**** DELETE INACTIVE CHARGE ITEMS FROM A CHARGE SET ****"
 W !!,?5,"For a given Charge Set, this option allows deletion of all chargeable items",!,?5,"that have been inactivated or replaced before a certain date.",!
 W !,?5,"Since all charges for a billing rate and date range may be deleted with",!,?5,"this option, caution is advised.",!
 ;
 N IBCS,IBDT,IBCSDEL,IBQUIT,DIR,DTOUT,DUOUT,DIRUT,X,Y S IBDT=0,IBCSDEL=0 K ^TMP($J,"IBCRED")
 ;
 W !!,"The Charge Set to delete Charge items from:" S IBCS=$$GETCS^IBCRU1 I +IBCS<1 Q
 ;
 W ! S DIR(0)="YO",DIR("A")="Delete ALL charges for this Charge Set" D ^DIR K DIR Q:$D(DIRUT)  I Y=1 S IBDT="ALL"
 I IBDT="ALL" I IBCS>999!($P(IBCS,U,2)["RC-")!($P(IBCS,U,2)["CMAC") D
 . S DIR("?")="Enter Yes to delete the Charge Set and it's links with Rate Schedules and Special Groups.  The sets Region will also be deleted if not associated with another set."
 . S DIR(0)="YO",DIR("A")="Also delete the Charge Set "_$P(IBCS,U,2) D ^DIR K DIR Q:$D(DIRUT)  I Y=1 S IBCSDEL=1
 ;
 I IBDT'="ALL" W !!,"All charges inactive before this date will be deleted:" S IBDT=$$GETDT^IBCRU1(,"Select INACTIVE DATE") I IBDT'?7N W !,"No deletions",! Q
 ;
 S DIR(0)="SO^1:Print List of Charges that will be Deleted;2:Delete Charges" D ^DIR K DIR I +Y<1!$D(DIRUT) Q
 I +Y=1 D DEV Q:+$G(IBQUIT)  G RPT
 ;
 W !!!,"All charges",$S('IBDT:"",1:" inactive before "_$$DATE(IBDT))," for ",$P(IBCS,U,2)," will be deleted.",!
 ;
 S DIR(0)="YO",DIR("A")="Is this correct, do you want to continue" D ^DIR K DIR I Y'=1 W !,"No deletions",!
 ;
 I Y=1 D
 . W !,"Beginning Deletions" W !,$$DELETE(IBCS,IBDT)," charges deleted."
 . I +IBCSDEL W !!,$P(IBCS,U,2)," ",$P($$CSDELETE(+IBCS),U,2)
 Q
 ;
DELETE(CS,INDT,SAVE) ; delete all charge items in a set inactive before a certain date
 ; Input:   CS   - set to delete charges from, 
 ;          INDT - charges not active on this date will be deleted, if ALL- all charges will be deleted from set
 ;          SAVE - if true, charge items that would be deleted are entered into TMP array for printing instead
 ; Output:  returns the count of the charge items deleted
 ;
 N IBXRF,IBCNT,IBSUB2,IBEFDT,IBITM,IBCIFN,IBINDTCI
 S IBXRF="AIVDTS"_+$G(CS),IBCNT=0,INDT=$G(INDT),IBSUB2="" I INDT="ALL" S INDT=9999999
 I +$G(SAVE) S IBSUB2=$$TMPHDR($G(CS),INDT)
 ;
 S IBITM=0 F  S IBITM=$O(^IBA(363.2,IBXRF,IBITM)) Q:'IBITM  D
 . S IBEFDT=0 F  S IBEFDT=$O(^IBA(363.2,IBXRF,IBITM,IBEFDT),-1) Q:'IBEFDT!(IBEFDT'>-INDT)  D
 .. S IBCIFN=0 F  S IBCIFN=$O(^IBA(363.2,IBXRF,IBITM,IBEFDT,IBCIFN)) Q:'IBCIFN  D
 ... ;
 ... S IBINDTCI=$$INACTCI^IBCRU4(IBCIFN)
 ... I INDT=9999999 D DELCI(IBCIFN,IBSUB2) S IBCNT=IBCNT+1 Q
 ... I +IBINDTCI,IBINDTCI<INDT D DELCI(IBCIFN,IBSUB2) S IBCNT=IBCNT+1
 ;
 Q IBCNT
 ;
DELCI(CI,SUB2) ; either save in TMP arry to print or delete
 I $G(SUB2)'="" D TMPLN^IBCROI1(CI,"IBCRED",SUB2,1) Q
 I $G(^IBA(363.2,+$G(CI),0)) S DA=CI,DIK="^IBA(363.2," D ^DIK K DA,DIK
 Q
 ;
DATE(X) ;
 Q $E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3)
 ;
TMPHDR(CS,INDT) ; set up array header for printed report
 N IBHDR,IBHDR2,IBDT,SUB2 S SUB2=$P($G(^IBE(363.1,+CS,0)),U,1)
 S IBHDR="Charges (to be deleted) in "_SUB2_" set"
 S IBHDR2=" inactive before",IBDT=INDT I IBDT=9999999 S IBHDR2=" (ALL CHARGES IN SET)",IBDT=""
 D TMPHDR^IBCROI1("IBCRED",SUB2,+CS,IBHDR_IBHDR2,"2^1",IBDT)
 Q SUB2
 ;
 ;
DEV ; get device for printed report
 S IBQUIT=0 S %ZIS="QM",%ZIS("A")="OUTPUT DEVICE: " D ^%ZIS I POP S IBQUIT=1 Q
 I $D(IO("Q")) S ZTRTN="RPT^IBCRED",ZTDESC="Delete Charges Report",ZTSAVE("IB*")="" D ^%ZTLOAD K IO("Q") S IBQUIT=1
 Q
 ;
RPT ; print report - entry point for tasked jobs
 N IBSCRPT,IBCNT S IBSCRPT="IBCRED" K ^TMP($J,"IBCRED")
 S IBCNT=$$DELETE(IBCS,IBDT,1)
 I $D(^TMP($J,"IBCRED")) S $P(^TMP($J,"IBCRED"),U,4)=IBCNT_" Charges to be deleted"
 G RPT^IBCROI
 Q
 ;
CSDELETE(IBCS) ; delete a Charge Set, including all pointers to it, also delete region if not assigned to another set
 N IBFN,IB11,IBRG,IBER,DA,DIC,DIE,DIK,X,Y S IBER="0^Charge Set not deleted"
 I '$D(^IBE(363.1,+$G(IBCS),0)) G CSDELQ
 I $O(^IBA(363.2,"AIVDTS"_+IBCS,"")) S IBER="0^Charge Set has associated Charge Items, can not delete." G CSDELQ
 I $P($G(^IBE(350.9,1,9)),U,12)=+IBCS S IBER="0^Charge Set pointed to by AWP CHARGE SET Site Parameter, can not delete." G CSDELQ
 ;
 ; remove from Rate Schedule
 S IBFN=0 F  S IBFN=$O(^IBE(363,"C",+IBCS,IBFN)) Q:'IBFN  D
 . S IB11="" F  S IB11=$O(^IBE(363,"C",+IBCS,IBFN,IB11)) Q:'IB11  D
 .. I +$G(^IBE(363,+IBFN,11,+IB11,0))=+IBCS S DA(1)=+IBFN,DA=+IB11,DIK="^IBE(363,"_DA(1)_",11," D ^DIK K DIK
 ;
 ; remove from Special Groups
 S IBFN=0 F  S IBFN=$O(^IBE(363.32,IBFN)) Q:'IBFN  D
 . S IB11=0 F  S IB11=$O(^IBE(363.32,IBFN,11,IB11)) Q:'IB11  D
 .. I +$P($G(^IBE(363.32,IBFN,11,IB11,0)),U,2)=+IBCS S DA(1)=+IBFN,DA=+IB11,DIK="^IBE(363.32,"_DA(1)_",11," D ^DIK K DIK
 ;
 ; delete region if not assigned to another Charge Set
 S IBRG=$P($G(^IBE(363.1,+IBCS,0)),U,7)
 I +IBRG S IBFN=0 F  S IBFN=$O(^IBE(363.1,IBFN)) Q:'IBFN  D
 . I +IBFN'=+IBCS,$P($G(^IBE(363.1,+IBFN,0)),U,7)=IBRG S IBRG=0
 I +IBRG S DA=+IBRG,DIK="^IBE(363.31," D ^DIK K DA,DIK
 ;
 ; delete Charge Set
 S DA=+IBCS,DIK="^IBE(363.1," D ^DIK K DA,DIK
 S IBER="1^Charge Set Deleted"_$S(+IBRG:", Region Deleted",1:"")_"."
CSDELQ Q IBER
 ;
CSEMPTY(BR) ; delete Charge Sets that have no associated Charges (except VA Cost)
 ; Input: BR may be passed to limit the check for empty Charge Sets to specific Billing Rates
 ;        only CS's of the passed Billing Rate will be checked and deleted if it has no charges
 ;           - pointer to the Billing Rate (363.3) to check
 ;           - first two characters of the Billing Rate Name (363.3,.01) to check
 ;           - if no BR passed then all Charge Sets/Billing Rates are checked
 ; Returns: count of Charge Sets deleted
 N IBCS,IBCS0,IBBR,IBBR0,IBX,IBCNT,X,Y S IBCNT=0
 S IBCS=0 F  S IBCS=$O(^IBE(363.1,IBCS)) Q:'IBCS  D
 . S IBCS0=$G(^IBE(363.1,IBCS,0)),IBBR=+$P(IBCS0,U,2),IBBR0=$G(^IBE(363.3,+IBBR,0))
 . I '$P(IBBR0,U,4)!($P(IBBR0,U,5)=2) Q  ; VA Cost
 . I +$G(BR),IBBR'=BR Q  ; selected Billing Rates
 . I '$G(BR),$G(BR)'="",$E(IBBR0,1,2)'=BR Q  ; selected Billing Rate names/types
 . I '$O(^IBA(363.2,"AIVDTS"_+IBCS,"")) S IBX=$$CSDELETE(IBCS) I +IBX S IBCNT=IBCNT+1
 Q IBCNT
