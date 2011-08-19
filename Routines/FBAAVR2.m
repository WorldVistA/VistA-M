FBAAVR2 ;AISC/GRR-FINALIZE BATCH ;01JAN86
 ;;3.5;FEE BASIS;;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
GET W !! S DIC="^FBAAA(",DIC(0)="AEQM" D ^DIC Q:X="^"!(X="")  G GET:Y<0 S DA=+Y,J=DA Q
DELM K QQ D GET Q:X="^"!(X="")  I '$D(^FBAAC("AC",B,J)) W !!,*7,"No payments in this batch for that patient!" G DELM
 S (QQ,FBAAOUT)=0 W @IOF D HED^FBAACCB
 F K=0:0 S K=$O(^FBAAC("AC",B,J,K)) Q:K'>0!(FBAAOUT)  F L=0:0 S L=$O(^FBAAC("AC",B,J,K,L)) Q:L'>0!(FBAAOUT)  F M=0:0 S M=$O(^FBAAC("AC",B,J,K,L,M)) Q:M'>0!(FBAAOUT)  D WRITM
RL1 S DIR(0)="Y",DIR("A")="Want all line items rejected for this patient",DIR("B")="YES" D ^DIR K DIR G DELM:$D(DIRUT),LOOP:Y
RL S DIR(0)="N^1:"_QQ,DIR("A")="Reject which line item" D ^DIR K DIR G DELM:X=""!$D(DIRUT) S HX=X
 I '$D(QQ(HX)) W !,*7,"You already rejected that one!!" G RL
RJT S DIR(0)="Y",DIR("A")="Are you sure you want to reject item number: "_HX,DIR("B")="NO" D ^DIR K DIR G RL:$D(DIRUT)!'Y
 S J=$P(QQ(HX),"^",1),K=$P(QQ(HX),"^",2),L=$P(QQ(HX),"^",3),M=$P(QQ(HX),"^",4)
RDR1 S DIR(0)="F^2:40",DIR("A")="Enter reason for rejecting" D ^DIR K DIR W:$D(DIRUT) !!,"Required Response!!" G:$D(DIRUT) RDR1 S FBRR=X
 D ^FBAAVR0
RDMORE S DIR(0)="Y",DIR("A")="Item rejected.  Want to reject another",DIR("B")="YES" D ^DIR K DIR Q:$D(DIRUT)  G RL:Y,DELM
WRITM S QQ=QQ+1,QQ(QQ)=J_"^"_K_"^"_L_"^"_M D SET^FBAACCB Q
LOOP S DIR(0)="F^2:40",DIR("A")="Reason for rejecting" D ^DIR K DIR W:$D(DIRUT) !!,"Required Response!!" G:$D(DIRUT) LOOP S FBRR=X
 F HX=0:0 S HX=$O(QQ(HX)) Q:HX'>0  S J=$P(QQ(HX),"^",1),K=$P(QQ(HX),"^",2),L=$P(QQ(HX),"^",3),M=$P(QQ(HX),"^",4) D ^FBAAVR0
 W !,"...DONE!" G DELM
Q Q
