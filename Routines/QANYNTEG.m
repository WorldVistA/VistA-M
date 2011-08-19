QANYNTEG ;ISC/XTSUMBLD KERNEL - Package checksum checker ;2950925.085642
 ;;2.0;Incident Reporting;**23**;08/07/1992
 ;;7.3;2950925.085642
 S XT4="I 1",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
CONT F XT1=1:1 S XT2=$T(ROU+XT1) Q:XT2=""  S X=$P(XT2," ",1),XT3=$P(XT2,";",3) X XT4 I $T W !,X X ^%ZOSF("TEST") S:'$T XT3=0 X:XT3 ^%ZOSF("RSUM") W ?10,$S('XT3:"Routine not in UCI",XT3'=Y:"Calculated "_$C(7)_Y_", off by "_(Y-XT3),1:"ok")
 ;
 K %1,%2,%3,X,Y,XT1,XT2,XT3,XT4 Q
ONE S XT4="I $D(^UTILITY($J,X))",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
 W !,"Check a subset of routines:" K ^UTILITY($J) X ^%ZOSF("RSEL")
 W ! G CONT
ROU ;;
QANBENE ;;8276483
QANUTL2 ;;16057656
QANYI001 ;;7920114
QANYI002 ;;1923982
QANYINI1 ;;4835264
QANYINI2 ;;5232632
QANYINI3 ;;16807712
QANYINI4 ;;3357804
QANYINI5 ;;500937
QANYINIS ;;2214735
QANYINIT ;;10294759
