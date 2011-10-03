XOBVTLS ;; mjk/alb - VistALink Programmer Mode Support Tools ; 07/27/2002  13:00
 ;;1.6;VistALink;;May 08, 2009;Build 15
 ;Per VHA directive 2004-038, this routine should not be modified.
 QUIT
 ;
DEBUG ; -- entry point for debugging
 NEW XOBDSKT
 ;
 WRITE !,"Before running this entry point set your debugger"
 WRITE !,"to stop at the place you want to debug."
 WRITE !!,"Some possible spots to use:"
 WRITE !,"     o  SERV+1^XOBVTLS  => where debugging starts"
 WRITE !,"     o  SPAWN+1^XOBVLL  => where VistALink spawn starts"
 WRITE !,"     o  or location of your choice.",!
 ;
 WRITE !,"IP Socket to Listen on ('^' to quit): "
 READ XOBDSKT:300
 ;
 ; -- quit if read timed out or up-arrow or number not entered
 IF '$TEST!(XOBDSKT["^")!(+XOBDSKT=0) DO  GOTO DEBUGQ
 . WRITE !,"Socket number not entered...debug listener not started.",!
 ;
 WRITE !!,"================================================"
 WRITE !,"Starting listener at port ",XOBDSKT," [Job: ",$JOB,"]..."
 ;
 ; -- use %ZISTCP to do a single server
 DO LISTEN^%ZISTCP(XOBDSKT,"SERV^XOBVTLS")
 ;
 USE $PRINCIPAL
 WRITE !!,"Listener stopped on port ",XOBDSKT,"."
 WRITE !,"Done."
 WRITE !,"================================================"
DEBUGQ QUIT
 ;
SERV ; -- service debug session
 NEW XOBDEBUG,XOBEC
 ;
 ; -- set a debug mode flag for reference
 SET XOBDEBUG=1
 ;
 USE $PRINCIPAL WRITE !!,"Debug mode started...",!
 USE IO
 ;
 ; -- do basic checks and then real spawn
 SET XOBEC=$$NEWOK^XOBVTCPL()
 IF XOBEC DO LOGINERR^XOBVTCPL(XOBEC,IO)
 IF 'XOBEC DO SPAWN^XOBVLL
 ;
 ; -- cause the listener to stop
 SET IO("C")=1
 QUIT
 ;
