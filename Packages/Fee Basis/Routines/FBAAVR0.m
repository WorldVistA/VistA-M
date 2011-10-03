FBAAVR0 ;AISC/GRR-REJECT ITEMS ;01JAN86
 ;;3.5;FEE BASIS;;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
STUFF S FBRFLAG=1,$P(^FBAAC(J,1,K,1,L,1,M,"FBREJ"),"^",3)=$P(^FBAAC(J,1,K,1,L,1,M,0),"^",8),FBIN=$P(^(0),"^",16),$P(^(0),"^",8)="",$P(^("FBREJ"),"^",1)="P",$P(^("FBREJ"),"^",2)=FBRR,FBAAAP=+$P(^(0),"^",3),FBAARA=FBAARA+FBAAAP
 K ^FBAAC("AC",B,J,K,L,M),^FBAAC("AJ",B,FBIN,J,K,L,M),QQ(HX) S ^FBAAC("AH",B,J,K,L,M)="",$P(FZ,"^",9)=($P(FZ,"^",9)-FBAAAP),$P(FZ,"^",11)=($P(FZ,"^",11)-1),$P(FZ,"^",17)="Y"
 S $P(^FBAA(161.7,B,0),"^",9)=$P(FZ,"^",9),$P(^(0),"^",11)=$P(FZ,"^",11),$P(^(0),"^",17)="Y"
 Q
VCHNH F J=0:0 S J=$O(^FBAAI("AC",B,J)) Q:J'>0  I '$D(^FBAAI(J,"FBREJ")),$D(^FBAAI(J,0)) S DA=J,(DIE,DIC)="^FBAAI(",DIC(0)="LQ",DR="19////^S X=DT",DLAYGO=162.5 D ^DIE
 K DIE,DIC,DA,DLAYGO Q
ERR S FBST=^FBAA(161.7,FBN,"ST")
 I FBST="O" W !,*7,"Batch is still Open!" G BT^FBAAVR
 I FBST="C" W !,*7,"Supervisor has not Released Batch yet!" G BT^FBAAVR
 I FBST="S" W !,*7,"Batch has not been Transmitted yet!" G BT^FBAAVR
DELC K QQ W !! S DIC=161,DIC("A")="Select Patient: ",DIC(0)="AEMZ",DIC("S")="I $D(^FBAAI(""AE"",B,+Y))" D ^DIC Q:X=""!($D(DTOUT))!($D(DUOUT))  G DELC:Y<0 S FBDFN=+Y K DIC
 ;I $D(^FBAAI(FBI,"FBREJ")) W !!,*7,"Payment already rejected!",! G DELC
 S (QQ,FBAAOUT)=0 W @IOF D HEDC^FBAACCB1 F I=0:0 S I=$O(^FBAAI("AE",B,FBDFN,I)) Q:I'>0!(FBAAOUT)  I $D(^FBAAI(I,0)) S Z(0)=^(0),FBI=I D WRITC
RL S DIR(0)="Y",DIR("A")="Want all line items rejected for this patient",DIR("B")="YES" D ^DIR K DIR G DELC:$D(DIRUT),LOOP:Y
RL1 S DIR(0)="NO^1:"_QQ,DIR("A")="Reject which line item" D ^DIR K DIR G DELC:X=""!$D(DIRUT) S HX=X
 I '$D(QQ(HX)) W !,*7,"You already rejected that one!!" G RL1
RJT S DIR(0)="Y",DIR("A")="Are you sure you want to reject item number: "_HX,DIR("B")="NO" D ^DIR K DIR G RL1:$D(DIRUT)!'Y
RDR1 S DIR(0)="F^2:40",DIR("A")="Enter reason for rejecting" D ^DIR K DIR W:$D(DIRUT) !!,"Required Response!!" G:$D(DIRUT) RDR1 S FBRR=X
 S I=QQ(HX) D RESET
RDMORE S DIR(0)="Y",DIR("A")="Item rejected.  Want to reject another",DIR("B")="YES" D ^DIR K DIR Q:$D(DIRUT)  G RL1:Y
 Q
WRITC S QQ=QQ+1,QQ(QQ)=I D CMORE^FBAACCB1 Q
LOOP S DIR(0)="F^2:40",DIR("A")="Reason for rejecting" D ^DIR K DIR W:$D(DIRUT) !!,"Required Response!!" G:$D(DIRUT) LOOP S FBRR=X
 F HX=0:0 S HX=$O(QQ(HX)) Q:HX'>0  S I=QQ(HX) D RESET
 W !,"...DONE!" G DELC
RESET K DR S (DIC,DIE)="^FBAAI(",DA=I,DR="20///^S X=""@"";13////^S X=""P"";14////^S X=FBRR;15////^S X=B" D ^DIE K DIC,DIE
 S FBAAAP=+$P(^FBAAI(I,0),"^",9),FBMM=$E($P(^(0),U,6),4,5),$P(FZ,"^",9)=$P(FZ,"^",9)-FBAAAP,$P(FZ,"^",10)=$P(FZ,"^",10)-1,$P(FZ,"^",11)=$P(FZ,"^",11)-1,$P(FZ,"^",17)="Y",^FBAA(161.7,B,0)=FZ,FBAARA=FBAARA+FBAAAP K QQ(HX)
 S FBAAMT=-FBAAAP,FBII78=$P(^FBAAI(I,0),"^",5) D INPOST^FBAARD3
 Q
