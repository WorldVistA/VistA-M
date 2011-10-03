IBOAMS ;ALB/AAS - PRINT REVENUE CODE TOTALS FOR MEANS TEST AMIS ; 10-SEP-91
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;
 ;MAP TO DGCRAMS1
 ;
EN ;  - Report of inpatient and nhcu per diems
 ;***
 ;S XRTL=$ZU(0),XRTN="IBOAMS-1" D T0^%ZOSV ;start rt clock
 ;
 D HOME^%ZIS W @IOF,?19,"Report of Revenue Code Totals by Rate Type",!!!
 S DIC="^DGCR(399.3,",DIC(0)="AEQMN",DIC("A")="Select Means Test Rate Type: "
 S IBRT="" F  S IBRT=$O(^DGCR(399.3,"B",IBRT)) Q:IBRT=""  I IBRT["MEANS TEST" S DIC("B")=$O(^(IBRT,0)) Q
 D ^DIC K DIC G:+Y<1 ENQ S IBRT=+Y
 ;
DATE W ! S %DT="AEPX",%DT("A")="START WITH DATE FIRST PRINTED: " D ^%DT K %DT G ENQ:Y<1 S IBBDT=Y
DATE1 W ! S %DT="EPX" R !,"GO TO DATE FIRST PRINTED: ",X:DTIME S:X=" " X=IBBDT G ENQ:(X="")!(X["^") D ^%DT K %DT G DATE1:Y<1 S IBEDT=Y I Y<IBBDT W *7," ??",!,"ENDING DATE must follow BEGINNING DATE." G DATE1
 ;
 W ! S DIR(0)="Y",DIR("A")="PRINT SUMMARY PAGE ONLY",DIR("B")="YES" D ^DIR K DIR G:$D(DIRUT) ENQ S IBSUM=Y
 ;
DEV W ! S %ZIS="QM",%ZIS("A")="Output Device: " D ^%ZIS G:POP ENQ
 I $D(IO("Q")) K IO("Q") S ZTRTN="DQ^IBOAMS",ZTDESC="Revenue Code Report",ZTSAVE("IB*")="" D ^%ZTLOAD K ZTSK G ENQ
 U IO
 ;***
 ;I $D(XRT0) S:'$D(XRTN) XRTN="IBOAMS" D T1^%ZOSV ;stop rt clock
 ;
DQ ;  - start report here
 ;***
 ;S XRTL=$ZU(0),XRTN="IBOAMS-2" D T0^%ZOSV ;start rt clock
 S (IBCNT,IBQUIT,IBPAG,IBTC)=0 D NOW^%DTC S Y=% D D^DIQ S IBPDT=Y
 D HDR
 K IBT S IBDT=IBBDT-.01
 F  S IBDT=$O(^DGCR(399,"AP",IBDT)) Q:'IBDT!(IBDT>(IBEDT+.25))!(IBQUIT)  S IBIFN=0 F  S IBIFN=$O(^DGCR(399,"AP",IBDT,IBIFN)) Q:'IBIFN!(IBQUIT)  D BLD
 ;
 D:'IBQUIT TOTALS
 I '$D(IBT) W !,"No Matches Found"
 D PAUSE:'IBQUIT
ENQ ;
 ;***
 ;I $D(XRT0) S:'$D(XRTN) XRTN="IBOAMS" D T1^%ZOSV ;stop rt clock
 I $D(ZTQUEUED) S ZTREQ="@" Q
 K R,X,X2,X3,Y,DFN,IB,IBBDT,IBC,IBDT,IBEDT,IBGT,IBIFN,IBLINE,IBPAG,IBPDT,IBRT,IBSUM,IBT,IBTC,VA,VAERR,DIC,DIR,%DT,IBY,IBQUIT,IBCNT
 D ^%ZISC
 Q
 ;
BLD ;
 K IB
 I $P(^DGCR(399,IBIFN,0),"^",7)'=IBRT!($S('$D(^("S")):1,$P(^("S"),"^",16):1,1:0)) Q
 S (IBC,R)=0 F  S R=$O(^DGCR(399,IBIFN,"RC",R)) Q:'R  I $D(^DGCR(399,IBIFN,"RC",R,0)) D BLD1
 S IBCNT=IBCNT+1,R=0 F  S R=$O(^DGCR(399,IBIFN,"RC","B",R)) Q:'R  S:'$D(IBCNT(R)) IBCNT(R)=0 S IBCNT(R)=IBCNT(R)+1
 Q:IBSUM
 I ($Y+4+IBC)>IOSL D PAUSE Q:IBQUIT  D HDR
 S DFN=$P(^DGCR(399,IBIFN,0),"^",2) D PID^VADPT W !,$E($P(^DPT(DFN,0),"^"),1,20),?23,VA("PID"),?38,$P(^DGCR(399,IBIFN,0),"^")
 S R=0 F  S R=$O(IB(R)) Q:'R  W ?59,$S($D(^DGCR(399.2,+R,0)):$P(^(0),"^"),1:R),?67 S X=IB(R),X2="2$",X3=12 D COMMA^%DTC W X,!
 Q
 ;
BLD1 S IB=^DGCR(399,IBIFN,"RC",R,0) S:'$D(IB(+IB)) IB(+IB)=0,IBC=IBC+1 S IB(+IB)=IB(+IB)+$P(IB,"^",4) S:'$D(IBT(+IB)) IBT(+IB)=0,IBTC=IBTC+1 S IBT(+IB)=IBT(+IB)+$P(IB,"^",4)
 Q
 ;
TOTALS ;  - print revenue code totals
 Q:'$D(IBT)
 I ($Y+4+IBTC)>IOSL S IBSUM=1 D PAUSE Q:IBQUIT  D HDR
 S IBGT=0
 W:'IBSUM !,"----------------------------------------------",!,"REVENUE CODE TOTALS",!
 S R=0 F  S R=$O(IBT(R)) Q:'R  W !,"Revenue Code: ",$S($D(^DGCR(399.2,+R,0)):$P(^(0),"^"),1:R)," .........." S IBGT=IBGT+IBT(R),X=IBT(R),X2="2$",X3=13 D COMMA^%DTC W ?32,X,?50,$J(IBCNT(R),8)," Bills"
 S X=IBGT,X2="2$",X3=13 D COMMA^%DTC W !,?31,"--------------",!,"   ",?32,X,?50,$J(IBCNT,8)," Bills"
 Q
HDR ;  - patient data header
 S IBPAG=IBPAG+1
 W:$E(IOST,1,2)["C-"!(IBPAG>1) @IOF
 W "Revenue Code Totals for ",$P(^DGCR(399.3,IBRT,0),"^",1),?(IOM-32),IBPDT,"  PAGE ",IBPAG
 W !,"For Bills First Printed " S Y=IBBDT D DT^DIQ W "  to  " S Y=IBEDT D DT^DIQ
 W:'IBSUM !,"Patient",?25,"Pt. ID.",?38,"Bill No.",?56,"Rev. Code",?72,"Amount"
 S IBLINE="",$P(IBLINE,"-",IOM)="" W !,IBLINE
 Q
PAUSE Q:$E(IOST,1,2)'["C-"
 F IBY=$Y:1:(IOSL-4) W !
 S DIR(0)="E" D ^DIR K DIR I $D(DIRUT)!($D(DUOUT)) S IBQUIT=1 K DIRUT,DTOUT,DUOUT
 Q
