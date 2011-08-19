PRX1NTEG ;ISC/XTSUMBLD KERNEL - Package checksum checker ;AUG 16, 1995@11:09:03
 ;;5.0;IFCAP;**25**;4/21/95
 ;;7.1;AUG 16, 1995@11:09:03
 S XT4="I 1",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
CONT F XT1=1:1 S XT2=$T(ROU+XT1) Q:XT2=""  S X=$P(XT2," ",1),XT3=$P(XT2,";",3) X XT4 I $T W !,X X ^%ZOSF("TEST") S:'$T XT3=0 X:XT3 ^%ZOSF("RSUM") W ?10,$S('XT3:"Routine not in UCI",XT3'=Y:"Calculated "_$C(7)_Y_", off by "_(Y-XT3),1:"ok")
 ;
 K %1,%2,%3,X,Y,XT1,XT2,XT3,XT4 Q
ONE S XT4="I $D(^UTILITY($J,X))",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
 W !,"Check a subset of routines:" K ^UTILITY($J) X ^%ZOSF("RSEL")
 W ! G CONT
ROU ;;
PRCBBUL ;;13737900
PRCSCPY ;;7392364
PRCSEM1 ;;50877
PRCSEZ ;;8914183
PRCSEZZ ;;7671855
PRX1I001 ;;19922023
PRX1I002 ;;12537316
PRX1INI1 ;;4855204
PRX1INI2 ;;5232535
PRX1INI3 ;;16806762
PRX1INI4 ;;3357707
PRX1INI5 ;;360527
PRX1INIS ;;2210561
PRX1INIT ;;10070353
