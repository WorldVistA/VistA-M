XOBWUS2 ;ALB/MJK - HWSC :: Generic Info Display Tool ; 09/13/10 4:00pm
 ;;1.0;HwscWebServiceClient;;September 13, 2010;Build 31
 ;
 QUIT
 ;
EN(XOBY) ; -- main entry point for XOBW WEB SERVICE DISPLAY
 ;   Input Array Subscripts:
 ;      XOBY("TITLE")          = title for List Manager
 ;      XOBY("HEADER")         = Header line
 ;      XOBY("BUILD CALLBACK") = code to build list to display
 ;         example: XOBY("BUILD CALLBACK"="DO BUILD^XOBWUS1(2)"
 ;      
 D EN^VALM("XOBW WEB SERVICE DISPLAY")
 Q
 ;
HDR ; -- header code
 S VALMHDR(1)=$GET(XOBY("HEADER",1))
 S VALMHDR(2)=$GET(XOBY("HEADER",2))
 Q
 ;
INIT ; -- init variables and list array
 SET VALM("TITLE")=$GET(XOBY("TITLE"))
 IF $GET(XOBY("BUILD CALLBACK"))]"" XECUTE XOBY("BUILD CALLBACK")
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 DO CLEAN^VALM10
 Q
 ;
EXPND ; -- expand code
 Q
 ;
