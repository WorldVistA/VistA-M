XWBTCPC ;ISC-SF/EG/VYD - TCP/IP PROCESS HANDLER ;08/25/2004  14:18
 ;;1.1;RPC BROKER;**2,5,4,6,9,16,26,35**;Mar 28, 1997
 ;Based on: XQORTCPH ;SLC/KCM - Service TCP Messages
 ;Modified by ISC-SF/EG
 ; 0. No longer supports old style OERR messages
 ; 1. Makes call to RPC  broker
 ; 2. Result of an rpc call can be a closed form of global
 ; 3. Can receive a large local array, within limits of job
 ;    partition size.
 ; 4. Sets default device to NULL device prior to call, restores
 ;    at termination.  Prevents garbage from 'talking' calls.
 ; 5. All reads have a timeout.
 ; 6. Intro message is sent when first connected.
 ; 7. Uses callback model to connect to client
 ;
 ;
EN(XWBTIP,XWBTSKT,DUZ,XWBVER,XWBCLMAN) ; -- Main entry point
 N TYPE,XWBTBUF,XWBTBUF1,XWBTDEV,XWBTLEN,XWBTOS,XWBTRTN,XWBWRAP
 N X,XWBL,XWB1,XWB2,Y,XWBTIME,XWBPTYPE,XWBPLEN,XWBNULL,XWBODEV,XWBRBUF
 N XWBERROR,XWBSEC ;new error variable available to rpc calls
 N IO,IOP,L,XWBAPVER,VL,XWBTHDR,XWBT
 ;
 ;Set up the error trap
 S U="^",$ETRAP="D ^%ZTER,XUTL^XUSCLEAN H" ;XWB-30
 S XWBOS=$$OS
 S XWBT("BF")=$S(XWBOS="GT.M":"#",1:"!")
 ;start RUM for Broker Handler XWB*1.1*5
 D LOGRSRC^%ZOSV("$BROKER HANDLER$",2,1)
 ;
 S XWBCLMAN=$G(XWBCLMAN)
 I '$D(XWBDEBUG) D  ;(*p35)
 . S XWBDEBUG=$$GET^XPAR("SYS","XWBDEBUG")
 . D LOGSTART^XWBDLOG("XWBTCPC")
 . Q
 I XWBDEBUG D LOG("Callback: "_XWBTIP_" :"_XWBTSKT) ;(*p35)
 D SETTIME(1) ;Setup for sign-on time-out
 ;Use Kernel to open the connection back to the client on new port
 D CALL^%ZISTCP(XWBTIP,XWBTSKT) Q:POP  S XWBTDEV=IO,IO(0)=IO
 ;Attempt to share the license, Must have TCP port open first.
 U XWBTDEV I $T(SHARELIC^%ZOSV)'="" D SHARELIC^%ZOSV(1)
 ;setup null device "NULL"
 S %ZIS="0H",IOP="NULL" D ^%ZIS S XWBNULL=IO I POP S XWBERROR="No NULL device" D ^%ZTER Q
 D SAVDEV^%ZISUTL("XWBNULL")
 I XWBOS="GTM" S @("$ZINTERRUPT=""I $$JOBEXAM^ZU($ZPOSITION)""")
 ;change process name
 S X="ip"_$P(XWBTIP,".",3,4)_":"_XWBTSKT
 D SETNM^%ZOSV($E(X,1,15)),LOG("ProcName: "_X)
RESTART ;(*p35)
 N $ESTACK S $ETRAP="D ETRAP^XWBTCPC"
 S U="^",DUZ=0,DUZ(0)="",DTIME=300
 U XWBTDEV D MAIN
 ;Turn off the error trap for the exit
 S $ETRAP=""
 I $G(DUZ) D LOGOUT^XUSRB
 K XWBR,XWBARY
 ;stop RUM for handler XWB*1.1*5
 D LOGRSRC^%ZOSV("$BROKER HANDLER$",2,2)
 D LOG("DUZ="_$G(DUZ)_"  LOGGED OFF")
 D USE^%ZISUTL("XWBNULL"),CLOSE^%ZISUTL("XWBNULL")
 C XWBTDEV ;Close can get an error
 Q
 ;
