XOBSCAV1 ;; kec/oak - VistaLink Access/Verify Security ; 12/09/2002  17:00
 ;;1.6;VistALink Security;;May 08, 2009;Build 15
 ;Per VHA directive 2004-038, this routine should not be modified.
 QUIT
 ; 
 ; Access/Verify Security: Security Message Request Handler
 ; specific message request/response pairs)  
 ; 
 ; ** Setting/Killing of DUZ covered by blanket SAC Kernel exemption for Foundations
 ; 
 ; ::AV.SetupAndIntroText.Request message processing
SENDITXT ; Do Setup and send Intro Text
 NEW XOBSTINF,XOBMSG,XOBTMP,XOBTMP1,XOBCCMSK,XOBI,XOBPROD
 ;
 ; define XWBTIP early so present in any error logs
 ; NOTE: $$GETPEER^%ZOSV fails for TCP_SERVICES listeners if COM file doesn't set up VISTA$IP logical
 ; 
 SET XWBTIP=$$GETPEER^%ZOSV ; XWBTIP needed by SETUP^XUSRB. Use of GETPEER^%ZOSV: DBIA #4056
 ; set ip from msg if not provided by OS
 SET:'$LENGTH(XWBTIP) XWBTIP=XOBDATA("CLIENTIP")
 ;
 IF $$PRODMISM() DO  QUIT
 . NEW XOBSPAR SET XOBSPAR(1)=$GET(XOBDATA("CLIENTISPRODUCTION")),XOBSPAR(2)=$SELECT($$PROD^XUPROD(0):"true",1:"false")
 . DO ERROR^XOBSCAV(.XOBR,$PIECE($TEXT(FSERVER^XOBSCAV),";;",2),"Production-Test Mismatch",183007,$$CHARCHK^XOBVLIB($$EZBLD^DIALOG(183007,.XOBSPAR)))
 ;
 IF $$STATMISM() DO  QUIT
 . NEW XOBSPAR SET XOBSPAR(1)=$GET(XOBDATA("CLIENTPRIMARYSTATION")),XOBSPAR(2)=XOBSYS("PRIMARY STATION#")
 . DO ERROR^XOBSCAV(.XOBR,$PIECE($TEXT(FSERVER^XOBSCAV),";;",2),"Primary Station Mismatch",183010,$$CHARCHK^XOBVLIB($$EZBLD^DIALOG(183010,.XOBSPAR)))
 ;
 ; seq: SETUP^XUSRB, then INTRO^XUSRB
 ; 
 USE XOBNULL ; protect against direct writes to socket
 ; note: SETUP^XUSRB sets current IO to null device
 ; 
 IF XOBSYS("ENV")="j2ee" DO
 . DO SETUP^XUSRB(.XOBSTINF,"") ; use of SETUP^XUSRB: DBIA #4054
 ELSE  DO  QUIT:$GET(DUZ)>0
 . SET XWBVER=1.1 ; to allow VistaLink to contact client agent
 . DO SETUP^XUSRB(.XOBSTINF,"") ; use of SETUP^XUSRB: DBIA #4054
 . ; start of auto-signon support
 . SET DUZ=$$AUTOXWB^XUS1B() IF DUZ<1 KILL DUZ ; use of $$AUTOXWB^XUS1B: DBIA #4060
 . IF $GET(DUZ)>0 DO NOW^XUSRB SET XUMSG=$$POST^XUSRB(0) IF XUMSG>0 KILL DUZ ; XUSRB calls: DBIA #4061
 . ; do autosignon and quit if DUZ is set
 . IF $GET(DUZ)>0 DO  QUIT
 . .USE XOBPORT ; restore current IO (the TCP port)
 . .SET XOBRET(5)=0 DO LOGFIN
 . .QUIT
 . KILL XWBVER ; once auto-signon fails, don't need to contact client agent
 . ; end of autosignon support
 ;
 ;if failed autosignon, continue w/intro text
 ; ** use of USE command covered by blanket SAC Kernel exemption for Foundations
 USE XOBPORT ; restore current IO (the TCP port)
 ;
 SET XOBMSG(1)="<SetupInfo serverName='"_$$CHARCHK^XOBVLIB(XOBSTINF(0))_"' volume='"
 ; note: next line, "dtime" attribute value is not DTIME, but is the VistaLink heartbeat rate.
 ;       this is used by the J2SE client code to time out the client dialogs.
 ;       Value may be replaced w/a signon-specific site parameter later.
 SET XOBMSG(1)=XOBMSG(1)_$$CHARCHK^XOBVLIB(XOBSTINF(1))_"' uci='"_$$CHARCHK^XOBVLIB(XOBSTINF(2))_"' device='"_$$CHARCHK^XOBVLIB(XOBSTINF(3))_"' numberAttempts='"_$$CHARCHK^XOBVLIB(XOBSTINF(4))_"' dtime='"_$$GETRATE^XOBVLIB()_"'/>"
 ; add intro text
 DO GETINTRO^XOBSCAV2("XOBMSG",2)
 ;
 DO SENDSEC^XOBSCAV(.XOBR,$PIECE($TEXT(RESTYPE^XOBSCAV),";;",2),$PIECE($TEXT(MSGSETUP^XOBSCAV),";;",2),.XOBMSG,$$SUCCESS^XOBSCAV(),$PIECE($TEXT(SCHSETUP^XOBSCAV),";;",2))
 QUIT
 ; ::AV.Logon.Request message processing
