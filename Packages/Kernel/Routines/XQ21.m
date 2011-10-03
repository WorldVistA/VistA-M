XQ21 ;MJM/SEA ;9/14/94  11:10
 ;;8.0;KERNEL;;Jul 10, 1995
 ;
USER ;This routine is called by the XUUSERDISP option.
USERN ;
 I '$D(IOF) S IOP="" D ^%ZIS K IOP
 S $P(XQDSH,"-",41)="-"
 S XQI="",IORV="""""",IORVX="""""" I $D(IOST(0)) S:$D(^%ZIS(2,IOST(0),5)) XQI=^(5) S:$L($P(XQI,U,4)) IORV=$P(XQI,U,4) S:$L($P(XQI,U,5)) IORVX=$P(XQI,U,5)
 I '$D(DTIME) S DTIME=$S('$D(^VA(200,DUZ,200)):"",1:$P(^(200),U,10)) I '$L(DTIME) S DTIME=$S('$D(^%ZIS(1,$I,"XUS")):"",1:$P(^("XUS"),U,10)) I '$L(DTIME) S DTIME=$P(^XTV(8989.3,1,"XUS"),U,10)
 I '$D(ION) S %ZIS="N0",IOP="HOME" D ^%ZIS
 W @IOF,!,@IORV,$P(^VA(200,DUZ,0),U,1),@IORVX,"  (#",DUZ,")",?30,"DEVICE: ",@IORV,ION,@IORVX,"  ($I: ",$I,")",?65,"JOB: ",@IORV,$J,@IORVX
 W !!,"ENVIRONMENT",?40,"ATTRIBUTES",!,$E(XQDSH,1,11),?40,$E(XQDSH,1,11)
 S XQX="N" I $D(^VA(200,DUZ,200)) S XQX=$P(^(200),U,9) S:'$L(XQX) XQX="N"
 W !?3,"Site ........ ",^DD("SITE"),?43,"Type-ahead ....... ",XQX
 S Y="unknown" I $D(^%ZOSF("UCI")) X ^("UCI")
 W !?3,"UCI ......... ",Y,?43,"Time-out ......... ",DTIME
 S XQX="unknown" I $D(^VA(200,DUZ,1.1)) S XQX=$P(^(1.1),".",2)
 W !?3,"Signed on ... ",$E(XQX,1,2)_":"_$E(XQX,3,4),?43,"Fileman code(s) .. ",DUZ(0)
 I $D(IOST)#10 W !?3,"Terminal type ",IOST
 I $D(^VA(200,DUZ,51)) W !!,"KEYS HELD",!,$E(XQDSH,1,9) S %=-1 F XQX=0:0 S XQX=$O(^VA(200,DUZ,51,XQX)),%=%+1 Q:XQX'>0  W:'(%#5) ! W ?(%#5*15+3),$P(^DIC(19.1,XQX,0),U,1)
HOW I $D(^XUTL("XQ",$J,"T")),^("T")>0 W !!,"MENU PATH",!,$E(XQDSH,1,9) F XQX=1:1:^XUTL("XQ",$J,"T") W !,?XQX-1*2,$P(^(XQX),U,3)," (",$P(^(XQX),U,2),")"
 W !!,"'^' to escape, <CR> to view Mailman user info: " R X:DTIME S:'$T X=U I '$L(X) S Y=DUZ W @IOF D EN^XMA7
 ;
OUT ;Clean up
 K %,XQDSH,XQI,XQX,Y
 Q
 ;
DISP ;Code brought over from old XQ2.  Not called anywhere that I know of.
 S XQDIC=D0,XQUR="?." S X=^DIC(19,D0,0) I $P(X,U,4)="M" W !,"Menu: " S XQL=999 D M6^XQ2,LIST^XQ2 W ! S X="" K D Q
 I $P(X,U,4)="A" S X="Action: "_$S($D(^DIC(19,D0,20)):^(20),1:"") W !?3,X,! Q
 I $P(X,U,4)="R" S X="Run routine: "_$S($D(^DIC(19,D0,25)):^(25),1:"") W !?3,X,! Q
 I $P(X,U,4)="E" S X="Edit file: "_$S($D(^DIC(19,D0,50)):^(50),1:"") W !?3,X,! Q
 I $P(X,U,4)="P" S X="Print file "_$S($D(^DIC(19,D0,60)):^(60),1:"") W !?3,X,! Q
 Q
