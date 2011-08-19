VSITNTEG ;ISC/XTSUMBLD KERNEL - Package checksum checker ;2960812.192141
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**76**;Aug 12, 1996
 ; Patch PX*1*76 changes the 2nd line of all VSIT* routines to reflect
 ; the incorporation of the module into PCE.  For historical reference,
 ; the old (VISIT TRACKING) 2nd line is included below to reference VSIT
 ; patches.
 ;
 ;;2.0;VISIT TRACKING;;Aug 12, 1996
 ;;7.3;2960812.192141
 S XT4="I 1",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
CONT F XT1=1:1 S XT2=$T(ROU+XT1) Q:XT2=""  S X=$P(XT2," ",1),XT3=$P(XT2,";",3) X XT4 I $T W !,X X ^%ZOSF("TEST") S:'$T XT3=0 X:XT3 ^%ZOSF("RSUM") W ?10,$S('XT3:"Routine not in UCI",XT3'=Y:"Calculated "_$C(7)_Y_", off by "_(Y-XT3),1:"ok")
 ;
 K %1,%2,%3,X,Y,XT1,XT2,XT3,XT4 Q
ONE S XT4="I $D(^UTILITY($J,X))",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
 W !,"Check a subset of routines:" K ^UTILITY($J) X ^%ZOSF("RSEL")
 W ! G CONT
ROU ;;
AUPNVSIT ;;5352310
VSIT ;;6026028
VSIT0 ;;911420
VSITASK ;;2075464
VSITBUL ;;2905102
VSITCK ;;937977
VSITCK1 ;;1017425
VSITDEF ;;9470989
VSITFLD ;;2638733
VSITGET ;;3290786
VSITHLP ;;6841141
VSITIENV ;;3898032
VSITIPOS ;;2337494
VSITIPRE ;;79953
VSITKIL ;;3586292
VSITOE ;;4386878
VSITPUT ;;492684
VSITPUT1 ;;1489104
VSITSTAT ;;3053946
VSITVAR ;;6380345
VSITVID ;;1147478
