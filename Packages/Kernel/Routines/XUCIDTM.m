%XUCI ;SF/STAFF - SWAP UCIs DSM-11 ;2/3/93  16:37 ;
 ;;8.0;KERNEL;;Jul 10, 1995
 ; *** For DataTree ***
1 R !,"What Namespace: ",%UCI:$S($D(DTIME):DTIME,1:10),"  " Q:%UCI=""!(%UCI["^")  G 2
 ;
2 ;
 I %UCI="PROD"!(%UCI="MGR") S %UCI=^%ZOSF(%UCI)
 S X=%UCI X ^%ZOSF("UCICHECK") G ERR:0[Y
 X ^%ZOSF("PROGMODE") I Y W:'$D(XUSLNT) !,*7,"NO SWITCHING UCI'S IN PROGRAMMER MODE!",! S Y=0 Q
V D SWAP
U I '$D(XUSLNT) W *7,!,"You're now in namespace: ",Y,!
 S $ZT="^%errlog",%ST=$D(^%ZOSF("OS")),^XUTL("XQ",$J,0)=DT,^("DUZ")=DUZ
K K %ST,%UCI Q
 ;
SWAP S X=$P(X,",")
 I $P($ZVER,"/",2)<4 X ^%ZOSF("PROGMODE") ZNSPACE:'Y X I 1
 E  X ^%ZOSF("PROGMODE") D:'Y ns^%m(X,1)
 Q
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
SAV S %XUCI="" F %="DUZ","DUZ(0)","DT","DTIME","IO","IO(0)","IOM","IOST","IOST(0)" S %XUCI=%XUCI_$S($D(@%)#2:@%,1:"")_"^"
 Q
RES F %=1:1:9 S @($P("DUZ^DUZ(0)^DT^DTIME^IO^IO(0)^IOM^IOST^IOST(0)","^",%))=$P(%XUCI,"^",%)
 Q
 ;
ERR W !?9,"'"_X_"' IS AN INVALID NAMESPACE!",!
