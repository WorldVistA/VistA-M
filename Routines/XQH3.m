XQH3 ;LL/THM,SEA/AMF,JLI -HELP FRAME XREF BY PARENT ;9/29/92  15:13 ;5/13/93  11:27 AM
 ;;8.0;KERNEL;;Jul 10, 1995
PKG R !!,"Select PACKAGE name: ALL// ",X:DTIME S:'$T X=U S DIC=9.4,DIC(0)="QEMZ" Q:X[U  S:'$L(X) X="ALL"
 I X="ALL" S XQS="@z",XQE="zzz" G SLIST
 D ^DIC G:Y<0 PKG S XQS=$P(Y(0),U,2),XQE=XQS_"zzz"
SLIST ;LIST PARENTS AND ORPHANS
 S %ZIS="MQ" D ^%ZIS Q:POP  I $D(IO("Q")) K IO("Q") G QUE
DQ ; Entry point for queued job
 U IO
 K ^TMP($J) S XQI=0 D S0 S XQS=0 D S3
 D:$D(^TMP($J)) S6
KILL K XQI,XQK,XQJ,XQL,XQE,XQS,XQDSH,XQN,%DT,%H,%ZIS,%T,DIC,X,XQP,Y,^TMP($J)
 D ^%ZISC
 Q
 ;
S0 ;
 S XQS=$O(^DIC(9.2,"B",XQS)) Q:XQS]XQE!(XQS="")  D S1 G S0
S1 ;
 S XQI=$O(^DIC(9.2,"B",XQS,XQI)) Q:XQI=""  S ^TMP($J,XQS,0)=XQI,XQJ=0 D S2 G S1
S2 ;
 S XQJ=$O(^DIC(9.2,XQI,2,XQJ)) Q:+XQJ<1  S XQK=$P(^(XQJ,0),U,2) G:'$L(XQK) S2 I '$D(^DIC(9.2,XQK,0)) W !,*7,"HELP FRAME ",XQS," POINTS TO HELP FRAME ",XQK," WHICH DOES NOT EXIST " G S2
 S XQL=$P(^DIC(9.2,XQK,0),U,1)
 I '$D(^TMP($J,XQL,"K")) S ^("K")=1,^TMP($J,XQL,1)=XQS G S2
 S XQN=^TMP($J,XQL,"K")+1,^("K")=XQN,^TMP($J,XQL,XQN)=XQS G S2
S3 ;
 S XQI=0,XQL=1,XQS=$O(^TMP($J,XQS)) Q:XQS=""  G:'$D(^(XQS,0)) S3 S XQJ=^(0) D:$D(^DIC(19,"AC",XQJ)) S4 S XQI=0,XQL=1 D:$D(^DIC(9.2,XQJ,3)) S5 G S3
S4 ;
 S XQI=$O(^DIC(19,"AC",XQJ,XQI)) Q:XQI=""  S XQK=$P(^DIC(19,XQI,0),U,1)
 S $P(^TMP($J,XQS,XQL),U,2)=XQK,XQL=XQL+1 G S4
S5 ;
 S XQI=$O(^DIC(9.2,XQJ,3,XQI)) Q:XQI=""  S XQK=^(XQI,0)
 S $P(^TMP($J,XQS,XQL),U,3)=XQK,XQL=XQL+1 G S5
S6 ;
 S XQDSH="---------------------------------------------------------------------------------------------------------------------------"
 S XQP=1 D HDR S (XQS,XQUI)=0 D SL
 D ^%ZISC
 K XQUI Q
SL S XQS=$O(^TMP($J,XQS)) Q:XQS=""  D:$Y+3>IOSL NWPG Q:XQUI  W XQS
 I '$D(^TMP($J,XQS,1)) W ?28,"** no parents **",!
 F XQJ=1:1 Q:'$D(^TMP($J,XQS,XQJ))  S XQK=^(XQJ) W ?28,$S('$L($P(XQK,U,1)):"** no parents **",1:$P(XQK,U,1)),?56,$P(XQK,U,2),?72,$P(XQK,U,3),!
 G SL
NWPG ;
 I $E(IOST,1)="C" D CON S XQUI=(X="^") Q:XQUI
 D HDR Q
CON ;
 W !,"Press return to continue or '^' to escape " R X:DTIME S:'$T X=U
 Q
HDR W @IOF,!,"CROSS REFERENCE OF HELP FRAMES BY PARENTS",?70,"PAGE ",XQP S XQP=XQP+1
 W !!,"HELP",?28,"PARENTS",?56,"MENU",?71,"INVOKING"
 W !,"FRAME",?56,"OPTIONS",?71,"ROUTINES"
 W !,$E(XQDSH,1,IOM-1),!
 Q
 ;
QUE ; Queue job to run later
 S ZTRTN="DQ^XQH3",ZTSAVE("XQS")="",ZTSAVE("XQE")="",ZTDESC="HELP FRAME XREF BY PARENT" D ^%ZTLOAD K ZTSAVE,ZTSK,ZTRTN,ZTDESC
 G KILL