LOGON ; process login request
 NEW XOBAC,XOBVC,XOBRET,XOBRETDV
 ;
 IF $$LOGGEDON^XOBSCAV DO  QUIT
 .DO ERROR^XOBSCAV(.XOBR,$PIECE($TEXT(FSERVER^XOBSCAV),";;",2),"Server Partition State",183003,$$CHARCHK^XOBVLIB($$EZBLD^DIALOG(183003)))
 ;
 KILL DUZ ; if DUZ is around, it shouldn't be.
 USE XOBNULL ; protect against direct writes to socket
 ; try to logon w/avcodes
 DO VALIDAV^XUSRB(.XOBRET,XOBDATA("XOB SECAV","AVCODE")) ; use of VALIDAV^XUSRB: DBIA#4054
 KILL XOBDATA("XOB SECAV","AVCODE")
 USE XOBPORT ; restore current IO (the TCP port)
 ;
 ; if bad a/v code credentials
 IF '+XOBRET(0),'+XOBRET(1),'+XOBRET(2) DO  QUIT
 . ; look for particular error string which means IP is locked
 . IF $GET(XOBRET(3))["Device/IP address is locked due" DO ERROR^XOBSCAV(.XOBR,$PIECE($TEXT(FSERVER^XOBSCAV),";;",2),"Logon Failed",182306,$$CHARCHK^XOBVLIB($$EZBLD^DIALOG(182306,$GET(XOBRET(3))))) QUIT
 . IF XOBSYS("ENV")="j2ee" DO ERROR^XOBSCAV(.XOBR,$PIECE($TEXT(FSERVER^XOBSCAV),";;",2),"Connector Proxy User Error",183008,$$CHARCHK^XOBVLIB($$EZBLD^DIALOG(183008,$GET(XOBRET(3))))) QUIT
 . ELSE  DO LOGBADCD
 ;
 ; if Kernel says user needs to change verify code
 IF '+XOBRET(0),'+XOBRET(1),XOBRET(2) DO LOGCVC QUIT
 ;
 IF '+XOBRET(0) DO  QUIT  ; there was an error
 .NEW XOBSPAR
 .SET XOBSPAR(1)=$GET(XOBRET(3))
 .; look for particular error string which means too many invalid signon attempts
 .IF XOBSPAR(1)["too many invalid sign" DO ERROR^XOBSCAV(.XOBR,$PIECE($TEXT(FSERVER^XOBSCAV),";;",2),"Logon Failed",183005,$$CHARCHK^XOBVLIB($$EZBLD^DIALOG(183005,.XOBSPAR))) QUIT
 .DO ERROR^XOBSCAV(.XOBR,$PIECE($TEXT(FSERVER^XOBSCAV),";;",2),"Logon Failed",183004,$$CHARCHK^XOBVLIB($$EZBLD^DIALOG(183004,.XOBSPAR)))
 ;
 ; if user requested to change verify code
 IF XOBDATA("XOB SECAV","REQUESTCVC")="true" DO LOGCVC QUIT
 ;
 ; if j2ee, test for connector proxy user
 IF XOBSYS("ENV")="j2ee" QUIT:'$$ISCPROXY()
 ;
 ; at this point login was successful
 DO LOGFIN
 QUIT
LOGFIN ; check the divisions, finish login now
 NEW XOBRETDV DO DIVGET^XUSRB2(.XOBRETDV,DUZ) ; use of DIVGET^XUSRB2: DBIA #4055
 IF '+XOBRETDV(0) DO  QUIT
 . DO LOGOK
 . DO DUZSV^XOBVSYSI(.DUZ)
 ; otherwise this is a multidivisional user
 DO LOGSELDV(.XOBRETDV)
 QUIT
LOGBADCD ; response if bad a/v code pair
 NEW XOBMSG
 SET XOBMSG(1)="<"_$PIECE($TEXT(MSGTAG^XOBSCAV),";;",2)_">"_$$CHARCHK^XOBVLIB(XOBRET(3))_"</"_$PIECE($TEXT(MSGTAG^XOBSCAV),";;",2)_">"
 DO SENDSEC^XOBSCAV(.XOBR,$PIECE($TEXT(RESTYPE^XOBSCAV),";;",2),$PIECE($TEXT(MSGLGON^XOBSCAV),";;",2),.XOBMSG,$$FAILURE^XOBSCAV(),$PIECE($TEXT(SCHSIMPL^XOBSCAV),";;",2))
 QUIT
LOGCVC ; response if need to change vc
 NEW XOBMSG,XOBLINE
 SET XOBLINE=$$POSTTXT^XOBSCAV(.XOBRET,.XOBMSG)
 SET XOBMSG(XOBLINE+1)="<"_$PIECE($TEXT(PARTTAG^XOBSCAV),";;",2)_" changeVerify=""true"" cvcHelpText="""_$$CHARCHK^XOBVLIB($$AVHLPTXT^XUS2())_""" />" ; use of AVHLPTXT^XUS2: DBIA #4057
 SET XOBMSG(XOBLINE+2)="<"_$PIECE($TEXT(MSGTAG^XOBSCAV),";;",2)_">"_$$CHARCHK^XOBVLIB(XOBRET(3))_"</"_$PIECE($TEXT(MSGTAG^XOBSCAV),";;",2)_">"
 DO SENDSEC^XOBSCAV(.XOBR,$PIECE($TEXT(RESTYPE^XOBSCAV),";;",2),$PIECE($TEXT(MSGLGON^XOBSCAV),";;",2),.XOBMSG,$$PARTIAL^XOBSCAV(),$PIECE($TEXT(SCHPARTS^XOBSCAV),";;",2))
 QUIT
LOGSELDV(XOBDIVS) ; response if need to select division
 ;XOBDIVS is in format of output from DIVGET^XUSRB2
 NEW XOBMSG,XOBLINE
 SET XOBLINE=$$POSTTXT^XOBSCAV(.XOBRET,.XOBMSG)
 SET XOBLINE=$$ADDDIVS^XOBSCAV(.XOBDIVS,.XOBMSG)
 DO SENDSEC^XOBSCAV(.XOBR,$PIECE($TEXT(RESTYPE^XOBSCAV),";;",2),$PIECE($TEXT(MSGLGON^XOBSCAV),";;",2),.XOBMSG,$$PARTIAL^XOBSCAV(),$PIECE($TEXT(SCHPARTS^XOBSCAV),";;",2))
 QUIT
LOGOK ; response if everything's looking good
 NEW XOBMSG,XOBLINE
 SET XOBLINE=$$POSTTXT^XOBSCAV(.XOBRET,.XOBMSG)
 DO SENDSEC^XOBSCAV(.XOBR,$PIECE($TEXT(RESTYPE^XOBSCAV),";;",2),$PIECE($TEXT(MSGLGON^XOBSCAV),";;",2),.XOBMSG,$$SUCCESS^XOBSCAV(),$PIECE($TEXT(SCHLGON^XOBSCAV),";;",2))
 QUIT
 ; ::AV.Logout.Request message processing
LOGOUT ; logout
 USE XOBNULL ; protect against direct writes to socket
 ; do the logout
 DO CLEAN
 USE XOBPORT ; restore current IO (the TCP port)
 NEW XOBMSG
 DO SENDSEC^XOBSCAV(.XOBR,$PIECE($TEXT(RESTYPE^XOBSCAV),";;",2),$PIECE($TEXT(MSGLGOUT^XOBSCAV),";;",2),.XOBMSG,$$SUCCESS^XOBSCAV(),$PIECE($TEXT(SCHSIMPL^XOBSCAV),";;",2))
 QUIT
 ; ::Logout to call if connection has timed out
CLEAN ; logout
 DO LOGOUT^XUSRB ; use of LOGOUT^XUSRB: DBIA #4054
 QUIT
 ; ::AV.SelectDivision.Request message processing
DIVSLCT ; select division
 NEW XOBRET
 ;
 IF '+DUZ DO DIVSLCT0("User did not complete the access/verify code login process.") QUIT  ; need DUZ
 DO DIVSET^XUSRB2(.XOBRET,"`"_XOBDATA("XOB SECAV","SELECTEDDIVISION")) ; use of DIVSET^XUSRB2: DBIA #4055
 IF +XOBRET DO  QUIT
 . DO DIVSLCT1
 . DO DUZSV^XOBVSYSI(.DUZ)
 DO DIVSLCT0("division not found for this user.")
 QUIT
 ;
DIVSLCT0(XOBTEXT) ; send 
 NEW XOBMSG
 SET XOBMSG(1)="<"_$PIECE($TEXT(MSGTAG^XOBSCAV),";;",2)_">"_$$CHARCHK^XOBVLIB(XOBTEXT)_"</"_$PIECE($TEXT(MSGTAG^XOBSCAV),";;",2)_">"
 DO SENDSEC^XOBSCAV(.XOBR,$PIECE($TEXT(RESTYPE^XOBSCAV),";;",2),$PIECE($TEXT(MSGSELDV^XOBSCAV),";;",2),.XOBMSG,$$FAILURE^XOBSCAV(),$PIECE($TEXT(SCHSIMPL^XOBSCAV),";;",2))
 QUIT
 ;
DIVSLCT1 ; success
 NEW XOBMSG
 DO SENDSEC^XOBSCAV(.XOBR,$PIECE($TEXT(RESTYPE^XOBSCAV),";;",2),$PIECE($TEXT(MSGSELDV^XOBSCAV),";;",2),.XOBMSG,$$SUCCESS^XOBSCAV(),$PIECE($TEXT(SCHSIMPL^XOBSCAV),";;",2))
 QUIT
 ;
PRODMISM() ; returns 1 if production mismatch, 0 if not
 IF XOBSYS("ENV")'="j2ee" QUIT 0 ; skip in c/s mode
 SET XOBPROD=$SELECT($GET(XOBDATA("CLIENTISPRODUCTION"))="true":1,1:0)
 IF '(XOBPROD=$$PROD^XUPROD(0)) QUIT 1
 QUIT 0
 ;
STATMISM() ; return 1 if primary station mismatch, 0 if not
 IF XOBSYS("ENV")'="j2ee" QUIT 0 ; no checking for c/s mode
 NEW XOBSTAT
 ; strip off suffix
 SET XOBSTAT=$$STRPSUFF($GET(XOBDATA("CLIENTPRIMARYSTATION")))
 ; compare w/KSP value
 IF XOBSTAT'=XOBSYS("PRIMARY STATION#") QUIT 1 ;mismatch found
 QUIT 0
 ;
STRPSUFF(XOBSTAT) ; strip alpha suffix from sta# e.g. AAC "200M"
 SET XOBSTAT=$$TRUNCCH^XOBVSYSI(XOBSTAT)
 ; nursing home, treat 9 as suffix
 IF $LENGTH(XOBSTAT)=4,$E(XOBSTAT,4)=9 SET XOBSTAT=$E(XOBSTAT,1,3)
 QUIT XOBSTAT
 ;
ISCPROXY() ; c/proxy check
 ; returns 1 if c/proxy user, 0 if not
 NEW XOBCPCHK,XOBOK
 SET XOBOK=1
 SET XOBCPCHK=$$CPCHK^XUSAP(+XOBRET(0))
 IF 'XOBCPCHK DO  SET XOBOK=0
 . DO ERROR^XOBSCAV(.XOBR,$PIECE($TEXT(FSERVER^XOBSCAV),";;",2),"Connector Proxy User Error",183008,$$CHARCHK^XOBVLIB($$EZBLD^DIALOG(183008,$PIECE($GET(XOBCPCHK),U,2))))
 QUIT XOBOK
 ;
