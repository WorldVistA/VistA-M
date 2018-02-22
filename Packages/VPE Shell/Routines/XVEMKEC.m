XVEMKEC ;DJB/KRN**ARROW,OTHER [02/14/95];2017-08-15  12:52 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
ARROW ;Process arrow keys
 NEW I D @$E(XVVSHC,2,$L(XVVSHC)-1)
 Q
AR ;Arrow right
 I $G(FLAGCLH)="CLH"!($G(FLAGCLH)=">>"),CD']"" S X="QUIT" Q
 Q:XCHAR>$L(CD)
 I XCHAR#WIDTH=0 S XCHAR=XCHAR+1,XCUR=START,YCUR=YCUR+1 W ! W:START>0 $C(27)_"["_START_"C" Q
 S XCHAR=XCHAR+1,XCUR=XCUR+1 W @XVVS("CR")
 Q
AL ;Arrow left. FLAGCLH allows left arrow to show last 20 CLH commands.
 I $G(FLAGCLH)="CLH"!($G(FLAGCLH)=">>"),CD']"" S X="QUIT" Q
 Q:XCHAR=1  S XCHAR=XCHAR-1
 I XCHAR#WIDTH=0 S XCUR=WIDTH+START-1,YCUR=YCUR-1 W @XVVS("CU"),$C(27)_"["_(WIDTH-1)_"C" Q
 S XCUR=XCUR-1 W @XVVS("CL")
 Q
AD ;Cursor down 1 line (Bottom)
 I $G(FLAGCLH)="CLH",XCHAR>$L(CD) S X="QUIT" Q
 I $G(FLAGCLH)=">>",CD']"" S X="QUIT" Q
 Q:YCUR=YCNT
 S YCUR=YCUR+1,XCHAR=XCHAR+WIDTH W @XVVS("CD")
 I XCHAR>($L(CD)+1) F I=1:1:(XCHAR-($L(CD)+1)) W @XVVS("CL") S XCHAR=XCHAR-1,XCUR=XCUR-1
 Q
AU ;Cursor up 1 line (Top)
 I $G(FLAGCLH)="CLH",XCHAR>$L(CD) S X="QUIT" Q
 I $G(FLAGCLH)=">>",CD']"" S X="QUIT" Q
 Q:YCUR=1
 S YCUR=YCUR-1,XCHAR=XCHAR-WIDTH W @XVVS("CU")
 Q
OTHER ;<F1AL>,<F1AR>,<F2AL>,<F2AR>
 NEW I D @$E(XVVSHC,2,$L(XVVSHC)-1)
 Q
F1AL ;Cursor to beginning of line
 I $G(FLAGCLH)="CLH"!($G(FLAGCLH)=">>"),CD']"" S X="QUIT" Q
 Q:CD']""
 F I=1:1:YCUR-1 W @XVVS("CU")
 F I=1:1:XCUR-START W @XVVS("CL")
 S XCUR=START,YCUR=1,XCHAR=1
 Q
F1AR ;Cursor to end of line
 I $G(FLAGCLH)="CLH"!($G(FLAGCLH)=">>"),CD']"" S X="QUIT" Q
 Q:CD']""  Q:XCHAR=($L(CD)+1)
 I YCNT>YCUR W $C(27)_"["_(YCNT-YCUR)_"B" S YCUR=YCNT ;Cursor down
 S XCUR=(($L(CD)#WIDTH)+START)
 W *13 W:XCUR>0 $C(27)_"["_XCUR_"C" ;Cursor right
 I $L(CD)>0,$L(CD)#WIDTH=0 W @XVVS("CD") S YCUR=YCUR+1 ;Line is width of screen.
 S XCHAR=$L(CD)+1
 Q
F2AL ;Cursor left 15
 I $G(FLAGCLH)="CLH"!($G(FLAGCLH)=">>"),CD']"" S X="QUIT" Q
 Q:CD']""
 I XCUR>(15+START) S XCUR=XCUR-15,XCHAR=XCHAR-15 W $C(27)_"[15D"
 Q
F2AR ;Cursor right 15
 I $G(FLAGCLH)="CLH"!($G(FLAGCLH)=">>"),CD']"" S X="QUIT" Q
 Q:CD']""
 I XCUR<(RMAR-15),($L(CD)-XCHAR)>14 S XCUR=XCUR+15,XCHAR=XCHAR+15 W $C(27)_"[15C"
 Q
