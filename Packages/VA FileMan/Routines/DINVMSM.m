%ZOSV ;SFISC/AC - $View commands for MSM-PC/PLUS ;2:24 PM  1 Oct 1998
 ;;22.0;VA FileMan;;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
ACTJ() ;
 Q $S($$V3:$V($V(44)+168,-3,2),1:$V(168,-4,2))
AVJ() ;
 Q $S($$V3:$V($V(44)+94,-3,2)+1-$V($V(44)+168,-3,2),1:$V($V(3,-5),-3,0)-$V(168,-4,2))
T0 ; start RT clock
 I $$OSTYPE()'=1 S XRT0=$H Q
 S XRT0=$P($H,",")_","_($V(#46C,-3,4)*5.4925\1/100) Q
T1 ; store RT datum
 I $$OSTYPE()'=1 S ^%ZRTL(3,XRTL,+$H,$P($H,",",2))=XRT0 K XRT0 Q
 S ^%ZRTL(3,XRTL,+$H,XRTN,$V(#46C,-3,4)*5.4925\1/100)=XRT0 K XRT0 Q
JOBPAR ;
 S Y=$V(2,X,2) Q:'Y
 S Y=$ZU(Y#32,Y\32) Q
PROGMODE() ;
 Q $V(0,$J,2)#2
PRGMODE ;
 W ! S ZTPAC=$S('$D(^VA(200,+DUZ,.1)):"",1:$P(^(.1),U,5)),XUVOL=^%ZOSF("VOL")
 I ZTPAC]"" X ^%ZOSF("EOFF") R !,"PAC: ",X:60 X ^%ZOSF("EON") I X'=ZTPAC W "??",*7 Q
 K XMB,XMTEXT,XMY S XMB="XUPROGMODE",XMB(1)=DUZ,XMB(2)=$I D ^XMB:$L($T(^XMB)) D BYE^XUSCLEAN K ZTPAC,X,XMB
 X ^%ZOSF("UCI") S XUCI=Y,XQZ="PRGM^ZUA[MGR]",XUSLNT=1 D DO^%XUCI
 V 0:$J:$ZB($V(0,$J,2),1,7):2 S $ZE="PRGMODEX^%ZOSV" ABORT
PRGMODEX W !,"YOU ARE NOW IN PROGRAMMING MODE!",! S $ECODE=",<<PROG>>,"
 Q
 ;
SIGNOFF ;
 I 0
 ;I $V($V(44)+4,-3,2)\32768#2 Q
 Q
UCI ;
 S Y=$ZU(0) Q  ;X ^%ZOSF("UCI") Q
 ;
UCICHECK(X) ;
 N Y,I S Y="",$ZT="BADUCI^%ZOSV"
 I X["," S Y=$ZU($P(X,","),$P(X,",",2)),(X,Y)=$ZU($P(Y,","),$P(Y,",",2)) Q:Y]"" Y
 F I=1:1:64 G:$ZU(I)="" BADUCI Q:$ZU(I)=X!($P($ZU(I),",")=X)!(I=X)
 Q $ZU(I)
 ;
BADUCI Q ""
 ;
BAUD ;S Y=^%ZOSF("MGR"),X=$S($D(^%ZIS(1,D0,0)):$P(^(0),"^",2),1:"")
 ;Q:X=""  I '$D(^[Y]SYS(0,"DDB",+X)) S X="" Q
 ;S X=$P(^(+X),",",3)#100 Q:'X
 ;S X=$P("50,75,110,134.5,150,300,600,1200,1800,2400,3600,4800,9600",",",X) Q
 Q
 ;
LGR() Q $ZR ;Last global ref.
 ;
EC() Q $ZE ;Error code
 ;
DOLRO ;SAVE ENTIRE SYMBOL TABLE IN LOCATION SPECIFIED BY X
 S Y="%" F %=0:0 S Y=$O(@Y) Q:Y=""  S %=$D(@Y) S:%#2 @(X_"Y)="_Y) I %>9 S %X=Y_"(",%Y=X_"Y," D %XY^%RCR
 Q
 ;
ORDER ;SAVE PART OF SYMBOL TABLE IN LOCATION SPECIFIED BY X
 S (Y,Y1)=$P(Y,"*",1) I $D(@Y)=0 F %=0:0 S Y=$O(@Y) Q:Y=""!(Y[Y1)
 Q:Y=""  S %=$D(@Y) S:%#2 @(X_"Y)="_Y) I %>9 S %X=Y_"(",%Y=X_"Y," D %XY^%RCR
 F %=0:0 S Y=$O(@Y) Q:Y=""!(Y'[Y1)  S %=$D(@Y) S:%#2 @(X_"Y)="_Y) I %>9 S %X=Y_"(",%Y=X_"Y," D %XY^%RCR
 K %,X,Y,Y1 Q
 ;
PRIORITY ;
 Q:X>5  N %D,%P S %P=(X>5) D INT^%HL Q
 ;
PRIINQ() ;
 Q $S($V(20,$J,2):10,1:1)
PARSIZ ;
 S X=3 Q
 ;
NOLOG ;
 S Y=$S($$V3:"$V($V(44)+4,-3,2)",1:"$V(4,-4,2)")_"\64#2" Q
 ;
DEVOPN ;
 ;X=$J,Y=List of devices separated by a comma
 N %,%1,%I,%X
 S Y=""
 I $$V3 S %=$V($V(44)+10,-3,2),%1=$V($V(44)+8,-3,2)+$V(44),%=$V(%*5+%1)
 E  S %=$V(5,-5,0)
 F %I=1:1:255 S %X=$V(%+%I+%I,-3,2) I %X,%X#4=0,%X/4=X S Y=Y_%I_","
 Q
DEVOK ;
 ;X=Device $I, Y=0 if available, Y=Job # if owned,
 ;Y=-1 if device is undefined.
 G RES:$G(X1)="RES" I $E(X)="/"!($E(X)="\") S Y=0 Q
 I X=2 S Y=0 Q
 I X'?1.N!(X'>0!(X'<1024)) S Y=-1 Q
 N %
 I $$VERSION(1)["NT" D DVOPN Q
 ;
 I $$V3 S %=$V($V(44)+8,-3,2)+$V(44),%=$V($V($V(44)+10,-3,2)*5+%),Y=$V(%+X+X,-3,2),Y=$S(Y=0:0,Y#4=0:Y/4,1:-1)
 E  S %=$V(5,-5,0),Y=$V(%+X+X,-3,2),Y=$S(Y=0:0,Y#4=0:Y/4+$V(272,-4),1:-1)
 I 'Y D DVOPN Q
 S:Y=$J Y=0 Q
DVOPN S $ZT="DVERR",Y=0 Q:$D(%ZTIO)
 L:$D(%ZISLOCK) +@%ZISLOCK:60
 O X::$S($D(%ZISTO):%ZISTO,1:0) E  S Y=999 L:$D(%ZISLOCK) -@%ZISLOCK Q
 L:$D(%ZISLOCK) -@%ZISLOCK
 S Y=0 I '$D(%ZISCHK)!$S($D(%ZIS)#2:(%ZIS["T"),1:0) C X Q
 S:X]"" IO(1,X)="" Q
DVERR I $ZE["OPENERR" S Y=-1 L:$D(%ZISLOCK) -@%ZISLOCK Q
 I $ZE["<NODEV>" S Y=-1 L:$D(%ZISLOCK) -@%ZISLOCK Q
 ZQ
RES S Y=0,%ZISD0=$O(^%ZISL(3.54,"B",X,0))
 I '%ZISD0 S Y=-1,%ZISD0=%O(^%ZIS(1,"C",X)) Q:'%ZISD0  Q:'$D(^%ZIS(1,+%ZISD0,0))  Q:$P(^(0),"^")'=X  Q:'$D(^("TYPE"))  Q:^("TYPE")'="RES"  S Y=0 Q
 S X1=$S($D(^%ZISL(3.54,+%ZISD0,0)):^(0),1:"")
 I $P(X1,"^",2)&(X=$P(X1,"^")) S Y=0 Q
 S Y=999 F %ZISD1=0:0 S %ZISD1=$O(^%ZISL(3.54,%ZISD0,1,%ZISD1)) Q:%ZISD1'>0  I $D(^(%ZISD1,0)) S Y=$P(^(0),"^",3) Q
 K %ZISD0,%ZISD1
 Q
V2CL1 F %=0:0 Q:$ZA<0  R %X:5 Q:%X']""  F %1=0:0 S %1=$L(%Y),%Y=%Y_$E(%X,1,255-%1),%X=$E(%X,256-%1,$L(%X)),%1=$F(%Y,%ZCR) Q:%1'>0  S %2=$E(%Y,$A(%Y)=10+1,%1-2),%Y=$E(%Y,%1,$L(%Y)) D V2CL2
 I %Y]"" S %2=$E(%Y,$A(%Y)=10+1,$L(%Y)) D V2CL2
 C 2:256 K IO(1,2) D CLOSE^ZISPL1 K %Y,%X,%1,ZOSFV
 Q
V2CL2 S %1=$F(%2,$C(12)) I %1>0 S %=%+1 D LIMIT:%Z1<% Q:%Z1<%  S ^XMBS(3.519,XS,2,%,0)="|TOP|",%2=$E(%2,1,%1-2)_$E(%2,%1,$L(%2))
 S %=%+1,^XMBS(3.519,XS,2,%,0)=%2 Q
 ;
LIMIT S ^XMBS(3.519,XS,2,%,0)="*** INCOMPLETE REPORT  -- SPOOL DOCUMENT LINE LIMIT EXCEEDED ***",$P(^XMB(3.51,%ZDA,0),"^",11)=1 Q
 ;
SET ;SET SPECIAL VARIABLES
 S DT=$$HTFM^DILIBF($H,1)
 Q
GETENV ;Get enviroment  (UCI^VOL^NODE)
 S Y=$P($ZU(0),",",1)_"^"_$P($ZU(0),",",2)_"^^"_$P($ZU(0),",",2)
 Q
VERSION(X) ;return OS version, X=1 - return OS
 Q $S($G(X):$P($ZV,"Version "),1:$P($ZV,"Version ",2))
V3() ;returns 1=version 3, 0=version 4
 Q $P($ZV,"Version ",2)<4
OSTYPE() ;Return 1 = PC/PLUS, 2 = NT, 3 = UNIX
 N % S %=$$VERSION(1)
 Q $S(%["MSM-PC/PLUS":1,%["Windows NT":2,1:3)
 ;
SETNM(X) ;Set name, Fall into SETENV
SETENV ;Set enviroment
 Q
ZHDIF ;Display dif of two $$ZH^%MSMOPS's
 S U="^" W !?2,"CPU=",$J($P(%ZH1,U)-$P(%ZH0,U),6,2),?14,"ET=",$J($P(%ZH1,U,7)-$P(%ZH0,U,7),6,2),?25,"PRD=",$J($P(%ZH1,U,3)-$P(%ZH0,U,3),4),?35,"LRD=",$J($P(%ZH1,U,2)-$P(%ZH0,U,2),6),?47,"LWT=",$J($P(%ZH1,U,4)-$P(%ZH0,U,4),5)
 W ?58,"TI=",$J($P(%ZH1,U,5)-$P(%ZH0,U,5),4),?67,"TO=",$J($P(%ZH1,U,6)-$P(%ZH0,U,6),5)
 Q
LOGRSRC(OPT) ;record resource usage in ^XUCP
 Q:$$OSTYPE'=1
 D RO^%ZOSVKR(OPT)
 Q
SETTRM(X) ;Set specified terminators.
 U $I:(::::::::X)
 Q 1
