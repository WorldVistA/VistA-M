PRCHQ2B ;(WASH IRMFO)/LKG-RFQ Enter/Edit cont ;9/8/96  21:07
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 I $P(PRC410(3),U,4)]"" D
 . S ^PRC(444,PRCDA,5,0)="^"_$P(^DD(444,20,0),U,2)_"^1^1"
 . S ^PRC(444,PRCDA,5,1,0)=$P(PRC410(3),U,4)_";PRC(440,"
 I $P(PRC410(3),U,4)="" D
 . N DIC,DIE,DR,Y,DA
 . S DIC=444.1,DIC(0)="XL",DLAYGO=444.1,X=$P(PRC410(2),U) D ^DIC K DLAYGO
 . Q:+Y<1
 . S ^PRC(444,PRCDA,5,0)="^"_$P(^DD(444,20,0),U,2)_"^1^1"
 . S ^PRC(444,PRCDA,5,1,0)=+Y_";PRC(444.1,"
 . I $P(Y,U,3) D
 . . S DA=+Y,DIE=444.1 L +^PRC(444.1,DA):5 E  W !,"Vendor ",$P(PRC410(2),U)," is being edited by another user." Q
 . . S PRCX=$P(PRC410(2),U,2) I PRCX]"" S DR="1///^S X=PRCX" D ^DIE
 . . S PRCX=$P(PRC410(2),U,3) I PRCX]"" S DR="2///^S X=PRCX" D ^DIE
 . . S PRCX=$P(PRC410(2),U,4) I PRCX]"" S DR="3///^S X=PRCX" D ^DIE
 . . S PRCX=$P(PRC410(2),U,5) I PRCX]"" S DR="4///^S X=PRCX" D ^DIE
 . . S PRCX=$P(PRC410(2),U,6) I PRCX]"" S DR="4.2///^S X=PRCX" D ^DIE
 . . S PRCX=$P(PRC410(2),U,7) I PRCX]"" S DR="4.4////^S X=PRCX" D ^DIE
 . . S PRCX=$P(PRC410(2),U,8) I PRCX]"" S DR="4.6///^S X=PRCX" D ^DIE
 . . S PRCX=$P(PRC410(2),U,9) I PRCX]"" S DR="4.8///^S X=PRCX" D ^DIE
 . . S PRCX=$P(PRC410(2),U,10) I PRCX]"" S DR="5///^S X=PRCX" D ^DIE
 . . L -^PRC(444.1,DA)
 S DA=PRCDA410,DIE="^PRC(443,",DR="1.5////79" D ^DIE K DA,DIE,DR
 L:$D(PRCDA410) -(^PRCS(410,PRCDA410),^PRC(443,PRCDA410))
 K DA,I,PRCDA410,PRC410,PRC443,PRCE,PRCI,PRCJ,PRCK,PRCL,PRCM,PRCN,PRCP,PRCQ,PRCX,PRCY,X,Y
 K DIR S DIR(0)="YA",DIR("A")="Do you wish to import items from an additional 2237? "
 S DIR("B")="NO"
 S DIR("?",1)="If you answer 'YES', you will be prompted for an Assigned to Purchasing Agent"
 S DIR("?",2)="2237 with the same Fund Control Point."
 S DIR("?")="All item information on that 2237 will be imported into this RFQ"
 D ^DIR K DIR G INDX:$D(DIRUT),INDX:Y'=1
 S PRCX=$P($P(^PRC(444,PRCDA,0),U,14)," ")
