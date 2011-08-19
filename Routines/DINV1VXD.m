ZOSV1VXD ;SFISC/AC - View commands & special functions(continued). ;1:05 PM  30 Sep 1998
 ;;22.0;VA FileMan;;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
DEVOPN ;List devices opened.
 N %,%B,%I,%L,%X,%X1,%X2,%Y
 S %X1=$V($V(0)+8),%X2=$V(%X1),Y=""
 F %I=1:1 D D1 S %X2=$V(%X2) Q:%X2=%X1
 Q
D1 S %X=$V(%X2+8)
 S %L=$V(%X+4,-1,1),%B=$V(%X+8)
 S %Y=""
 F %=1:1:%L S %Y=%Y_$C($V(%B,-1,1)) S %B=%B+1
 S Y=Y_%Y_"," Q
 ;
DEVOK ;Check Device Availability.  (not complete)
 ;INPUT:  X=Device $I, X1=IOT -- X1 needed for resources
 ;OUTPUT: Y=0 if available, Y=job # if owned, Y=-1 if device does not exists.
 S Y=0 Q:X["::"  I $G(X1)="RES" G RES
 S Y=$ZC(%GETDVI,X,"EXISTS")
 G DV1:Y D DV2 Q:Y=-1  I Y="TERM" S Y=-1 Q
 S Y=-2 Q
DV1 S Y=$ZC(%GETDVI,X,"PID") I Y=$J!($ZC(%GETDVI,X,"SPL")) S Y=0 Q
 I Y,$ZC(%GETJPI,X,"MASTER_PID")=Y G DVOPN
 Q:Y>0  D DV2 G DVOPN:Y="TERM" S Y=$S(Y="DISK":0,Y="MAILBOX":0,Y="TAPE":0,1:-1) Q
DV2 S Y=$ZC(%PARSE,X) I Y="" S Y=-1 Q
 I X]"" S Y=$ZC(%GETDVI,$S(Y]"":Y,1:X),"DEVCLASS") Q
 Q
DVOPN S $ZT="DVERR",Y=0 Q:$D(%ZTIO)
 L:$D(%ZISLOCK) +@%ZISLOCK:60
 O X::$S($D(%ZISTO):%ZISTO,1:0) E  S Y=999 L:$D(%ZISLOCK) -@%ZISLOCK:60 Q
 L:$D(%ZISLOCK) -@%ZISLOCK
 S Y=0 I '$D(%ZISCHK)!$S($D(%ZIS)#2:(%ZIS["T"),1:0) C X Q
 S:X]"" IO(1,X)="" Q
DVERR I $ZE["OPENERR" S Y=-1 Q
 ZQ
RES S Y=0,%ZISD0=$O(^%ZISL(3.54,"B",X,0))
 I '%ZISD0 S Y=-1,%ZISD0=$O(^%ZIS(1,"C",X)) Q:'%ZISD0  Q:'$D(^%ZIS(1,+%ZISD0,0))  Q:$P(^(0),"^")'=X  Q:'$D(^("TYPE"))  Q:^("TYPE")'="RES"  S Y=0 Q
 S X1=$S($D(^%ZISL(3.54,+%ZISD0,0)):^(0),1:"")
 I $P(X1,"^",2)&(X=$P(X1,"^")) S Y=0 Q
 S Y=999 F %ZISD1=0:0 S %ZISD1=$O(^%ZISL(3.54,%ZISD0,1,%ZISD1)) Q:%ZISD1'>0  I $D(^(%ZISD1,0)) S Y=$P(^(0),"^",3) Q
 K %ZISD0,%ZISD1
 Q
