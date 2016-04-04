DDGF3 ;SFISC/MKO-Block Viewer Page ;02:49 PM  12 Oct 1994
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 ;Variables used:
 ;  DDGFBV      = flag indicating we're on block viewer page
 ;  DDGFORIG(B) = original $Y^original $X for all blocks that were
 ;                  selected, since they were potentially moved
 ;  DDGFEBV     = flag that can be set to exit block viewer page
 ;                  after a block has been selected
 ;
 N DDGFE
 S DDGFE=0,DDGFBV=1 K DDGFORIG,DDGFEBV
 ;
 D PAINT,RC(DY,DX)
 F  S Y=$$READ W:$T(@Y)="" $C(7) D:$T(@Y)]"" @Y D:$D(DDGFMSG) MSG^DDGF() Q:DDGFE!$G(DDGFEBV)
 D CLEANUP
 Q
 ;
LNU I DY>$P(DDGFLIM,U) D RC(DY-1,DX)
 Q
LND I DY<$P(DDGFLIM,U,3) D RC(DY+1,DX)
 Q
CHR I DX<$P(DDGFLIM,U,4) D RC(DY,DX+1)
 Q
CHL I DX>$P(DDGFLIM,U,2) D RC(DY,DX-1)
 Q
ELR N Y,X
 S Y=DY,X=DX
 F  D  Q:Y=""!(X]"")
 . S X=$O(@DDGFREF@("BKRC",DDGFWIDB,Y,X))
 . S:X="" Y=$O(@DDGFREF@("BKRC",DDGFWIDB,Y))
 D:X]"" RC(Y,X)
 Q
ELL N Y,X
 S Y=DY,X=DX
 F  D  Q:Y=""!(X]"")
 . S X=$O(@DDGFREF@("BKRC",DDGFWIDB,Y,X),-1)
 . S:X="" Y=$O(@DDGFREF@("BKRC",DDGFWIDB,Y),-1)
 D:X]"" RC(Y,X)
 Q
TBR I DX<$P(DDGFLIM,U,4) D
 . D RC(DY,$S(DX+5'<$P(DDGFLIM,U,4):$P(DDGFLIM,U,4),1:DX+5))
 E  I DY<$P(DDGFLIM,U,3) D RC(DY+1,$P(DDGFLIM,U,2))
 Q
TBL I DX>$P(DDGFLIM,U,2) D
 . D RC(DY,$S(DX-5'>$P(DDGFLIM,U,2):$P(DDGFLIM,U,2),1:DX-5))
 E  I DY>$P(DDGFLIM,U) D RC(DY-1,$P(DDGFLIM,U,4))
 Q
 ;
SCT I DY>$P(DDGFLIM,U) D RC($P(DDGFLIM,U),DX)
 Q
SCB I DY<$P(DDGFLIM,U,3) D RC($P(DDGFLIM,U,3),DX)
 Q
SCR I DX<$P(DDGFLIM,U,4) D RC(DY,$P(DDGFLIM,U,4))
 Q
SCL I DX>$P(DDGFLIM,U,2) D RC(DY,$P(DDGFLIM,U,2))
 Q
SELECT ;
 Q:'$D(@DDGFREF@("BKRC",DDGFWIDB,DY))
 G SELECT^DDGFBSEL
 ;
SAVE ;Save data
 G SAVE^DDGFSV
 ;
BKADD ;Add a new block
 G ADD^DDGFBK
 ;
HBKADD ;Add a header block
 G ADD^DDGFHBK
 ;
HELP ;Invoke help screens
 D ^DDGFH,REFRESH^DDGF,RC(DY,DX)
 Q
 ;
TO W $C(7)
QUIT ;
EXIT ;
VIEW S DDGFE=1
 Q
CLEANUP ;
 S DDGFDY=DY,DDGFDX=DX
 D CLOSE^DDGLIBW(DDGFWIDB,1)
 I $D(DDGFORIG) D
 . N A
 . S A=$$AREA^DDGLIBW(DDGFWID)
 . D DESTROY^DDGLIBW(DDGFWID,1)
 . D CREATE^DDGLIBW(DDGFWID,A,$P(@DDGFREF@("F",DDGFPG),U,3)]"")
 . D BLK^DDGFUPDB(.DDGFORIG)
 E  D OPEN^DDGLIBW(DDGFWID)
 S DY=IOSL-6,DX=46 X IOXY W $J("",13)
 S DY=IOSL-1,DX=0 X IOXY W $P(DDGLCLR,DDGLDEL)_$P(DDGLVID,DDGLDEL)_"<PF1>Q=Quit  <PF1>E=Exit  <PF1>S=Save  <PF1>V=Block Viewer  <PF1>H=Help"_$P(DDGLVID,DDGLDEL,10)
 D RC(DDGFDY,DDGFDX)
 K DDGFDY,DDGFDX,DDGFBV,DDGFEBV,DDGFORIG
 Q
 ;
PAINT ;Paint block displayer window
 N B,C,S,DY,DX
 D CLOSE^DDGLIBW(DDGFWID,1)
 S DY=IOSL-6,DX=46 X IOXY W "BLOCK VIEWER"
 S DY=IOSL-1,DX=0 X IOXY W $P(DDGLCLR,DDGLDEL)_$P(DDGLVID,DDGLDEL)_"<PF1>V=Main Screen  <PF1>H=Help"_$P(DDGLVID,DDGLDEL,10)
 I $$EXIST^DDGLIBW(DDGFWIDB) D FOCUS^DDGLIBW(DDGFWIDB) Q
 D CREATE^DDGLIBW(DDGFWIDB,$P(DDGFLIM,U,1,2)_U_($P(DDGFLIM,U,3)-$P(DDGFLIM,U,1)+1)_U_($P(DDGFLIM,U,4)-$P(DDGFLIM,U,2)+1),$P(@DDGFREF@("F",DDGFPG),U,3)]"")
 S B="" F  S B=$O(@DDGFREF@("F",DDGFPG,B)) Q:B=""  D
 . S C=@DDGFREF@("F",DDGFPG,B)
 . S S=$P(C,U,4)
 . S:$P(C,U,3)'<IOM S=$E(S,1,IOM-$P(C,U,2)-1)
 . D WRITE^DDGLIBW(DDGFWIDB,S,$P(C,U)-$P(DDGFLIM,U),$P(C,U,2)-$P(DDGFLIM,U,2))
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
READ() N S,Y
 F  R *Y:DTIME D C Q:Y'=-1
 Q Y
 ;
C I Y<0 S Y="TO" Q
 S S=""
C1 S S=S_$C(Y)
 I DDGF("IN")'[(U_S) D  I Y=-1 W $C(7) Q
 . I $C(Y)'?1L S Y=-1 Q
 . S S=$E(S,1,$L(S)-1)_$C(Y-32) S:DDGF("IN")'[(U_S_U) Y=-1
 ;
 I DDGF("IN")[(U_S_U),S'=$C(27) S Y=$P(DDGF("OUT"),U,$L($P(DDGF("IN"),U_S_U),U)) Q
 R *Y:5 G:Y'=-1 C1 W $C(7)
 Q
