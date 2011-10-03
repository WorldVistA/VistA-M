PRCHQ5 ;(WASH IRMFO)/LKG-RFQ 864 Text Message Create ;9/6/96  15:00
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
EN ;Entry point
 S PRCEDIT=$$EDITOR^PRCHQ1C
 I PRCEDIT="" D EN^DDIOL("Edit mode not indicated, aborting the edit") K PRCEDIT Q
 S PRCMSG="" D ESIG^PRCUESIG(DUZ,.PRCMSG)
 I PRCMSG'=1 D EN^DDIOL("Electronic Signature Failed, Edit aborted") G OUT
 S DIC="^PRC(444,",DIC(0)="AEMQ",DIC("S")="I "";2;3;4;""[("";""_$P(^(0),U,8)_"";"")"
 S DIC("A")="Enter RFQ #: " D ^DIC K DIC I Y<1!$D(DTOUT)!$D(DUOUT) G OUT
 S PRCDA=+Y
 L +^PRC(444,PRCDA):3 E  W !,"Someone else is editing this entry, please try later!" G OUT
 S PRCX=$G(^PRC(444,PRCDA,1)),PRCMSGN=$P(PRCX,U,5)+1,PRCOUTN=$P(PRCX,U,6)+1
 K DD,DO S DA(1)=PRCDA,DIC="^PRC(444,DA(1),7,",DIC(0)="L"
 S DIC("P")=$P(^DD(444,21,0),U,2),X=PRCMSGN,DINUM=PRCMSGN,DLAYGO=444.021
 D FILE^DICN K DIC,DINUM,DLAYGO
 I Y<1 W !,"No entry was made.!" L -^PRC(444,PRCDA) G EX
 S PRCDA2=+Y
 S $P(^PRC(444,PRCDA,1),U,5,6)=PRCMSGN_U_PRCOUTN
 K ^UTILITY("DIQ1",$J) S DA=DUZ,DIC=200,DR=".01;.135" D EN^DIQ1
 S PRCA=^UTILITY("DIQ1",$J,200,DA,.01),PRCB=^(.135) K ^UTILITY("DIQ1",$J)
 S DA=PRCDA2,DA(1)=PRCDA,DIE="^PRC(444,DA(1),7,"
 S DR="1////O;4///^S X=PRCOUTN;5///NOW;6///NOW;7///^S X=PRCA" D ^DIE
 I PRCB]"" S DR="8///^S X=PRCB" D ^DIE
 S PRCA=$P($G(^PRC(444,PRCDA,1)),U,8) I PRCA]"" S DR="12////^S X=PRCA" D ^DIE
 K DIE,DR,DA,PRCA,PRCB
 I $P($G(^PRC(444,PRCDA,5,0)),U,4)>0 D
 . N PRCX,PRCY,PRCDA3
 . S PRCX=0,PRCDA3=0
 . F  S PRCX=$O(^PRC(444,PRCDA,5,PRCX)) Q:PRCX'?1.N  D
 . . S PRCY=$G(^PRC(444,PRCDA,5,PRCX,0)) Q:PRCY=""
 . . Q:$P(PRCY,U,2)'="e"&($P(PRCY,U,2)'="b")  S PRCY=$P(PRCY,U) Q:PRCY=""
 . . S PRCDA3=PRCDA3+1,^PRC(444,PRCDA,7,PRCDA2,3,PRCDA3,0)=PRCY
 . . S ^PRC(444,PRCDA,7,PRCDA2,3,"B",PRCY,PRCDA3)=""
 . S:PRCDA3>0 ^PRC(444,PRCDA,7,PRCDA2,3,0)=U_$P(^DD(444.021,11,0),U,2)_U_PRCDA3_U_PRCDA3
DDS ;Test FORM
 S PRCRFQ=$P($G(^PRC(444,PRCDA,0)),U)
 I PRCEDIT="s" D  G EX:$D(DTOUT)
 . S DDSPARM="S"
 . S DDSFILE=444,DDSFILE(1)=444.021,DA(1)=PRCDA,DA=PRCDA2,DR="[PRCHQ4]"
 . D ^DDS
 . K DDSCHANG,DDSPARM,DIMSG,DDSFILE,DA,DR
 I PRCEDIT="i" D  G EX:$D(DTOUT)!$D(DUOUT)
 . N %,%H,%I
 . K DA S DA=PRCDA2,DA(1)=PRCDA,DIE="^PRC(444,PRCDA,7,",DR="9R;10R;8R;12R;11",DR(2,444.022)=".01"
 . D ^DIE K DIE,DR
 . D NOW^%DTC S $P(^PRC(444,PRCDA,7,PRCDA2,0),U,10,11)=DUZ_U_%
 I $G(DDSSAVE)=1!(PRCEDIT="i") D
 . S DIR(0)="YA",DIR("A")="Do you wish to transmit this message to the vendors? "
 . S DIR("B")="YES",DIR("?")="Accept default of 'YES' to transmit, enter 'No' to avoid transmitting."
 . D ^DIR K DIR Q:Y'=1!$D(DIRUT)!$D(DIROUT)!$D(DTOUT)!$D(DUOUT)
 . K PRCERR
 . D TRANS864^PRCHQ4A
 . I $G(PRCERR) D EN^DDIOL("Electronic Transmission Aborted!")
EX L:$D(PRCDA) -^PRC(444,PRCDA) K DDSSAVE,PRCERR
OUT K PRCX,PRCMSGN,PRCOUTN,PRCDA,PRCDA2,PRCRFQ,DTOUT,DUOUT,DA,DIRUT,DIROUT,X,Y,PRCMSG,%,PRCEDIT
 Q
SC() ;Screen for File 440 and File 444.1 vendors
 N PRC,PRCX,PRCZ S PRC=0,PRCX=Y_";"_$P(DIC,U,2)
 I $D(PRCDA) D
 . S PRCZ=$O(^PRC(444,PRCDA,5,"B",PRCX,""))
 . I PRCZ]"",$P($G(^PRC(444,PRCDA,5,PRCZ,0)),U,2)="e" S PRC=1 Q
 . I $P($G(^PRC(444,PRCDA,1)),U,8)="y",PRCX["PRC(440",$P($G(^PRC(440,+PRCX,3)),U,2)="Y",$P($G(^PRC(440,+PRCX,7)),U,12)]"" S PRC=1 Q
 Q PRC
RHLP ;Executable Help for Recipient Lookup
 N PRCAR S PRCAR(1)="Choices are restricted to Electronic Solicited Vendors unless the RFQ's"
 S PRCAR(2)="   transmission was Public.  Vendor must be EDI and have Duns #."
 D EN^DDIOL(.PRCAR)
 Q
