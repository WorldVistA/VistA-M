XOBWUA ;OAK/KEC - HWSC :: Web Server Lookup Key Manager ; 09/13/10 4:00pm
 ;;1.0;HwscWebServiceClient;;September 13, 2010;Build 31
 ;
 QUIT
 ;
EN ; -- main entry point for XOBW WEB SERVER LOOKUPKEY
 NEW XOBSORT,XOBKFILT,XOBSFILT,X
 SET XOBSORT="K" ; default sort by KEY
 SET XOBKFILT=""
 SET XOBSFILT=""
 DO KILL
 SET VALMBCK=""
 DO EN^VALM("XOBW WEB SERVER LOOKUPKEY")
 QUIT
 ;
HDR ; -- header code
 SET X="                  HWSC Web Server Lookup Key Manager"
 SET VALMHDR(1)=X
 SET X="                      Version: "_$PIECE($TEXT(XOBWUA+1),";",3)_"     Build: "_$$VERSION^XOBWENV()
 SET VALMHDR(2)=X
 SET X=$SELECT(XOBSFILT]"":XOBSFILT,1:"<no filter>")
 SET VALMHDR(3)="Filters:  Key = "_$SELECT(XOBKFILT]"":XOBKFILT,1:"<no filter>")_"   Server = "_X
 QUIT
 ;
CHGCAP ; -- change captions to indicate sort
 NEW KEYCAP,SRVCAP
 SET KEYCAP="Lookup Key Name"
 SET SRVCAP="Web Server Name"
 IF XOBSORT="K" DO
 . DO CHGCAP^VALM("KEY",KEYCAP_" [Sorted By]")
 . DO CHGCAP^VALM("SERVER",SRVCAP)
 ELSE  DO
 . DO CHGCAP^VALM("SERVER",SRVCAP_" [Sorted By]")
 . DO CHGCAP^VALM("KEY",KEYCAP)
 QUIT
 ;
INIT ; -- init variables and list array
 DO CLEAR
 DO MSG
 DO CHGCAP
 QUIT
 ;
MSG ; -- set default message
 SET VALMSG=""
 QUIT
 ;
BUILD ; -- build list
 NEW I,XOBI,XOB0,X,XOBDATA,XOBROOT,XOBSITEI,Y,SORT,XOBX,XOBKEY,XOBSRVR
 DO KILL
 ;
 SET VALMCNT=0
 SET XOBROOT=$NAME(XOBDATA("DILIST","ID"))
 DO LIST^DIC(18.13,"",".01;.03","","","","","","","",$NAME(XOBDATA))
 ; -- build sort
 SET XOBI=0
 FOR  SET XOBI=$ORDER(@XOBROOT@(XOBI)) QUIT:'XOBI  DO
 . SET XOBX=$SELECT(XOBSORT="S":$GET(@XOBROOT@(XOBI,.03)),1:$GET(@XOBROOT@(XOBI,.01)))
 . SET SORT($SELECT(XOBX="":" ",1:XOBX),XOBI)=""
 ; -- build list off sort and apply filters
 SET XOBX=""
 FOR  SET XOBX=$ORDER(SORT(XOBX)) QUIT:XOBX=""  DO
 . SET XOBI=0
 . FOR  SET XOBI=$ORDER(SORT(XOBX,XOBI)) QUIT:'XOBI  DO
 . . SET XOBKEY=$GET(@XOBROOT@(XOBI,.01))
 . . SET XOBSRVR=$GET(@XOBROOT@(XOBI,.03))
 . . IF XOBSRVR="" SET XOBSRVR=$$NOTDEF()
 . . IF XOBKFILT]"",$EXTRACT(XOBKEY,1,$LENGTH(XOBKFILT))'=XOBKFILT QUIT
 . . IF XOBSFILT]"",$$UP^XLFSTR($EXTRACT(XOBSRVR,1,$LENGTH(XOBSFILT)))'=$$UP^XLFSTR(XOBSFILT) QUIT
 . . SET VALMCNT=VALMCNT+1
 . . SET X=""
 . . SET X=$$SETFLD^VALM1(VALMCNT,X,"ID")
 . . SET X=$$SETFLD^VALM1(XOBKEY,X,"KEY")
 . . SET X=$$SETFLD^VALM1(XOBSRVR,X,"SERVER")
 . . DO SET^VALM10(VALMCNT,X,VALMCNT)
 . . SET ^TMP("XOB WEB SERVER LOOKUP","IDX",$JOB,VALMCNT,VALMCNT)=+$GET(XOBDATA("DILIST",2,XOBI))
 ;
 QUIT
 ;
NOTDEF() ; -- constant text to use if server is not defined
 QUIT "<server not defined>"
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
 KILL ^TMP("XOB WEB SERVER LOOKUP",$JOB)
 KILL ^TMP("XOB WEB SERVER LOOKUP","XOB",$JOB)
 QUIT
 ;
HELP ; -- help code
 SET X="?" DO DISP^XQORM1 WRITE !!
 QUIT
 ;
EXIT ; -- exit code
 QUIT
 ;
ADD ; -- add a web server lookup identifier entry
 ; -- Protocol: XOBW ASSOCIATE ADD
 DO ACTION("ADD",0)
 QUIT
 ;
EDIT ; -- edit a web server lookup identifier entry
 ; -- Protocol: XOBW ASSOCIATE EDIT
 DO ACTION("EDIT",0)
 QUIT
 ;
DEL ; -- delete web server lookup identifier entry
 ; -- Protocol: XOBW ASSOCIATE DELETE
 DO ACTION("DEL",0)
 QUIT
 ;
EXPAND ; -- expand web server lookup identifier entry
 DO ACTION("EXPAND",1)
 QUIT
 ;
SORT ; -- sort list
 ; -- Protocol: XOBW ASSOCIATE SORT
 DO ACTION("SORT",0)
 DO HDR
 DO CHGCAP
 QUIT
 ;
KFILTER ; -- specify look up key filter
 ; -- Protocol: XOBW ASSOCIATE FILTER KEY
 DO ACTION("KFILTER",0)
 DO HDR
 QUIT
 ;
SFILTER ; -- specify web server filter
 ; -- Protocol: XOBW ASSOCIATE FILTER SERVER
 DO ACTION("SFILTER",0)
 DO HDR
 QUIT
 ;
ACTION(TYPE,XOBPAUSE) ; -- execute action
 DO FULL^VALM1
 NEW X,Y
 SET X="DO "_TYPE_"^XOBWUA1"
 XECUTE X
 IF XOBPAUSE DO PAUSE^VALM1
 DO REFRESH
 DO MSG
 QUIT
 ;
