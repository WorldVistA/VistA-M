PRCPURS1 ;WISC/RFJ/VAC-select group category list                       ; 11/2/06 11:32am
 ;;5.1;IFCAP;**98**;Oct 20, 2000;Build 37
 ;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
 ;
GROUPSEL(V1) ;  select group categories
 ;  v1=inventory point da
 N %,G,GROUP,GROUPNM,PRCPEXIT,PRCPFLAG,PRCPLINE,PRCPINPT
 K ^TMP($J,"PRCPURS1"),GROUPALL
 S PRCPINPT=+V1,PRCPLINE="",$P(PRCPLINE,"-",78)=""
 S %=$$ALLGRP I %=0 Q
 I %=1 S GROUPALL=1
 F  D  I $G(PRCPFLAG) Q
 .   W !!
 .   I $O(^TMP($J,"PRCPURS1","YES",0))!($G(GROUPALL)) D
 .   .   W !?2,PRCPLINE,!?2,"| Currently selected group categories:",?78,"|"
 .   .   I $G(GROUPALL) W !?2,"| << ALL GROUP CATEGORIES >>",?78,"|"
 .   .   E  D
 .   .   .   W !?2,"| "
 .   .   .   S G=0 F  S G=$O(^TMP($J,"PRCPURS1","YES",G)) Q:'G  S %=$E(^(G),1,20),%=%_$E("                    ",$L(%),20) W:$X>70 ?78,"|",!?2,"| " W %,"  "
 .   .   .   W ?78,"|"
 .   .   W !?2,"| You can DE-select one of the above group categories by reselecting it.",?78,"|"
 .   I $O(^TMP($J,"PRCPURS1","NO",0))!('$G(GROUPALL)) D
 .   .   W !?2,PRCPLINE,!?2,"| Currently DE-selected group categories:",?78,"|"
 .   .   I '$G(GROUPALL) W !?2,"| << ALL GROUP CATEGORIES >>",?78,"|"
 .   .   E  D
 .   .   .   W !?2,"| "
 .   .   .   S G=0 F  S G=$O(^TMP($J,"PRCPURS1","NO",G)) Q:'G  S %=$E(^(G),1,20),%=%_$E("                    ",$L(%),20) W:$X>70 ?78,"|",!?2,"| " W %,"  "
 .   .   .   W ?78,"|"
 .   .   W !?2,"| You can RE-select one of the above group categories by reselecting it.",?78,"|"
 .   W !?2,PRCPLINE
 .   S GROUP=$$GROUP^PRCPEGRP(PRCPINPT,"") I GROUP<0 S (PRCPFLAG,PRCPEXIT)=1 Q
 .   S GROUPNM=$$GROUPNM^PRCPEGRP(GROUP)
 .   I GROUP=0,'$O(^TMP($J,"PRCPURS1","YES",0)),'$G(GROUPALL) D  Q
 .   .   S %=$$ALLGRP I %=0 S (PRCPFLAG,PRCPEXIT)=1 Q
 .   .   I %=1 S GROUPALL=1
 .   I GROUP=0 S PRCPFLAG=1 Q
 .   I $G(GROUPALL),'$D(^TMP($J,"PRCPURS1","NO",GROUP)) K ^TMP($J,"PRCPURS1","YES",GROUP) S ^TMP($J,"PRCPURS1","NO",GROUP)=GROUPNM W !?10,"*** DE-selected !" Q
 .   I $D(^TMP($J,"PRCPURS1","YES",GROUP)) K ^TMP($J,"PRCPURS1","YES",GROUP) S ^TMP($J,"PRCPURS1","NO",GROUP)=GROUPNM W !?10,"*** DE-selected !" Q
 .   I $D(^TMP($J,"PRCPURS1","NO",GROUP)) K ^(GROUP) S ^TMP($J,"PRCPURS1","YES",GROUP)=GROUPNM W !?10,"*** RE-selected !" Q
 .   S ^TMP($J,"PRCPURS1","YES",GROUP)=GROUPNM W !?10,"*** selected !"
 I $G(PRCPEXIT) K ^TMP($J,"PRCPURS1"),GROUPALL Q
 I $G(GROUPALL) K ^TMP($J,"PRCPURS1","YES")
 Q
 ;
 ;
ALLGRP() ;  select all group categories
 ;  returns 1 for yes, 2 for no, 0 for ^
 S XP="Do you want to select ALL group categories",XH="Enter 'YES' to select ALL groups, 'NO' to not select all groups."
 W !
 Q $$YN^PRCPUYN(1)
ZEROQTY(Y) ;**98** Select zero quantity items to print or not or only
 ;DIRUT - "^" entered, exit from this option and return to menu
 ;Y - User selection, passed to calling routine for further process:
 ; If Y=1, Include Zero Quantity Items
 ; If Y=2, Do not include Zero Quantity Items
 ; If Y=3, Include ONLY Zero Quantity Items
 N X
 W !
 S X(1)="Select a number to display zero quantities or not "
 D DISPLAY^PRCPUX2(3,42,.X)
 K DIR
 S DIR(0)="S^1: Include Zero Quantity items;2: Do not include Zero Quantity items;3: Print  Only Zero Quantity items"
 S DIR("A")="Select"
 D ^DIR
 K DIR
 Q:$D(DIRUT) 0
 Q Y
 ;
