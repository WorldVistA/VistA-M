PRCFACR ;WISC/CTB/CLH-RELEASE CODE SHEETS TO AUSTIN ;4/30/93  3:04 PM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 S PRCFASYS="CLM"
SE W !,"This option will release code sheets to the VADATS system for transmission",!,"to the Austin DPC.  You will have the option of releasing individual batches",!,"or all batches within a certain Transmission Number."
 S PRCF("X")="AS" D ^PRCFSITE G:'% OUT
 D NOW^%DTC S PRCFKEY=%_"-"_DUZ
A W !!,"Do you wish to release by Batch or Transmission number?  (B/T) T//" R X:$S($D(DTIME):DTIME,1:60)
 I '$T!(X["^") G OUT
 I X=""!("Tt"[$E(X)) G T
 I "Bb"[$E(X) G B
 W !!,"If you respond with a 'B', you will be required to enter the full Batch Number",!,"of each Batch that you wish to release to Austin.  A 'T', will cause",!,"ALL batches within the Transmission to be released automatically.",!! G A
QUE I '$D(^PRCF(421.2,"AD",PRCFKEY)) W !!,"NO BATCHES SELECTED  OPTION ABORTED",$C(7) G OUT
 S ZTSAVE("PRCFRT")="",ZTSAVE("PRCFASYS")="",ZTSAVE("PRCFKEY")="",ZTRTN="^PRCFACR1",ZTDESC="TRANSMIT "_$S(PRCFASYS["LOG":"LOG",PRCFASYS["ISM":"ISM",1:"")_" CODE SHEETS" D ^PRCFQ G OUT
B D ES G OUT:$D(FAIL)
 S DIC("A")="Select Batch Number: ",PRCFRT=0
B1 S DIC=421.2,DIC(0)="XAEMQZO",DIC("S")="S XXX=^(0) I $P(XXX,U,4)="""",$P(XXX,U,3)=""B"",PRCFASYS[$P(XXX,""-"",2),+XXX=PRC(""SITE"")"
 D ^DIC K DIC,XXX G:Y<0&('$D(POK)) OUT G:Y<0 QUE
 S PBAT=$P(Y,U,2),PBATN=+Y S $P(^PRCF(421.2,PBATN,0),"^",15)=PRCFKEY,^PRCF(421.2,"AD",PRCFKEY,PBATN)=""
 S POK="",DIC("A")="Select Next Batch Number: " G B1
T D ES G OUT:$D(FAIL) K POK
 S DIC("A")="Enter Transmission Number: ",PRCFRT=0
T1 S DIC=421.2,DIC(0)="XAMEQZO",DIC("S")="S XXX=^(0) I $P(XXX,U,4)="""",$E($P(XXX,U,3),1)=""T"",PRCFASYS[$P(XXX,""-"",2),+XXX=PRC(""SITE"")"
 D ^DIC K DIC,XXX G:Y<0&('$D(POK)) OUT G:Y<0 QUE
 S PTR=$P(Y,"^",2),PTRN=+Y
 S ^PRCF(421.2,"AD",PRCFKEY,PTRN)="",$P(^PRCF(421.2,PTRN,0),"^",15)=PRCFKEY
 S K=0 F I=1:1 S K=$O(^PRCF(421.2,PTRN,1,K)) Q:+K=0  S PBAT=^(K,0) W !,"Processing Batch # ",PBAT D T3
 S POK="",DIC("A")="Select Next Transmission Number: " G T1
T3 S:$D(^PRCF(421.2,"B",PBAT)) PBATN=$O(^PRCF(421.2,"B",PBAT,0))
 I $P(^PRCF(421.2,PBATN,0),"^",4)="" S $P(^(0),"^",15)=PRCFKEY,^PRCF(421.2,"AD",PRCFKEY,PBATN)="" Q
 S X="Batch "_PBAT_" has already been released/scheduled for release.  No action has been taken on this batch.*" D MSG^PRCFQ
 Q
OUT K %,N,I,%DT,%H,%Y,DIC,DIJ,ER,A,B,C,DQTIME,FAIL,POP,POK,PTR,PTRN,PBAT,PBATN,PFLAG,PRCFRT,X,X1,XMDUZ,XMKK,XMLOCK,XMR,XMSUB,XMT,XMTEXT,IOX,IOY,XMZ,Y Q
ES ;
ES1 N MESSAGE S MESSAGE=""
 D ESIG^PRCUESIG(DUZ,.MESSAGE)
 ;S ^ZZTOMF($H,"TOM9.5",$J,DT,0)="TOM NEEL TESTING - DVA"_U_DUZ_U_"YOU HIT ES1^PRCFACR AND DID ESIG^PRCUESIG"_U_"MESSAGE = "_MESSAGE_U
 G:(MESSAGE=0)!(MESSAGE=-3) FAIL
 G:(MESSAGE=-1)!(MESSAGE=-2) FAIL1
 Q
FAIL S FAIL="" W !,$C(7),"  SIGNATURE CODE FAILURE " R X:3 Q
FAIL1 S FAIL="" Q
