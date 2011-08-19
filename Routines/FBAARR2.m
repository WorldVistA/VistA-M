FBAARR2 ;AISC/GRR-RE-INITIATE REJECTED LINE ITEMS ;13AUG86
 ;;3.5;FEE BASIS;;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
DELT ;TRAVEL LINE ITEM RE-INITIATE
 K QQ
 D GET^FBAAVR2 I '$D(^FBAAC("AG",B,J)) W !!,*7,"No payments rejected in this batch for that patient!" G DELT
 S (QQ,TM1,TM2)=0 W @IOF D HEDP^FBAACCB0
 F K=0:0 S K=$O(^FBAAC("AG",B,J,K)) Q:K'>0  S QQ=QQ+1,QQ(QQ)=J_"^"_K S Y(0)=^FBAAC(J,3,K,0) D SETT^FBAACCB0
RLT S DIR(0)="N^1:"_QQ,DIR("A")="Re-initiate which line item" D ^DIR K DIR G:$D(DIRUT) ENDT S HX=X
 I '$D(QQ(HX)) W !!,*7,"You just did that one!!" G RLT
RIN S DIR(0)="Y",DIR("A")="Are you sure you want to re-initiate line item number: "_HX,DIR("B")="NO" D ^DIR K DIR G:$D(DIRUT)!'Y RLT
 S J=$P(QQ(HX),"^",1),K=$P(QQ(HX),"^",2)
 D REJT^FBAARR1 S FBAAAP=$P(^FBAAC(J,3,K,0),"^",3),$P(^FBAA(161.7,FBNB,0),"^",9)=($P(^FBAA(161.7,FBNB,0),"^",9)+FBAAAP),$P(^(0),"^",11)=($P(^(0),"^",11)+1) K QQ(HX)
RASK S DIR(0)="Y",DIR("A")=$S($G(FBERR):"",1:"Line Re-initiated.  ")_"Want to re-initiate another",DIR("B")="YES" D ^DIR K DIR G RASK:$D(DIRUT),ENDT:'Y,DELT:Y
ENDT I '$D(^FBAAC("AG",B)) S $P(^FBAA(161.7,B,0),"^",17)=""
 Q
DELP ;PHARMACY LINE ITEM RE-INITIATE
RDI K QQ W !! S DIC="^FBAA(162.1,",DIC(0)="AEQ" D ^DIC Q:X="^"!(X="")  G:Y<0 RDI S A=+Y I '$D(^FBAA(162.1,"AF",B,A)) W !!,*7,"No payments rejected in this batch for that Invoice!" G RDI
 S (QQ,TM1,TM2)=0,FBIN=A W @IOF D SETV^FBAACCB0,HED^FBAACCB
 F B2=0:0 S B2=$O(^FBAA(162.1,"AF",B,A,B2)) Q:B2'>0  S QQ=QQ+1,QQ(QQ)=A_"^"_B2 S Z(0)=^FBAA(162.1,A,"RX",B2,0) D MORE^FBAACCB1
RLP S DIR(0)="N^1:"_QQ,DIR("A")="Re-initiate which line item" D ^DIR K DIR G:$D(DIRUT) ENDP S HX=X
 I '$D(QQ(HX)) W !!,*7,"You just did that one!!" G RLP
PRIN S DIR(0)="Y",DIR("A")="Are you sure you want to re-initiate item number: "_HX,DIR("B")="NO" D ^DIR K DIR G:$D(DIRUT)!'Y RLP
 S A=$P(QQ(HX),"^",1),B2=$P(QQ(HX),"^",2)
 I $P($G(^FBAA(162.1,A,"RX",B2,2)),"^",3)="V" S FBIN=A D VOID^FBAARR1 Q
 S FBPID=$P(^FBAA(162.1,A,"RX",B2,0),"^",5),$P(^(0),"^",17)=FBNB,FBAAAP=$P(^(0),"^",16),^FBAA(162.1,"AE",FBNB,A,B2)="",^FBAA(162.1,"AJ",FBNB,FBPID,A,B2)="" K ^FBAA(162.1,"AF",B,A,B2),^FBAA(162.1,A,"RX",B2,"FBREJ")
 S $P(^FBAA(161.7,FBNB,0),"^",9)=($P(^FBAA(161.7,FBNB,0),"^",9)+FBAAAP),$P(^(0),"^",11)=($P(^(0),"^",11)+1)
PASK S DIR(0)="Y",DIR("A")=$S($G(FBERR):"",1:"Reject code deleted.  ")_"Want to delete another",DIR("B")="YES" D ^DIR K DIR G PASK:$D(DIRUT),DELP:Y,ENDP
ENDP I '$D(^FBAA(162.1,"AF",B)) S $P(^FBAA(161.7,B,0),"^",17)=""
 Q
