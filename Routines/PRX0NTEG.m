PRX0NTEG ;ISC/XTSUMBLD KERNEL - Package checksum checker ;AUG 15, 1995@08:19:20
 ;;5.0;IFCAP;**8**;4/21/95
 ;;7.1;AUG 15, 1995@08:19:20
 S XT4="I 1",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
CONT F XT1=1:1 S XT2=$T(ROU+XT1) Q:XT2=""  S X=$P(XT2," ",1),XT3=$P(XT2,";",3) X XT4 I $T W !,X X ^%ZOSF("TEST") S:'$T XT3=0 X:XT3 ^%ZOSF("RSUM") W ?10,$S('XT3:"Routine not in UCI",XT3'=Y:"Calculated "_$C(7)_Y_", off by "_(Y-XT3),1:"ok")
 ;
 K %1,%2,%3,X,Y,XT1,XT2,XT3,XT4 Q
ONE S XT4="I $D(^UTILITY($J,X))",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
 W !,"Check a subset of routines:" K ^UTILITY($J) X ^%ZOSF("RSEL")
 W ! G CONT
ROU ;;
PRCBRCP ;;3736798
PRCSP1D ;;14773207
PRCSREC1 ;;7158749
PRCSREC4 ;;7819401
PRX0I001 ;;2122905
PRX0INI1 ;;4855263
PRX0INI2 ;;5232531
PRX0INI3 ;;16806700
PRX0INI4 ;;3357703
PRX0INI5 ;;360498
PRX0INIS ;;2210298
PRX0INIT ;;10209531
