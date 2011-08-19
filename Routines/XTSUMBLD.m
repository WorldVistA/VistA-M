XTSUMBLD ;SF/RWF - BUILD PACKAGE INTEG ROUTINE ; 3/21/06 2:50MP
 ;;7.3;TOOLKIT;**11,20,66,70,94,100**;Apr 25, 1995;Build 4
A ;
 K ^UTILITY($J),DIR D MSG
 S DIR(0)="SM^P:Package;B:Build",DIR("A")="Build from" D ^DIR K DIR Q:X[U
 G PKG:Y="P",BUILD:Y="B" Q
PKG W !!,"This will build a checksum routine for a package from the package file",!
 S DIC=9.4,DIC(0)="AEMQZ" D ^DIC G EXIT:Y'>0
 D NAME($P(Y(0),U,2)) G EXIT:'$D(XTRNAME)
 X ^%ZOSF("RSEL") G EXIT:$O(^UTILITY($J,""))=""
 G BLD
 ;
BUILD W !!,"This will build a checksum routine from the BUILD file."
 S DIC="^XPD(9.6,",DIC(0)="AEMQZ" D ^DIC G EXIT:Y'>0 S BLDA=+Y
 I $P(Y(0),U,2)'>0 W !!,"There isn't a package file pointer." G EXIT
 S X=$P(^DIC(9.4,+$P(Y(0),U,2),0),U,2) D NAME(X) G EXIT:'$D(XTRNAME)
 F IX=0:0 S IX=$O(^XPD(9.6,BLDA,"KRN",9.8,"NM",IX)) Q:IX'>0  S X=^(IX,0) S:'$P(X,U,3) ^UTILITY($J,$P(X,U))=""
 F IX="INI","INIT","PRE" S X=$G(^XPD(9.6,BLDA,IX)) I X]"" S ^UTILITY($J,$S(X[U:$P(X,U,2),1:X))=""
 G EXIT:$O(^UTILITY($J,""))=""
 G BLD
 ;
NAME(Y) S XTRNAME=Y_"NTEG" W !,"I will create a routine ",XTRNAME
 S X=XTRNAME X ^%ZOSF("TEST") I $T S DIR(0)="YA",DIR("A")="But you already have one on file!  OK to replace? ",DIR("B")="NO" D ^DIR I Y'=1 K XTRNAME
 Q
 ;
BLD S X=XTRNAME F I=0:0 K ^UTILITY($J,X) S X=$O(^UTILITY($J,X)) Q:X'[XTRNAME
 I $O(^UTILITY($J,""))="" W !,"Routine list is empty" G EXIT
 W !,"Calculating check-sums" S XTDT=$$NOW^XLFDT()
 S X=" " F I=0:0 S X=$O(^UTILITY($J,X)) Q:X=""  D
 . W !,X X ^%ZOSF("TEST") I '$T W ?10,"Routine not in this UCI." Q
 . X ^%ZOSF("RSUM") S ^UTILITY($J,X)=Y Q
 W !,"Building routine" S RN=" ",XTRNCNT=0
B K ^UTILITY($J,0) S XTSIZE=0,XCN=0,DIE="^UTILITY($J,0,",XTRNEXT=$E(XTRNAME,1,7)_XTRNCNT,XTRNCNT=XTRNCNT+1
 F I=1:1 S XT=$P($T(ROU+I),";;",2,99) D ADD Q:$E(XT,1,3)="ROU"
 S @(DIE_"1,0)")=XTRNAME_$P($T(ROU+1),";;",2)_XTDT,@(DIE_"3,0)")=" ;;"_$P($T(+2),";",3)_";"_XTDT
 F I=0:0 S RN=$O(^UTILITY($J,RN)) Q:RN=""  S %=^(RN),XT=RN_" ;;"_% D ADD Q:XTSIZE>3700
 I RN]"" S @(DIE_"6,0)")=" G CONT^"_XTRNEXT
 S XCN=0,X=XTRNAME W !!,"Filing routine ",XTRNAME X ^%ZOSF("SAVE") S XTRNAME=XTRNEXT G:RN]"" B
 W !,"  DONE",!
EXIT K ^UTILITY($J),DIC,DIR,XCN,XTRNAME,XTRNCNT,XU1,XTSIZE,XTDT,DIE,XTRNEXT,XT,X,Y
 Q
ADD S XCN=XCN+1,XTSIZE=XTSIZE+$L(XT)+2,@(DIE_XCN_",0)")=XT Q
 Q
