%XUCI ;SF/STAFF - SWAP UCIS FOR MSM-UNIX ;11/20/92  07:30
 ;;8.0;KERNEL;;Jul 10, 1995
1 R !,"What UCI: ",%UCI:$S($D(DTIME):DTIME,1:10),"  " Q:%UCI=""!(%UCI["^")  G 2
 ;
2 ;
 I %UCI="PROD"!(%UCI="MGR") S %UCI=^%ZOSF(%UCI)
 S X=%UCI X ^%ZOSF("UCICHECK") G ERR:0[Y
 I $S($P($ZV,"Version ",2)'<2:$V(0,$J,2)#2,1:$V(2,$J)#2) W:'($D(XUSLNT)!$D(ZTQUEUED)) !,*7,"NO SWITCHING UCI'S IN PROGRAMMER MODE!",! S Y=0 Q
V D SWAP
U I '($D(XUSLNT)!$D(ZTQUEUED)) W *7,!,"YOU'RE IN UCI: ",Y,!
 S $ZT="^%ZTER",%=$D(^%ZOSF("OS"))
K K %,%UCI S Y=1 Q
 ;
SWAP ;I $P($ZV,"Version ",2)'<2
 S %ST=$S(X[",":$ZU($P(X,","),$P(X,",",2)),1:$ZU(X))
 I $P($ZV,"Version ",2),%ST["," S %ST=$P(%ST,",",2)*32+$P(%ST,",") V:'($V(0,$J,2)#2) 2:$J:%ST:2 Q
 F %ST=1:1:64 Q:$ZU(%ST)=X
 V:'($V(2,$J)#2) 2:$J:%ST-1:2 Q
 ;
ENT G 2:$D(%UCI)#2,1
 ;
GO ;
 D 2 Q:0[Y  S X=PGM I PGM'?1"%".E X ^%ZOSF("TEST") I '$T W !?9,"'"_X_"' DOES NOT EXIST IN "_%UCI,! HALT
 K ^XUTL("XQ",$J),^UTILITY($J) G @(U_PGM)
 ;
DO S %UCI=$P(XQZ,"[",2,9),PGM=$P(XQZ,"[",1),%UCI=$E(%UCI,1,$L(%UCI)-1)
 I %UCI="PROD"!(%UCI="MGR") S %UCI=^%ZOSF(%UCI)
 E  S X=%UCI X ^%ZOSF("UCICHECK") G ERR:0[Y
 X ^%ZOSF("UCI") D SAV,D S %UCI=Y D 2^%XUCI,RES Q
D N Y,%XUCI D 2 Q:0[Y  G @PGM Q
SAV S %XUCI="" F %="DUZ","DUZ(0)","DT","DTIME","IO","IO(0)","IOF","IOM","IOST","IOST(0)" S %XUCI=%XUCI_$S($D(@%)#2:@%,1:"")_"^"
 Q
RES F %=1:1:10 S @($P("DUZ^DUZ(0)^DT^DTIME^IO^IO(0)^IOF^IOM^IOST^IOST(0)","^",%))=$P(%XUCI,"^",%)
 Q
 ;
ERR W !?9,"'"_X_"' IS AN INVALID UCI!",!
