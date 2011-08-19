PRX4NTEG ;ISC/XTSUMBLD KERNEL - Package checksum checker ;AUG 12, 1995@11:34:10
 ;;5.0;IFCAP;**11**;4/21/95
 ;;7.1;AUG 12, 1995@11:34:10
 S XT4="I 1",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
CONT F XT1=1:1 S XT2=$T(ROU+XT1) Q:XT2=""  S X=$P(XT2," ",1),XT3=$P(XT2,";",3) X XT4 I $T W !,X X ^%ZOSF("TEST") S:'$T XT3=0 X:XT3 ^%ZOSF("RSUM") W ?10,$S('XT3:"Routine not in UCI",XT3'=Y:"Calculated "_$C(7)_Y_", off by "_(Y-XT3),1:"ok")
 ;
 K %1,%2,%3,X,Y,XT1,XT2,XT3,XT4 Q
ONE S XT4="I $D(^UTILITY($J,X))",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
 W !,"Check a subset of routines:" K ^UTILITY($J) X ^%ZOSF("RSEL")
 W ! G CONT
ROU ;;
PRC0F ;;783401
PRCBSTF ;;11630230
PRCS826 ;;1360201
PRCSEM2 ;;837451
PRX4I001 ;;6826931
PRX4I002 ;;1921614
PRX4I003 ;;1801222
PRX4INI1 ;;4835030
PRX4INI2 ;;5232547
PRX4INI3 ;;16806948
PRX4INI4 ;;3357719
PRX4INI5 ;;465677
PRX4INIS ;;2211350
PRX4INIT ;;10112969
