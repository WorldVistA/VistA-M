EEOANTEG ;ISC/XTSUMBLD KERNEL - Package checksum checker ;2951106.093819
 ;;2.0;EEO Complaint Tracking;**3**;Apr 27, 1995
 ;;7.3;2951106.093819
 S XT4="I 1",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
CONT F XT1=1:1 S XT2=$T(ROU+XT1) Q:XT2=""  S X=$P(XT2," ",1),XT3=$P(XT2,";",3) X XT4 I $T W !,X X ^%ZOSF("TEST") S:'$T XT3=0 X:XT3 ^%ZOSF("RSUM") W ?10,$S('XT3:"Routine not in UCI",XT3'=Y:"Calculated "_$C(7)_Y_", off by "_(Y-XT3),1:"ok")
 ;
 K %1,%2,%3,X,Y,XT1,XT2,XT3,XT4 Q
ONE S XT4="I $D(^UTILITY($J,X))",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
 W !,"Check a subset of routines:" K ^UTILITY($J) X ^%ZOSF("RSEL")
 W ! G CONT
ROU ;;
EEOAI001 ;;6911211
EEOAI002 ;;6705733
EEOAI003 ;;3246512
EEOAINI1 ;;4855360
EEOAINI2 ;;5232535
EEOAINI3 ;;16805844
EEOAINI4 ;;3357707
EEOAINI5 ;;572392
EEOAINIS ;;2206906
EEOAINIT ;;10318556
