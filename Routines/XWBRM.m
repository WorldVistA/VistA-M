XWBRM ;OIFO-Oakland/REM - M2M Broker Server Request Mgr  ;4/6/06  10:21
 ;;1.1;RPC BROKER;**28,45**;Mar 28, 1997
 ;
 QUIT
 ;
 ; ---------------------------------------------------------------------
 ;                             Server Request Manager (SRM)
 ; ---------------------------------------------------------------------
 ;
EN(XWBROOT) ; -- main entry point for SRM
 NEW XWBOK,XWBOPT,XWBDATA,XWBMODE
 N XWBM2M ;Flag for M2M requests **M2M
 SET XWBOK=0,XWBM2M=0
 ;
 ; -- parse the xml
 SET XWBOPT=""
 DO EN^XWBRMX(XWBROOT,.XWBOPT,.XWBDATA)
 S XWBMODE=$G(XWBDATA("MODE"))
 ;M ^REM($J)=XWBDATA ;**TEST ONLY
 ;
 I $G(XWBDATA("URI"))="XUS GET VISITOR" D EN^XWBRPC(.XWBDATA) S XWBOK=1 S:'$D(DUZ) XWBSTOP=1 Q 1
 ;Break off to RCPBroker **M2M
 IF $G(XWBDATA("MODE"))="RPCBroker" D RPC^XWBM2MS(.XWBDATA) SET XWBSTOP=0
 ; -- single call processing
 IF $G(XWBDATA("MODE"),"single call")="single call" SET XWBSTOP=1
 ;
 ; -- check if app defined
 IF $G(XWBDATA("APP"))="" DO RMERR(1) SET XWBOK=0 GOTO ENQ
 ;
 ; -- process close request
 IF $G(XWBDATA("APP"))="CLOSE" DO  SET XWBOK=0 GOTO ENQ
 . D:$G(DUZ) LOGOUT^XUSRB ;**M2M -Logout user and cleanup
 . DO RESPONSE^XWBVL()
 . SET XWBSTOP=1
 ;
 ; -- do security checks
 IF $G(XWBDATA("MODE"))'="RPCBroker",'$$SECCHK() SET XWBOK=0 GOTO ENQ
 ;
 ; -- call app to write to socket
 IF $G(XWBDATA("APP"))="RPC" DO EN^XWBRPC(.XWBDATA) SET XWBOK=1
 ;
ENQ ;
 QUIT XWBOK
 ;
 ; ---------------------------------------------------------------------
 ;
SECCHK() ; -- do security checks  (no real checks at this time)
 NEW XWBCODES
 ;
 ; -- is token valid
 IF '$$CHKTOKEN($G(XWBDATA("SECTOKEN"))) SET XWBCODES(1)="",XWBCODES=$G(XWBCODES)+1
 ;
 ; -- is DUZ valid
 IF '$$CHKDUZ($G(XWBDATA("DUZ"))) SET XWBCODES(2)="",XWBCODES=$G(XWBCODES)+1
 ;
 ; -- if security errors then send error response
 IF $G(XWBCODES) D SECERR(.XWBCODES)
 ;
 QUIT '+$G(XWBCODES)
 ;
CHKTOKEN(XWBTOKEN) ; -- do check against token for validity
 ; -- // TODO: Need to check into how we might use XUS1B and related code in Kernel Sign-On (ESSO)
 NEW XWBINVAL
 SET XWBINVAL="#UNKNOWN#"
 IF $G(XWBTOKEN,XWBINVAL)=XWBINVAL QUIT 0
 QUIT 1
 ;
CHKDUZ(XWBDUZ) ; -- do check against DUZ for validity
 ; -- // TODO: Need to check into how we might use XUS1B and related code in Kernel Sign-On (ESSO)
 NEW XWBINVAL
 SET XWBINVAL="#UNKNOWN#"
 IF $G(XWBDUZ,XWBINVAL)=XWBINVAL QUIT 0
 IF '$D(^VA(200,+XWBDUZ,0)) QUIT 0
 QUIT 1
 ;
 ; ---------------------------------------------------------------------
 ;                 Request Manager and Security Error Handlers
 ; ---------------------------------------------------------------------
RMERR(XWBCODE) ; -- send request error message
 NEW XWBDAT,XWBMSG
 SET XWBMSG=$P($TEXT(RMERRS+XWBCODE),";;",2)
 SET XWBDAT("MESSAGE TYPE")="Gov.VA.Med.Foundations.Errors"
 SET XWBDAT("ERRORS",1,"CODE")=1
 SET XWBDAT("ERRORS",1,"ERROR TYPE")="request manager"
 SET XWBDAT("ERRORS",1,"CDATA")=1
 SET XWBDAT("ERRORS",1,"MESSAGE",1)="An Request Manager error occurred: "_XWBMSG
 DO ERROR^XWBUTL(.XWBDAT)
 QUIT
 ;
RMERRS ; -- application errors
 ;;No valid application specified.
 ;
SECERR(XWBCODES) ; -- send security error message
 NEW XWBDAT,XWBCNT,XWBCODE
 SET XWBCNT=0
 SET XWBDAT("MESSAGE TYPE")="Gov.VA.Med.Foundations.Security.Errors"
 SET XWBCODE=0 FOR  SET XWBCODE=$O(XWBCODES(XWBCODE)) Q:'XWBCODE  DO
 . SET XWBCNT=XWBCNT+1
 . SET XWBDAT("ERRORS",XWBCNT,"CODE")=XWBCODE
 . SET XWBDAT("ERRORS",XWBCNT,"ERROR TYPE")="security"
 . SET XWBDAT("ERRORS",XWBCNT,"MESSAGE",1)=$P($TEXT(SECERRS+XWBCODE),";;",2)
 . SET XWBDAT("ERRORS",XWBCNT,"CDATA")=0
 DO ERROR^XWBUTL(.XWBDAT)
 QUIT
 ;
SECERRS ; -- security errors
 ;;Security token is either invalid or was not passed.
 ;;DUZ is either invalid or was not passed.
 ;;
