DIFROM ;SFISC/XAK-GENERATE INITS ; 03DEC2012
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**V22.2**
 ;
 D Q
 S X=$S('$D(^DD("VERSION"))#2:0,1:^("VERSION")),Y=$P($T(DIFROM+1),";",3) G:X'=Y ERV K X,Y
 I $S('$D(DUZ(0)):1,DUZ(0)'="@":1,1:0) W !,"PROGRAMMER ACCESS REQUIRED",! Q
 D WARN
 S DIR("A")="Enter the Name of the Package (2-4 characters)"
 S DIR(0)="FO^2:4:0^I X'?1U1.NU K X"
 S DIR("?")="^D R^DIFROMH",DIR("??")=DIR("?")
 D ^DIR G Q:$D(DIRUT) K DIR
 S DIC="^DIC(9.4,",DIC(0)="EZ",D="C" D IX^DIC K D,DIC S DPK=+Y,DPK(0)=$S($D(Y(0)):Y(0),1:"")
R W !!,"I am going to create a routine called '",X,"INIT'."
 S DTL=X,X=X_"INIT" D OS^DII
 I $D(^DD("OS",DISYS,18)) X ^(18) I  W $C(7),!,"but '"_X_"' is ALREADY ON FILE!" S Q=1
 K DIR S DIR("A")="Is that OK",DIR(0)="Y",DIR("??")="^D R1^DIFROMH"
 D ^DIR G Q:$D(DIRUT)!'Y
 S DIR("A")="Would you like to include Data Dictionaries",DIR("B")="YES"
 S DIR("??")="^D R3^DIFROMH" D ^DIR G Q:$D(DIRUT) I 'Y S F(-1)=0 G DD
 G L:DPK<0 S DIR("A")="Would you like to see the package definition"
 S DIR("??")="^D CUR^DIFROMH1",DIR("B")="NO" D ^DIR G Q:$D(DIRUT)
 I Y D L^DIFROMH1
 S DIR("A")="Do you want to accept the current definition"
 S DIR(0)="Y",DIR("??")="^D PKG^DIFROMH1" D ^DIR G Q:$D(DIRUT) S DIH=Y
 F DA=0:0 S DA=$O(^DIC(9.4,DPK,4,DA)) G:'$D(^(+DA,0)) DD:$D(F),L S Y=+^(0) I $D(^DIC(Y,0))#2 S F(Y)=$P(^(0),U) W !!,F(Y) D SF G Q:%<0
L W !!,"THEN PLEASE LIST THE FILES THAT YOU WISH TO TRANSPORT:" S DIH=0,DPK=-1
 F F=1:1 G Q:$D(DTOUT) K DIC S DIC("S")="I Y>1.9999&'$D(F(+Y))",DIC(0)="AIQEZ",DIC="^DIC(" D ^DIC G:Y<0 Q:X[U,DD S F(+Y)=$P(Y,U,2) D F
DD W ! F Y=1,2,3,4 S D=$P("DIE^DIPT^DIBT^DIST",U,Y),DIC=$P("INPUT^PRINT^SORT^FORM(S):",U,Y)_$S(Y<4:" TEMPLATE(S):",1:"") F %=0:0 S %=$O(^DIC(9.4,DPK,D,%)) Q:'$D(^(+%,0))  S DH=$P(^(0),U),X=$P(^(0),U,2) D T
 S DN=DTL_$E("INI",1,5-$L(DTL))
 K ^UTILITY(U,$J),DR S DRN=0,F=0,Q=DPK G Q:$D(F)+$D(Q)=2
 D VER^DIFROM12 G Q:$D(DIRUT)
S G ^DIFROM0
 ;
T W !,DIC,?24,DH
 I Y'=4 F F=0:0 S @("F=$O(^"_D_"(""B"",DH,F))"),DIC="" Q:'F  I @("$D(^"_D_"(F,0))"),$P(^(0),U,4)=X!'X S Q(D,F)="",DIFC=1 G TQ
 I Y=4 F F=0:0 S F=$O(^DIST(.403,"B",DH,F)),DIC="" Q:'F  I $D(^DIST(.403,F,0)),$P(^(0),U,8)=X S Q(D,F)="",DIFC=1 G TQ
 W $C(7)," **NOT FOUND** "
TQ Q
 ;
SF G F:$O(^DIC(9.4,DPK,4,DA,1,0))'>0
 F %=0:0 S %=$O(^DIC(9.4,DPK,4,DA,1,%)) Q:%'>0  I $D(^(%,0)) S E=$P(^(0),U),D=$O(^DD(+Y,"B",E,0)) D:D="" ERF I $D(^DD(+Y,D,0)) S F(+Y,+Y,D)="",%C=+$P(^(0),U,2) I %C W "  (",E,")" S F(+Y,%C)=0
 S F(+Y,+Y)=1,E=+Y S:(+Y'=200)!(DTL="XU") F(+Y,+Y,.01)=0 G E
F S F(+Y,+Y)=0,%=1,E=0 K %A
 ; VEN/SMH 3121029 - Change below to that S F(+Y,D)=0 not "", to conform with KIDS FIA format. 
 ; IX & KEYS on subfiles don't get exported with KIDS otherwise. For V22.2.
E F E=E:0 S E=$O(F(+Y,E)) Q:E'>0  F D=0:0 S D=$O(^DD(E,"SB",D)) Q:D'>0  I Y-E!'$D(%A)!$D(%A(D)) S F(+Y,D)=0 S:$D(%A) %A(D)=0
 S F(+Y,0)=^DIC(+Y,0,"GL"),D=$P(@(F(+Y,0)_"0)"),U,4),DPK(1)=+Y S:D<2 D=""
 S DA(1)=DPK,DR="222.1;222.2;223;222.4;222.7;S:""n""[X Y=0;222.8;222.9;"
 S DIE=$S(DPK>0:"^DIC(9.4,",1:"^UTILITY($J,")_DA(1)_",4,"
 I DPK<0 S ^UTILITY($J,-1,4,0)="^9.44",^(+Y,0)=+Y,DA=+Y
 I 'DIH W ! S DIE("W")="W !?2,$P(DQ(DQ),U),?32,"": """ D ^DIE I $D(Y) S %=-1
 S F(DPK(1),-222)=$S($D(@(DIE_"DA,222)")):^(222),1:"y"),F(DPK(1),-223)=$S($D(^(223)):^(223),1:"") K DIE,DR
 Q
 ;
ERF S D=-1 W $C(7),!,"  INVALID FIELD LABEL:  "_E,! Q
ERV W $C(7),!!,"Your FileMan Version number: "_X_"  does not match the version number",!,"on the DIFROM routine: "_Y_" !!",!!,"You must run ^DINIT before you can build an INIT!!",! K X,Y Q
Q G Q^DIFROM11
WARN N I F I=1:1 Q:$T(WARN+I)=""  W !,$P($T(WARN+I),";;",2)
 ;;                    * * Please Note * *
 ;;
 ;;     DIFROM generates routines in the following format:
 ;;
 ;;     nmspInxx
 ;;     ^^^^^^^^
 ;;     ||||||||
 ;;     |||||| \\- xx is any combination of numbers and
 ;;     ||||||     uppercase alpha characters.
 ;;     ||||||
 ;;     ||||| \--- n is a number 0 - 9 and uppercase letter N.
 ;;     |||||
 ;;     |||| \---- I is always uppercase letter I.
 ;;     ||||
 ;;      \\\\----- 2 to 4 characters of package namespace.
 ;;
 ;;     Any routines that support the init process should not
 ;;     be in this format.
 ;;
