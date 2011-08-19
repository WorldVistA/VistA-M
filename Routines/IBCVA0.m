IBCVA0 ;ALB/MJB - SET MCCR VARIABLES CONT.  ;04 AUG 88 03:02
 ;;2.0;INTEGRATED BILLING;**52,361,371**;21-MAR-94;Build 57
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;MAP TO DGCRVA0
 ;
 Q
ALL I $D(DFN) S IBDPT=^DPT(DFN,0) D ADDR ;I IBADD1]"",$L(IBADD1)'>47 S DIE="^DGCR(399,",(DA,Y)=+IBIFN,DR="110///"_IBADD1 D ^DIE K DIE,DR,DA
 ;I $D(^DPT(DFN,.11)) S IBST=$P(^(.11),U,5),IBST=$S(IBST'="":$P(^DIC(5,IBST,0),U,2),1:"")
 S IBBNO=$P(IB(0),"^"),IBDT=$P(IB(0),"^",3)
 D 2^VADPT
 ;I $P(IB(0),U,5)<3 S Y=0 F I=1:1 S Y=$O(^DGPM("APTT1",DFN,Y)) Q:'Y  S:$E(Y,1,7)=IBDT IBDA=Y
 Q
1 ;Demographic variables set
 D Q1^IBCVA
EN1 Q:'$D(DFN)  S IBMAR=$S($P(IBDPT,U,5)'="":$P(IBDPT,U,5),1:"U") I IBMAR'="U" S IBMAR=$S(IBMAR=6:"S",IBMAR=2:"M",IBMAR=1:"D",IBMAR=4:"W",IBMAR=5:"X",1:"U")
 I $D(^DPT(DFN,.121)) S IBTADD=^DPT(DFN,.121),IBTST=$P(IBTADD,U,5),IBTST=$S(IBTST'="":$P(^DIC(5,IBTST,0),U,2),1:"") I $P(IBTADD,U)="" S IBT1="NO TEMPORARY ADDRESS"
 Q
2 ;Employment variables set
 D Q1^IBCVA,Q2^IBCVA
EN2 S:'$D(^DPT(DFN,.311)) IBEMPD="" I $D(^DPT(DFN,.311)) I ^DPT(DFN,.311)'="" S IBEMPD=$P(^(.311),U)_"^"_$P(^(.311),U,6)_"^"_$S($P(^(.311),U,7)'="":$P(^(.311),U,7),1:"")_"^"_$P($G(^DPT(DFN,.22)),U,5)_"^"_$P(IB(0),U,9)_"^"_$P(IB(0),U,8)
 I $D(IBEMPD) S:IBEMPD'="" IBEC=$P(^DPT(DFN,.311),"^",15)
 I $D(^DPT(DFN,.25)) S:$P(^DPT(DFN,.25),U,6)'="" IBSEST=$P(^(.25),U,6),IBSEST=$P(^DIC(5,IBSEST,0),U,2)
 Q
3 ;Insurance variables set
EN3 D 123^IBCVA
EN31 ; -IBdd(i) = value of ins node in dpt
 I '$D(^DGCR(399,IBIFN,"AIC")) S IBINDT=$S(+$G(IB("U")):+IB("U"),+$G(^DGCR(399,IBIFN,"U")):+$G(^("U")),1:DT) D ALL^IBCNS1(DFN,"IBDD",1,IBINDT) S I="" F  S I=$O(IBDD(I)) Q:'I  D INS
 I $D(^DGCR(399,IBIFN,"AIC")) S IBIN="I" F I=1:1:3 S IBIN=$O(^DGCR(399,IBIFN,IBIN)) Q:IBIN'?1"I".N  S IBDD(I,0)=^DGCR(399,IBIFN,IBIN) D INS
 Q
INS I $P(IBDD(I,0),U,6)="v" S IBISEX(I)=$P(^DPT(DFN,0),U,2)
 E  S IBISEX(I)=$P($G(^DPT(DFN,.312,+$P($G(^DGCR(399,IBIFN,"M")),U,I+11),3)),U,12) ; *361 replaces old calculation of insured's sex
 S IBISEX(I)=$S(IBISEX(I)="M":"MALE",IBISEX(I)="F":"FEMALE",1:"UNSPECIFIED")
 S IBIRN(I)=$P(IBDD(I,0),U,16)
 S IBIR(I)=$$EXTERNAL^DILFD(2.312,16,,IBIRN(I))
 Q
ADDR ;SET ADDRESS
 S IBADD1="" I $D(^DGCR(399,IBIFN,"M")),$P(^("M"),"^",10)]"" Q
 S X=$S($D(^DPT(DFN,.11)):^(.11),1:"") F I=1:1:4 I $P(X,"^",I)]"" S IBADD1=IBADD1_$P(X,"^",I)_","
 I $D(^DIC(5,+$P(X,"^",5),0)) S IBADD1=IBADD1_$P(^(0),"^",2),IBST=$P(^(0),"^",2)
 S:$P(X,"^",12)]"" IBADD1=IBADD1_" "_$P(X,"^",12) Q
 ;IBCVA0
