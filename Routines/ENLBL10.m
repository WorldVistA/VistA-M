ENLBL10 ;(WASH ISC)/DH-Print Bar Coded Equipment Labels ;10.10.97
 ;;7.0;ENGINEERING;**12,35,45,90**;Aug 17, 1993;Build 25
PM ;Range of PM numbers
 S ENERR=0 D STA^ENLBL3 G:ENEQSTA="^" QUIT^ENLBL3
 N DIC,DIE,DA,DR,X,X1,X2,I,J,K,I1
PM1 S X="" R !,"Starting with: ",X:DTIME G:X=""!($E(X)="^") EXIT1^ENLBL8
 I $E(X)="?" D  G PM1
 . W !!,"Property Management (PM) numbers should consist of four numbers, followed",!,"by a dash (-), followed by four more numbers.  There may be an alphabetic"
 . W !,"at the end (for a grand total of ten characters), but there usually isn't."
 . W !!,"The first four numbers correspond to the Federal Supply Classification Code."
 . W !,"The next four numbers are assigned at the site, usually by the Property",!,"Management Section in A&MM."
 . W !!,"It is the intent of VACO Program Offices to phase out PM numbers in favor of",!,"the AEMS/MERS entry number, but no official timetable has been established.",!
 S FR=X I FR'?4N1"-"4N W !,"Doesn't look like a standard PM number. Are you sure",*7 S %=2 D YN^DICN G:%<0 EXIT1^ENLBL8 G:%=2 PM1 I %=0 W !,"PM #'s look like '7025-5001'." G PM1
 I FR=+FR S FR=FR_" "
PM2 S X="" R !,"and ending with: ",X:DTIME G:X="^"!(X="") EXIT1^ENLBL8 S TO=X I FR]TO W !!,"Your ending point does not follow your starting point. I'm confused.",*7 G PM1
 I TO'?4N1"-"4N W !,"Are you sure" S %=2 D YN^DICN G:%<0 EXIT1^ENLBL8 G:%=2 PM2 I %=0 W !,"PM numbers look like '7025-5001'." G PM2
 I '$D(^ENG(6914,"C",FR)) S I=$O(^ENG(6914,"C",FR)) I I]TO W !!,*7,"Sorry, but there doesn't appear to be any equipment in specified range." G PM1
 D EN^ENLBL9 I $D(DIRUT) G EXIT1^ENLBL8
 I '$D(ENEQIO),%<0 G EXIT1^ENLBL8
 S ENLOCSRT=1
PM21 W !,"Sort labels by LOCATION" S %=1 D YN^DICN G:%<0 EXIT1^ENLBL8 I %=0 W !,"Say YES to sort labels by DIVISION, BUILDING, then by ROOM.",!,"If you say NO, labels will be sorted by VA PM #." G PM21
 S:%=2 ENLOCSRT=0
 S %ZIS("A")="Select BAR CODE PRINTER: ",%ZIS("B")="",%ZIS="Q" I $D(ENEQIO),ENEQIO=IO S %ZIS=""
 K IO("Q") D ^%ZIS K %ZIS G:POP EXIT1^ENLBL8
 S ENBCIO=IO,ENBCIOSL=IOSL,ENBCIOF=IOF,ENBCION=ION,ENBCIOST=IOST,ENBCIOST(0)=IOST(0),ENBCIOS=IOS S:$D(IO("S")) ENBCIO("S")=IO("S")
 I $D(IO("Q")) K IO("Q") S ZTIO=ION,ZTRTN="PM3^ENLBL10",ZTSAVE("D*")="",ZTSAVE("EN*")="",ZTSAVE("FR")="",ZTSAVE("TO")="",ZTDESC="NX Barcode Labels by PM #" D ^%ZTLOAD K ZTSK G EXIT1^ENLBL8
PM3 S ENEQBY="PM # "_FR_" thru "_TO,ENBCIO=IO ;HD308658
 I $D(ENEQIO) D OPEN^ENLBL9 I POP G:$D(ZTQUEUED) REQ^ENLBL8 W !,*7,"Companion Printer UNAVAILABLE." D HOLD G EXIT1^ENLBL8
 K ^TMP($J) S I1=FR I $D(^ENG(6914,"C",FR)) S DA=$O(^ENG(6914,"C",FR,0)) D STATCK^ENLBL3 I DA]"" D:ENLOCSRT SORT^ENLBL3 I 'ENLOCSRT D PMNSRT
 F K=0:0 S I1=$O(^ENG(6914,"C",I1)) Q:I1=""!(I1]TO)  S DA=$O(^ENG(6914,"C",I1,0)) D STATCK^ENLBL3 I DA]"" D:ENLOCSRT SORT^ENLBL3 D:'(DA#10) DOTS^ENLBL3 I 'ENLOCSRT D PMNSRT
 I $D(^TMP($J)) U ENBCIO D FORMAT^ENLBL7 S I1="" F J1=0:0 S I1=$O(^TMP($J,I1)) Q:I1=""  F DA=0:0 S DA=$O(^TMP($J,I1,DA)) Q:DA'>0  U ENBCIO D NXPRT^ENLBL7 D:$D(ENEQIO) CPRNT^ENLBL9 D:'(DA#10) DOTS^ENLBL3 D BCDT^ENLBL7
 G EXIT^ENLBL8
 ;
PMNSRT S ^TMP($J,I1,DA)="" Q
HOLD W !,"Press <RETURN> to continue..." R X:DTIME
 Q
 ;ENLBL10
