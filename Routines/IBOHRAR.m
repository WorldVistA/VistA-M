IBOHRAR ;ALB/EMG-RELEASED CHARGES REPORT;APR 11 1997
 ;;2.0;INTEGRATED BILLING;**70,95,215,347**;21-MAR-94;Build 24
 ;
EN ; - Option entry point.
 N X,Y,ZTIO
 S (IBCRT,IBQUIT)=0,IBLINE="",$P(IBLINE,"-",IOM)=""
 D NOW^%DTC S Y=X X ^DD("DD") S IBNOW=Y D HOME^%ZIS
 W @IOF,!,"List of On Hold/Hold-Review Charges Released to AR"
 W !!?5,"This report will list all charges that were previously on"
 W !?5,"ON HOLD or HOLD-REVIEW status and currently have a status"
 W !?5,"of BILLED and the DATE LAST UPDATED is within the date range"
 W !?5,"you specify."
 ;
SELECT W !!,"Print former (O)N HOLD charges,"
 R !?13,"(H)OLD-REVIEW charges, or (B)OTH: BOTH// ",X:DTIME
 G:'$T!(X["^") END S:X="" X="B" S X=$E(X)
 I "BHObho"'[X D HELP G SELECT
 W "  ",$S("Hh"[X:"HOLD-REVIEW","Oo"[X:"ON HOLD",1:"BOTH")
 S IBSEL=$S("Hh"[X:"H","Oo"[X:"O",1:"HO")
 ;
RANGE S DIR(0)="DA^:NOW:EX",DIR("A")="Start with DATE: "
 S DIR("?")="Enter the starting date for this report."
 W ! D ^DIR K DIR G:$D(DIRUT) END S IBSDT=+Y
 S DIR(0)="DA^+Y:NOW:EX",DIR("A")="     Go to DATE: "
 S DIR("?")="Enter the ending date for this report."
 D ^DIR K DIR G:$D(DIRUT) END S IBEDT=+Y
 ;
QUEUED ; - Entry point if queued.
 K ^TMP($J)
 I '$G(IBQUIT) D DEVICE
 I '$G(IBQUIT) D CHRGS,PRINT
 ;
END D ^%ZISC
 K DFN,DIRUT,DUOUT,I,IBACT,IBATYPE,IBBILL,IBCHG,IBCNT,IBCRT,IBDT,IBFR
 K IBGBL,IBHDR,IBHR,IBLINE,IBN,IBNAME,IBND,IBND1,IBNOW,IBOH,IBPAGE,IBQUIT
 K IBRDT,IBRF,IBRX,IBRXN,IBSEL,IBSDT,IBSSN,IBTO,IBTYPE,POP,VA,X,^TMP($J)
 Q
 ;
DEVICE I $D(ZTQUEUED) Q
 W !!,"*** This output should be queued ***"
 S %ZIS="QM" D ^%ZIS I POP S IBQUIT=1 Q
 I $D(IO("Q")) D  Q
 .S ZTRTN="QUEUED^IBOHRAR",ZTIO=ION,ZTDESC="CHARGES RELEASED TO AR"
 .S ZTSAVE("IB*")="" D ^%ZTLOAD
 .W !,$S($D(ZTSK):"REQUEST QUEUED TASK="_ZTSK,1:"REQUEST CANCELLED")
 .D HOME^%ZIS K ZTSK S IBQUIT=1
 ;
 U IO
 Q
 ;
CHRGS ; - Indexes charges released to AR within date range.
 S IBSDT=IBSDT+.000001,IBEDT=IBEDT+.24 Q:IBQUIT
 I $E(IOST,1,2)="C-" S IBCRT=1
 S IBN=0 F  S IBN=$O(^IB("AC",3,IBN)) Q:'IBN  D
 .S IBND=$G(^IB(IBN,0)),IBND1=$G(^IB(IBN,1)) Q:'IBND!('IBND1)
 .S IBOH=$P(IBND1,U,6),IBHR=$P(IBND1,U,7)
 .I IBOH,IBSEL["O" S IBGBL="IBOH" D CHRGS1 Q
 .I IBHR,IBSEL["H" S IBGBL="IBHR" D CHRGS1
 ;
 Q
 ;
CHRGS1 ; - Set global for report.
 S IBDT=$P(IBND1,U,4) Q:'IBDT!(IBDT<IBSDT)!(IBDT>IBEDT)
 S DFN=$P(IBND,U,2) Q:'DFN
 D PAT S ^TMP($J,IBGBL,IBNAME,DFN,IBN)=""
 Q
 ;
PRINT ; - Print charges released to AR.
 N IENS Q:IBQUIT
 I IBCRT=1 W @IOF
 S IBGBL="" F  S IBGBL=$O(^TMP($J,IBGBL)) Q:IBGBL=""  D  Q:IBQUIT
 .S (IBCNT,IBPAGE)=0 D HEADER Q:IBQUIT
 .S IBNAME="" F  S IBNAME=$O(^TMP($J,IBGBL,IBNAME)) Q:IBNAME=""  S (DFN,IBFL)=0 F  S DFN=$O(^TMP($J,IBGBL,IBNAME,DFN)) Q:'DFN  D  Q:IBQUIT
 ..D PRNTPAT Q:IBQUIT
 ..S IBN=0 F  S IBN=$O(^TMP($J,IBGBL,IBNAME,DFN,IBN)) Q:IBN=""  D
 ...S IBND=$G(^IB(IBN,0)),IBND1=$G(^IB(IBN,1))
 ...S (IBRX,IBRXN,IBRF,IBRDT)=0,IBACT=+IBND
 ...S IBTYPE=$P(IBND,U,3),IBTYPE=$P($G(^IBE(350.1,IBTYPE,0)),U)
 ...S IBTYPE=$S(IBTYPE["PSO NSC":"RXNSC",IBTYPE["PSO SC":"RX SC",1:$E(IBTYPE,4,7))
 ...S IBBILL=$P($P(IBND,U,11),"-",2)
 ...I $P(IBND,U,4)["52:" S IBRXN=$P($P(IBND,U,4),":",2),IBRX=$P($P(IBND,U,8),"-"),IBRF=$P($P(IBND,U,4),":",3)
 ...I IBRF>0 S IBRDT=$$SUBFILE^IBRXUTL(+IBRXN,IBRF,52,.01)
 ...E  S IBRDT=$$FILE^IBRXUTL(IBRXN,22)
 ...S IBFR=$$DAT1^IBOUTL($S(IBRXN>0:IBRDT,1:$P(IBND,U,14)))
 ...S IBTO=$$DAT1^IBOUTL($S($P(IBND,U,15)'="":$P(IBND,U,15),1:$P(IBND1,U,2)))
 ...S IBCHG=$J(+$P(IBND,U,7),9,2)
 ...I IBQUIT Q
 ...W ?27,IBACT,?37,IBBILL,?46,IBTYPE W:IBRX>0 ?52,"Rx #: "_IBRX_$S(IBRF>0:"("_IBRF_")",1:""),!
 ...W ?52,IBFR,?62,IBTO,?70,IBCHG,!
 ...S IBCNT=IBCNT+1
 ...I ($Y+4)>IOSL,$O(^TMP($J,IBGBL,IBNAME,DFN,IBN)) D PRNTPAT
 .;
 .I IBCNT=0 W !?10,"No charges were released in this time period.",!!
 ;
 Q
 ;
PAT ; - Print patient data during processing.
 N VADM,VAERR D DEM^VADPT K:VAERR VADM
 S IBNAME=$G(VADM(1)) S:IBNAME="" IBNAME=""
 Q
 ;
PRNTPAT ; - Print patient data on report.
 N VADM,VAERR
 D DEM^VADPT S IBSSN=$S('VAERR:VA("BID"),1:"")
 I ($Y+4)>IOSL D HEADER Q:IBQUIT
 W $E(IBNAME,1,20),?21,IBSSN
 Q
 ;
HEADER ; - Report header.
 I IBQUIT Q
 I IBCRT,$Y>1 D PAUSE Q:IBQUIT
 S IBHDR=$S(IBGBL="IBHR":"HOLD-REVIEW",1:"ON HOLD"),IBPAGE=IBPAGE+1
 W !,@IOF
 W "List of ",IBHDR," charges released to AR from ",$P($$DAT2^IBOUTL(IBSDT),"@")," to ",$P($$DAT2^IBOUTL(IBEDT),"@")
 W !,"Date Printed: ",IBNOW,?72,"Page ",IBPAGE,!,IBLINE
 W !,"Name",?20,"Pt.ID",?27,"Act.ID",?37,"Bill #",?46,"Type",?52,"Fr/Fl Dt",?62,"To/Rls Dt",?73,"Charge"
 W !,IBLINE,!
 Q
 ;
PAUSE ; - Pause for screen output.
 I $E(IOST,1,2)'="C-" Q
 F I=$Y:1:(IOSL-5) W !
 S DIR(0)="E" D ^DIR K DIR I $D(DIRUT)!($D(DUOUT)) S IBQUIT=1
 Q
 ;
HELP ; - 'Print former (O)N HOLD...' prompt help text.
 W !!?5,"Enter: '<CR>' - To select both On Hold and Hold-Review charges"
 W !?15,"'O' - To select only On Hold charges"
 W !?15,"'H' - To select only Hold-Review charges"
 W !?15,"'^' - To quit this option",!
 Q
