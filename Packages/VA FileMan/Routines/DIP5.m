DIP5 ;SFISC/GFT-INITIALIZE TO PROCESS THE PRINT ;16NOV2007
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**32,97,99,1003,1005,1031**
 ;
 S %H=$H D YMD^%DTC S DT=X K %H,^UTILITY($J),^("DIL",$J)
 I $G(DIFIXPT)=1 D  G GO
 . S ^UTILITY($J,1)="S DIFIXPTH="""_$$CONVQQ^DILIBF(DHD)_""",DC=1"
 . Q
 U IO
 S Z=IOM-33,DIOSL=IOSL,M=$P("I 1 S Y=1,DIFF=1 W:DC?.N $C(7) R:DC?.N Y:DTIME S:'$T Y=U S:Y=U (DN,S)=0 I Y'=U ",U,IOST?1"C".E)
 I M]"",DHD="@@" S M=M_"S $Y=0 "
 S ^UTILITY($J,1)=M_"S DC=$P(DC,"","",2)+DC+1",M=DHD?1"W ".E
 I DHD'="@@" S ^UTILITY($J,1)=^(1)_" W:$D(DIFF)&($Y) "_IOF_$P(",#",U,IOF'["#"),A1="S DIFF=1,$X=0,$Y=0" S:$L(^UTILITY($J,1))+$L(A1)>200 ^(1.3)=A1,A1="X ^(1.3)" S ^(1)=^(1)_" "_A1 K A1
 I W S ^(1)=^(1)_" W $C(7)"_$S(F:"",1:" U """_IO(0)_"""")_" R Y"_$S(F:"",1:" U IO")_" W """""
DIOSUBHD I M S ^(1)=^(1)_" X ^(1.5)",^(1.5)=DHD D:$D(DIOSUBHD)  G GO
 .S ^(1)=^(1)_" D SUBHEADS^DIL" ;IF THERE ARE SUBHEADERS WITH SPECIAL HEADING
 .I $G(DIPZ) N R S R=$G(^DIPT(DIPZ,"ROU")) I R?1"^"1.E S ^(1)=^UTILITY($J,1)_" D HEAD"_R Q
 .S ^(1)=^UTILITY($J,1)_" W !,$TR($J("""","_IOM_"),"" "",""-"")"
 I DHD'?.P1"[".E1"]",DHD'?1"@".E D
EGP .N D,X,% S M=$P($H,C,2)\60,^UTILITY($J,2)=" N Y S Y=""    ""_$$DATE^DIUTL("_(M#60/100+(M\60)/100+DT)_")_""   ""_$$EZBLD^DIALOG(7095,DC) W:$X+$L(Y)>IOM ! W ?IOM-$L(Y),Y",D=3 ;**CCO/NI WRITE PAGE NUMBER
 .I DIPCRIT S X="",%=0 D
 ..N A,B,S S (B,S)=1
 ..F  S %=$O(DISTXT(%)) D:'% AS Q:'%  S A=$G(DISTXT(%,0)) I A]"" S A=$$CONVQQ^DILIBF(A) D:$L(X)+$L(A)+20>IOM AS S X=X_$P(",  ^",U,(X]""))_A
 ..S S=1,B=2
 ..F  S %=$O(DPP(%)) D:%="" AS Q:%=""  S A=$G(DPP(%,"TXT")) I A]"" S A=$$CONVQQ^DILIBF(A) D:$L(X)+$L(A)+20>IOM AS S X=X_$P(",  ^",U,(X]""))_A
 ..I $G(DIPZ) F S=3:1:D S A=$G(^UTILITY($J,S)) I A]"",$D(^(S+1)) S ^(S)=A_" X ^UTILITY($J,"_(S+1)_")"
 ..I DIPCRIT=1,D>3 S:$G(DIPZ) ^(D-1)=^UTILITY($J,D-1)_" X ^UTILITY($J,"_D_")" S ^UTILITY($J,D)="S DIPCRIT=0",D=D+1
 ..Q
 .S %=$S($D(^UTILITY($J,3)):28,1:0),M="W """_DHD_"""" S:$L(M)+$L(^(2))+%>252 ^(2.5)=DHD,M="W ^(2.5)" S ^(2)=M_^(2)
 .I $G(DIPZ),%>0 S ^(2)=^(2)_" X"_$P(":DIPCRIT^",U,(DIPCRIT=1))_" ^UTILITY($J,3)"
 .S DHD=D Q
GO S X=0 F Y=$G(DPP(0))+1:1 Q:'$D(DPP(Y))  S X=X+1 D
 . Q:$D(DPP(Y,"SER"))#2
 . I X=1,'$O(DPP(Y)) Q:'$D(DPP(Y,"PTRIX"))  Q:$O(DPP(Y,0))
 . I $O(DPP(Y,0)) K:$D(DPP(Y,"PTRIX")) DPP(Y,"PTRIX"),DPP(Y,"IX") Q
 . I $D(DPP(Y,"CM")),'$D(DPP(Y,"PTRIX")) Q
 . N N,%,X,S S N=0,(%,X)="",S=$P(DPP(Y),U) Q:S<2
 . I $P(DPP(Y),U,2)=.01!($P(DPP(Y),U,2)=0) I '$D(DPP(Y,"F")),'$D(DPP(Y,"T")) S (%,X)=0 G CAL
 . D
 .. N I S I=Y N Y,DIBT1
 .. D SER^DIOQ(S,DPP(I,"GET"),DPP(I,"QCON"),$D(DPP(I,"IX"))#2,.X,.%,N)
 .. Q
CAL .I $D(DPP(Y,"PTRIX")) D
 .. N F,T,N S F=+$P($G(@(^DIC(+S,0,"GL")_"0)")),U,4)
 .. S T=$P($G(^DD(+S,+$P($P(DPP(Y),U,4),"""",2),0)),U,3) Q:T=""  S T=$P($G(@("^"_T_"0)")),U,4)
 .. S N=$S(Y>($G(DPP(0))+1):2,$O(DPP(Y)):2,1:1)
 .. I (T*(1-%)*N)>F S X=% K DPP(Y,"IX"),DPP(Y,"PTRIX")
 .. Q
 . Q:%=""  Q:X=""  S X=X_U_%,DPP(Y,"SER")=X
 . I $G(DIBT1),$D(^DIBT(DIBT1,2,Y)) S ^DIBT(DIBT1,2,Y,"SER")=X
 . Q
 S X=0 F Y=1:1:DPP I $P(DPP(Y),U,4)["!" S X=1,DRK=1 Q
FIELDS K R G DIPZ:$D(DIPZ) D INIT S R=DE,DJ=-1 I X S (X,W)="",Y=",DRK",DRJ=0,DLN=3 K DNP D O^DIL
DIL D ^DIL:R]"" S DJ=$S(DIPT:+$O(^DIPT(DIPT,"F",DJ)),1:+$O(^UTILITY("DIP2",$J,DJ))) I DJ S R=^(DJ) G DIL
 D UNSTACK^DIL:DM,A^DIL G ^DIL2
 ;
