FBAAVR1 ;AISC/GRR-FEE BASIS VOUCHER AUDIT DELETE AN ITEM ;10AUG86
 ;;3.5;FEE BASIS;;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
DELT ;TRAVEL LINE ITEM REJECT
 D GET Q:X="^"!(X="")  I '$D(^FBAAC("AD",B,J)) W !!,*7,"No payments in this batch for that patient!" G DELT
 S (QQ,FBAAOUT)=0 W @IOF D HEDP^FBAACCB0
 F K=0:0 S K=$O(^FBAAC("AD",B,J,K)) Q:K'>0!(FBAAOUT)  S QQ=QQ+1,QQ(QQ)=J_"^"_K S Y(0)=^FBAAC(J,3,K,0) D SETT^FBAACCB0
RLT1 S DIR(0)="Y",DIR("A")="Reject all line items for this patient",DIR("B")="YES" D ^DIR K DIR G DELT:$D(DIRUT),LOOPT:Y
RLT S DIR(0)="NO^1:"_QQ,DIR("A")="Reject which line item" D ^DIR K DIR G DELT:X=""!$D(DIRUT) S HX=X
 I '$D(QQ(HX)) W !!,*7,"You just deleted that one!!" G RLT
RASK S DIR(0)="Y",DIR("A")="Are you sure you want to reject line item number: "_HX,DIR("B")="NO" D ^DIR K DIR G RLT:$D(DIRUT)!'Y
 S J=$P(QQ(HX),"^",1),K=$P(QQ(HX),"^",2),FBRFLAG=1,XMB(2)="some"
RDR2 S DIR(0)="F^2:40",DIR("A")="Enter reason for rejecting" D ^DIR K DIR W:$D(DIRUT) !!,"Required Response!!" G:$D(DIRUT) RDR2 S FBRR=X
 D STUFFT G RDMORT
STUFFT D REJT^FBAADD S FBAAAP=$P(^FBAAC(J,3,K,0),"^",3),$P(FZ,"^",9)=($P(FZ,"^",9)-FBAAAP),$P(FZ,"^",11)=($P(FZ,"^",11)-1),$P(FZ,"^",17)="Y",FBAARA=FBAARA+FBAAAP K QQ(HX)
 S $P(^FBAA(161.7,B,0),"^",9)=$P(FZ,"^",9),$P(^(0),"^",11)=$P(FZ,"^",11),$P(^(0),"^",17)="Y"
 Q
RDMORT S DIR(0)="Y",DIR("A")="Item Rejected!  Want to reject another",DIR("B")="YES" D ^DIR K DIR Q:$D(DIRUT)  G RLT:Y
 G DELT
DELP ;PHARMACY LINE ITEM REJECT
RDI K QQ W !! S DIC="^FBAAA(",DIC(0)="AEMQ" D ^DIC Q:X="^"!(X="")  G:Y<0 RDI S DFN=+Y I '$D(^FBAA(162.1,"AJ",B,DFN)) W !!,*7,"No payments in this batch for that patient!" G RDI
 S (FBAAOUT,QQ,TM1,TM2)=0 W @IOF D HED^FBAACCB
 F W1=0:0 S W1=$O(^FBAA(162.1,"AJ",B,DFN,W1)) Q:W1'>0!(FBAAOUT)  F W2=0:0 S W2=$O(^FBAA(162.1,"AJ",B,DFN,W1,W2)) Q:W2'>0!(FBAAOUT)  S (A,FBIN)=W1,B2=W2,QQ=QQ+1,QQ(QQ)=A_"^"_B2 S Z(0)=^FBAA(162.1,A,"RX",B2,0) D SETV^FBAACCB0,MORE^FBAACCB1
RLP1 S DIR(0)="Y",DIR("A")="Reject all line items for this patient",DIR("B")="YES" D ^DIR K DIR G DELP:$D(DIRUT),LOOPP:Y
RLP S DIR(0)="NO^1:"_QQ,DIR("A")="Reject which line item" D ^DIR K DIR G DELP:X=""!$D(DIRUT) S HX=X
 I '$D(QQ(HX)) W !!,*7,"You just did that one!" G RLP
RLI S DIR(0)="Y",DIR("A")="Are you sure you want to reject line item number: "_HX,DIR("B")="NO" D ^DIR K DIR G RLP:$D(DIRUT)!'Y
 S A=$P(QQ(HX),"^",1),B2=$P(QQ(HX),"^",2),J=A,K=B2,FBRFLAG=1,XMB(2)="some"
RDR3 S DIR(0)="F^2:40",DIR("A")="Enter reason for rejecting" D ^DIR K DIR W:$D(DIRUT) !!,"Required Response!!" G:$D(DIRUT) RDR3 S FBRR=X
 D STUFFP G RDMORP
STUFFP D REJP^FBAADD S FBAAAP=$P(^FBAA(162.1,A,"RX",B2,0),"^",16),$P(FZ,"^",9)=($P(FZ,"^",9)-FBAAAP),$P(FZ,"^",11)=($P(FZ,"^",11)-1),$P(FZ,"^",17)="Y",$P(^FBAA(161.7,B,0),"^",9)=$P(FZ,"^",9),$P(^(0),"^",11)=$P(FZ,"^",11),$P(^(0),"^",17)="Y"
 S FBAARA=FBAARA+FBAAAP K QQ(HX)
 Q
RDMORP S DIR(0)="Y",DIR("A")="Item rejected, want to reject another",DIR("B")="YES" D ^DIR K DIR Q:$D(DIRUT)  G RLP:Y
 G DELP
GET K QQ W !! S DIC="^FBAAA(",DIC(0)="AEQM" D ^DIC Q:X=""!(X="^")  G:Y<0 GET S DA=+Y,J=DA Q
LOOPT S DIR(0)="F^2:40",DIR("A")="Reason for Rejecting" D ^DIR K DIR W:$D(DIRUT) !!,"Required Response!!" G:$D(DIRUT) LOOPT S FBRR=X
 F HX=0:0 S HX=$O(QQ(HX)) Q:HX'>0  S J=$P(QQ(HX),"^",1),K=$P(QQ(HX),"^",2),FBRFLAG=1,XMB(2)="some" D STUFFT
 W !,"...DONE!" G DELT
LOOPP S DIR(0)="F^2:40",DIR("A")="Reason for Rejecting" D ^DIR K DIR W:$D(DIRUT) !!,"Required Response!!" G:$D(DIRUT) LOOPP S FBRR=X
 F HX=0:0 S HX=$O(QQ(HX)) Q:HX'>0  S A=$P(QQ(HX),"^",1),B2=$P(QQ(HX),"^",2),J=A,K=B2,FBRFLAG=1,XMB(2)="some" D STUFFP
 W !,"...DONE!" G DELP
