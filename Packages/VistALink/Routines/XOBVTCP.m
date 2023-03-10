XOBVTCP ;; mjk/alb - VistALink TCP Utilities ; 07/27/2002  13:00
 ;;1.6;VistALink Security;**4**;May 08, 2009;Build 7
 ; ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
 ; -- called from protocol action at START^XOBUM1 
START(XOBPORT,XOBCFG) ;
 ; 
 ; -- set up environment
 N XOBOK
 S XOBOK=0
 S U="^" D HOME^%ZIS
 ;
 ; -- if no port, set to default
 I $G(XOBPORT)="" N XOBPORT S XOBPORT=8000
 ;
 I $$LOCK(XOBPORT) D
 . D UNLOCK(XOBPORT)
 . ; -- JOB command same for CacheNT and DSM
 . J LISTENER^XOBVTCPL(XOBPORT,$G(XOBCFG))::5
 . S XOBOK=$T
 E  D
 . S XOBOK=0
 Q XOBOK
 ;
UCX ; -- old VMS TCPIP (UCX) multi-thread entry point [for DSM]
 ; -- Called from VistALink .com files
 ;
 N XOBEC
 D ESET
 S (IO,IO(0))="SYS$NET"
 ; **VMS specific code, need to share device**
 O IO:(TCPDEV:BLOCKSIZE=512):60 E  S ^TMP("XOB DSM CONNECT FAILURE",$H)="" Q
 U IO
 S XOBEC=$$NEWOK^XOBVTCPL()
 I XOBEC D LOGINERR^XOBVTCPL(XOBEC,IO)
 I 'XOBEC D SPAWN^XOBVLL
 Q
 ;
CACHEVMS ; -- VMS TCPIP (UCX) multi-thread entry point for Cache for VMS
 ; -- Called from VistALink .com files
 ;
 N XOBEC
 D ESET
 S (IO,IO(0))="SYS$NET"
 ;
 O IO::5
 U IO:(::"-M") ;Packet mode like DSM
 ;
 S XOBEC=$$NEWOK^XOBVTCPL()
 I XOBEC D LOGINERR^XOBVTCPL(XOBEC,IO)
 I 'XOBEC D SPAWN^XOBVLL
 Q
 ;
CACHELNX ; -- multi-thread entry point for Cache for Linux
 ; -- Called from XINETD service files
 ;
 N XOBEC
 D ESET
 S (IO,IO(0))=$P
 ;
 O IO::5
 U IO:(::"-M") ;Packet mode like DSM
 ;
 S XOBEC=$$NEWOK^XOBVTCPL()
 I XOBEC D LOGINERR^XOBVTCPL(XOBEC,IO)
 I 'XOBEC D SPAWN^XOBVLL
 Q
 ;
GTMLNX ; -- Linux xinetd multi-thread entry point for GT.M
 ;
 N XOBEC,TMP,X,%
 D ESET
 ;
 ; **GTM/linux specific code**
 S (IO,IO(0))=$P,@("$ZT=""""")
 X "U IO:(nowrap:nodelimiter:IOERROR=""TRAP"")" ;Setup device
 S @("$ZINTERRUPT=""I $$JOBEXAM^ZU($ZPOSITION)"""),X=""
 X "ZSHOW ""D"":TMP"
 F %=1:1 Q:'$D(TMP("D",%))  S X=TMP("D",%) Q:X["LOCAL"
 S IO("IP")=$P($P(X,"REMOTE=",2),"@"),IO("PORT")=+$P($P(X,"LOCAL=",2),"@",2)
 ;End GT.M code
 ;
 S XOBEC=$$NEWOK^XOBVTCPL()
 I XOBEC D LOGINERR^XOBVTCPL(XOBEC,IO)
 I 'XOBEC D COUNT^XUSCNT(1),SPAWN^XOBVLL,COUNT^XUSCNT(-1)
 Q
 ;
 ;Sample linux scripts
 ;xinetd script
 ;vvvvvvvvvvvvvvvvvvvvvvvvv
 ;service vistalink
 ;{
 ;   socket_type     = stream
 ;   port            = 18001
 ;   type            = UNLISTED
 ;   user            = vista
 ;   wait            = no
 ;   disable         = no
 ;   server          = /bin/bash
 ;   server_args     = /home/vista/dev/vistalink.sh
 ;   passenv         = REMOTE_HOST
 ;}
 ;^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 ;
 ;cat /home/vista/dev/vistalink.sh
 ;vvvvvvvvvvvvvvvvvvvvvvvvvvvv
 ;#!/bin/bash
 ;#RPC Broker
 ;cd /home/vista/dev
 ;. ./gtmprofile
 ;$gtm_dist/mumps -r GTMLNX^XOBVTCP
 ;exit 0
 ;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 ;
