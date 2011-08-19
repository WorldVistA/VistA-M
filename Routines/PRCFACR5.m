PRCFACR5 ;WISC@ALTOONA/CTB-RETRANSMIT CODE SHEETS TO AUSTIN ;2/19/93  08:17
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
OUT K %,N,I,%DT,%H,%Y,DIC,DIJ,ER,A,B,C,DQTIME,FAIL,POP,POK,PTR,PTRN,PBAT,PBATN,PFLAG,PRCFRT,X,X1,XMDUZ,XMKK,XMLOCK,XMR,XMSUB,XMT,XMTEXT,IOX,IOY,XMZ,Y Q
RT ;ENTRY POINT TO RETRANSMIT A BATCH
 W !!,"This option is designed to RERELEASE a batch.  You may not do original releases",!,"using this option."
 S:'$D(PRCFASYS) PRCFASYS="FEEFENIRSCLICLM" S PRCF("X")="AS" D ^PRCFSITE G:'% OUT
 S PRCF("X")="AS" D NOW^PRCFQ S PRCFKEY=%_"-"_DUZ
 D ES^PRCFACR G:$D(FAIL) OUT K POK,^PRCF(421.2,"AD",PRCFKEY) S DIC("A")="Select Batch Number: " I $D(^PRCF(423,"AK",PRCFKEY)) D SET I %<0 W "  <Option Aborted>",$C(7) G OUT
 K ^PRCF(423,"AD",PRCFKEY)
RT1 S PRCFRT=3,DIC=421.2,DIC(0)="AEMQZ",DIC("S")="S XXX=^(0) I $P(XXX,U,4)]"""",$P(XXX,U,3)=""B"",PRCFASYS[$P(XXX,""-"",2)"
 D ^DIC K DIC,XXX I Y<0,'$D(POK) S X=" <No Action Taken>*" D MSG^PRCFQ G OUT
 G:Y<0 ^PRCFACR0 S PBAT=$P(Y,U,2),PBATN=+Y,^PRCF(421.2,"AD",PRCFKEY,PBATN)="",$P(^PRCF(421.2,PBATN,0),"^",15)=PRCFKEY
 W !,$C(7) S %A="I will now RERELEASE batch "_PBAT_" to Austin.",%A(1)="ARE YOU SURE YOU WANT TO DO THIS",%B="",%=2 D ^PRCFYN G OUT:%<0 I %=2 S X=" <No Action Taken>*" D MSG^PRCFQ
 I %=1 S X="  <Batch has been Rereleased to Austin>*" D MSG^PRCFQ W !
 S POK="",DIC("A")="Select Next Batch Number: " G RT1
 Q
SET ;
 W $C(7),!!,"There appears to be Code Sheets transmitting at this time.  Please try",!,"again in 30 minutes.",!!
 S %A="Try later",%B="",%=1 D ^PRCFYN I %=1 S %=-1 Q
 S %A="Do you want to overide transmission at this time",%B="",%=2 D ^PRCFYN I %'=1 S %=-1 Q
 S %=1 Q
