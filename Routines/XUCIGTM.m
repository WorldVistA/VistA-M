%XUCI ;SFISC/STAFF,PUG/TOAD - SWAP UCIs GT.M ;20 May 2003 8:43 am
 ;;8.0;KERNEL;**275**;Jul 10, 1995;
 ; for GT.M for Unix & VMS, version 4.3--based on single UCI model
 ;
1 W !,"GT.M doesn't have an equivlent to UCI's.",!,"You will remain in this enviroment."
 R !,"What UCI: ",%UCI:$S($D(DTIME):DTIME,1:10),"  " Q:%UCI=""!(%UCI["^")
 G 2
 ;
2 ;For GT.M this is a NOP, Return Y.
 X ^%ZOSF("UCI")
U I '($D(XUSLNT)!$D(ZTQUEUED)) W *7,!,"YOU'RE IN UCI: ",Y,!
 S %=$D(^%ZOSF("OS"))
K K %,%UCI S Y=1 Q
 ;
SWAP ;
 ; X ^%ZOSF("PROGMODE") I 'Y S X=$S(X[",":$ZC(%SETUCI,$P(X,","),$P(X,",",2)),1:$ZC(%SETUCI,$P(X,","))),X=$ZC(%PGMSET),X=$ZC(%SECMAP)
 Q
 ;
ENT G 2:$D(%UCI)#2,1
 ;
GO ;GOTO some routine
 D 2 Q:0[Y
 S X=PGM I PGM'?1"%".E X ^%ZOSF("TEST") I '$T W !?9,"'"_X_"' DOES NOT EXIST IN "_%UCI,! HALT
 K ^XUTL("XQ",$J),^UTILITY($J) G @(U_PGM)
 ;
DO ;Do some routine and return
 S %UCI=$P(XQZ,"[",2,9),PGM=$P(XQZ,"[",1),%UCI=$E(%UCI,1,$L(%UCI)-1)
 D SAV,D S %UCI=Y D 2,RES Q
D N Y,%XUCI D 2 Q:0[Y  G @PGM Q
 ;
SAV S %XUCI="" F %="DUZ","DUZ(0)","DT","DTIME","IO","IO(0)","IOF","IOM","IOST","IOST(0)" S %XUCI=%XUCI_$S($D(@%)#2:@%,1:"")_"^"
 Q
RES F %=1:1:10 S @($P("DUZ^DUZ(0)^DT^DTIME^IO^IO(0)^IOF^IOM^IOST^IOST(0)","^",%))=$P(%XUCI,"^",%)
 Q
 ;
ERR W !?9,"'"_X_"' IS AN INVALID UCI!",!
