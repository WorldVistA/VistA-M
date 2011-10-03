ENXDNTEG ;ISC/XTSUMBLD KERNEL - Package checksum checker ;FEB 07, 1995@15:55:49
 ;;7.0;ENGINEERING;**20**;Aug 17, 1993
 ;;7.1;FEB 07, 1995@15:55:49
 S XT4="I 1",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
CONT F XT1=1:1 S XT2=$T(ROU+XT1) Q:XT2=""  S X=$P(XT2," ",1),XT3=$P(XT2,";",3) X XT4 I $T W !,X X ^%ZOSF("TEST") S:'$T XT3=0 X:XT3 ^%ZOSF("RSUM") W ?10,$S('XT3:"Routine not in UCI",XT3'=Y:"Calculated "_$C(7)_Y_", off by "_(Y-XT3),1:"ok")
 ;
 K %1,%2,%3,X,Y,XT1,XT2,XT3,XT4 Q
ONE S XT4="I $D(^UTILITY($J,X))",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
 W !,"Check a subset of routines:" K ^UTILITY($J) X ^%ZOSF("RSEL")
 W ! G CONT
ROU ;;
ENEXPT ;;7449593
ENXDI001 ;;2658051
ENXDINI1 ;;5647097
ENXDINI2 ;;5232592
ENXDINI3 ;;16093555
ENXDINI4 ;;3357764
ENXDINI5 ;;360766
ENXDINIS ;;2212105
ENXDINIT ;;10748626
ENXDIPST ;;1225216
