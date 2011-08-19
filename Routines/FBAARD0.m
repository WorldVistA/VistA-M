FBAARD0 ;AISC/GRR-VOUCHER AUDIT DELETE REJECTS ENTERED IN ERROR CONT. ;01JAN86
 ;;3.5;FEE BASIS;;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
HELPD W !!,"If you answer 'Yes' to this question, all payment items in this batch",!,"will be flagged as rejected! If you answer 'No', you will be asked if you"
 W !,"want to reject specific line items!"
 Q
DELC S (QQ,FBAAOUT)=0 W @IOF D HEDC^FBAACCB1 F I=0:0 S I=$O(^FBAAI("AH",B,I)) Q:I'>0!(FBAAOUT)  I $D(^FBAAI(I,0)) S Z(0)=^(0) D WRITC
RL S ERR=0 S DIR(0)="N^1:"_QQ,DIR("A")="Delete reject flag for which line item" D ^DIR K DIR Q:$D(DIRUT)  S HX=X
 I '$D(QQ(HX)) W !,*7,"You already did that one !!" G RL
ASKSU S DIR(0)="Y",DIR("A")="Are you sure you want to delete the reject on item number "_HX,DIR("B")="NO" D ^DIR K DIR G:$D(DIRUT)!'Y RL
 S I=QQ(HX),(FBAAAP,FBAAMT)=+$P(^FBAAI(I,0),"^",9),FBII78=$P($G(^(0)),"^",5),FBMM=$E($P(^(0),U,6),4,5) S FBINVI=I D INPOST^FBAARD3 S I=FBINVI K FBINVI I $D(FBERR) G PROB^FBAARD1
 S $P(^FBAAI(I,0),"^",17)=$P(^FBAAI(I,"FBREJ"),"^",3),^FBAAI("AC",B,I)="",^FBAAI("AE",B,$P(^FBAAI(I,0),"^",4),I)="" K FBMM,^FBAAI("AH",B,I),^FBAAI(I,"FBREJ") S FBAARA=FBAARA+FBAAAP
 S $P(FZ,"^",9)=$P(FZ,"^",9)+FBAAAP,$P(FZ,"^",10)=$P(FZ,"^",10)+1,$P(FZ,"^",11)=$P(FZ,"^",11)+1 I '$D(^FBAAI("AH",B)) S $P(FZ,"^",17)="",^FBAA(161.7,B,0)=FZ W !,"...Done" Q
 S ^FBAA(161.7,B,0)=FZ W !,"...Done"
RDMORE S DIR(0)="Y",DIR("A")=$S($G(FBERR):"",1:"Item Deleted.  ")_"Want to delete another",DIR("B")="YES" D ^DIR K DIR G RDMORE:$D(DIRUT),RL:Y
 Q
WRITC S QQ=QQ+1,QQ(QQ)=I D CMORE^FBAACCB1 Q
