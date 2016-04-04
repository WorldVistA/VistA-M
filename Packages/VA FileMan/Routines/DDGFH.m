DDGFH ;SFISC/MKO-HELP SCREENS ;09:20 AM  7 Jul 1994
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
HLP ;Print help screens, refresh screen
 D HLP^DDGLIBH(9251,9259,"DDGFH")
 D REFRESH^DDGF,RC(DY,DX)
 Q
 ;
RC(DDGFY,DDGFX) ;Update status line, reset DX and DY, move cursor
 N DDGFS
 I DDGFR D
 . S DY=IOSL-6,DX=IOM-9,DDGFS="R"_(DDGFY+1)_",C"_(DDGFX+1)
 . X IOXY W DDGFS_$J("",7-$L(DDGFS))
 S DY=DDGFY,DX=DDGFX X IOXY
 Q
