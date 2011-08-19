GMRSPRE ;ISC-SLC/MJC;ENVIROMENT CHECK FOR SVC/SECTION PATCH;3-17-95 2:09pm
 ;;2.5;Consult/Request Tracking;**8**;Jan 08, 1993
 I '$D(^GMR(123,0)) W $C(7),$C(7),!,"I think you're in the wrong UCI!",!?16,"-or-",!,"You don't have Consults v2.5 installed yet!",!! K DIFQ Q
 S U="^" I $S('($D(DUZ)#2):1,'$D(^VA(200,DUZ,0)):1,1:0) D  K DIFQ Q
 .W !!,"Your DUZ is "_$S($D(DUZ):"incorrectly set",1:"not set")_", the INIT will not run!!" Q
 I $S('$D(DUZ(0)):1,DUZ(0)'="@":1,1:0) D  K DIFQ Q
 .W !!,"DUZ(0) needs to be set to ""@"", the INIT will not run!!" Q
 H 1
CHECK N X,Y S XT4="I 1"
 W !!,"I will check your checksums for you...." H 2 K FLAG W !
CONT F XT1=1:1 S XT2=$T(ROU+XT1) Q:XT2=""  D
 .S X=$P(XT2," ",1),XT3=$P(XT2,";",3) X XT4 I $T W !,X X ^%ZOSF("TEST") S:'$T XT3=0 X:XT3 ^%ZOSF("RSUM") W ?10,Y,?19,$S('XT3:"Routine not in UCI",XT3'=Y:"OFF BY "_(Y-XT3),1:"ok")
 .I 'XT3!(XT3'=Y) S FLAG=1
 I $D(FLAG) D
 .W !!,$C(7),$C(7),"All of the routines that were exported with this"
 .W " patch do not",!,"have the correct checksum values!!",!
 .K DIR S DIR("A")="Do you want to continue? "
 .S DIR("B")="NO",DIR(0)="YA"
 .S DIR("?")="  'YES' and I will continue- 'NO' and I will stop the init"
 .D ^DIR K DIR I '+$G(Y) K DIFQ W !!,"Init stopped- re-run it when you're ready."
 I $D(DIFQ)&('$D(FLAG)) W !!,"Checksums are all correct......",!
 ;
EXIT K XT1,XT2,XT3,XT4,FLAG Q
ROU ;;
GMRSI001 ;;7465375
GMRSI002 ;;7319548
GMRSI003 ;;5123760
GMRSI004 ;;2495019
GMRSINI1 ;;5626819
GMRSINI2 ;;5232634
GMRSINI3 ;;16094179
GMRSINI4 ;;3357806
GMRSINI5 ;;499983
GMRSINIS ;;2214759
GMRSINIT ;;11300862