LOOP K DIC S DIC="^PRC(443,",DIC(0)="AEMN"
 S DIC("S")="I "";70;80;""[("";""_$P(^(0),U,7)_"";""),PRCX=$P($P($G(^PRCS(410,Y,0)),U),""-"",4),$P($G(^PRCS(410,Y,4)),U,5)="""""
 S DIC("A")="Enter additional 2237 Transaction #: " D ^DIC K DIC
 I Y<1!$D(DTOUT)!$D(DUOUT) G INDX
 S PRCDA410=+Y
 L +^PRC(443,PRCDA410):5 E  W !,"Work Sheet entry in use, please try later!" G INDX
 L +^PRCS(410,PRCDA410):5 E  W !,"Someone is editing the source 2237, please try later!" G INDX
 W !,"Importing item information into this RFQ entry..."
 S PRC410(3)=$G(^PRCS(410,PRCDA410,3))
 D IT^PRCHQ2A
 S DA=PRCDA410,DIE="^PRC(443,",DR="1.5////79" D ^DIE K DA,DIE,DR
 L -(^PRCS(410,PRCDA410),^PRC(443,PRCDA410))
 K PRCDA410
 G LOOP
INDX ;Index the entry
 K PRC410
 D NOW^%DTC S $P(^PRC(444,PRCDA,1),U,9,10)=DUZ_U_% K %,%H,%I
 W !,"Building the cross references..."
 S DIK="^PRC(444,",DA=PRCDA D IX1^DIK K DA,DIK
 G:$D(DUOUT)!$D(DIRUT)!$D(DTOUT) OUT
CONT D EDIT L -^PRC(444,PRCDA)
 I '$D(DTOUT)&'$D(DUOUT)&'$D(DIRUT)&'$D(DIROUT) G B^PRCHQ2:$G(PRCNEW),A^PRCHQ2
OUT ;
 L:$D(PRCDA410) -(^PRCS(410,PRCDA410),^PRC(443,PRCDA410))
 L:$D(PRCDA) -^PRC(444,PRCDA)
 K DA,DIC,DIRUT,DIROUT,DTOUT,DUOUT,PRCDA,PRCDA410,PRCOUT,PRCX,X,Y,PRCNEW,PRCEDIT
 Q
EDIT ;Edit RFQ
 N %,%H,%I
 I PRCEDIT="s" D
 . K DA S DDSPARM="CS"
 . S DDSFILE=444,DR="[PRCHQ1]",DA=PRCDA,DDSPAGE=1 D ^DDS
 . K DA,DDSFILE,DR,DDSPAGE,DDSPARM,DIMSG,PRCMSG,%
 I PRCEDIT="i" D
 . N PRCMSG,PRCI,PRCX,PRCRD,PRCRQD,PRCDA2,PRCITMO,PRCIEN,PRCVEN
 . S PRCMSG="" D ESIG^PRCUESIG(DUZ,.PRCMSG)
 . I PRCMSG'=1 D EN^DDIOL("Electronic Signature Failed, Edit aborted") S PRCERR=10 Q
 . K DA S DIE="^PRC(444,",DA=PRCDA,DR="[PRCHQ RFQ REQUEST]" D ^DIE K DIE,DR
 . D NOW^%DTC S $P(^PRC(444,PRCDA,1),U,9,10)=DUZ_U_%
 . I $D(DTOUT) S PRCERR=10 Q
 . I $D(DUOUT) K DIR S DIR(0)="YA",DIR("A")="Do you wish to continue? ",DIR("B")="NO" D ^DIR K DIR I Y'=1 S PRCERR=10 Q
 . K DUOUT
 . S PRCI=0
 . F  S PRCI=$O(^PRC(444,PRCDA,5,PRCI)) Q:+PRCI'=PRCI  D  Q:$G(PRCERR)
 . . S PRCX=$G(^PRC(444,PRCDA,5,PRCI,0)) Q:$P(PRCX,U)'["PRC(444.1,"
 . . W !!,"Editing Solicited Vendor in RFQ Temporary Vendor File..."
 . . L +^PRC(444.1,+PRCX):3 E  S X="Vendor "_$P($G(^PRC(444.1,+PRCX,0)),U)_" is locked, please try later!" D EN^DDIOL(X) Q
 . . K DA S DA=+PRCX,DIE="^PRC(444.1,",DR=".01;18.3;38;4.8;5;46;1R;2;3;4;4.2R;4.4R;4.6"
 . . D ^DIE K DIE,DR,DA L -^PRC(444.1,+PRCX)
 . . I $D(DTOUT) S PRCERR=10 Q
 . . I $D(DUOUT) K DIR S DIR(0)="YA",DIR("A")="Do you wish to continue? ",DIR("B")="NO" D ^DIR K DIR I Y'=1 S PRCERR=10 Q
 . . K DUOUT
 . K DIR S DIR(0)="YA",DIR("A")="Do you wish to view the RFQ? "
 . S DIR("B")="YES" D ^DIR K DIR I $D(DIROUT)!$D(DIRUT) S PRCERR=10 Q
 . I Y=1 D
 . . S PRCRFQ=$P($G(^PRC(444,PRCDA,0)),U)
 . . S DIC=444,BY=.01,FLDS="[PRCHQ RFQ FULL]",L=0,(FR,TO)=PRCRFQ,DHD="@"
 . . D EN1^DIP K BY,DIC,DHD,FLDS,FR,L,TO
 I $G(DDSCHANG)=1!($G(DDSSAVE)=1)!(PRCEDIT="i"&'$G(PRCERR)) D
 . N PRCRFQ,PRCTYPE,PRCNOPRT S PRCRFQ=$P(^PRC(444,PRCDA,0),U)
 . K DIR S DIR(0)="YA",DIR("A")="Do you wish to transmit this RFQ to vendors? "
 . S DIR("B")="YES",DIR("?")="Accept default of 'YES' to transmit, enter 'NO' to avoid transmitting."
 . D ^DIR K DIR Q:Y'=1!$D(DIRUT)!$D(DIROUT)!$D(DTOUT)!$D(DUOUT)
 . I $P($G(^PRC(444,PRCDA,1)),U,8)'="y",$P($G(^PRC(444,PRCDA,5,0)),U,4)'>0 D EN^DDIOL("Warning - Transmit aborted as there are NO RECIPIENTS!") Q
 . S PRCTYPE="00"
 . K PRCERR
 . D TRANS840^PRCHQ4A(PRCTYPE)
 . I $G(PRCERR) D EN^DDIOL("Due to Error Conditions Transmission Was Aborted!") Q
 . S PRCNOPRT=$$MANUAL
 . I $P($G(^PRC(444,PRCDA,1)),U,11)=""&PRCNOPRT D EN^DDIOL("RFQ has not been transmitted, use option Edit Incomplete RFQ to complete.") Q
 . D:PRCNOPRT EN^DDIOL("Required manual RFQs were not printed, use option Manual Print of RFQ.")
 . I $P($G(^PRC(444,PRCDA,1)),U,11)]""!('PRCNOPRT) D
 . . N PRCAR,PRCSTAT,PRCSTRG
 . . S PRCSTRG="CANCELLED^INCOMPLETE^PENDING QUOTES^CLOSED^EVALUATION COMPLETE^AWARDED",PRCSTAT=$P(PRCSTRG,U,$P(^PRC(444,PRCDA,0),U,8)+1)
 . . K DA S DA=PRCDA,DR="7////2",DIE="^PRC(444," D ^DIE K DA,DIE,DR
 . . S PRCAR(1)="The status of RFQ #: "_PRCRFQ_" has been changed from"
 . . S PRCAR(2)="   '"_PRCSTAT_"' to '"_$P(PRCSTRG,U,$P($G(^PRC(444,PRCDA,0)),U,8)+1)_"'."
 . . D EN^DDIOL(.PRCAR)
 K DDSCHANG,DDSSAVE,PRCERR
 Q
MANUAL() ;Print Manual RFQ
 N X,Y,POP,%,%H,%I,DA
 S X=0,Y=0
 F  S X=$O(^PRC(444,PRCDA,5,X)) Q:+X'=X  I $P($G(^PRC(444,PRCDA,5,X,0)),U,2)="m" S Y=1 Q
 I 'Y D EN^DDIOL("There are no vendors for Manual Solicitation") Q 0
MANA K %ZIS S %ZIS("A")="90 Column Printer for Manual RFQ: "
 S %ZIS("B")="",%ZIS="PQ" D ^%ZIS I POP Q 1
 I $E(IOST)'="P"!(IOM'>89) D ^%ZISC,EN^DDIOL("Device must be a printer supporting 90 characters per line.") G MANA
 I $D(IO("Q")) S ZTRTN="PROCESS^PRCHQM1",ZTSAVE("DA")=PRCDA D ^%ZTLOAD,HOME^%ZIS G:$G(ZTSK)>0 XMANUAL Q 1
 S DA=PRCDA D PROCESS^PRCHQM1
XMANUAL ;
 Q 0
