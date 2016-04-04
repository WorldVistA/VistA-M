DDGF4 ;SFISC/MKO-ACTIONS AFTER BLOCK SELECTION ;02:49 PM  12 Oct 1994
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 ;Input:
 ;  B     = Block number
 ;  C     = Block name
 ;  C1    = Block $Y
 ;  C2    = Block $X1
 ;  C3    = Block $X2
 ;  DDGFHDR = 1, if block is immobile (header block)
 ;
 N DDGFE
 S:'$G(DDGFHDR) DDGFHDR=0
 D PAINTS
 ;
 S DDGFE=0 F  S Y=$$READ W:$T(@Y)="" $C(7) D:$T(@Y)]"" @Y Q:DDGFE
 D CLEANUP
 Q
 ;
LNU Q:C1'>$P(DDGFLIM,U)!DDGFHDR
 D REDRAW
 S C1=C1-1,DY=DY-1
 D PAINTS
 Q
LND Q:C1'<$P(DDGFLIM,U,3)!DDGFHDR
 D REDRAW
 S C1=C1+1,DY=DY+1
 D PAINTS
 Q
CHR Q:C2'<$P(DDGFLIM,U,4)!DDGFHDR
 D REDRAW
 S C2=C2+1,DX=DX+1
 D PAINTS
 Q
CHL Q:C2'>$P(DDGFLIM,U,2)!DDGFHDR
 D REDRAW
 S C2=C2-1,DX=DX-1
 D PAINTS
 Q
TBR N X
 Q:C2+$L(C)>$P(DDGFLIM,U,4)!DDGFHDR
 D REDRAW
 S X=$$MIN(5,$P(DDGFLIM,U,4)-C2-$L(C)+1)
 S C2=C2+X,DX=DX+X
 D PAINTS
 Q
TBL N X
 Q:C2'>$P(DDGFLIM,U,2)!DDGFHDR
 D REDRAW
 S X=$$MIN(5,C2-$P(DDGFLIM,U,2))
 S C2=C2-X,DX=DX-X
 D PAINTS
 Q
SCT Q:C1'>$P(DDGFLIM,U)!DDGFHDR
 D REDRAW
 S (C1,DY)=$P(DDGFLIM,U)
 D PAINTS
 Q
SCB Q:C1'<$P(DDGFLIM,U,3)!DDGFHDR
 D REDRAW
 S (C1,DY)=$P(DDGFLIM,U,3)
 D PAINTS
 Q
SCR N X
 Q:C2+$L(C)>$P(DDGFLIM,U,4)!DDGFHDR
 D REDRAW
 S X=$P(DDGFLIM,U,4)-C2-$L(C)+1
 S C2=C2+X,DX=DX+X
 D PAINTS
 Q
SCL N X
 Q:C2'>$P(DDGFLIM,U,2)!DDGFHDR
 D REDRAW
 S X=C2-$P(DDGFLIM,U,2)
 S C2=C2-X,DX=DX-X
 D PAINTS
 Q
 ;
EDIT ;Edit block parameters
 G:'$G(DDGFHDR) EDIT^DDGFBK
 G EDIT^DDGFHBK
 ;
REORDER ;Reorder fields on block
 D EN^DDGFORD(B)
 Q
 ;
TO ;Time-out
 W $C(7)
 G DESELECT
 ;
DESELECT ;
 S DDGFE=1
 Q
 ;
CLEANUP ;
 I '$G(DDGFBDEL) D
 . S C3=C2+$L(C)-1
 . S @DDGFREF@("F",DDGFPG,B)=C1_U_C2_U_C3_U_C_U_1,DDGFCHG=1
 . S @DDGFREF@("BKRC",DDGFWIDB,C1,C2,C3,B)=$S($G(DDGFHDR):"H",1:"")
 ;
 I '$G(DDGFEBV),'$G(DDGFBDEL) D
 . D WRITE^DDGLIBW(DDGFWIDB,C,C1-$P(DDGFLIM,U),C2-$P(DDGFLIM,U,2))
 . X IOXY
 K DDGFHDR,DDGFBDEL
 Q
 ;
RC(DDGFY,DDGFX) ;Update status line, reset DX and DY, move cursor
 N S
 I DDGFR D
 . S DY=IOSL-6,DX=IOM-9,S="R"_(DDGFY+1)_",C"_(DDGFX+1)
 . X IOXY W S_$J("",7-$L(S))
 S DY=DDGFY,DX=DDGFX X IOXY
 Q
 ;
REDRAW ;
 D REPAINT^DDGLIBW(DDGFWIDB,(C1-$P(DDGFLIM,U))_U_(C2-$P(DDGFLIM,U,2))_U_1_U_$$MIN($L(C),$P(DDGFLIM,U,4)-C2+1))
 Q
 ;
PAINTS ;
 N Y,X
 S Y=DY,X=DX
 S DY=C1,DX=C2 X IOXY
 W $P(DDGLVID,DDGLDEL,6)_$E(C,1,$$MIN($L(C),$P(DDGFLIM,U,4)-C2+1))_$P(DDGLVID,DDGLDEL,10)
 D RC(Y,X)
 Q
 ;
MIN(X,Y,Z) ;Return the minimum of two or three numbers
 N A
 S A=$S(X<Y:X,1:Y)
 Q:$G(Z)="" A
 Q $S(A<Z:A,1:Z)
 ;
READ() N S,Y
 F  R *Y:DTIME D C Q:Y'=-1
 Q Y
 ;
C I Y<0 S Y="TO" Q
 S S=""
C1 S S=S_$C(Y)
 I DDGF("SIN")'[(U_S) D  I Y=-1 W $C(7) Q
 . I $C(Y)'?1L S Y=-1 Q
 . S S=$E(S,1,$L(S)-1)_$C(Y-32) S:DDGF("SIN")'[(U_S_U) Y=-1
 ;
 I DDGF("SIN")[(U_S_U),S'=$C(27) S Y=$P(DDGF("SOUT"),U,$L($P(DDGF("SIN"),U_S_U),U)) Q
 R *Y:5 G:Y'=-1 C1 W $C(7)
 Q
