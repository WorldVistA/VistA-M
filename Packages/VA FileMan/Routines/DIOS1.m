DIOS1 ;SFISC/GFT-BUILD SORT LOGIC ;04:33 PM  10 Nov 1999
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**2**
 ;
L S X=$P(DPP(DL),U,2) S:X=0 X=.001
 S W=+$P($P(DPP(DL),U,5),";L",2) I W D  G SL
 . I $P(DPP(DL),U,5)[";TXT" S W=W+1
 . S W=$S(W<DIOS:W,1:DIOS),DE(DL)=W,DE(DL,"SIC")=1 Q
 I '$D(^DD(DX,+X,0)) D
 . N I,Z,L S W=0
 . S Z=$P(DPP(DL),U,4),L=$L(Z,Q)
 . F I=2:1:L S X=+$P(Z,Q,I)
 . Q
 I '$D(^DD(DX,+X,0)) S W=30 G DJ:$P(DPP(DL),U,7)["D",LL
X S DN=$P(^(0),U,2),W=+$P(DN,"J",2) G LL:W>8,DJ:W I $P(DN,"P",2) G X:$D(^DD(+$P(DN,"P",2),.01,0)),LL
SHORTEN I DN["C"!(DN["K"),DN'["J" S W=30 G LL
 I DN'["F" S DE=DE+5,W=13 S:$P(DPP(DL),U,5)[";TXT" W=14 G DJ
 S W=+$P(^(0),"$L(X)>",2) S:'W W=30 S:W>DIOS W=DIOS
LL I $P(DPP(DL),U,5)[";TXT" S W=W+1
 S:W>8 DE(DL)=W,D5=D5+1
SL S DE=DE+W-8
DJ I $O(DPP(DL,-1)) D  I X=.001 S DE=DE+W
 . N I,J S I=0
 . F J=0:0 S J=$O(DPP(DL,J)) Q:'J  S I=I+1
 . S DE=(I*4)+DE Q
 Q
