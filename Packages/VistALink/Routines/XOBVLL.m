XOBVLL ;MJK/ALB - VistALink Listen and Spawn Code ; 07/27/2002  13:00
 ;;1.6;VistALink;**4,6**;Apr 5,2017;Build 33
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
 ; ***deprecated*** tag ; Use START^XOBVTCP instead
START(SOCKET) ; -- start listener
 D START^XOBVTCP(SOCKET)
 Q
 ;
 ; ***deprecated*** tag ; Use UCX^XOBVTCP instead
UCX ; -- VMS TCPIP (UCX) multi-thread entry point
 ; -- Called from VistALink .com files
 G UCX^XOBVTCP
 ;
SPAWN ; -- spawned process
 N X,XOBSTOP,XOBPORT,XOBHDLR,XOBLASTR,XOBCMREF
 ;
 S XOBSTOP=0
 S XOBPORT=IO
 S U="^"
 ;
 ; -- initialize timestamp for last time request made (used for debugging)
 S XOBLASTR=0
 ;
 ; -- set error trap
 ;Set up the error trap
 ; * * *
 ;S $ET="D APPERROR^%ZTER(""VistALink Error $P(XOBMSG,"": "",2 "") HALT" ;*4
 S $ET="D APPERROR^%ZTER(""VistALink Error ""_$P(XOBMSG,"": "",2)) HALT" ;*6
 ; * * *
 ;
 ; -- attempt to share the license; must have TCP port open first
 U XOBPORT I $T(SHARELIC^%ZOSV)'="" D SHARELIC^%ZOSV(1)
 ;
 ; -- start RUM for VistALink Handler
 D LOGRSRC^%ZOSV("$VISTALINK HANDLER$",2,1)
 ;
 ; -- cache/initialize startup request handlers 
 S X=$$CACHE^XOBVRH(.XOBHDLR)
 I 'X D RMERR^XOBVRM(184001,$P(X,U,2)) Q
 ;
 ; -- initialize tcp processing variables
 D INIT^XOBVSKT
 ;
 ; -- change job name if possible
 D SETNM^%ZOSV("VLink_"_$$CNV^XLFUTL($J,16))
 ;
 ; -- setup for Connection Mgr: get ref; kill data @ ref
 S XOBCMREF=$$GETREF^XOBUZAP1()
 D KILL^XOBUZAP0(XOBCMREF)
 ;
 ; -- loop until told to stop
 F  D NXTCALL Q:XOBSTOP
 ;
 ; -- kill ^XTMP ref node
 D KILL^XOBUZAP0(XOBCMREF)
 ;
 ; -- final/clean tcp processing variables
 D FINAL^XOBVSKT
 ;
 ; -- stop RUM for VistALink Handler
 D LOGRSRC^%ZOSV("$VISTALINK HANDLER$",2,2)
 ;
 Q
 ;
NXTCALL ; -- do next call
 N X,XOBROOT,XOBREAD,XOBTO,XOBFIRST,XOBOK,XOBRL,XOBDATA
 ;
 ; -- set up error trap
 N $ES S $ET="DO SYSERR^XOBVLL"
 ;
 ; -- setup environment variables
 N DIQUIET S DIQUIET=1
 S U="^",DTIME=$G(DTIME,900),DT=$$DT^XLFDT()
 ;
 ; -- set ^XTMP for Connection Mgr usage if DUZ not 1st piece
 I '$$GETDUZ^XOBUZAP0(XOBCMREF) D
 . N XOBDUZ,XOBIP
 . S XOBDUZ=$G(XOBSYS("DUZ"),$G(DUZ))
 . S XOBIP=$G(IO("IP"))
 . D SETVI^XOBUZAP0(XOBCMREF,XOBDUZ,XOBIP,$$GETDESC^XOBUZAP1())
 ;
 ; -- initialize 'current' request handler to empty string
 S XOBHDLR=""
 ;
 ; -- # of chars to get on first read / read 11 for Broker initial read
 S XOBREAD=11
 ;
 ; -- get J2SE heartbeat rate for timeout plus network latency factor
 S XOBTO=$$GETRATE^XOBVLIB()+$$GETDELTA^XOBVLIB()
 ;
 ; -- get J2EE timeout value for app serv environment
 I $G(XOBSYS("ENV"))="j2ee" S XOBTO=$$GETASTO^XOBVLIB()
 ;
 ; -- set first read flag
 S XOBFIRST=1
 ;
 ; -- setup intake global
 S XOBROOT=$NA(^TMP("XOBVLL",$J))
 K @XOBROOT
 ;
 ; -- read from socket port
 U XOBPORT
 S XOBOK=$$READ^XOBVSKT(XOBROOT,.XOBREAD,.XOBTO,.XOBFIRST,.XOBSTOP,.XOBDATA,.XOBHDLR)
 ;
 ; -- timed out ; cleanup user and exit
 I 'XOBOK!(XOBSTOP) D  G NXTCALLQ
 . I $G(DUZ) D CLEAN^XOBSCAV1
 . S XOBSTOP=1
 ;
 ; -- need null device
 ; * * *
 ;I '$D(XOBNULL) D ERROR(181002,$$EZBLD^DIALOG(181002),XOBPORT) S XOBSTOP=1 G NXTCALLQ
 I '$D(XOBNULL) D ERROR(181002,$$EZBLD^DIALOG(181002,$$EC^%ZOSV),XOBPORT) S XOBSTOP=1 G NXTCALLQ ;*6
 ; * * *
 ;
 ; -- call request manager                   
 S XOBOK=$$EN^XOBVRM(XOBROOT,.XOBDATA,.XOBHDLR)
 ; -- timestamp last time request made
 S XOBLASTR=$$NOW^XLFDT()
 ; -- cleanup intake global
 K @XOBROOT
 ;