AS S:X]"" ^UTILITY($J,D)="W"_$P(":DIPCRIT^",U,DIPCRIT)_" !,?"_$S(S=1:"0,"_""""_$P("Search^Sort",U,B)_" Criteria: ",1:"15,"_"""")_X_"""",D=D+1,S=S+1
 S X="" Q
 ;
INIT ;
 D:'$D(DISYS) OS^DII K DIL,DIWR S DN=-2,(DIL,DIL0,DIWL,DIO,DIO("SCR"),DM,DG,DX,DHT,DLN)=0,DY="D0",DI=DK_DY,@("DP=+$P("_DK_"0),U,2)"),M(DP)=1,DP(0)=DP,F="",Y=$S($D(^DD("OS"))[0!'$D(^DD("OS",DISYS,0)):0,1:$P(^(0),U,2)),DISMIN=99999
 S DISEARCH=0 ; Initialize SEARCH Switch SO-2/24/2000
 Q
 ;
DIPZ I $S('$D(^DIPT(DIPZ,"ROU")):1,^("ROU")'[U:1,'$D(^("IOM")):1,1:^("IOM")>IOM)!X!$S($G(^("ROULANG")):^("ROULANG")-$G(DUZ("LANG")),1:0) S Y=DIPZ D F^DIP21 K DIPZ G GO ;**CCO/NI DON'T USE PRINT TEMPLATE COMPILED IN WRONG LANGUAGE
 S Y=DIPZ D F^DIP21 S DK=DCC D INIT S ^UTILITY($J,99,1)="D "_^DIPT(DIPZ,"ROU"),DX=1
 S X="" F DG=0:0 S X=$O(^DIPT(DIPZ,"STATS",X)) Q:X=""  M @X=^(X)
 F X=-1:0 S X=$O(^DIPT(DIPZ,"T",X)) Q:'X  S ^UTILITY($J,"T",X)=^(X)
 F X=-1:0 S X=$O(DPQ(X)) Q:X=""  F %=-1:0 S %=$O(DPQ(X,%)) Q:%=""  K:$D(^DIPT("AF",X,$S(%:%,1:.001),DIPZ)) DPQ(X,%)
 G ^DIL2
