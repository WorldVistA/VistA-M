PRCSP1C1 ;SF/LJP-CONTROL POINT ACTIVITY PRINT OPTIONS CON'T ;4-26-94/3:45 PM
V ;;5.1;IFCAP;**101**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
SUB ;BUDGET OBJECT CODE TOTALS
 D EN1^PRCSUT G W1:'$D(PRC("SITE")),EXIT:Y<0 W ! S %ZIS="MQ" D ^%ZIS G EXIT:POP I $D(IO("Q")) S ZTRTN="SUB1^PRCSP1C1",ZTSAVE("DUZ")="",ZTSAVE("PRC*")="" D ^%ZTLOAD,EXIT,W2 G SUB
SUB1 K T S (N,Z1)="",(T("COM"),T("OBL"),P)=0 D SUB2
 U IO D SUBHD W !,"BUDGET OBJECT CODE TOTALS",! S X="",$P(X,"-",18)="" W X S N=""
 S S=0 F I=0:1 S S=$O(T("S",S)) Q:S'>0  S PRC("SUB")=^PRCD(420.2,+S,0),PRC("SUB")=$P(PRC("SUB"),"^") W !,$E(PRC("SUB"),1,60),?70,$J(T("S",S),10,2) I IOSL-$Y<6 D HOLD Q:Z1[U  D SUBHD
 G SUB:Z1[U I 'I W !!,"There are no transactions for this control point for the station and time frame",!,"you selected."
 I IOSL-($Y#IOSL)<6 D HOLD Q:Z1[U  D SUBHD
 I I S X="",$P(X,"-",38)="" W !,X W !,"TOTAL OBLIGATED (ACTUAL) COST: ",?70,$J(T("OBL"),10,2),!,"TOTAL COMMITTED (ESTIMATED) COST: ",?70,$J(T("COM"),10,2)
 I I S REPORT2=1 D T2^PRCSAPP1 K REPORT2
 I $D(ZTSK) D KILL^%ZTLOAD K ZTSK G EXIT
 D W,W2 G SUB
SUB2 S N1=PRC("SITE")_"-"_PRC("FY")_"-"_PRC("QTR")_"-"_$P(PRC("CP")," "),N2=N1_"-0000"
S1 S N2=$O(^PRCS(410,"B",N2)) Q:$P(N2,"-",1,4)'=N1
 S N3=0,N3=$O(^PRCS(410,"B",N2,N3)) G S1:'N3
 G S1:'$D(^PRCS(410,N3,0)),S1:$P(^(0),U,2)'="O"
 I $P(^PRCS(410,N3,0),"^",4)=1 D CALC2 G S2
 S N4=0 F I=0:0 S N4=$O(^PRCS(410,N3,"IT",N4)) Q:N4'>0  I $D(^(N4,0)) S X=^(0) I $P(X,U,4)]"",+$P(X,U,2),+$P(X,U,7) D CALC
 G S2
CALC ;
 S S=$P(X,U,4),SA=$P(X,U,2)*$P(X,U,7)
 I $D(^PRCS(410,N3,"IT",N4,3)) S AMT=$P($G(^(0)),"^")-$P($G(^(0)),"^",2),SA=AMT
 S:'$D(T("S",+S)) T("S",+S)=0 S T("S",+S)=T("S",+S)+SA,T("OBL")=T("OBL")+SA Q
CALC2 ; Changes to include 1358s begin here
 N AA,BB,PRCTMP
 S PRCTMP=^PRCS(410,N3,3) F AA=6,8 S BB=AA+1 I $P(PRCTMP,"^",AA),$P(PRCTMP,"^",BB) D
 .S S=$P(PRCTMP,"^",AA),SA=$P(PRCTMP,"^",BB)
 .I '$D(T("S",+S)) S T("S",+S)=0
 .S T("S",+S)=T("S",+S)+SA,T("OBL")=T("OBL")+SA
 K AA,BB,PRCTMP
 Q
S2 S:$D(^PRCS(410,N3,4)) T("COM")=T("COM")+$P(^(4),U,1)
 G S1
SUBHD S P=P+1 W @IOF,!!,"BUDGET OBJECT CODE TOTALS REPORT",?50 D NOW^%DTC S Y=% D DD^%DT W Y,?73,"PAGE ",P
 W !,"STATION ",PRC("SITE"),", ",PRC("QTR")_$S(PRC("QTR")=1:"ST",PRC("QTR")=2:"ND",PRC("QTR")=3:"RD",1:"TH")," QUARTER, FY",PRC("FY")," ,CONTROL POINT ",PRC("CP")
 S L="",$P(L,"-",IOM)="-" W !,L Q
HOLD Q:$D(ZTQUEUED)  Q:IO'=IO(0)  W !,"Press return to continue, uparrow (^) to exit: " R Z1:DTIME S:'$T Z1=U Q
W1 W !!,"You are not an authorized control point user.",!,"Contact your control point official." R X:5 G EXIT
W2 W !!,"Enter information for another report or an uparrow to return to the menu.",! Q
W I '$D(ZTQUEUED),IO'=IO(0) U IO(0) W !!,"Press return to continue:  " R X:DTIME
 I (IO'=IO(0))!($D(ZTQUEUED)) D ^%ZISC
 I (IO=IO(0))!($D(ZTQUEUED)) D ^%ZISC
EXIT K IO("Q"),S,SA,%,%DT,%ZIS,I,J,L,N,N1,N2,N3,N4,P,PRCS,T,X,Y,Z1,ZTRTN,ZTSAVE,PRC("SUB") Q
