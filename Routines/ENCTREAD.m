ENCTREAD ;(WASH ISC)/RGY,RFJ-Upload Data from Bar Code Reader ;3.23.99
 ;;7.0;ENGINEERING;**9,35,54**;Aug 17, 1993
READ ;
 N TIME
 D NOW^%DTC S ENCTNOW=%
 I $P(^($O(^PRCT(446.4,0)),0),"^",8)<$P(ENCTNOW,".") D TASK^ENCTPRG
 W:'$D(IOP) !!,"Enter the device to which the bar code reader is connected.",! D ^%ZIS G:POP Q1
 S ENCTEON=^%ZOSF("EON"),ENCTEOFF=^%ZOSF("EOFF"),ENCTTYPE=^%ZOSF("TYPE-AHEAD"),ENCTOPEN=$G(^%ZIS(2,IOST(0),10)),ENCTCLOS=$G(^%ZIS(2,IOST(0),11))
 U IO D OFF W !,">>> Use the TRANSMIT option on the bar code reader to start sending data:"
 D ON R X:30 I '$T D OFF W !!,"*** Error, Timeout period expired ...",!,"... No data is being received from bar code reader ***",!! G Q1
 D OFF W !,"    Thank you.  Data is being received..."
 S TIME=$P($H,",",2)
 S X=$TR(X,$C(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31)) ;strip control chars
 I X="" W *7,!,"*** Error, an identifier was not uploaded ***",!! G Q1
 S ENCTID=+$O(^PRCT(446.4,"C",X,"")) I '$D(^PRCT(446.4,+ENCTID,0)) W !!,"*** Error, bar code data identifier '",X,"' is non-existent ***",!! G Q1
 S X=ENCTNOW
 S:'$D(^PRCT(446.4,ENCTID,2,0)) ^(0)="^446.42DI^^" S DA(1)=ENCTID,DIC="^PRCT(446.4,"_ENCTID_",2,",DIC(0)="XL",DLAYGO=446.42 F Y=0:0 D ^DIC Q:$P(Y,"^",3)  S ENCTMIN=1,ENCTSD=X D ^ENCTTI S X=Y
 S ENCTTI=+Y,$P(^PRCT(446.4,ENCTID,2,+Y,0),"^",2,3)=DUZ_"^ATTEMPTING DATA UPLOAD",Y=$P(Y,"^",2) X ^DD("DD")
 W !!,"OK, You are logging data on ",Y," ...",!," ... using the BARCODE program ",$P(^PRCT(446.4,ENCTID,0),"^"),!!,"Reading barcode reader ..."
 D ON F Y=0:1 R X:10 S X=$TR(X,$C(10)) Q:$E(X,1,9)="***END***"!'$T  D
 . I X="" S Y=Y-1 Q  ;  check for blank lines (Open-M problem)
 . S ^PRCT(446.4,ENCTID,2,ENCTTI,1,Y+1,0)=X D DOTS
 R %:1 ;clear buffer
 D OFF S ^PRCT(446.4,ENCTID,2,ENCTTI,1,0)="^^"_Y_"^"_Y_"^"_$P(ENCTNOW,".") W !,"Data transmission complete. Number of records read: ",Y
 W !!,"Upload time: "_($P($H,",",2)-TIME)_" sec."
 I Y'=$P(X,"^",2) W *7 S MES="REC" D ^ENCTMES1 S $P(^PRCT(446.4,ENCTID,2,ENCTTI,0),"^",3)="DATA UPLOAD FAILURE" G READ K ^(1) G READ
 S $P(^PRCT(446.4,ENCTID,2,ENCTTI,0),"^",3)="DATA UPLOAD SUCCESSFUL"
 I $P(^PRCT(446.4,ENCTID,0),"^",3)]"" S X=$P(^(0),"^",3) D RTN^ENCTUTL,NORTN^ENCTMES1:'$D(X) S:'$D(X) $P(^PRCT(446.4,ENCTID,2,ENCTTI,0),"^",3)="POST UPLOAD RTN MISSING" G:'$D(X) Q1 D Q11 G @($P(X,"-")_"^"_$P(X,"-",2))
 W !!,"*** OK, transmission of data successful !",!,"You can purge the files on the barcode reader if you wish.",! K ZTDTH D TASK
