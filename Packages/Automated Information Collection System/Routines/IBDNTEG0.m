IBDNTEG0 ;ISC/XTSUMBLD KERNEL - Package checksum checker ;2970424.083551
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
 ;;7.3;2970424.083551
 S XT4="I 1",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
CONT F XT1=1:1 S XT2=$T(ROU+XT1) Q:XT2=""  S X=$P(XT2," ",1),XT3=$P(XT2,";",3) X XT4 I $T W !,X X ^%ZOSF("TEST") S:'$T XT3=0 X:XT3 ^%ZOSF("RSUM") W ?10,$S('XT3:"Routine not in UCI",XT3'=Y:"Calculated "_$C(7)_Y_", off by "_(Y-XT3),1:"ok")
 ;
 K %1,%2,%3,X,Y,XT1,XT2,XT3,XT4 Q
ONE S XT4="I $D(^UTILITY($J,X))",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
 W !,"Check a subset of routines:" K ^UTILITY($J) X ^%ZOSF("RSEL")
 W ! G CONT
ROU ;;
IBDFOSG2 ;;13313314
IBDFOSG3 ;;7158757
IBDFOSG4 ;;3710643
IBDFPCE ;;2696567
IBDFPE ;;12450329
IBDFPE1 ;;8310152
IBDFPRG ;;7553882
IBDFPRG1 ;;2560350
IBDFQB ;;12597674
IBDFQEA ;;11843748
IBDFQEA1 ;;44681
IBDFQS ;;1334094
IBDFQSL ;;3215307
IBDFQSL1 ;;7683177
IBDFQSL2 ;;5616996
IBDFREG ;;5649578
IBDFRPC ;;8402302
IBDFRPC1 ;;3939573
IBDFRPC2 ;;13348413
IBDFRPC3 ;;5251659
IBDFRPC4 ;;5575808
IBDFSS ;;16958149
IBDFSS1 ;;2595117
IBDFST ;;11142778
IBDFST1 ;;11299943
IBDFU ;;15610352
IBDFU1 ;;12896586
IBDFU10 ;;522009
IBDFU1A ;;1409234
IBDFU1B ;;5339731
IBDFU1C ;;6702058
IBDFU2 ;;11675915
IBDFU2A ;;14139503
IBDFU2B ;;14408614
IBDFU2C ;;9269483
IBDFU3 ;;5569853
IBDFU4 ;;3631011
IBDFU5 ;;8489458
IBDFU5A ;;3373891
IBDFU6 ;;331661
IBDFU7 ;;665770
IBDFU8 ;;6550892
IBDFU9 ;;2718995
IBDFU91 ;;1874757
IBDFUA ;;3285590
IBDFUTI ;;3380251
IBDFUTL ;;11719221
IBDFUTL1 ;;21879277
IBDFUTL2 ;;11033351
IBDFUTL3 ;;3224598
