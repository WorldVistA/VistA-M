IBCNQ1 ;ALB/CPM - OUTPATIENT VISIT DATE INQUIRY ; 31-JUL-91
 ;;2.0; INTEGRATED BILLING ;**199**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;MAP TO DGCRNQ1
 ;
 D HOME^%ZIS
ASKPAT ;
 ;***
 ;I $D(XRT0) S:'$D(XRTN) XRTN="IBCNQ1" D T1^%ZOSV ;stop rt clock
 ;S XRTL=$ZU(0),XRTN="IBCNQ1-1" D T0^%ZOSV ;start rt clock
 N DPTNOFZY S DPTNOFZY=1  ;Suppress PATIENT file fuzzy lookups
 D END S DIC="^DPT(",DIC(0)="AEMQZ" W ! D ^DIC K DIC G:+Y<1 END
 S DFN=+Y I '$O(^DGCR(399,"AOPV",DFN,"")) W !!,"This patient has no bills with OP visits.  Please enter another patient." G ASKPAT
 ;
 S IBQUIT=0,IBAC=78
ASKDAT S DIR("A")="Select OP Visit Date",DIR(0)="DO^::EX^K:'$D(^DGCR(399,""AOPV"",DFN,Y)) X"
 S DIR("?",1)="Please enter a valid Outpatient Visit date for this patient.",DIR("?")="Enter '??' to list valid dates and bill numbers.",DIR("??")="^D HELP^IBCNQ1"
 D ^DIR K DIR G:Y<1 END
 S X=$O(^DGCR(399,"AOPV",DFN,Y,0)) I '$O(^DGCR(399,"AOPV",DFN,Y,X)) S IBIFN=X
 I '$D(IBIFN) D LIST K IBARR G END:IBQUIT
 I $D(IBIFN) D VIEW^IBCNQ ; Display bill record
 G ASKPAT:'IBQUIT
 ;
END K DFN,IBQUIT,DGI,DGX,DGY,IBS,IBNUM,IBAC,IB,IBBNO,IBN,IBU,IBUK,IBUN,IBX,IBSTAT,IBAC1,IBIFN,IBOPD,IBNOW,IBPAGE,IBPT,J,X,X2,Y
 ;***
 ;I $D(XRT0) S:'$D(XRTN) XRTN="IBCNQ1" D T1^%ZOSV ;stop rt clock
 Q
 ;
LIST ; If multiple bills for an OP visit date, list them.
 W !!?5,"Select one of the following bills for this visit date:"
 ;
 S DGI=0
 F J=1:1 S DGI=$O(^DGCR(399,"AOPV",DFN,Y,DGI)) Q:'DGI  S IBARR(J)=DGI W !?12,J D DISP,ASKNUM:'(J#5) G:IBQUIT!($D(IBIFN)) LQ
 I '((J-1)#5) W !!?5,"End of list.",!
ASKNUM W !?5,"Select 1-"_$S(J#5:J-1,1:J)_", or type '^' to quit: " R DGX:DTIME S:'$T!(DGX["^") IBQUIT=1 Q:IBQUIT!(DGX="")  I +DGX<1!(+DGX>$S(J#5:J-1,1:J)) W !!?5,*7,"Enter a NUMBER from 1 to "_$S(J#5:J-1,1:J)_".",! G ASKNUM
 I $D(IBARR(DGX)) S IBIFN=IBARR(DGX)
LQ Q
 ;
HELP ; List all OP visit dates and bill numbers for patient.
 W !!?5,"Enter one of the following OP visit dates: ",!
 S (DGY,Y)="",J=0 F  S Y=$O(^DGCR(399,"AOPV",DFN,Y)) Q:'Y!(DGY["^")  S DGX="" F  S DGX=$O(^DGCR(399,"AOPV",DFN,Y,DGX)) Q:'DGX  S J=J+1 D:'(J#20) PAUSE Q:DGY["^"  W !?5,$E(Y,4,5)_"-"_$E(Y,6,7)_"-"_$E(Y,2,3) S DGI=DGX D DISP
 Q
 ;
PAUSE W !!?5,"Enter '^' to stop or <CR> to continue: " R DGY:DTIME S:'$T DGY="^"
 W:DGY'["^" ! Q
 ;
DISP ; Write the bill number, rate type, and bill status.
 Q:'$D(^DGCR(399,DGI,0))  S IBS=$P(^(0),"^",13) W ?20,$P(^(0),"^"),?30,$P($G(^DGCR(399.3,+$P(^(0),"^",7),0)),"^")
 W ?55,$S(IBS=1:"ENTERED/NOT REVIEWED",IBS=2:"REVIEWED",IBS=3:"AUTHORIZED",IBS=4:"PRINTED",IBS=7:"CANCELLED",IBS=0:"CLOSED",1:"")
 Q
