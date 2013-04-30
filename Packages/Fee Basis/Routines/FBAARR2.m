FBAARR2 ;AISC/GRR - REINITIATE REJECTED LINE ITEMS ;3/27/2012
 ;;3.5;FEE BASIS;**132**;JAN 30, 1995;Build 17
 ;;Per VHA Directive 2004-038, this routine should not be modified.
DELT ;TRAVEL LINE ITEM RE-INITIATE
 ; select patient
 S J=$$ASKVET^FBAAUTL1("I $D(^FBAAC(""AG"",B,+Y))")
 Q:'J
 K QQ
 S QQ=0 W @IOF D HEDP^FBAACCB0
 F K=0:0 S K=$O(^FBAAC("AG",B,J,K)) Q:K'>0  S QQ=QQ+1,QQ(QQ)=J_"^"_K S Y(0)=^FBAAC(J,3,K,0) D SETT^FBAACCB0
RLT S DIR(0)="N^1:"_QQ,DIR("A")="Re-initiate which line item" D ^DIR K DIR G:$D(DIRUT) ENDT S HX=X
 I '$D(QQ(HX)) W !!,*7,"You just did that one!!" G RLT
RIN S DIR(0)="Y",DIR("A")="Are you sure you want to re-initiate line item number: "_HX,DIR("B")="NO" D ^DIR K DIR G:$D(DIRUT)!'Y RLT
 S J=$P(QQ(HX),"^",1),K=$P(QQ(HX),"^",2)
 K FBERR
 D REJT^FBAARR1
 K QQ(HX)
RASK S DIR(0)="Y",DIR("A")=$S($G(FBERR):"",1:"Line Re-initiated.  ")_"Want to re-initiate another",DIR("B")="YES" D ^DIR K DIR G RASK:$D(DIRUT),ENDT:'Y,DELT:Y
ENDT ;
 Q
DELP ;PHARMACY LINE ITEM RE-INITIATE
RDI W !! S DIC="^FBAA(162.1,",DIC(0)="AEQ" D ^DIC Q:X="^"!(X="")  G:Y<0 RDI S A=+Y I '$D(^FBAA(162.1,"AF",B,A)) W !!,*7,"No payments rejected in this batch for that Invoice!" G RDI
 K QQ
 S QQ=0,FBIN=A W @IOF D SETV^FBAACCB0,HED^FBAACCB
 F B2=0:0 S B2=$O(^FBAA(162.1,"AF",B,A,B2)) Q:B2'>0  S QQ=QQ+1,QQ(QQ)=A_"^"_B2 S Z(0)=^FBAA(162.1,A,"RX",B2,0) D MORE^FBAACCB1
RLP S DIR(0)="N^1:"_QQ,DIR("A")="Re-initiate which line item" D ^DIR K DIR G:$D(DIRUT) ENDP S HX=X
 I '$D(QQ(HX)) W !!,*7,"You just did that one!!" G RLP
PRIN S DIR(0)="Y",DIR("A")="Are you sure you want to re-initiate item number: "_HX,DIR("B")="NO" D ^DIR K DIR G:$D(DIRUT)!'Y RLP
 S J=$P(QQ(HX),"^",1),K=$P(QQ(HX),"^",2)
 K FBERR
 D REJP^FBAARR1
PASK S DIR(0)="Y",DIR("A")=$S($G(FBERR):"",1:"Line Re-initiated.  ")_"Want to re-initiate another",DIR("B")="YES" D ^DIR K DIR G PASK:$D(DIRUT),DELP:Y,ENDP
ENDP ;
 Q
