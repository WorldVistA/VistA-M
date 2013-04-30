PRCHG ;ID/RSD,SF-ISC/TKW/DAP-PROCESS 2237 ;6/18/12  13:07
V ;;5.1;IFCAP;**81,167**;Oct 20, 2000;Build 17
 ;Per VHA Directive 2004-38, this routine should not be modified.
 ;
ES ;SIGN 2237 IN PPM
 G Q:'$D(PRC("PER"))!('$D(PRC("SITE"))) I $S('$D(^VA(200,+PRC("PER"),400)):1,$P(^(400),U,1)=4:0,$P(^(400),U,1)=2:0,1:1) W !!,"You are not a Supply Accountable Officer !",$C(7) G Q
 S P=+PRC("PER"),DA=1,PRCSIG="" D ESIG^PRCUESIG(DUZ,.PRCSIG) S ROUTINE="PRCUESIG" G:PRCSIG'=1 QQ S PRCHNM=$P(^VA(200,P,20),U,2)
 Q
 ;
ES1 ;S PRCHG=$S($D(^PRCD(442.3,+$P(^PRC(443,DA,0),U,7),0)):$P(^(0),U,2),1:""),$P(^PRC(443,DA,0),"^",3)="",P=+PRC("PER")
 S PRCHG=$P($G(^PRCD(442.3,+$P(^PRC(443,DA,0),U,7),0)),U,2),$P(^PRC(443,DA,0),"^",3)="",P=+PRC("PER")
 I PRCHG=63 S PRCFA("WHO")=3 D RET
 N DA2237 S DA2237=DA
 ;
 ;if PO is not for PPM Clerk stop processing and exit
 I PRCHG<65 K PRCHG Q
 S PRCSIG="" D ENCODE^PRCHES11(DA,DUZ,.PRCSIG) S ROUTINE=$T(+0) G:PRCSIG<1 QQ
 ;set AO name, signature date on 2237 record
 I $D(DA2237) L +^PRCS(410,DA2237):15 Q:'$T  D NOW^%DTC S $P(^PRCS(410,DA2237,7),"^",11)=P,$P(^PRCS(410,DA2237,7),"^",12)=% L -^PRCS(410,DA2237)
 ;
 ;if 2237 status is 'Sent to eCMS(P&C)', transmit to eCMS via HL7 msg OMN^O07 (PRC*5.1*167)
 N PRCERFLG ;2237 transmission error flag
 N PRCER    ;transmission error msg
 N PRCEVNT  ;event array for LOG^PRCHJTA
 I PRCHG=69 D
 . N PRCLOGER ;error returned from LOG^PRCHJTA
 . N PRCMSGID ;ien of msg in HLO MESSAGES (#778)
 . W !!,"Transmitting 2237 transaction to eCMS..."
 . S PRCMSGID=$$SEND2237^PRCHJS01($G(DA2237),.PRCER)
 . ;
 . ;was the transmission successful, ELSE did it fail?
 . I $G(PRCMSGID)>0 D
 . . W !?3,">>> 2237 transaction has been successfully transmitted to eCMS."
 . . W !?3,"    Transaction Number: "_$G(PRCTRANS)
 . . W !?3,"        HLO Message ID: "_$G(PRCMSGID)
 . . W !!?3,">>> Updating transmission in IFCAP/ECMS Transaction file..."
 . . S PRCEVNT("MSGID")=$G(PRCMSGID)
 . . S PRCEVNT("IEN410")=$G(DA2237)
 . . S PRCEVNT("IFCAPU")=$G(DUZ)
 . . D LOG^PRCHJTA($G(PRCTRANS),,1,.PRCEVNT,.PRCLOGER)
 . . I +$G(PRCLOGER) W !?3,"    Error: "_$P($G(PRCLOGER),U,2)
 . E  D
 . . W !?3,">>> ERROR: 2237 was not transmitted to eCMS!"
 . . W !?3,"    Transaction Number: "_$G(PRCTRANS)
 . . W !?3,"    Error: "_$G(PRCER)
 . . S PRCERFLG=1 ;set flag for sending notification msg to Accountable Officer
 . . W !!?3,">>> Updating transmission error in IFCAP/ECMS Transaction file..."
 . . S PRCEVNT("MSGID")=""
 . . S PRCEVNT("IEN410")=$G(DA2237)
 . . S PRCEVNT("IFCAPU")=$G(DUZ)
 . . S PRCEVNT("ERROR",1)="An error occurred when transmitting the 2237 transaction to eCMS."
 . . S PRCEVNT("ERROR",2)="Error: "_$E($G(PRCER),1,60)
 . . I $D(XQY0) S PRCEVNT("ERROR",3)="Option: "_$P($G(XQY0),"^",2)
 . . D LOG^PRCHJTA($G(PRCTRANS),,1,.PRCEVNT,.PRCLOGER)
 . . I +$G(PRCLOGER) W !?3,"    Error: "_$P($G(PRCLOGER),U,2)
 ;
 ;if 2237 transmission error occurred, send notification msg to AO (PRC*5.1*167)
 I PRCHG=69,($G(PRCERFLG)) D
 . W !!?3,">>> Sending error notification mail message to Accountable Officer..."
 . N PRCMSG1,PRCMSG2 ;input arrays for PHMSG^PRCHJMSG, pass by ref
 . S PRCMSG1(1)=$G(PRCTRANS) ;2237 transaction #
 . S PRCMSG1(2)=5 ;return to AO since failed transmission to eCMS
 . S PRCMSG1(3)=$$NOW^XLFDT ;action date/time
 . I $G(PRCER)["REQUESTING SERVICE" D
 . . S PRCMSG1(7)="Return 2237 to Control Point for edit and re-approval!"
 . E  D
 . . S PRCMSG1(7)="Please forward this message to appropriate OIT staff!"
 . M PRCMSG2=PRCEVNT("ERROR") ;merge error array into PRCMSG2 array
 . D PHMSG^PRCHJMSG(.PRCMSG1,.PRCMSG2) ;send msg
 ;
 Q
 ;
QQ S:'$D(ROUTINE) ROUTINE=$T(+0) W !!,$$ERR^PRCHQQ(ROUTINE,PRCSIG) W:PRCSIG=0!(PRCSIG=-3) !,"Notify Application Coordinator!",$C(7) S DIR(0)="EAO",DIR("A")="Press <return> to continue" D ^DIR
 ;
Q K %,DA,DIC,DIE,DR,P,PRCHNM,PRCHTDA,PRCHG,PRCHPO,PRCHS,PRCHSIT,PRCHSX,PRCHSY,PRCHSZ,PRCHX,PRCTRANS,ROUTINE
 Q
 ;
RET ;RETURN TO SERVICE--UPDATE CP BALANCES, ERASE CP OFFICIAL SIGNATURE, SEND BULLETIN BACK TO SERVICE
 S PRCHDA=DA,X=$P(^PRCS(410,DA,4),"^",8) D TRANK^PRCSES S $P(^PRCS(410,DA,7),"^",5,7)="^^",$P(^PRCS(410,DA,10),U,4)=$P(^PRC(443,DA,0),U,7),DIE="^PRCS(410,",DR=61 D ^DIE K DIE
 S DA=PRCHDA D REMOVE^PRCSC1(DA),REMOVE^PRCSC3(DA)
 ;remove AO name, signature date from 2237 record
 N PPMNODE F PPMNODE=11,12 S $P(^PRCS(410,DA,7),"^",PPMNODE)=""
 S (DA,PRCFA("TRDA"))=PRCHDA D RETURN^PRCEFIS1 S DA=PRCHDA D EN3^PRCPWI
 Q
 ;
SIT S PRCF("X")="SP" D ^PRCFSITE K PRCHNM
 Q
 ;
TR S DIC("S")="I $P(^(0),U,3)="""",$D(^PRCS(410,Y,7)),$P(^(7),U,6)]"""",+^(0)=PRC(""SITE"")"
 S DIC("S")=$S('$D(PRCFDICS):DIC("S")_" S Z=$O(^PRCD(442.3,""C"",+$P(^PRC(443,Y,0),U,7),0)) I Z'=10&(Z'=85)",1:DIC("S")_PRCFDICS)
 ;
DIC W !! K DA S DIC="^PRC(443,",DIC(0)="QEAMZ",DIC("A")="2237 TRANSACTION NUMBER: " D ^DIC S DIE=DIC K DIC S:Y>0 DA=+Y,PRCTRANS=$G(Y(0,0))
 Q
 ;
ST S DIC("S")="I $P(^(0),U,3)]"""",$O(^PRCD(442.3,""C"",+$P(^(0),U,7),0))'=65,$D(^PRCS(410,+Y,0)),+^(0)=PRC(""SITE"")" D DIC
 Q
 ;
PPM S DR="[PRCHPPM]",DIE("NO^")="" D ^DIE K DIE,PRCHPPM D ES1
 Q
 ;
EN ;SIGN 2237 IN PPM
 D SIT Q:'$D(PRC("SITE"))  D:'$D(PRCHNM) ES G:'$D(PRCHNM) Q
 ;*81 Check site parameter to see if issue books should be allowed
 I $$GET^XPAR("SYS","PRCV COTS INVENTORY",1,"Q")'=1 D EN^PRCHG1
 ;
EN0 D:'$D(PRCHNM) ES G:'$D(PRCHNM) Q D TR G:'$D(DA) Q D PPM
 G EN0
 ;
EN1 ;SIGN 2237 IN PC
 D SIT Q:'$D(PRC("SITE"))
EN10 D ST G:'$D(DA) Q S DR="[PRCHPC]",DIE("NO^")="" D ^DIE K DIE
 G EN10
 ;
EN2 ;RETURN 2237 IN PC
 D SIT Q:'$D(PRC("SITE"))
EN20 ;D ST G:'$D(DA) Q S DR="[PRCHPCR]" D ^DIE K PRCHPCR S Z=$S($D(^PRCD(442.3,+$P(^PRC(443,DA,0),U,7),0)):$P(^(0),U,2),1:"") G:Z'=76 EN20
 D ST G:'$D(DA) Q S DR="[PRCHPCR]" D ^DIE K PRCHPCR S Z=$P($G(^PRCD(442.3,+$P(^PRC(443,DA,0),U,7),0)),U,2) G:Z'=76 EN20
 S $P(^PRC(443,DA,0),"^",2,4)="^^"
 S PRCFA("WHO")=2 D RET
 G EN20
 ;
EN3 ;SPLIT 2237 IN PPM
 D SIT Q:'$D(PRC("SITE"))
EN30 D TR G:'$D(DA) Q S PRCHSY(0)=Y(0),(PRCHPO,PRCHSY)=DA,(PRCHG,PRCHSZ)=1 D N^PRCHNPO3 G Q:'$D(PRCHSY)!('$O(^TMP($J,"PRCHS",0))),W1:+^TMP($J,"PRCHS",0)=+^PRCS(410,DA,10)
 S PRCHSIT=+^TMP($J,"PRCHS",0),PRCHS=PRCHSY D WAIT^DICD,^PRCHSP I PRCHSY=-1 D ERR^PRCHNPO3,Q G EN30
 W !!,"The new 2237, ",PRCHSX,", will now be printed with the old one." F DA=PRCHS,PRCHSY S PRCSF=1 D PRF1^PRCSP1
 K PRCSF D Q
 G EN30
 ;
EN4 ;EDIT A SIGNED 2237 IN PPM
 D SIT Q:'$D(PRC("SITE"))
EN40 D:'$D(PRCHNM) ES G:'$D(PRCHNM) Q S DIC("S")="I $P(^(0),U,3)]""""" D DIC G:'$D(DA) Q D PPM
 G EN40
 ;
EN5 ;DISPLAY NO.OF REQUESTS TO BE PROCESSED BY PPM
 S X=0 F I=0:0 S I=$O(^PRC(443,"AC",60,I)) Q:'I  S X=X+1
 W $C(7),!!!,?3,"There are "_X_" Requests ready to process." K X,I
 Q
 ;
W1 W !!,"You have selected all Line Items, NO action taken.",$C(7) D Q
 G EN3
 ;
STAT I $D(PRCFGPF) S DIC("S")="S Z=$P(^(0),U,2) I Z=10!(Z=60)!(Z=85)" Q
 I $D(PRCHPCR) D  Q
 . S DIC("S")="I $P(^(0),U,2)=75!($P(^(0),U,2)=76)"
 . I $$GET^XPAR("SYS","PRCV COTS INVENTORY",1,"Q")=1 D  Q
 . . N PRC2237
 . . S PRC2237=$P(^PRCS(410,DA,0),"^",1)
 . . I '$$CHKDM^PRCVLIC(PRC2237) Q
 . . I $O(^PRCS(410,"AG",PRC2237,""))]"" S DIC("S")="I $P(^(0),U,2)=75"
 I '$D(PRCHPPM) S DIC("S")="I $P(^(0),U,2)>69" Q
 K Z0 S (Z0(60),Z0(62),Z0(63),Z0(65),Z0(74))="" S:$P(^PRC(443,DA,0),U,10)=4 Z0(70)="",Z0(69)=""
 S DIC("S")="I $D(Z0(+$P(^(0),U,2)))"
 Q
