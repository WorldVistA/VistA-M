DGNTEG03 ;ISC/XTSUMBLD KERNEL - Package checksum checker ;AUG 13, 1993@12:48:50
 ;;5.3;Registration;;Aug 13, 1993
 ;;7.0;AUG 13, 1993@12:48:50
 S XT4="I 1",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
CONT F XT1=1:1 S XT2=$T(ROU+XT1) Q:XT2=""  S X=$P(XT2," ",1),XT3=$P(XT2,";",3) X XT4 I $T W !,X X ^%ZOSF("TEST") S:'$T XT3=0 X:XT3 ^%ZOSF("RSUM") W ?10,$S('XT3:"Routine not in UCI",XT3'=Y:"Calculated "_$C(7)_Y_", off by "_(Y-XT3),1:"ok")
 ;
 K %1,%2,%3,X,Y,XT1,XT2,XT3,XT4 Q
ONE S XT4="I $D(^UTILITY($J,X))",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
 W !,"Check a subset of routines:" K ^UTILITY($J) X ^%ZOSF("RSEL")
 W ! G CONT
ROU ;;
VASITE ;;4888172
VASITE0 ;;4791385
VASITE1 ;;8954803
VATRAN ;;3819391
VATREDIT ;;335073
VAUQWK ;;3399132
VAUTL ;;1759877
VAUTOMA ;;9753719
