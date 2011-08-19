IBCROI ;ALB/ARH - RATES: REPORTS CHARGE ITEM ; 11/22/96
 ;;2.0;INTEGRATED BILLING;**52,106,121,245**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN ; OPTION ENTRY POINT:  Charge Item report - get parameters then run the report
 N DIC,DIR,DIRUT,DTOUT,DUOUT,X,Y,IBLIST,IBX,IBSORT1,IBSORT2,IBBDT,IBEDT,IBHDR,IBQUIT,IBSELITM S IBLIST=""
 ;
 W !!,?20,"****** Charge Item Report ******",!!
 W !,"This report will list all charges that are effective within a date range."
 ;
 S DIR(0)="SO^1:Rate;2:Charge Set",DIR("A")="First sort by" D ^DIR K DIR S IBSORT1=+Y I Y<1!$D(DTOUT)!$D(DUOUT) Q
 ;
 S DIC=$S(IBSORT1=1:"^IBE(363.3,",1:"^IBE(363.1,") S DIC(0)="AENQ" D ^DIC I Y>0 S IBLIST=+Y
 I '$G(IBLIST)!$D(DTOUT)!$D(DUOUT) Q
 ;
 W !!,"Select a single item to display or press return for all items."
 S IBX=$S(IBSORT1=1:+IBLIST,1:$P($G(^IBE(363.1,+IBLIST,0)),U,2)),IBX=$P($G(^IBE(363.3,+IBX,0)),U,4) Q:'IBX
 S IBSELITM=$S(IBX=1:+$$GETBED^IBCRU1(),IBX=2:+$$GETCPT^IBCRU1("",1),IBX=3:+$$GETNDC^IBCRU1(),IBX=4:+$$GETDRG^IBCRU1(),IBX=9:+$$GETMISC^IBCRU1(),1:-1) Q:IBSELITM<0
 ;
 I '$G(IBSELITM) S DIR(0)="SO^1:Charge Item;2:Effective Date",DIR("A")="Sort by" D ^DIR K DIR S IBSORT2=+Y I Y<1!$D(DUOUT) Q
 I '$G(IBSORT2) S IBSORT2=1
 ;
 S IBBDT=$$GETDT^IBCRU1(DT,"Charges effective beginning on") Q:IBBDT'?7N
 S IBEDT=$$GETDT^IBCRU1(DT,"Charges effective ending on") Q:IBEDT'?7N
 ;
 S IBQUIT=0 D DEV I IBQUIT G EXIT
 ;
