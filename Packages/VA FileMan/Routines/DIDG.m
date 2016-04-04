DIDG ;SFISC/RWF-GLOBAL MAP ;10JAN2006
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**105,999,1022**
 ;
 K W S DJ(Z)=D0,F=0,W=F(Z),M=1,DP=0
 W !
UP I $D(^DD(W,0,"UP")) S Y=^("UP"),N=$O(^DD(Y,"SB",W,0)) I $D(^DD(Y,N,0)) S F=F+1,W(F)=$P($P(^(0),U,4),";",1),W=Y G UP
 S W=$S($D(^DIC(W,0,"GL")):^("GL"),1:"^("),Y=0 F N=F:-1:1 S W=W_"D"_Y_","_$S(+W(N)=W(N):W(N),1:""""_W(N)_"""")_",",Y=Y+1
 S DID(Z-1)=W K W
 ;
L S DN(Z)=""
A S DN(Z)=$O(^DD(F(Z),"GL",DN(Z))),DP(0)=0 I DN(Z)="" D POP Q
 S DID(Z)=DID(Z-1)_"D"_(F+Z-1)_","_DN(Z) I $O(^DD(F(Z),"GL",DN(Z),""))=0 S DP=""
 E  S W=DID(Z)_")=" W ! D WL Q:M=U
B S DP=$O(^DD(F(Z),"GL",DN(Z),DP)) G PUSH:DP=0,A:DP=""
 S DF=$O(^DD(F(Z),"GL",DN(Z),DP,0))
 I DP(0)+1<DP F I1=DP(0)+1:1:DP-1 S W=" ^ " D WL Q:M=U
 S N=^DD(F(Z),DF,0),DP(0)=DP
 S X=$P(N,U,2) I +X S Z=Z+1,F(Z)=+X D L G B
 S W="(#"_DF_") "_$P(N,U,1)_" ["_DP
 F Y="F","S","D","N","P","W","V","K" I X[Y S W=W_Y S:Y="P" W=W_":"_+$P(X,"P",2)
 S W=W_"] ^ " D WL Q:M=U  G B
 ;
PUSH S N=$O(^DD(F(Z),"GL",DN(Z),DP,0)) S:N="" N=-1 S Y=^DD(F(Z),N,0),DID(Z)=DID(Z)_","
 W !,DID(Z)_"0)=^"_$P(Y,U,2)_"^^  (#",N,") "_$P(Y,U,1) S Z=Z+1,F(Z)=+$P(Y,U,2)
 D L Q:M=U  G A
 ;
POP S Z=Z-1,DID(Z)=$E(DID(Z),1,$L(DID(Z))-1) Q:Z  K DN,W,DP,DG,DID S DN=0 W ! Q
 ;
END ;
 S S=0,M=1
T1 S S=S+1 D:$Y+3>IOSL HDR Q:M=U
 W !!,$S(S<4:$P("INPU^PRIN^SOR",U,S)_"T TEMPLATE(S):",1:"FORM(S)/BLOCK(S):")
 S DFF="^DI"_$P("E^PT^BT^ST(.403)",U,S),DA=""
 F  S DA=$O(@DFF@("F"_F(1),DA)) Q:DA=""  D  Q:M=U
 . S DUB=0 F  S DUB=$O(@DFF@("F"_F(1),DA,DUB)) Q:DUB'>0  D  Q:M=U
 .. I $D(@DFF@(DUB,0))#2 S %1=^(0) D TEMPL
 K %1 Q:M=U  G T1:S<4
Q Q
TEMPL I $Y+3>IOSL D HDR Q:M=U
 N % S %=$S($D(^("ROU")):"Compiled: "_^("ROU"),'$D(^("ROU"))&($D(^("ROUOLD"))):"Previously Compiled: "_^("ROUOLD"),1:"")
 I %]"",DFF["DIBT" S %=%_"*"
 I DFF'["DIST" W !,DFF,"("_DUB_")= ",$P(%1,U)_"    "_%
 E  D FORM
 Q
WL I $Y+4>IOSL S %1=W D HD Q:M=U  S W=%1 I W[DID(Z) S W=""
 F I=1:1 S Y=$P(W," ",I)_" " Q:$P(W," ",I,99)=""  W:$X+$L(Y)+2>IOM !,?$L(DID(Z)),"==>" W Y
 Q
W W:$X+$L(W)+3>IOM !,?$S(IOM-$L(W)-5<M:IOM-5-$L(W),1:M),S S %Y=$E(W,IOM-$X,999) W $E(W,1,IOM-$X-1),S Q:%Y=""  S W=%Y G W
 ;
HD S DC=DC+1 D ^DIDH Q:M=U  W !,DID(Z),")= " Q
 ;
HDR ;
 S DC=DC+1 I IOST?1"C".E W $C(7) R M:DTIME S:'$T M=U Q:M=U
H1 W:$D(DIFF)&($Y) @IOF S DIFF=1 W "TEMPLATE LIST  --  FILE #"_DIB,?(IOM-20),$$OUT^DIALOGU(DT,"FMTE","2D")_"    "_$$EZBLD^DIALOG(7095,DC) ;**CCO/NI  DATE AND 'PAGE'
 S M="",$P(M,"-",IOM)="" W !,M
 Q
 ;
FORM ;
 W !,"^DIST(.403,"_DUB_")= ",$P(%1,U)_"    "_%
 ;
 N B,L,P
 S L=1,L(1)=U
 S P=0 F  S P=$O(^DIST(.403,DUB,40,P)) Q:'P  D  Q:M=U
 . Q:$D(^DIST(.403,DUB,40,P,0))[0  S B=$P(^(0),U,2) D:B BLOCK  Q:M=U
 . S B=0 F  S B=$O(^DIST(.403,DUB,40,P,40,B)) Q:'B  D BLOCK  Q:M=U
 W !
 Q
BLOCK ;
 N I
 F I=1:1:L I L(I)[(U_B_U) G BLOCKQ
 S:$L(L)+$L(B)+1>245 L=L+1,L(L)=U S L(L)=L(L)_B_U
 Q:$D(^DIST(.404,B,0))[0  S %1=^(0)
 ;
 I $Y+3>IOSL D HDR Q:M=U
 W !?2,"^DIST(.404,"_B_")= ",$P(%1,U)
BLOCKQ Q
