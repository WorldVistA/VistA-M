PRCHQ13A ;(WASH IRMFO)/LKG-RFQ Award ;8/6/96  20:46
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
EN ;Entry point for awarding evaluation complete RFQs
 K DIC S DIC="^PRC(444,",DIC(0)="AEMQ",DIC("S")="I $P(^(0),U,8)=4"
 S DIC("A")="Select RFQ to Award: " D ^DIC K DIC
 G EX1:+Y<1!$D(DTOUT)!$D(DUOUT)
 S PRCDA=+Y,PRCRFQ=$P(Y,U,2)
 L +^PRC(444,PRCDA):5 E  W !,"This RFQ entry is in use, please try later!" G EN
 K DIR S DIR(0)="YA",DIR("A")="Do you wish to review this RFQ? "
 S DIR("B")="YES",DIR("?")="Answer 'YES' if you wish to view the RFQ before proceeding with the award."
 D ^DIR K DIR
 I Y=1 D  G:Y'=1 A
 . N L,DIC,DR,FLDS,BY,FR,TO,IOP S DIC=444,BY=.01,(FR,TO)=PRCRFQ,L=0,IOP="HOME"
 . S FLDS="[PRCHQ RFQ FULL]" D EN1^DIP K DIC,FLDS,BY,FR,DR,L
 . S DIR(0)="YA",DIR("A")="Is this the correct RFQ? ",DIR("B")="NO"
 . S DIR("?")="Answer 'NO' to abort the Award."
 . D ^DIR K DIR
 S PRCMSG="" D ESIG^PRCUESIG(DUZ,.PRCMSG) G:PRCMSG'=1 EX1
 D AWARD(PRCDA)
A L -^PRC(444,PRCDA)
 G EN:'$D(DIRUT)&'$D(DIROUT)
EX1 L:$D(PRCDA) -^PRC(444,PRCDA)
 K DIC,DTOUT,DUOUT,DIRUT,DIROUT,PRCDA,PRCRFQ,X,Y,PRCMSG
 Q
 ;;Driver for calls to set up 2237 and PO documents
