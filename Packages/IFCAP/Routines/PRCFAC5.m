PRCFAC5 ;WISC/CTB-REPRINT A BATCH OR TRANSMISSION ;1/9/92  4:00 PM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 S PRCFASYS=""
EN S X="This option will reprint code sheets.  You will have the option of reprinting individual batches or all batches within a certain Transmission Number." D MSG^PRCFQ
 S PRCF("X")="AS" D ^PRCFSITE G:'% OUT
 D NOW^%DTC S PRCFKEY=%_"-"_DUZ
A R !!,"Do you wish to reprint by Batch or Transmission number?  (B/T) T//",X:$S($D(DTIME):DTIME,1:60) Q:'$T!(X["^")  G:X=""!("Tt"[$E(X,1)) T G:"Bb"[$E(X,1) B
 W ! S X="If you respond with a 'B', you will be required to enter the full Batch Number of each Batch that you wish to reprint.  A 'T', will cause ALL batches within the Transmission to be reprinted automatically.*"
 D MSG^PRCFQ W ! G A
B ;
 S DIC("A")="Select Batch Number: ",RT=0 K ^PRCF(423,"AM",PRCFKEY)
B1 S DIC=421.2,DIC(0)="AEMQZ",DIC("S")="S XXX=^(0) I $E($P(XXX,U,3),1)=""B"",PRCFASYS[$P(XXX,""-"",2),+XXX=PRC(""SITE"")" D ^DIC K DIC,XXX G:Y<0&('$D(POK)) OUT G:Y<0 QUE S PBAT=$P(Y,U,2) D BLIST
 S POK="",DIC("A")="Select Next Batch Number: " G B1
T ;
 S DIC("A")="Enter Transmission Number: ",RT=0 K ^PRCF(423,"AM",PRCFKEY)
T1 S DIC=421.2,DIC(0)="AMEQZ",DIC("S")="S XXX=^(0) I $E($P(XXX,U,3),1)=""T"",PRCFASYS[$P(XXX,""-"",2),+XXX=PRC(""SITE"")" D ^DIC K DIC,XXX G:Y<0&('$D(POK)) OUT G:Y<0 QUE S PTR=$P(Y,"^",2),PTRN=+Y
 S K=0 F I=1:1 S K=$O(^PRCF(421.2,PTRN,1,K)) Q:+K=0  S PBAT=^(K,0) W !,"Processing Batch # ",PBAT D BLIST
 S POK="",DIC("A")="Select Next Transmission Number: " G T1
QUE I '$D(^PRCF(423,"AM",PRCFKEY)) W !!,"NO BATCHES SELECTED  OPTION ABORTED",$C(7) G OUT
 S ZTRTN="SE^PRCFAC5",ZTSAVE("PRCFKEY")="",ZTSAVE("PRCFASYS")="",ZTDESC="REPRINT A "_$S(PRCFASYS["IRS":"IRS",PRCFASYS["ISM":"ISM",1:"LOG")_" BATCH" D ^PRCFQ I $D(NODEV) K ^PRCF(423,"AM","Y"),NODEV
OUT K %,N,I,%DT,%H,%Y,DIC,DIJ,ER,A,B,C,DQTIME,FAIL,POP,POK,PTR,PTRN,PBAT,PBATN,PRCFKEY,RT,X,X1,XMDUZ,XMKK,XMLOCK,XMR,XMSUB,XMT,XMTEXT,IOX,IOY,XMZ,Y Q
FAIL1 S FAIL="" Q
BLIST I '$D(^PRCF(421.2,"B",PBAT)) Q
 I $D(^PRCF(423,"AD",PBAT)) S N=0 F I=1:1 S N=$O(^PRCF(423,"AD",PBAT,N)) Q:N'=+N  S ^PRCF(423,"AM",PRCFKEY,N)="",$P(^PRCF(423,N,"TRANS"),"^",13)=PRCFKEY W "."
 Q
SE D:$D(ZTQUEUED) KILL^%ZTLOAD
 D NOW^PRCFQ S IOP=$S($D(ION):ION,1:IO),DIC="^PRCF(423,",L=0,BY="[PRCFA BATCH REPRINT SORT]",FLDS="[PRCFA REPRINT TRAILER]",(FR,TO)=PRCFKEY D EN1^DIP
 F I=1:1 S N=$O(^PRCF(423,"AM",PRCFKEY,0)) Q:'N  S $P(^PRCF(423,N,"TRANS"),"^",13)="" K ^PRCF(423,"AM",PRCFKEY,N)
 K %,%DT,%I,BATCH,BATTYPE,DP,I,J,K,L,M,N,PRCFX,PRCFKEY,PTYP,X,Y,Z1,Z2
 Q
