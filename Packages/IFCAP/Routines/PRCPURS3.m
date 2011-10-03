PRCPURS3 ;WISC/RFJ-select distribution points                       ;24 May 93
V ;;5.1;IFCAP;**1,108**;Oct 20, 2000;Build 10
 ;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
 ;
DISTRSEL(V1) ;  select distribution points
 ;  v1=inventory point da
 N %,D,DISTR,DISTRNM,PRCPEXIT,PRCPFLAG,PRCPLINE,PRCPINPT
 K ^TMP($J,"PRCPURS3"),DISTRALL
 S PRCPINPT=+V1,PRCPLINE="",$P(PRCPLINE,"-",76)="",PRCPLINE="+"_PRCPLINE_"+"
 S %=$$ALLDISTR I %=0 Q
 I %=1 S DISTRALL=1
 F  D  I $G(PRCPFLAG) Q
 .   W !
 .   I $O(^TMP($J,"PRCPURS3","YES",0))]""!($G(DISTRALL)) D
 .   .   W !?2,PRCPLINE,!?2,"| Currently selected ",$S(PRCP("DPTYPE")="S":"recipients:",1:"distribution points:"),?78,"|"
 .   .   I $G(DISTRALL) W !?2,"| << ALL ",$S(PRCP("DPTYPE")="S":"RECIPIENTS",1:"DISTRIBUTION POINTS")," >>",?78,"|"
 .   .   E  D
 .   .   .   W !?2,"| "
 .   .   .   S D=0 F  S D=$O(^TMP($J,"PRCPURS3","YES",D)) Q:D']""  S %=$E(^(D),1,20),%=%_$E("                    ",$L(%),20) W:$X>70 ?78,"|",!?2,"| " W %,"  "
 .   .   .   W ?78,"|"
 .   .   W !?2,"| You can DE-select one of the above ",$S(PRCP("DPTYPE")="S":"recipients:",1:"distribution points:")," by reselecting it.",?78,"|"
 .   I $O(^TMP($J,"PRCPURS3","NO",0))]""!('$G(DISTRALL)) D
 .   .   W !?2,PRCPLINE,!?2,"| Currently DE-selected ",$S(PRCP("DPTYPE")="S":"recipients:",1:"distribution points:"),?78,"|"
 .   .   I '$G(DISTRALL) W !?2,"| << ALL ",$S(PRCP("DPTYPE")="S":"RECIPIENTS",1:"DISTRIBUTION POINTS")," >>",?78,"|"
 .   .   E  D
 .   .   .   W !?2,"| "
 .   .   .   S D=0 F  S D=$O(^TMP($J,"PRCPURS3","NO",D)) Q:D']""  S %=$E(^(D),1,20),%=%_$E("                    ",$L(%),20) W:$X>70 ?78,"|",!?2,"| " W %,"  "
 .   .   .   W ?78,"|"
 .   .   I PRCP("DPTYPE")'="S" W !?2,"| You can RE-select one of the above distribution points by reselecting it.",?78,"|"
 .   .   I PRCP("DPTYPE")="S" W !?2,"| These recipients can be moved to the SELECTED List by reselecting them.",?78,"|"
 .   W !?2,PRCPLINE
 .   I PRCP("DPTYPE")'="S" S DISTR=$$TO^PRCPUDPT(PRCPINPT)
 .   I PRCP("DPTYPE")="S" S DISTR=$$TOWHOM^PRCPRISS(PRCPINPT)
 .   I DISTR<0 S (PRCPFLAG,PRCPEXIT)=1 Q
 .   S DISTRNM="" I PRCP("DPTYPE")="S",DISTR'=0 S DISTRNM=DISTR
 .   I PRCP("DPTYPE")'="S" S DISTRNM=$$INVNAME^PRCPUX1(DISTR)
 .   I DISTR=0,$O(^TMP($J,"PRCPURS3","YES",0))']"",'$G(DISTRALL) D  Q
 .   .   S %=$$ALLDISTR I %=0 S (PRCPFLAG,PRCPEXIT)=1 Q
 .   .   I %=1 S DISTRALL=1
 .   I DISTR=0 S PRCPFLAG=1 Q
 .   I $G(DISTRALL),'$D(^TMP($J,"PRCPURS3","NO",DISTR)) K ^TMP($J,"PRCPURS3","YES",DISTR) S ^TMP($J,"PRCPURS3","NO",DISTR)=DISTRNM W !?10,"*** DE-selected !" Q
 .   I $D(^TMP($J,"PRCPURS3","YES",DISTR)) K ^TMP($J,"PRCPURS3","YES",DISTR) S ^TMP($J,"PRCPURS3","NO",DISTR)=DISTRNM W !?10,"*** DE-selected !" Q
 .   I $D(^TMP($J,"PRCPURS3","NO",DISTR)) K ^(DISTR) S ^TMP($J,"PRCPURS3","YES",DISTR)=DISTRNM W !?10,"*** RE-selected !" Q
 .   S ^TMP($J,"PRCPURS3","YES",DISTR)=DISTRNM W !?10,"*** selected !"
 I $G(PRCPEXIT) K ^TMP($J,"PRCPURS3"),DISTRALL Q
 I $G(DISTRALL) K ^TMP($J,"PRCPURS3","YES")
 Q
 ;
 ;
ALLDISTR() ;  select all distribution points/recipients
 ;  returns 1 for yes, 2 for no, 0 for ^
 I PRCP("DPTYPE")'="S" D
 .   S XP="Do you want to select ALL distribution points"
 .   S XH="Enter 'YES' to select ALL distr. points, 'NO' to not select all distr. points."
 I PRCP("DPTYPE")="S" D
 .   S XP="Do you want ALL recipients"
 .   S XH="Enter 'YES' to select ALL recipients, 'NO' to select individual recipients."
 Q $$YN^PRCPUYN(1)
