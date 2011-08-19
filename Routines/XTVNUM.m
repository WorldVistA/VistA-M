XTVNUM ;SF-ISC/RWF - TO UPDATE THE VERSION NUMBER ;09 Apr 2003 8:24 am
 ;;7.3;TOOLKIT;**20,39,70**;Apr 25, 1995
GO W !!,"THIS ROUTINE WILL UPDATE THE VERSION NUMBER OR PATCH LIST"
 W !,"IN THE ROUTINES SELECTED"
 ;XTV(2)=New Version or Patch, 3=Version #, 4=Package Name, 5=Clear patch
 ;6=Date
 N BLDA,XTV,XTVPCH,DIC,DIR,Y,X K ^UTILITY($J)
 S XTV(5)=0,XTV(2)=0
 S DIR(0)="SM^F:Free Form;B:Build File",DIR("A")="Build from" D ^DIR K DIR Q:X[U
 S XTV=Y G PKG:Y="F",BUILD:Y="B" Q
 ;
PKG W !,"Will only update the Version number.",!
 X ^%ZOSF("RSEL") G EXIT:$O(^UTILITY($J,0))="",BLD
 ;
BUILD W !!,"This will use the BUILD file for the list of routines to update."
 W !,"It will update the Patch number of the patch list."
 S DIC="^XPD(9.6,",DIC(0)="AEMQZ" D ^DIC G EXIT:Y'>0 S BLDA=+Y
 S X=$P(Y,"^",2),XTV(4)=$$PKG^XPDUTL(X),XTV(3)=$$VER^XPDUTL(X)
 I X["*" D
 . S XTV(3)=$P(X,"*",2),XTVPCH=$P(X,"*",3),XTV(4)=$$GET1^DIQ(9.6,BLDA_",",1),XTV(5)=0,XTV(2)=1
 . S XTV(99)="S Y=(T?.E1P1"""_XTVPCH_"""1P.E)"
 . Q
 D RTN^XTRUTL1(BLDA)
 G EXIT:$O(^UTILITY($J,""))=""
 G 3
 ;
BLD K DIR
 S DIR(0)="FA^1:8^K:'(X?1.2N1"".""1.2N.1(1""T"",1""V"").2N) X",DIR("A")="WHAT IS THE VERSION NUMBER: ",DIR("?")="Enter a number of the form nn.nn[Tnn or Vnn]"
 D ^DIR G EXIT:$D(DIRUT) S XTV(3)=X
 ;
2 K DIR
 S DIR(0)="F^1:30^K:X[U X",DIR("A")="Package Name",DIR("?")="The package name will go into the 4th piece of the second line."
 D ^DIR G EXIT:$D(DTOUT)!$D(DUOUT) S:X]"" XTV(4)=X
 ;
3 I XTV(2) W !,"This date is only used if building a new second line."
 K DIR S DIR(0)="D",DIR("A")="Enter the Version Date",DIR("?")="The DATE of this Version"
 D ^DIR G EXIT:$D(DIRUT) S XTV(6)=$$FMTE^XLFDT(Y,1) W "  ",XTV(6)
 ;
 K DIR S DIR(0)="Y",DIR("A")="Clear the 'Patch List'",DIR("B")="YES",DIR("?")="Answer YES to remove the list of patch numbers from the 5th piece of the second line."
 I 'XTV(2) D ^DIR G EXIT:$D(DIRUT) S XTV(5)=Y
 ;
OK W "  OK.",!
 K DIR
 S DIR("A",1)=" SETTING "_$S(XTV(2):"Patch",1:"Version")_" number to "_$S(XTV(2):XTVPCH,1:XTV(3)),DIR(0)="Y",DIR("A")=" Are you ready",DIR("B")="NO"
 D ^DIR G:Y'=1 EXIT
 W ! N AQ,CQ,I,SQ,DQ,R,T,T1,TO,TAB
 S AQ="**",CQ=",",SQ=";",DQ=" ",R=0,T1=" ;;"_XTV(3)_SQ_XTV(4)_";;"_XTV(6)
 ;DoIt
 F I=0:0 S R=$O(^UTILITY($J,R)) Q:'$L(R)  D XTV(R) W $J(R,9),?15,T,!
 W !,"DONE",!
EXIT K ^UTILITY($J),^TMP($J)
 Q
 ;
XTV(RN) ;
 N DIF,XCNP,DIE,XCN,IX,P
 K ^TMP($J) S DIF="^TMP($J,",XCNP=0,X=RN X ^%ZOSF("LOAD")
 S IX=2,(T,TO)=^TMP($J,IX,0)
 S:T?.8E1" ;"1N.E $P(T,SQ)=$P(T,SQ)_SQ I T'?.8E1" ;;"1N.E S T=T1,IX=1.5,^TMP($J,IX,0)=T1
 I 'XTV(2) S $P(T,SQ,3,4)=XTV(3)_SQ_XTV(4) S:XTV(5) $P(T,SQ,5)="" S $P(T,SQ,6)=XTV(6)
 I XTV(2) X XTV(99) I 'Y S P=$P($P(T,SQ,5),AQ,2),P=AQ_$S($L(P):P_CQ_XTVPCH,1:XTVPCH)_AQ,$P(T,SQ,5)=P
 I T'=TO S ^TMP($J,IX,0)=T
 S DIE=DIF,XCN=0,X=RN X ^%ZOSF("SAVE")
 Q
 ;old code
 ;X XTV(11),XTV(10):'XTV(2),XTV(12):XTV(2),XTV(15) W $J(R,9),?15,T,!"
 ;ZR +2 ZI T ZS @R"
