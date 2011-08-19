PSUNTEG ;ISC/XTSUMBLD KERNEL - Package checksum checker ;AUG 11, 1995@07:52:57
 ;;2.0;D&PPM;;AUG 11, 1995
 S XT4="I 1",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
CONT F XT1=1:1 S XT2=$T(ROU+XT1) Q:XT2=""  S X=$P(XT2," ",1),XT3=$P(XT2,";",3) X XT4 I $T W !,X X ^%ZOSF("TEST") S:'$T XT3=0 X:XT3 ^%ZOSF("RSUM") W ?10,$S('XT3:"Routine not in UCI",XT3'=Y:"Calculated "_$C(7)_Y_", off by "_(Y-XT3),1:"ok")
 ;
 K %1,%2,%3,X,Y,XT1,XT2,XT3,XT4 Q
ONE S XT4="I $D(^UTILITY($J,X))",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
 W !,"Check a subset of routines:" K ^UTILITY($J) X ^%ZOSF("RSEL")
 W ! G CONT
ROU ;;
PSU ;;17686765
PSU1 ;;10796767
PSU10 ;;7073224
PSU2 ;;5200299
PSU3 ;;9396320
PSU4 ;;13311993
PSU5 ;;13880306
PSU6 ;;6053866
PSU7 ;;7932255
PSU8 ;;13085355
PSU81 ;;7524948
PSU9 ;;14930047
