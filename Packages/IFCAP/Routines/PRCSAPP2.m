PRCSAPP2 ;WISC/KMB/BGJ/SC/ASU - CONTINUATION OF PRCSAPP ; 3/31/05 3:07pm
V ;;5.1;IFCAP;**14,81,148,186**;Oct 20, 2000;Build 10
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ;PRC*5.1*81-if a 2237 trx is being approved & it originated from
 ;DynaMed RIL then update DM re. approval thru a call to rtn PRCVTAP
 ;
 ;PRC*5.1*186 Fix duplicate entries in file 443 by changing 
 ;            the direct field 1.5 and x-ref 'AC' set to 
 ;            Fileman update of status field.
 ;
FINAL ;   ask if request was reviewed. print request if needed.
 ;
 N PRCSDA,PRCPRIB,RPRINT,REPLY,REPLY1 S (REPLY,REPLY1)=2
 ; SKIPRNT is set in PRCSEB - official can approve request here
 ; immediately after creating it in PRCSEB
 I '$D(SKIPRNT) S %=0 W !,"Requests need to be reviewed prior to approval.",!,"Have you reviewed this request" D YN^DICN Q:%=-1  I %=0 W !,"Enter yes or no.",! H 1 G FINAL
 I '$D(SKIPRNT),%=2 S (PRCS,PRCPRIB)=DA,TRNODE(0)=0 D:PRCHQ=1 NODE^PRCS58OB(DA,.TRNODE) S RPRINT=$S(PRCHQ=1:"^PRCE58P0",PRCHQ=5:"DQ^PRCPRIB0",1:"^PRCSD12") D @RPRINT S DA=PRCS
 ;ask for approval, signature
 N PRCOKCB S PRCOKCB=$$OKCCBOC^PRCSCK($P(PRCSN,"^"))
 I PRCOKCB S %=1 W !,"Is this request ready for approval" D YN^DICN W:%=0 !,"Enter yes or no.",! G:%=0 FINAL Q:%=-1  S REPLY=%
 I 'PRCOKCB S REPLY=2
 ; PRC*5.1*148 start
 ; if Approver is a requestor, violation to segregation of duties
 I REPLY=1,PRCHQ=1,$P($G(^PRCS(410,DA,7)),"^",1)=DUZ D  G FINAL2
 . W !!,"You are the CP Clerk (Requestor) on this 1358 transaction."
 . W " Per Segregation",!,"of Duties, the CP Clerk (Requestor)"
 . W " is not permitted to Approve the 1358." H 2
 ; PRC*5.1*148 end
 ;
FINAL1 ;*******************************************************************
 ;PRCVDM -flag helps in determining if ans is Y to transmit to Fiscal
 ;then ONLY pass the data to DynaMed for DM related approved 2237
 ;*******************************************************************
 N PRCVDM
 I REPLY=1 W !,"Is this request ready for transmission to A&MM/Fiscal" S %=2 D YN^DICN Q:%=-1  S REPLY1=% S:%=1 PRCVDM=1 I %=0 W !,"Enter yes or no.",! H 1 G FINAL1
 ;  if ready for approval (or reviewed), store on cross-ref F,F1
