PRCPAGPV ;WISC/RFJ-autogen primary or whse order (select vendor)    ;11 Dec 92
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
GETVEND ;  select vendors
 ;  returns tmp global of vendors selected or de-selected;
 ;  vendall if all vendors selected (can be used in combination
 ;  with the tmp global);  $g(prcpexit) to exit autogen.
 N %,PRCPFLAG,V,VENDOR,VENDORNM,X,Y
 K PRCPEXIT,VENDALL
 D ALLVEND I $G(PRCPFLAG) S PRCPEXIT=1 Q
 F  D  I $G(PRCPFLAG) Q
 .   I $O(^TMP($J,"PRCPAG","VY",0))!($G(VENDALL)) D
 .   .   W !!,"  Currently selected vendors:",!,"  "
 .   .   I $G(VENDALL) W "<< ALL VENDORS >>"
 .   .   E  S V=0 F  S V=$O(^TMP($J,"PRCPAG","VY",V)) Q:'V  S %=$E(^(V),1,20),%=%_$E("                    ",$L(%),20) W:$X>70 !,"  " W %,"  "
 .   .   W !,"  You can DE-select one of the above vendors by reselecting it."
 .   I $O(^TMP($J,"PRCPAG","VN",0)) D
 .   .   W !!,"  Currently DE-selected vendors:",!,"  "
 .   .   S V=0 F  S V=$O(^TMP($J,"PRCPAG","VN",V)) Q:'V  S %=$E(^(V),1,20),%=%_$E("                    ",$L(%),20) W:$X>70 !,"  " W %,"  "
 .   .   W !,"  You can RE-select one of the above vendors by reselecting it."
 .   W !!,"Select the name of the vendor supplying this primary, '^' to exit."
 .   S VENDOR=$$VENDOR I VENDOR<0 S (PRCPFLAG,PRCPEXIT)=1 Q
 .   S VENDORNM=$P($G(^PRC(440,VENDOR,0)),"^")
 .   I VENDOR=0,'$O(^TMP($J,"PRCPAG","VY",0)),'$G(VENDALL) D ALLVEND S:$G(PRCPFLAG) PRCPEXIT=1 Q
 .   I VENDOR=0 S PRCPFLAG=1 Q
 .   I $G(VENDALL),'$D(^TMP($J,"PRCPAG","VN",VENDOR)) K ^TMP($J,"PRCPAG","VY",VENDOR) S ^TMP($J,"PRCPAG","VN",VENDOR)=VENDORNM W !?10,"DE-selected !" Q
 .   I $D(^TMP($J,"PRCPAG","VY",VENDOR)) K ^TMP($J,"PRCPAG","VY",VENDOR) S ^TMP($J,"PRCPAG","VN",VENDOR)=VENDORNM W !?10,"DE-selected !" Q
 .   I $D(^TMP($J,"PRCPAG","VN",VENDOR)) K ^(VENDOR) S ^TMP($J,"PRCPAG","VY",VENDOR)=VENDORNM W !?10,"RE-selected !" Q
 .   S ^TMP($J,"PRCPAG","VY",VENDOR)=VENDORNM W !?10,"selected !"
 I $G(PRCPEXIT) Q
 I $G(VENDALL) K ^TMP($J,"PRCPAG","VY")
 I '$G(VENDALL),'$O(^TMP($J,"PRCPAG","VY",0)) W !!,"NO VENDORS SELECTED." S PRCPEXIT=1 Q
 Q
 ;
 ;
VENDOR() ;  select vendor
 N DIC,X,Y
 S DIC="^PRC(440,",DIC("S")="I '$P($G(^(10)),U,5)",DIC(0)="QEAM",PRCPPRIV=1 D ^DIC K PRCPPRIV,DIC
 Q $S($G(X)["^":-1,Y<0:0,1:+Y)
 ;
 ;
ALLVEND ;  select all vendors
 K VENDALL,PRCPFLAG
 S XP="Do you want to select ALL vendors",XH="Enter 'YES' to auto-generate for ALL vendors,",XH(1)="enter 'NO' to auto-generate selectable vendors, or '^' to exit."
 W ! S %=$$YN^PRCPUYN(1)
 I %=2 Q
 I %=1 S VENDALL=1 Q
 S PRCPFLAG=1 Q
