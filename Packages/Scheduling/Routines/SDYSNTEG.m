SDYSNTEG ;ISC/XTSUMBLD KERNEL - Package checksum checker ;2960129.085047
 ;;5.3;Scheduling;**36**;Aug 13, 1993
 ;;7.3;2960129.085047
 S XT4="I 1",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
CONT F XT1=1:1 S XT2=$T(ROU+XT1) Q:XT2=""  S X=$P(XT2," ",1),XT3=$P(XT2,";",3) X XT4 I $T W !,X X ^%ZOSF("TEST") S:'$T XT3=0 X:XT3 ^%ZOSF("RSUM") W ?10,$S('XT3:"Routine not in UCI",XT3'=Y:"Calculated "_$C(7)_Y_", off by "_(Y-XT3),1:"ok")
 ;
 K %1,%2,%3,X,Y,XT1,XT2,XT3,XT4 Q
ONE S XT4="I $D(^UTILITY($J,X))",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
 W !,"Check a subset of routines:" K ^UTILITY($J) X ^%ZOSF("RSEL")
 W ! G CONT
ROU ;;
SDACS ;;3960050
SDSTP ;;8897711
SDSTP2 ;;7578258
SDSTP3 ;;4568915
SDYSI001 ;;6867439
SDYSINI1 ;;4855600
SDYSINI2 ;;5232649
SDYSINI3 ;;16808286
SDYSINI4 ;;3357821
SDYSINI5 ;;361277
SDYSINIS ;;2217089
SDYSINIT ;;10301424