SERVICE ; -- service entry point (for VMS TCP/IP & LINUX XINETD utilities)
 ; TODO: possible single entry point for os service calls; needs work and has not been tested
 N XOBEC,XOBMOS,XOBSOS
 D ESET
 S XOBMOS=$$OS^XOBVSKT()
 I XOBMOS'["OpenM" S $EC=",U98,"
 S XOBSOS=$$SYSOS^XOBVLIB(XOBMOS)
 I XOBMOS'["VMS"!(XOBMOS'["UNIX") S $EC=",U97,"
 ;
 S (IO,IO(0))=$S(XOBSOS="VMS":"SYS$NET","UNIX":$P)
 ;
 O IO::5
 U IO:(::"-M") ;Packet mode like DSM
 ;
 S XOBEC=$$NEWOK^XOBVTCPL()
 I XOBEC D LOGINERR^XOBVTCPL(XOBEC,IO)
 I 'XOBEC D SPAWN^XOBVLL
 Q
 ;
ESET ;Set initial error trap
 N $ET,$ES
 S U="^",$ET="D APPERROR^%ZTER(""VistALink Error - TCP Utilities"") H" ;Set up the error trap ;*4
 Q
 ;
STARTUP ; -- called by TaskMan startup option [Option: XOBV LISTENER STARTUP]
 ;           and could be called by VMS .com procedure
 ;
 ; -- quit if not Cache OS
 I $$GETOS()'["OpenM" G STARTUPQ
 ; -- clear log of non-active listeners
 D CLEARLOG
 ; -- get config for BOX-VOL and start it!
 D STARTCFG($$GETCFG())
STARTUPQ ;
 Q
 ;
CLEARLOG ; -- clear log of non-active listeners
 N DIK,DA,Y,XOBI,XOB0,XOBPORT
 ;
 S XOBI=0
 F  S XOBI=$O(^XOB(18.04,XOBI)) Q:'XOBI  D
 . S XOB0=$G(^XOB(18.04,XOBI,0))
 . S XOBPORT=+$P(XOB0,U,2)
 . ; -- make sure listener is not running
 . I $$LOCK(XOBPORT) D
 . . S DIK="^XOB(18.04,",DA=XOBI D ^DIK
 . . D UNLOCK(XOBPORT)
 ;
 Q
 ;
STARTCFG(XOBCFG) ; -- start a configurations listeners
 N CFG0,LSTR,LSTR0,XOBPORT,STARTUP,XOBOK
 S CFG0=$G(^XOB(18.03,XOBCFG,0))
 ;
 ; -- quit if no configuration
 I CFG0="" G CFGQ
 ;
 ; -- quit if not Cache...for now!
 I $$GETOS()'["OpenM" G CFGQ
 ;
 S LSTR=0
 F  S LSTR=$O(^XOB(18.03,XOBCFG,"PORTS",LSTR)) Q:'LSTR  D
 . S LSTR0=$G(^XOB(18.03,XOBCFG,"PORTS",LSTR,0))
 . S XOBPORT=+$P(LSTR0,U,1)
 . S STARTUP=$P(LSTR0,U,2)
 . ;
 . ; -- if ok to start, port # defined and not already started
 . I XOBPORT,STARTUP,$$LOCK^XOBVTCP(XOBPORT) D
 . . D UNLOCK(XOBPORT)
 . . D UPDATE^XOBVTCP(XOBPORT,1,XOBCFG)
 . . S XOBOK=$$START(XOBPORT,XOBCFG)
 . . I 'XOBOK D UPDATE(XOBPORT,5,XOBCFG)
 ;
