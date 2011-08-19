PRCHQ2 ;(WASH IRMFO)/LKG-RFQ Enter/Edit ;9/8/96  13:01
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
EN ;Entry point for editing Incomplete RFQ
 S PRCEDIT=$$EDITOR^PRCHQ1C
 I PRCEDIT="" D EN^DDIOL("Edit mode not indicated, aborting the edit.") K PRCEDIT Q
A S DIC="^PRC(444,",DIC(0)="AEMQ",DIC("S")="I "";1;""[("";""_$P(^(0),U,8)_"";"")"
 S DIC("A")="Enter '^' to Exit or existing RFQ #: "
 S D="F^D" D MIX^DIC1 K DIC
 I Y<1!$D(DTOUT)!$D(DUOUT) G OUT^PRCHQ2B
 S PRCDA=+Y
 L +^PRC(444,PRCDA):5 E  W !,"Someone else is editing this entry, please try later!" G OUT^PRCHQ2B
 G CONT^PRCHQ2B
EN2 ;Entry point for generating a new RFQ
 S PRCEDIT=$$EDITOR^PRCHQ1C
 I PRCEDIT="" D EN^DDIOL("Edit mode not indicated, aborting the edit.") K PRCEDIT Q
B S PRCNEW=1
 S DIC="^PRC(443,",DIC(0)="AEMNZ"
 S DIC("S")="I "";70;80;""[("";""_$P(^(0),U,7)_"";""),$P($G(^PRCS(410,Y,4)),U,5)="""""
 S DIC("A")="Enter Primary 2237 Transaction #: "
 D ^DIC K DIC I Y<1!$D(DTOUT)!$D(DUOUT) G OUT^PRCHQ2B
 S PRCDA410=+Y
 L +^PRC(443,PRCDA410):5 E  W !,"Work Sheet entry in use, please try later!" G OUT^PRCHQ2B
 L +^PRCS(410,PRCDA410):5 E  W !,"Someone is editing the source 2237, please try later!" G OUT^PRCHQ2B
 S X=$$GETNUM($P(Y(0,0),"-",1,2)) G:'X OUT^PRCHQ2B
 S DIC="^PRC(444,",DIC(0)="XL",DLAYGO=444 D ^DIC K DIC,DLAYGO
 I +Y<1 W !,"Unable to add RFQ entry - Please notify IRM staff." G OUT^PRCHQ2B
 S PRCDA=+Y W:$P(Y,U,3) !,"RFQ # ",$P(Y,U,2)," has been added."
 L +^PRC(444,PRCDA):5 E  W !,"Someone else is editing this RFQ entry, please try later!" G OUT^PRCHQ2B
 I '$P(Y,U,3) G CONT^PRCHQ2B
 W !,"Importing 2237 information into the RFQ entry..."
 K PRC410,PRC443
 F I=0,1,2,3,7,9 S PRC410(I)=$G(^PRCS(410,PRCDA410,I))
 S PRC443(0)=$G(^PRC(443,PRCDA410,0))
 S PRCE(0)=^PRC(444,PRCDA,0)
 S $P(PRCE(0),U,8)=1
 S PRCX=$P(PRC443(0),U,5) S:PRCX]"" $P(PRCE(0),U,4)=PRCX
 S PRCX=$P(PRC410(1),U,3) S:PRCX]"" $P(PRCE(0),U,6)=PRCX
 S $P(PRCE(0),U,9)=PRCDA410
 S PRCX=$P(PRC410(0),U,10) S:PRCX]"" $P(PRCE(0),U,10)=PRCX
 S PRCX=$P(PRC410(3),U,5) S:PRCX]"" $P(PRCE(0),U,11)=PRCX
 S PRCX=$P(PRC410(7),U) S:PRCX]"" $P(PRCE(0),U,12)=PRCX
 S PRCX=$P(PRC410(3),U) S:PRCX]"" $P(PRCE(0),U,14)=PRCX
 S PRCY=$P(PRC410(7),U)
 I PRCY?1.N D
 . K ^UTILITY("DIQ1",$J)
 . N DA,DIC,DIQ,DR,PRCZ
 . S DA=PRCY,DIC=200,DIQ="PRCZ",DR=".132;.135" D EN^DIQ1
 . S PRCX=$S(PRCZ(200,DA,.132)]"":PRCZ(200,DA,.132),1:PRCZ(200,DA,.135))
 . S:PRCX]"" $P(PRCE(0),U,13)=PRCX K ^UTILITY("DIQ1",$J)
 S ^PRC(444,PRCDA,0)=PRCE(0) K PRCE(0)
 S PRCE(1)=$G(^PRC(444,PRCDA,1))
 S PRCX=$P(PRC410(9),U,4),$P(PRCE(1),U)=$S(+PRCX>0:"O",1:"D")
 S PRCX=$P(PRC410(1),U,4) S:PRCX]"" $P(PRCE(1),U,2)=PRCX
 S PRCX=$P(PRC410(9),U) S:PRCX]"" $P(PRCE(1),U,4)=PRCX
 S ^PRC(444,PRCDA,1)=PRCE(1) K PRCE(1)
 K PRC443,PRC410(0),PRC410(1),PRC410(7),PRC410(9)
 S PRCI=0,PRCJ=0
 F  S PRCI=$O(^PRCS(410,PRCDA410,"RM",PRCI)) Q:PRCI=""  D
 . S:$D(^PRCS(410,PRCDA410,"RM",PRCI,0)) PRCJ=PRCJ+1,^PRC(444,PRCDA,3,PRCJ,0)=^(0)
 S:PRCJ>0 ^PRC(444,PRCDA,3,0)="^^"_PRCJ_U_PRCJ_U_DT_"^^^^"
 D IT^PRCHQ2A
 G ^PRCHQ2B
HERE ;
GETNUM(PRCX) ;Get new RFQ #
 N PRCFAIL,PRCI,X,DIC,Y,DA,DLAYGO
 S X=PRCX,DIC=444.3,DIC(0)="LX",DLAYGO=444.3 D ^DIC
 I +Y<1 W !,"Unable to get RFQ counter value - Please notify IRM staff." Q 0
 S DA=+Y,PRCFAIL=0
 F PRCI=1:1:10 L +^PRC(444.3,DA):5 Q:$T  W !,"Someone else has the RFQ counter locked!" W:PRCI<10 !,?5,"I will try again!" S:PRCI=10 PRCFAIL=1
 Q:PRCFAIL 0
UPCNTR S X=$P(^PRC(444.3,DA,0),U,2)+1,$P(^PRC(444.3,DA,0),U,2)=X
 S X=PRCX_"-RFQ-"_$E(100000+X,2,6) G:$D(^PRC(444,"B",X)) UPCNTR
 L -^PRC(444.3,DA)
 Q X
