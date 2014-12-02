XWBVLL ;OIFO-Oakland/REM - M2M Broker Listener  ;12/29/2010
 ;;1.1;RPC BROKER;**28,41,34,62,63**;Mar 28, 1997;Build 4
 ;Per VHA Directive 6402, this routine should not be modified
 ;
 QUIT
 ;
 ;p41 - fixed infinite loop bug in SYSERR.
 ;    - new Cache/VMS tcpip entry point, called from XWBSERVER_START.COM file.
 ;p34 - added "BrokerM2M" in message type - SYSERR.
 ;    - removed the quotes (") after 'M:' - SYSERRS.
 ;    - new entry point to job off the listener for Cashe- STRT^XWBVLL(PORT).
 ;    - clear locks when error occurs - SYSERR.
 ;    - halt for read/write errors - SYSERR
 ; 
START(SOCKET) ;Entry point for Cache/NT
 ;May be called directly to start the listener.
 ;SOCKET -is the port# to start the listener on.
 I ^%ZOSF("OS")'["OpenM" Q  ;Quits if not a Cache OS.
 D LISTEN^%ZISTCPS(SOCKET,"SPAWN^XWBVLL")
 Q
 ;
UCX ;Old entry point NOT used anymore.  *p55*
 ;DMS/VMS UCX entry point, called from XWBSERVER_START.COM file,
 ;listener,  % = <input variable>
 ;IF $G(%)="" DO ^%ZTER QUIT
 SET (IO,IO(0))="SYS$NET"
 ; **VMS specific code, need to share device**
 OPEN IO:(TCPDEV):60 ELSE  SET ^TMP("XWB DSM CONNECT FAILURE",$H)="" QUIT
 USE IO
 DO SPAWN
 QUIT
 ;
STRT(PORT) ;*p34-This entry is called from option "XWB M2M CACHE LISTENER" and jobs off the listener for Cashe/NT.  Will call START.
 ;PORT -is the port# to start the listener on.
 J START^XWBVLL(PORT)::5 ;Used in place of TaskMan
 Q
 ;
CACHEVMS ;Cache/VMS tcpip entry point, called from XWBSERVER_START.COM fLle *p41*
 ;Update the SET (IO)="SYS$NET" *p55*
 SET (IO,IO(0))=$S($ZV["VMS":"SYS$NET",1:$P) ;Support for both VMS/TCPIP and Linux/xinetd *p55*
 ; **CACHE/VMS specific code**
 OPEN IO::60 ELSE  SET ^TMP("XWB DSM CONNECT FAILURE",$H)="" QUIT
 X "U IO:(::""-M"")" ;Packet mode like DSM
 DO SPAWN
 QUIT
 ;
SPAWN ; -- spawned process
 NEW U,DTIME,XWBROOT,XWBAVC,XWBSTOP
 SET U="^",DUZ=0,DUZ(0)="",DTIME=900,XWBROOT=$NA(^TMP("XWBVLL",$J)),XWBSTOP=0
 ;
 ; -- initialize tcp processing variables
 DO INIT^XWBRL
 ;
 ; -- set error trap
 NEW $ESTACK,$ETRAP S $ETRAP="D SYSERR^XWBVLL"
 ;Get IP from client
 S IO("IP")=$$GETPEER^%ZOSV()
 ; -- change job name if possible
 ;DO SETNM^%ZOSV("XWBSERVER: Server") ;**M2M - comment out for now
 DO SAVDEV^%ZISUTL("XWBM2M SERVER") ;**M2M save off server IO
 S XWBDEBUG=$$GET^XPAR("SYS","XWBDEBUG",,"Q")
 I XWBDEBUG D LOG^XWBRPC("Server Start @ "_$$NOW^XLFDT)
 ;check that XUS AV CODE is the 1st or 2nd RPC call P62
 I '$$GET^XPAR("SYS","XWB62",1,"Q") F XWBAVC=1:1:2 D NXTCALL Q:DUZ
 S XWBAVC=0
 ; process rest of messages; loop until told to stop
 D
 .I '$$GET^XPAR("SYS","XWB62",1,"Q") Q:'DUZ
 .F  DO NXTCALL QUIT:XWBSTOP
 ;
 ; -- final/clean tcp processing variables
 D RMDEV^%ZISUTL("XWBM2M SERVER") ;**M2M remove server IO
 Q
 ;
NXTCALL ; -- do next call
 NEW DT,X,XWBREAD,XWBTO,XWBFIRST,XWBOK,XWBRL,BUG
 ;
 ; -- setup environment variables
 SET DT=$$DT^XLFDT(),XWBREAD=20,XWBTO=36000,XWBFIRST=1 ;p63
 ;
 ; -- clean intake global - root is request data
 KILL @XWBROOT
 ;
 ; -- set parameters for RawLink
 SET XWBRL("TIME OUT")=36000
 SET XWBRL("READ CHARACTERS")=20
 SET XWBRL("FIRST READ")=1
 SET XWBRL("STORE")=XWBROOT
 SET XWBRL("STOP FLAG")=XWBSTOP
 ;
 ; -- read from socket
 SET XWBOK=$$READ^XWBRL(XWBROOT,.XWBREAD,.XWBTO,.XWBFIRST,.XWBSTOP)
 ;
 ;**TESTING **REM
 ;For debugging - hard set ^TMP(..."DEBUG") and ^TMP(..."CNT") to 1
 I $G(^TMP("XWBM2M","DEBUG")) D
 . S XWBCNT=(^TMP("XWBM2M","CNT"))+1
 . M ^TMP("XWBM2MSV","REQUEST",XWBCNT)=^TMP("XWBVLL",$J)
 . S ^TMP("XWBM2M","CNT")=XWBCNT
 . Q
 ;
 ;**TESING **RWF
 I $G(XWBDEBUG) D
 . N CNT
 . S CNT=$G(^TMP("XWBM2ML",$J))+1,^($J)=CNT
 . M ^TMP("XWBM2ML",$J,CNT)=^TMP("XWBVLL",$J)
 . Q
 ;
 IF 'XWBOK GOTO NXTCALLQ
 ;
 ; -- call request manager           
 SET XWBOK=$$EN^XWBRM(XWBROOT)
 ; 
NXTCALLQ ; -- exit
 ;
 QUIT
 ;
 ; ---------------------------------------------------------------------
 ;                                System Error Handler
 ; ---------------------------------------------------------------------
SYSERR ; -- send system error message
 ;p41-don't new $Etrap, it was causing infinite loop.
 ;p34-added "BrokerM2M" in message type in SYSERR.
 ;   -halt for read/write errors
 NEW XWBDAT,XWBMSG ;,$ETRAP ;*p41
 S $ETRAP="D ^%ZTER HALT" ;If we get an error in the error handler just Halt
 SET XWBMSG=$$EC^%ZOSV ;Get the error code
 D ^%ZTER ;Save off the error
 SET XWBDAT("MESSAGE TYPE")="Gov.VA.Med.BrokerM2M.Errors" ;*34
 SET XWBDAT("ERRORS",1,"CODE")=1
 SET XWBDAT("ERRORS",1,"ERROR TYPE")="system"
 SET XWBDAT("ERRORS",1,"CDATA")=1
 SET XWBDAT("ERRORS",1,"MESSAGE",1)=$P($TEXT(SYSERRS+1),";;",2)_XWBMSG
 ;*p34-will halt for read/write errors
 I XWBMSG["<READ>" HALT
 DO ERROR^XWBUTL(.XWBDAT)
 D UNWIND^%ZTER ;Return to NXTCALL loop
 L  ;Clear locks *p34
 Q
 ;
SYSERRS ; -- application errors
 ;*p34-removed the quotes (") after 'M:'
 ;;A system error occurred in M:
