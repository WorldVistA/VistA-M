PRCHQ9 ;(WASH IRMFO)/LKG-RFQ CANCEL ; [8/31/98 11:24am]
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
EN ;Cancel RFQ and Transmit Cancel 840
 K DIC S DIC="^PRC(444,",DIC(0)="AEMQ",DIC("S")="I "";1;2;3;4;""[("";""_$P(^(0),U,8)_"";"")"
 S DIC("A")="Select RFQ to Cancel: " D ^DIC K DIC
 G EX1:+Y<1!$D(DTOUT)!$D(DUOUT)
 S PRCDA=+Y,PRCRFQ=$P(Y,U,2)
 L +^PRC(444,PRCDA):5 E  W !,"This RFQ entry is in use, please try later!" G EN
 K DIR S DIR(0)="YA",DIR("A")="Do you wish to review a synopsis of this RFQ? "
 S DIR("B")="YES",DIR("?")="Answer 'YES' if you wish to view the RFQ prior to Cancellation."
 D ^DIR K DIR
 I Y=1 D  G:Y'=1 EX1
 . N L,DIC,DR,FLDS,BY,FR,TO,IOP S DIC=444,BY=.01,(FR,TO)=PRCRFQ,L=0,IOP="HOME"
 . S FLDS="[PRCHQ RFQ SYNOPSIS]" D EN1^DIP K DIC,FLDS,BY,FR,DR,L
 . S DIR(0)="YA",DIR("A")="Is this the correct RFQ? ",DIR("B")="NO"
 . S DIR("?")="Answer 'NO' to abort the Cancellation."
 . D ^DIR K DIR
 S PRCMSG="" D ESIG^PRCUESIG(DUZ,.PRCMSG) G:PRCMSG'=1 EX1
 D NOW^%DTC S PRCDT=% K %
 S PRCSTOLD=$P(^PRC(444,PRCDA,0),U,8)
 G:$P($G(^PRC(444,PRCDA,1)),U,11)="" STATUS
 S PRCX=$G(^PRC(444,PRCDA,1)),PRCMSGN=$P(PRCX,U,5)+1,PRCOUTN=$P(PRCX,U,6)+1
 K DD,DO S DA(1)=PRCDA,DIC="^PRC(444,DA(1),7,",DIC(0)="L"
 S DIC("P")=$P(^DD(444,21,0),U,2),X=PRCMSGN,DINUM=PRCMSGN,DLAYGO=444.021
 D FILE^DICN K DIC,DINUM,DLAYGO
 I Y<1 W !,"No Cancellation Message has been entered!" L -^PRC(444,PRCDA) G EX1
 S PRCDA2=+Y
 S $P(^PRC(444,PRCDA,1),U,5,6)=PRCMSGN_U_PRCOUTN
 K ^UTILITY("DIQ1",$J) S DA=DUZ,DIC=200,DR=".01;.135" D EN^DIQ1
 S PRCA=^UTILITY("DIQ1",$J,200,DA,.01),PRCB=^(.135) K ^UTILITY("DIQ1",$J)
 S DA=PRCDA2,DA(1)=PRCDA,DIE="^PRC(444,DA(1),7,"
 S DR="1////O;4///^S X=PRCOUTN;5///NOW;6///NOW;7///^S X=PRCA" D ^DIE
 I PRCB]"" S DR="8///^S X=PRCB" D ^DIE
 S PRCA=$P($G(^PRC(444,PRCDA,1)),U,8) I PRCA]"" S DR="12////^S X=PRCA" D ^DIE
 S PRCX="** RFQ Cancellation Message **",DR="9///^S X=PRCX" D ^DIE
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
 S ^PRC(444,PRCDA,7,PRCDA2,2,1,0)="This is to notify you that RFQ #: "_PRCRFQ_" has "
 S ^PRC(444,PRCDA,7,PRCDA2,2,2,0)="been cancelled."
 S ^PRC(444,PRCDA,7,PRCDA2,2,0)="^^2^2^"_$P(PRCDT,".")
 K DA S DA=PRCDA2,DA(1)=PRCDA,DIE="^PRC(444,DA(1),7,",DR="10Reason for Cancellation"
 D ^DIE K DA,DIE,DR
 K ^TMP($J,"STRING"),^TMP($J,"VE")
 D HE^PRCHQ4 S PRCCOUNT=1
 I $G(PRCERR) D EN^DDIOL("Electronic Transmission & Status Change Aborted!") K PRCERR,PRCCOUNT,^TMP($J,"STRING") D EX1 G EN
 S $P(^TMP($J,"STRING",1),U,18)=$$VELST^PRCHQ4(.PRCCOUNT)
 I $P(^TMP($J,"STRING",1),U,18)=0 D EN^DDIOL("No Vendors for Electronic Transmission - Transmission & Status Change Aborted!") K PRCCOUNT,^TMP($J,"STRING"),^TMP($J,"VE") D EX1 G EN
 D ST^PRCHQ4(.PRCCOUNT)
 D MI^PRCHQ4("01",.PRCCOUNT)
 D AC^PRCHQ4(.PRCCOUNT)
 S $P(^TMP($J,"STRING",1),U,14)=$$TX^PRCHQ4("^PRC(444,PRCDA,7,PRCDA2,2)",.PRCCOUNT)
 D IT^PRCHQ4(.PRCCOUNT)
 S PRCSORC=$O(^PRC(411,"B",$P(PRCRFQ,"-"),""))
 I PRCSORC="" S PRCERR=4 D EN^DDIOL("Sending Station not in File 411")
 I $G(PRCERR) D EN^DDIOL("Electronic Transmission & Status Change Aborted!") K PRCERR,PRCCOUNT,^TMP($J,"STRING"),^TMP($J,"VE") D EX1 G EN
 S PRCDEST=$S($P($G(^PRC(411,PRCSORC,9)),U,4)="T":"EDT",1:"EDP")
 D TRANSMIT^PRCPSMCS($P(PRCRFQ,"-"),"RFQ",PRCRFQ,PRCDEST,200,1)
 K ^TMP($J,"STRING") S XMZ=$O(PRCPXMZ(0))
 I XMZ>0 D
 . N PRCV
 . S $P(^PRC(444,PRCDA,1),U,11)=PRCPXMZ(XMZ)
 . S $P(^PRC(444,PRCDA,7,PRCDA2,1),U,3)=PRCPXMZ(XMZ)
 . S X="MailMan Msg #: "_PRCPXMZ(XMZ)
 . D EN^DDIOL(X)
 . S PRCV=""
 . F  S PRCV=$O(^TMP($J,"VE",PRCV)) Q:PRCV=""  D ENTER^PRCOEDI(PRCRFQ,"RFQ",PRCPXMZ(XMZ),PRCV,$P($G(^PRC(444,PRCDA,0)),U,4),PRCDA,"01")
 K ^TMP($J,"VE")
 K PRCCOUNT,PRCPXMZ,XMZ,X
