IBCSC6 ;ALB/MJB - MCCR SCREEN 6 (INPT. BILLING INFO) ;27 MAY 88 10:19
 ;;2.0;INTEGRATED BILLING;**52,80,109,106,51,137,343,400,432,623**;21-MAR-94;Build 70
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;MAP TO DGCRSC6
 ;
EN I $P(^DGCR(399,IBIFN,0),"^",5)>2 G EN^IBCSC7
 I $D(DGRVRCAL) D ^IBCU6 K DGRVRCAL
 D ^IBCSCU S IBSR=6,IBSR1="",IBV1="0000000" S:IBV IBV1="1111111" F I="U","U1",0,"U2","U3" S IB(I)=$S($D(^DGCR(399,IBIFN,I)):^(I),1:"")
 D H^IBCSCU
 S IBBT=$P(IB(0),U,24)_$P(IB(0),U,5)_$P(IB(0),U,26)
 S IBBT1=$P(IB(0),U,24)_$P($G(^DGCR(399.1,+$P(IB(0),U,25),0)),U,2)_$P(IB(0),U,26)
 D 4^IBCVA1,5^IBCVA1
 ;
1 S Z=1,IBW=1 X IBWW W " Bill Type   : ",$S('$D(IBBT1):IBU,IBBT1="":IBU,1:IBBT1)
 W $J("",14),"Loc. of Care: ",$E($G(IBBTP1),1,30) K IBBTP1
 ;W !?4,"Covered Days: ",$S(IB("U2")="":IBU,$P(IB("U2"),U,2)'="":$P(IB("U2"),U,2),1:IBU)
 W !?4,"Charge Type : ",$S($P(IB(0),U,27)=1:"INSTITUTIONAL",$P(IB(0),U,27)=2:"PROFESSIONAL",1:IBU)
 ; IB*2.0*432 - remove Covered, Non-covered and co-insurance days
 ;W !?4,"Non-Cov Days: ",$S(IB("U2")="":IBU,$P(IB("U2"),U,3)'="":$P(IB("U2"),U,3),1:IBU)
 W ?38,"Timeframe: ",$S($D(IBBTP3):$E(IBBTP3,1,30),1:"") K IBBTP3
 W !?4,"Form Type   : ",$P($G(^IBE(353,+$P(IB(0),U,19),0)),U,1)
 W ?39,"Division: ",$E($P($G(^DG(40.8,+$P(IB(0),U,22),0)),U,1),1,30)
 W !,?4,"Bill Classif: ",$E($G(IBBTP2),1,30) K IBBTP2
 ;W ?34,"Co-Insur Days: ",$S($P(IB("U2"),U,7)="":$S($$MCRONBIL^IBEFUNC(IBIFN):IBU,1:IBUN),1:$P(IB("U2"),U,7))
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
3 S Z=3,IBW=1 X IBWW D FROMTO
 ;
BED S Z=4,IBW=1 X IBWW
 W " Bedsection  : ",$S(IB("U")="":IBU,$P(IB("U"),U,11)'="":$P(^DGCR(399.1,$P(IB("U"),U,11),0),U,1),1:IBU)
 W !?4,"LOS         : ",IBLS
 ;
 I $P($G(^DPT(DFN,.3)),"^")="Y" D SC I IBSCM>0 W !?4,"PTF record indicates ",IBSCM," of ",IBM," movements are for Service Connected Care."
 ;
REV S Z=5,IBREVC=0,IBW=1 X IBWW W " Rev. Code   : " F I=1:1:8 Q:'$D(IBREVC(I))  D:$S(IBREVC<7:1,1:$P(IBREVC(I),U,9)="") REV^IBCSC61 S IBREVC=IBREVC+1 Q:IBREVC>7
 I $G(IBREVC)>9 W !,?4,"Too many Revenue Codes to display, enter '5' to list"
BILL D OFFSET^IBCSC61
 I $G(IBUCH),$$FT^IBCEF(IBIFN)=3 S X=IBUCH,X2="2$" D COMMA^%DTC W !,?39,"Non-Cov: ",X
 ;
RS S Z=6,IBW=1 X IBWW W " Rate Sched  : (re-calculate charges)"
 ;
PRPAY S Z=7,IBW=1 X IBWW
 S IB("M1")=$G(^DGCR(399,IBIFN,"M1")),X3=0,IBI="Prior Payments:" F X=0,1,2 D
 . S X1=$P(IB("U2"),U,(X+4)),X2=$P(IB("M1"),U,(5+X)) I X1="",X2="" Q
 . S IBI=IBI_$J("",(17-$L(IBI)))_$S(X=0:"Primary",X=1:"Secondary",X=2:"Tertiary",1:"")
 . S IBI=IBI_$J("",(28-$L(IBI)))_$S(X1'="":$J(X1,11,2),1:IBU)
 . S IBI=IBI_$J("",(50-$L(IBI)))_"Bill #: "_$S(+X2:$P($G(^DGCR(399,+X2,0)),U,1),1:IBU)
 . W:'X3 " " W:X3 !,?4 W IBI S X3=1,IBI=""
 I 'X3 W " Prior Claims: ",IBU
 ;
 G ^IBCSCP
 Q
 ;
FROMTO ;  - Print From and To dates of bill
 W " Bill From   : " S Y=$P(IB("U"),"^") D D^DIQ W $S($L(Y):Y,1:IBU)
 W ?49,"Bill To: " S Y=$P(IB("U"),"^",2) D D^DIQ W $S($L(Y):Y,1:IBU)
 Q
 ;
SC ;  -if patient is sc, are movements for sc care
 S PTF=$P(IB(0),"^",8)
 ;
SC1 ;
 ;  -input ptf
 ;
 ;  -output IBm   = number of movements
 ;          IBscm = number of SC movements
 S (IBM,IBSCM,M)=0
 I $S('PTF:1,'$D(^DGPT(PTF,0)):1,1:0) Q
 F  S M=$O(^DGPT(PTF,"M",M)) Q:'M  S IBM=IBM+1 I $P($G(^DGPT(PTF,"M",M,0)),"^",18)=1 S IBSCM=IBSCM+1
 Q
 ;IBCSC6
