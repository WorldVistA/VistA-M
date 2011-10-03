PRCPAGP0 ;WISC/RFJ-autogenerate primary or warehouse order               ;11 Dec 92
 ;;5.1;IFCAP;**108**;Oct 20, 2000;Build 10
 ;Per VHA Directive 2004-038, this routine should not be modified.
 D ^PRCPUSEL Q:'$G(PRCP("I"))
 I "PW"'[PRCP("DPTYPE") W !!,"THIS OPTION CAN ONLY BE USED BY A PRIMARY OR WHSE INVENTORY POINT." Q
 N %,G,GROUP,GROUPALL,GROUPNM,PRCPEXIT,PRCPFLAG,PRCPREPN,VENDALL,WHSE,X,Y
 S WHSE=+$O(^PRC(440,"AC","S",0)) I 'WHSE W !!,"WAREHOUSE VENDOR HAS NOT BEEN CREATED IN VENDOR FILE." Q
 ;
 ;  get repetitive item list number
 S %="==========  PART 1:  REPETITIVE ITEM LIST NUMBER  ==========" W !!?(80-$L(%)\2),%
 S PRCPREPN=$$GETRIL^PRCPAGPR I PRCPREPN="" Q
 ;
 ;  select group categories
 S %="==========  PART 2A:  SELECTION OF GROUP CATEGORIES  ==========" W !!?(80-$L(%)\2),%
 W !!,"Selected group categories and vendors will be used to auto-generate the order."
 K ^TMP($J,"PRCPAG") D ALLGRP I $G(PRCPFLAG) Q
 F  D  I $G(PRCPFLAG) Q
 .   I $O(^TMP($J,"PRCPAG","GY",0))!($G(GROUPALL)) D
 .   .   W !!,"  Currently selected group categories:",!,"  "
 .   .   I $G(GROUPALL) W "<< ALL GROUP CATEGORIES >>"
 .   .   E  S G=0 F  S G=$O(^TMP($J,"PRCPAG","GY",G)) Q:'G  S %=$E(^(G),1,20),%=%_$E("                    ",$L(%),20) W:$X>70 !,"  " W %,"  "
 .   .   W !,"  You can DE-select one of the above group categories by reselecting it."
 .   I $O(^TMP($J,"PRCPAG","GN",0)) D
 .   .   W !!,"  Currently DE-selected group categories:",!,"  "
 .   .   S G=0 F  S G=$O(^TMP($J,"PRCPAG","GN",G)) Q:'G  S %=$E(^(G),1,20),%=%_$E("                    ",$L(%),20) W:$X>70 !,"  " W %,"  "
 .   .   W !,"  You can RE-select one of the above group categories by reselecting it."
 .   W !!,"Select the name of the group category created for this primary, '^' to exit."
 .   S GROUP=$$GROUP^PRCPEGRP(PRCP("I"),"") I GROUP<0 S (PRCPFLAG,PRCPEXIT)=1 Q
 .   S GROUPNM=$$GROUPNM^PRCPEGRP(GROUP)
 .   I GROUP=0,'$O(^TMP($J,"PRCPAG","GY",0)),'$G(GROUPALL) D ALLGRP S:$G(PRCPFLAG) PRCPEXIT=1 Q
 .   I GROUP=0 S PRCPFLAG=1 Q
 .   I $G(GROUPALL),'$D(^TMP($J,"PRCPAG","GN",GROUP)) K ^TMP($J,"PRCPAG","GY",GROUP) S ^TMP($J,"PRCPAG","GN",GROUP)=GROUPNM W !?10,"DE-selected !" Q
 .   I $D(^TMP($J,"PRCPAG","GY",GROUP)) K ^TMP($J,"PRCPAG","GY",GROUP) S ^TMP($J,"PRCPAG","GN",GROUP)=GROUPNM W !?10,"DE-selected !" Q
 .   I $D(^TMP($J,"PRCPAG","GN",GROUP)) K ^(GROUP) S ^TMP($J,"PRCPAG","GY",GROUP)=GROUPNM W !?10,"RE-selected !" Q
 .   S ^TMP($J,"PRCPAG","GY",GROUP)=GROUPNM W !?10,"selected !"
 I $G(PRCPEXIT) D Q Q
 I $G(GROUPALL) K ^TMP($J,"PRCPAG","GY")
 I '$G(GROUPALL),'$O(^TMP($J,"PRCPAG","GY",0)) W !!,"NO GROUP CATEGORIES SELECTED." D Q Q
 ;
 ;  select vendors
 S %="==========  PART 2B:  SELECTION OF VENDORS  ==========" W !!?(80-$L(%)\2),%
 S VENDALL=1
 I $G(GROUPALL),'$O(^TMP($J,"PRCPAG","GN",0)) D GETVEND^PRCPAGPV I $G(PRCPEXIT) D Q Q
 ;
 ;  start running autogen
 I '$G(VENDALL),'$O(^TMP($J,"PRCPAG","VY",0)) W !!,"NO VENDORS SELECTED." D Q Q
 I $G(VENDALL),'$O(^TMP($J,"PRCPAG","VN",0)) W !!,"<<< NOTE: Auto-generating for ALL vendors."
 S %="==========  PART 3:  START AUTO-GENERATION  ==========" W !!?(80-$L(%)\2),%
 S XP="ARE YOU SURE YOU WANT TO START AUTO-GENERATION",XH="Enter 'YES' to start auto-generating the order, 'NO' or '^' to exit."
 W !! I $$YN^PRCPUYN(1)=1 D START^PRCPAGP1
Q K ^TMP($J,"PRCPAG") Q
 ;
 ;
ALLGRP ;  select all group categories
 K GROUPALL,PRCPFLAG
 S XP="Do you want to select ALL group categories",XH="Enter 'YES' to auto-generate for ALL inventory items selectable by vendor,",XH(1)="enter 'NO' to auto-generate selectable group category items not selectable by"
 S XH(2)="vendor, or enter '^' to exit."
 W ! S %=$$YN^PRCPUYN(1)
 I %=2 Q
 I %=1 S GROUPALL=1 Q
 S PRCPFLAG=1 Q
