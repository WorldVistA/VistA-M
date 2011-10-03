FBAARD2 ;AISC/GRR-FEE BASIS VOUCHER AUDIT DELETE REJECT CODE FOR AN ITEM ;10AUG86
 ;;3.5;FEE BASIS;;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
DELT ;TRAVEL LINE ITEM REJECT
 K QQ
 D GET^FBAAVR2 Q:X="^"!(X="")  I '$D(^FBAAC("AG",B,J)) W !!,*7,"No payments rejected in this batch for that patient!" G DELT
 S (QQ,TM1,TM2)=0 W @IOF D HEDP^FBAACCB0
 F K=0:0 S K=$O(^FBAAC("AG",B,J,K)) Q:K'>0  S QQ=QQ+1,QQ(QQ)=J_"^"_K S Y(0)=^FBAAC(J,3,K,0) D SETT^FBAACCB0
RLT1 S DIR(0)="Y",DIR("A")="Delete Reject flag for all items for this patient",DIR("B")="YES" D ^DIR K DIR Q:$D(DIRUT)  G LOOPT:Y
RLT  S DIR(0)="N^1:"_QQ,DIR("A")="Delete reject for which line item" D ^DIR K DIR Q:$D(DIRUT)  S HX=X
 I '$D(QQ(HX)) W !!,*7,"You just deleted that one!!" G RLT
ASKK S DIR(0)="Y",DIR("A")="Are you sure you want to delete reject for item number "_HX,DIR("B")="NO" D ^DIR K DIR G:$D(DIRUT)!'Y RLT
 S J=$P(QQ(HX),"^",1),K=$P(QQ(HX),"^",2)
 D STUFFT G RDMORT
STUFFT D REJT^FBAARD1 S (FBAAMT,FBAAAP)=$P(^FBAAC(J,3,K,0),"^",3) D POST^FBAARD3 I $D(FBERR) G PROB^FBAARD1
 S $P(FZ,"^",9)=($P(FZ,"^",9)+FBAAAP),$P(FZ,"^",11)=($P(FZ,"^",11)+1) K QQ(HX) S FBAARA=FBAARA+FBAAAP
 S $P(^FBAA(161.7,B,0),"^",9)=$P(FZ,"^",9),$P(^(0),"^",11)=$P(FZ,"^",11)
 Q
RDMORT S DIR(0)="Y",DIR("A")=$S($G(FBERR):"",1:"Item Deleted.  ")_"Want to delete another",DIR("B")="YES" D ^DIR K DIR G RDMORT:$D(DIRUT),RLT:Y
 I '$D(^FBAAC("AG",B)) S $P(FZ,"^",17)="",$P(^FBAA(161.7,B,0),"^",17)=""
 Q
DELP ;PHARMACY LINE ITEM DELETE REJECT DESIGNATION
RDI K QQ W !! S DIC="^FBAA(162.1,",DIC(0)="AEQ" D ^DIC Q:X="^"!(X="")  G:Y<0 RDI S A=+Y I '$D(^FBAA(162.1,"AF",B,A)) W !!,*7,"No payments rejected in this batch for that Invoice!" G RDI
 S (QQ,TM1,TM2)=0,FBIN=A W @IOF D SETV^FBAACCB0,HED^FBAACCB
 F B2=0:0 S B2=$O(^FBAA(162.1,"AF",B,A,B2)) Q:B2'>0  S QQ=QQ+1,QQ(QQ)=A_"^"_B2 S Z(0)=^FBAA(162.1,A,"RX",B2,0) D MORE^FBAACCB1
RLP1 S DIR(0)="Y",DIR("A")="Delete Reject code for all items for this patient",DIR("B")="YES" D ^DIR K DIR Q:$D(DIRUT)  G LOOPP:Y
RLP S DIR(0)="N^1:"_QQ,DIR("A")="Delete reject code for which line item" D ^DIR K DIR Q:$D(DIRUT)  S HX=X
 I '$D(QQ(HX)) W !!,*7,"You just deleted that one!!" G RLP
ASKJJ S DIR(0)="Y",DIR("A")="Are you sure you want to delete reject for item number "_HX,DIR("B")="NO" D ^DIR K DIR G:$D(DIRUT)!'Y RLP
 S A=$P(QQ(HX),"^",1),B2=$P(QQ(HX),"^",2)
 D STUFFP G RDMORP
STUFFP S (FBAAAP,FBAAMT)=$P(^FBAA(162.1,A,"RX",B2,0),"^",16) D POST^FBAARD3 I $D(FBERR) G PROB^FBAARD1
 S $P(^FBAA(162.1,A,"RX",B2,0),"^",17)=B,FBPID=$P(^(0),"^",5)
 S FBAARA=FBAARA+FBAAAP,$P(FZ,"^",9)=($P(FZ,"^",9)+$P(^FBAA(162.1,A,"RX",B2,0),"^",16)),$P(FZ,"^",11)=($P(FZ,"^",11)+1),^FBAA(162.1,"AE",B,A,B2)="",^FBAA(162.1,"AJ",B,FBPID,A,B2)="" K ^FBAA(162.1,"AF",B,A,B2),^FBAA(162.1,A,"RX",B2,"FBREJ")
 S $P(^FBAA(161.7,B,0),"^",9)=$P(FZ,"^",9),$P(^(0),"^",11)=$P(FZ,"^",11)
 Q
RDMORP S DIR(0)="Y",DIR("A")=$S($G(FBERR):"",1:"Reject code deleted!  ")_"Want to delete another",DIR("B")="YES" D ^DIR K DIR G RDMORP:$D(DIRUT),RLP:Y
 I '$D(^FBAA(162.1,"AF",B)) S $P(FZ,"^",17)="",$P(^FBAA(161.7,B,0),"^",17)=""
 Q
LOOPT F HX=0:0 S HX=$O(QQ(HX)) Q:HX'>0  S J=$P(QQ(HX),"^",1),K=$P(QQ(HX),"^",2) D STUFFT
 W !,"...DONE!"
 I '$D(^FBAAC("AG",B)) S $P(FZ,"^",17)="",$P(FBAA(161.7,B,0),"^",17)=""
 G DELT
LOOPP F HX=0:0 S HX=$O(QQ(HX)) Q:HX'>0  S A=$P(QQ(HX),"^",1),B2=$P(QQ(HX),"^",2) D STUFFP
 I '$D(^FBAA(162.1,"AF",B)) S $P(FZ,"^",17)="",$P(^FBAA(161.7,B,0),"^",17)=""
 W !,"...DONE!" G DELP
