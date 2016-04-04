DDSR1 ;SFISC/MKO-PAINT ;11AUG2004
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
CAP ;Write captions in "X" nodes
 N DDGLVAN S DDGLVAN=1 ;** DEFEAT OLD LOGIC ABOUT LO-INTENSITY
 W:$D(DDGLVAN) $P(DDGLVID,DDGLDEL,2)
 ;
EGP N DDCAP,A,C,C1,C2,P,PC,V,X ;**CCO/NI
 I $G(DUZ("LANG"))>1 S DY=$NA(@DDSREFS@("CAP")) F  S DY=$Q(@DY) Q:$QS(DY,4)'="CAP"  D  ;IF WE HAVE A FIELD WITH A FOREIGN LABEL ENTERED, USE IT
 .I $QS(DY,7)=DDS3P S C1=+$QS(DY,8),C2=$P($G(@DDSREFS@(DDS3P,C1)),U,3) I C2 S X=$G(^(C1,+$QS(DY,9),"D")),A=$P(X,U,4) I A S P=$P($G(^DD(C2,A,0)),U),A=$$LABEL^DIALOGZ(C2,A) I A]"",A'=P S DDCAP($$UP^DILIBF($QS(DY,5)))=A
 S DY="" F  S DY=$O(@DDSREFS@("X",DDS3P,DY)) Q:DY=""  S DX=$O(^(DY,"")),DDS3CAP=^(DX) D  X IOXY W DDS3CAP
 .I $G(DUZ("LANG"))>1 D
 ..;I $D(@DDSREFS@("X",DDS3P,DY,DX,"LANG",DUZ("LANG"))) S DDS3CAP=^(DUZ("LANG")) Q
 ..S C="",C2=$$UP^DILIBF(DDS3CAP) F  S C=$O(DDCAP(C)) Q:C=""  D
 ...S C1=$L(C),P=$F(C2,C) I P S $E(DDS3CAP,P-C1,P-1)=$E(DDCAP(C)_$J("",80),1,C1) ;COULD FIND "NAME" IN "FATHER'S NAME" AND REPLACE IT WITH "NOBRE"!
 ..Q
 ..S C=DDS3CAP,C1=C?.E1":" I C1 S C=$E(C,1,$L(C)-1)
 . Q:'$D(@DDSREFS@("X",DDS3P,DY,DX,"A"))  S A=^("A")
 . S X=DDS3CAP,DDS3CAP="",P=1
 . F PC=1:1:$L(A,U) S C=$P(A,U,PC) D:C]""
 .. S C1=$P(C,";"),C2=$P(C,";",2)
 .. S V=$S($P(C,";",3)="U":$P(DDGLVID,DDGLDEL,4),1:"")
 .. S DDS3CAP=DDS3CAP_$E(X,P,C1-1)_V_$E(X,C1,C2)_$P(DDGLVID,DDGLDEL,10)_$S($D(DDGLVAN):$P(DDGLVID,DDGLDEL,2),1:"")
 .. S P=C2+1
 . S DDS3CAP=DDS3CAP_$E(X,P,999)
 ;
 W:$D(DDGLVAN) $P(DDGLVID,DDGLDEL,10)
 K DDS3CAP
 Q
