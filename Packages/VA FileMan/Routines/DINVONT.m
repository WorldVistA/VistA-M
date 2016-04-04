%ZOSV ;SFISC/AC - $View commands for Open M for NT.  ;2015-01-02  4:31 PM
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
ACTJ() ;# Active jobs
 N Y,% S %=0 F Y=0:1 S %=$ZJ(%) Q:%=""
 Q Y
AVJ() ;# available jobs
 ;Return fixed value if version < 2.1.6 (e.i. not Cache)
 N V S V=$$VERSION($ZV) I 216>$TR(V,".") Q 15 ;
 N MAXPID S MAXPID=$V($ZU(40,2,118),-2,4) ;from %SS
 Q MAXPID-$$ACTJ() ;need ISM to provide maxpid in ^%MACHINE
PRIINQ() ;
 Q 8
UCI ;Current UCI
 S Y=$ZU(5)_","_^%ZOSF("VOL") Q
 ;
UCICHECK(X) ;Check if valid UCI
 N Y,%
 S %=$P(X,",",1),Y=0 I $ZU(90,10,%) S Y=%
 Q Y
JOBPAR ;See if X points to a valid Job. Return its UCI.
 N ZJ S Y="",$ZT="JOBX"
 Q:'$D(^$JOB(X))  S Y=$V(-1,X),Y=$P(Y,"^",14)_","_^%ZOSF("VOL")
JOBX Q
 ;
T0 ; start RT clock
 S XRT0=$H Q
T1 ; store RT datum
 S ^%ZRTL(3,XRTL,+$H,XRTN,$P($H,",",2))=XRT0 K XRT0 Q
NOLOG ;
 S Y="$V(0,-2,4)\4096#2" Q
 ;
PROGMODE() ;Check if in PROG mode
 Q $ZJ#2
 ;
PRGMODE ;
 W ! S ZTPAC=$S('$D(^VA(200,+DUZ,.1)):"",1:$P(^(.1),U,5)),XUVOL=^%ZOSF("VOL")
 S X="" X ^%ZOSF("EOFF") R:ZTPAC]"" !,"PAC: ",X:60 D LC^XUS X ^%ZOSF("EON") I X'=ZTPAC W "??",*7 Q
 S XMB="XUPROGMODE",XMB(1)=DUZ,XMB(2)=$I D ^XMB:$L($T(^XMB)) D BYE^XUSCLEAN K ZTPAC,X,XMB
 D UCI S XUCI=Y,XQZ="PRGM^ZUA[MGR]",XUSLNT=1 D DO^%XUCI D ^%PMODE U $I:("":"+B+C+R") S $ZT="" Q
 Q
LGR() S $ZT="LGRX^%ZOSV"
 Q $ZR ;Last Global ref.
LGRX Q ""
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
 S Y=0,X1=$G(X1) Q:X=2  Q:(X1="HFS")!(X1="MT")  G:X1="RES" RES ;Quit w/ OK for HFS, Spool, MT
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
 X ^%ZOSF("UCI") S Y=$P(Y,",")_"^"_^%ZOSF("VOL")_"^"_$ZU(110)_"^"_^%ZOSF("VOL")
 Q
VERSION(X) ;return OS version, X=1 - return OS
 Q $S($G(X):$P($ZV,")")_")",1:$P($P($ZV,") ",2),"("))
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
LOGRSRC(OPT) ;record resource usage in ^XTMP("KMPR"
 D RO^%ZOSVKR(OPT)
 Q
SETTRM(X) ;Turn on specified terminators.
 U $I:(::X)
 Q 1
