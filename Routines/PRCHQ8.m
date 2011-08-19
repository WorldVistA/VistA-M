PRCHQ8 ;(WASH IRMFO)/LKG-RFQ RETRANSMIT ;8/6/96  20:59
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
RETRANS ;Retransmit 840 Transaction for RFQ
 K DIC S DIC="^PRC(444,",DIC(0)="AEMQ",DIC("S")="I "";2;""[("";""_$P(^(0),U,8)_"";"")"
 S DIC("A")="Select RFQ to retransmit: " D ^DIC K DIC
 G EX1:+Y<1!$D(DTOUT)!$D(DUOUT)
 S PRCDA=+Y,PRCRFQ=$P(Y,U,2)
 L +^PRC(444,PRCDA):5 E  W !,"This RFQ is in use, please try later!" G RETRANS
 K DIR S DIR(0)="YA",DIR("A")="Do you wish to review a synopsis of this RFQ? "
 S DIR("B")="YES",DIR("?")="Answer 'YES' if you wish to view the RFQ prior to retransmission."
 D ^DIR K DIR
 I Y=1 D  G:Y'=1 EX1
 . N L,DIC,DR,FLDS,BY,FR,TO,IOP S DIC=444,BY=.01,(FR,TO)=PRCRFQ,L=0,IOP="HOME"
 . S FLDS="[PRCHQ RFQ SYNOPSIS]" D EN1^DIP K DIC,FLDS,BY,FR,DR,L
 . S DIR(0)="YA",DIR("A")="Is this the correct RFQ? ",DIR("B")="NO"
 . S DIR("?")="Answer 'NO' to abort the retransmission."
 . D ^DIR K DIR
 K PRCERR S PRCTYPE="00"
 D TRANS840^PRCHQ4A(PRCTYPE) D:$G(PRCERR) EN^DDIOL("Electronic Transmission Aborted!")
 L -^PRC(444,PRCDA) K PRCERR
 G RETRANS
EX1 L:$D(PRCDA) -^PRC(444,PRCDA) K PRCDA,PRCRFQ,X,Y,DTOUT,DUOUT,DIRUT,DIROUT,PRCTYPE
 Q
RSND864 ;Retransmit 864 Text Message
 K DIC S DIC="^PRC(444,",DIC(0)="AEMQ",DIC("S")="I "";0;5;""'[("";""_$P(^(0),U,8)_"";"")"
 S DIC("A")="Select 864's RFQ #: " D ^DIC K DIC
 G EX2:+Y<1!$D(DTOUT)!$D(DUOUT)
 S PRCDA=+Y,PRCRFQ=$P(Y,U,2)
 L +^PRC(444,PRCDA):5 E  W !,"This RFQ is in use, please try later!" G RSND864
 K DIR S DIR(0)="YA",DIR("A")="Do you wish to view a synopsis of this RFQ? "
 S DIR("B")="YES",DIR("?")="Answer 'YES' if you wish to view the RFQ prior to selecting the message."
 D ^DIR K DIR
 I Y=1 D  G:Y'=1 EX2:$D(DTOUT)!$D(DIROUT)!$D(DIRUT),RSND864
 . N L,DIC,DR,FLDS,BY,FR,TO,IOP S DIC=444,BY=.01,(FR,TO)=PRCRFQ,L=0,IOP="HOME"
 . S FLDS="[PRCHQ RFQ SYNOPSIS]" D EN1^DIP K DIC,FLDS,BY,FR,DR,L
 . S DIR(0)="YA",DIR("A")="Is this the correct RFQ? ",DIR("B")="NO"
 . S DIR("?")="Answer 'NO' to return to the prompt for RFQ #."
 . D ^DIR K DIR
 . L:Y'=1 -^PRC(444,PRCDA)
A K DIC S DA(1)=PRCDA,DIC="^PRC(444,DA(1),7,",DIC("S")="I $P(^(0),U,2)=""O"""
 S DIC("W")="S PRCZ=$P(^(0),U,6) W ""   Created: "",+$E(PRCZ,4,5),""/"",+$E(PRCZ,6,7),""/"",$E(PRCZ,2,3),""  "",$E($P($G(^(1)),U),1,40) K PRCZ"
 S DIC(0)="AEMQ",DIC("A")="Select 864 Text Message: "
 D ^DIC K DIC,DA
 G EX2:$D(DTOUT)!$D(DUOUT),RSND864:+Y<1
 S PRCDA2=+Y,PRCMSGN=$P(Y,U,2)
 K DIR S DIR(0)="YA",DIR("A")="Do you wish to view this text message? "
 S DIR("B")="YES",DIR("?")="Answer 'YES' if you wish to view this message before transmission."
 D ^DIR K DIR
 I Y=1 D  G EX2:$D(DIROUT)!$D(DIRUT),A:+Y<1
 . N L,DIC,DR,FLDS,BY,FR,TO,IOP,DHD S DIC=444,L=0,BY="[PRCHQ RFQ MESSAGE SORT]"
 . S FLDS="[PRCHQ RFQ MESSAGES 2]",(FR,TO)=PRCRFQ_","_PRCMSGN,DHD="@",IOP="HOME"
 . D EN1^DIP K DIC,FLDS,BY,FR,TO,DHD,L
 . K DIR S DIR(0)="YA",DIR("A")="Is this the correct Message? "
 . S DIR("B")="NO",DIR("?")="Answer 'NO' to abort the retransmission."
 . D ^DIR K DIR
 . L:Y'=1 -^PRC(444,PRCDA)
 K PRCERR
 D TRANS864^PRCHQ4A D:$G(PRCERR) EN^DDIOL("Electronic Transmission Aborted!")
 L -^PRC(444,PRCDA) K PRCERR
 G A
EX2 L:$D(PRCDA) -^PRC(444,PRCDA)
 K PRCDA,PRCDA2,PRCRFQ,PRCMSGN,DTOUT,DUOUT,DIRUT,DIROUT,X,Y,DA
 Q
