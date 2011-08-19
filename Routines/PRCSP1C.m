PRCSP1C ;WISC/SAW-CONTROL POINT ACTIVITY PRINT OPTIONS CON'T ;3-25-91/13:05 
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
CCT ;COST CENTER TOTALS
 D EN4^PRCSUT G W1:'$D(PRC("SITE")),EXIT:Y<0 W ! S %ZIS="MQ" D ^%ZIS G EXIT:POP I $D(IO("Q")) S ZTRTN="CCT1^PRCSP1C",ZTSAVE("DUZ")="",ZTSAVE("PRC*")="" D ^%ZTLOAD,HOME^%ZIS,EXIT,W2 G CCT
CCT1 K T S (N,Z1)="",(T("T",1),T("T",2),T("T",3),P)=0 F I=1:1 S N=$O(^PRC(420,"A",DUZ,PRC("SITE"),N)) Q:N=""  I $O(^(N,0))<3 S (T(N,1),T(N,2),T(N,3))=0 D CCT2
 U IO D CCHD S N="" F I=0:1 S N=$O(T(N)) Q:N'>0  S PRC("CP")=$S($D(^PRC(420,PRC("SITE"),1,N,0)):$P(^(0),"^"),1:""),T("T",1)=T("T",1)+T(N,1),T("T",2)=T("T",2)+T(N,2),T("T",3)=T("T",3)+T(N,3) D CCPR I IOSL-$Y<6 D HOLD Q:Z1[U  D CCHD
 G CCT:Z1[U I 'I W !!,"There are no transactions for this cost center for the station and time frame",!,"you selected."
 I IOSL-($Y#IOSL)<6 D HOLD G CCT:Z1[U D CCHD
 I I W !!,"TOTALS FOR ALL CONTROL POINTS" S X="",$P(X,"-",29)="" W !,X D CCPR1
 I $D(ZTSK) D KILL^%ZTLOAD K ZTSK G EXIT
 D W,W2 G CCT
CCT2 S N(1)=PRC("SITE")_"-"_PRC("FY")_"-"_PRC("QTR")_"-"_$S($L(N)=1:"00"_N,$L(N)=2:0_N,1:N)
 S N(2)="" F J=0:1 S N(2)=$O(^PRCS(410,"AE",N(1),N(2))) Q:N(2)=""  I $D(^PRCS(410,N(2),3)),$P($P(^(3),U,3)," ")=$P(PRCS("CC")," "),$D(^PRCS(410,N(2),4)) S X=^(4),T(N,1)=T(N,1)+$P(X,"^"),T(N,2)=T(N,2)+$P(X,"^",3),T(N,3)=T(N,3)+$P(X,"^",8)
 K:T(N,1)+T(N,2)+T(N,3)=0 T(N) Q
CCPR W !!,"CONTROL POINT: ",PRC("CP"),! S X="",$P(X,"-",$L(PRC("CP"))+15)="" W X Q
CCPR1 W !,"TOTAL COMMITTED (ESTIMATED) COST: ",$J(T(N,1),9,2),!,"TOTAL OBLIGATED (ACTUAL) COST:    ",$J(T(N,2),9,2),!,"TOTAL (BEST ESTIMATE) COST:       ",$J(T(N,3),9,2),! Q
CCHD S P=P+1 W @IOF,!!,"COST CENTER TOTALS REPORT",?50 D NOW^%DTC S Y=% D DD^%DT W Y,?73,"PAGE ",P
 W !,"STATION ",PRC("SITE"),", ",PRC("QTR")_$S(PRC("QTR")=1:"ST",PRC("QTR")=2:"ND",PRC("QTR")=3:"RD",1:"TH")," QUARTER, FY",PRC("FY")
 S L="",$P(L,"-",IOM)="-" W !,L S L=""
 W !!,"COST CENTER: ",PRCS("CC") Q
HOLD Q:$D(ZTQUEUED)  Q:IO'=IO(0)  W !,"Press return to continue, uparrow (^) to exit: " R Z1:DTIME S:'$T Z1=U Q
W1 W !!,"You are not an authorized control point user.",!,"Contact your control point official." R X:5 G EXIT
W2 W !!,"Enter information for another report or an uparrow to return to the menu.",! Q
W I '$D(ZTQUEUED),IO'=IO(0) U IO(0) W !!,"Press return to continue:  " R X:DTIME
 I (IO'=IO(0))!($D(ZTQUEUED)) D ^%ZISC
 I (IO=IO(0))!($D(ZTQUEUED)) D ^%ZISC
EXIT K %,%DT,%ZIS,I,J,L,N,P,PRCS,T,X,Y,Z1,ZTRTN,ZTSAVE Q