CHECK ;Print the values of a set of routines.
 N XPCH,X,DIR D MSG
 S DIR(0)="SM^P:Package;B:Build",DIR("A")="Build from" D ^DIR K DIR Q:X[U
 G CHKPKG:Y="P",CHKBLD:Y="B" Q
CHKPKG W !! K ^UTILITY($J) X ^%ZOSF("RSEL") I $O(^UTILITY($J,0))']"" W !!,"NO SELECTED ROUTINES" G EXIT
CHK2 S X=" " F XU1=0:0 S X=$O(^UTILITY($J,X)) Q:X']""  D
 . W !,X,?10 X ^%ZOSF("TEST") I '$T W "Routine not in this UCI." Q
 . I $G(XUCHFLG)=1 X ^%ZOSF("RSUM1") W "value = ",Y
 . E  X ^%ZOSF("RSUM") W "value = ",Y
 . I $D(XPCH) X XPCH
 . Q
 W !,"done" G EXIT
CHKBLD W !!,"This will check the routines from a BUILD file."
 S DIC="^XPD(9.6,",DIC(0)="AEMQZ" D ^DIC G EXIT:Y'>0
 S BLDA=+Y,X=$P(Y,"^",2)
 I X["*" S XPCH="S L=$T(+2^@X) I $P(L,"";"",5)'?.E1P1"""_$P(X,"*",3)_"""1P.E W ?30,""Missing patch number"""
 F IX=0:0 S IX=$O(^XPD(9.6,BLDA,"KRN",9.8,"NM",IX)) Q:IX'>0  S X=^(IX,0) S:'$P(X,U,3) ^UTILITY($J,$P(X,U))=""
 F IX="INI","INIT","PRE" S X=$G(^XPD(9.6,BLDA,IX)) I X]"" S ^UTILITY($J,$S(X[U:$P(X,U,2),1:X))=""
 G EXIT:$O(^UTILITY($J,""))=""
 G CHK2
 ;
MSG W !!,"This option determines the current checksum of selected routine(s)."
 W !,"The Checksum of the routine is determined as follows:",!
 W !,"1. Any comment line with a single semi-colon is presumed to be"
 W !,"   followed by comments and only the line tag will be included."
 W !!,"2. Line 2 will be excluded from the count.",!
 W !,"3. The total value of the routine is determined (excluding"
 W !,"   exceptions noted above) by multiplying the ASCII value of each"
 W !,"   character by its position on the line "
 I $G(XUCHFLG)=1 W "and position of the line in ",!,"   the routine "
 W "being checked."
 Q
 ;
CHECK1 ;New CheckSum logic
 W !,"New CheckSum CHECK1^XTSUMBLD:"
 N XUCHFLG S XUCHFLG=1 D CHECK
 Q
 ;
CHCKSUM ;
 W !,"This option determines the current Old (CHECK^XTSUMBLD) or New (CHECK1^XTSUMBLD) logic checksum of selected routine(s)."
 N OON
 S OON=$$ASKOON Q:OON<1  ;Return 1 or 2
 I OON=1 D CHECK
 I OON=2 D CHECK1
 Q
 ;
ASKOON() ;
 ;Ask if user wants old/new checksum
 ;Return 1 or 2.
 N DIR,DIOUT
 S DIR(0)="S^1:Old;2:New",DIR("A")="New or Old Checksums",DIR("B")="New"
 D ^DIR
 I $D(DIRUT) S Y=-1
 Q Y
ROU ;;
 ;; ;ISC/XTSUMBLD KERNEL - Package checksum checker ;
 ;; ;;0.0;
 ;; ;;7.3;10/1/94
 ;; S XT4="I 1",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
 ;;CONT F XT1=1:1 S XT2=$T(ROU+XT1) Q:XT2=""  S X=$P(XT2," ",1),XT3=$P(XT2,";",3) X XT4 I $T W !,X X ^%ZOSF("TEST") S:'$T XT3=0 X:XT3 ^%ZOSF("RSUM") W ?10,$S('XT3:"Routine not in UCI",XT3'=Y:"Calculated "_$C(7)_Y_", off by "_(Y-XT3),1:"ok")
 ;; ;
 ;; K %1,%2,%3,X,Y,XT1,XT2,XT3,XT4 Q
 ;;ONE S XT4="I $D(^UTILITY($J,X))",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
 ;; W !,"Check a subset of routines:" K ^UTILITY($J) X ^%ZOSF("RSEL")
 ;; W ! G CONT
 ;;ROU ;;
