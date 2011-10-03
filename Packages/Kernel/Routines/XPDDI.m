XPDDI ;SFISC/RSD - Display an Install ; 29 Feb 96 13:10
 ;;8.0;KERNEL;**21**;Jul 10, 1995
EN1 ;print from Install file
 N DIC,D0,XPD,Y,Z
 S DIC="^XPD(9.7,",DIC(0)="AEMQZ" D ^DIC Q:Y'>0
 S D0=+Y,XPD("D0")="",Y="PNT^XPDDI",Z="Install File Print"
 D EN^XUTMDEVQ(Y,Z,.XPD)
 Q
 ;
PNT ;print a package
 N X,XPD,XPDDT,XPDI,XPDJ,XPD0,XPDPG,XPDQ,XPDUL
 Q:'$D(^XPD(9.7,D0,0))  S XPD0=^(0),XPDJ=$G(^(1)),XPDPG=1,$P(XPDUL,"-",IOM)="",XPDDT=$$HTE^XLFDT($H,"1PM")
 W:$E(IOST,1,2)="C-" @IOF D HDR
 W "STATUS: ",$$EXTERNAL^DILFD(9.7,.02,"",$P(XPD0,U,9)),?42,"DATE LOADED: ",$$EXTERNAL^DILFD(9.7,2,"",$P(XPD0,U,3))
 W !,"INSTALLED BY: ",$$EXTERNAL^DILFD(9.7,9,"",$P(XPD0,U,11))
 W !,"NATIONAL PACKAGE: ",$$EXTERNAL^DILFD(9.7,1,"",$P(XPD0,U,2))
 W !!,"INSTALL STARTED: ",$$EXTERNAL^DILFD(9.7,11,"",$P(XPDJ,U))
 W:$P(XPDJ,U,3) ?45,$P($$EXTERNAL^DILFD(9.7,17,"",$P(XPDJ,U,3)),"@",2),?65,$$DIFF($P(XPDJ,U,3),$P(XPDJ,U))
 ;XPD is start date/time
 S XPD=+$P(XPDJ,U)
 W !!,"ROUTINES:",?45,$P($$EXTERNAL^DILFD(9.7,12,"",$P(XPDJ,U,2)),"@",2),?65,$$DIFF($P(XPDJ,U,2),XPD),!
 ;XPD is the last complete time, it is also the next start time
 S XPDQ=0 S:$P(XPDJ,U,2) XPD=$P(XPDJ,U,2)
 I $O(^XPD(9.7,D0,"INI",1)) D
 .W !,"PRE-INIT CHECK POINTS:",! S XPDI=1
 .F  S XPDI=$O(^XPD(9.7,D0,"INI",XPDI)) Q:'XPDI  S X=^(XPDI,0) D  Q:XPDQ
 ..W $P(X,U),?45,$P($$EXTERNAL^DILFD(9.713,1,"",$P(X,U,2)),"@",2),?65,$$DIFF($P(X,U,2),XPD),!
 ..S XPDQ=$$CHK(4)
 .Q:XPDQ  S X=^XPD(9.7,D0,"INI",1,0)
 .W $P(X,U),?45,$P($$EXTERNAL^DILFD(9.713,1,"",$P(X,U,2)),"@",2),?65,$$DIFF($P(X,U,2),XPD),!
 .S XPDQ=$$CHK(4)
 Q:XPDQ
 I $O(^XPD(9.7,D0,4,0)) D
 .W !,"FILES:",! S XPDI=0
 .F  S XPDI=$O(^XPD(9.7,D0,4,XPDI)) Q:'XPDI  S X=^(XPDI,0) D  Q:XPDQ
 ..W $P($G(^DIC(+$P(X,U),0)),U),?45,$P($$EXTERNAL^DILFD(9.714,1,"",$P(X,U,2)),"@",2),?65,$$DIFF($P(X,U,2),XPD),!
 ..S XPDQ=$$CHK(4)
 Q:XPDQ
 I $O(^XPD(9.7,D0,"KRN","AC",0)) D
 .W ! S XPDI=0
 .F  S XPDI=$O(^XPD(9.7,D0,"KRN","AC",XPDI)) Q:'XPDI  S XPDJ=$O(^(XPDI,0)) D  Q:XPDQ
 ..Q:'$D(^XPD(9.7,D0,"KRN",XPDJ,0))  S X=^(0)
 ..Q:'$D(^DIC(XPDJ,0))#2  W $P(^(0),U)
 ..W ?45,$P($$EXTERNAL^DILFD(9.715,1,"",$P(X,U,2)),"@",2),?65,$$DIFF($P(X,U,2),XPD),!
 ..S XPDQ=$$CHK(4)
 Q:XPDQ
 I $O(^XPD(9.7,D0,"GLO",0)) D
 .W !,"GLOBALS:",! S XPDI=0
 .F  S XPDI=$O(^XPD(9.7,D0,"GLO",XPDI)) Q:'XPDI  S X=^(XPDI,0) D  Q:XPDQ
 ..W $P(X,U),?45,$P($$EXTERNAL^DILFD(9.718,1,"",$P(X,U,2)),"@",2),?65,$$DIFF($P(X,U,2),XPD),!
 ..S XPDQ=$$CHK(4)
 Q:XPDQ
 I $O(^XPD(9.7,D0,"INIT",1)) D
 .W !,"POST-INIT CHECK POINTS:",! S XPDI=1
 .F  S XPDI=$O(^XPD(9.7,D0,"INIT",XPDI)) Q:'XPDI  S X=^(XPDI,0) D  Q:XPDQ
 ..W $P(X,U),?45,$P($$EXTERNAL^DILFD(9.716,1,"",$P(X,U,2)),"@",2),?65,$$DIFF($P(X,U,2),XPD),!
 ..S XPDQ=$$CHK(4)
 .Q:XPDQ  S X=^XPD(9.7,D0,"INIT",1,0)
 .W $P(X,U),?45,$P($$EXTERNAL^DILFD(9.716,1,"",$P(X,U,2)),"@",2),?65,$$DIFF($P(X,U,2),XPD),!
 .S XPDQ=$$CHK(4)
 I $O(^XPD(9.7,D0,"VOL",0)) D
 .W !,"OTHER CPUs:",! S XPDI=0
 .F  S XPDI=$O(^XPD(9.7,D0,"VOL",XPDI)) Q:'XPDI  S X=^(XPDI,0) D  Q:XPDQ
 ..W $P(X,U),"  STARTED ",$P($$EXTERNAL^DILFD(9.703,2,"",$P(X,U,3)),"@",2)
 ..W ?45,$P($$EXTERNAL^DILFD(9.703,1,"",$P(X,U,2)),"@",2),?65,$$DIFF($P(X,U,2),$P(X,U,3)),!
 ..S XPDQ=$$CHK(4)
 Q:XPDQ
 I $O(^XPD(9.7,D0,"QUES",0)) D
 .W !,"INSTALL QUESTION PROMPT",?70,"ANSWER",! S XPDI=0
 .F  S XPDI=$O(^XPD(9.7,D0,"QUES",XPDI)) Q:'XPDI  S X=$P(^(XPDI,0),U),XPD=$G(^("A")),XPDJ=$G(^("B")) D  Q:XPDQ
 ..W !,X,"   ",XPD,?70,XPDJ
 ..S XPDQ=$$CHK(4)
 Q:XPDQ
 W !,"MESSAGES:",!
 S XPDI=0
 F  S XPDI=$O(^XPD(9.7,D0,"MES",XPDI)) Q:'XPDI  I $D(^(XPDI,0)) W ^(0),! S XPDQ=$$CHK(4) Q:XPDQ
 Q
 ;
CHK(Y) ;Y=excess lines, return 1 to exit
 Q:$Y<(IOSL-Y) 0
 I $E(IOST,1,2)="C-" D  Q:'Y 1
 .N DIR,I,J,K,X
 .S DIR(0)="E" D ^DIR
 S XPDPG=XPDPG+1
 W @IOF D HDR
 Q 0
 ;
DIFF(X,Y) ;returns diff of X-Y
 I 'X Q ""
 S XPD=X
 Q $$FMDIFF^XLFDT(X,Y,3)
 ;
HDR W !,"PACKAGE: ",$P(XPD0,U),"     ",XPDDT,?70,"PAGE ",XPDPG,!,?45,"COMPLETED",?65,"ELAPSED",!,XPDUL,!
 Q
