XOBWUS ;ALB/MJK - HWSC :: Web Service Manager ; 09/13/10 4:00pm
 ;;1.0;HwscWebServiceClient;;September 13, 2010;Build 31
 ;
 QUIT
 ;
EN ; -- main entry point for XOBW WEB SERVICE
 KILL ^TMP("XOB WEBSERVICES",$JOB)
 SET VALMBCK=""
 DO EN^VALM("XOBW WEB SERVICE")
 QUIT
 ;
HDR ; -- header code
 NEW Y
 SET X="                       HWSC Web Service Manager"
 SET VALMHDR(1)=X
 SET X="                      Version: "_$PIECE($TEXT(XOBWUS+1),";",3)_"     Build: "_$$VERSION^XOBWENV()
 SET VALMHDR(2)=X
 QUIT
 ;
INIT ; -- init variables and list array
 DO CLEAR
 DO MSG
 QUIT
 ;
MSG ; -- set default message
 SET VALMSG=""
 QUIT
 ;
BUILD ; -- build list
 NEW XOBI,X,XOBDATA,XOBROOT,Y
 DO KILL
 ;
 SET VALMCNT=0
 SET XOBROOT=$NAME(XOBDATA("DILIST","ID"))
 DO LIST^DIC(18.02,"",".01;.02;200","","","","","","","",$NAME(XOBDATA))
 SET XOBI=0
 FOR  SET XOBI=$ORDER(@XOBROOT@(XOBI)) QUIT:'XOBI  DO
 . SET VALMCNT=VALMCNT+1
 . SET X=""
 . SET X=$$SETFLD^VALM1(VALMCNT,X,"ID")
 . SET X=$$SETFLD^VALM1($GET(@XOBROOT@(XOBI,.01)),X,"NAME")
 . SET X=$$SETFLD^VALM1($GET(@XOBROOT@(XOBI,.02)),X,"TYPE")
 . SET Y=$GET(@XOBROOT@(XOBI,200))
 . IF $LENGTH(Y)>35 SET Y=$EXTRACT(Y,1,35)_"..."
 . SET X=$$SETFLD^VALM1(Y,X,"CONTEXT")
 . DO SET^VALM10(VALMCNT,X,VALMCNT)
 . SET ^TMP("XOB WEBSERVICES","IDX",$JOB,VALMCNT,VALMCNT)=+$GET(XOBDATA("DILIST",2,XOBI))
 ;
 QUIT
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
 KILL ^TMP("XOB WEBSERVICES",$JOB)
 KILL ^TMP("XOB WEBSERVICES","IDX",$JOB)
 QUIT
 ;
HELP ; -- help code
 SET X="?" DO DISP^XQORM1 WRITE !!
 QUIT
 ;
EXIT ; -- exit code
 QUIT
 ;
ADD ; -- add an web service entry
 ; -- Protocol: XOBW WEB SERVICE ADD
 DO ACTION("ADD",0)
 QUIT
 ;
EDIT ; -- edit web service entry
 ; -- Protocol: XOBW WEB SERVICE EDIT
 DO ACTION("EDIT",0)
 QUIT
 ;
DEL ; -- delete web service entry
 ; -- Protocol: XOBW WEB SERVICE DELETE
 DO ACTION("DEL",0)
 QUIT
 ;
EXPAND ; -- expand web service entry
 DO ACTION("EXPAND",0)
 QUIT
 ;
ACTION(TYPE,XOBPAUSE) ; -- execute action
 DO FULL^VALM1
 NEW X,Y
 SET X="DO "_TYPE_"^XOBWUS1"
 XECUTE X
 IF XOBPAUSE DO PAUSE^VALM1
 DO REFRESH
 DO MSG
 QUIT
 ;