STATUS S DIE=444,DA=PRCDA,DR="7////0;20.7////^S X=DUZ;20.8////^S X=PRCDT"
 D ^DIE K DIE,DR,PRCDT
 I $P($G(^PRC(444,PRCDA,1)),U,11)]""!($P($G(^PRC(444,PRCDA,9)),U)]"") D COPY(PRCDA) G:PRCCOPY EX1
 K PRC S PRCDA2=0,DIE="^PRC(443,"
 F  S PRCDA2=$O(^PRC(444,PRCDA,2,PRCDA2)) Q:PRCDA2'?1.N  D
 . N PRCOSTAT,PRC2237,PRCAR
 . S DA=$P($G(^PRC(444,PRCDA,2,PRCDA2,3)),U) Q:DA=""
 . I '$D(PRC(DA)) D
 . . S PRCOSTAT=$P(^PRC(443,DA,0),U,7)
 . . S:PRCOSTAT?1.N PRCOSTAT=$P(^PRCD(442.3,PRCOSTAT,0),U)
 . . L +^PRC(443,DA):300 S DR="1.5////70" D ^DIE S PRC(DA)="" L -^PRC(433,DA)
 . . S PRC2237=$P(^PRCS(410,DA,0),U)
 . . S PRCAR(1)="Status of 2237 #"_PRC2237_" has been changed from"
 . . S PRCAR(2)="  "_PRCOSTAT_" to "_$P(^PRCD(442.3,70,0),U)
 . . D EN^DDIOL(.PRCAR)
 K DIE,DR,PRC,PRCDA2
 I PRCSTOLD=1,$P($G(^PRC(444,PRCDA,1)),U,11)="" D
 . K DIR S DIR(0)="YA",DIR("A",1)="As it appears that this RFQ was never transmitted electronically,"
 . S DIR("A")="do you wish to delete this RFQ? ",DIR("B")="YES"
 . S DIR("?")="Enter 'YES' to delete, 'NO' to retain in the database."
 . D ^DIR K DIR
 . Q:Y'=1
 . S DIK="^PRC(444,",DA=PRCDA D ^DIK K DIK,DA
 . S X="RFQ #"_PRCRFQ_" has been deleted!" D EN^DDIOL(X)
 L -^PRC(444,PRCDA)
 G EN:'$D(DIRUT)&'$D(DIROUT)&'$D(DTOUT)