CFGQ ;
 Q
 ;
LOCK(XOBPORT) ;-- Lock port
 ;
 ;  Used to prevent another process from attempting to start the Listener
 ;  when it is already running.
 ;
 ;    Input:
 ;      XOBPORT - Port #
 ;
 ;   Output:
 ;      Function Value - Returns 1 if lock was successful, 0 otherwise
 ;
 Q $$ACTION("LOCK",XOBPORT)
 ;
 ;
UNLOCK(XOBPORT) ;-- Unlock port
 ;
 ;  Used to release a lock created by $$LOCK.
 ;
 ;    Input:
 ;      XOBPORT - Port #
 ;
 ;   Output:
 ;      None
 ;
 N X
 S X=$$ACTION("UNLOCK",XOBPORT)
 Q
 ;
ACTION(ACTION,XOBPORT) ; -- do lock action
 N ENV,VOL,UCI,BOX
 ;
 S XOBPORT=+$G(XOBPORT)
 ;
 S ENV=$$GETENV()
 S VOL=$P(ENV,U,2)
 S UCI=$P(ENV,U)
 S BOX=$P(ENV,U,4)
 ;
 I ACTION="LOCK",XOBPORT L +^XOB(18.01,"VistALink Listener",VOL,UCI,BOX,XOBPORT):1 Q $T
 I ACTION="UNLOCK",XOBPORT L -^XOB(18.01,"VistALink Listener",VOL,UCI,BOX,XOBPORT) Q 1
 Q 0
 ;
 ;
UPDATE(XOBPORT,XOBSTAT,XOBCFG) ; -- update VISTALINK LISTENER STARTUP LOG for listener
 N DIC,Y,X,XOBBOX
 S XOBBOX=$$GETBOXN()
 ;
 ; -- set up lookup call
 S DIC="^XOB(18.04,"
 S DIC(0)="MLX"
 S DIC("DR")=".02////"_XOBPORT
 S DIC("S")="IF $P(^(0),U,2)="_XOBPORT
 S X=XOBBOX
 ;
 D ^DIC
 ; -- quit if lookup failed
 I +Y>0 D UPDLOG(+Y,XOBPORT,XOBSTAT,$G(XOBCFG))
 Q
 ;
UPDLOG(XOBDA,XOBPORT,XOBSTAT,XOBCFG) ; -- do edit
 N DA,DIE,DR,Y,X
 ;
 L +^XOB(18.04,XOBDA,0)
 ; -- set basic fields
 S DA=XOBDA
 S DIE="^XOB(18.04,"
 S DR=".02////"_XOBPORT_";.03////"_XOBSTAT_";.05////^S X=$$NOW^XLFDT"
 ; -- set config if defined, otherwise delete
 S DR=DR_";.06////"_$S($G(XOBCFG)]"":XOBCFG,1:"@")
 ; -- set user if defined, otherwise delete
 S DR=DR_";.04////"_$S($G(DUZ)]"":DUZ,1:"@")
 ;
 D ^DIE
 L -^XOB(18.04,XOBDA,0)
 ;
 Q
 ;
GETENV() ; -- get environment variable
 ;-- Get environment of current system i.e. Y=UCI^VOL/DIR^NODE^BOX LOOKUP
 N Y
 D GETENV^%ZOSV
 Q Y
 ;
GETOS() ;-- Get operating system
 ;
 ;  This function will determine which operating system is being used.
 ;
 ;   Input:
 ;     None
 ;
 ;  Output:
 ;     Operating system value i.e. OpenM-NT for OpenM.
 ;
 ;-- Get operating system
 Q $P($G(^%ZOSF("OS")),"^")
 ;
 ;
GETBOX() ; -- get box ien
 ;
 Q $$FIND1^DIC(14.7,"","BX",$P($$GETENV(),U,4),"","","")
 ;
GETBOXN() ; -- get box name
 ;
 Q $P($$GETENV(),U,4)
 ;
GETCFG() ; -- get config ien for current BOX-VOL pair
 Q +$P($G(^XOB(18.01,1,"CONFIG",+$O(^XOB(18.01,1,"CONFIG","B",+$$GETBOX(),"")),0)),U,2)
 ;
