DIWE5 ;SFISC/GFT-WP, AUX FUNCTIONS ; 15NOV2012
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**999**
 ;
 ;**CCO/NI   ENTIRE ROUTINE CHANGED
LNQ ;
 W !,$$EZBLD^DIALOG(8150),"("_(I'=6)_$P("-"_DWLC,U,DWLC>1)_")" ;**CCO/NI
 I $G(DWL) D
 .W !?9,$$EZBLD^DIALOG(8151,DWL) ;**CCI/NI
 .I DWL>2 W !?9,$$EZBLD^DIALOG(8152,DWL) ;**CCO/NI
 .I DWLC>DWL W !?9,$$EZBLD^DIALOG(8153,DWL+1) ;**CCI/NI
 W ! Q
 ;
WL W !,"INITIALS:",! S X=$P(DIC,"(",1) Q:$D(@X)<9  S X=$O(@(X_"(0)"))-1,I=0 F  S X=$O(^(X)) Q:X=""  W X,!
 S X=-1 Q
NL W !,"TEXT NAMES:",! S %T2="",I=0 F  S %T2=$O(@(DW_")")) Q:%T2=""  W %T2,?20,^(%T2,0),!
 K %T2 Q
 ;
F ;
 W !!,"Line WIDTH: "_DWLW_"//" R X:DTIME S DWLW=$S(X<10:DWLW,X>255:DWLW,1:X\1)
 W !,"PACK "_$S(DWPK:"ON",1:"OFF")_"//" R X:DTIME S DWPK=$S(X="ON":1,1:0)
 Q
X ;FILE TRANSFER
 D:'$D(DISYS) OS^DII
 D  Q:X=""  S DIWL=X,(%,%B)="" X ^DD("OS",DISYS,"EOFF")
 .N DIR,DIRUT,DIROUT,DTOUT,DUOUT
 .W ! S DIR("A")=$$EZBLD^DIALOG(8156) ;MAX STRING LENGTH
 .S DIR("B")=75,DIR(0)="N^3:245:0" D ^DIR K DIR I $D(DIRUT) S X="" Q
 .W !! D BLD^DIALOG(8155),MSG^DIALOG("WM") Q  ; Long messge about 30-sec timeout
ENT I '$D(DIWL) S DIWL=245
A R X#245:30 E  I '$L(X) D S:$L(%B) X ^DD("OS",DISYS,"EON") W !!,$$EZBLD^DIALOG(8157),! Q
 S:X="" X=" " I X?.ANP S Y=X G D
 S I=0,Y=""
C S I=I+1 I $E(X,I,999)?.ANP S Y=Y_$E(X,I,999) G D
 S %=$E(X,I),%0=$A(%)
 I %?1C S %="" I %0=9 S %=$E("         ",1,9-($L(Y)-($L(Y)\9*9)))
 S Y=Y_% D S:$L(Y)>DIWL I ":27:13:"[(":"_%0_":") D S
 G C
D D S G D:$L(Y)'<DIWL S %B=Y,Y="" G A
S S:$L(%B) %B=%B_$S($E(Y)=" ":"",1:" ") S %=%B_Y,%2=$L(%) Q:'%2  S Y=""
 I %2>DIWL F %1=DIWL:-1 I %1<$S(DIWL-12>0:DIWL-12,1:4)!(" -"[$E(%,%1)) S Y=$E(%,%1+1+$S($E(%,%1+1)=" ":1,1:0),999),%=$E(%,1,%1-$S($E(%,%1)=" ":1,1:0)) Q
 S %B="",DWLC=DWLC+1,@(DIC_"DWLC,0)")=%
 Q
TQ ;
 D  G Z^DIWE3
 .N DIP S DIP(1)=J,DIP(2)=I
 .D BLD^DIALOG(9183),MSG^DIALOG("WH") ;**CCO/NI
 ;
IQ ;
 I $D(DC) W:$D(^DD(+$P(DC,U,2),.01,3)) !?4,^(3),! X:$D(^(4)) ^(4) F %=0:0 S %=$O(^DD(+$P(DC,U,2),.01,21,%)) Q:%'>0  W !,^(%,0)
 W !! D BLD^DIALOG(9180),MSG^DIALOG("WH") ;**CCO/NI
 W !,$C(7),$$EZBLD^DIALOG(9181) S %=2 D YN^DICN Q:%-1  ;**CCO/NI
 W !?5,$$EZBLD^DIALOG(9182) ;**CCO/NI
FN S %=15 F  S %=$O(^DD("FUNC",%)) Q:%>97  I $D(^(%,10)) W !," |"_$P(^(0),U,1)_$P("(ARGUMENT)",U,$S('$D(^(3)):1,1:^(3)'=0))_"|",?25 W:$D(^(9)) ^(9)
