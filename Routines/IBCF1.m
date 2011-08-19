IBCF1 ;ALB/MJB/AAS - PRINT UB-82 BILL  ;10 JUN 88 14:42
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;MAP TO DGCRP
 ;
ZIS Q:'$D(IBAC)  S:'$D(IBPNT) IBPNT=0
 ;S DGPGM="ENP^IBCF1",DGVAR="DFN^IBCIFN^IBC^IBEPAR^IBCDPT^IBCU^IBPNT" D ZIS^DGUTQ I POP G Q
 ;
DEV S %ZIS="Q",%ZIS("A")="Output Device: "
 S %ZIS("B")=$P($G(^IBE(353,+$P($G(^DGCR(399,IBIFN,0)),"^",19),0)),"^",2)
 D ^%ZIS G:POP Q
 I $D(IO("Q")) S ZTRTN="ENP^IBCF1",ZTDESC="PRINT BILL",ZTSAVE("IB*")="",ZTSAVE("DG*")="",ZTSAVE("DFN")="" D ^%ZTLOAD K IO("Q") D HOME^%ZIS G Q
 ;
 U IO D ENP
Q S IBKILL=1 D Q5^IBCVA
 D:'$D(ZTQUEUED) ^%ZISC
 K IBKILL Q
 ;
Q1 K DFN,IBIFN Q
ENP Q:'$D(DFN)  D SET D:$D(IBIFN) ALL^IBCVA0 D EN1^IBCVA0,EN4^IBCVA1,EN5^IBCVA1,^IBCF12
EN2 W @IOF I IB("I1")]"",$P(IB("I1"),U,1)]"",$P($G(^DIC(36,$P(IB("I1"),U,1),0)),U,3)=1 W "##SR"
 W ?24,$S(IBPNT=1:"",IBPNT=0:"*** COPY OF ORIGINAL BILL ***",IBPNT=2:"*** SECOND NOTICE ***",IBPNT=3:"*** THIRD NOTICE ***",1:"")
 ;
1 F I=1,2 W !,$S(IBEPAR(2)]"":$P(IBEPAR(2),U,I),1:"")
 W ?24,$P(IB("U1"),U,4),?57,IBBNO,?74,IBBT
2 I IBEPAR(2)]"" W !,$P(IBEPAR(2),U,3) S IBOPST=$P(IBEPAR(2),U,4),IBOPST=$P(^DIC(5,IBOPST,0),"^",2) W ?$X+2,IBOPST,?$X+2,$P(IBEPAR(2),U,5)
3 W !,$S(IBEPAR(2)]"":$P(IBEPAR(2),U,6),1:"")
 S X=$P(IBEPAR(1),"^",6) W ?24,$S($P(IB("U"),U,14)]"":$P(IB("U"),U,14),1:X),?38,$P(IBEPAR(1),U,5),?50,$P(IBEPAR(1),"^",21),?71,$P(IB("U1"),U,5)
4 W !!,VADM(1),?33,$S(IB("M")']"":"",$P(IB("M"),U,10)]"":$P(IB("M"),U,10),1:"")
5 W !!,$E($P(VADM(3),U),4,7)_$E($P(VADM(3),U),2,3),?8,$P(VADM(5),U),?10 S Y=$P(IBDPT(0),U,5) W $S(Y=1:"D",Y=2:"M",Y=4:"W",Y=5:"X",Y=6:"S",1:"U")
 W:$D(IBIP) ?14,$S($P(IBIP,U,2)'="":$E($P(IBIP,U,2),4,7)_$E($P(IBIP,U,2),2,3),1:$E(IBDT,4,7)_$E(IBDT,2,3)),?21,$S($E($P($P(IBIP,U,2),".",2),1,2)'="":$E($P($P(IBIP,U,2),".",2),1,2),1:"99")
 W:$D(IBIP) ?24,$S($P(IBIP,U,5)'="":$P(IBIP,U,5),1:9),?27,$S($P(IBIP,U,4)'="":$P(IBIP,U,4),1:9),?29,$S($P(IBIP,U,3)'="":$P(IBIP,U,3),1:"99")
 I $D(IBIP) W ?32,$S($P(IBIP,U,6)']"":"99",1:$E($P($P(IBIP,U,6),".",2),1,2)) S X=$P(IBIP,U,7) W ?36,$S($D(^DGCR(399.1,+X,0)):$P(^(0),"^",2),1:"")
 I '$D(IBIP) W ?14,$E(IBDT,4,7)_$E(IBDT,2,3),?21,"99"
 W ?40,$E($P(IB("U"),"^"),4,7)_$E($P(IB("U"),"^"),2,3),?48,$E($P(IB("U"),"^",2),4,7)_$E($P(IB("U"),"^",2),2,3),?70,$P(IB("U1"),U,6),!!
6 I $D(IBO(1)) W IBO(1),?3,$E(IBOCD(1),4,7)_$E(IBOCD(1),2,3) I $D(IBO(2)) W ?11,IBO(2),?14,$E(IBOCD(2),4,7)_$E(IBOCD(2),2,3) I $D(IBO(3)) W ?22,IBO(3),?25,$E(IBOCD(3),4,7)_$E(IBOCD(3),2,3)
 I $D(IBO(4)) W ?35,IBO(4),?38,$E(IBOCD(4),4,7)_$E(IBOCD(4),2,3) I $D(IBO(5)) W ?46,IBO(5),?49,$E(IBOCD(5),4,7)_$E(IBOCD(5),2,3)
 D 7^IBCF10 I DGPAG<DGTOTPAG S DGPAG=DGPAG+1 G EN2
 Q
SET ;Set Variables
 D 2^VADPT F I=0,.11,.121,.25,.311,.36 S IBDPT(I)=$S($D(^DPT(DFN,I)):^(I),1:"")
 F I=0,"C","I1","I2","I3","M","M1","S","U","U1" S IB(I)=$S($D(^DGCR(399,IBIFN,I)):^(I),1:"")
 F I=0,1,2 S IBEPAR(I)=$G(^IBE(350.9,1,I))
 S IBBT=$P(IB(0),"^",4)_$P(IB(0),"^",5)_$P(IB(0),"^",6)
 S IBU="UNSPECIFIED" Q
 ;IBCF1
