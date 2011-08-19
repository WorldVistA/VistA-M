PRCSP13 ;BOISE/TKE,WISC/SAW-CPA PRINTS CON'T-TRANSACTION STATUS REPORT ;12/28/92  4:32 PM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 U IO S U="^",PRCS0=$S($D(^PRCS(410,DA,0)):^(0),1:""),PRCSS=IOSL-2
 S PRCSTC=$P(PRCS0,"^",2),PRCSTP="" I PRCSTC'="" S X=$P(^DD(410,1,0),U,3) F I=1:1 S Y=$P(X,";",I) Q:Y=""  I $P(Y,":")=PRCSTC S PRCSTP=$P(Y,":",2) Q
 S PRCSEX="" D HDR
CA I PRCSTC="CA" W ! S PRCSDY=4 D COM^PRCSP131 G EX
C G A:PRCSTC="A",O:PRCSTC="O" S PRCS6=$S($D(^PRCS(410,DA,6)):^(6),1:"")
 W !,"Ceiling $ Amount: $",$J(+$P(PRCS6,U),0,2),?41,"Date Allocated: " S Y=$P(PRCS6,U,2) X:Y ^DD("DD") W Y
 W !,"Fund Control Point Dist. No.: ",$P(PRCS6,U,3) S PRCS6=$S($D(^PRCS(410,DA,4)):^(4),1:"") W !,"Reference Number: ",$P(PRCS6,U,5) K PRCS6 D ACC S PRCSDY=8 D COM^PRCSP131 G EX
A D VND
 S PRCS4=$S($D(^PRCS(410,DA,4)):^(4),1:"") W !,"Purchase Order/Obligation No.: ",$P(PRCS4,U,5),?41,"Adjustment $ Amount: $",$J($P(PRCS4,U,6),0,2)
 S Y=$P(PRCS4,U,7) X:Y ^DD("DD") W !,"Date Obl.Adjusted: ",Y K PRCS4
 D ACC S X=$S($D(^PRCS(410,DA,11)):$P(^(11),U),1:"") S:$P(X,";") X=$P(X,";",2)_$P(X,";"),X="^"_X_",0)",X=$S($D(@X):$P(^(0),U),1:"") W !,"Sort Group: ",X
 S PRCS1=$S($D(^PRCS(410,DA,1)):^(1),1:"") W ?41,"Classification of Request: " S X=$S($D(^PRCS(410.2,+$P(PRCS1,U,5),0)):$E($P(^(0),U),1,22),1:"") W X K PRCS1
 S PRCSDY=4 D SUBC^PRCSP132 G EX:PRCSEX[U D:PRCSDY>(PRCSS-4) S G EX:PRCSEX[U
 S PRCSDY=PRCSDY+5 D:PRCSDY>(PRCSS-1) S G EX:PRCSEX[U D COM^PRCSP131 G EX
O ;
 S D0=DA D STATUS^PRCSES W !,"A&MM Status: ",X I $D(^PRCS(410,DA,10)),$D(^PRC(442,+$P(^(10),U,3),1)),$D(^VA(200,+$P(^(1),U,10),20)) W ?41,"PA/PPM: ",$P(^(20),U,2)
 W !,"Temporary Trans. Number: ",$P(PRCS0,U,3) W:'PRCS0 ?41,"Control Point: ",$E($P(^PRCS(410,DA,3),U),1,24)
 W !,"Form Type: ",$S($D(^PRCS(410.5,+$P(PRCS0,U,4),0)):$P(^(0),U),1:"") I $P(PRCS0,U,4)=1,$P(PRCS0,U,8) W ?41,"Month of 1358: ",$P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC",U,$P(PRCS0,U,8))
 S PRCS1=$S($D(^PRCS(410,DA,1)):^(1),1:"") W !,"Date of Request: " S Y=$P(PRCS1,U) X:Y ^DD("DD") W Y W ?41,"Date Required: " S Y=$P(PRCS1,U,4) X:Y ^DD("DD") W Y
 S PRCS9=$S($D(^PRCS(410,DA,9)):^(9),1:"") W !,"Est. Delivery Date: " S Y=$P(PRCS9,U,2) X:Y ^DD("DD") W Y W ?41,"Date Received: " S Y=$P(PRCS9,U,3) X:Y ^DD("DD") W Y
 D VND S PRCS4=$S($D(^PRCS(410,DA,4)):^(4),1:"")
 W !,"Committed (Estimated) Cost: $",$J($P(PRCS4,U),0,2),?41,"Date Committed: " S Y=$P(PRCS4,U,2) X:Y ^DD("DD") W Y
 W !,"Obligated (Actual) Cost: $",$J($P(PRCS4,U,3),0,2),?41,"Date Obligated: " S Y=$P(PRCS4,U,4) X:Y ^DD("DD") W Y
 W !,"Purchase Order/Obligation No.: ",$P(PRCS4,U,5) K PRCS4
 D ACC W !,"Return to Service Comments:" W:$D(^PRCS(410,DA,13,1,0)) $E(^(0),1,80),! W !,"Comments:" W:$D(^PRCS(410,DA,"CO",1,0)) $E(^(0),1,80),! S PRCSDY=20 D ^PRCSP131,^PRCSP133 G EX
VND W !,"Vendor: ",$S($D(^PRCS(410,DA,2)):$E($P(^(2),U),1,30),1:"")
 S PRCSVND=$S($D(^PRC(442,+$S($D(^PRCS(410,DA,10)):$P(^(10),U,3),1:""),1)):$P(^(1),U),1:"") I $D(^PRCS(410,DA,3)),$P(^(3),U,4)'=PRCSVND W ?41,"P.O. Vendor: ",$S($D(^PRC(440,+PRCSVND,0)):$E($P(^(0),U),1,20),1:"")
 Q
ACC W ?41,"Accounting Data: ",$S($D(^PRCS(410,DA,3)):$P(^(3),U,2),1:"")
 S PRCS5=$S($D(^PRCS(410,DA,5)):^(5),1:"") W !,"FMS $ Amount: $",$J($P(PRCS5,U),0,2) S Y=$P(PRCS5,U,2) X:Y ^DD("DD") W ?41,"FMS Date: ",Y W !,"FMS Transaction Code: ",$P(PRCS5,U,3) K PRCS5 Q
HDR W @IOF D NOW^%DTC S Y=% X:Y ^DD("DD") W ?10,PRCSTP," TRANSACTION STATUS DISPLAY          ",Y,!!
 W "Transaction Number: ",$P(PRCS0,U),?41,"Transaction Type: ",PRCSTP S X="",PRCSDY=3 Q
S Q:$D(ZTQUEUED)  G S2:$E(IOST)'="C" F L=PRCSDY:1:PRCSS W !
 W !,"Press return to continue or ""^"" to escape" R X:DTIME S:'$T X="^" S PRCSEX=X Q:X[U
S2 D HDR Q
EX D:$D(ZTSK) KILL^%ZTLOAD K ZTSK
EXIT K PRCS0,PRCSTC,PRCSTP,PRCSI,PRCSJ,PRCSEX,DA,PRCSS,PRCSDY,DIWL,DIWR,DIWF,I,J,L,X,Y,Z,^TMP($J) D ^%ZISC Q
