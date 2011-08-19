DGY3NTEG ;ISC/XTSUMBLD KERNEL - Package checksum checker ;JAN 04, 1996@11:00:04
 ;;5.3;Registration;**81**;Aug 13, 1993
 ;;7.2;JAN 04, 1996@11:00:04
 S XT4="I 1",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
CONT F XT1=1:1 S XT2=$T(ROU+XT1) Q:XT2=""  S X=$P(XT2," ",1),XT3=$P(XT2,";",3) X XT4 I $T W !,X X ^%ZOSF("TEST") S:'$T XT3=0 X:XT3 ^%ZOSF("RSUM") W ?10,$S('XT3:"Routine not in UCI",XT3'=Y:"Calculated "_$C(7)_Y_", off by "_(Y-XT3),1:"ok")
 ;
 K %1,%2,%3,X,Y,XT1,XT2,XT3,XT4 Q
ONE S XT4="I $D(^UTILITY($J,X))",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
 W !,"Check a subset of routines:" K ^UTILITY($J) X ^%ZOSF("RSEL")
 W ! G CONT
ROU ;;
DGY3I001 ;;7783924
DGY3I002 ;;3814238
DGY3I003 ;;3154946
DGY3I004 ;;6413790
DGY3I005 ;;2198754
DGY3I006 ;;1430059
DGY3INI1 ;;4834848
DGY3INI2 ;;5232512
DGY3INI3 ;;16805636
DGY3INI4 ;;3357684
DGY3INI5 ;;399581
DGY3INIS ;;2205985
DGY3INIT ;;10223175
