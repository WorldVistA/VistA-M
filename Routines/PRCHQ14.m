PRCHQ14 ;(WASH IRMFO)/LKG-RFQ   ReOpen RFQ ;8/6/96  20:47
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
ENT ;Entry point for Reopen RFQ
 K DIC S DIC=444,DIC(0)="AEMQ",DIC("S")="I $P(^(0),U,8)=3"
 S DIC("A")="Select RFQ to ReOpen: " D ^DIC K DIC
 G EX:+Y<1!$D(DTOUT)!$D(DUOUT)
 S PRCDA=+Y,PRCRFQ=$P(Y,U,2)
 L +^PRC(444,PRCDA):5 E  W !,"This RFQ is in use, please try later!" G ENT
 K DIR S DIR(0)="YA",DIR("A")="Do you wish to review a synopsis of this RFQ? "
 S DIR("B")="YES",DIR("?")="Answer 'YES' if you wish to view the RFQ prior to ReOpening."
 D ^DIR K DIR I $D(DIRUT)!$D(DIROUT) L -^PRC(444,PRCDA) G EX
 I Y=1 D  G:Y'=1 UNLOCK
 . N L,DIC,DR,FLDS,BY,FR,TO,IOP S DIC=444,BY=.01,(FR,TO)=PRCRFQ,L=0,IOP="HOME"
 . S FLDS="[PRCHQ RFQ SYNOPSIS]" D EN1^DIP K DIC,FLDS,BY,FR,DR,L
 . S DIR(0)="YA",DIR("A")="Is this the correct RFQ? ",DIR("B")="YES"
 . S DIR("?")="Answer 'NO' to abort the ReOpening."
 . D ^DIR K DIR
 S PRCMSG="" D ESIG^PRCUESIG(DUZ,.PRCMSG) I PRCMSG'=1 L -^PRC(444,PRCDA) G EX
 S PRCOLD=$P(^PRC(444,PRCDA,0),U,3) D NOW^%DTC S PRCDT=%
 S (PRCORDT,PRCRDT)=$P($G(^PRC(444,PRCDA,1)),U,2)\1,PRCRDTE=+$E(PRCRDT,4,5)_"/"_(+$E(PRCRDT,6,7))_"/"_$E(PRCRDT,2,3)
 S DA=PRCDA,DIE=444
 S DR="13;S PRCRDT=X,PRCRDTE=+$E(PRCRDT,4,5)_""/""_(+$E(PRCRDT,6,7))_""/""_$E(PRCRDT,2,3)"
 S DR(1,444,1)="2;S PRCDD=X;I PRCDT>PRCDD W !,""Quote Due Date must be in the Future"" S Y=2;I PRCDD'<PRCRDT W !,""Quote Due Date must be earlier than Required Delivery Date ""_PRCRDTE S Y=2"
 D ^DIE K DIE,DR,DA
 I $D(Y)!$D(DTOUT) D  G UNLOCK
 . S DA=PRCDA,DIE=444,DR="13////^S X=PRCORDT;2////^S X=PRCOLD" D ^DIE K DA,DIE,DR
 . W !,"The Status and Quote Due Date for RFQ #"_PRCRFQ_" are unchanged!"
 S DR="7////2;20.7////^S X=DUZ;20.8////^S X=PRCDT"
 S DA=PRCDA,DIE=444 D ^DIE K DA,DIE,DR
 K PRCAR S PRCAR(1)="The Status of RFQ #"_PRCRFQ_" has been changed from CLOSED"
 S PRCAR(2)="  to PENDING QUOTES"
 D EN^DDIOL(.PRCAR) K PRCAR
 G:$P($G(^PRC(444,PRCDA,1)),U,11)="" UNLOCK
 K DIR S DIR(0)="YA",DIR("A")="Do you wish to send an electronic notification to the vendors? "
 S DIR("B")="YES",DIR("?")="Answer 'YES' if you wish to send a text message."
 D ^DIR K DIR G:Y'=1 UNLOCK
 S PRCX=$G(^PRC(444,PRCDA,1)),PRCMSGN=$P(PRCX,U,5)+1,PRCOUTN=$P(PRCX,U,6)+1
 K DD,DO S DA(1)=PRCDA,DIC="^PRC(444,DA(1),7,",DIC(0)="L"
 S DIC("P")=$P(^DD(444,21,0),U,2),X=PRCMSGN,DINUM=PRCMSGN,DLAYGO=444.021
 D FILE^DICN K DIC,DINUM,DLAYGO
 I Y<1 W !,"No Reopening Message has been entered!" L -^PRC(444,PRCDA) G UNLOCK
 S PRCDA2=+Y
 S $P(^PRC(444,PRCDA,1),U,5,6)=PRCMSGN_U_PRCOUTN
 K ^UTILITY("DIQ1",$J) S DA=DUZ,DIC=200,DR=".01;.135" D EN^DIQ1
 S PRCA=^UTILITY("DIQ1",$J,200,DA,.01),PRCB=^(.135) K ^UTILITY("DIQ1",$J)
 S DA=PRCDA2,DA(1)=PRCDA,DIE="^PRC(444,DA(1),7,"
 S DR="1////O;4///^S X=PRCOUTN;5///NOW;6///NOW;7///^S X=PRCA" D ^DIE
 I PRCB]"" S DR="8///^S X=PRCB" D ^DIE
 S PRCA=$P($G(^PRC(444,PRCDA,1)),U,8) I PRCA]"" S DR="12////^S X=PRCA" D ^DIE
 S PRCX="** RFQ Reopening Message **",DR="9///^S X=PRCX" D ^DIE
 S DR="13////^S X=DUZ;13.1////^S X=PRCDT" D ^DIE
 K DIE,DR,DA,PRCA,PRCB,PRCX,PRCMSGN,PRCOUTN
 I $P($G(^PRC(444,PRCDA,5,0)),U,4)>0 D
 . N PRCX,PRCY,PRCDA3
 . S PRCX=0,PRCDA3=0
 . F  S PRCX=$O(^PRC(444,PRCDA,5,PRCX)) Q:PRCX'?1.N  D
 . . S PRCY=$G(^PRC(444,PRCDA,5,PRCX,0)) Q:PRCY=""
 . . Q:$P(PRCY,U,2)'="e"&($P(PRCY,U,2)'="b")  S PRCY=$P(PRCY,U) Q:PRCY=""
 . . S PRCDA3=PRCDA3+1,^PRC(444,PRCDA,7,PRCDA2,3,PRCDA3,0)=PRCY
 . . S ^PRC(444,PRCDA,7,PRCDA2,3,"B",PRCY,PRCDA3)=""
 . S:PRCDA3>0 ^PRC(444,PRCDA,7,PRCDA2,3,0)=U_$P(^DD(444.021,11,0),U,2)_U_PRCDA3_U_PRCDA3
 S PRCDD=$P($G(^PRC(444,PRCDA,0)),U,3) S Y=PRCDD D DD^%DT S Y=$P(Y,":",1,2)
 S ^PRC(444,PRCDA,7,PRCDA2,2,1,0)="This is to notify you that RFQ #: "_PRCRFQ_" has been"
 S ^PRC(444,PRCDA,7,PRCDA2,2,2,0)="reopened with a new Quote Due Date of "_Y_". "
 S ^PRC(444,PRCDA,7,PRCDA2,2,0)="^^2^2^"_$P(PRCDT,".")
 K DA S DA=PRCDA2,DA(1)=PRCDA,DIE="^PRC(444,DA(1),7,",DR="10Reopening Message"
 D ^DIE K DA,DIE,DR
 K PRCERR
 D TRANS864^PRCHQ4A
 D:$G(PRCERR) EN^DDIOL("Electronic Transmission Aborted!")
 K PRCDA2,PRCERR
UNLOCK L -^PRC(444,PRCDA) K DA,PRCX,PRCMSGN,PRCOUTN,PRCDA,PRCDA2,PRCDD
 G:'$D(DTOUT) ENT
EX K PRCDA,PRCRFQ,PRCDT,PRCDD,PRCOLD,PRCORDT,PRCMSG,PRCRDT,PRCRDTE,DTOUT,DUOUT,DIROUT,DIRUT,DA,DIE,DR,%,X,Y
 Q
