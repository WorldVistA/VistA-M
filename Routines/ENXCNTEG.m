ENXCNTEG ;ISC/XTSUMBLD KERNEL - Package checksum checker ;12/16/94  12:23
 ;;7.0;ENGINEERING;**19**;Aug 17, 1993
 ;;7.1;DEC 16, 1994@12:15:25
 S XT4="I 1",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
CONT F XT1=1:1 S XT2=$T(ROU+XT1) Q:XT2=""  S X=$P(XT2," ",1),XT3=$P(XT2,";",3) X XT4 I $T W !,X X ^%ZOSF("TEST") S:'$T XT3=0 X:XT3 ^%ZOSF("RSUM") W ?10,$S('XT3:"Routine not in UCI",XT3'=Y:"Calculated "_$C(7)_Y_", off by "_(Y-XT3),1:"ok")
 ;
 K %1,%2,%3,X,Y,XT1,XT2,XT3,XT4 Q
ONE S XT4="I $D(^UTILITY($J,X))",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
 W !,"Check a subset of routines:" K ^UTILITY($J) X ^%ZOSF("RSEL")
 W ! G CONT
ROU ;;
ENEQRPI ;;11877117
ENXCI001 ;;3505400
ENXCI002 ;;5890755
ENXCINI1 ;;5657215
ENXCINI2 ;;5232588
ENXCINI3 ;;16093493
ENXCINI4 ;;3357760
ENXCINI5 ;;412291
ENXCINIS ;;2211842
ENXCINIT ;;10758870
ENXCIPST ;;3663458
