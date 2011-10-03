PRCPRPHP ;WISC/RFJ-physical count form for prim and sec;02 Feb 93 ; 3/22/99 11:32am
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 D ^PRCPUSEL Q:'$G(PRCP("I"))
 N %,%H,%I,D,DESCR,G,GROUP,GROUPALL,GROUPNM,ITEMDA,MAIN,NOW,PAGE,PRCPEXIT,PRCPFLAG,PRCPOH,SCREEN,X,Y
 S PRCPOH=0
 S XP="Do you need to print the ON-HAND column"
 S XH="Enter 'YES' only if you are NOT performing a physical count."
 W ! S %=$$YN^PRCPUYN(2)
 I %=0 Q
 I %=1 S PRCPOH=1
 W !!,"Selected group categories will be used to generate the physical count form."
 K ^TMP($J,"PRCPRPH") D ALLGRP I $G(PRCPFLAG) Q
 F  D  I $G(PRCPFLAG) Q
 .   I $O(^TMP($J,"PRCPRPH","YES",0))!($G(GROUPALL)) D
 .   .   W !!,"  Currently selected group categories:",!,"  "
 .   .   I $G(GROUPALL) W "<< ALL GROUP CATEGORIES >>"
 .   .   E  S G=0 F  S G=$O(^TMP($J,"PRCPRPH","YES",G)) Q:'G  S %=$E(^(G),1,20),%=%_$E("                    ",$L(%),20) W:$X>70 !,"  " W %,"  "
 .   .   W !,"  You can DE-select one of the above group categories by reselecting it."
 .   I $O(^TMP($J,"PRCPRPH","NO",0)) D
 .   .   W !!,"  Currently DE-selected group categories:",!,"  "
 .   .   S G=0 F  S G=$O(^TMP($J,"PRCPRPH","NO",G)) Q:'G  S %=$E(^(G),1,20),%=%_$E("                    ",$L(%),20) W:$X>70 !,"  " W %,"  "
 .   .   W !,"  You can RE-select one of the above group categories by reselecting it."
 .   W !!,"Select the name of the group category created for this primary, '^' to exit."
 .   S GROUP=$$GROUP^PRCPEGRP(PRCP("I"),"") I GROUP<0 S (PRCPFLAG,PRCPEXIT)=1 Q
 .   S GROUPNM=$$GROUPNM^PRCPEGRP(GROUP)
 .   I GROUP=0,'$O(^TMP($J,"PRCPRPH","YES",0)),'$G(GROUPALL) D ALLGRP S:$G(PRCPFLAG) PRCPEXIT=1 Q
 .   I GROUP=0 S PRCPFLAG=1 Q
 .   I $G(GROUPALL),'$D(^TMP($J,"PRCPRPH","NO",GROUP)) K ^TMP($J,"PRCPRPH","YES",GROUP) S ^TMP($J,"PRCPRPH","NO",GROUP)=GROUPNM W !?10,"DE-selected !" Q
 .   I $D(^TMP($J,"PRCPRPH","YES",GROUP)) K ^TMP($J,"PRCPRPH","YES",GROUP) S ^TMP($J,"PRCPRPH","NO",GROUP)=GROUPNM W !?10,"DE-selected !" Q
 .   I $D(^TMP($J,"PRCPRPH","NO",GROUP)) K ^(GROUP) S ^TMP($J,"PRCPRPH","YES",GROUP)=GROUPNM W !?10,"RE-selected !" Q
 .   S ^TMP($J,"PRCPRPH","YES",GROUP)=GROUPNM W !?10,"selected !"
 I $G(PRCPEXIT) D Q^PRCPRPH1 Q
 I $G(GROUPALL) K ^TMP($J,"PRCPRPH","YES")
 I '$G(GROUPALL),'$O(^TMP($J,"PRCPRPH","YES",0)) W !!,"NO GROUP CATEGORIES SELECTED." D Q^PRCPRPH1 Q
 ;
 S %ZIS="Q" W ! D ^%ZIS Q:POP  I $D(IO("Q")) D  D ^%ZTLOAD K IO("Q"),ZTSK Q
 .   S ZTDESC="Physical Count Form",ZTRTN="DQ^PRCPRPH1"
 .   S ZTSAVE("PRCP*")="",ZTSAVE("GROUPALL")="",ZTSAVE("^TMP($J,""PRCPRPH"",")="",ZTSAVE("ZTREQ")="@"
 W !!,"<*> please wait <*>"
 D DQ^PRCPRPH1 Q
 ;
 ;
ALLGRP ;select all groups
 K GROUPALL,PRCPFLAG
 S XP="Do you want to select ALL group categories",XH="Enter 'YES' to generate the physical count form for ALL group categories",XH(1)="enter 'NO' to print the physical count form for selected group categories"
 S XH(2)="or enter '^' to exit."
 W ! S %=$$YN^PRCPUYN(1)
 I %=2 Q
 I %=1 S GROUPALL=1 Q
 S PRCPFLAG=1 Q
