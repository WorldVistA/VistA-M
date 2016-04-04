DIVRE ;SFISC/MWE-REQ FLD(S) CHK ;06:27 PM  7 Dec 1999
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**999**
 ;
B K ^UTILITY($J),DIBT S (DK,DIC)=DI,DIC(0)="EQM",DIK=0
 W !,"CHECK WHICH ENTRY: " R X:DTIME G QQ:U[X!'$T
 I X="ALL" D ALL G QQ:$D(DIRUT) I Y S DIROOT=DIU G D
 D ^DIC I Y<0 W:X?1."?" !?3,"You may type 'ALL' to select every entry in the file.",! G B
R S DIK=DIK+1,^UTILITY($J,"DIN",+Y)=""
 S DIC(0)="AEQM",DIC("A")=$$EZBLD^DIALOG(8199)_" " D ^DIC I Y>0 G R ;**CCO/NI 'ANOTHER ONE:'
 Q:'DIK!(X=U)
D ;
 D S2^DIBT1 K DIRUT,DIROUT G QQ:$D(DTOUT)!($D(DUOUT))
 I X]"" G D:Y<0 S:Y>0 DIBT=+Y
 S DIC=DI
 S:$D(^%ZTSK) %ZIS="Q" D ^%ZIS G:POP QQ
 I $G(IO("Q"))=1 G TSK
L I $E(IOST)="C" S DIFF=1
 S (DC,DA,N)=0 S:'$D(DIROOT) DIROOT="^UTILITY($J,""DIN""," F I=0:0 S DA=$O(@(DIROOT_DA_")")) Q:'DA  W:IOST?1"C".E "." D START
 I N U IO S DC=0 D PH F N=1:1 Q:'$D(^UTILITY($J,"DIVRE",N))  S X=^(N) D P I IOST?1"C".E,$Y>(IOSL-4) W $C(7) R X:DTIME Q:X=U!'$T
 I 'N U IO D PH W !!,"NO REQUIRED FIELD IS MISSING"
Q W:$E(IOST)'="C"&($Y) @IOF X $G(^%ZIS("C"))
QQ K DIRUT,DTOUT,DUOUT,DIROUT,DK,C,D,I,J,N,F,S,G,P,L,X,Y,DI,DIK,DIC,DISD,DIREF,DIFLD,DC,DIROOT,DIFF,^UTILITY($J)
 Q
P ;
 D:$Y>(IOSL-3) PH
 S %=$P(X,U),Y=$P(@(^DIC($P(%,";",2),0,"GL")_+%_",0)"),U,1),C=$P(^DD($P(%,";",2),.01,0),U,2) D Y^DIQ
 W !,+$P(X,U),?10,$E(Y,1,20),?35,$P(X,U,2),?50,$P(^DD($P(X,U,2),$P(X,U,3),0),U)
 Q:DUZ(0)'="@"
 I IOM>80 W ?85,$P(X,U,4) Q
 W !?35,$P(X,U,4) Q
PH ;
 S DC=DC+1 W:$D(DIFF)&($Y) @IOF S DIFF=1 W "Required-Field-Check  File: ",DIC_" "_$O(^DD(DIC,0,"NM","")),?(IOM-25) S Y=DT D DD^%DT W ?(IOM-10),"PAGE ",DC
 W !,"Entry",?35,"DD-Number",$S((DUZ(0)="@")+(IOM'>80)=2:"/Path",1:""),?50,"Field" I DUZ(0)="@",IOM>80 W ?85,"Path"
 W ! F L=1:1:(IOM-2) W "-"
 Q
CHECK ;
 I $P(^DD(DIC,DIFLD,0),U,2)'["R",'$D(DIKEYCHK) Q
 S G=$P(^(0),U,4),P=$P(G,";",2),G=$P(G,";") S:'P P=1
 I $D(@(DIREF_","""_G_""")")),$P(^(G),U,P)]"" Q
 N % S %=0 S N=N+1,^UTILITY($J,"DIVRE",N)=D(1)_";"_I(1)_U_DIC_U_DIFLD_DIREF S:$D(DIBT) %=%+1,^DIBT(DIBT,1,D(1))=""
 I %,$G(DIBT) S ^DIBT(DIBT,"QR")=DT_U_%
 Q
START ;
 S L=1,DIC=$S('DIC:+$P(@(DIC_"0)"),U,2),1:DIC),DIREF=^DIC(DIC,0,"GL"),X="",U="^",DIREF=DIREF_DA
M S J(L)=DIREF,I(L)=DIC,D(L)=DA K DIFLIST,DIKEYCHK
 S DIFLD=0 F I=0:0 S DIFLD=$O(^DD(DIC,"RQ",DIFLD)) Q:'DIFLD  S F(L)=DIFLD,DIFLIST(DIFLD)="" D CHECK
 S DIKEYCHK=1,DIFLD=0 F  S DIFLD=$O(^DD("KEY","F",DIC,DIFLD)) Q:'DIFLD  I '$D(DIFLIST(DIFLD)) S F(L)=DIFLD D CHECK
 K DIFLIST,DIKEYCHK S F(L)=""
 S DISD=0 F I=0:0 S DISD=$O(^DD(DIC,"SB",DISD)) Q:'DISD  S S(L)=DISD D NEW
 Q
NEW ;
 S L=L+1
 S DINODE=$P($P(^DD(I(L-1),$O(^DD(I(L-1),"SB",DISD,"")),0),U,4),";")
 I DINODE="" S DINODE=0
 E  I DINODE'=+$P(DINODE,"E") S DINODE=""""_DINODE_""""
 S DIC=DISD,DIREF=DIREF_","_DINODE_"," K DINODE
 S DA=0 F I=0:0 S DA=$O(@(DIREF_DA_")")) Q:'DA  S DIREF(L)=DIREF,DIREF=DIREF_DA D M S DIREF=DIREF(L)
 S L=L-1,DIC=I(L),DIREF=J(L),DA=D(L),DIFLD=F(L),DISD=S(L)
 Q
TSK ;
 S ZTRTN="L^DIVRE",ZTDESC="REQUIRED FIELD CHECK",ZTIO=ION_";"_IOST_";"_IOM
 F N="DIC","^UTILITY($J,","DIROOT" S ZTSAVE(N)=""
 D ^%ZTLOAD X $G(^%ZIS("C")) G QQ
 ;
ALL S DIR(0)="Y",DIR("??")="^D H^DIVRE1"
 S DIR("A")="DO YOU MEAN ALL THE ENTRIES IN THE FILE"
 D ^DIR K DIR S X="ALL"
 Q
