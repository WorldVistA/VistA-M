DIT2 ;SFISC/GFT-TRANSFER TEMPLATES ;10/16/90  9:37 AM
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
TEM F Z=0:0 W "." S Z=$O(^UTILITY("DITR",$J,DIK,Z)) Q:Z=""  F V=V:1 I $O(@(%Y_"0)"))="" D %XY S ^(0)=$P(@(%Y_"0)"),U,1,3)_U_DDT(0)_U_$P(^(0),U,5,99) K ^("ROU"),^("ROUOLD") K:DIK="^DIBT(" ^DIBT(V,1) Q
 Q
%XY ;
 S %Z=0,%A="",%C(-1)=0,%E=""
S S %B=-1
N S @("%B=$O("_%X_%A_"%B))") S:%B="" %B=-1 S %C(%Z)=%C(%Z-1),%D=$S($D(L(%B)):L(%B),1:%B)
 I %B=-1 Q:'%Z  S @("%B="_$P(%A,",",%Z+%C(%Z-2),%Z+%C(%Z-1))),%Z=%Z-1,%A=$P(%A,",",1,%Z+%C(%Z-1))_$E(",",%Z>0),%E=$P(%E,",",1,%Z+%C(%Z-1))_$E(",",%Z>0) G N
 I $D(@(%X_%A_"%B)"))#2 S W=^(%B) X A D Y^DIT1 X E S @(%Y_%E_"%D)=W") I %A="""DCL""," S ^(%B#1+DHIT_U_$P(%B,U,2))=^(%B) K ^(%B) G N
 I @("$D("_%X_%A_"%B))<9") G N
 S:+%B'=%B %B=""""_%B_"""" S:+%D'=%D %D=""""_%D_""""
 S %A=%A_%B_",",%Z=%Z+1,%E=%E_%D_"," G S
 ;
DCL ;S ^(%B#1+DHIT_U_$P(%B,U,2))=^(%B) K ^(%B) G N
 ;
