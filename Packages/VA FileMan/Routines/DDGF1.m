DDGF1 ;SFISC/MKO-MAIN SCREEN ;02:46 PM  12 Oct 1994
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 D RC($P(DDGFLIM,U),$P(DDGFLIM,U,2))
 S DDGFE=0 F  S Y=$$READ W:$T(@Y)="" $C(7) D:$D(DDGFMSG) MSG^DDGF() D:$T(@Y)]"" @Y Q:DDGFE
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
 ;
ELR N Y,X
 S Y=DY,X=DX
 S X=$O(@DDGFREF@("RC",DDGFWID,Y,X))
 D:X=""
 . S Y=$O(@DDGFREF@("RC",DDGFWID,Y))
 . S:Y="" Y=$O(@DDGFREF@("RC",DDGFWID,""))
 . S:Y]"" X=$O(@DDGFREF@("RC",DDGFWID,Y,""))
 D:X]"" RC(Y,X)
 Q
ELL N Y,X
 S Y=DY,X=DX
 S X=$O(@DDGFREF@("RC",DDGFWID,Y,X),-1)
 D:X=""
 . S Y=$O(@DDGFREF@("RC",DDGFWID,Y),-1)
 . S:Y="" Y=$O(@DDGFREF@("RC",DDGFWID,""),-1)
 . S:Y]"" X=$O(@DDGFREF@("RC",DDGFWID,Y,""),-1)
 D:X]"" RC(Y,X)
 Q
 ;
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
 ;
SAVE ;Save data from DDGFREF
 I 'DDGFPG D ERR(110) Q
 G SAVE^DDGFSV
 ;
SELECT ;Select an item
 I 'DDGFPG D ERR(110) Q
 G SELECT^DDGFEL
 ;
EDIT ;Edit a caption or data length
 I 'DDGFPG D ERR(110) Q
 G EDIT^DDGFEL
 ;
FLDADD ;Add a new field to the form
 I 'DDGFPG D ERR(110) Q
 G ADD^DDGFFLDA
 ;
VIEW ;Go to block viewer
 I 'DDGFPG D ERR(110) Q
 I $O(@DDGFREF@("F",DDGFPG,""))="" D ERR(120) Q
 G ^DDGF3
 ;
BKADD ;Add a new block
 I 'DDGFPG D ERR(110) Q
 G ADD^DDGFBK
 ;
HBKADD ;Add a header block
 I 'DDGFPG D ERR(110) Q
 G ADD^DDGFHBK
 ;
NXTPG ;Go to next page
 I 'DDGFPG D ERR(110) Q
 D NXTPRV^DDGFPG(1) Q
 ;
PRVPG ;Go to previous page
 I 'DDGFPG D ERR(110) Q
 D NXTPRV^DDGFPG(-1) Q
 ;
CLSPG ;Close pop-up page
 G CLSPG^DDGFPG
 ;
PGSEL ;Select a new page
 I 'DDGFPG D ERR(110) Q
 G PGSEL^DDGFPG
 ;
PGADD ;Add a new page to the form
 G ADD^DDGFPG
 ;
PGEDIT ;Edit attributes of a page
 I 'DDGFPG D ERR(110) Q
 G EDIT^DDGFPG
 ;
FMSEL ;Select another form
 G SEL^DDGFFM
 ;
FMADD ;Add a new form
 G ADD^DDGFFM
 ;
FMEDIT ;Edit the form
 G EDIT^DDGFFM
 ;
HELP ;Invoke help screens
 G HLP^DDGFH
 ;
TO ;Time-out
 W $C(7)
 G QUIT
 ;
QUIT ;Exit from form designer
 I DDGLSCR>1 G CLSPG^DDGFPG
 S DDGFE=1
 Q
EXIT ;Save and exit
 I DDGLSCR>1 G CLSPG^DDGFPG
 S DDGFE=1
 G SAVE^DDGFSV
 ;
RC(DDGFY,DDGFX) ;Update status line, reset DX and DY, move cursor
 N DDGFS
 I DDGFR D
 . S DY=IOSL-6,DX=IOM-9,DDGFS="R"_(DDGFY+1)_",C"_(DDGFX+1)
 . X IOXY W DDGFS_$J("",7-$L(DDGFS))
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
 ;
ERR(X) ;
 D MSG^DDGF($C(7)_$P($T(@X),";;",2,999)) H 3
 D MSG^DDGF()
 Q
110 ;;There are no pages on this form.  Use PF2-P to add a page.
120 ;;There are no blocks on this page.  Use PF2-B to add a block.
