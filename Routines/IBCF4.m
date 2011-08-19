IBCF4 ;ALB/ARH - PRINT BILL ADDENDUM ;12-JAN-94
 ;;2.0;INTEGRATED BILLING;**52,137,199,309,389**;21-MAR-94;Build 6
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
PRXA ;get bill number then print rx refill addendums for bills
 S DIC("S")="I $D(^IBA(362.4,""AIFN""_+Y))!($D(^IBA(362.5,""AIFN""_+Y)))"
 N DPTNOFZY S DPTNOFZY=1  ;Suppress PATIENT file fuzzy lookups
 S DIC="^DGCR(399,",DIC(0)="AEMQ" D ^DIC K DIC G:+Y'>0 EXIT S IBBILL=$P(Y,U,2),IBIFN=+Y
 ;
 I $D(^IBA(364,"ABDT",IBIFN)),+$$TXMT^IBCEF4(IBIFN)=1 D  G:'IBTXOK PRXA
 .S IBTXOK=0
 .N IBLDT,IBX
 .S IBLDT=$O(^IBA(364,"ABDT",IBIFN,""),-1),IBX=$O(^IBA(364,"B",IBIFN,+IBLDT,""),-1)
 .I "X"[$P($G(^IBA(364,+IBX,0)),U,3) W !!,*7,"Transmittable Bill can NOT be printed until transmitted" Q
 .W !!,"This is a Transmittable Bill that has already been transmitted"
 .W !!,"WANT TO PRINT THIS BILL ADDENDUM ANYWAY" S %=2 D YN^DICN
 .Q:'(%+1#3)  ;-1 or 2
 .S IBTXOK=1
 ;
DEV ;get the device
 W !!,"Report requires 132 columns."
 S %ZIS="QM",%ZIS("A")="OUTPUT DEVICE: " D ^%ZIS G:POP EXIT
 I $D(IO("Q")) S ZTRTN="EN^IBCF4",ZTDESC="BILL ADDENDUM FOR "_IBBILL,ZTSAVE("IB*")="" D ^%ZTLOAD K IO("Q"),ZTSK G EXIT
 U IO D EN
 ;
EXIT ;clean up and quit
 I $D(ZTQUEUED) S ZTREQ="@" Q
 K IBQUIT,IBIFN,IBBILL,IBTXOK,X,Y,DTOUT,DUOUT,DIRUT,DIROUT D ^%ZISC
 Q
 ;
EN ;ENTRY POINT IF QUEUED, print all rx refills for a bill
 S IBY=$G(^DGCR(399,+IBIFN,0)) Q:IBY=""  S IBXREF="AIFN"_IBIFN
 S (IBQUIT,IBPGN,IBRX)=0,IBHDR="BILL ADDENDUM FOR "_$P($G(^DPT(+$P(IBY,U,2),0)),U,1)_" - "_$P(IBY,U,1) D HDR
RX I '$D(^IBA(362.4,IBXREF)) G PROS
 W !!,"PRESCRIPTION REFILLS:",!
 K IBRC
 D RCITEM^IBCSC5A(IBIFN,"IBRC",3)
 S IBRX=0 F  S IBRX=$O(^IBA(362.4,IBXREF,IBRX)) Q:IBRX=""!IBQUIT  S IBRIFN=0 F  S IBRIFN=$O(^IBA(362.4,IBXREF,IBRX,IBRIFN)) Q:'IBRIFN!IBQUIT  D
 .S IBY=$G(^IBA(362.4,IBRIFN,0)) Q:IBY=""
 .S IBYC=$$CHG(IBRIFN,3,.IBRC)
 .;
 . D ZERO^IBRXUTL(+$P(IBY,U,4))
 . W !,$P(IBY,U,1),?13,$$FMTE^XLFDT(+$P(IBY,U,3),2),?22,$J($S(IBYC:"$"_$FN(IBYC,",",2),1:""),10),?34,$G(^TMP($J,"IBDRUG",+$P(IBY,U,4),.01))
 . K ^TMP($J,"IBDRUG")
 . I $P(IBY,U,6)'="" W ?77,"QTY: ",$P(IBY,U,7)
 . I $P(IBY,U,7)'="" W ?87,"DAYS SUPPLY: ",$P(IBY,U,6)
 . I $P(IBY,U,8)'="" W ?105,"NDC #: ",$P(IBY,U,8)
 . S IBLN=IBLN+1 I IBLN>(IOSL-7) D PAUSE,HDR
 K IBRC
 ;
PROS I '$D(^IBA(362.5,IBXREF)) G END
 W !!!,"PROSTHETIC ITEMS:",!
 K IBRC
 D RCITEM^IBCSC5A(IBIFN,"IBRC",5)
 S IBPI=0 F  S IBPI=$O(^IBA(362.5,IBXREF,IBPI)) Q:IBPI=""!IBQUIT  S IBPIFN=0 F  S IBPIFN=$O(^IBA(362.5,IBXREF,IBPI,IBPIFN)) Q:'IBPIFN!IBQUIT  D
 . S IBY=$G(^IBA(362.5,IBPIFN,0)),IBYC="" Q:IBY=""
 . S IBYC=$$CHG(IBPIFN,5,.IBRC)
 . W !,$$FMTE^XLFDT(+$P(IBY,U,1),2),?11,$J($S(IBYC:"$"_$FN(IBYC,",",2),1:""),10),?24,$E($P(IBY,U,5),1,55)
 . S IBLN=IBLN+1 I IBLN>(IOSL-7) D PAUSE,HDR
 D:'IBQUIT PAUSE
END K IBX,IBY,IBPGN,IBRX,IBHDR,IBRIFN,IBLN,IBCDT,IBI,IBXREF,IBPI,IBPIFN,IBRC,IBYC
 Q
 ;
CHG(IBY,IBTYP,IBRC) ; Return charge for item entry IBY or null if no charge
 ; IBRC = the array containing the revenue code items and their units and charges
 ; IBTYP = the type of item being priced
 N IBZ,IBYC
 S IBRC=$S($D(IBRC(IBTYP,IBY)):IBY,1:0),IBYC=""
 F IBRC=IBRC,0 Q:'$D(IBRC(IBTYP,IBRC))  S IBZ="" D  Q:IBZ'=""!(IBRC=0)
 .F  S IBZ=$O(IBRC(IBTYP,IBRC,IBZ)) Q:IBZ=""  I IBRC(IBTYP,IBRC,IBZ) S $P(IBRC(IBTYP,IBRC,IBZ),U)=IBRC(IBTYP,IBRC,IBZ)-1,IBYC=$P(IBRC(IBTYP,IBRC,IBZ),U,2) K:'IBRC(IBTYP,IBRC,IBZ) IBRC(IBTYP,IBRC,IBZ) Q
 Q IBYC
 ;
HDR ;print the report header
 S IBQUIT=$$STOP Q:IBQUIT  S IBPGN=IBPGN+1,IBLN=5
 D NOW^%DTC S Y=$E(%,1,12) D DD^%DT S IBCDT=$P(Y,"@",1)_"  "_$P(Y,"@",2)
 I IBPGN>1!($E(IOST,1,2)["C-") W @IOF
 W IBHDR W:IOM<85 ! W ?(IOM-30),IBCDT,?(IOM-8),"PAGE ",IBPGN,!
 ;W !,"RX #",?13,"REFILL DATE",?28,"DRUG",?70,"DAYS SUPPLY",?83,"QTY",?90,"NDC #",!
 F IBI=1:1:IOM W "-"
 W !
 Q
 ;
PAUSE ;pause at end of screen if being displayed on a terminal
 Q:$E(IOST,1,2)'["C-"
 S DIR(0)="E" D ^DIR K DIR
 I $D(DUOUT)!($D(DIRUT)) S IBQUIT=1
 Q
 ;
STOP() ;determine if user has requested the queued report to stop
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1 K ZTREQ I +$G(IBPGN) W !,"***TASK STOPPED BY USER***"
 Q +$G(ZTSTOP)
 ;
RXDISP ;displays all rx refills bills
 ;N IBX,IBY,IBZ,IBC,X,Y S Y=1,IBC=0,IBX="AIFN"
 ;F  S IBX=$O(^IBA(362.4,IBX)) Q:IBX=""  S IBY=$E(IBX,5,999),IBZ=$G(^DGCR(399,+IBY,0)) I IBZ'="" D  Q:'Y
 ;. W !,$P(IBZ,U,1),?10,$E($P($G(^DPT(+$P(IBZ,U,2),0)),U,1),1,20),?32,$$DATE(+$P(IBZ,U,3)),?42,$S(+$P(IBZ,U,5)<3:"INPT",1:"OUTPT")
 ;. W ?49,$P($G(^DGCR(399.3,+$P(IBZ,U,7),0)),U,4),?59,$E($$EXSET^IBEFUNC(+$P(IBZ,U,13),399,.13),1,7),?68,$E($P($G(^IBE(353,+$P(IBZ,U,19),0)),U,1),1,11)
 ;. S IBC=IBC+1 I '(IBC#10) S DIR(0)="E" D ^DIR K DIR
 ;Q
 ;
DATE(X) Q $E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3)
 ;
BILLAD(IFN) ;returns true if bill has either rx refills or prosthetics so addendum should print
 N IBX S IBX=0,IFN=+$G(IFN) S:+$O(^IBA(362.4,"AIFN"_IFN,0)) IBX=1 S:+$O(^IBA(362.5,"AIFN"_IFN,0)) IBX=IBX+2
 Q IBX
