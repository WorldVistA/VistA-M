DIFROM12 ;SFISC/XAK-CREATES RTN ENDING IN INIT1 ;12:50 PM  28 Sep 1998
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
VER ;
 W !!?5,"Now you must enter the information that goes on the second line",!?5,"of the INIT routines.",!
 G:DPK<1 V2
 S DIE=9.4,DA=Q,DR=22,DR(2,9.49)=1 D ^DIE I $D(Y) S (DUOUT,DIRUT)=1 Q
 G V2:'$D(D1) S X=^DIC(9.4,DPK,22,D1,0),DPK(1)=$P(X,U,1),DILN2=" ;;"_DPK(1)_";"_$P(^DIC(9.4,DPK,0),U,1)_";;",Y=$P(X,U,2) D DD^%DT S DILN2=DILN2_Y
 W !! Q
V2 K DIR S DIR(0)="F^4:30",DIR("A")="Package Name",DIR("?")="^D PNM^DIFROMH1" D ^DIR Q:$D(DIRUT)  S DILN2=Y
 K DIR S DIR(0)="F^1:9^K:'(X?1.3N.1""."".2N.1A.2N) X",DIR("A")="Version",DIR("?")="^D VER^DIFROMH1" D ^DIR Q:$D(DIRUT)  S DPK(1)=Y,DILN2=" ;;"_Y_";"_DILN2_";;"
 K DIR S DIR(0)="D^::EX",DIR("A")="Date Distributed",DIR("?")="^D VDT^DIFROMH1" D ^DIR Q:$D(DIRUT)  D DD^%DT S DILN2=DILN2_Y
 W !! Q
PKG ;
 Q:DTL="DIPK"!(DTL="DI")
 S %Y="^UTILITY(U,$J,""PKG"",DPK,",%X="^DIC(9.4,"_DPK_","
 W !,"Moving "_$P(^DIC(9.4,DPK,0),U)_" Entry into Init's."
 S D=%X_"""22""," D %XY^%RCR K DR S:$D(^DISV(DUZ,D)) DR=^(D)
 I $P(^DIC(9.4,DPK,0),U,4) S DL=$S($D(^DIC(9.2,+$P(^(0),U,4),0))#2:$P(^(0),U),1:""),$P(^UTILITY(U,$J,"PKG",DPK,0),U,4)=DL
 F %="PRE","INI","INIT" S:$D(^UTILITY(U,$J,"PKG",DPK,%)) $P(^(%),U,2)=""
 K ^UTILITY(U,$J,"PKG",DPK,"VERSION"),DIE Q:'$D(^ORD(100.99,1,5,DPK,0))
OR ;
 S %X="^ORD(100.99,1,5,DPK,",%Y="^UTILITY(U,$J,""OR"",DPK," D %XY^%RCR
 S %=$P(^ORD(100.99,1,5,DPK,0),U,4)
 I %]"" S %=$S($D(^ORD(100.98,%,0)):$P(^(0),U),1:"") I %]"" S $P(^UTILITY(U,$J,"OR",DPK,0),U,4)=%
 F I=0:0 S I=$O(^ORD(100.99,1,5,DPK,1,I)) Q:'I  I $D(^(I,0)) S %=+$P(^(0),U) I $D(^ORD(101,%,0)) S $P(^UTILITY(U,$J,"OR",DPK,1,I,0),U)=$P(^(0),U) D OR1
 F I=0:0 S I=$O(^ORD(100.99,1,5,DPK,5,I)) Q:'I  I $D(^(I,0)) S %=+$P(^(0),U,3) I $D(^ORD(101,%,0)) S $P(^UTILITY(U,$J,"OR",DPK,5,I,0),U,3)=$P(^(0),U)
 K ^UTILITY(U,$J,"OR",DPK,"B")
 Q
OR1 F J=0:0 S J=$O(^ORD(100.99,1,5,DPK,1,I,1,J)) Q:'J  I $D(^(J,0)) S %=+$P(^(0),U) I $D(^ORD(101,%,0)) S $P(^UTILITY(U,$J,"OR",DPK,1,I,1,J,0),U)=$P(^(0),U)
 Q
