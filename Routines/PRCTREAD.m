PRCTREAD ;WISC@ALTOONA/RGY,RFJ-READ DATA FROM BAR CODE READER ;6.29.98
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
READ ;  upload from portable bar code reader
 N PRCTCLOS,PRCTEOFF,PRCTEON,PRCTNOW,PRCTOPEN,PRCTTYPE,TIME
 D NOW^%DTC S PRCTNOW=%
 S PRCTID=+$O(^PRCT(446.4,0))
 I $P($G(^PRCT(446.4,PRCTID,0)),"^",8)<$P(PRCTNOW,".") D TASK^PRCTPRG
 W:'$D(IOP) !!,"Enter the device to which the bar code reader is connected.",! D ^%ZIS I POP D Q1 Q
 S PRCTEON=^%ZOSF("EON"),PRCTEOFF=^%ZOSF("EOFF"),PRCTTYPE=^%ZOSF("TYPE-AHEAD"),PRCTOPEN=$G(^%ZIS(2,IOST(0),10)),PRCTCLOS=$G(^%ZIS(2,IOST(0),11)) S:PRCTOPEN="" PRCTOPEN="W """"" S:PRCTCLOS="" PRCTCLOS="W """""
 U IO D OFF W !,">>> Use the TRANSMIT option on the barcode reader to start sending the data:"
 D ON
READ1 R X:30 I '$T D OFF W !,"    *** Error, NO data received from bar code reader within 30 seconds ***",!! G Q1
 G:X="" READ1
 D OFF W !,"    Thank You !  Data is being received ..." D ON
 S TIME=$P($H,",",2)
 ;strip off control characters
 S X=$TR(X,$C(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31))
 I X="" D OFF W !,"    *** Error, an identifier was not entered ***",!! G Q1
 S PRCTID=+$O(^PRCT(446.4,"C",X,"")) I '$D(^PRCT(446.4,+PRCTID,0)) D OFF W !,"    *** Error, bar code data identifier '",X,"' is non-existent ***",!! G Q1
 S X=PRCTNOW S:'$D(^PRCT(446.4,PRCTID,2,0)) ^(0)="^446.42DI^^" S DA(1)=PRCTID,DIC="^PRCT(446.4,"_PRCTID_",2,",DIC(0)="XL",DLAYGO=446.4 F Y=0:0 D ^DIC Q:$P(Y,"^",3)  S PRCTMIN=1,PRCTSD=X D ^PRCTTI S X=Y
 S PRCTTI=+Y,$P(^PRCT(446.4,PRCTID,2,+Y,0),"^",2,3)=DUZ_"^ATTEMPTING DATA UPLOAD",Y=$P(Y,"^",2) D DD^%DT
 D OFF W !!,"<<< Reading records for ",$P(^PRCT(446.4,PRCTID,0),"^"),",",!?14,"logged on ",Y," ..." D ON
 F Y=0:1 R X:10 S X=$TR(X,$C(10)) Q:$E(X,1,9)="***END***"!'$T  D
 . I X="" S Y=Y-1 Q  ; check for blank lines (Open-M problem)
 . S ^PRCT(446.4,PRCTID,2,PRCTTI,1,Y+1,0)=X
 ;clear buffer
 R %:1
 D OFF S ^PRCT(446.4,PRCTID,2,PRCTTI,1,0)="^^"_Y_"^"_Y_"^"_$P(PRCTNOW,".") W !,"    Data transmission complete, number of records read: ",Y
 W !!,"Upload time: "_($P($H,",",2)-TIME)_" sec."
 I Y'=$P(X,"^",2) W *7 S MES="REC" D ^PRCTMES1 S $P(^PRCT(446.4,PRCTID,2,PRCTTI,0),"^",3)="DATA UPLOAD FAILURE" G READ
 S $P(^PRCT(446.4,PRCTID,2,PRCTTI,0),"^",3)="DATA UPLOAD SUCCESSFUL"
 I $P(^PRCT(446.4,PRCTID,0),"^",3)]"" S X=$P(^(0),"^",3) D RTN^PRCTUTL,NORTN^PRCTMES1:'$D(X) S:'$D(X) $P(^PRCT(446.4,PRCTID,2,PRCTTI,0),"^",3)="POST UPLOAD RTN MISSING" G:'$D(X) Q1 D Q11 G @($P(X,"-")_"^"_$P(X,"-",2))
 W !!,"<<< Transmission of data successful! >>>",!,"    You can purge the files on the bar code reader if you wish.",! K ZTDTH D TASK
