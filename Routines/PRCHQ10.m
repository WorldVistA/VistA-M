PRCHQ10 ;(WASH IRMFO)/LKG-RFQ CLOSE ;8/6/96  20:42
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
EN ;Close RFQ and Transmit 864 Text Message notification
 K DIC S DIC="^PRC(444,",DIC(0)="AEMQ",DIC("S")="I "";2;""[("";""_$P(^(0),U,8)_"";"")"
 S DIC("A")="Select RFQ to Close: " D ^DIC K DIC
 G EX1:+Y<1!$D(DTOUT)!$D(DUOUT)
 S PRCDA=+Y,PRCRFQ=$P(Y,U,2)
 L +^PRC(444,PRCDA):5 E  W !,"This RFQ entry is in use, please try later!" G EN
 K DIR S DIR(0)="YA",DIR("A")="Do you wish to review a synopsis of this RFQ? "
 S DIR("B")="YES",DIR("?")="Answer 'YES' if you wish to view the RFQ prior to Closure."
 D ^DIR K DIR
 I Y=1 D  G:Y'=1 EX1
 . N L,DIC,DR,FLDS,BY,FR,TO,IOP S DIC=444,BY=.01,(FR,TO)=PRCRFQ,L=0,IOP="HOME"
 . S FLDS="[PRCHQ RFQ SYNOPSIS]" D EN1^DIP K DIC,FLDS,BY,FR,DR,L
 . S DIR(0)="YA",DIR("A")="Is this the correct RFQ? ",DIR("B")="NO"
 . S DIR("?")="Answer 'NO' to abort the Closure."
 . D ^DIR K DIR
 S PRCMSG="" D ESIG^PRCUESIG(DUZ,.PRCMSG) G:PRCMSG'=1 EX1
 S PRCDUZ=DUZ D CLOSE
 G EN
CLOSE ;Close RFQ to further quotes
 D NOW^%DTC S PRCDT=% K %
 G:$P($G(^PRC(444,PRCDA,1)),U,11)="" STATUS
 S PRCX=$G(^PRC(444,PRCDA,1)),PRCMSGN=$P(PRCX,U,5)+1,PRCOUTN=$P(PRCX,U,6)+1
 K DD,DO S DA(1)=PRCDA,DIC="^PRC(444,DA(1),7,",DIC(0)="L"
 S DIC("P")=$P(^DD(444,21,0),U,2),X=PRCMSGN,DINUM=PRCMSGN,DLAYGO=444.021
 D FILE^DICN K DIC,DINUM,DLAYGO
 I Y<1 W:'$D(ZTQUEUED) !,"No 864 Text Message has been entered!" L -^PRC(444,PRCDA) D EX1 Q
 S PRCDA2=+Y
 S $P(^PRC(444,PRCDA,1),U,5,6)=PRCMSGN_U_PRCOUTN
 K ^UTILITY("DIQ1",$J) S DA=PRCDUZ,DIC=200,DR=".01;.135" D EN^DIQ1
 S PRCA=^UTILITY("DIQ1",$J,200,DA,.01),PRCB=^(.135) K ^UTILITY("DIQ1",$J)
 S DA=PRCDA2,DA(1)=PRCDA,DIE="^PRC(444,DA(1),7,"
 S DR="1////O;4///^S X=PRCOUTN;5///NOW;6///NOW;7///^S X=PRCA" D ^DIE
 I PRCB]"" S DR="8///^S X=PRCB" D ^DIE
 S PRCA=$P($G(^PRC(444,PRCDA,1)),U,8) I PRCA]"" S DR="12////^S X=PRCA" D ^DIE
 S PRCX="** RFQ Closure Notification **",DR="9///^S X=PRCX" D ^DIE
 S DR="13////^S X=PRCDUZ;13.1////^S X=PRCDT" D ^DIE
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
 S ^PRC(444,PRCDA,7,PRCDA2,2,1,0)="This is to notify you that RFQ #: "_PRCRFQ_" has "
 S ^PRC(444,PRCDA,7,PRCDA2,2,2,0)="been closed to further quotes."
 S ^PRC(444,PRCDA,7,PRCDA2,2,0)="^^2^2^"_$P(PRCDT,".")
 K PRCERR
 D TRANS864^PRCHQ4A
 I $G(PRCERR),'$D(ZTQUEUED) D EN^DDIOL("Electronic Transmission Aborted!")
 K PRCDA2,PRCERR
STATUS S DIE=444,DA=PRCDA,DR="7////3;20.7////^S X=PRCDUZ;20.8////^S X=PRCDT"
 D ^DIE K DIE,DR,PRCDT
 L -^PRC(444,PRCDA)
 Q
EX1 L:$D(PRCDA) -^PRC(444,PRCDA) K PRCDA,PRCRFQ,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 K DA,PRCX,PRCMSGN,PRCOUTN,DA,DD,DO,PRCDT,PRCMSG,PRCDUZ
 Q
BKGND ;Automatic closure upon reaching Quote Due Date.  This code
 ;;can be invoked as a Scheduled Option
 K ^TMP($J,"RFQ"),^TMP($J,"PRCHQ10") D:'$D(U)!'$D(DUZ) DT^DICRW
 N PRCDA,PRCDUZ,PRCLCNT,PRCQDT
 S ^TMP($J,"RFQ",1)="The following RFQs have been closed automatically as the Quote Due Date"
 S ^TMP($J,"RFQ",2)="has been reached.",^TMP($J,"RFQ",3)=" "
 S PRCDA=0,PRCLCNT=3
 S PRCDA=0
 F  S PRCDA=$O(^PRC(444,"AH",2,PRCDA)) Q:PRCDA=""  D
 . N PRCDT,PRCX,PRCMSGN,PRCOUTN,DD,DO,DA,DIC,X,DINUM,DLAYGO,X,Y
 . N PRCDA2,PRCA,PRCB,DIE,DR,PRCERR,PRCRFQ
 . D NOW^%DTC Q:%<$P($G(^PRC(444,PRCDA,0)),U,3)
 . S PRCRFQ=$P($G(^PRC(444,PRCDA,0)),U),PRCQDT=$P($G(^(0)),U,3),PRCDUZ=$P($G(^(0)),U,4)
 . S ^TMP($J,"PRCHQ10",PRCDUZ)=""
 . S PRCQDT=+$E(PRCQDT,4,5)_"/"_(+$E(PRCQDT,6,7))_"/"_$E(PRCQDT,2,3)_$S($P(PRCQDT,".",2)]"":"@"_$E($P(PRCQDT,".",2)_"000000",1,4),1:"")
 . D CLOSE
 . S PRCLCNT=PRCLCNT+1,^TMP($J,"RFQ",PRCLCNT)="    "_PRCRFQ_"   Quote Due: "_PRCQDT_"  CO: "_$P($G(^VA(200,PRCDUZ,0)),U)
 I PRCLCNT>3 D
 . N XMY,XMZ,XMTEXT,XMSUB,XMDUZ
 . S XMTEXT="^TMP($J,""RFQ"",",XMSUB="RFQs Closed by Scheduled Option"
 . S PRCDUZ=""
 . F  S PRCDUZ=$O(^TMP($J,"PRCHQ10",PRCDUZ)) Q:PRCDUZ=""  S XMY(PRCDUZ)=""
 . S XMY("G.PRCHQ RFQ")="",XMDUZ="BACKGROUND RFQ CLOSE OPTION"
 . D ^XMD K XMZ,XMY,XMTEXT,XMSUB
 K ^TMP($J,"RFQ"),^TMP($J,"PRCHQ10")
 Q