Q1 K ENCTID,ENCTTI
Q11 D ^%ZISC
 K DIC,DA,DLAYGO,ZTSK,POP,ENCTCLOS,ENCTEOFF,ENCTEON,ENCTNOW,ENCTOPEN,ENCTTYPE
 Q
 ;
TASK ;Tasks an appropriate processor routine, needs ENCTID and ENCTTI
 ;If ZTDTH is undefined, time will be set automatically, If ZTDTH=-1, time will be asked.
 S ENCT=$S('$D(ENCTID):0,$D(^PRCT(446.4,ENCTID,0))#2:^(0),1:0) I ENCT=0 W *7 D NONID^ENCTMES1 G Q3
 I $S('$D(ENCTTI):1,1:'$D(^PRCT(446.4,ENCTID,2,ENCTTI,0))#2) W *7 D NOTI^ENCTMES1 G Q3
 S ZTRTN="DEQUE^ENCTMAN",ZTIO="" I $P(ENCT,"^",6) D DEV G:POP Q3
 I '$D(ZTDTH) D NOW^%DTC S ENCT=$P(ENCT,"^",5),X=$S(ENCT="":"N",%#1>+("."_ENCT):"T+1@"_ENCT,1:"T@"_ENCT),%DT="XTR" D ^%DT S ZTDTH=Y
 K:ZTDTH<0 ZTDTH S (ZTSAVE("ENCTID"),ZTSAVE("ENCTTI"))="",ZTDESC="Barcode data processor"
 I '$D(ZTDTH) S %DT="XTRA",%DT("A")="Request time to process: ",%DT("B")="NOW" D ^%DT S ZTDTH=Y I Y<0 W !,"* Data will NOT be processed *",! S:$P(^PRCT(446.4,ENCTID,2,ENCTTI,0),"^",3)="DATA UPLOAD SUCCESSFUL" $P(^(0),"^",3)="NOT QUEUED" G Q3
 W !!,"OK, the data collected on " S Y=+$P(^PRCT(446.4,ENCTID,2,ENCTTI,0),"^") X ^DD("DD") W Y,!,"for ",$P(^PRCT(446.4,ENCTID,0),"^")," will be processed on "
 S Y=ZTDTH X ^DD("DD") W Y,! S $P(^PRCT(446.4,ENCTID,2,ENCTTI,0),"^",3)="TASKED FOR "_Y
 D ^%ZTLOAD
Q3 K ENCT,POP,ENCTID,ENCTTI,ZTDTH,ZTDESC,ZTRTN,ZTSAVE,ZTSK,ZTIO Q
DEV ;
 W !,"QUEUE TO PRINT ON" S %ZIS="NQ" D ^%ZIS I 'POP S ZTIO=IO,IOP=ION D ^%ZIS Q
 W *7 D NODEV^ENCTMES1 S X="Are you sure you do NOT want to select a device ?^N" D ENYN^ENCTQUES I X="^"!X S:$P(^PRCT(446.4,ENCTID,2,ENCTTI,0),"^",3)="DATA UPLOAD SUCCESSFUL" $P(^(0),"^",3)="DEVICE NOT SELECTED",POP=1 Q
 G DEV
DOTS ;Act ind
 I IO=IO(0) D OFF
 U IO(0) W "." U IO
 I IO=IO(0) D ON
 Q
 ;
ON ;
 X ENCTOPEN U IO X ENCTEOFF,ENCTTYPE
 Q
OFF ;
 X ENCTCLOS,ENCTEON U IO(0)
 Q
 ;ENCTREAD
