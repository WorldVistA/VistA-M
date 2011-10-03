FBAACH ;AISC/GRR-DISPLAY ID CARD HISTORY FOR PATIENT ;13APR86
 ;;3.5;FEE BASIS;;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 S IOP=$S($D(ION):ION,1:"HOME") D ^%ZIS K IOP S UL="" F A=1:1:79 S UL=UL_"="
RD K FBOUT W !! S DIC="^FBAAA(",DIC(0)="AEQM" D ^DIC G Q:X="^"!(X=""),RD:Y<0 S DFN=+Y
 I '$D(^FBAAA(DFN,4)),'$D(^FBAA(161.83,DFN)) W !!,"Patient has never been assigned ID Card!" G RD
 S FBNM=$S($D(^DPT(DFN,0)):$P(^(0),"^"),1:""),FBSSN=$$SSN^FBAAUTL(DFN)
 I '$D(^FBAAA(DFN,4)),$D(^FBAA(161.83,DFN)) D HED,NOC,HED2,LISTH G RD
 S Y(0)=^FBAAA(DFN,4),FBIDC=$P(Y(0),"^",1),FBDT=$P(Y(0),"^",2)
 D HED W !,?6,"Current ID Card: ",FBIDC,?32,"Date Issued: ",$E(FBDT,4,5),"/",$E(FBDT,6,7),"/",$E(FBDT,2,3)
 I $D(^FBAA(161.83,DFN)) D HED2,LISTH G RD
 W !!,?5,"No previous ID Cards!",! G RD
HED W @IOF,"Patient: ",FBNM,?41,"SSN: ",FBSSN,! Q
NOC W !,"Does not currently have ID Card!",! Q
HED2 W !!,"Date/Time Changed",?22,"Old Card #",?35,"Person Who Changed",!,?5,"Reason For Change",!,UL Q
LISTH I $D(^FBAA(161.83,DFN,1)) F J=0:0 S J=$O(^FBAA(161.83,DFN,1,J)) Q:J'>0  I $D(^(J,0)) S Y(0)=^(0) D GOT Q:$G(FBOUT)
 Q
GOT S FBDT=$P(Y(0),"^"),FBIDC=$P(Y(0),"^",2),FBR=$P(Y(0),"^",3),FBUSER=$P(Y(0),"^",4)
 S X=FBDT D TM^FBAAUTL S Y=FBDT D PDF^FBAAUTL S FBUSER=$S(FBUSER="":"UNKNOWN",$D(^VA(200,FBUSER,0)):$P(^(0),"^",1),1:"UNKNOWN")
 I $Y+2>IOSL S DIR(0)="E" D ^DIR K DIR S:$D(DIRUT) FBOUT=1 Q:$G(FBOUT)  D HED,HED2
 W !,Y,?10,$J(X,8),?23,FBIDC,?35,FBUSER,!,?1,FBR,!
 Q
Q K DFN,A,FBIDC,FBDT,FBOUT,FBUSER,FBNM,FBSSN,X,Y,UL,FBR,DIC,C,DIYS,I,J,Z Q
