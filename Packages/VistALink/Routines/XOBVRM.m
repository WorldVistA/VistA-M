XOBVRM ;; mjk/alb - VistaLink Request Manager ; 07/27/2002  13:00
 ;;1.6;VistALink Security;**4**;May 08, 2009;Build 7
 ; ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
 ; --------------------------------------------------------------------------------
 ;                                Request Manager
 ; --------------------------------------------------------------------------------
 ;                   
EN(XOBROOT,XOBDATA,XOBHDLR) ; -- main entry point for Request Manager
 N XOBOK,XOBOPT
 S XOBOK=0
 ;
 ; -- if 'current' request handler is not defined then parse xml global buffer
 ;    Note: 'Current' request handler could be define already via proprietary format reader
 I $G(XOBHDLR)="" S XOBOPT="" D EN^XOBVRMX(XOBROOT,.XOBOPT,.XOBDATA,.XOBHDLR)
 ;
 ; -- default single call processing if not specified by request handler
 I $G(XOBDATA("MODE"),"single call")="single call" S XOBSTOP=1
 ;
 ; -- check if request handler info was successfully initialized / if not, throw exception
 S XOBHDLR=+$G(XOBHDLR)
 I '$G(XOBHDLR(XOBHDLR)) D  G ENQ
 . S XWBTIP=$$GETPEER^%ZOSV ; try get client IP for error trap. Use of GETPEER^%ZOSV: DBIA #4056
 . D RMERR(184001,$G(XOBHDLR(XOBHDLR,"ERROR"),"Request Manager not defined"))
 . S XOBOK=0
 ;
 ; -- do authentication check for message type?
 I $G(XOBHDLR(XOBHDLR,"AUTHENTICATE")) D
 . S XOBOK=$$LOGGEDON^XOBSCAV()
 E  D
 . S XOBOK=1
 ;
 ; -- call request handler
 I XOBOK X $G(XOBHDLR(XOBHDLR,"REQHDLR"))
 ;
ENQ ;
 Q XOBOK
 ;
 ; ----------------------------------------------------------------------------------
 ;                    Request Manager Error Handler
 ; ----------------------------------------------------------------------------------
RMERR(XOBCODE,XOBMSG) ; -- send request error message
 N XOBDAT,$ET,$ES
 S XOBDAT("MESSAGE TYPE")=3
 S XOBDAT("ERRORS",1,"FAULT STRING")="System Error"
 S XOBDAT("ERRORS",1,"FAULT ACTOR")="Request Manager"
 S XOBDAT("ERRORS",1,"CODE")=XOBCODE
 S XOBDAT("ERRORS",1,"ERROR TYPE")="Request Manager"
 S XOBDAT("ERRORS",1,"CDATA")=0
 S XOBDAT("ERRORS",1,"MESSAGE",1)=$$EZBLD^DIALOG(XOBCODE,XOBMSG)
 D ERROR^XOBVLIB(.XOBDAT)
 ;DO ^%ZTER
 D APPERROR^%ZTER("VistALink Error "_XOBCODE) ;*4
 Q
 ;
