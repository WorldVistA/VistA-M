XWBM2MC ;OIFO-Oakland/REM - M2M Broker Client APIs  ;05/21/2002  17:55
 ;;1.1;RPC BROKER;**28,34**;Mar 28, 1997
 ;
 QUIT
 ;
 ;p34 -make sure RES is defined - CALLRPC.
 ;    -error exception if RPCNAM not defined - CALLRPC.
 ;    -kill XWBY before going to PARSE^XWBRPC - CALLRPC.
 ;    -return 0 when error occurs and XWBY=error msg - CALLRPC.
 ;    -new module to GET the division for a user - GETDIV.
 ;    -new module to SET the division for a user - SETDIV.
 ;    -kills entry for current context in ^TMP("XWBM2M",$J) - CLEAN.
 ;    -comment out line. Will do PRE in REQUEST^XWBRPCC - PARAM.
 ;    -send PORT;IP to ERROR so it's included in error msg - ERROR.
 ;    -add 2 more error msg for GETDIV and SETDIV - ERRMGS.
 ;
CONNECT(PORT,IP,AV) ;Establishes the connection to the server.
 ;CONNECT returns 1=successful, 0=failed
 ;PORT - PORT number where listener is running.
 ;IP - IP address where the listener is running.
 ;AV - Access and verify codes to sign on into VistA.
 ;DIV - User division.
 ;
 ;K XWBPARMS
 N XWBSTAT,XWBPARMS
 S XWBPARMS("ADDRESS")=IP,XWBPARMS("PORT")=PORT
 S XWBPARMS("RETRIES")=3 ;Retries 3 times to open
 ;
 ;p34-send PORT;IP to ERROR so it's included in error msg.
 I '$$OPEN^XWBRL(.XWBPARMS) D ERROR(1,PORT_";"_IP) Q 0
 D SAVDEV^%ZISUTL("XWBM2M PORT")
 ;
 ;XUS SIGNON SETUP RPC
 I '$$SIGNON() D ERROR(2) S X=$$CLOSE() Q 0
 ; Results from XUS Signon 
 ; 1=server name, 2=volume, 3=uci, 4=device, 5=# attempts
 ; 6=skip signon-screen
 ;M ^TMP("XWBM2M",$J,"XUS SIGNON")=^TMP("XWBM2MRPC",$J,"RESULTS") ;Remove after testing **REM
 ;
 ;Validate AV codes
 ;S AV=$$CHARCHK^XWBUTL(AV) ;Convert and special char
 I '$$VALIDAV(AV) D ERROR(3) S X=$$CLOSE() Q 0
 ;
 I $G(^TMP("XWBM2MRPC",$J,"RESULTS",1))'>0 D ERROR(4) S X=$$CLOSE() Q 0
 ;M ^TMP("XWBM2M",$J,"XUS AV CODE")=^TMP("XWBM2MRPC",$J,"RESULTS") ;Remove after testing **REM
 ;
 D USE^%ZISUTL("XWBM2M CLIENT") U IO
 S ^TMP("XWBM2M",$J,"CONNECTED")=1
 Q 1
 ;
ISCONT() ;Function to check connection status. 1=connect, 0=not connect
 Q $G(^TMP("XWBM2M",$J,"CONNECTED"),0)
 ;
SETCONTX(CONTXNA) ;Set context and returns 1=successful or 0=failed  
 N REQ,XWBPARMS,X
 S ^TMP("XWBM2M",$J,"CONTEXT")=""
 K ^TMP("XWBM2M",$J,"ERROR","SETCONTX")
 ;;D PRE,SETPARAM(1,"STRING",$$CHARCHK^XWBUTL($$ENCRYP^XUSRB1(CONTXNA)))
 D PRE,SETPARAM(1,"STRING",$$ENCRYP^XUSRB1(CONTXNA))
 S X=$$CALLRPC("XWB CREATE CONTEXT","REQ",1)
 S REQ=$G(REQ(1))
 I REQ'=1 S ^TMP("XWBM2ME",$J,"ERROR","SETCONTX")=REQ Q 0
 S ^TMP("XWBM2M",$J,"CONTEXT")=CONTXNA
 Q 1
 ;
GETCONTX(CONTEXT) ;Returns current context
 S CONTEXT=$G(^TMP("XWBM2M",$J,"CONTEXT"))
 I CONTEXT="" Q 0
 Q 1
 ;
SETPARAM(INDEX,TYPE,VALUE) ;Set a Params entry
 S XWBPARMS("PARAMS",INDEX,"TYPE")=TYPE
 S XWBPARMS("PARAMS",INDEX,"VALUE")=VALUE
 Q
 ;
PARAM(PARAMNUM,ROOT) ;Build the PARAM data structure
 ;p34-comment out line. Will do PRE in REQUEST^XWBRPCC
 ;
 I PARAMNUM=""!(ROOT="") Q 0
 ;D PRE ;*p34
 M XWBPARMS("PARAMS",PARAMNUM)=@ROOT
 Q 1
 ;
