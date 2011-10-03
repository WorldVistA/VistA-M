XQUSR ;MJM/SEA Display User Chracteristics XUUSERDISP ;01/30/2001  14:00
 ;;8.0;KERNEL;**169**;Jul 10, 1995
USER ;
USERN ;
 N XQA
 I '$D(IOF) S IOP="" D ^%ZIS K IOP
 S XQPAGE=$S($D(IOSL):IOSL-2,1:18),XQLINE=9
 S $P(XQDSH,"-",41)="-"
 S I="",IORV="""""",IORVX="""""" I $D(IOST(0)) S:$D(^%ZIS(2,IOST(0),5)) I=^(5) S:$L($P(I,U,4)) IORV=$P(I,U,4) S:$L($P(I,U,5)) IORVX=$P(I,U,5)
 I '$D(DTIME) S DTIME=$S('$D(^VA(200,DUZ,200)):"",1:$P(^(200),U,10)) I '$L(DTIME) S DTIME=$S('$D(^%ZIS(1,$I,"XUS")):"",1:$P(^("XUS"),U,10)) I '$L(DTIME) S DTIME=$P(^XTV(8989.3,1,"XUS"),U,10)
 I '$D(ION) S %ZIS="N0",IOP="HOME" D ^%ZIS
 W @IOF,!,@IORV,$P(^VA(200,DUZ,0),U,1),@IORVX,"  (#",DUZ,")",?30,"DEVICE: ",@IORV,ION,@IORVX,"  ($I: ",$I,")",?65,"JOB: ",@IORV,$J,@IORVX
 W !!,"ENVIRONMENT",?40,"ATTRIBUTES",!,$E(XQDSH,1,11),?40,$E(XQDSH,1,11)
 S X="N" I $D(^VA(200,DUZ,200)) S X=$P(^(200),U,9) S:'$L(X) X="N"
 W !?3,"Site ........ ",^DD("SITE"),?43,"Type-ahead ....... ",X
 S Y="unknown" I $D(^%ZOSF("UCI")) X ^("UCI")
 W !?3,"UCI ......... ",Y,?43,"Time-out ......... ",DTIME
 S X="unknown" I $D(^VA(200,DUZ,1.1)) S X=$P(+^(1.1),".",2)
 W !?3,"Signed on ... ",$E(X,1,2)_":"_$E(X,3,4),?43,"Fileman code(s) .. ",DUZ(0)
 I $D(IOST)#10 W !?3,"Terminal type ",IOST
 ;Show the Person Class
 W !!,"Person Class: " D SHPC^XUSER1(DUZ)
 I $D(^VA(200,DUZ,51)) D
 . W !!,"KEYS HELD",!,$E(XQDSH,1,9)
 . D GKEYS^XUSER1(DUZ,.XQA),SHLIST^XUSER1(.XQA,3,4) S:$D(DIRUT) XQUPAR=1 K DIRUT
 .Q
 Q:$D(XQUPAR)
 D HOW
 W !!,"Enter '^' to escape, <CR> to view Mailman user info: " R X:DTIME S:'$T X=U I '$L(X) S Y=DUZ W @IOF D EN^XMA7
 ;
 K %,%Y,X,XQDSH,XQLINE,XQPAGE,XQUPAR,Y
 Q
 ;
HOW S:'$D(XQDSH) $P(XQDSH,"-",21)="-" W !!,"MENU PATH",!,$E(XQDSH,1,9)
 I '$D(^XUTL("XQ",$J,"T")) W !?5,"==>  No User stack in ^XUTL." Q
 S XQLINE=XQLINE+2 I XQLINE'<XQPAGE D PAUSE Q:$D(XQUPAR)  S XQLINE=0
 F Z=1:1:^XUTL("XQ",$J,"T") Q:$D(XQUPAR)  D
 .W !,?Z-1*2,$P(^(Z),U,3)," (",$P(^(Z),U,2),")"
 .S XQLINE=XQLINE+1 I XQLINE'<XQPAGE D PAUSE S XQLINE=0
 .Q
 Q
 ;
TIME ;
 D ^XQDATE W "   "_%Y
 Q
 ;
PAUSE ;Hold the screen
 N XQ I 1
 R !!,"Hit RETURN or ENTER to continue or ""^"" to halt: ",XQ:DTIME
 I '$T S XQ=U
 I XQ=U S XQUPAR=""
 Q
