DIFGO ;SFISC/XAK-FILEGRAM OPTIONS ;10:15 AM  7 Aug 2002
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**47,999**
 ;
0 S DIC="^DOPT(""DIFG"","
 G OPT:$D(^DOPT("DIFG",6)) S ^(0)="FILEGRAM OPTION^1.01" K ^("B")
 F X=1:1:6 S ^DOPT("DIFG",X,0)=$P($T(@X),";;",2)
 S DIK=DIC D IXALL^DIK
OPT ;
 S DIC(0)="AEQIZ" D ^DIC G Q:Y<0 S DI=+Y D EN G 0
 ;
EN ;Entry point for all filegram options
 S:'$D(Y) Y=0 S DIC("S")="I Y>1.99" D:DI#2 ^DICRW G:Y<0 Q K DIC("S") ;ihs/ohprd/dg 8-21-91
 D @DI W !!
Q K %,DIC,DIK,DI,DA,I,J,X,Y Q
 ;
1 ;;CREATE/EDIT FILEGRAM TEMPLATE
 G EN^DIFGA
 ;
2 ;;DISPLAY FILEGRAM TEMPLATE
 S DIC("A")="Select FILEGRAM TEMPLATE: "
 S DIC="^DIPT(",DIC(0)="QEAM",DIC("S")="I $P(^(0),U,8)=1" D ^DIC I Y<0 K DIC Q
 W !! S DA=+Y,DIQ(0)="C" D EN^DIQ K DIC,DIQ G 2
 Q
 ;
3 ;;GENERATE FILEGRAM
 I '($D(IO)#2) D HOME^%ZIS
 I DUZ'>0 W $C(7),!!,"INVALID USER.  YOU CAN'T USE THIS OPTION." Q
 S DIC=+Y G ^DIFGG
 ;
 ;
4 ;;VIEW FILEGRAM
 W !! S DIC(0)="ZQEAMIN",DIC=1.12 D ^DIC Q:Y<0  S IOP="HOME" D ^%ZIS Q:POP
 S D0=+Y D EN1 G 4
EN1 S X=Y(0),Y=$P(X,U,6),Y=$S($D(^XMB(3.9,+Y,0))#2:$P(^(0),U),1:Y) W !!,Y
 S Y=$P(X,U,2) W !,$S(Y="s":"Sent",Y="i":"Installed",1:Y)
 W " on " S Y=$P(X,U) D DT W " by ",$P(X,U,3)
 S DIWL=1,DIWR=78,DIWF="WN" S D0=$P(X,U,6) S:'$D(^XMB(3.9,+D0,0)) D0=-1
 W !! S S=5,D=0 F  S (D,D1)=$O(^XMB(3.9,D0,2,D)) Q:D'>0  I $D(^(D,0))#2 S X=^(0) D ^DIWP Q:'$D(D)  S D=D1,S=S+1 I $E(IOST)="C",S+4>IOSL S DIR(0)="E" D ^DIR Q:'Y  S S=0
 S:D="" (D,D1)=-1 D 0^DIWW K DIP,Y,DIWF
 Q
DT X ^DD("DD")
 W Y Q
 ;
5 ;;SPECIFIERS
 S DI=+Y G 99^DIU
 ;
6 ;;INSTALL/VERIFY FILEGRAM
 S DIC(0)="QEAMNIZ",DIC=1.12 D ^DIC K DIC Q:Y<0  Q:'$P(Y(0),U,6)
 S DIFGLO="^XMB(3.9,"_$P(Y(0),U,6)_",2,",DIFGG=+Y
 D ^DIFG W !,$S($D(DIFGER):"UNSUCCESSFUL INSTALLATION: "_DIFGER,1:"DONE")
 S $P(^DIAR(1.12,DIFGG,0),U,2)=$S($D(DIFGER):"u",1:"i") K DIFGER,DIFGG Q
