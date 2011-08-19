XUINEACH ;SF/RWF - Code that needs to be run on each cpu. ;8/1/94  14:01 ;
 ;;8.0;KERNEL;;Jul 10, 1995
 I $D(DUZ)_$D(DUZ(0))_$D(U)[0 D DT^DICRW
A2 W !!,"Recompile Template routines."
 S XU1="X"
 F XU2=0:0 S XU1=$O(^DIPT("B",XU1)) Q:$E(XU1)'["X"  F XU3=0:0 S XU3=$O(^DIPT("B",XU1,XU3)) Q:XU3'>0  I $D(^DIPT(XU3,"ROU")) D DIPT
A3 W !!,"Queue Menu Tree Rebuild"
 F I=0:0 S I=$O(^%ZTSK(I)) Q:I'>0  I $P($G(^%ZTSK(I,.1)),"^",13)="Install Menu Rebuild" Q
 G:I>0 A4
 K ZTUCI,ZTCPU I ^%ZOSF("OS")["MSM" X ^%ZOSF("UCI") S ZTUCI=$P(Y,","),ZTCPU=$P(Y,",",2)
 S ZTRTN="QUE^XQ81",ZTDTH=$H,ZTIO="",ZTDESC="Install Menu Rebuild" D ^%ZTLOAD
A4 Q
DIPT S Y=XU3,DMAX=^DD("ROU"),X=$G(^DIPT(XU3,"ROUOLD")) D:X]"" EN^DIPZ Q
