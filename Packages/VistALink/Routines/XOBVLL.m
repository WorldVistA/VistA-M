XOBVLL ;; mjk/alb - VistALink Listen and Spawn Code ; 07/27/2002  13:00
 ;;1.6;VistALink;;May 08, 2009;Build 15
 ;Per VHA directive 2004-038, this routine should not be modified.
 QUIT
 ;
 ; ***deprecated*** tag ; Use START^XOBVTCP instead
START(SOCKET) ; -- start listener
 DO START^XOBVTCP(SOCKET)
 QUIT
 ;
 ; ***deprecated*** tag ; Use UCX^XOBVTCP instead
UCX ; -- VMS TCPIP (UCX) multi-thread entry point
 ; -- Called from VistALink .com files
 GOTO UCX^XOBVTCP
 ;
SPAWN ; -- spawned process
 NEW X,XOBSTOP,XOBPORT,XOBHDLR,XOBLASTR,XOBCMREF
 ;
 SET XOBSTOP=0
 SET XOBPORT=IO
 SET U="^"
 ;
 ; -- initialize timestamp for last time request made (used for debugging)
 SET XOBLASTR=0
 ;
 ; -- set error trap
 ;Set up the error trap
 SET $ETRAP="DO ^%ZTER HALT"
 ;
 ; -- attempt to share the license; must have TCP port open first
 USE XOBPORT IF $TEXT(SHARELIC^%ZOSV)'="" DO SHARELIC^%ZOSV(1)
 ;
 ; -- start RUM for VistALink Handler
 DO LOGRSRC^%ZOSV("$VISTALINK HANDLER$",2,1)
 ;
 ; -- cache/initialize startup request handlers 
 SET X=$$CACHE^XOBVRH(.XOBHDLR)
 IF 'X DO RMERR^XOBVRM(184001,$PIECE(X,U,2)) QUIT
 ;
 ; -- initialize tcp processing variables
 DO INIT^XOBVSKT
 ;
 ; -- change job name if possible
 DO SETNM^%ZOSV("VLink_"_$$CNV^XLFUTL($J,16))
 ;
 ; -- setup for Connection Mgr: get ref; kill data @ ref
 SET XOBCMREF=$$GETREF^XOBUZAP1()
 DO KILL^XOBUZAP0(XOBCMREF)
 ;
 ; -- loop until told to stop
 FOR  DO NXTCALL QUIT:XOBSTOP
 ;
 ; -- kill ^XTMP ref node
 DO KILL^XOBUZAP0(XOBCMREF)
 ;
 ; -- final/clean tcp processing variables
 DO FINAL^XOBVSKT
 ;
 ; -- stop RUM for VistALink Handler
 DO LOGRSRC^%ZOSV("$VISTALINK HANDLER$",2,2)
 ;
 QUIT
 ;
