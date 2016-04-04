DIFROM0 ;SFISC/XAK-GATHER PCS TO SEND ; 31OCT2012
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**1045**
 ;
 S %=2,DIT=0,DIH=""
 I DPK<0,$O(F(0))>0 K DIR S DIR(0)="Y",DIR("A")="Do you want to include all the templates and forms",DIR("B")="NO",DIR("??")="^D NOPKG^DIFROMH" D ^DIR G Q:$D(DIRUT) S DIT=Y=1
 W ! S DIR(0)="YA",DIR("??")="^D ^DIFROMH",DIR("B")="YES"
 ;NOTE: I removed 9.8 (ROUTINE FILE) from this list for V19 but none of the supporting code. (tkw)
 F DL=19,3.6,19.1,.5,9.2,8994 I $D(^DIC(DL,0)) S X=$P(^(0),U),DIR("A")="Would you like to include "_X_"S?"_$J("",17-$L(X)) D ^DIR G Q:$D(DIRUT) I Y=1 S DL(DL)=DL,DIFC=1
 G:$D(F(-1))&('$D(DIFC)) Q
S W ! S DIR("A")="Would you like security codes sent along: ",DIR("B")="NO"
 S DIR("??")="^D S^DIFROMH" D ^DIR G Q:$D(DIRUT) S DSEC=Y=1 K ^UTILITY("DI",$J)
M ;
 S DIR("A")="Maximum Routine Size    (2000 - "_^DD("ROU")_") : ",DIR("B")=^DD("ROU"),DIR(0)="NA^2000:"_^DD("ROU") ; VEN/SMH V22.2
 S DIR("??")="^D M^DIFROMH" D ^DIR G Q:$D(DIRUT) S DIFRM=Y
GO W ! D WAIT^DICD
 D:DPK>0 PKG^DIFROM12
 D  I DTL="DI" S DTL="DD" D  S DTL="DM" D  S DTL="DI"
 .F Y=19,3.6,19.1,.5,9.8,9.2,8994 I $D(DL(Y)) S X=$S(Y=19:"OPT",Y=3.6:"BUL",Y=19.1:"SE",Y=.5:"FUN",Y=9.8:"ROU",Y=9.2:"HEL",Y=8994:"REM") D ADD,A:'Y
 D SBF
 K DL,DIR S DL=DRN,DRN=1 G ^DIFROM1
ADD ;
 S DH=$S(DTL="XU":"DD",1:DTL)
 Q:$D(^DIC(Y,0))[0!$D(DTL(Y))  Q:$P(^(0),X,1)]""!'$D(^(0,"GL"))
 S Y=^("GL"),X=$S(X="ROU":"RTN",X="SE":"KEY",1:X)
 Q
A F D=0:0 S D=$O(^DIC(9.4,DPK,"EX",D)) Q:D'>0  I $P(DH,$P(^(D,0),U))="" G DH
 S D=$O(@(Y_"""B"",DH,0)")),%X=Y_"D,",%Y="^UTILITY(U,$J,X,D,"
 G DH:D'>0,DH:D<100&(X="FUN") S Q(X)=0
 D %XY^%RCR G H:X'="OPT"
 S %=^UTILITY(U,$J,X,D,0),%1=+$P(%,U,12),%1=$S($D(^DIC(9.4,%1,0)):$P(^(0),U),1:""),$P(%,U,12)=%1,$P(%,U,5)=""
 S %1=+$P(%,U,7),%1=$S($D(^DIC(9.2,%1,0)):$P(^(0),U),1:""),$P(%,U,7)=%1,^UTILITY(U,$J,X,D,0)=% K ^(3.96),^(10,"B"),^("C")
 I $D(^UTILITY(U,$J,X,D,220)) S %=^(220),%1=$S($D(^XMB(3.6,+%,0)):$P(^(0),U),1:""),$P(%,U)=%1,%1=$S($D(^XMB(3.8,+$P(%,U,3),0)):$P(^(0),U),1:""),$P(%,U,3)=%1,^UTILITY(U,$J,X,D,220)=%
 F %=0:0 S %=$O(^DIC(19,D,10,%)) Q:%'>0  I $D(^(%,0)),$D(^DIC(19,+^(0),0)) S ^UTILITY(U,$J,X,D,10,%,U)=$P(^(0),U)
H K:"BULKEY"[X ^UTILITY(U,$J,X,D,2) G:X'="HEL" DH
 K ^UTILITY(U,$J,X,D,4) S $P(^(0),U,4)="" K ^(2,"B"),^UTILITY(U,$J,X,D,10,"B")
 F %2=0:0 S %2=$O(^UTILITY(U,$J,X,D,10,%2)) Q:'%2  I $D(^(%2,0))#2 S %1=+^(0),%1=$S($D(^MAG(%1,0)):$P(^(0),U,1),1:"") K:%1="" ^UTILITY(U,$J,X,D,10,%2) I %1]"" S $P(^UTILITY(U,$J,X,D,10,%2,0),U,1)=%1
 F %2=0:0 S %2=$O(^UTILITY(U,$J,X,D,2,%2)) G DH:%2'>0 I $D(^(%2,0))#2,$P(^(0),U,2) S %1=^(0),%=1 D HP1 Q:%<0
 K %1,%2 Q
HP1 I $D(^DIC(9.2,+$P(%1,U,2),0)) S ^UTILITY(U,$J,X,D,2,%2,0)=$P(%1,U)_U_$P(^(0),U) Q
 W !,$C(7),"The Help Frame, "_$P(^DIC(9.2,D,0),U)_" has the keyword "_$P(%1,U)
 W !,"whose Related Frame does not exist.  Shall I exclude it" D YN^DICN
 K:%=1 ^UTILITY(U,$J,X,D,2,%2) Q
 ;
DH S DH=$O(@(Y_"""B"",DH)")) G A:DH]""&(DTL="XU"!($P(DH,DTL,1)="")) Q
 ;
ERM W $C(7),!!?5,"Was not able to get a message number for the network INIT",!?10,"DIFROM ABORTED!!",! Q
 ;
Q G Q^DIFROM11
SBF N I,II
 S I=0 F  S I=$O(F(I)) Q:I'>0  S II=0 F  S II=$O(F(I,II)) Q:II'>0  S ^UTILITY("^",$J,"SBF",I,II)=""
 Q
