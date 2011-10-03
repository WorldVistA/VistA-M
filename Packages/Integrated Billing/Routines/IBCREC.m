IBCREC ;ALB/ARH - RATES: CM INACTIVATE CPT CHARGE OPTION ; 22-MAY-1996
 ;;2.0;INTEGRATED BILLING;**52,131**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
ENTER ; OPTION ENTRY POINT:  inactivate all CPT procedures Charge Items that are currently inactive in the CPT file
 ;
 W @IOF W !,?8,"**** INACTIVATE CHARGES FOR ALL CURRENTLY INACTIVE CPTS ****"
 W !!,?5,"For all Charge Sets based on CPT procedures, this option will add an",!,?5,"Inactive Date to each Charge Item that is a currently Inactive CPT code.",!!
 ;
 N DIR,DTOUT,DUOUT,DIRUT,X,Y,IBQUIT K ^TMP($J,"IBCREC")
 ;
 S DIR(0)="SO^1:Print List of Active Charges for Inactive CPT's;2:Inactivate Charges for Inactive CPT's"
 D ^DIR K DIR I +Y<1!$D(DIRUT) Q
 I +Y=1 D DEV Q:$G(IBQUIT)  G RPT
 ;
 W !!!,"All charges for currently Inactive CPT codes will become inactive",!,"on the CPT Inactive Date.",!
 ;
 S DIR(0)="YO",DIR("A")="Is this correct, do you want to continue" D ^DIR K DIR I Y'=1 W !,"None inactivated",! Q
 ;
 I Y=1 W !,"Beginning Inactivations" W !,$$INACTCPT(0)," charges inactivated"
 Q
 ;
INACTCPT(SAVE) ; inactivate charges for all Inactive CPT codes, all sets checked
 ; if an active charge for an Inactive CPT, the CPT's inactive date is added as the charges Inactive Date
 ; if a CPT is inactive before the charges Effective date, that Effective date is added as the Inactive Date
 ;    Input:   SAVE - if true, charge items that would be deleted are entered into TMP array for print instead
 ;    Output:  returns the count of the charge items inactivated
 ;
 N IBCS,IBBI,IBXRF,IBSUB2,IBITM,IBEFDT,IBCIFN,IBCNT,IBINDTCI,IBINDATE,IBX,INDT S IBCNT=0
 ;
 S IBCS=0 F  S IBCS=$O(^IBE(363.1,IBCS)) Q:'IBCS  D
 . ;
 . S IBBI=$$CSBI^IBCRU3(IBCS) I +IBBI'=2 Q
 . S IBXRF="AIVDTS"_+IBCS I '$D(ZTQUEUED),'$D(XPDNM) W "."
 . I +$G(SAVE) S IBSUB2=$$TMPHDR(IBCS) Q:IBSUB2=""
 . ;
 . S IBITM=0 F  S IBITM=$O(^IBA(363.2,IBXRF,IBITM)) Q:'IBITM  D
 .. ;
 .. S IBX=$$CPT^ICPTCOD(IBITM,DT) I +$P(IBX,U,7) Q
 .. S INDT=$P(IBX,U,6) I 'INDT Q
 .. ;
 .. S IBEFDT=-9999999 F  S IBEFDT=$O(^IBA(363.2,IBXRF,IBITM,IBEFDT)) Q:'IBEFDT  D
 ... S IBCIFN=0 F  S IBCIFN=$O(^IBA(363.2,IBXRF,IBITM,IBEFDT,IBCIFN)) Q:'IBCIFN  D
 .... ;
 .... S IBINDTCI=$$INACTCI^IBCRU4(IBCIFN) I +IBINDTCI,IBINDTCI<INDT Q
 .... ;
 .... S IBINDATE=INDT I -IBEFDT>IBINDATE S IBINDATE=-IBEFDT
 .... I IBINDATE=$P($G(^IBA(363.2,IBCIFN,0)),U,4) Q
 .... ;
 .... S IBCNT=IBCNT+1
 .... I +$G(SAVE) D TMPLN^IBCROI1(IBCIFN,"IBCREC",IBSUB2,1) Q
 .... D EDITCI^IBCREF(IBCIFN,"","","",IBINDATE)
 Q IBCNT
 ;
DATE(X) ;
 Q $E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3)
 ;
TMPHDR(CS) ; set up array header for printed report
 N IBHDR,IBSUB2 S IBSUB2="BILLING RATE",IBHDR="Charges for Inactive CPT's"
 D TMPHDR^IBCROI1("IBCREC",IBSUB2,0,IBHDR,"1^1")
 Q IBSUB2
 ;
DEV ; get device for printed report
 S IBQUIT=0 S %ZIS="QM",%ZIS("A")="OUTPUT DEVICE: " D ^%ZIS I POP S IBQUIT=1 Q
 I $D(IO("Q")) S ZTRTN="RPT^IBCREC",ZTDESC="Charges for Inactive CPT's" D ^%ZTLOAD K IO("Q") S IBQUIT=1
 Q
 ;
RPT ; print report - entry point for tasked jobs
 N IBSCRPT,IBCNT S IBSCRPT="IBCREC" K ^TMP($J,"IBCREC")
 S IBCNT=$$INACTCPT(1)
 I $D(^TMP($J,"IBCREC")) S $P(^TMP($J,"IBCREC"),U,4)=IBCNT_" Charges for Inactive CPT's"
 G RPT^IBCROI
 Q
