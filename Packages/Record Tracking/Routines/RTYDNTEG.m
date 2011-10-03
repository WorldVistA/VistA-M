RTYDNTEG ;ISC/XTSUMBLD KERNEL - Package checksum checker ;2951215.112439
 ;;v 2.0;Record Tracking;**23**;10/22/91
 ;;7.3;2951215.112439
 S XT4="I 1",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
CONT F XT1=1:1 S XT2=$T(ROU+XT1) Q:XT2=""  S X=$P(XT2," ",1),XT3=$P(XT2,";",3) X XT4 I $T W !,X X ^%ZOSF("TEST") S:'$T XT3=0 X:XT3 ^%ZOSF("RSUM") W ?10,$S('XT3:"Routine not in UCI",XT3'=Y:"Calculated "_$C(7)_Y_", off by "_(Y-XT3),1:"ok")
 ;
 K %1,%2,%3,X,Y,XT1,XT2,XT3,XT4 Q
ONE S XT4="I $D(^UTILITY($J,X))",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
 W !,"Check a subset of routines:" K ^UTILITY($J) X ^%ZOSF("RSEL")
 W ! G CONT
ROU ;;
RTQ ;;12672257
RTYDI001 ;;2766437
RTYDI002 ;;1330739
RTYDINI1 ;;4835320
RTYDINI2 ;;5232620
RTYDINI3 ;;16808228
RTYDINI4 ;;3357792
RTYDINI5 ;;437060
RTYDINIS ;;2216741
RTYDINIT ;;10176337
RTYDPST ;;2288469