RPT ;find, save, and print Charge Item report - entry for tasked jobs
 ;
 ; if IBSCRPT is defined then the report will use the existing ^TMP($J,IBSCRPT,  array
 ;            this array must be in the same format as the arrays created in IBCROI1
 ; Otherwise, the following variations on the Charges report are possible:
 ;
 ; IBBDT, IBEDT required, if IBSELITM is defined then a single itme will print, otherwise all
 ; IBSORT1:  1 - primary sort is by the Billing Rate selected (IBLIST - list of Billing Rates to print, required)
 ;               all Charge Sets for a single Rate are accumulated into the sort,
 ;               the Charge Set name is printed as a date element on each charge line
 ;
 ; IBSORT1:  2 - primary sort is by Charge Set                  (IBLIST - list of Charge Sets to print, required)
 ;               group of Charge Sets are accumulated into the sort and ordered by Charge Set,
 ;               the Charge Set name is printed as a sub-header on the report, not as a line data element
 ;
 ; IBSORT2:  1 - secondary sort element is Charge Item Name and tertiary sort element is Effective Date
 ; IBSORT2:  2 - secondary sort element is Effective Date and tertiary sort element is Charge Item Name
 ;
 ;
 I $G(IBSCRPT)="" S IBSCRPT="IBCROI" K ^TMP($J,IBSCRPT) D
 . I $G(IBSORT1)=1 D SRCH1^IBCROI1(IBLIST,$G(IBSORT2),$G(IBBDT),$G(IBEDT),$G(IBSELITM))
 . I $G(IBSORT1)=2 D SRCH2^IBCROI1(IBLIST,$G(IBSORT2),$G(IBBDT),$G(IBEDT),$G(IBSELITM))
 ;
 D PRINT
 ;
EXIT ;clean up and quit
 K ^TMP($J),IBSCRPT Q:$D(ZTQUEUED)
 D ^%ZISC
 Q
 ;
PRINT ;print the report from the temp sort file to the appropriate device
 N IBPGN,IBLN,IBHDR1,IBHDR2,IBHDR3,IBS1,IBS2,IBS3,IBS4,IBQUIT,IBSP1,IBSP2,IBSORT1,IBSORT2
 N IBLNX,IBITEM,IBCSN,IBEFDT,IBINDT,IBCHG,IBCHGB,IBRVCD I '$D(ZTQUEUED) U IO
 S IBPGN=0,IBLN=999,IBQUIT=0 D GETHDR Q:$$HDR
 ;
 S IBS1="" F  S IBS1=$O(^TMP($J,IBSCRPT,IBS1)) Q:IBS1=""  D  Q:IBQUIT
 . I +IBSORT1=2 W !!,?20,"CHARGE SET: ",IBS1,! S IBLN=IBLN+3
 . ;
 . S IBS2="" F  S IBS2=$O(^TMP($J,IBSCRPT,IBS1,IBS2)) Q:IBS2=""  D  Q:IBQUIT
 .. S IBS3="" F  S IBS3=$O(^TMP($J,IBSCRPT,IBS1,IBS2,IBS3)) Q:IBS3=""  D  Q:IBQUIT
 ... S IBS4="" F  S IBS4=$O(^TMP($J,IBSCRPT,IBS1,IBS2,IBS3,IBS4)) Q:IBS4=""  D  S IBQUIT=$$HDR Q:IBQUIT
 .... ;
 .... S IBLNX=$G(^TMP($J,IBSCRPT,IBS1,IBS2,IBS3,IBS4))
 .... S IBITEM=$$EXPAND^IBCRU1(363.2,.01,$P(IBLNX,U,1))
 .... S IBCSN="" I IBSORT1=1 S IBCSN=$P($G(^IBE(363.1,+$P(IBLNX,U,2),0)),U,1)
 .... S IBEFDT=$$DATE^IBCRU1(+$P(IBLNX,U,3))
 .... S IBINDT="" I +$P(IBLNX,U,4) S IBINDT=$$DATE^IBCRU1(+$P(IBLNX,U,4))
 .... S IBCHG=$P(IBLNX,U,5),IBCHGB=$P(IBLNX,U,8) I IBCHGB'="" S IBCHGB="+"_$J(IBCHGB,0,2)
 .... S IBRVCD=$$RVCPT(+$P(IBLNX,U,6),+$P(IBLNX,U,1),+$P(IBLNX,U,2))
 .... I +$P(IBLNX,U,7) S IBITEM=IBITEM_"-"_$P($$MOD^ICPTMOD(+$P(IBLNX,U,7),"I",IBEFDT),U,2)
 .... ;
 .... I +IBSORT2=1 W !,$E(IBITEM,1,(31-IBSP1)),?(34-IBSP1),IBEFDT,?(44-IBSP1),IBINDT S IBLN=IBLN+1
 .... I +IBSORT2'=1 W !,IBEFDT,?10,IBINDT,?21,$E(IBITEM,1,(32-IBSP1)) S IBLN=IBLN+1
 .... I +IBSORT1=1 W ?(55-IBSP1),$E(IBCSN,1,(27-IBSP2)),?(82-IBSP1-IBSP2),$J(IBCHG,10,2),IBCHGB,?(102-IBSP1-IBSP2),IBRVCD
 .... I +IBSORT1'=1 W ?(55-IBSP1),$J(IBCHG,10,2),IBCHGB,?(75-IBSP1),IBRVCD
 I $P($G(^TMP($J,IBSCRPT)),U,4)'="" W !!,$P(^TMP($J,IBSCRPT),U,4)
 I 'IBQUIT D PAUSE
 Q
 ;
GETHDR ; set up header lines
 N IBDT,IBS S IBHDR2="",(IBSP1,IBSP2)=0
 S IBS=$G(^TMP($J,IBSCRPT)),IBSORT1=$P(IBS,U,2),IBSORT2=$P(IBS,U,3) I IBSORT1=1,$E(IOST,1,2)["C-" S IBSP1=23,IBSP2=2
 S IBDT=$$HTE^XLFDT($H),IBDT=$P(IBDT,"@",1)_"  "_$P($P(IBDT,"@",2),":",1,2)
 S IBHDR1=$P(IBS,U,1),IBHDR1=IBHDR1_$J("",(IOM-$L(IBHDR1)-30))_IBDT_$J("",$L(IOM-8))_"Page "
 ;
 I +IBSORT2=1 S IBHDR2=$E("Charge Item                      ",1,(31-IBSP1))_"   Effective Inactive "
 I +IBSORT2=2 S IBHDR2="Effective Inactive   "_$E("Charge Item                            ",1,(32-IBSP1))
 I +IBSORT1=1 S IBHDR2=IBHDR2_"  "_$E("Charge Set                  ",1,(27-IBSP2))_"     Charge       Rv Cd"
 I +IBSORT1=2 S IBHDR2=IBHDR2_"      Charge         Rv Cd"
 S IBHDR3="",$P(IBHDR3,"-",IOM+1)=""
 Q
 ;
HDR() ;print the report header
 N IBQUIT,X,Y S IBQUIT=0
 S IBQUIT=$$STOP I +IBQUIT G HDRQ
 I IBLN<(IOSL-3) G HDRQ
 I IBPGN>0 D PAUSE I +IBQUIT G HDRQ
 S IBPGN=IBPGN+1,IBLN=4
 I IBPGN>1!($E(IOST,1,2)["C-") W @IOF
 ;
 W !,IBHDR1,IBPGN,!,IBHDR2,!,IBHDR3
HDRQ Q IBQUIT
 ;
DEV ;get the device
 S IBQUIT=0 S %ZIS="QM",%ZIS("A")="OUTPUT DEVICE: " D ^%ZIS I POP S IBQUIT=1 Q
 I $D(IO("Q")) S ZTRTN="RPT^IBCROI",ZTDESC="Charge Item Report",ZTSAVE("IB*")="" D ^%ZTLOAD K IO("Q") S IBQUIT=1
 Q
 ;
RVCPT(DRV,ITM,CS) ; returns revenue code:  first CI rev code then rv-cpt link
 N IBX,IBY S (IBX,IBY)=""
 I +$G(DRV) S IBY=+DRV
 I IBY="",+$G(ITM),+$G(CS) S IBY=$P($$RVLNK^IBCRU6(+ITM,"",+CS),U,2)
 I IBY'="" S IBX=$P($G(^DGCR(399.2,+IBY,0)),U,1)
 Q IBX
 ;
PAUSE ;pause at end of screen if being displayed on a terminal
 Q:$E(IOST,1,2)'["C-"  S DIR(0)="E" D ^DIR K DIR I $D(DUOUT)!($D(DIRUT)) S IBQUIT=1
 Q
 ;
STOP() ; determine if user has requested the queued report to stop
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1 K ZTREQ I +$G(IBPGN) W !,"***TASK STOPPED BY USER***"
 Q +$G(ZTSTOP)
