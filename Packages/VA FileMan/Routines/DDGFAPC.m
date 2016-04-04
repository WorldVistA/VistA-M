DDGFAPC ;SFISC/MKO-ADJUST PAGE COORDINATES ;01:16 PM  19 Jan 1994
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 ;Input:
 ; T  = PTOP: top of page
 ;      PBRC: bottom right corner of page
 ;Returns:
 ; DDGFLIM
 ;
 N DDGFE,P1,P2,P3,P4
 ;
 D SETUP
 S DDGFE=0 F  S Y=$$READ W:$T(@Y)="" $C(7) D:$T(@Y)]"" @Y Q:DDGFE
 D CLEANUP
 Q
 ;
DESELECT ;
 S DDGFE=1
 Q
 ;
LNU Q:DY'>$P(DDGFLIM,U)
 D MV(DY-1,DX)
 Q
LND Q:DY'<$P(DDGFLIM,U,3)
 D MV(DY+1,DX)
 Q
CHR Q:DX'<$P(DDGFLIM,U,4)
 D MV(DY,DX+1)
 Q
CHL Q:DX'>$P(DDGFLIM,U,2)
 D MV(DY,DX-1)
 Q
TBR Q:DX'<$P(DDGFLIM,U,4)
 D MV(DY,DX+$$MIN(5,$P(DDGFLIM,U,4)-DX))
 Q
TBL Q:DX'>$P(DDGFLIM,U,2)
 D MV(DY,DX-$$MIN(5,DX-$P(DDGFLIM,U,2)))
 Q
SCT Q:DY'>$P(DDGFLIM,U)
 D MV($P(DDGFLIM,U),DX)
 Q
SCB Q:DY'<$P(DDGFLIM,U,3)
 D MV($P(DDGFLIM,U,3),DX)
 Q
SCR Q:DX'<$P(DDGFLIM,U,4)
 D MV(DY,$P(DDGFLIM,U,4))
 Q
SCL Q:DX'>$P(DDGFLIM,U,2)
 D MV(DY,$P(DDGFLIM,U,2))
 Q
 ;
MV(DDGFY,DDGFX) ;
 I T="PTOP" D
 . F DDGFC=P1_U_P2,P1_U_P4,P3_U_P2,P3_U_P4 D REPALL^DDGLIBW(DDGFC_"^1^1")
 . S P1=P1+DDGFY-DY,P2=P2+DDGFX-DX,P3=P3+DDGFY-DY,P4=P4+DDGFX-DX
 ;
 I T="PBRC" D
 . D:DDGFX'=DX REPALL^DDGLIBW(P1_U_P4_"^1^1")
 . D:DDGFY'=DY REPALL^DDGLIBW(P3_U_P2_"^1^1")
 . D REPALL^DDGLIBW(P3_U_P4_"^1^1")
 . S P3=P3+DDGFY-DY,P4=P4+DDGFX-DX
 ;
 D CORNER()
 S DY=DDGFY,DX=DDGFX
 K DDGFC
 Q
 ;
CORNER(N) ;Draw corners of box
 ;In: P1,P2,P3,P4,T; if N:normal video
 N DY,DX
 S DY=P1,DX=P2 X IOXY
 W $P(DDGLGRA,DDGLDEL)_$S($G(N):"",1:$P(DDGLVID,DDGLDEL,6))_$P(DDGLGRA,DDGLDEL,5)
 S DY=P1,DX=P4 X IOXY W $P(DDGLGRA,DDGLDEL,6)
 S DY=P3,DX=P2 X IOXY W $P(DDGLGRA,DDGLDEL,7)
 S DX=P4 X IOXY
 W $P(DDGLGRA,DDGLDEL,8)_$S($G(N):"",1:$P(DDGLVID,DDGLDEL,10))_$P(DDGLGRA,DDGLDEL,2)
 Q
 ;
MIN(X,Y,Z) ;Return the minimum of two or three numbers
 N A
 S A=$S(X<Y:X,1:Y)
 Q:$G(Z)="" A
 Q $S(A<Z:A,1:Z)
 ;
RC(DDGFY,DDGFX) ;Update status line, reset DX and DY, move cursor
 N S
 I DDGFR D
 . S DY=IOSL-6,DX=IOM-9,S="R"_(DDGFY+1)_",C"_(DDGFX+1)
 . X IOXY W S_$J("",7-$L(S))
 S DY=DDGFY,DX=DDGFX X IOXY
 Q
 ;
SETUP ;Initial setup
 S DDGFDY=DY,DDGFDX=DX
 ;
 ;Get page coordinates
 S P4=@DDGFREF@("F",DDGFPG)
 S P1=$P(P4,U),P2=$P(P4,U,2),P3=$P(P4,U,3),P4=$P(P4,U,4)
 S DDGFAREA=P1_U_P2_U_(P3-P1+1)_U_(P4-P2+1)
 ;
 ;Draw corners in reverse video, reset DDGFLIM
 D CORNER()
 I T="PTOP" S DDGFLIM=0_U_(DX-P2)_U_(DY+IOSL-8-P3)_U_(DX+IOM-2-P4)
 I T="PBRC" S DDGFLIM=P1+2_U_(P2+2)_U_(IOSL-8)_U_(IOM-2)
 Q
 ;
CLEANUP ;Final cleanup
 I DDGFDY'=DY!(DDGFDX'=DX) D
 . D PAGE^DDGFUPDP(P1,P2,P3,P4,T,DDGFAREA)
 E  D CORNER(1) S DDGFLIM=P1_U_P2_U_P3_U_P4
 ;
 D RC(DY,DX)
 K DDGFDY,DDGFDX,DDGFAREA
 Q
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
