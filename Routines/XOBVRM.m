XOBVRM ;; mjk/alb - VistaLink Request Manager ; 07/27/2002  13:00
 ;;1.6;VistALink;;May 08, 2009;Build 15
 ;Per VHA directive 2004-038, this routine should not be modified.
 QUIT
 ;
 ; --------------------------------------------------------------------------------
 ;                                Request Manager
 ; --------------------------------------------------------------------------------
 ;                   
EN(XOBROOT,XOBDATA,XOBHDLR) ; -- main entry point for Request Manager
 NEW XOBOK,XOBOPT
 SET XOBOK=0
 ;
 ; -- if 'current' request handler is not defined then parse xml global buffer
 ;    Note: 'Current' request handler could be define already via proprietary format reader
 IF $GET(XOBHDLR)="" SET XOBOPT="" DO EN^XOBVRMX(XOBROOT,.XOBOPT,.XOBDATA,.XOBHDLR)
 ;
 ; -- default single call processing if not specified by request handler
 IF $GET(XOBDATA("MODE"),"single call")="single call" SET XOBSTOP=1
 ;
 ; -- check if request handler info was successfully initialized / if not, throw exception
 SET XOBHDLR=+$GET(XOBHDLR)
 IF '$GET(XOBHDLR(XOBHDLR)) DO  GOTO ENQ
 . SET XWBTIP=$$GETPEER^%ZOSV ; try get client IP for error trap. Use of GETPEER^%ZOSV: DBIA #4056
 . DO RMERR(184001,$GET(XOBHDLR(XOBHDLR,"ERROR"),"Request Manager not defined"))
 . SET XOBOK=0
 ;
 ; -- do authentication check for message type?
 IF $GET(XOBHDLR(XOBHDLR,"AUTHENTICATE")) DO
 . SET XOBOK=$$LOGGEDON^XOBSCAV()
 ELSE  DO
 . SET XOBOK=1
 ;
 ; -- call request handler
 IF XOBOK XECUTE $GET(XOBHDLR(XOBHDLR,"REQHDLR"))
 ;
ENQ ;
 QUIT XOBOK
 ;
 ; ----------------------------------------------------------------------------------
 ;                    Request Manager Error Handler
 ; ----------------------------------------------------------------------------------
RMERR(XOBCODE,XOBMSG) ; -- send request error message
 NEW XOBDAT
 SET XOBDAT("MESSAGE TYPE")=3
 SET XOBDAT("ERRORS",1,"FAULT STRING")="System Error"
 SET XOBDAT("ERRORS",1,"FAULT ACTOR")="Request Manager"
 SET XOBDAT("ERRORS",1,"CODE")=XOBCODE
 SET XOBDAT("ERRORS",1,"ERROR TYPE")="Request Manager"
 SET XOBDAT("ERRORS",1,"CDATA")=0
 SET XOBDAT("ERRORS",1,"MESSAGE",1)=$$EZBLD^DIALOG(XOBCODE,XOBMSG)
 DO ERROR^XOBVLIB(.XOBDAT)
 DO ^%ZTER
 QUIT
 ;
