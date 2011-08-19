IBCF11 ;ALB/MJB - PRINT UB-82 BILL (CONT.) ;25 JAN 89 12:54
 ;;2.0;INTEGRATED BILLING;**133,210**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;MAP TO DGCRP1
 ;
 Q
13 ;I $D(IBIP),$D(IBPR) W !!,$S($P(IB(0),"^",9)]"":$P(IB(0),"^",9),1:9)
 W !!,$P(IB(0),"^",9)
 ;I '$D(IBCPT),'$D(IBICD),'$D(IBHC) G 14
 ;G:$D(IBCPT) CPT G:$D(IBICD) ICD G:$D(IBHC) HCFA
CPT ;W !!,"4"
 ;S I=0 F Z=1:1 S I=$O(IBCPT(I)) Q:'I  S X=$S($D(IB("C")):$E($P(IB("C"),U,(I+10)),4,7),1:"") S IBCPTN=$P(^ICPT(IBCPT(I),0),"^") W:Z=1 ?3,$P(^(0),"^",2),?43,IBCPTN,?49,X W:Z=2 ?54,IBCPTN,?60,X W:Z=3 ?65,IBCPTN,?71,X
 ;G 14
ICD ;W !!,"9"
 ;F I=4:1:6 I $D(IBICD(I)) S X=$E($P(IB("C"),U,(I+7)),4,5)_$E($P(IB("C"),U,(I+7)),6,7),Y=$S($D(^ICD0(IBICD(I),0)):^(0),1:"") W:I=4 ?3,$P(^ICD0(IBICD(I),0),U,4),?43,$P(Y,U,1),?49,X W:I=5 ?54,$P(Y,U,1),?60,X W:I=6 ?65,$P(Y,U,1),?71,X
 ;G 14
HCFA ;W !!,"5"
 ;F I=7:1:9 I $D(IBHC(I)) S X=$E($P(IB("C"),U,(I+4)),4,5)_$E($P(IB("C"),U,(I+4)),6,7) W:I=7 ?3,$P(^ICPT(IBHC(I),0),"^",2),?43,IBHCN(I),?49,X W:I=8 ?54,IBHCN(I),?60,X W:I=9 ?65,IBHCN(I),?71,X
 D PROC
14 F I=1:1 Q:$Y>55  W !
 W ! W:$P(IB("U"),U,13)]"" ?22,$P(IB("U"),U,13) W ?33,$S($P(IB("U1"),U,13)="":"Dept. Veterans Affairs",1:$P(IB("U1"),U,13)),?56,$P(IB("U1"),U,14)
 S IBRATY=$P(^DGCR(399,IBIFN,0),U,7),IBRATY=$P(^DGCR(399.3,IBRATY,0),U,2)
15 W !!,"Patient ID: ",$P(VADM(2),"^"),!,"Bill Type: ",$S(IBRATY]"":IBRATY,1:"UNSPECIFIED")
 I $D(IBEPAR(1)),$P(IBEPAR(1),U,4)'="" W !,$P(IBEPAR(1),U,4)
 I IB("U1")]"",$P(IB("U1"),"^",8)]"" W !,"**",$P(IB("U1"),"^",8),"**"
16 F I=1:1 Q:$Y>61  W !
 I $D(IBEPAR(1)),$P(IBEPAR(1),U,1)'="" W ?46,$P(IBEPAR(1),U,1) W:$P(IBEPAR(1),U,2)'="" !,?46,$P(IBEPAR(1),U,2)
 S IBXDT=$S(IBPNT:DT,$P(IB("S"),U,12)]"":$P(IB("S"),U,12),1:DT) W ?69,$E(IBXDT,4,5)_"-"_$E(IBXDT,6,7)_"-"_$E(IBXDT,2,3)
 W ! S (DIC,DIE)=399,IBYY=$S($P(^DGCR(399,IBIFN,"S"),"^",12)="":"@92",1:"@94"),DA=IBIFN,DR="[IB STATUS]" D ^DIE K DIC,DIE,IBYY
 D BSTAT^IBCDC(IBIFN) ; remove from auto biller list
 K IBXDT,IBMA
 Q
 ;
PROC ;  -print first 3-5 procedure codes
 S TAB=43
 S J=0 F I=1:1 S J=$O(IBPROC(J)) Q:'J!(I>3)  D
 . I IBPROC(J)["ICD" S X=$$ICD0^IBACSV(+IBPROC(J),+$P(IBPROC(J),U,2))
 . I IBPROC(J)["ICPT" S X=$$CPT^IBACSV(+IBPROC(J),+$P(IBPROC(J),U,2))
 . S Y=$E($P(IBPROC(J),U,2),4,7)
 . ;
 . I I=1 W ?3,$E($P(X,U,$S(IBPROC(J)["ICD":4,1:2)),1,30)
 . W ?(TAB+(I-1*11)),$P(X,U),?(TAB+6+(I-1*11)),Y
 Q
 ;IBCF11
