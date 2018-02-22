XVEMKT2 ;DJB/KRN**Txt Scroll-Other,Help ;2017-08-15  1:11 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
SCROLL(CRSRON) ;End scroll, do form feed, start scroll
 D ENDSCR,STARTSCR($G(CRSRON))
 Q
STARTSCR(CRSRON) ;Start Scroll Region
 ;CRSRON=If 1, leave on cursor
 NEW I
 X XVVS("RM0")
 I '$G(CRSRON) W @XVVS("COFF")
 D SCROLL^XVEMKY2(XVVT("S1"),XVVT("S2"))
 W @XVV("IOF")
 I XVV("OS")=9 D  ;DTM-Blank screen below scroll area
 . S DX=0,DY=XVVT("S2") X XVVS("CRSR") W @XVVS("BLANK_C_EOS")
 S DX=0,DY=XVVT("S2")
 F I=1:1:XVVT("FT") X XVVS("CRSR") W XVVT("FT",I) S DY=DY+1
 S DX=0,DY=XVVT("S1")-XVVT("HD")-1
 F I=1:1:XVVT("HD") X XVVS("CRSR") W XVVT("HD",I) S DY=DY+1
 Q
ENDSCR ;End Scroll Region
 D SCROLL^XVEMKY2(1,XVV("IOSL"))
 I $D(XVVS("CON")) W @XVVS("CON")
 X XVVS("RM80") W @XVV("IOF")
 Q
BOTTOM(PKG,CRSRON) ;Move to last line displayed.
 ; PKG    - Package
 ; CRSRON - If 1, tell REDRAW to leave on cursor
 ;
 NEW X
 S X=999999999
 S:$G(PKG)']"" PKG="K"
 F  S X=+$O(^TMP("XVV",PKG,$J,X),-1) Q:X=0  Q:$G(^(X))'=" <> <> <>"
 S XVVT("TOP")=$S(X>0:X,1:1)
 D REDRAW($G(CRSRON))
 Q
REDRAW(CRSRON) ;Redraw screen after running a menu selection
 ;CRSRON=If 1, tell STARTSCR to leave on cursor
 S XVVT("BOT")=XVVT("TOP")
 S XVVT("GAP")=XVVT("SL")
 S XVVT("HLN")=XVVT("TOP")
 S XVVT("H$Y")=XVVT("S1")-1
 D SCROLL($G(CRSRON))
 Q
HELP ;
 D ENDSCR
 W !?25,"V P E   S C R O L L E R"
 W !,"The display you are viewing is utilizing the VPE generic scroller."
 W !,"Displays that use this scroller are marked with ""<>"" at the extreme"
 W !,"left side of the bar menu located at the bottom of the screen."
 W !!?4,"<ARROW UP> ..........: Move up one line"
 W !?4,"<ARROW DOWN> ........: Move down one line"
 ;W !?4,"<F1><AU> ............: Move highlight to screen top"
 ;W !?4,"<F1><AD> ............: Move highlight to screen bottom"
 W !?4,"U,<F4><AU> ..........: Move up one page"
 W !?4,"D,<F4><AD>,<RETURN> .: Move down one page"
 W !?4,"T,<F4><AL>,<HOME> ...: Move to page 1"
 W !?4,"B,<F4><AR>,<END> ....: Move to bottom (Last line displayed)"
 W !?4,"^,<ESC><ESC>,<F1>E,<F1>Q ..: Quit"
 W !?4,"F ...................: Find characters (Look on left side of line only)"
 W !?4,"L ...................: Locate characters (Anywhere in the line)"
 W !!,"If you hear a beep when you hit any of the above keys, you have reached"
 W !,"the top or bottom of the display and can go no further."
 D PAUSE^XVEMKC(1)
 Q
ERROR ;Error Trap
 S FLAGQ=1
 KILL ^TMP("XVV","K",$J)
 D ENDSCR,ERRMSG^XVEMKU1("SCROLLER"),PAUSE^XVEMKU(2)
 Q
