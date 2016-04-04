DIWW ;SFISC/GFT-OUTPUT WP LINE ;5NOV2007
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**64,144,152**
 ;
 F I=0:1 G:$D(DN) QQ:'DN Q:$D(^UTILITY($J,"W"))<9  D T G:$D(DN) QQ:'DN D 0
T W:$X !
B Q:$S($D(DN):'DN,1:0)  I '$D(DIWF) S DIWF=""
 I '$D(DIOT(2)),$D(IOSL),$Y+$S($P(DIWF,"B",2):$P(DIWF,"B",2),1:2)'<IOSL,$D(^UTILITY($J,1))#2,^(1)?1U1P1E.E X ^(1) I $D(DN),'DN S D0="zzzzzz",W=9999999 Q
 F I=$Y+2:1:+$P(DIWF,"T",2) W !
 Q
 ;
A ;
 D 0 G DIWW
 ;
NX ;
 W:$X+1>DIWL ! D B G:$D(DN) Q:'DN
0 ;
 S I=999999,%="" F  S %=$O(^UTILITY($J,"W",%)) Q:%=""  S:$O(^(%,""))<I I=$O(^(""))
1 S %="" F  S %=$O(^UTILITY($J,"W",%)) Q:%=""  I $D(^(%,I)) D W I $D(^UTILITY($J,"W",%))<9 K ^(%) I $O(^(""))="" K DIWI,DIWX,DIWTC
 S:%="" %=-1 G Q
 ;
W G X:^(I,0)="",O:'$D(DIWF) I DIWF[" " S DIWF=$P(DIWF," ",1)_$P(DIWF," ",2) G X:^(0)?." "
 W:$X+(%>0)>% ! I DIWF["L",$D(^("L")) W $E(^("L")_"   ",1,4)
O W ?%-1,^(0)
X D U:$D(^("U")) I $D(^("X")) S Y=^("X") D K X Y Q
K K ^UTILITY($J,"W",%,I) Q
 ;
U Q:'$D(IOST)  Q:IOST'?1"P".E  W $C(13) F DE=1:1:$S($D(^("L")):%+3,1:%-1) W " "
 S DE=1
UU S %Y=$O(^UTILITY($J,"W",%,I,"U","")) I %Y="" S %Y=$L(^UTILITY($J,"W",%,I,0))+1 S:'$D(DIWFWU) DIWFWU=" " D UUU K DIWFWU Q
 S Y=^(%Y) K ^(%Y) I Y="" D UUU K DIWFWU G UU
 S DIWFWU=Y F DE=DE:1 G UU:DE'<%Y W " "
UUU I $D(DIWFWU) F DE=DE:1 Q:DE'<%Y  W DIWFWU
Q Q
QQ K DIWI,DIWX,DIWTC Q
 ;
RCR ;
 N DA,M,DQI,DA
 F M="DIWX","DICMX","DIC","D","D0","D1","D2","D3","D4","D5","D6","D7","Y","I","J" M %=@M N @M M @M=%
 S DQI="Y(",DA="X(",DICMX="X DICMX",DICOMP="ST" S:$D(DIA("P"))#2 J(0)=DIA("P") D EN1^DICOMP
 I '$D(X) Q:DIWF'["?"!(IO(0)=IO)!$D(IO("C"))  U IO(0) W $C(7),!,$P(@(I(0)_"D0,0)"),U),"---",!?4,$P(DIWX,DIW)_": " R X:DTIME,! U IO G BACK
 I Y["m" S DICMX=$S(Y["w":"D ^DIWP",1:"S DIWX=X,DIWTC=1 D DIW^DIWP S DIWI=$J("""","_$L(DIWI)_")") X X S X="" G BACK
 I Y["X" S X=DIW_X_DIW G BACK
 I $P(DIWX,"SETPAGE(",1)="" S ^(DIWL,^UTILITY($J,"W",DIWL),"X")=X,X="" G BACK
 S DICMX=Y["D" X X I DICMX S Y=X X ^DD("DD") S X=Y
 I $P(DIWX,"INDENT(")="" S X=$J(X,$P(DIWF,"I",2)-$L(DIWI)-1)
BACK D C^DIWP:X]"" S X=""
 Q
 ;
DIQ ;
 S DIWF=$E("N",C["L")_"W"_$E("|X",C["X"!(C["x")+1),DIWL=2,DIWR=IOM,X=O_":   " K ^UTILITY($J,"W")
 S W=0 F  D  S W=$O(@(D(DL-1)_"W)")) Q:W'>0!(S=0)  S X=^(W,0)
 .D ^DIWP
 .N W D LF^DIQ
 G DIWW
 ;
H G H^DIO2
DT G DT^DIO2
 ;
N W ! G B
