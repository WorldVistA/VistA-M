FBAAVR1 ;AISC/GRR,SAB - FEE BASIS VOUCHER AUDIT DELETE AN ITEM ;4/30/2012
 ;;3.5;FEE BASIS;**132**;JAN 30, 1995;Build 17
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
DELT ; specify local rejects for batch type B2 (travel)
 N FBIENS
 ; select patient
 S J=$$ASKVET^FBAAUTL1("I $D(^FBAAC(""AD"",B,+Y))")
 Q:'J
 K QQ
 S (QQ,FBAAOUT)=0 W @IOF D HEDP^FBAACCB0
 F K=0:0 S K=$O(^FBAAC("AD",B,J,K)) Q:K'>0!(FBAAOUT)  S QQ=QQ+1,QQ(QQ)=J_"^"_K S Y(0)=^FBAAC(J,3,K,0) D SETT^FBAACCB0
 ;
RLT1 S DIR(0)="Y",DIR("A")="Reject all line items for this patient",DIR("B")="YES" D ^DIR K DIR G DELT:$D(DIRUT),LOOPT:Y
RLT ; select a line to reject
 S DIR(0)="NO^1:"_QQ,DIR("A")="Reject which line item" D ^DIR K DIR G DELT:X=""!$D(DIRUT) S HX=X
 I '$D(QQ(HX)) W !!,*7,"You just deleted that one!!" G RLT
RASK S DIR(0)="Y",DIR("A")="Are you sure you want to reject line item number: "_HX,DIR("B")="NO" D ^DIR K DIR G RLT:$D(DIRUT)!'Y
 S FBIENS=$P(QQ(HX),"^",2)_","_$P(QQ(HX),"^",1)_","
RDR2 S DIR(0)="F^2:40",DIR("A")="Enter reason for rejecting" D ^DIR K DIR W:$D(DIRUT) !!,"Required Response!!" G:$D(DIRUT) RDR2 S FBRR=X
 D REJLN^FBAAVR0
RDMORT S DIR(0)="Y",DIR("A")="Item Rejected!  Want to reject another",DIR("B")="YES" D ^DIR K DIR Q:$D(DIRUT)  G RLT:Y
 G DELT
 ;
LOOPT ; reject all lines for patient in batch type B2 (travel)
 S DIR(0)="F^2:40",DIR("A")="Reason for Rejecting" D ^DIR K DIR
 G:$D(DIRUT) DELT
 S FBRR=X
 F HX=0:0 S HX=$O(QQ(HX)) Q:HX'>0  S FBIENS=$P(QQ(HX),"^",2)_","_$P(QQ(HX),"^",1)_"," D REJLN^FBAAVR0
 W !,"...DONE!"
 G DELT
 ;
DELP ; specify local rejects for batch type B5 (pharmacy)
 N FBIENS,W1,W2
 ; select patient
 S DFN=$$ASKVET^FBAAUTL1("I $D(^FBAA(162.1,""AJ"",B,+Y))")
 Q:'DFN
 K QQ
 S (FBAAOUT,QQ)=0 W @IOF D HED^FBAACCB
 F W1=0:0 S W1=$O(^FBAA(162.1,"AJ",B,DFN,W1)) Q:W1'>0!(FBAAOUT)  F W2=0:0 S W2=$O(^FBAA(162.1,"AJ",B,DFN,W1,W2)) Q:W2'>0!(FBAAOUT)  S (A,FBIN)=W1,B2=W2,QQ=QQ+1,QQ(QQ)=A_"^"_B2 S Z(0)=^FBAA(162.1,A,"RX",B2,0) D SETV^FBAACCB0,MORE^FBAACCB1
 ;
RLP1 S DIR(0)="Y",DIR("A")="Reject all line items for this patient",DIR("B")="YES" D ^DIR K DIR G DELP:$D(DIRUT),LOOPP:Y
 ;
RLP ; select a line to reject
 S DIR(0)="NO^1:"_QQ,DIR("A")="Reject which line item" D ^DIR K DIR G DELP:X=""!$D(DIRUT) S HX=X
 I '$D(QQ(HX)) W !!,*7,"You just did that one!" G RLP
RLI S DIR(0)="Y",DIR("A")="Are you sure you want to reject line item number: "_HX,DIR("B")="NO" D ^DIR K DIR G RLP:$D(DIRUT)!'Y
 S FBIENS=$P(QQ(HX),"^",2)_","_$P(QQ(HX),"^",1)_","
RDR3 S DIR(0)="F^2:40",DIR("A")="Enter reason for rejecting" D ^DIR K DIR
 G:$D(DIRUT) RLP
 S FBRR=X
 D REJLN^FBAAVR0
RDMORP S DIR(0)="Y",DIR("A")="Item rejected. Want to reject another",DIR("B")="YES" D ^DIR K DIR Q:$D(DIRUT)  G RLP:Y
 G DELP
 ;
LOOPP ; reject all lines for patient in batch type B5 (pharmacy)
 S DIR(0)="F^2:40",DIR("A")="Reason for Rejecting" D ^DIR K DIR
 G:$D(DIRUT) DELP
 S FBRR=X
 F HX=0:0 S HX=$O(QQ(HX)) Q:HX'>0  S FBIENS=$P(QQ(HX),"^",2)_","_$P(QQ(HX),"^",1)_"," D REJLN^FBAAVR0
 W !,"...DONE!"
 G DELP