FINAL2 ;
 D:REPLY=2 W5^PRCSEB D:REPLY=1 W51^PRCSEB Q:REPLY1=2
 I $D(SKIPRNT) S MESSAGE="" D ESIG^PRCUESIG(DUZ,.MESSAGE) Q:MESSAGE'=1
 ;********************************************************************
 ;all of the line item data that we need to pass to DM on a DM related
 ;trx. is recorded in the file 410 at this point for an approved 2237
 ;********************************************************************
 I $D(PRCVDM),PRCVDM=1 D EN^PRCVTAP(DA)
 ;
 ;  set record in 443, clean up 410, change cp uncommitted balance 
 ;  using TRANS^PRCSES, in 420
 D NOW^%DTC S PRCS=%
 S PRCSCP=$S($D(^PRC(420,PRC("SITE"),1,+PRC("CP"),0)):$P(^(0),U,12),1:"")
 N PPMFLG S:$D(PPMFLG1) PPMFLG=10
 L +^PRCS(410,DA):15 Q:$T=0
 S $P(^PRCS(410,DA,10),U,4)=$S(PRCSCP=1!(PRCHQ=1):$O(^PRCD(442.3,"C",10,0)),1:$O(^PRCD(442.3,"C",60,0))),$P(^(11),U,3)=""
 N ESTSHIP,COST S ESTSHIP=$P($G(^PRCS(410,DA,9)),"^",4),COST=$P($G(^PRCS(410,DA,4)),"^",8)
 N IJ F IJ=1,8 S $P(^PRCS(410,DA,4),"^",IJ)=ESTSHIP+COST
 K ^PRCS(410,"F",+PRCSN_"-"_+PRC("CP")_"-"_$P($P(PRCSN,U),"-",5),DA),^PRCS(410,"F1",$P($P(PRCSN,U),"-",5)_"-"_+PRCSN_"-"_+PRC("CP"),DA),^PRCS(410,"AQ",1,DA)
 S:'$D(^PRCS(410,DA,11)) ^(11)="" S $P(^(11),U,3)=""
 D ERS410^PRC0G(DA_"^A")
 ;
 S MESSAGE=""
 D ENCODE^PRCSC1(DA,DUZ,.MESSAGE)
 K MESSAGE
 S X=PRCST D TRANS^PRCSES
 ;
 S PRCSSCP=0 F PRCSSI=1:1 S PRCSSCP=$O(^PRCS(410,DA,12,PRCSSCP)) Q:PRCSSCP'>0  I $D(^PRCS(410,DA,12,PRCSSCP,0)) S X=$P(^(0),U,2) I X S DA(1)=DA,DA=PRCSSCP D TRANS^PRCSEZZ S DA=DA(1)
 K PRCSSCP,PRCSSI L -^PRCS(410,DA)
 ;PRC*5.1*186
 I $P(PRCSN,U,4)>1 D
 . S X=$P(PRCSN,U,1),DIC="^PRC(443,",DIC(0)="L",DLAYGO=443 D ^DIC K DIC,DLAYGO,X
 . S X=$O(^PRCD(442.3,"C",60,0)) S:PRCSCP=1 X=$O(^PRCD(442.3,"C",10,0))
 . S PRCSSTS=X
 . S DIE="^PRC(443,",DR="1.5////^S X=PRCSSTS" D ^DIE K DR,DIE,PRCSSTS
 . S $P(^PRC(443,DA,0),U,11)=$P(PRCSN,U,6)
 D EN2^PRCPWI
 S (PRCS,PRCPRIB)=DA,TRNODE(0)=0 D:PRCHQ=1 NODE^PRCS58OB(DA,.TRNODE)
TAG ;
 S PRCSDA=DA
 S D0=DA,PRCHQ=$S(PRCHQ=1:"QUE^PRCE58P2",PRCHQ=5:"DQ^PRCPRIB0",1:"QUE^PRCSP12"),PRCHQ("DEST")=$S(PRCSCP=1!(PRCHQ="QUE^PRCE58P2"):"F",1:"S") D ^PRCHQUE S DA=PRCSDA Q
 Q
PRT ;
 K IO("Q") S %ZIS("B")="HOME",%ZIS="MQ" D ^%ZIS Q:POP
 I $D(IO("Q")) S D0=$G(DA),ZTRTN=$S(PRCHQ=1:"QUE^PRCE58P2",PRCHQ=5:"DQ^PRCPRIB0",1:"^PRCSP12"),ZTSAVE("PRNTALL")="",ZTSAVE("DA")="",ZTSAVE("D0")="",ZTSAVE("PRC*")="",ZTSAVE("TRNODE*")="" D ^%ZTLOAD,^%ZISC Q
 I IO=IO(0) U IO D:PRCHQ=5 DQ^PRCPRIB0 D:PRCHQ=1 ^PRCE58P0 D:PRCHQ'=1&(PRCHQ'=5) ^PRCSD12 D ^%ZISC W:$Y>0 @IOF Q
 U IO D:PRCHQ=5 DQ^PRCPRIB0 D:PRCHQ=1 QUE^PRCE58P2 D:PRCHQ'=1&(PRCHQ'=5) ^PRCSP12 D ^%ZISC W:$Y>0 @IOF
 QUIT
