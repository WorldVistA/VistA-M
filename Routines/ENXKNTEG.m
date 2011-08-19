ENXKNTEG ;ISC/XTSUMBLD KERNEL - Package checksum checker ;FEB 22, 1996@14:46:43
 ;;7.0;ENGINEERING;**31**;AUG 17, 1993
 ;;7.2;FEB 22, 1996@14:46:43
 S XT4="I 1",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
CONT F XT1=1:1 S XT2=$T(ROU+XT1) Q:XT2=""  S X=$P(XT2," ",1),XT3=$P(XT2,";",3) X XT4 I $T W !,X X ^%ZOSF("TEST") S:'$T XT3=0 X:XT3 ^%ZOSF("RSUM") W ?10,$S('XT3:"Routine not in UCI",XT3'=Y:"Calculated "_$C(7)_Y_", off by "_(Y-XT3),1:"ok")
 ;
 K %1,%2,%3,X,Y,XT1,XT2,XT3,XT4 Q
ONE S XT4="I $D(^UTILITY($J,X))",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
 W !,"Check a subset of routines:" K ^UTILITY($J) X ^%ZOSF("RSEL")
 W ! G CONT
ROU ;;
ENXKI001 ;;5785482
ENXKI002 ;;7753044
ENXKI003 ;;5772213
ENXKINI1 ;;4877846
ENXKINI2 ;;5232620
ENXKINI3 ;;16807526
ENXKINI4 ;;3357792
ENXKINI5 ;;439044
ENXKINIT ;;10233857