CALLRPC(RPCNAM,RES,CLRPARMS) ;Call to RPC and wraps RPC in XML
 ;RPCNAM -RPC name to run
 ;RES -location where to place results.  If no RES, then results will be
 ; placed in ^TMP("XWBM2M",$J,"RESULTS")
 ;CLRPARMS - 1=clear PARAMS, 0=do not clear PARAMS.  Default is 1.
 ;
 N ER,ERX,GL
 I '$D(RES) S RES="" ;*p34-make sure RES is defined.
 I '$D(RPCNAM) D  Q 0  ;*p34-error if RPCNAM not defined.
 .I $G(RES)'="" S @RES="Pass in NULL for RPCNAM."
 .I $G(RES)="" S ^TMP("XWBM2MRPC",$J,"RESULTS",1)="Pass in NULL for RPCNAM."
 K ^TMP("XWBM2MRPC",$J,"RESULTS") ;Clear before run new RPC
 K ^TMP("XWBM2ME",$J,"ERROR","CALLRPC")
 I '$$ISCONT() D ERROR(5) Q 0  ;Not connected so do not run RPC
 D SAVDEV^%ZISUTL("XWBM2M CLIENT")
 D USE^%ZISUTL("XWBM2M PORT") U IO
 S XWBPARMS("URI")=RPCNAM
 S XWBCRLFL=0
 D REQUEST^XWBRPCC(.XWBPARMS)
 I XWBCRLFL D  Q 0
 . I $G(CLRPARMS)'=0 K XWBPARMS("PARAMS")
 . K RES
 . D USE^%ZISUTL("XWBM2M CLIENT") U IO
 ;
 ;Check if needed!!  **REM
 ;;IF $G(XWBPARMS("RESULTS"))="" SET XWBPARMS("RESULTS")=$NA(^TMP("XWBRPC"))
 ;
 I '$$EXECUTE^XWBVLC(.XWBPARMS) D  Q 0  ;Run RPC and place raw XML results
 .D ERROR(6)
 .D USE^%ZISUTL("XWBM2M CLIENT") U IO
 ;
 S XWBY="" I RES'="" S XWBY=RES K @($G(XWBY)) ;*p34-kill XWBY before PARSE
 D PARSE^XWBRPC(.XWBPARMS,XWBY)
 ;
 ;*p34-return 0 when error occurs and XWBY=error msg.
 I ($G(RES))'="",($G(@XWBY))="",($G(@(XWBY_"("_1_")")))="" D  Q ERX
 .S ER=$G(^TMP("XWBM2MVLC",$J,"XML",2))
 .S ERX=$S(ER["ERROR":0,ER["ERRORS":0,ER["error":0,ER["errors":0,1:1)
 .I 'ERX S @XWBY=ER
 .D USE^%ZISUTL("XWBM2M CLIENT") U IO
 ;When RES in not defined.
 I ($G(RES))="",($G(^TMP("XWBM2MRPC",$J,"RESULTS")))="",($G(^TMP("XWBM2MRPC",$J,"RESULTS",1)))="" D  Q ERX
 .S ER=$G(^TMP("XWBM2MVLC",$J,"XML",2))
 .S ERX=$S(ER["ERROR":0,ER["ERRORS":0,ER["error":0,ER["errors":0,1:1)
 .I 'ERX S ^TMP("XWBM2MRPC",$J,"RESULTS",1)=ER
 .D USE^%ZISUTL("XWBM2M CLIENT") U IO
 ;
 I $G(CLRPARMS)'=0 K XWBPARMS("PARAMS") ;Default is to clear
 D USE^%ZISUTL("XWBM2M CLIENT") U IO
 Q 1
 ;
CLOSE() ;Close connection
 I '$$ISCONT() D ERROR(5) Q 0  ;Not connected
 D SAVDEV^%ZISUTL("XWBM2M CLIENT")
 D USE^%ZISUTL("XWBM2M PORT") U IO
 D CLOSE^XWBRL
 D RMDEV^%ZISUTL("XWBM2M PORT")
 D CLEAN
 S ^TMP("XWBM2M",$J,"CONNECTED")=0
 Q 1
 ;
CLEAN ;Clean up
 ;*p34-kills entry for current context in ^TMP("XWBM2M",$J)
 ;
 I '$G(XWBDBUG) K XWBPARMS
 K ^TMP("XWBM2M",$J),^TMP("XWBM2MRPC",$J),^TMP("XWBM2MVLC",$J)
 K ^TMP("XWBM2MRL"),^TMP("XWBM2ML",$J),^TMP("XWBVLL")
 K XWBTDEV,XWBTID,XWBVER,XWBCBK,XWBFIRST,XWBTO,XWBQUIT,XWBREAD
 K XWBRL,XWBROOT,XWBSTOP,XWBX,XWBY,XWBYX,XWBREQ,XWBCOK
 K XWBCLRFL
 Q
 ;
SIGNON() ;
 ;Encrpt AV before sending with RPC
 N XWBPARMS,XWBY
 K XWBPARMS
 S XWBPARMS("URI")="XUS SIGNON SETUP"
 S XWBCRLFL=0
 D REQUEST^XWBRPCC(.XWBPARMS)
 I XWBCRLFL Q 0
 ;
 ;Check if needed!!  **REM
 ;;IF $G(XWBPARMS("RESULTS"))="" SET XWBPARMS("RESULTS")=$NA(^TMP("XWBRPC",$J,"XML"))
 ;
 I '$$EXECUTE^XWBVLC(.XWBPARMS) Q 0 ;Run RPC and place raw XML results in ^TMP("XWBM2MVLC"
 S XWBY="" D PARSE^XWBRPC(.XWBPARMS,XWBY) ;Parse out raw XML and place results in ^TMP("XWBM2MRPC"
 Q 1
 ;
VALIDAV(AV) ;Check AV code
 K XWBPARMS
 S AV=$$ENCRYP^XUSRB1(AV) ;Encrypt access/verify codes
 D PRE
 ;
 ; -String parameter type
 S XWBPARMS("PARAMS",1,"TYPE")="STRING"
 ;;S XWBPARMS("PARAMS",1,"VALUE")=$$CHARCHK^XWBUTL(AV)
 S XWBPARMS("PARAMS",1,"VALUE")=AV
 S XWBPARMS("URI")="XUS AV CODE"
 S XWBCRLFL=0
 D REQUEST^XWBRPCC(.XWBPARMS)
 I XWBCRLFL Q 0
 ;
 ;Check if needed!!  **REM
 ;;IF $G(XWBPARMS("RESULTS"))="" SET XWBPARMS("RESULTS")=$NA(^TMP("XWBRPC",$J,"XML"))
 ;
 I '$$EXECUTE^XWBVLC(.XWBPARMS) Q 0 ;Run RPC and place raw XML results in ^TMP("XWBM2MVLC"
 S XWBY="" D PARSE^XWBRPC(.XWBPARMS,XWBY) ;Parse out raw XML and place results in ^TMP("XWBM2MRPC"
 K XWBPARMS
 Q 1
 ;
GETDIV(XWBDIVG) ;*p34-gets the division for a user.
 ;Returns 1-succuss, 0=fail
 ;XWBDIVG - where the division string will be places.
 ;Return value for XWBDIVG:
 ; XWBDIVG(1)=number of divisions
 ; XWBDIVG(#)='ien;station name;station#' delimitated with ";"
 ; If a user has only 1 divison, then XWBDIVG(1)=0 because Kernel
 ; will automatically assign that division as a default.  Use IEN to 
 ; set division in $$SETDIV.
 N RPC,ROOT
 K XWBPARMS
 D PRE,SETPARAM(1,"STRING","DUMBY")
 I '$$CALLRPC^XWBM2MC("XUS DIVISION GET",XWBDIVG,0) D ERROR(10) Q 0
 K XWBPARMS
 Q 1
 ;
SETDIV(XWBDIVS) ;*p34-sets the division for a user.
 ;Returns 1-success, 0=fail
 ;XWBDIVS - Division to set. Use IEN from $$GETDIV. 
 N REQ
 K XWBPARMS
 S REQ="RESULT"
 D PRE,SETPARAM(1,"STRING",XWBDIVS)
 I '$$CALLRPC^XWBM2MC("XUS DIVISION SET",REQ,0) D ERROR(11) Q 0
 K XWBPARMS
 Q 1
 ;
PRE ;Prepare the needed PARMS **REM might not need PRE
 ;S XWBCON="DSM" ;Check if needed!!  **REM
 ;
 S XWBPARMS("MODE")="RPCBroker"
 Q
 ;
ERROR(CODE,STR) ;Will write error msg and related API in TMP
 ;*p34-new STR to append to error msg.
 N API,X
 S API=$P($T(ERRMSG+CODE),";;",3)
 S X=$NA(^TMP("XWBM2ME",$J,"ERROR",API)),@X=$P($T(ERRMSG+CODE),";;",2)_$G(STR) ;*p34
 Q
 ;
ERRMSG ; Error messages
 ;*p34-add 2 more error msg for GETDIV and SETDIV.
 ;;Could not open connection ;;CONNECT
 ;;XUS SIGNON SETUP RPC failed ;;SIGNON
 ;;XUS AV CODE RPC failed ;;SIGNON
 ;;Invalid user, no DUZ returned ;;SIGNON
 ;;There is no connection ;;CALLRPC
 ;;RPC could not be processed ;;CALLRPC
 ;;Remote Procedure Unknown ;;SERVER
 ;;Control Character Found ;;CALLRPC
 ;;Error in division return ;;CONNECT
 ;;Could not obtain list of valid divisions for current user ;;GETDIV
 ;;Could not Set active Division for current user ;;SETDIV
 Q
