DVBCVW2 ;ALB/CMM LIST MANAGER PROTOCOL DRIVER ;17FEB92
 ;;2.7;AMIE;;Apr 10, 1995
 ;
 ;List Manager -display for exams and chapter/introductions
EN() ;
 I VWQRY<2 Q
 I '$D(QUIT)!(QUIT="Y") Q
 I $D(DVBCSPR) G LEAVE^DVBCPGD
 S VALMBG=1
 ;
 ;vwqry     reference query number
 ;vwdoc     reference doc number
 ;vwline    reference line, default=1
 ;
 I $D(QUIT) D EN^VALM("DVBA C VIEW EXAMS")
 Q
 ;
INIT ;   set up the doc to be viewed based on parameters
 I '$D(QUIT)!(VWQRY<2) Q
 I QUIT="Y" Q
 S DVBCVAR="^TMP"
 S VALMAR=VALMAR_"(""DVBCVIEW"",$J,"_VWQRY_","_VWDOC_")"
 I $D(DVBCFLG) D CALLIT^DVBCPG1
 ;
 S VWLINE=1,VALMBG=VWLINE
 ;
 ; get number of lines in doc from 0 node
 S VALMCNT=$P($G(@VALMAR@(0)),"^",4)
 I VALMCNT<1 Q
 ;
 Q
 ;
HEADER ; HEADER FOR LIST MANAGER DISPLAY 
 Q
 ;
EXIT ;CLEAN UP
 ;   set line to NULL so if user reopens doc it will be recalc'ed
 I $D(DVBCSPR) Q
 S VWLINE="",VALMBG=1
 ; if normal exit, then leave dvbcvw2
 S VALMBCK="R"
 I '$D(QUIT) Q
 I $D(QUIT) D REMOVE^DVBCLMU5(VWQRY)
 K ^TMP("DVBC,",$J,VWQRY),^TMP("DVBCVIEW",$J,VWQRY)
 S VWQRY=VWQRY-1,DVBCHLD="DVBCVIEW,"_$J_","_VWQRY
 I VWQRY>1 S VALMCNT=$P(^TMP("DVBCVIEW",$J,VWQRY,VWDOC,0),"^",4)
 I VWQRY<3 K DVBCJMP,DVBCTEMP
 S QUIT="Y"
 S DVBCCT="Y"
 Q
 ;
EXPAND ;EXPAND ACTION
 Q
HELP ;DISPLAY HELP
 N OFFSET,TEXT
 D CLEAR^VALM1
 W !,"***  The function keys F9 for 'Print List' and F12 for 'Super Quit' ***"
 W !,"***  are available.  ***"
 F OFFSET=1:1 S TEXT=$P($T(HELPTXT+OFFSET),";;",2,78) Q:TEXT="$END"  D
 .I (TEXT="$PAUSE") D PAUSE^VALM1 Q:('Y)  W !
 .W:'(TEXT="$PAUSE") !,TEXT
 D PAUSE^VALM1
 S VALMBCK="R"
 K Y
 Q
HELPTXT ;TEXT FOR HELP
 ;;
 ;;Available Options Are:
 ;;
 ;;  NX - Next Screen            - Scroll down one screen
 ;;  BU - Previous Screen        - Scroll up one screen
 ;;  UP - Up a Line              - Scroll up one line
 ;;  DN - Down a Line            - Scroll down one line
 ;;  FS - First Screen           - Go to top of list
 ;;  LS - Last Screen            - Go to bottom of list
 ;;  RE - Refresh Screen         - Repaint the screen
 ;;  PS - Print Screen           - Print the current screen
 ;;  PL - Print List             - Print Exam or Chapter/Introduction displayed
 ;;  AD - Auto Display(On/Off)   - Turn on/off displaying of available actions
 ;;  QU - Quit                   - Exit display screen
 ;;  SQ - Super Quit             - Exit Completely to Menu Option
 ;; JMP - Jump to New Exam       - Select a New Exam to View
 ;;$END
 ;
 ;
KEYSET ;this sets up the print and super quit function keys
 S XQORM("XLATE","F12")="SQ"
 S XQORM("XLATE","F9")="PL"
 Q
