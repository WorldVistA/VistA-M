PRCPAGS0 ;WISC/RFJ-autogenerate secondary order                     ;01 Dec 92
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 D ^PRCPUSEL Q:'$G(PRCP("I"))
 I PRCP("DPTYPE")'="S" W !!,"THIS OPTION CAN ONLY BE USED BY SECONDARY INVENTORY POINTS." Q
 N %,D,INVPT,PRCPEXIT,PRCPFLAG,PRCPFNON,PRCPFONE,V,X,Y
 S %="==========  PART 1:  SELECTION OF DISTRIBUTION INVENTORY POINTS  ==========" W !!?(80-$L(%)\2),%
 W !!,"Selected distribution inventory points will be used to auto-generate the order."
 K ^TMP($J,"PRCPAG")
 S INVPT=$$FROMCHEK^PRCPUDPT(PRCP("I"),0)
 I $G(PRCPFNON) W !!,"THIS INVENTORY POINT IS NOT STOCKED BY A PRIMARY INVENTORY POINT." Q
 I $G(PRCPFONE) S %=$$INVNAME^PRCPUX1(INVPT) W !!,"This inventory point is only stocked by: ",% S ^TMP($J,"PRCPAG","V",INVPT)=% G AUTOGEN
 K PRCPFLAG D ALL Q:$G(PRCPFLAG)
 F  D  Q:$G(PRCPFLAG)
 .   I $O(^TMP($J,"PRCPAG","V",0)) D
 .   .   W !!!,"  Currently selected distribution inventory points:",!,"  "
 .   .   S V=0 F  S V=$O(^TMP($J,"PRCPAG","V",V)) Q:'V  S %=$E(^(V),1,20),%=%_$E("                    ",$L(%),20) W:$X>70 !,"  " W %,"  "
 .   .   W !,"  You can DE-select one of the above distribution points by reselecting it."
 .   W !!,"Select the name of the inventory point that stocks your secondary, '^' to exit."
 .   I '$O(^TMP($J,"PRCPAG","V",0)) W !,"Press return without a selection to select ALL distribution inventory points."
 .   S Y=$$FROM^PRCPUDPT(PRCP("I")) I Y["^" S (PRCPEXIT,PRCPFLAG)=1 Q
 .   I 'Y,'$O(^TMP($J,"PRCPAG","V",0)) D ALL S:$G(PRCPFLAG) PRCPEXIT=1 Q
 .   I 'Y S PRCPFLAG=1 Q
 .   I $D(^TMP($J,"PRCPAG","V",+Y)) K ^(+Y) W !?10,"DE-selected !" Q
 .   S ^TMP($J,"PRCPAG","V",+Y)=$$INVNAME^PRCPUX1(Y) W !?10,"selected !"
 I $G(PRCPEXIT) D Q Q
 ;
AUTOGEN ;  start autogen with selected distribution points
 S %="==========  PART 2: START AUTO-GENERATION  ==========" W !!?(80-$L(%)\2),%
 I '$O(^TMP($J,"PRCPAG","V",0)) W !!,"NO DISTRIBUTION INVENTORY POINTS SELECTED." Q
 W !!,"Auto-generating from the following distribution inventory points:",!
 S V=0 F  S V=$O(^TMP($J,"PRCPAG","V",V)) Q:'V  S %=$E(^(V),1,20),%=%_$E("                    ",$L(%),20) W:$X>70 ! W %,"         "
 ;
 ;  check to see if there are outstanding distribution orders
 ;  unreleased
 K PRCPFLAG S X=0 F  S X=$O(^PRCP(445.3,"AD",PRCP("I"),X)) Q:'X  S D=$G(^PRCP(445.3,X,0)) I D'="",$P(D,"^",6)="" D
 .   I '$G(PRCPFLAG) W !!,"The following distribution orders have not been released for filling:"
 .   W !?5,$P(D,"^"),?15,"primary ",$$INVNAME^PRCPUX1(+$P(D,"^",2)),?50,"Date: ",$E($P(D,"^",4),4,5),"-",$E($P(D,"^",4),6,7),"-",$E($P(D,"^",4),2,3)
 .   S PRCPFLAG=1
 S %=1 I $G(PRCPFLAG) S %=2 W !,"Since the DUE-INS have not been created for the above orders, you may want to",!,"check them before continuing with auto-generating the new distribution order."
 S XP="ARE YOU SURE YOU WANT TO START AUTO-GENERATION",XH="Enter 'YES' to start auto-generating the order, 'NO' or '^' to exit."
 W !! I $$YN^PRCPUYN(%)=1 D START^PRCPAGS1
Q K ^TMP($J,"PRCPAG") Q
 ;
 ;
ALL ;  select all distribution inventory points
 S XP="  Do you want to select ALL distribution inventory points",XH="  Enter 'YES' to autogen from ALL distribution inventory points,",XH(1)="        'NO' or '^' to exit."
 W ! S %=$$YN^PRCPUYN(1)
 I %=2 Q
 I %=1 D  Q
 .   S X=0 F  S X=$O(^PRCP(445,"AB",PRCP("I"),X)) Q:'X  S ^TMP($J,"PRCPAG","V",X)=$$INVNAME^PRCPUX1(X)
 S PRCPFLAG=1 Q
