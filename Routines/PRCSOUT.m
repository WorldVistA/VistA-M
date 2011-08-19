PRCSOUT ;WISC/KMB-OUTSTANDING APPROVED REQUESTS REPORT ;1-24-94  13:06
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
START ;
 N PAGE,XDA,I,J,LL,OUT,OUT1,LOOP,LOOP1,LOOP2,TODAY,TODAY1 S (OUT,OUT1,I)=1,(LOOP1,LOOP2,PAGE)=0
 S (OUT,OUT1,I)=1,(LOOP1,LOOP2,PAGE)=0
 W @IOF D EN1^PRCSUT G W1:'$D(PRC("SITE")),EXIT:Y<0
PROCESS ;
 W @IOF D NOW^%DTC S TODAY=$P(%,"."),Y=% D DD^%DT S TODAY1=Y
 W !,"Processing entries...",!
 S LOOP=PRC("SITE")_"-"_PRC("FY")_"-"_PRC("QTR")_"-"_$P(PRC("CP")," "),LOOP1=LOOP_"-0000"
 F I=0:1 S LOOP1=$O(^PRCS(410,"B",LOOP1)) Q:$P(LOOP1,"-",1,4)'=LOOP  D
 .S LOOP2=0 F  S LOOP2=$O(^PRCS(410,"B",LOOP1,LOOP2)) Q:LOOP2=""  S XDA=LOOP2 D
 ..N ZEROTH,FIRST,SECOND,THIRD,FOURTH,FIFTH,SIXTH
 ..S FIFTH=$P($G(^PRCS(410,XDA,1)),"^",4) Q:FIFTH>TODAY
 ..S FIRST=$P($G(^PRCS(410,XDA,7)),"^",5) Q:FIRST=""
 ..Q:$P($G(^PRCS(410,XDA,0)),"^",2)'["O"
 ..S ZEROTH=$P($G(^PRCS(410,XDA,0)),"^"),SECOND=$P($G(^PRCS(410,XDA,9)),"^",2),THIRD=$P($G(^PRCS(410,XDA,2)),"^",1),FOURTH=$P($G(^PRCS(410,XDA,4)),"^",4)
 ..S SIXTH=$P($G(^PRCS(410,XDA,4)),"^",5)
 ..S ^TMP($J,I)=FIRST_"*"_SECOND_"*"_THIRD_"*"_FOURTH_"*"_FIFTH_"*"_SIXTH_"*"_ZEROTH_"*"_XDA
 I '$D(^TMP($J)) U IO(0) W !,"No outstanding transactions found for this quarter.",! G START
WRITE ;
 S %ZIS("B")="HOME",%ZIS="MQ" D ^%ZIS G EXIT:POP
 S ZTSAVE("PRC*")="",ZTSAVE("OUT")="",ZTSAVE("I")="",ZTSAVE("TODAY1")="",ZTSAVE("PAGE")=""
 I IO'=IO(0) S OUT1=0
 I $D(IO("Q")) S ZTDESC="REQUEST REPORT",ZTRTN="WRITE1^PRCSOUT",ZTSAVE("OUT1")="",ZTSAVE("DA")="",ZTSAVE("^TMP($J,")="",ZTSAVE("D0")="" D ^%ZTLOAD D ^%ZISC,EXIT,WRITE2 G START
 D WRITE1 D ^%ZISC,EXIT,WRITE2 G START
WRITE1 ;
 U IO D HEADER F K=1:1:I-1 I $G(^TMP($J,K))'="" D
 .Q:OUT=U  D:IOSL-($Y#IOSL)<6 HOLD Q:OUT=U
 .W !,?2,$P(^TMP($J,K),"*",7)
 .S D0=$P(^TMP($J,K),"*",8) D:D0'="" STATUS^PRCSES W ?22,$E(X,1,25)
 .W ?50,$E($P(^TMP($J,K),"*",3),1,30)
 .W ! S Y=$P(^TMP($J,K),"*") D DD^%DT W Y
 .S Y=$P(^TMP($J,K),"*",2) D DD^%DT W ?15,Y
 .W ?35,$P(^TMP($J,K),"*",6)
 .S Y=$P(^TMP($J,K),"*",4) D DD^%DT W ?50,Y
 .S Y=$P(^TMP($J,K),"*",5) D DD^%DT W ?65,Y
 I $D(ZTSK) D KILL^%ZTLOAD K ZTSK
 Q
WRITE2 ;
 U IO(0) W !!,"------------------",!,"End of processing",! H 2 Q
W1 W !!,"You are not an authorized control point user.",!,"Please contact your control point official." R I:5 G EXIT
HEADER ;
 S PAGE=PAGE+1
 I PAGE'=1 W @IOF
 W !,"OUTSTANDING APPROVED REQUEST REPORT - CP ",$P(PRC("CP")," "),?49,TODAY1,?72,"PAGE ",PAGE
 W !!,"TRANSACTION NUMBER",?22,"TRANSACTION STATUS",?50,"VENDOR"
 W !,"DATE SIGNED",?15,"EST. DEL. DATE",?35,"PO #",?50,"DATE OBL.",?65,"DATE REQ."
 S LL="",$P(LL,"-",IOM)="-" W !,LL S LL="" Q
HOLD ;
 G HEADER:IO'=IO(0),HEADER:$D(ZTQUEUED) W !,"Press return to continue, uparrow (^) to exit: " R OUT:100 S:'$T OUT=U D:OUT'=U HEADER Q
EXIT K ^TMP($J),PRCS Q
