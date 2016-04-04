DIUTL ;GFT/GFT - TIMSON'S UTILITIES;24JAN2013
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**76,999,1003,1004,1023**
 ;
 ;
NAKED(DIUTLREF) ;The argument is evaluated and returned, while keeping the naked reference as it was!
 N DIUTLNKD S DIUTLNKD=$NA(^(0))
 X "S DIUTLREF="_DIUTLREF
 D  Q DIUTLREF
 .I $D(@DIUTLNKD)
 ;
 ;
DATE(Y) ;**CCO/NI   RETURN A DATE
 I Y X ^DD("DD")
 Q Y
 ;
 ;
NOWINT() ;INTERNAL VERSION OF NOW
 N %,%I,%H,%M,%D,%Y,X
 D NOW^%DTC Q %
 ;
 ;
NOW() ;EXTERNAL NOW
 N X S X=$$NOWINT Q $$DATE(X-(X#.0001))
 ;
 ;
WP(DIRF,DIWL,DIWR,DIWPUT) ;Write out WP field (if any) stored at DIRF, or put it in DIWPUT array
 N DIWF,Z,A1,D,X,DIW,DIWT,DN,I,DIWI,DIWTC,DIWX
 K ^UTILITY($J,"W")
 S DIWF=$E("W",'$D(DIWPUT))_"|" S:'$G(IOM) IOM=80 S:'$G(DIWR) DIWR=IOM S:'$G(DIWL) DIWL=1
 S A1=$P($G(@DIRF@(0)),U,3) F D=0:0 S D=$O(@DIRF@(D)) Q:D>A1&A1!'D  S X=^(D,0) D ^DIWP G QWP:$G(DN)=0
 I $G(DIWPUT)]"" D  Q 1
 .K @DIWPUT M @DIWPUT=^UTILITY($J,"W")
 D ^DIWW
QWP I $G(DN)'=0 Q 1
 K DIOEND Q 0
 ;
IJ(N) ;build I & J arrays given subfile number N
 N A K I,J
 S J(0)=N,N=0
0 I $D(^DIC(J(0),0,"GL")) S I(0)=^("GL") Q
 S A=$G(^DD(J(0),0,"UP")) Q:A=""
 S I=$O(^DD(A,"SB",J(0),0)) Q:'I
 S I=$P($P($G(^DD(A,I,0)),U,4),";") Q:I=""
 I +I'=I S I=""""_I_""""
 F J=N:-1:0 S J(J+1)=J(J) S:J I(J+1)=I(J)
 S J(0)=A,I(1)=I,N=N+1 G 0
 ;
 ;
DIVR(DI,DIFLD) ;verify
 N DIVZ,S,A,DA,DICL,V,Z,DDC,DR,N,Y,I,J,Q,W,V,T,DQI
 K ^UTILITY("DIVR",$J),^DD(U,$J)
 D IJ(DI)
 I '$O(@(I(0)_"0)")) Q  ;File must have some entries!
 S S=";",Q="""",V=$O(J(""),-1),A=DI,DA=DIFLD
 S DR=$P(^DD(DI,DIFLD,0),U,2),Z=$P(^(0),U,3),$P(Y(0),U,4)=$P(^(0),U,4),DDC=$P(^(0),U,5,999)
 Q:DR["W"!(DR["C")
 F T="N","S","V","P","K","F" Q:DR[T
 W !!,"SINCE YOU HAVE CHANGED THE FIELD DEFINITION,",!,"EXISTING '",$P(^(0),U),"' DATA WILL NOW BE CHECKED FOR INCONSISTENCIES",!,"OK"
 S %=1 D YN^DICN Q:%-1
 ;D ^%ZIS Q:POP
 ;U IO   WON'T WORK BECAUSE Q+3^DIVR ASKS TO STORE IN TEMPLATE
 D EN^DIVR(DI,DIFLD)
 ;D ^%ZISC
 Q