AWARD(PRCRFQDA) ;Entry point for creating 2237 and PO documents
 N PRCQDA,PRCNLNK S PRCQDA=0 K ^TMP($J,"RFQ")
 F  S PRCQDA=$O(^PRC(444,PRCRFQDA,2,"AJ",PRCQDA)) Q:+PRCQDA'=PRCQDA  D
 . N PRCAR,PRCX
 . S PRCV=$P($G(^PRC(444,PRCRFQDA,8,PRCQDA,0)),U)
 . I '$D(@("^"_$P(PRCV,";",2)_(+PRCV)_",0)")) S PRCAR="Vendor submitting Quote #"_PRCQDA_" is not in the database!" D EN^DDIOL(PRCAR) K PRCAR Q
 . I PRCV["PRC(444.1",$P($G(^PRC(444.1,+PRCV,0)),U,9)="" D  Q:PRCNLNK
 . . K PRCAR S PRCX=^PRC(444.1,+PRCV,0),PRCNLNK=0
 . . S PRCAR(1)="Vendor "_$P(PRCX,U)_" Dun # "_$P(PRCX,U,2)_" must be linked to an"
 . . S PRCAR(2)="existing File #440 entry before he can receive awards."
 . . D EN^DDIOL(.PRCAR) K PRCAR
 . . K DIR S DIR(0)="YA",DIR("A")="Do you wish to link the vendor at this time? "
 . . S DIR("B")="YES",DIR("?")="Answer 'YES' to continue or 'NO' to bypass this vendor"
 . . D ^DIR K DIR
 . . I Y'=1 D EN^DDIOL("Bypassing this vendor") S PRCNLNK=1 Q
 . . S DA=+PRCV,DIE=444.1,DR=60 D ^DIE K DIE,DR,DA
 . . I $P(^PRC(444.1,+PRCV,0),U,9)="" D EN^DDIOL("Bypassing this vendor") S PRCNLNK=1 Q
 . S PRCI=0
 . F  S PRCI=$O(^PRC(444,PRCRFQDA,2,"AJ",PRCQDA,PRCI)) Q:+PRCI'=PRCI  D
 . . S PRCLN=$P($G(^PRC(444,PRCRFQDA,2,PRCI,0)),U) Q:PRCLN=""
 . . Q:$P($G(^PRC(444,PRCRFQDA,2,PRCI,3)),U,6)]""
 . . S PRCITM=$P(^PRC(444,PRCRFQDA,2,PRCI,0),U,4)
 . . I PRCITM]"" D  Q:$G(PRCSKIP)
 . . . S PRCSKIP=0
 . . . S PRCVEN=$S(PRCV["PRC(444.1":$P(^PRC(444.1,+PRCV,0),U,9),1:+PRCV)
 . . . I '$D(^PRC(441,PRCITM,2,PRCVEN)) D
 . . . . K PRCAR
 . . . . S PRCAR(1)="Vendor "_$P($G(^PRC(440,PRCVEN,0)),U)_" Dun # "_$P($G(^PRC(440,PRCVEN,7)),U,12)_" must be associated"
 . . . . S PRCAR(2)="with ITEM MASTER File entry #"_PRCITM_" before he can be awarded this"
 . . . . S PRCAR(3)="item."
 . . . . D EN^DDIOL(.PRCAR) K PRCAR S PRCSKIP=1
 . . S PRCK=$O(^PRC(444,PRCRFQDA,8,PRCQDA,3,"B",PRCLN,"")) Q:PRCK=""
 . . S PRCFOB=$P($G(^PRC(444,PRCRFQDA,8,PRCQDA,3,PRCK,0)),U,10)
 . . S:PRCFOB="" PRCFOB=$P($G(^PRC(444,PRCRFQDA,8,PRCQDA,1)),U)
 . . S:PRCFOB="" PRCFOB=$P($G(^PRC(444,PRCRFQDA,1)),U)
 . . S ^TMP($J,"RFQ",PRCRFQDA,PRCQDA,PRCFOB,PRCI)=""
 S PRCQDA=0
 F  S PRCQDA=$O(^TMP($J,"RFQ",PRCRFQDA,PRCQDA)) Q:PRCQDA=""  D
 . S PRCFOB=""
 . F  S PRCFOB=$O(^TMP($J,"RFQ",PRCRFQDA,PRCQDA,PRCFOB)) Q:PRCFOB=""  D
 . . S PRC2237=$$REQUEST^PRCHQ410(PRCRFQDA,PRCQDA,"^TMP($J,""RFQ"",PRCRFQDA,PRCQDA,PRCFOB)")
 . . I PRC2237>0 D
 . . . K PRCAR S PRCAR="2237 #"_$P($G(^PRCS(410,PRC2237,0)),U)_" has been built for Quote #"_PRCQDA_"." D EN^DDIOL(PRCAR) K PRCAR
 . . . S PRCRFQPO=$$POBLD^PRCHQ15(PRC2237,PRCRFQDA,PRCQDA,PRCFOB)
 . . . I PRCRFQPO'="" K PRCAR S PRCAR="PO #"_PRCRFQPO_" has been built for Quote #"_PRCQDA_"." D EN^DDIOL(PRCAR) K PRCAR
 S PRCI=0,PRCAWARD=1
 F  S PRCI=$O(^PRC(444,PRCRFQDA,2,PRCI)) Q:+PRCI'=PRCI  D  Q:'PRCAWARD
 . I $P($G(^PRC(444,PRCRFQDA,2,PRCI,3)),U,6)="" S PRCAWARD=0
 I PRCAWARD,$P(^PRC(444,PRCRFQDA,0),U,8)'=5 D
 . S PRCOSTAT=$P("CANCELLED^INCOMPLETE^PENDING QUOTES^CLOSED^EVALUATION COMPLETE^AWARDED",U,$P(^PRC(444,PRCRFQDA,0),U,8)+1)
 . K DA,DR S DA=PRCRFQDA,DIE=444,DR="7////5" D ^DIE K DIE,DR
 . K PRCAR S PRCAR(1)="The Status of RFQ #"_$P(^PRC(444,PRCRFQDA,0),U)_" has been changed from"
 . S PRCAR(2)=PRCOSTAT_" to AWARDED."
 . D EN^DDIOL(.PRCAR) K PRCAR
EX K DA,DIE,DR,PRCAR,PRC2237,PRCAWARD,PRCFOB,PRCI,PRCITM,PRCK,PRCLN,PRCOSTAT
 K PRCQDA,PRCRFQPO,PRCSKIP,PRCV,PRCVEN,PRCX
 Q
