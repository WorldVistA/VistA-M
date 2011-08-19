VBECVLC ;HOIFO/BNT-VBECS VistALink Client ;07/27/2002
 ;;1.0;VBECS;**3**;Apr 14, 2005;Build 21
 ;
 ; Note: This routine supports data exchange with an FDA registered
 ; medical device. As such, it may not be changed in any way without
 ; prior written approval from the medical device manufacturer.
 ; 
 ; Integration Agreements:
 ;  Call to XOBVLIB Supported by IA #4090
 ;  Reference to %ZOSV supported by IA #10097
 ;  Reference to %ZTER supported by IA #1621
 ;
 QUIT
 ;
EXECUTE(VBECPRMS) ; -- Main entry point
 NEW X,VBECI,VBECOK,VBECRES,VBECREF,VBECROOT,VBECREQ,VBECREAD,VBECTO,VBECFRST,VBECSTOP,VBECRL
 NEW $ETRAP,$ESTACK S $ETRAP="D SYSERR^VBECVLC"
 ;
 ; -- if no 'results' node set, set it and kill it!
 IF $G(VBECPRMS("RESULTS"))="" SET VBECPRMS("RESULTS")=$NA(^TMP("VBECVLC",$J,"XML"))
 SET VBECROOT=VBECPRMS("RESULTS")
 KILL @VBECROOT
 ;
 SET VBECREQ=VBECPRMS("REQUEST")
 ;
 ; -- intialize result flag to 'failed' (0)
 SET VBECRES=0
 ;
 ; -- application can pass in address/port
 IF '$D(VBECPRMS("ADDRESS")) D CLIERR(1,.VBECROOT) GOTO MAINQ
 IF '$D(VBECPRMS("PORT")) D CLIERR(2,.VBECROOT) GOTO MAINQ
 ;
 ;  Retry open only once to prevent delay in calling application
 SET VBECPRMS("RETRIES")=1
 IF '$$OPEN^VBECRL(.VBECPRMS) D CLIERR(3,.VBECROOT) GOTO MAINQ
 ;
 ; -- write request
 DO PRE^VBECRL
 SET VBECI=0 FOR  SET VBECI=$O(@VBECREQ@(VBECI)) Q:'VBECI  DO WRITE^VBECRL(@VBECREQ@(VBECI))
 ;
 ; -- send eot and flush buffer
 DO POST^VBECRL
 ;
 ; -- set inputs and read results
 SET VBECREAD=255,VBECTO=1,VBECFRST=0,VBECSTOP=0
 SET VBECOK=$$READ^VBECRL(VBECROOT,.VBECREAD,.VBECTO,.VBECFRST,.VBECSTOP)
 ;
 ; -- close port
 DO CLOSE^VBECRL(.VBECPRMS)
 ;
 ; -- set result flag to 'successful' (1)
 SET VBECRES=1
 ;
MAINQ ;
 QUIT VBECRES
 ;
 ; -----------------------------------------------------
 ;         Client Error Handler
 ; -----------------------------------------------------
CLIERR(VBECCODE,VBECROOT) ; -- send client error message
 NEW VBECDAT
 SET VBECDAT("MESSAGE TYPE")="gov.va.med.foundations.rpc.fault"
 SET VBECDAT("ERRORS",1,"CODE")=1
 SET VBECDAT("ERRORS",1,"ERROR TYPE")="client"
 SET VBECDAT("ERRORS",1,"CDATA")=1
 SET VBECDAT("ERRORS",1,"MESSAGE")=$P($TEXT(CLIERRS+VBECCODE),";;",2)
 DO BUILD(.VBECROOT,.VBECDAT)
 QUIT
 ;
 ; ------------------------------------------------------
 ;         System Error Handler
 ; ------------------------------------------------------
SYSERR ; -- send system error message
 NEW VBECDAT,VBECMSG,$ETRAP
 SET $ETRAP="D ^%ZTER HALT" ; -- If we get an error in the error handler just Halt
 SET VBECMSG=$$EC^%ZOSV      ; -- Get the error code
 DO ^%ZTER                  ; -- Save off the error
 ;
 SET VBECDAT("MESSAGE TYPE")="gov.va.med.foundations.rpc.fault"
 SET VBECDAT("ERRORS",1,"CODE")=1
 SET VBECDAT("ERRORS",1,"ERROR TYPE")="system"
 SET VBECDAT("ERRORS",1,"CDATA")=1
 SET VBECDAT("ERRORS",1,"MESSAGE")=$P($TEXT(SYSERRS+1),";;",2)_VBECMSG
 DO BUILD(.VBECROOT,.VBECDAT)
 QUIT
 ;
BUILD(VBECY,VBECDAT) ;  -- store built xml in passed store reference (VBECY)
 ; -- input format
 ; VBECDAT("MESSAGE TYPE") = type of message (ex. gov.va.med.foundations.rpc.fault) 
 ; VBECDAT("ERRORS",<integer>,"CODE") = error code
 ; VBECDAT("ERRORS",<integer>,"ERROR TYPE") = type of error (system/application/security)
 ; VBECDAT("ERRORS",<integer>,"MESSAGE",<integer>) = error message
 ; 
 NEW VBECCODE,VBECI,VBECERR,VBECLINE,VBECETYP
 SET VBECLINE=0
 ;
 DO ADD($$XMLHDR^XOBVLIB())
 DO ADD("<VistaLink messageType="""_$G(VBECDAT("MESSAGE TYPE"))_""" version=""1.0"" xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance"" xsi:noNamespaceSchemaLocation=""rpcFault.xsd"" >")
 DO ADD("xmlns=""http://med.va.gov/Foundations"">")
 DO ADD("<Fault>")
 DO ADD("<FaultString>Internal Application Error</FaultString>")
 DO ADD("<FaultActor>VBECS VistaLink Client</FaultActor>")
 SET VBECERR=0
 FOR  SET VBECERR=$O(VBECDAT("ERRORS",VBECERR)) Q:'VBECERR  DO
 . SET VBECCODE=$G(VBECDAT("ERRORS",VBECERR,"CODE"),0)
 . SET VBECETYP=$G(VBECDAT("ERRORS",VBECERR,"ERROR TYPE"),0)
 . DO ADD("<Detail>")
 . DO ADD("<Error code="""_VBECCODE_""" type="""_VBECETYP_""" >")
 . DO ADD("<Message>"_$$CHARCHK^XOBVLIB(VBECDAT("ERRORS",VBECERR,"MESSAGE"))_"</Message>")
 . DO ADD("</Error>")
 . DO ADD("</Detail>")
 DO ADD("</Fault>")
 DO ADD("</VistaLink>")
 ;
 QUIT
 ;
ADD(TXT) ; -- add line
 SET VBECLINE=VBECLINE+1
 SET @VBECY@(VBECLINE)=TXT
 QUIT
 ;
CLIERRS ; -- VistALink client errors
 ;;'Address' parameter not specified.
 ;;'Port' parameter not specified.
 ;;Unable to retrieve patient information at this time, please contact the Blood Bank. [restart VBECS VistALink listener]
 ;
SYSERRS ; -- application errors
 ;;A system error occurred in M: "
