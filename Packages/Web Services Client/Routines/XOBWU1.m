XOBWU1 ;ALB/MJK - HWSC :: Web Server Manager ; 09/13/10 4:00pm
 ;;1.0;HwscWebServiceClient;;September 13, 2010;Build 31
 ;
 QUIT
 ;
ADD ; -- add web server entry
 NEW DIC,Y,XOBY,D
 WRITE !
 SET DIC="^XOB(18.12,",DIC(0)="AELQ",D="B" DO IX^DIC KILL DIC
 SET XOBY=Y
 IF +XOBY>0,'$PIECE(XOBY,U,3) DO  GOTO ADDQ
 . DO DISPLAY("",+XOBY)
 . WRITE !!,"This is not a new entry! Please use 'Edit Server' action."
 . DO PAUSE^VALM1
 IF +XOBY>0,$PIECE(XOBY,U,3) DO DOEDIT(+XOBY)
ADDQ ;
 QUIT
 ;
EDIT ; -- edit web server entry
 NEW DA,DR,DIE,XOBI,VALMY
 DO EN^VALM2(XQORNOD(0),"OS")
 SET XOBI=+$ORDER(VALMY(""))
 IF XOBI>0 DO DOEDIT(+$GET(^TMP("XOB WEBSERVERS","IDX",$JOB,XOBI,XOBI)))
EDITQ ;
 QUIT
 ;
DOEDIT(DA) ; -- do actual web server edit
 NEW DR,DIE
 SET DR="[XOBW WEB SERVER SETUP]",DIE="^XOB(18.12," DO ^DIE
 QUIT
 ;
DEL ; -- delete web server entry
 NEW XOBI,VALMY,Y,XOBDA
 DO EN^VALM2(XQORNOD(0),"OS")
 SET XOBI=+$ORDER(VALMY(""))
 ; -- quit if nothing selected
 IF XOBI'>0 GOTO DELQ
 ; -- display entry, ask if 'ok' and delete
 SET XOBDA=+$GET(^TMP("XOB WEBSERVERS","IDX",$JOB,XOBI,XOBI))
 DO DISPLAY(XOBI,XOBDA)
 IF $ORDER(^XOB(18.13,"WS",XOBDA,""))]"" DO  GOTO DELQ
 . WRITE !,*7
 . WRITE !,"************************************************************"
 . WRITE !,"* Lookup keys are still associated with this web server.   *"
 . WRITE !,"*                  Deletion prohibited!                    *"
 . WRITE !,"* Use the 'Lookup Key Manager' to change key associations. *"
 . WRITE !,"************************************************************"
 . DO PAUSE^VALM1
 DO
 . NEW DIR
 . SET DIR("A")="Are you sure you want to delete entry"
 . SET DIR("B")="NO",DIR(0)="Y"
 . WRITE !
 . DO ^DIR
 IF '$GET(Y) DO  GOTO DELQ
 . WRITE !!,"Deletion aborted."
 . DO PAUSE^VALM1
 ; -- execute deletion
 DO DODEL(XOBDA)
 WRITE !!,"Entry has been deleted."
 DO PAUSE^VALM1
DELQ ;
 QUIT
 ;
DODEL(DA) ; -- do actual web server delete
 NEW DIK
 SET DIK="^XOB(18.12," DO ^DIK
 QUIT
 ;
EXPAND ; -- expand Protocol
 NEW DA,DIC,XOBI,VALMY
 DO EN^VALM2(XQORNOD(0),"OS")
 SET XOBI=+$ORDER(VALMY(""))
 IF XOBI>0 DO DISPLAY(XOBI,+$GET(^TMP("XOB WEBSERVERS","IDX",$JOB,XOBI,XOBI)))
 QUIT
 ;
DISPLAY(XOBI,DA) ; display web server informaton
 ; input: XOBI == list entry number
 ;        DA   == internal entry number in file 18.12
 NEW DIC,XOBLINE,XOBDASH,IEN,IEN0,KEY,XOBY
 SET $PIECE(XOBLINE,"=",$GET(IOM,80))=""
 SET $PIECE(XOBDASH,"-",$GET(IOM,80))=""
 DO CLEAR^VALM1
 WRITE !,XOBLINE
 IF $GET(XOBI) DO
 . WRITE !,@VALMAR@(XOBI,0)
 . WRITE !,XOBDASH
 SET DIC="^XOB(18.12,"
 DO EN^DIQ
 WRITE XOBDASH
 ; -- display lookup keys associated with web server
 WRITE !,"Lookup keys associated with server:"
 SET IEN=""
 FOR  SET IEN=$ORDER(^XOB(18.13,"WS",DA,IEN)) QUIT:'IEN  DO
 . SET IEN0=$GET(^XOB(18.13,IEN,0))
 . SET KEY=$PIECE(IEN0,"^")
 . IF KEY]"" SET XOBY(KEY)=$PIECE(IEN0,"^",2)
 IF $ORDER(XOBY(""))]"" DO
 . SET KEY="" FOR  SET KEY=$ORDER(XOBY(KEY)) QUIT:KEY=""  DO
 . . WRITE !?2,"o ",KEY," - ",XOBY(KEY)
 ELSE  DO
 . WRITE !?3,"<No lookup keys associations>"
 WRITE !,XOBLINE
 QUIT
 ;
AVAIL ; -- check web service availabilities
 NEW XOBI,XOBY,VALMY
 DO EN^VALM2(XQORNOD(0),"OS")
 SET XOBI=+$ORDER(VALMY(""))
 IF $GET(XOBI) DO
 . SET XOBY("HEADER",1)="Web Server: "
 . SET XOBY("HEADER",2)=@VALMAR@(XOBI,0)
 . SET XOBY("TITLE")="Web Service Availability"
 . SET XOBY("BUILD CALLBACK")="DO BUILD^XOBWU1("_+$GET(^TMP("XOB WEBSERVERS","IDX",$JOB,XOBI,XOBI))_")"
 . D EN^XOBWUS2(.XOBY)
 QUIT
 ;
BUILD(XOBDA) ; -- test web services availability
 NEW XOBSRVR,XOBY,XOBDOTS,XOBI,XOBX
 DO CLEAN^VALM10
 SET XOBSRVR=##class(xobw.WebServer).%OpenId(XOBDA)
 SET VALMCNT=0
 SET XOBDOTS=1 ; -- write dots during check processing
 SET XOBY=XOBSRVR.checkWebServicesAvailability(XOBDOTS)
 IF XOBY]"",XOBY.Count()>0 DO
 . FOR XOBI=1:1:XOBY.Count() SET XOBX=XOBY.GetAt(XOBI) QUIT:XOBI=""  DO ADDLN("  "_XOBX)
 QUIT
 ;
ADDLN(XOBTEXT) ; -- add line utility
 SET VALMCNT=VALMCNT+1
 DO SET^VALM10(VALMCNT,XOBTEXT)
 QUIT
 ;