Q1 K PRCTID,PRCTTI
Q11 D ^%ZISC S IOP=ION D ^%ZIS K IOP,DIC,DA,DLAYGO,ZTSK,POP,%DT,D Q
TASK ;Tasks an appropriate barcode processor to taskman, needs PRCTID and PRCTTI
 ;If routine is PRCPBALM, process the data on line.
 ;If ZTDTH is undefined, time will be set automatically, If ZTDTH=-1, time will be asked or ZTDTH= valied $H or Fileman format
 S PRCT=$S('$D(PRCTID):0,$D(^PRCT(446.4,PRCTID,0))#2:^(0),1:0) I PRCT=0 W *7 D NONID^PRCTMES1 G Q3
 I $S('$D(PRCTTI):1,1:'$D(^PRCT(446.4,PRCTID,2,PRCTTI,0))#2) W *7 D NOTI^PRCTMES1 G Q3
 S %=$TR($P(PRCT,"^",4),"-","^") I %["PRCPBALM" D @% K %,X,Y,ZTDTH G Q3
 S ZTRTN="DEQUE^PRCTMAN",ZTIO="" I $P(PRCT,"^",6) D DEV G:POP Q3
 I '$D(ZTDTH) D NOW^%DTC S PRCT=$P(PRCT,"^",5),X=$S(PRCT="":"N",%#1>+("."_PRCT):"T+1@"_PRCT,1:"T@"_PRCT),%DT="XTR" D ^%DT S ZTDTH=Y
 K:ZTDTH<0 ZTDTH S (ZTSAVE("PRCTID"),ZTSAVE("PRCTTI"))="",ZTDESC="Barcode data processor"
 I '$D(ZTDTH) S %DT="XTRA",%DT("A")="Request time to process: ",%DT("B")="NOW" D ^%DT S ZTDTH=Y I Y<0 W !,"* Data will NOT be processed *",! S:$P(^PRCT(446.4,PRCTID,2,PRCTTI,0),"^",3)="DATA UPLOAD SUCCESSFUL" $P(^(0),"^",3)="NOT QUEUED" G Q3
 W !!,"OK, the data collected on " S Y=+$P(^PRCT(446.4,PRCTID,2,PRCTTI,0),"^") D DD^%DT W Y,!,"for ",$P(^PRCT(446.4,PRCTID,0),"^")," will be processed on "
 S Y=ZTDTH D DD^%DT W Y,! S $P(^PRCT(446.4,PRCTID,2,PRCTTI,0),"^",3)="TASKED FOR "_Y
 D ^%ZTLOAD
Q3 K PRCT,POP,PRCTID,PRCTTI Q
DEV ;
 W !,"QUEUE TO PRINT ON" S %ZIS="NQ" D ^%ZIS I 'POP S IOP=ION D ^%ZIS Q
 W *7 D NODEV^PRCTMES1 S X="Are you sure you do NOT want to select a device ?^N" D ENYN^PRCTQUES I X="^"!X S:$P(^PRCT(446.4,PRCTID,2,PRCTTI,0),"^",3)="DATA UPLOAD SUCCESSFUL" $P(^(0),"^",3)="DEVICE NOT SELECTED",POP=1 Q
 G DEV
OFF ;
 X PRCTCLOS,PRCTEON U IO(0) Q
ON ;
 X PRCTOPEN U IO X PRCTEOFF,PRCTTYPE Q
