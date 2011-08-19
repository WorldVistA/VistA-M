XOBWU ;ALB/MJK - HWSC :: Web Server Manager ; 09/13/10 4:00pm
 ;;1.0;HwscWebServiceClient;;September 13, 2010;Build 31
 ;
 QUIT
 ;
EN ; -- main entry point for XOBW WEB SERVER
 NEW VALMBCK
 KILL ^TMP("XOB WEBSERVERS",$JOB)
 SET VALMBCK=""
 DO EN^VALM("XOBW WEB SERVER")
 QUIT
 ;
HDR ; -- header code
 NEW Y
 SET X="                       HWSC Web Server Manager"
 SET VALMHDR(1)=X
 SET X="                      Version: "_$PIECE($TEXT(XOBWU+1),";",3)_"     Build: "_$$VERSION^XOBWENV()
 SET VALMHDR(2)=X
 QUIT
 ;
INIT ; -- init variables and list array
 DO CLEAR
 DO MSG
 QUIT
 ;
MSG ; -- set default message
 SET VALMSG="Legend:  *Enabled"
 QUIT
 ;
BUILD ; -- build list
 NEW I,XOBI,XOB0,X,XOBDATA,XOBROOT,XOBSITEI,Y
 DO KILL
 ;
 SET VALMCNT=0
 SET XOBROOT=$NAME(XOBDATA("DILIST","ID"))
 DO LIST^DIC(18.12,"",".01;.03;.04;.06;3.01;3.03","I","","","","","","",$NAME(XOBDATA))
 SET XOBI=0
 FOR  SET XOBI=$ORDER(@XOBROOT@(XOBI)) QUIT:'XOBI  DO
 . SET VALMCNT=VALMCNT+1
 . SET X=""
 . SET X=$$SETFLD^VALM1(VALMCNT,X,"ID")
 . SET X=$$SETFLD^VALM1($GET(@XOBROOT@(XOBI,.01)),X,"NAME")
 . SET X=$$SETFLD^VALM1($GET(@XOBROOT@(XOBI,.04))_":"_$$GETPORT(.XOBROOT,XOBI),X,"IP")
 . SET X=$$SETFLD^VALM1($SELECT(+$GET(@XOBROOT@(XOBI,.06)):"*",1:""),X,"ENABLED")
 . DO SET^VALM10(VALMCNT,X,VALMCNT)
 . SET ^TMP("XOB WEBSERVERS","IDX",$JOB,VALMCNT,VALMCNT)=+$GET(XOBDATA("DILIST",2,XOBI))
 ;
 QUIT
 ;
GETPORT(XOBROOT,XOBI) ; -- return reg or SSL port
 IF +$GET(@XOBROOT@(XOBI,3.01)) QUIT $GET(@XOBROOT@(XOBI,3.03))_" (SSL)"
 QUIT $GET(@XOBROOT@(XOBI,.03))
 ;
CLEAR ; -- clean up entries
 DO REFRESH
 QUIT
 ;
REFRESH ; -- refresh display
 DO BUILD
 SET VALMBCK="R"
 QUIT
 ;
KILL ; -- kill off list location
 KILL ^TMP("XOB WEBSERVERS",$JOB)
 KILL ^TMP("XOB WEBSERVERS","IDX",$JOB)
 QUIT
 ;
HELP ; -- help code
 SET X="?" DO DISP^XQORM1 WRITE !!
 QUIT
 ;
EXIT ; -- exit code
 QUIT
 ;
ADD ; -- add an web server entry
 ; -- Protocol: XOBW WEB SERVER ADD
 DO ACTION("ADD",0)
 QUIT
 ;
EDIT ; -- edit web server entry
 ; -- Protocol: XOBW WEB SERVER EDIT
 DO ACTION("EDIT",0)
 QUIT
 ;
DEL ; -- delete web server entry
 ; -- Protocol: XOBW WEB SERVER DELETE
 DO ACTION("DEL",0)
 QUIT
 ;
EXPAND ; -- expand web server entry
 DO ACTION("EXPAND",1)
 QUIT
 ;
AVAIL ; -- test web services availability
 ; -- Protocol: XOBW WEB SERVER TEST WS AVAILABILITY
 DO ACTION("AVAIL",0)
 QUIT
 ;
WST ; -- web server tester
 ; -- Protocol: XOBW WEB SERVER TESTER
 DO EN1^XOBTWU
 DO REFRESH
 DO MSG
 QUIT
 ;
WSM ; -- web service manager
 ; -- Protocol: XOBW WEB SERVICE MANAGER
 DO EN^XOBWUS
 DO REFRESH
 DO MSG
 QUIT
 ;
LKM ; -- lookup key manager
 ; -- Protocol: XOBW WEB SERVER LOOKUP KEY MANAGER
 DO EN^XOBWUA
 DO REFRESH
 DO MSG
 QUIT
 ;
ACTION(TYPE,XOBPAUSE) ; -- execute action
 DO FULL^VALM1
 NEW X,Y
 SET X="DO "_TYPE_"^XOBWU1"
 XECUTE X
 IF XOBPAUSE DO PAUSE^VALM1
 DO REFRESH
 DO MSG
 QUIT
 ;
