XOBVTCPL ;; mjk/alb - VistALink TCP/IP Listener (Cache NT) ; 07/27/2002  13:00
 ;;1.6;VistALink Security;**4**;May 08, 2009;Build 7
 ; ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
 ; -- Important: Should always be JOBed using START^XOBVTCP
LISTENER(XOBPORT,XOBCFG) ; -- Start Listener
 ;
 ; -- quit if not Cache for NT
 I $$GETOS^XOBVTCP()'="OpenM-NT" Q
 ;
 N $ET,$ES S $ET="D APPERROR^%ZTER(""VistALink Error""_ECODE_ "") H" ;*4
 ;
 N X,POP,XOBDA,U,DTIME,DT,XOBIO
 S U="^",DTIME=900,DT=$$DT^XLFDT()
 I $G(DUZ)="" N DUZ S DUZ=.5,DUZ(0)="@"
 ;
 ; -- only start if not already started
 I $$LOCK^XOBVTCP(XOBPORT) D
 . I $$OPENM(.XOBIO,XOBPORT) D
 . . ; -- listener started and now stopping
 . . S IO=XOBIO
 . . D CLOSE^%ZISTCP
 . . ; -- update status to 'stopped'
 . . D UPDATE^XOBVTCP(XOBPORT,4,$G(XOBCFG))
 . E  D
 . . ; -- listener failed to start
 . . ; -- update status to 'failed'
 . . D UPDATE^XOBVTCP(XOBPORT,5,$G(XOBCFG))
 . ;
 . D UNLOCK^XOBVTCP(XOBPORT)
 Q
 ;
 ; -- open/start listener port
OPENM(XOBIO,XOBPORT) ;
 N XOBBOX,%ZA
 S XOBBOX=+$$GETBOX^XOBVTCP()
 S XOBIO="|TCP|"_XOBPORT
 O XOBIO:(:XOBPORT:"AT"):30
 ;
 ; -- if listener port could not be opened then gracefully quit
 ;    (other namespace using port maybe?)
 I '$T Q 0
 ;
 ; -- indicate listener is 'running'
 D UPDATE^XOBVTCP(XOBPORT,2,$G(XOBCFG))
 ; -- read & spawn loop
 F  D  Q:$$EXIT(XOBBOX,XOBPORT)
 . U XOBIO
 . R *X:60 I '$T Q
 . J CHILDNT^XOBVTCPL():(:4:XOBIO:XOBIO):10 S %ZA=$ZA
 . I %ZA\8196#2=1 W *-2 ;Job failed to clear bit
 Q 1
 ;
CHILDNT() ;Child process for OpenM
 N XOBEC,$ET,$ES
 S $ET="D APPERROR^%ZTER(""VistALink Error "") L  HALT" ;4
 S IO=$P ;Reset IO to be $P
 U IO:(::"-M") ;Packet mode like DSM
 ; -- do quit to save a stack level
 S XOBEC=$$NEWOK()
 I XOBEC D LOGINERR(XOBEC,IO)
 I 'XOBEC D VAR,SPAWN^XOBVLL
 Q
 ;
VAR ;Setup IO variables
 S IO(0)=IO,IO(1,IO)="",POP=0
 S IOT="TCP",IOF="#",IOST="P-TCP",IOST(0)=0
 Q
 ;
NEWOK() ;Is it OK to start a new process
 N XQVOL,XUCI,XUENV,XUVOL,X,Y,XOBCODE
 D XUVOL^XUS
 I $$INHIB1^XUSRB() Q 181004
 I $$INHIB2^XUSRB() Q 181003
 Q 0
 ;
 ; -- process error
LOGINERR(XOBEC,XOBPORT) ;
 D ERROR^XOBVLL(XOBEC,$$EZBLD^DIALOG(XOBEC),XOBPORT)
 ;
 ; -- give client time to process stream
 H 2
 Q
 ;
EXIT(XOBBOX,XOBPORT) ;
 ; -- is status 'stopping'
 Q ($P($G(^XOB(18.04,+$$GETLOGID(XOBBOX,XOBPORT),0)),U,3)=3)
 ;
GETLOGID(XOBBOX,XOBPORT) ;
 Q +$O(^XOB(18.04,"C",XOBBOX,XOBPORT,""))
 ;
