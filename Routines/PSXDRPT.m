PSXDRPT ;BIR/WPB-Duplicate Rx Report ;09/09/98  6:46 AM
 ;;2.0;CMOP;**18,38**;11 Apr 97
ALRT S ST=$$KSP^XUPARAM("INST")
 ;N X,Y S X=ST,DIC=4,DIC(0)="MNZ" S:$D(^PSX(552,"D",X)) X=$E(X,2,99) D ^DIC S SITE=$S($G(Y)]"":$P(Y,"^",2),1:"UNKNOWN") K X,Y,DIC ;****DOD L1
 N X,Y S X=ST,AGNCY="VASTANUM" S:$D(^PSX(552,"D",X)) X=$E(X,2,99),AGNCY="DMIS" S SITE=$$IEN^XUMF(4,AGNCY,X),SITE=$S($G(SITE)]"":$$NAME^XUAF4(SITE),1:"UNKNOWN") K X,Y,AGNCY ;****DOD L1
 S LN=$L(SITE),LEN=((80-LN)/2)+1,XQAKILL=0
 I '$D(^PSX(552.3,"AD")) W !,"There are no duplicate Rx's in the file!" G EXIT
 S %ZIS="Q" D ^%ZIS G EXIT:POP
 I $D(IO("Q")) D  Q
 .S ZTRTN="STRT^PSXDRPT",ZTSAVE("LEN")="",ZTSAVE("SITE")="",ZTDESC="CMOP Duplicate Rx Report" D ^%ZTLOAD,HOME^%ZIS K IO("Q") Q
 ;Called by Taskman to run Duplicate Rx report
STRT I '$D(^PSX(552.3,"AD")) W !,"There are no duplicate Rx's in the file!" G EXIT
 D HDR,EN
 Q
HDR U IO W @IOF
 W !,?30,"Duplicate Rx Report",!,?LEN,SITE,!
 W !,"Rx #",?16,"Query #",?27,"Completed Time",?44,"Orig Qry",?56,"Orig Completed Time",!
 F I=0:1:79 W "-"
 S LCNT=7
 Q
EN S (CNT,XX)=0 F  S XX=$O(^PSX(552.3,"AD",XX)) Q:XX'>0  G:$G(STOP) EXIT S LAST=XX D
 .I $P(^PSX(552.3,XX,0),"|",1)["ZMP" S QRY1="MAN" D
 ..S RX=$P(^PSX(552.3,XX,0),"|",3),BATREF=$P(^PSX(552.3,XX,0),"|",2),C1=$P(^PSX(552.3,XX,0),"|",7),C2=$P($$FMTE^XLFDT(C1,"2S"),":",1,2)
 ..S P5521=$O(^PSX(552.1,"B",BATREF,"")),P5524=$O(^PSX(552.4,"B",P5521,"")),PRX=$O(^PSX(552.4,P5524,1,"B",RX,""))
 ..I $P(^PSX(552.4,P5524,1,PRX,0),"^",2)'="" S QRY2="MAN",CMDT=$P($G(^PSX(552.4,P5524,1,PRX,0)),"^",9) S CNT=CNT+1 D
 ...W !,RX,?16,$J(QRY1,7),?27,C2,?44,$J(QRY2,8),?56,$P($$FMTE^XLFDT(CMDT,"2S"),":",1,2) S LCNT=LCNT+1
 ..I ($G(LCNT)>22&($G(IOST)["C-")) S DIR(0)="E" D ^DIR K DIR S:$G(Y)'=1 STOP=1 Q:$G(STOP)  D HDR
 ..I ($G(LCNT)>60&($G(IOST)'["C-")) D HDR
 ..K RX,BAT,BATREF,P5521,P5524,PRX,QRY2,CMDT,C2,C1
 .I $G(^PSX(552.3,XX,0))["QRD|" S QRY1=$P(^PSX(552.3,XX,0),"|",5),PSXTS=$P(^PSX(552.3,XX,0),"|",2) D TSIN^PSXUTL S QRYTM=PSXFM K PSXTS,PSXFM
 .I $G(^PSX(552.3,XX,0))["NTE|99" D
 ..S RX=$P($P(^PSX(552.3,XX,0),"\",1),"|",4),BAT=$P(^PSX(552.3,XX,0),"\F\",6),BATREF=$P(BAT,"-",1,2),C1=$P(^PSX(552.3,XX,0),"\",5),C2=$E(C1,5,6)_"/"_$E(C1,7,8)_"/"_$E(C1,3,4)_"@"_$E(C1,9,10)_":"_$E(C1,11,12)
 ..S P5521=$O(^PSX(552.1,"B",BATREF,"")),P5524=$O(^PSX(552.4,"B",P5521,"")),PRX=$O(^PSX(552.4,P5524,1,"B",RX,""))
 ..I $P(^PSX(552.4,P5524,1,PRX,0),"^",2)'="" S QRY2=$P($G(^PSX(552.4,P5524,1,PRX,0)),"^",8),CMDT=$P($G(^PSX(552.4,P5524,1,PRX,0)),"^",9) S CNT=CNT+1 D
 ...W !,RX,?16,$J($G(QRY1),7),?27,C2,?44,$J(QRY2,8),?56,$P($$FMTE^XLFDT(CMDT,"2S"),":",1,2) S LCNT=LCNT+1
 ..I ($G(LCNT)>22&($G(IOST)["C-")) S DIR(0)="E" D ^DIR K DIR S:$G(Y)'=1 STOP=1 Q:$G(STOP)  D HDR
 ..I ($G(LCNT)>60&($G(IOST)'["C-")) D HDR
 .K RX,BAT,BATREF,P5521,P5524,PRX,QRY2,CMDT,C2,C1
 I IOST'["C-" D ^%ZISC G EXIT
ASK S DIR(0)="Y",DIR("A")="Delete these Rx's",DIR("B")="YES",DIR("??")="Yes - deletes the duplicate Rx's from the CMOP Release file.",DIR("??",1)="No - Will not delete the duplicate Rx's from the CMOP Release file."
 D ^DIR K DIR G:($G(Y)=1) DEL
EXIT K XX,CNT,QRY1,QRYTM,LEN,ST,SITE,LN,I,LCNT,LINE,DIR,X,Y,STOP
 S:$D(ZTQUEUED) ZTREQ="@" Q
DEL S ZX=0,DIE="^PSX(552.3,",DR="1////1" F  S ZX=$O(^PSX(552.3,"AD",ZX)) Q:ZX>$G(LAST)!(ZX'>0)  L +^PSX(552.3,ZX):600 Q:'$T  S DA=ZX D ^DIE L -^PSX(552.3,ZX) K DA
 K ZX,LAST,DA,DIE,DR
 G EXIT
RESET S CC=0,DIE="^PSX(552.3,",DR="1////2" F  S CC=$O(^PSX(552.3,"AF",CC)) Q:CC'>0  L +^PSX(552.3,CC) S DA=CC D ^DIE L -^PSX(552.3,CC) K DA
 Q
