DPTNTEG ;ISC/XTSUMBLD KERNEL - Package checksum checker ;AUG 13, 1993@12:47:13
 ;;5.3;Patient File;;Aug 13, 1993
 ;;7.0;AUG 13, 1993@12:47:13
 S XT4="I 1",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
CONT F XT1=1:1 S XT2=$T(ROU+XT1) Q:XT2=""  S X=$P(XT2," ",1),XT3=$P(XT2,";",3) X XT4 I $T W !,X X ^%ZOSF("TEST") S:'$T XT3=0 X:XT3 ^%ZOSF("RSUM") W ?10,$S('XT3:"Routine not in UCI",XT3'=Y:"Calculated "_$C(7)_Y_", off by "_(Y-XT3),1:"ok")
 ;
 K %1,%2,%3,X,Y,XT1,XT2,XT3,XT4 Q
ONE S XT4="I $D(^UTILITY($J,X))",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
 W !,"Check a subset of routines:" K ^UTILITY($J) X ^%ZOSF("RSEL")
 W ! G CONT
ROU ;;
DPTDUP ;;4110286
DPTLK ;;10455790
DPTLK1 ;;10271019
DPTLK2 ;;13614639
DPTLK3 ;;4989853
DPTV53PP ;;3821
DPTV53PR ;;3837
DPTV53PT ;;390447
DPTVPP ;;129108
DPTVPR ;;109490
DPTVPT ;;1645669
