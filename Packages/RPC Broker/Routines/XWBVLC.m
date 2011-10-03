XWBVLC ;OIFO-Oakland/REM - M2M Broker Client  ;05/17/2002  17:47
 ;;1.1;RPC BROKER;**28**;Mar 28, 1997
 ;QUIT
 ;
EXECUTE(XWBPARMS) ; -- Main entry point
 NEW X,XWBI,XWBOK,XWBRES,XWBREF,XWBROOT,XWBREQ,XWBREAD,XWBTO,XWBFIRST,XWBSTOP
 NEW $ETRAP,$ESTACK S $ETRAP="D SYSERR^XWBVLL"
 ;
 ; -- if no 'results' node set, set it and kill it!
 IF $G(XWBPARMS("RESULTS"))="" SET XWBPARMS("RESULTS")=$NA(^TMP("XWBM2MVLC",$J,"XML"))
 SET XWBROOT=XWBPARMS("RESULTS")
 KILL @XWBROOT
 ;
 SET XWBREQ=XWBPARMS("REQUEST")
 ;
 SET XWBRES=0
 ;
 ; -- check for socket information **M2M - use later for error chk
 ;IF '$D(XWBPARMS("ADDRESS")) D CLIERR(1,.XWBROOT) GOTO MAINQ
 ;IF '$D(XWBPARMS("PORT")) D CLIERR(2,.XWBROOT) GOTO MAINQ
 ;  Retry open 3 times
 ;SET XWBPARMS("RETRIES")=3
 ;
 ;IF '$$OPEN^XWBRL(.XWBPARMS) D CLIERR(3,.XWBROOT) GOTO MAINQ ;can pull out after it works with M2M **REM
 ;
 ; -- write request
 DO PRE^XWBRL
 SET XWBI=0 FOR  SET XWBI=$O(@XWBREQ@(XWBI)) Q:'XWBI  DO WRITE^XWBRL(@XWBREQ@(XWBI))
 ;
 ;IF $G(XWBDBUG) S X=$G(XWBPARMS("URI")) M ^TMP("XWBM2MCL",X)=XWBPARMS
 ;
 ; -- send eot and flush buffer
 DO POST^XWBRL
 ;
 SET XWBREAD=20,XWBTO=1,XWBFIRST=0,XWBSTOP=0
 ;
 ; -- set parameters for RawLink
 SET XWBRL("TIME OUT")=1
 SET XWBRL("READ CHARACTERS")=20
 SET XWBRL("FIRST READ")=0
 SET XWBRL("STORE")=XWBROOT
 SET XWBRL("STOP FLAG")=0
 ;
 ; -- read results
 SET XWBOK=$$READ^XWBRL(XWBROOT,.XWBREAD,.XWBTO,.XWBFIRST,.XWBSTOP)
 ;
 ;-------------------------------------------------------
 ; -- close port - - delete after close works **REM 
 ;IF $G(XWBPARMS("MODE"))'="RPCBroker" D CLOSE^XWBRL
 ;
 ;D CLOSE^XWBRL ;Comment out for M2M
 ;---------------------------------------------------------------
 ;
 ; -- app processes data (0 = success) ; I think 0 = failure **REM
 SET XWBRES=1
 ;
MAINQ ;
 QUIT XWBRES
 ;
 ; ----------------------------------------------------------------------------------
 ;                                Client Error Handler
 ; ----------------------------------------------------------------------------------
CLIERR(XWBCODE,XWBROOT) ; -- send client error message
 NEW XWBDAT
 SET XWBDAT("MESSAGE TYPE")="Gov.VA.Med.Foundations.Errors"
 SET XWBDAT("ERRORS",1,"CODE")=1
 SET XWBDAT("ERRORS",1,"ERROR TYPE")="client"
 SET XWBDAT("ERRORS",1,"CDATA")=1
 SET XWBDAT("ERRORS",1,"MESSAGE",1)=$P($TEXT(CLIERRS+XWBCODE),";;",2)
 DO BUILD^XWBUTL(.XWBROOT,.XWBDAT)
 QUIT
 ;
CLIERRS ; -- VistALink client errors
 ;;'Address' parameter not specified.
 ;;'Port' parameter not specified.
 ;;"Not able to open port"
