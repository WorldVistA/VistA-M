DDGFADL ;SFISC/MKO-ADJUST DATA LENGTH ;11:28 AM  22 Dec 1993
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 N DDGFE
 D DRAW(1)
 S DDGFE=0 F  S Y=$$READ W:$T(@Y)="" $C(7) D:$T(@Y)]"" @Y Q:DDGFE
 Q
 ;
CHR Q:L'<($P(DDGFLIM,U,4)-D2+1)
 S L=L+1,D=D_"_"
 D DRAW(1)
 Q
CHL Q:L<2
 S L=L-1,D=$E(D,1,$L(D)-1)
 D DRAW(-1)
 Q
DONE ;
 S DDGFE=1,D3=D2+L-1,DDGFDY=DY,DDGFDX=DX
 S DY=IOSL-6,DX=IOM-9
 X IOXY W $J("",7)
 S DY=DDGFDY,DX=DDGFDX X IOXY
 K DDGFDY,DDGFDX
 Q
DRAW(I) ;Draw line
 ;I = 1 if we've increased the data length, -1 if we've decreased it
 ;
 N S,X,Y
 S X=DX,Y=DY
 S DY=D1,DX=D2 X IOXY
 W $P(DDGLVID,DDGLDEL,6)_D_$P(DDGLVID,DDGLDEL,10)_$E(" ",1,I=-1)
 S DY=IOSL-6,DX=IOM-9,S="L="_L X IOXY W S_$J("",7-$L(S))
 I I=-1 D REPAINT^DDGLIBW(DDGFWID,D1_U_(D2+L)_U_1_U_1)
 ;
 S DX=X,DY=Y X IOXY
 Q
 ;
READ() N S,Y
 F  R *Y:DTIME D C Q:Y'=-1
 Q Y
 ;
C I Y<0 S Y="TO" Q
 S S=""
C1 S S=S_$C(Y)
 I DDGF("DIN")'[(U_S) D  I Y=-1 W $C(7) Q
 . I $C(Y)'?1L S Y=-1 Q
 . S S=$E(S,1,$L(S)-1)_$C(Y-32) S:DDGF("DIN")'[(U_S_U) Y=-1
 ;
 I DDGF("DIN")[(U_S_U),S'=$C(27) S Y=$P(DDGF("DOUT"),U,$L($P(DDGF("DIN"),U_S_U),U)) Q
 R *Y:5 G:Y'=-1 C1 W $C(7)
 Q
