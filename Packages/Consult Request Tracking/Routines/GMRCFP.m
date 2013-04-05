GMRCFP ;DSS/MBS - GMRC FEE PARAM List Utilities ;2/21/12 9:35am
 ;;3.0;CONSULT/REQUEST TRACKING;**74**;DEC 27, 1997;Build 4
 Q
 ;; ;
EN ; -- main entry point for GMRC FEE PARAM
 K GMRCCHNG D EN^VALM("GMRC FEE PARAM")
 Q
 ;
HDR ; -- header code
 S VALMHDR(1)="Services defined in GMRC FEE SERVICES system parameter"
 S VALMHDR(2)="as fee-basis services."
 Q
 ;
INIT ; -- init variables and list array
 N GMRCER
 S $P(GMRCFPBK," ",10)=""
 K GMRCFPX
 D GETWP^XPAR(.GMRCFPX,"SYS","GMRC FEE SERVICES",,.GMRCER)
 D BUILD
 Q
BUILD ; -- (re)Build the list
 N LINE,NAME,IEN,I
 K @VALMAR
 S LINE=0
 S I=0 F  S I=$O(GMRCFPX(I)) Q:'I  D
 . S IEN=GMRCFPX(I,0)
 . S NAME=$$GET1^DIQ(123.5,IEN_",",".01")
 . I NAME="" S NAME="*****UNKNOWN SERVICE!!!*****"
 . S LINE=LINE+1
 . D SET^VALM10(LINE,$E(LINE_GMRCFPBK,1,5)_NAME)
 S VALMCNT=LINE
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K @VALMAR,GMRCFPX,GMRCFPBK,GMRCCHNG
 Q
 ;
EXPND ; -- expand code
 Q
 ;