EX1 L:$D(PRCDA) -^PRC(444,PRCDA) K PRCDA,PRCRFQ,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 K DA,DIC,PRCX,PRCMSGN,PRCOUTN,DA,DD,DO,PRCDT,PRCMSG,PRCDA2,PRCERR,PRCSTOLD,PRCCOPY,PRCSORC,PRCDEST
 Q
COPY(PRCDA) ;Requires PRCDA the IEN of RFQ
 N PRCI,PRCJ,PRCK,PRCX,DIC,PRCEDIT S PRCCOPY=0
 K DIR S DIR(0)="YA",DIR("A")="Do you wish to copy this RFQ into a new RFQ entry? "
 S DIR("B")="NO",DIR("?")="Answer 'YES' if you wish to copy this RFQ to make changes and reissue."
 D ^DIR K DIR
 Q:Y'=1  S PRCCOPY=1
 W !,"Copying this RFQ into a new entry..."
 K ^TMP($J,"RFQ") M ^TMP($J,"RFQ")=^PRC(444,PRCDA)
 F PRCI=6:1:9 K ^TMP($J,"RFQ",PRCI)
 F PRCI=5,6,11:1:19 S $P(^TMP($J,"RFQ",1),U,PRCI)=""
 S PRCI=0
 F  S PRCI=$O(^TMP($J,"RFQ",2,PRCI)) Q:+PRCI'=PRCI  D
 . Q:'$D(^TMP($J,"RFQ",2,PRCI,3))
 . S PRCK=^TMP($J,"RFQ",2,PRCI,3)
 . F PRCJ=3:1:9 S $P(PRCK,U,PRCJ)=""
 . S ^TMP($J,"RFQ",2,PRCI,3)=PRCK
 K ^TMP($J,"RFQ",2,"AG"),^TMP($J,"RFQ",2,"AJ") S $P(^TMP($J,"RFQ",0),U,8)=1
 S PRCX=$$GETNUM^PRCHQ2($P($P(^TMP($J,"RFQ",0),U),"-",1,2))
 I 'PRCX W !,"Unable to get new RFQ # - Please notify IRM staff" Q
 S $P(^TMP($J,"RFQ",0),U)=PRCX,X=PRCX
 K DIC S DIC="^PRC(444,",DIC(0)="LX",DLAYGO=444 D ^DIC K DIC,DLAYGO
 I +Y<1 W !,"Unable to add RFQ entry - Please notify IRM staff." Q
 S PRCDA=+Y
 W !,"RFQ # ",$P(Y,U,2)," has been added."
 L +^PRC(444,PRCDA):5 E  W !,"Someone else is editing this RFQ entry, please try later!" Q
 M ^PRC(444,PRCDA)=^TMP($J,"RFQ")
 K DA S DA=PRCDA,DIK="^PRC(444," D IX1^DIK K DA,DIK
 K ^TMP($J,"RFQ")
 K DIR S DIR(0)="YA",DIR("A")="Do you wish to edit this new RFQ now? "
 S DIR("B")="YES",DIR("?")="Enter 'YES' to edit now, or 'NO' to exit."
 D ^DIR K DIR
 Q:Y'=1
 S PRCEDIT=$$EDITOR^PRCHQ1C
 I PRCEDIT="" D EN^DDIOL("Edit mode not indicated, aborting the edit.") G COPYX
 D EDIT^PRCHQ2B
COPYX L -^PRC(444,PRCDA)
 Q
