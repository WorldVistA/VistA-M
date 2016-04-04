DDGFBSEL ;SFISC/MKO-SELECT BLOCK ;07:50 AM  23 Aug 1993
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 ;Sets:
 ;  DDGFORIG(B) = original $Y^original $X for all blocks that were
 ;                  selected, since they were potentially moved
SELECT ;
 N B,C,C1,C2,C3
 N B1,X1,X2
 ;
 ;Which element is the cursor on?
 ;Set B=Block
 S X1="" K B
 F  S X1=$O(@DDGFREF@("BKRC",DDGFWIDB,DY,X1)) Q:X1=""!(DX<X1)  D
 . S X2=""
 . F  S X2=$O(@DDGFREF@("BKRC",DDGFWIDB,DY,X1,X2)) Q:X2=""  D  Q:$G(B)
 .. Q:DX>X2
 .. S B=$O(@DDGFREF@("BKRC",DDGFWIDB,DY,X1,X2,""))
 .. I @DDGFREF@("BKRC",DDGFWIDB,DY,X1,X2,B)="H",$O(^(B)) S B=$O(^(B))
 Q:'$G(B)
 ;
 ;Get caption and coordinates
 S B1=$G(@DDGFREF@("F",DDGFPG,B)) Q:B1=""
 S C1=$P(B1,U),C2=$P(B1,U,2),C3=$P(B1,U,3),C=$P(B1,U,4)
 ;
 S:@DDGFREF@("BKRC",DDGFWIDB,C1,C2,C3,B)="H" DDGFHDR=1
 D COVER
 ;
 K B1,X1,X2
 G ^DDGF4
 ;
COVER ;
 N H,O,L
 ;Clear and/or kill portions of DDGFREF
 K @DDGFREF@("BKRC",DDGFWIDB,C1,C2,C3,B)
 ;
 ;Remember original block coordinates
 S:$D(DDGFORIG(B))[0 DDGFORIG(B)=C1_U_C2
 ;
 ;Look for covered (hidden) fields
 ;Set H(B) - array of hidden fields
 S X1=""
 F  S X1=$O(@DDGFREF@("BKRC",DDGFWIDB,C1,X1)) Q:X1=""  D
 . S X2=""
 . F  S X2=$O(@DDGFREF@("BKRC",DDGFWIDB,C1,X1,X2)) Q:X2=""  D
 .. S H=$O(@DDGFREF@("BKRC",DDGFWIDB,C1,X1,X2,""))
 .. I H]"",$D(H(H))[0,$$OVERLAP(C2,C3,X1,X2) S H(H)=""
 ;
 ;Clear in buffer area occupied by element(s) selected
 ;If block on the page border, redraw the lines
 S L=$J("",$L(C)-$S(C3>$P(DDGFLIM,U,4):C3-$P(DDGFLIM,U,4),1:0))
 D WRITE^DDGLIBW(DDGFWIDB,L,C1-$P(DDGFLIM,U),C2-$P(DDGFLIM,U,2),"",1)
 ;
 I $P(@DDGFREF@("F",DDGFPG),U,3) D
 . I C1=$P(DDGFLIM,U)!(C1=$P(DDGFLIM,U,3)) D
 .. S L=$TR(L," ",$P(DDGLGRA,DDGLDEL,3))
 .. S:C2=$P(DDGFLIM,U,2) $E(L)=$P(DDGLGRA,DDGLDEL,$S(C1=$P(DDGFLIM,U):5,1:7))
 .. S:C3'<$P(DDGFLIM,U,4) $E(L,$L(L))=$P(DDGLGRA,DDGLDE,$S(C1=$P(DDGFLIM,U):6,1:8))
 .. D WRITE^DDGLIBW(DDGFWIDB,L,C1-$P(DDGFLIM,U),C2-$P(DDGFLIM,U,2),"G",1)
 . E  I C2=$P(DDGFLIM,U,2) D
 .. D WRITE^DDGLIBW(DDGFWIDB,$P(DDGLGRA,DDGLDEL,4),C1-$P(DDGFLIM,U),C2-$P(DDGFLIM,U,2),"G",1)
 . E  I C3'<$P(DDGFLIM,U,4) D
 .. D WRITE^DDGLIBW(DDGFWIDB,$P(DDGLGRA,DDGLDEL,4),C1-$P(DDGFLIM,U),$P(DDGFLIM,U,4)-$P(DDGFLIM,U,2),"G",1)
 ;
 ;Write to buffer the overlapped blocks(s)
 I $D(H)>1 S H="" F  S H=$O(H(H)) Q:H=""  D
 . S B1=$G(@DDGFREF@("F",DDGFPG,H)) Q:B1=""
 . D WRITE^DDGLIBW(DDGFWIDB,$P(B1,U,4),$P(B1,U)-$P(DDGFLIM,U),$P(B1,U,2)-$P(DDGFLIM,U,2),"",1)
 Q
 ;
OVERLAP(A1,A2,B1,B2) ;Does line with X-coords A1,A2 overlap B1,B2
 N T
 I A1<B1 S T=A1,A1=B1,B1=T,T=A2,A2=B2,B2=T
 Q A1'<B1&(A1'>B2)!(A2'<B1&(A2'>B2))
