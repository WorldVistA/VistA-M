XQ31 ;SEA/AMF - MENU MANAGEMENT REPORTS ;09/30/94  10:07
 ;;8.0;KERNEL;;Jul 10, 1995
 W !!,"This option lists options by parents, as well as running several other menu",!,"management utilities. It can be run for one option, one package or all."
PKG R !!,"Select PACKAGE/OPTION name: ALL// ",X:DTIME S:'$T X=U S DIC=9.4,DIC(0)="EMZ" Q:X[U  S:'$L(X) X="ALL"
 I X="ALL" S XQS="@z",XQE="zzz" G PRNT
 D ^DIC I Y>0 S XQS=$P(Y(0),U,2),XQE=XQS_"zzz" G PRNT
 S DIC=19,DIC(0)="QEMZ" D ^DIC G:Y<0 PKG S XQE=$P(Y(0),U,1),XQS=$E(XQE,1,$L(XQE)-1)_$C($A($E(XQE,$L(XQE)))-1)_"zzz"
 ;
PRNT ;
 S %ZIS="MQ" D ^%ZIS G:POP OUT I $D(IO("Q")) K IO("Q") S ZTRTN="DQ1^XQ31",ZTDESC="DISPLAY PARENTS AND USES OF OPTIONS",ZTSAVE("XQS")="",ZTSAVE("XQE")="" D ^%ZTLOAD K ZTSK G OUT
 ;
DQ1 ; Entry point to list option parents and uses as a queued job
 K XQHDR S XQHDR(1)="CROSS REFERENCE OF OPTIONS BY PARENTS",XQHDR(2)="OPTION                         PARENTS                     TASKED JOB, PRIMARY",XQHDR(3)="                                                           OR SECONDARY MENU"
 S XQENT=1,$P(XQDSH,"-",132)="-" K ^TMP($J) U IO
 S XQP=1 D HDR,LP
OUT D ^%ZISC K XQUI,XQJ,XQS,XQE,XQK,XQLEN,XQNM,XQI,I,J,K,C,L,DIC,POP,X,XQDSH,XQENT,XQHDR,XQP,Y,ZISI,ZTDTH,ZTSAVE,ZTRTN,ZTDESC,%A1,S,XQFL
 Q
LP S XQUI=0,XQJ=XQS F  S XQJ=$O(^DIC(19,"B",XQJ)) Q:XQJ=""!XQUI!(XQJ]XQE)  D LP1
 Q
LP1 S XQI=0 F  S XQI=$O(^DIC(19,"B",XQJ,XQI)) Q:XQI'>0!XQUI  D LP2
 Q
LP2 S XQFL="" D:$Y+3>IOSL&XQENT NWPG Q:XQUI  W:XQENT !,XQJ,?31 I '$D(^DIC(19,"AD",XQI)) W:XQENT "** no parents **" G PRI
 K XQFL S (XQK,XQLEN,XQNM)=0
 I XQENT F  S XQK=$O(^DIC(19,"AD",XQI,XQK)) Q:XQK'>0  I $D(^DIC(19,XQK,0)) S L=$P(^DIC(19,XQK,0),U,1) S:XQLEN+$L(L)+2>34 XQLEN=0 W:'XQLEN&XQNM !?31 W:XQNM&XQLEN ", " W $P(^DIC(19,XQK,0),U,1) S XQLEN=XQLEN+$L(L)+2,XQNM=XQNM+1
PRI ;
 I $D(^VA(200,"AP",XQI)) W:XQENT ?65,"-P-" K XQFL
 I $D(^VA(200,"AD",XQI)) W:XQENT ?70,"-S-" K XQFL
 I $D(^DIC(19.2,"B",XQI)) D  ;Check Schedule file
 . N % S %=$O(^DIC(19.2,"B",XQI,0)) Q:%'>0
 . S %=$G(^DIC(19.2,%,0)) I $P(%,U,2)!$L($P(%,U,7)) W:XQENT ?75,"-T-" K XQFL
 I $D(XQFL) S ^TMP($J,XQI)=""
 Q
NWPG I $E(IOST,1)="C" D CON S XQUI=(X="^") Q:XQUI
 D HDR Q
CON W !!,"Press return to continue or '^' to escape " R X:DTIME S:'$T X=U
 Q
HDR W @IOF,!,XQHDR(1),?70,"PAGE ",XQP S XQP=XQP+1
 W:$D(XQHDR(2)) !!,XQHDR(2) W:$D(XQHDR(3)) !,XQHDR(3)
 W !,$E(XQDSH,1,IOM-1)
 Q
