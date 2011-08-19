LRCKPTR ;SLC/RWF - CHECK ^LR & ^DPT CROSS POINTERS ; 8/30/87  17:20 ;
 ;;5.2;LAB SERVICE;**272,293**;Sep 27, 1994
 W !,"CHECK OF POINTERS TO/FROM THE ^LR FILE",!!,"Want me to add missing nodes. " S %=2,U="^" D YN^DICN I %<1 W:%=0 !!,"a 'yes' and I will add missing zero nodes that are reported,",!,"  and missing pointers to ^LR." Q:%<0  G LRCKPTR
 S LRFIX=(%=1)
 S DFN=0,%ZIS="Q" D ^%ZIS Q:POP
 I $D(IO("Q")) K IO("Q") S ZTRTN="DQ^LRCKPTR",ZTSAVE("LRFIX")="",ZTDESC="Integrity Report" D ^%ZTLOAD K ZTRTN,ZTIO,ZTDESC,ZTSAVE,ZTSK D ^%ZISC Q
DQ S:$D(ZTQUEUED) ZTREQ="@" D ENT W !! W:$E(IOST,1,2)="P-" @IOF K LRFIX Q
ENT ;from LRCKF
 U IO W ! S:'$D(LRFIX) LRFIX=0
 F LRF=0:0 S LRF=$O(^DIC("AC","LR",LRF)) Q:LRF'>0  D LRP
 G LRS
LRP S U="^",DFN=0,DIC=$S($D(^DIC(LRF,0,"GL")):^("GL"),1:"") I DIC'[U W !,"BAD ENTRY IN APPLICATION GROUP" Q
 W !,"CHECKING THE ",$P(^DIC(LRF,0),U)," FILE (#",LRF,") POINTERS.",!
DPT S @("DFN=$O("_DIC_"DFN))") G END:DFN'>0 S @("D=$D("_DIC_"DFN,""LR""))[0") G DPT:D S LR=^("LR")
 I LR'>0!(+LR'=LR) W !,"Entry: ",DFN," has a invalid LR Pointer: '",LR,"'." G DPT
 W:'$D(^LR(LR,0)) !,"Entry: ",DFN," Pointer to MISSING node LR: ",LR
 IF $D(^LR(LR,0))[0 W !,"LR: ",LR," Is missing the zero node." S:LRFIX ^LR(LR,0)=LR_U_LRF_U_DFN W:LRFIX "  added" G DPT
 S X=^LR(LR,0),LRDPF=$P(X,U,2) W:LRDPF'=LRF !,"Entry: ",DFN," points to LR: ",LR," Which doesn't point back to this file.",!?5," ^LR points to file: ",LRDPF
 W:$P(X,U,3)'=DFN !,"Entry: ",DFN," Points to a entry that points to Entry: ",$P(X,U,3)
 G DPT
LRS S LR=0 W !!,"CHECKING THE LAB DATA FILE POINTERS.",!
LR S LR=$O(^LR(LR)) G END:LR'>0 I $D(^LR(LR,0))[0 W !,"LR: ",LR," Lacks a zero node." G LR
 S LRDPF=+$P(^LR(LR,0),U,2),DFN=+$P(^(0),U,3),LRGBL=$S(LRDPF=2:"^DPT(",1:$S($D(^DIC(LRDPF,0,"GL")):^("GL"),1:""))_DFN_","
 I LRDPF<2!(DFN'>0) W !,"LR: ",LR," has a BAD file or entry pointer. File: ",LRDPF," Entry: ",DFN G LR
 I $D(^DIC(LRDPF,0,"GL"))[0 W !,"LR: ",LR,?11," Points to a BAD file: ",LRDPF G LR
 I @("$D("_LRGBL_"0))[0") W !,"LR: ",LR,?11," Points to a missing ",$P(^DIC(LRDPF,0),U)," FILE ENTRY, Entry: ",DFN S:LRFIX @(LRGBL_"0)=""LOST,PT."""),@(LRGBL_"""LR"")="_LR) W:LRFIX "  added" G LR
 I @("$D("_LRGBL_"""LR""))[0") W !,"LR: ",LR,?11," Points to file: ",LRDPF," Entry: ",DFN,", that doesn't have a pointer." S:LRFIX @(LRGBL_"""LR"")="_LR) W:LRFIX "  added" G LR
 W:@(LRGBL_"""LR"")")'=LR !,"LR: ",LR,?11," Points to file: ",LRDPF," Entry: ",DFN,", That points to LR: ",^("LR")
 G LR
END K LRGBL W !,"ALL DONE",! W:$E(IOST,1,2)="P-" @IOF Q
 Q
