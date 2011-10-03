HBHVNTEG ;ISC/XTSUMBLD KERNEL - Package checksum checker ;SEP 27, 1994@09:03:46
 ;;1.0;HOSPITAL BASED HOME CARE;**4**;NOV 01,1993
 ;;7.2;SEP 27, 1994@09:03:46
 S XT4="I 1",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
CONT F XT1=1:1 S XT2=$T(ROU+XT1) Q:XT2=""  S X=$P(XT2," ",1),XT3=$P(XT2,";",3) X XT4 I $T W !,X X ^%ZOSF("TEST") S:'$T XT3=0 X:XT3 ^%ZOSF("RSUM") W ?10,$S('XT3:"Routine not in UCI",XT3'=Y:"Calculated "_$C(7)_Y_", off by "_(Y-XT3),1:"ok")
 ;
 K %1,%2,%3,X,Y,XT1,XT2,XT3,XT4 Q
ONE S XT4="I $D(^UTILITY($J,X))",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
 W !,"Check a subset of routines:" K ^UTILITY($J) X ^%ZOSF("RSEL")
 W ! G CONT
ROU ;;
HBHCXMD ;;15400394
HBHVI001 ;;2646690
HBHVI002 ;;3081174
HBHVI003 ;;842022
HBHVI004 ;;2113298
HBHVINI1 ;;5626605
HBHVINI2 ;;5232595
HBHVINI3 ;;16093183
HBHVINI4 ;;3357767
HBHVINI5 ;;517203
HBHVINIS ;;2210636
HBHVINIT ;;10931164