NXTCALLQ ; -- exit
 Q
 ;
 ; ----------------------------------------------------------------------------------
 ;                                System Error Handler
 ; ----------------------------------------------------------------------------------
SYSERR ; -- send system error message
 ; -- If we get an error in the error handler just Halt
 S $ET="D APPERROR^%ZTER(""VistALink Error 181001"") HALT" ;*4
 D ERROR(181001,$$EZBLD^DIALOG(181001,$$EC^%ZOSV),XOBPORT)      ; -- Get the error code
 Q
 ;
ERROR(XOBEC,XOBMSG,XOBPORT) ; -- send error message
 N XOBDAT
 ;
 ; -- If we get an error in the error handler just Halt
 ;
 ; * * *
 ;S $ET="D APPERROR^%ZTER(""VistALink Error_$G(XOBDAT(""ERRORS"_",1,"_"""CODE"""_"),180000)"_") HALT" ;*4
 S $ET="D APPERROR^%ZTER(""VistALink Error ""_$G(XOBDAT(""ERRORS"""_",1,"_"""CODE"")"_",180000)) HALT" ;*6
 ; * * *
 ; -- set up error info
 S XOBDAT("MESSAGE TYPE")=3
 S XOBDAT("ERRORS",1,"CODE")=XOBEC
 S XOBDAT("ERRORS",1,"ERROR TYPE")="system"
 S XOBDAT("ERRORS",1,"FAULT STRING")="System Error"
 S XOBDAT("ERRORS",1,"CDATA")=1
 S XOBDAT("ERRORS",1,"MESSAGE",1)=XOBMSG
 ;
 ; -- if serious error, save error info, logout, and halt
 I (XOBMSG["<DSCON>")!(XOBMSG["<READ>")!(XOBMSG["<WRITE>")!(XOBMSG["<SYSTEM>")!(XOBMSG["READERR")!(XOBMSG["WRITERR")!(XOBMSG["SYSERR") D  H
 . D APPERROR^%ZTER($S(XOBMSG["<DSCON>":$P(XOBMSG,":",2),1:"VistALink Error "_XOBEC)) ;*4
 . I $G(DUZ) D CLEAN^XOBSCAV1
 .Q
 ;
 ; -- send error back to client
 U XOBPORT
 D ERROR^XOBVLIB(.XOBDAT)
 ;
 ; -- just quit if no slots are available or logins are disabled
 I (XOBEC=181003)!(XOBEC=181004) Q
 ;
 ; -- need to make sure any locks are released since code aborted ungracefully
 L
 ;
 ; -- Save off the error
 D APPERROR^%ZTER($P(XOBMSG,": ",2)) ;*4
 ;
 ; -- go back to listening
 S $ET="Q:($ESTACK&'$QUIT)  Q:$ESTACK -9 S $ECODE="""" DO KILL^XOBVLL G NXTCALLQ^XOBVLL",$EC=",U99,"
 Q
 ;
KILL ; -- new VistALink variables and then do big KILL
 N XOBPORT,XOBSTOP,XOBNULL,XOBOS,XOBSYS,XOBHDLR,XOBOK,XOBLASTR,XOBCMREF
 D KILL^XUSCLEAN
 Q
 ;