MAIN ; -- main message processing loop
 N XCNT,XR
 F  D  Q:XWBTBUF="#BYE#"
 . S XWBAPVER=0,(XWBSEC,XWBERROR,XWBRBUF)=""
 . U XWBTDEV ;Make sure we are reading from the right device
 . ; -- read client request
 . ;F XCNT=0:0 R XR#1:XWBTIME Q:(XR="{")!(XR="#")  I '$T S XCNT=XCNT+1 Q:XCNT>5
 . S XR=$$BREAD^XWBRW(1,XWBTIME,1)
 . I '$L(XR) D LOG("Timeout"),TIMEOUT S XWBTBUF="#BYE#" Q
 . S XWBTHDR=XR_$$BREAD^XWBRW(4) ;(*p35)
 . I XWBTHDR["#BYE#" S XWBTBUF="#BYE#" Q  ;Clear $C(4)
 . S XWBTHDR=XWBTHDR_$$BREAD^XWBRW(6)
 . I $G(XWBDEBUG)>1 D LOG("HDR Read:"_XWBTHDR_":")
 . S TYPE=($E(XWBTHDR,1,5)="{XWB}")  ;check HDR
 . I 'TYPE D  Q
 . . D LOG("Bad Header: "_XWBTHDR) ;(*p35)
 . . S XWBTBUF="#BYE#" D QSND^XWBRW(XWBTBUF) ;(*p35)
 . . Q
 . S XWBTLEN=$E(XWBTHDR,6,10),L=$E(XWBTHDR,11)
 . I L="|" D  ;(*p35)  Save $T
 . . S VL=$$BREAD^XWBRW(1),VL=$A(VL)
 . . S XWBAPVER=$$BREAD^XWBRW(VL),XWBPLEN=$$BREAD^XWBRW(5) ;(*p35)
 . E  S XWBTBUF=$$BREAD^XWBRW(4),XWBPLEN=L_XWBTBUF ;(*p35)
 . S XWBTBUF=$$BREAD^XWBRW(XWBPLEN) ;(*p35)
 . I $P(XWBTBUF,U)="TCPconnect" D  Q
 . . D QSND^XWBRW("accept") ;Ack (*p35)
 . IF TYPE D
 . . K XWBR,XWBARY
 . . IF XWBTBUF="#BYE#" D QSND^XWBRW("#BYE#") Q  ; -- clean disconnect
 . . S XWBTLEN=XWBTLEN-15
 . . D CALLP^XWBBRK(.XWBR,XWBTBUF)
 . . S XWBPTYPE=$S('$D(XWBPTYPE):1,XWBPTYPE<1:1,XWBPTYPE>6:1,1:XWBPTYPE)
 . IF XWBTBUF="#BYE#" D LOG("APP set #BYE#") Q  ;(*p35)
 . U XWBTDEV
 . D SND^XWBRW ;Does SNDERR,SND,WRITE($C(4))
 . I $G(XWBSHARE) D KILL1^XUSCLEAN ; CLEAN OUT PARTITION FOR SHARED BROKER
 Q  ;End Of Main
 ;
ETRAP ; -- on trapped error, send error info to client
 N XWBERC,XWBERR
 ;Change trapping during trap.
 S $ETRAP="D ^%ZTER,BYE^XUSCLEAN,XUTL^XUSCLEAN HALT" ;XWB-30
 S XWBERC=$E($$EC^%ZOSV,1,200),XWBERR="M  ERROR="_XWBERC_$C(13,10)_"LAST REF="_$$LGR^%ZOSV
 S XWBOS=$$OS
 ;Check for short read, Tell Client to resend.
 I $EC["U411" S XWBERROR="U411",XWBSEC="",XWBERR="Data Transfer Error to Server"
 D ^%ZTER ;%ZTER clears $ZE and $ECODE
 I $G(XWBDEBUG) D LOG("In ETRAP: "_XWBERC) ;(*p35)
 I ($G(XWBERC)["READ")!($G(XWBERC)["WRITE")!($G(XWBERC)["SYSTEM-F")!('$D(XWBERC)) D:$G(DUZ) LOGOUT^XUSRB HALT  ; XWB-30
 U XWBTDEV
 L  ;Clear locks (*p35)
ETX ;Exit for trap
 D ESND^XWBRW($C(24)_XWBERR_$C(4)) ;(p*35)
 S $ETRAP="Q:($ESTACK&'$QUIT)  Q:$ESTACK -9 S $ECODE="""" G RESTART^XWBTCPC",$ECODE=",U99,"
 Q
 ;
STYPE(X,WRAP) ;For backward compatability only
 I $D(WRAP) Q $$RTRNFMT^XWBLIB($G(X),WRAP)
 Q $$RTRNFMT^XWBLIB(X)
 ;
SETTIME(%) ;Set the Read timeout 0=RPC, 1=sign-on
 ; Increased timeout period (%=1) during signon from 90 to 180 for accessibility reasons
 S XWBTIME=$S($G(%):180,$G(XWBVER)>1.105:$$BAT^XUPARAM,1:36000),XWBTIME(1)=5 ; (*p35)
 I $G(%) S XWBTIME=$S($G(XWBVER)>1.1:90,1:36000)
 Q
TIMEOUT ;Do this on MAIN  loop timeout
 I $G(DUZ)>0 D QSND^XWBRW("#BYE#"_$C(4)) Q
 ;Sign-on timeout
 S XWBR(0)=0,XWBR(1)=1,XWBR(2)="",XWBR(3)="TIME-OUT",XWBPTYPE=2
 D SND^XWBRW
 Q
 ;
MSM ;entry point for MSERVER service - used by MSM
 N XWBVER,LEN,MSG,X
 S XWBVER=0
 R LEN#11:3600 IF $E(LEN,1,5)'="{XWB}" D  Q  ;bad client, abort
 . W "RPC broker disconnect!",!
 . C 56
 . Q
 IF $E(LEN,11,11)="|" D
 . R X#1:60
 . R XWBVER#$A(X):60
 . R LEN#5:60
 . R MSG#LEN:60
 . Q
 ELSE  S X=$E(LEN,11,11),LEN=$E(LEN,6,10)-1 R MSG#LEN:60 S MSG=X_MSG
 IF $P(MSG,"^")="TCPconnect" D
 . D QSND^XWBRW("accept")
 . C 56
 . D EN($P(MSG,"^",2),$P(MSG,"^",3),$P(X,"^"),XWBVER,$P(MSG,"^",4))
 IF $P(MSG,"^")="TCPdebug" D
 . D QSND^XWBRW("accept")
 C 56
 Q
OS() ;Return the OS
 N % S %=^%ZOSF("OS") ;(*p35)
 Q $S(%["DSM":"DSM",%["OpenM":"OpenM",%["GT.M":"GTM",1:"MSM") ;(*p35)
 ;
LOG(TX) ;DeBug Logging (*p35)
 D:$G(XWBDEBUG) LOG^XWBDLOG(TX)
 Q
