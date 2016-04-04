DIDC ;SFISC/STAFF-CONDENSED DD ;26APR2010
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**19,105,999,1024,1039**
 ;
TODAY S DM="",Y=DT,X="I $Y+3>IOSL W $C(7) D P" X ^DD("DD") S DAT=Y ;**CCO/NI TODAY'S DATE
EN S N(0)=$O(^DD(X1),-1),I=0 F  S N(0)=$O(^DD(N(0))) Q:N(0)'>0!(N(0)>X2)  S NAME=$O(^DD(N(0),0,"NM",0)) I NAME'="" S P=0 D P,P2 G:DM["^" EXIT
EXIT K %DT,%ZIS,DAT,I,J,K,K1,M,N,N1,NAME,MO,P,X,X1,X2,Y,KK,NF,NY,POP S D0="B",M=DM K DM Q
P S P=P+1 I IOST?1"C-".E R:P'=1 DM:DTIME Q:DM["^"!'$T
 W:$D(DIFF)&($Y) @IOF S DIFF=1 W !!,"CONDENSED DATA DICTIONARY---",NAME," FILE"," (#",N(0),")" I $D(^%ZOSF("UCI"))#2 X ^("UCI") W ?47,"UCI: "_Y
 W ?63,$S($G(^DD(N(0),0,"VR"))]"":"   VERSION: "_$P(^("VR"),U),1:" ") W !!,"STORED IN: ",$S($D(^DIC(N(0),0,"GL")):^("GL"),1:""),?58,DAT,?70,"PAGE ",P W ! F I=0:1:IOM-1 W "-"
 G P1:P'=1 W !!,?50,"FILE SECURITY"
 W !,?35,"DD SECURITY    : ",$S($D(^DIC(N(0),0,"DD")):^("DD"),1:""),?58,"DELETE SECURITY: ",$S($D(^("DEL")):^("DEL"),1:"")
 W !,?35,"READ SECURITY  : ",$S($D(^("RD")):^("RD"),1:""),?58,"LAYGO SECURITY : ",$S($D(^("LAYGO")):^("LAYGO"),1:"")
 W !,?35,"WRITE SECURITY : ",$S($D(^("WR")):^("WR"),1:"")
AFOF I $D(^VA(200,"AFOF",N(0))) W !?10,"(NOTE: Kernel's File Access Security applies to this File.)",!
 W !,"CROSS REFERENCED BY:",!,?5
 S NY="" F KK=1:1 S NY=$O(^DD(N(0),0,"IX",NY)) Q:NY=""  S NF=+$O(^(NY,0)),N1=+$O(^(NF,0)) D
 .N % S %=0 F  S %=$O(^DD(NF,N1,1,%)) Q:'%  I $D(^(%,0)),+^(0)=N(0),$P(^(0),U,2)=NY W:$X>50&($L($P(^DD(NF,N1,0),"^",1)>20)) !,?5 W " ",$P(^DD(NF,N1,0),"^",1),"(",NY,") "
 D LIST^DIKCP(N(0),"","M")
P1 W !!!,?33,"FILE STRUCTURE",!! W "FIELD",?10,"FIELD",!,"NUMBER",?10,"NAME",! Q
P2 S M(0)=0 F K1=0:0 S M(0)=$O(^DD(N(0),M(0))),K=0 Q:+M(0)'>0!(M(0)?1U.U)  X X Q:DM["^"  W !,M(0),?10,$P(^DD(N(0),M(0),0),U,1)," " D M I J S K=K+1 D MO Q:DM["^"
 Q
MO X X Q:DM["^"  S N(K)=+$P(^DD(N(K-1),M(K-1),0),U,2) S M(K)=0
 F L=0:0 S M(K)=$O(^DD(N(K),M(K))) Q:M(K)'>0  X X Q:DM["^"  W !,?10+((K-1)*5),M(K),?15+((K-1)*5),$P(^DD(N(K),M(K),0),U,1)," " D M I J S K=K+1 D MO Q:DM["^"
 Q:DM["^"  X X Q:DM["^"  S K=K-1 Q
M S J=$P(^(0),U,2) W $S(+J:"(Multiple-"_+J,1:"("_J),"), [",$P(^(0),U,4),"]"
 Q
PTR ;
 S F=0,I=0 F  S F=$O(^UTILITY($J,"P",F)) Q:F=""  D PT
 S F=-1 Q
PT W !,F_" " I ^(F,0) W:$X>24 !?19 W "(#"_^(0)_") "
 S %=0 F  S %=$O(^UTILITY($J,"P",F,%)) Q:%=""  W ?33," ",$S(%=F(1):"",1:$P(^DD(%,0)," SUB-FIELD",1)_":") S S=0 F  S S=$O(^UTILITY($J,"P",F,%,S)) Q:S=""  W ?34,$P(^DD(%,S,0),U)," (#"_S_")",!
 S (%,S)=-1 Q
 ;
L ; CUSTOM LOOP
 I $G(Y)=U!($G(M)=U) G Q
 I DJ,IOST?1"C-".E W $C(7) R X:DTIME I X[U!'$T G Q
 K ^UTILITY($J,0)
DD S DIB=$O(^DD(+DIB)) G:DIB>DIB(1)!(+DIB'=DIB) Q G:$D(^(DIB,0))[0 DD
 I $G(DIPP(0,"IX"))["^DD(DFF,""AUDIT""",$O(^DD(DIB,"AUDIT",""))="" G DD:'$D(^DIC(DIB)) D  G:'DIB!(DIB>DIB(1)) Q
 . F  S DIB=$O(^DIC(+DIB)) Q:'DIB!(DIB>DIB(1))  Q:$O(^DD(DIB,"AUDIT",""))]""
SUBFILES M DPP=DIPP
 F Y="S","N","Q","H","L" D  ;IF THERE ARE SUBTOTALS, ETC, ZERO THEM OUT
 .N C,V S C=Y_"(V)" F V=0:0 S V=$O(@C) Q:V=""  S @C=0
 S L=0,DISEARCH=1,DFF=DIB,DJ=DIJS,DPQ=DIPQ,M=DIMS S:'$D(DIA) DC="," G ^DIO
Q S DFF=DIB(1) G STOP^DIO4
