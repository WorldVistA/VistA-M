XVEMKEB ;DJB/KRN**INSERT,DELETE,PRINT ;2017-08-15  12:51 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
INSERT ;Insert a character
 NEW XVVY
 S XVVY=(XVV("IOSL")-1)
 I $L(CD)>244 D  S XVVSHC="TOO LONG",X="QUIT" Q  ;Tell calling routine line is too long.
 . I YCNT>YCUR W $C(27)_"["_(YCNT-YCUR)_"B" ;Move cursor to last line.
 . S DX=0,DY=$S($Y>XVVY:XVVY,1:$Y) X XVVS("XY")
 . W $C(7),!!?3,"Line length may not exceed 245"
 I $L(CD)>0,$L(CD)#WIDTH=0 D  ;Allow for scroll at bottom of screen.
 . I YCNT>YCUR W $C(27)_"["_(YCNT-YCUR)_"B" ;Move cursor to last line.
 . W !,$C(27)_"["_(YCNT-YCUR+1)_"A" ;Linefeed,move cursor back up.
 . W $C(27)_"["_(XCUR+1)_"C" ;Move cursor right.
 S CD=$S(XCHAR=1:X_CD,1:$E(CD,1,XCHAR-1)_X_$E(CD,XCHAR,999))
 I XCHAR#WIDTH=0 S XCUR=START,YCUR=YCUR+1 D  I 1
 . W ! I START>0 W $C(27)_"["_START_"C" ;Cursor right
 E  S XCUR=XCUR+1
 S XCHAR=XCHAR+1 D PRINTL
 Q
DELETE ;Delete character
 ;---<DEL> key struck---
 I XVVSHC="<DEL>" D  Q
 . S CD=$E(CD,1,XCHAR-1)_$E(CD,XCHAR+1,999) D PRINTL
 ;---<BS> key struck---
 Q:XCHAR=1  S XCHAR=XCHAR-1
 I XCHAR=1 S XCUR=XCUR-1,CD=$E(CD,2,999) W @XVVS("CL") D PRINTL Q
 I XCHAR#WIDTH=0,YCUR>1 D  I 1
 . S XCUR=WIDTH+START-1,YCUR=YCUR-1
 . W @XVVS("CU"),$C(27)_"["_(WIDTH-1)_"C"
 E  S XCUR=XCUR-1 W @XVVS("CL")
 S CD=$E(CD,1,XCHAR-1)_$E(CD,XCHAR+1,999) D PRINTL
 Q
PRINTL ;Print Line
 NEW TEMP,XVVY
 S XVVY=(XVV("IOSL")-1)
 S TEMP=$E(CD,XCHAR,999)
 I TEMP?.E1C.E S TEMP=$$CC^XVEMKEA(TEMP) ;Control characters
 S DX=XCUR,DY=$S($Y>XVVY:XVVY,1:$Y)
 W @XVVS("SC") ;Save cursor position
 W @XVVS("BLANK_C_EOS") ;Blank screen
 X XVVS("XY") ;Reset $X & $Y
 F YCNT=1:1 Q:$L(CD)<(YCNT*WIDTH+1)
 W $E(TEMP,1,WIDTH+START-XCUR)
 S TEMP=$E(TEMP,(WIDTH+START+1)-XCUR,999)
PRINTL1 ;Print remainder of line
 I TEMP="" W @XVVS("RC") Q
 W !?START,$E(TEMP,1,WIDTH) S TEMP=$E(TEMP,WIDTH+1,999)
 G PRINTL1
