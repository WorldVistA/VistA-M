IBCSC7 ;ALB/MJB - MCCR SCREEN 7 (INPT. BILLING INFO)  ;27 MAY 88 10:19
 ;;2.0;INTEGRATED BILLING;**52,80,109,106,343,400,432,623**;21-MAR-94;Build 70
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;MAP TO DGCRSC7
 ;
 I $P(^DGCR(399,IBIFN,0),"^",5)'>2 G ^IBCSC8
 I $D(DGRVRCAL) D ^IBCU6 K DGRVRCAL
EN D ^IBCSCU S IBSR=7,IBSR1="",IBV1="0000000" S:IBV IBV1="1111111" F I="U","U1",0,"U2","U3" S IB(I)=$S($D(^DGCR(399,IBIFN,I)):^(I),1:"")
 D H^IBCSCU
 D 4^IBCVA1,5^IBCVA1
 S IBBT=$P(IB(0),U,24)_$P($G(^DGCR(399.1,+$P(IB(0),U,25),0)),U,2)_$P(IB(0),U,26)
 S Z=1,IBW=1 X IBWW W " Bill Type   : ",$S('$D(IBBT):IBU,IBBT="":IBU,1:IBBT)
 W $J("",14),"Loc. of Care: ",$E($G(IBBTP1),1,30) K IBBTP1
 ; IB*2.0*432 - remove Covered, Non-covered and co-insurance days
 ;W !?4,"Covered Days: ",$S(IB("U2")="":IBU,$P(IB("U2"),U,2)'="":$P(IB("U2"),U,2),1:IBU)
 W !?4,"Charge Type : ",$S($P(IB(0),U,27)=1:"INSTITUTIONAL",$P(IB(0),U,27)=2:"PROFESSIONAL",1:IBU)
 W ?37,"Disch Stat: ",$E($$EXTERNAL^DILFD(399,162,"",$P(IB("U"),U,12)),1,30)
 W !?4,"Form Type   : ",$P($G(^IBE(353,+$P(IB(0),U,19),0)),U,1)
 W ?38,"Timeframe: ",$S($D(IBBTP3):$E(IBBTP3,1,30),1:"") K IBBTP3
 W !,?4,"Bill Classif: ",$E($G(IBBTP2),1,30) K IBBTP2
 ;W !?4,"Non-Cov Days: ",$S(IB("U2")="":IBU,$P(IB("U2"),U,3)'="":$P(IB("U2"),U,3),1:IBU)
 W ?39,"Division: ",$E($P($G(^DG(40.8,+$P(IB(0),U,22),0)),U,1),1,30)
 ;
ROI S Z=2,IBW=1 X IBWW
 W " Sensitive?  : ",$S(IB("U")="":IBU,$P(IB("U"),U,5)="":IBU,$P(IB("U"),U,5)=1:"YES",1:"NO")
 W ?46,"Assignment: ",$S(IB("U")="":IBU,$P(IB("U"),U,6)="":IBU,$P(IB("U"),U,6)["n":"NO",$P(IB("U"),U,6)["N":"NO",$P(IB("U"),U,6)=0:"NO",1:"YES")
 ;/vd - IB*2.0*623 (US4995) - Modified the following line of code with the following conditional to validate that a
 ;                            claim is ROI Eligible based upon the Date of Service.
 ;I $P(IB("U"),U,5)=1 W !?4,"R.O.I. Form : ",$S($P(IB("U"),U,7)=1:"COMPLETED",$P(IB("U"),U,7)=0:"NOT COMPLETED",1:"STATUS UNKNOWN")
 I $$ROIDTCK^IBCEU7(IBIFN) D
 . I $P(IB("U"),U,5)=1 W !?4,"R.O.I. Form : ",$S($P(IB("U"),U,7)=1:"COMPLETED",$P(IB("U"),U,7)=0:"NOT COMPLETED",1:"STATUS UNKNOWN")
 S IBOA="01^02^03^04^05^06^" F I=1:1:5 Q:'$D(IBOCN(I))  I IBOA[IBOCN(I)_"^" S IBOX=1
 W:$D(IBOX) !,?4,"Pow of Atty : ",$S($P(IB("U"),U,3)=1:"COMPLETED",$P(IB("U"),U,3)=0:"NOT COMPLETED",1:"STATUS UNKNOWN")
 ;
 S Z=3,IBW=1 X IBWW D FROMTO^IBCSC6
 ;
OP S Z=4,IBW=1 X IBWW W " OP Visits   : " F I=0:0 S I=$O(^DGCR(399,IBIFN,"OP",I)) Q:'I  S Y=I X ^DD("DD") W:$X>67 !?18 W Y_", "
 I '$O(^DGCR(399,IBIFN,"OP",0)) W IBU
 ;
 G REV^IBCSC6
 ;
 ;IBCSC7
