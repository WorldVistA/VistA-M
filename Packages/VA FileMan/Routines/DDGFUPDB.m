DDGFUPDB ;SFISC/MKO-UPDATE BLOCK COORDINATES ;03:28 PM  17 Aug 1993
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
BLK(DDGFORIG) ;
 ;Update image with adjusted block coordinates
 ; DDGFORIG(B) : defined for all blocks that changed coordinates
 ;               = original $Y^original $X
 N P,P1,P2,B,B1,B2,F,C1,C2,C3,C,D1,D2,D3,L,X1,Y1,N,I
 ;
 ;Get page coordinates
 S P=DDGFPG
 S P1=$P(@DDGFREF@("F",P),U),P2=$P(@DDGFREF@("F",P),U,2)
 ;
 ;Loop through all blocks on page
 S B="" F  S B=$O(@DDGFREF@("F",P,B)) Q:B=""  D BK
 Q
 ;
BK ;Get block coordinates
 S B2=@DDGFREF@("F",P,B)
 S B1=$P(B2,U),B2=$P(B2,U,2)
 ;
 ;Get Y1=delta $Y, X1=delta $X
 I $D(DDGFORIG(B)) S Y1=B1-$P(DDGFORIG(B),U),X1=B2-$P(DDGFORIG(B),U,2)
 E  S (Y1,X1)=0
 I 'Y1,'X1 K DDGFORIG(B)
 ;
 ;Loop through all fields on block
 S F="" F  S F=$O(@DDGFREF@("F",P,B,F)) Q:F=""  D FD
 Q
 ;
FD ;
 ;Get field data
 S N=@DDGFREF@("F",P,B,F)
 S C1=$P(N,U),C2=$P(N,U,2),C3=$P(N,U,3),C=$P(N,U,4)
 S D1=$P(N,U,5),D2=$P(N,U,6),D3=$P(N,U,7),L=$P(N,U,8)
 ;
 I $D(DDGFORIG(B)) D
 . I Y1 S:C1]"" $P(N,U)=C1+Y1 S:L $P(N,U,5)=D1+Y1
 . I X1 D
 .. I C]"" F I=2,3 S $P(N,U,I)=$P(N,U,I)+X1
 .. I L F I=6,7 S $P(N,U,I)=$P(N,U,I)+X1
 . S @DDGFREF@("F",P,B,F)=N
 . ;
 . I C]"" D
 .. K @DDGFREF@("RC",DDGFWID,C1,C2,C3,B,F,"C")
 .. S @DDGFREF@("RC",DDGFWID,$P(N,U),$P(N,U,2),$P(N,U,3),B,F,"C")=""
 . I L D
 .. K @DDGFREF@("RC",DDGFWID,D1,D2,D3,B,F,"D")
 .. S @DDGFREF@("RC",DDGFWID,$P(N,U,5),$P(N,U,6),$P(N,U,7),B,F,"D")=""
 ;
 I C]"" D WRITE^DDGLIBW(DDGFWID,C,$P(N,U)-P1,$P(N,U,2)-P2)
 I L D WRITE^DDGLIBW(DDGFWID,$TR($J("",L)," ","_"),$P(N,U,5)-P1,$P(N,U,6)-P2)
 Q
