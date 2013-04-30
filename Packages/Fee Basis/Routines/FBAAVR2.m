FBAAVR2 ;AISC/GRR,SAB - FINALIZE BATCH (CONT) ;3/26/2012
 ;;3.5;FEE BASIS;**132**;JAN 30, 1995;Build 17
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
DELM ; specify local rejects for batch type B3
 ; select patient
 S J=$$ASKVET^FBAAUTL1("I $D(^FBAAC(""AC"",B,+Y))")
 Q:'J
 K QQ
 S (QQ,FBAAOUT)=0 W @IOF D HED^FBAACCB
 F K=0:0 S K=$O(^FBAAC("AC",B,J,K)) Q:K'>0!(FBAAOUT)  F L=0:0 S L=$O(^FBAAC("AC",B,J,K,L)) Q:L'>0!(FBAAOUT)  F M=0:0 S M=$O(^FBAAC("AC",B,J,K,L,M)) Q:M'>0!(FBAAOUT)  D WRITM
RL1 S DIR(0)="Y",DIR("A")="Want all line items rejected for this patient",DIR("B")="YES" D ^DIR K DIR G DELM:$D(DIRUT),LOOP:Y
RL S DIR(0)="N^1:"_QQ,DIR("A")="Reject which line item" D ^DIR K DIR G DELM:X=""!$D(DIRUT) S HX=X
 I '$D(QQ(HX)) W !,*7,"You already rejected that one!!" G RL
RJT S DIR(0)="Y",DIR("A")="Are you sure you want to reject item number: "_HX,DIR("B")="NO" D ^DIR K DIR G RL:$D(DIRUT)!'Y
 S FBIENS=$P(QQ(HX),"^",4)_","_$P(QQ(HX),"^",3)_","_$P(QQ(HX),"^",2)_","_$P(QQ(HX),"^",1)_","
RDR1 S DIR(0)="F^2:40",DIR("A")="Enter reason for rejecting" D ^DIR K DIR W:$D(DIRUT) !!,"Required Response!!" G:$D(DIRUT) RDR1 S FBRR=X
 D REJLN^FBAAVR0
RDMORE S DIR(0)="Y",DIR("A")="Item rejected. Want to reject another",DIR("B")="YES"
 D ^DIR K DIR Q:$D(DIRUT)  G RL:Y,DELM
 ;
WRITM S QQ=QQ+1,QQ(QQ)=J_"^"_K_"^"_L_"^"_M D SET^FBAACCB Q
 ;
LOOP ; reject all lines for patient
 S DIR(0)="F^2:40",DIR("A")="Reason for rejecting" D ^DIR K DIR
 G:$D(DIRUT) DELM
 S FBRR=X
 F HX=0:0 S HX=$O(QQ(HX)) Q:HX'>0  S FBIENS=$P(QQ(HX),"^",4)_","_$P(QQ(HX),"^",3)_","_$P(QQ(HX),"^",2)_","_$P(QQ(HX),"^",1)_"," D REJLN^FBAAVR0
 W !,"...DONE!"
 G DELM
 ;
SPLIT ; reject all lines on split invoices
 S DIR(0)="F^2:40",DIR("A")="Reason for rejecting" D ^DIR K DIR
 Q:$D(DIRUT)
 S FBRR=X
 S FBIENS=""  F  S FBIENS=$O(FBLNLST(FBIENS)) Q:FBIENS=""  D REJLN^FBAAVR0
 W !,"...DONE!"
 Q
