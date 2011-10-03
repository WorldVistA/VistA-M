QAN2NTEG ;ISC/XTSUMBLD KERNEL - Package checksum checker ;8/27/93  10:45
 ;;2.0;Incident Reporting;**22**;08/07/1992;
 ;;7.0;AUG 27, 1993@10:23:47
 S XT4="I 1",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
CONT F XT1=1:1 S XT2=$T(ROU+XT1) Q:XT2=""  S X=$P(XT2," ",1),XT3=$P(XT2,";",3) X XT4 I $T W !,X X ^%ZOSF("TEST") S:'$T XT3=0 X:XT3 ^%ZOSF("RSUM") W ?10,$S('XT3:"Routine not in UCI",XT3'=Y:"Calculated "_$C(7)_Y_", off by "_(Y-XT3),1:"ok")
 ;
 K %1,%2,%3,X,Y,XT1,XT2,XT3,XT4 Q
ONE S XT4="I $D(^UTILITY($J,X))",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
 W !,"Check a subset of routines:" K ^UTILITY($J) X ^%ZOSF("RSEL")
 W ! G CONT
ROU ;;
QAN2I001 ;;5799177
QAN2I002 ;;2729881
QAN2INI1 ;;5483037
QAN2INI2 ;;5215686
QAN2INI3 ;;15729881
QAN2INI4 ;;3357634
QAN2INI5 ;;500153
QAN2INIT ;;11055824
QAN2IPRE ;;3574825
QAN2IPST ;;199119
