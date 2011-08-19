%ZOSV ;SFISC/AC - $View commands for M/SQL systems.  ;5/12/94  10:10
 ;;8.0;KERNEL;;JUL 10, 1995
ACTJ() ;
 N Y,% S Y=$V(204,-2,4),%="" F Y=0:1 S %=$ZJ(%) Q:%=""
 Q Y
AVJ() ;
 Q 128-$$ACTJ()
PRIINQ() ;
 Q 8
UCI ;
 ;S Y=$V(4,-2,4)+348,Y=$V(Y+1,$J,-$V(Y,$J,1)) Q  ;***
 D ^%ST S Y=$V(%ST("DIR")+1,$J,-$V(%ST("DIR"),$J,1)) Q
 ;
UCICHECK(XX) ;
 N X
 S X=$P(XX,",",1),Y=0,%=^%ZOSF("MGR"),%=$D(^[%]SYS("UCI",0)) F %=0:0 S Y=$O(^(Y)) Q:Y=""!(Y=X)
 Q Y
JOBPAR ;
 K ZJ S ZJ="" F Y=0:0 S ZJ=$ZJ(ZJ) Q:'$L(ZJ)  S ZJ(ZJ)=""
 ;S Y="" Q:'$D(ZJ(X))  S Y=$V($V(4,-2,4)+349,X,-$V($V(4,-2,4)+348,X,1)) K ZJ Q
 S Y="" Q:'$D(ZJ(X))  S Y=$P($V(-1,X),"^",5) K ZJ Q
 ;
T0 ; start RT clock
 S XRT0=$H Q
T1 ; store RT datum
 S ^%ZRTL(3,XRTL,+$H,XRTN,$P($H,",",2))=XRT0 K XRT0 Q
NOLOG ;
 S Y="$V(0,-2,4)\4096#2" Q
 ;
PRGMODE ;
 W ! S ZTPAC=$S('$D(^VA(200,+DUZ,.1)):"",1:$P(^(.1),U,5)),XUVOL=^%ZOSF("VOL")
 S X="" X ^%ZOSF("EOFF") R:ZTPAC]"" !,"PAC: ",X:60 D LC^XUS X ^%ZOSF("EON") I X'=ZTPAC W "??",*7 Q
 S XMB="XUPROGMODE",XMB(1)=DUZ,XMB(2)=$I D ^XMB:$D(^XMB(3.7,0)) K ^XMB(3.7,+DUZ,100,$I),^XUSEC(0,"CUR",DUZ,+^XUSEC("XQ",$J,0)),ZTPAC,X,XMB
 D UCI S XUCI=Y,XQZ="PRGM^ZUA[MGR]",XUSLNT=1 D DO^%XUCI D ^%BJ X "ZR  B"
 Q
LGR() Q $ZR ;Last Global ref.
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
PARSIZ ;
 S X=3 Q
 ;
DEVOPN ;List of Devices opened
 ;Returns variable Y. Y=Devices owned separated by a comma
 S X=$J
 N % S Y=$P($V(-1,$J),"^",3) F %=1:1:$L(Y,",") S $P(Y,",",%)=$P($P(Y,",",%),"*",1)
 Q
DEVOK ;
 I $G(X1)="RES" G RES
 I X=2 S Y=0 Q
 S $ZT="OPNERR"
 O X::$S($D(%ZISTO):%ZISTO,1:0) E  S Y=999 Q  ;G NOPN
 S Y=0 I '$D(%ZISCHK)!$S($D(%ZIS)#2:(%ZIS["T"),1:0) C X Q
 S:X]"" IO(1,X)="" Q
 Q
NOPN ;
 N ZJ S $ZT="NJ"
 S ZJ="" F %=0:0 S ZJ=$ZJ(ZJ) Q:'ZJ  D NOPN1 Q:'ZJ
 Q
NOPN1 S Y=$V(-1,ZJ) I $P(Y,"^",3)[X_","!($P(Y,"^",3)[X_"*,") S Y=ZJ,ZJ="" Q
 Q
NJ Q  ;NOJOB ERROR
OPNERR S Y=-1 Q
 ;
RES S Y=0,%ZISD0=$O(^%ZISL(3.54,"B",X,0))
 I '%ZISD0 S Y=-1,%ZISD0=%O(^%ZIS(1,"C",X)) Q:'%ZISD0  Q:'$D(^%ZIS(1,+%ZISD0,0))  Q:$P(^(0),"^")'=X  Q:'$D(^("TYPE"))  Q:^("TYPE")'="RES"  S Y=0 Q
 S X1=$S($D(^%ZISL(3.54,+%ZISD0,0)):^(0),1:"")
 I $P(X1,"^",2)&(X=$P(X1,"^")) S Y=0 Q
 S Y=999 F %ZISD1=0:0 S %ZISD1=$O(^%ZISL(3.54,%ZISD0,1,%ZISD1)) Q:%ZISD1'>0  I $D(^(%ZISD1,0)) S Y=$P(^(0),"^",3) Q
 K %ZISD0,%ZISD1
 Q
GETENV ;Get environment  (UCI^VOL^NODE)
 X ^%ZOSF("UCI") S Y=Y_"^"_^%ZOSF("VOL")_"^^"_^%ZOSF("VOL")
 Q
VERSION(X) ;return OS version, X=1 - return OS
 Q $S($G(X):$P($ZV," V"),1:$P($P($ZV," V",2)," "))
 ;
SETNM(X) ;Set name, Fall into SETENV
SETENV ;Set environment
 Q
 ;
HFSREW(IO,IOPAR) ;Rewind Host File.
 S $ZT="HFSRWERR"
 C IO O @(""""_IO_""""_$S(IOPAR]"":":"_IOPAR_":1",1:":1")) I '$T Q 0
 Q 1
HFSRWERR ;Error encountered
 Q 0
LOGRSRC(OPT) ;record resource usage in ^XUCP
 Q