NXTCALL ; -- do next call
 NEW X,XOBROOT,XOBREAD,XOBTO,XOBFIRST,XOBOK,XOBRL,XOBDATA
 ;
 ; -- set up error trap
 NEW $ESTACK SET $ETRAP="DO SYSERR^XOBVLL"
 ;
 ; -- setup environment variables
 NEW DIQUIET SET DIQUIET=1
 SET U="^",DTIME=$GET(DTIME,900),DT=$$DT^XLFDT()
 ;
 ; -- set ^XTMP for Connection Mgr usage if DUZ not 1st piece
 IF '$$GETDUZ^XOBUZAP0(XOBCMREF) DO
 . NEW XOBDUZ,XOBIP
 . SET XOBDUZ=$GET(XOBSYS("DUZ"),$GET(DUZ))
 . SET XOBIP=$GET(IO("IP"))
 . DO SETVI^XOBUZAP0(XOBCMREF,XOBDUZ,XOBIP,$$GETDESC^XOBUZAP1())
 ;
 ; -- initialize 'current' request handler to empty string
 SET XOBHDLR=""
 ;
 ; -- # of chars to get on first read / read 11 for Broker initial read
 SET XOBREAD=11
 ;
 ; -- get J2SE heartbeat rate for timeout plus network latency factor
 SET XOBTO=$$GETRATE^XOBVLIB()+$$GETDELTA^XOBVLIB()
 ;
 ; -- get J2EE timeout value for app serv environment
 IF $GET(XOBSYS("ENV"))="j2ee" SET XOBTO=$$GETASTO^XOBVLIB()
 ;
 ; -- set first read flag
 SET XOBFIRST=1
 ;
 ; -- setup intake global
 SET XOBROOT=$NAME(^TMP("XOBVLL",$JOB))
 KILL @XOBROOT
 ;
 ; -- read from socket port
 USE XOBPORT
 SET XOBOK=$$READ^XOBVSKT(XOBROOT,.XOBREAD,.XOBTO,.XOBFIRST,.XOBSTOP,.XOBDATA,.XOBHDLR)
 ;
 ; -- timed out ; cleanup user and exit
 IF 'XOBOK!(XOBSTOP) DO  GOTO NXTCALLQ
 . IF $GET(DUZ) DO CLEAN^XOBSCAV1
 . SET XOBSTOP=1
 ;
 ; -- need null device
 IF '$DATA(XOBNULL) DO ERROR(181002,$$EZBLD^DIALOG(181002),XOBPORT) SET XOBSTOP=1 GOTO NXTCALLQ
 ;
 ; -- call request manager                   
 SET XOBOK=$$EN^XOBVRM(XOBROOT,.XOBDATA,.XOBHDLR)
 ; -- timestamp last time request made
 SET XOBLASTR=$$NOW^XLFDT()
 ; -- cleanup intake global
 KILL @XOBROOT
 ;
NXTCALLQ ; -- exit
 QUIT
 ;
 ; ----------------------------------------------------------------------------------
 ;                                System Error Handler
 ; ----------------------------------------------------------------------------------
SYSERR ; -- send system error message
 ; -- If we get an error in the error handler just Halt
 SET $ETRAP="D ^%ZTER HALT"
 ;
 DO ERROR(181001,$$EZBLD^DIALOG(181001,$$EC^%ZOSV),XOBPORT)      ; -- Get the error code
 QUIT
 ;
ERROR(XOBEC,XOBMSG,XOBPORT) ; -- send error message
 NEW XOBDAT
 ;
 ; -- If we get an error in the error handler just Halt
 SET $ETRAP="D ^%ZTER HALT"
 ;
 ; -- set up error info
 SET XOBDAT("MESSAGE TYPE")=3
 SET XOBDAT("ERRORS",1,"CODE")=XOBEC
 SET XOBDAT("ERRORS",1,"ERROR TYPE")="system"
 SET XOBDAT("ERRORS",1,"FAULT STRING")="System Error"
 SET XOBDAT("ERRORS",1,"CDATA")=1
 SET XOBDAT("ERRORS",1,"MESSAGE",1)=XOBMSG
 ;
 ; -- if serious error, save error info, logout, and halt
 IF XOBMSG["<READ>"!(XOBMSG["<WRITE>")!(XOBMSG["<SYSTEM>")!(XOBMSG["READERR")!(XOBMSG["WRITERR")!(XOBMSG["SYSERR") DO  HALT
 . DO ^%ZTER
 . IF $GET(DUZ) DO CLEAN^XOBSCAV1
 ;
 ; -- send error back to client
 USE XOBPORT
 DO ERROR^XOBVLIB(.XOBDAT)
 ;
 ; -- just quit if no slots are available or logins are disabled
 IF (XOBEC=181003)!(XOBEC=181004) QUIT
 ;
 ; -- need to make sure any locks are released since code aborted ungracefully
 LOCK
 ;
 ; -- Save off the error
 DO ^%ZTER
 ;
 ; -- go back to listening
 SET $ETRAP="Q:($ESTACK&'$QUIT)  Q:$ESTACK -9 S $ECODE="""" DO KILL^XOBVLL G NXTCALLQ^XOBVLL",$ECODE=",U99,"
 QUIT
 ;
KILL ; -- new VistALink variables and then do big KILL
 NEW XOBPORT,XOBSTOP,XOBNULL,XOBOS,XOBSYS,XOBHDLR,XOBOK,XOBLASTR,XOBCMREF
 DO KILL^XUSCLEAN
 QUIT
 ;
