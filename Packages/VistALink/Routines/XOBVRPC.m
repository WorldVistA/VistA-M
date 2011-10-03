XOBVRPC ;; mjk/alb - VistaLink RPC Server Listener Code ; 07/27/2002  13:00
 ;;1.6;VistALink;;May 08, 2009;Build 15
 ;Per VHA directive 2004-038, this routine should not be modified.
 QUIT
 ;
 ; ------------------------------------------------------------------------
 ;                   RPC Server: Message Request Handler         
 ; ------------------------------------------------------------------------
 ; 
EN(XOBDATA) ; -- handle parsed messages request
 NEW DX,DY,RPC0,RPCNAME,RPCIEN,TAG,ROU,METHSIG,XOBERR,XOBR,XOBSEC,XOBWRAP,XOBPTYPE,XRTN,XOBRA,XOBVER
 ;
 IF $GET(XOBDATA("XOB RPC","RPC NAME"))="" DO  GOTO ENQ
 . DO ERROR(182001,"[No RPC]","")
 ;
 SET RPCNAME=XOBDATA("XOB RPC","RPC NAME")
 ;
 IF $DATA(^XWB(8994,"B",RPCNAME))=0 DO  GOTO ENQ
 . DO ERROR(182002,RPCNAME,RPCNAME)
 ;
 IF $DATA(^XWB(8994,"B",RPCNAME))=10 SET RPCIEN=+$ORDER(^XWB(8994,"B",RPCNAME,""))
 ;
 ; -- get zero node
 SET RPC0=$GET(^XWB(8994,RPCIEN,0))
 ;
 ; -- make sure there is data on node
 IF RPC0="" DO  GOTO ENQ
 . DO ERROR(182003,RPCNAME,RPCNAME)
 ;
 ; -- make sure x-ref is not corrupt and found the wrong entry
 IF RPCNAME'=$PIECE(RPC0,U) DO  GOTO ENQ
 . NEW PARAMS SET PARAMS(1)=RPCNAME,PARAMS(2)=$PIECE(RPC0,U)
 . DO ERROR(182008,RPCNAME,.PARAMS)
 ;
 ; -- check inactive flag
 IF $PIECE(RPC0,U,6)=1!($PIECE(RPC0,U,6)=2) DO  GOTO ENQ
 . DO ERROR(182004,RPCNAME,RPCNAME)
 ;
 ; -- if not already performed, check version, environment and set re-auth check flag
 SET XOBERR=$SELECT($DATA(XOBSYS("RPC REAUTH")):0,1:$$VER())
 IF XOBERR DO  GOTO ENQ
 . DO ERROR(XOBERR,RPCNAME)
 ;
 ; -- reauthentication checks
 SET XOBERR=0
 IF +$GET(XOBSYS("RPC REAUTH")) DO  GOTO:XOBERR ENQ
 . ;
 . ; -- reauthenticate user based on type (i.e. DUZ,AV,VPID,CCOW,APPPROXY)
 . SET XOBERR=$$SETUPDUZ^XOBSRA()
 . IF XOBERR DO ERROR(XOBERR,RPCNAME) QUIT
 . ;
 . ; -- if application proxy user, check if allowed to run RPC
 . IF $$UP^XLFSTR(XOBDATA("XOB RPC","SECURITY","TYPE"))="APPPROXY",'$$RPC^XUSAP($GET(RPCIEN)) DO  QUIT
 .. SET XOBERR=182010
 .. DO ERROR(XOBERR,RPCNAME,RPCNAME)
 ;
 ; -- set context
 SET XOBSEC=$$CRCONTXT^XOBSCAV($GET(XOBDATA("XOB RPC","RPC CONTEXT")))
 IF '+XOBSEC DO  GOTO ENQ
 . DO ERROR(182005,RPCNAME,XOBSEC)
 ;
 ; -- check if appropriate context created
 SET XOBSEC=$$CHKCTXT^XOBSCAV(RPCNAME)
 IF '+XOBSEC DO  GOTO ENQ
 . DO ERROR(182006,RPCNAME,XOBSEC)
 ;
 ; -- setup timeout info
 SET XOBDATA("XOB RPC","TIMED OUT")=0
 SET XOBDATA("XOB RPC","START")=$HOROLOG
 ;
 ; -- setup info needed for RPC execution
 SET TAG=$PIECE(RPC0,U,2)
 SET ROU=$PIECE(RPC0,U,3)
 SET XOBPTYPE=$PIECE(RPC0,U,4)
 SET XOBWRAP=$PIECE(RPC0,U,8)
 SET XOBVER=$$GETVER^XOBVRPCX()
 ;
 ; -- build method signature
 SET METHSIG=TAG_"^"_ROU_"(.XOBR"_$GET(XOBDATA("XOB RPC","PARAMS"))_")"
 ;
 ; -- start RTL
 DO:$DATA(XRTL) T0^%ZOSV
 ;
 ; -- use null device in case of writing during RPC execution
 USE XOBNULL
 ;
 ; -- start RUM for RPC Name
 DO LOGRSRC^%ZOSV(RPCNAME,2,1)
 ;
 ; -- execute RPC
 DO CALLRPC(.XOBPTYPE,.XOBWRAP,.XOBVER,METHSIG)
 ;
 ; -- re-start RUM for VistaLink Handler
 DO LOGRSRC^%ZOSV("$VISTALINK HANDLER$",2,1)
 ;
 ; -- stop RTL
 SET:$DATA(XRT0) XRTN=RPCNAME DO:$DATA(XRT0) T1^%ZOSV
 ;
 ; -- empty write buffer of null device
 USE XOBNULL SET DX=0,DY=0 XECUTE ^%ZOSF("XY")
 ;
 ; -- reset to use tcp port device to send results
 USE XOBPORT
 ;
 ; -- check for RPC processing timeout
 IF $$TOCHK^XOBVLIB() DO  GOTO ENQ
 . NEW PARAMS SET PARAMS(1)=RPCNAME,PARAMS(2)=$$GETTO^XOBVLIB()
 . DO ERROR(182007,RPCNAME,.PARAMS)
 ;
 ; -- send results
 DO SEND(.XOBR)
 ;
ENQ ; -- end message handler
 DO CLEAN
 QUIT
 ;
CALLRPC(XWBPTYPE,XWBWRAP,XWBAPVER,METHSIG) ;-- execute RPC (use Broker RPC return type & wrap flag if there)
 DO @METHSIG
 QUIT
 ;
CLEAN ; -- clean up message handler environment
 NEW POS
 ; -- kill parameters
 SET POS=0
 FOR  SET POS=$ORDER(XOBDATA("XOB RPC","PARAMS",POS)) QUIT:'POS  KILL @XOBDATA("XOB RPC","PARAMS",POS)
 QUIT
 ;
SEND(XOBR) ; -- stream rpc data to client
 NEW XOBFMT,XOBFILL
 ;
 SET XOBFMT=$$GETFMT()
 ; -- prepare socket for writing
 DO PRE^XOBVSKT
 ; -- initialize XML headers
 DO WRITE^XOBVSKT($$VLHDR^XOBVLIB(1))
 ; -- start response
 DO WRITE^XOBVSKT("<Response type="""_XOBFMT_""" ><![CDATA[")
 ; -- results
 DO PROCESS
 ; -- finalize
 DO WRITE^XOBVSKT("]]></Response>"_$$ENVFTR^XOBVLIB())
 ; -- send eot and flush buffer
 DO POST^XOBVSKT
 ;
 QUIT
 ;
DOCTYPE ;
 DO WRITE^XOBVSKT("<!DOCTYPE vistalink [<!ELEMENT vistalink (results) ><!ELEMENT results (#PCDATA)><!ATTLIST vistalink type CDATA ""Gov.VA.Med.RPC.Response"" ><!ATTLIST results type (array|string) >]>")
 QUIT
 ;
GETFMT() ; -- determine response format type
 IF XOBPTYPE=1!(XOBPTYPE=5)!(XOBPTYPE=6) QUIT "string"
 IF XOBPTYPE=2 QUIT "array"
 ;
 QUIT $SELECT(XOBWRAP:"array",1:"string")
 ;
PROCESS ; -- send the real results
 NEW I,T,D
 ; -- single value
 IF XOBPTYPE=1 SET XOBR=$GET(XOBR) DO WRITE^XOBVSKT(XOBR) QUIT
 ; -- table delimited by CR+LF
 IF XOBPTYPE=2 DO  QUIT
 . SET I="" FOR  SET I=$ORDER(XOBR(I)) QUIT:I=""  DO WRITE^XOBVSKT(XOBR(I)),WRITE^XOBVSKT($CHAR(10))
 ; -- word processing
 IF XOBPTYPE=3 DO  QUIT
 . SET I="" FOR  SET I=$ORDER(XOBR(I)) QUIT:I=""  DO WRITE^XOBVSKT(XOBR(I)) DO:XOBWRAP WRITE^XOBVSKT($CHAR(10))
 ; -- global array
 IF XOBPTYPE=4 DO  QUIT
 . IF $EXTRACT($GET(XOBR))'="^" QUIT
 . SET I=$GET(XOBR) QUIT:I=""  SET T=$EXTRACT(I,1,$LENGTH(I)-1)
 . ;Only send root node if non-null.
 . IF $DATA(@I)>10 SET D=@I IF $LENGTH(D) DO WRITE^XOBVSKT(D),WRITE^XOBVSKT($CHAR(10)):XOBWRAP&(D'=$CHAR(10))
 . FOR  SET I=$QUERY(@I) QUIT:I=""!(I'[T)  SET D=@I DO WRITE^XOBVSKT(D),WRITE^XOBVSKT($CHAR(10)):XOBWRAP&(D'=$CHAR(10))
 . IF $DATA(@XOBR) KILL @XOBR
 ; -- global instance
 IF XOBPTYPE=5 DO  QUIT
 . IF $EXTRACT($GET(XOBR))'="^" QUIT
 . SET XOBR=$GET(@XOBR) DO WRITE^XOBVSKT(XOBR)
 ; -- variable length records only good up to 255 char)
 IF XOBPTYPE=6 DO
 . SET I="" FOR  SET I=$ORDER(XOBR(I)) QUIT:I=""  DO WRITE^XOBVSKT($CHAR($LENGTH(XOBR(I)))),WRITE^XOBVSKT(XOBR(I))
 QUIT
 ;
ERROR(CODE,RPCNAME,PARAMS) ; -- send rpc application error
 NEW XOBI,XOBDAT
 ; -- if parameters are passed as in CODE (where CODE = code^param1^param2^...)
 ; -- parse CODE and put parameters into PARAMS array.
 IF CODE[U,$DATA(PARAMS)=0 DO
 . KILL PARAMS
 . FOR XOBI=2:1:$LENGTH(XOBERR,U) SET PARAMS(XOBI-1)=$PIECE(XOBERR,U,XOBI)
 . SET CODE=+CODE
 ;
 SET XOBDAT("MESSAGE TYPE")=2
 SET XOBDAT("ERRORS",1,"FAULT STRING")="Internal Application Error"
 SET XOBDAT("ERRORS",1,"FAULT ACTOR")=RPCNAME
 SET XOBDAT("ERRORS",1,"CODE")=CODE
 SET XOBDAT("ERRORS",1,"ERROR TYPE")=RPCNAME
 SET XOBDAT("ERRORS",1,"CDATA")=0
 SET XOBDAT("ERRORS",1,"MESSAGE",1)=$$EZBLD^DIALOG(CODE,.PARAMS)
 DO ERROR^XOBVLIB(.XOBDAT)
 ;
 ; -- save info in error system
 ;DO ^%ZTER
 QUIT
 ;
VER() ; -- check version and if re-authentication check is needed
 ; -- IMPORTANT: This tag needs updating for version numbers for each target release.
 ; -- This call needs only be called once per connection.
 ; 
 NEW XOBERR,CV,SV,ENV
 ;
 KILL XOBSYS("RPC REAUTH")
 ;
 SET XOBERR=0
 ; -- default re-auh flag to true
 SET XOBRA=1
 ; -- client version
 SET CV=XOBDATA("XOB RPC","RPC HANDLER VERSION")
 ; -- current server version
 SET SV="1.6"
 ; -- client environment
 SET ENV=XOBSYS("ENV")
 ;
 ; -- if client version is not supported then return error
 IF ("^1.0^1.5^1.6^")'[(U_CV_U) DO  GOTO VERQ
 . SET XOBERR=182009_U_CV_U_SV_U_"Client version not supported"
 ;
 ; -- if client environment is not supported then return error
 IF ("^j2se^j2ee^.net^")'[(U_ENV_U) DO  GOTO VERQ
 . SET XOBERR=182009_U_CV_U_SV_U_"Client environment ("_$$UP^XLFSTR(ENV)_") not supported"
 ;
 ; -- if client/server environment then ok
 IF ("^j2se^.net^")[(U_ENV_U) SET XOBRA=0 GOTO VERQ
 ;
 ; -- if client version is "1.0" and client is j2ee then return error
 IF CV="1.0",ENV="j2ee" DO  GOTO VERQ
 . SET XOBERR=182009_U_CV_U_SV_U_"Client RPC version does not support "_$$UP^XLFSTR(ENV)
 ;
 ; -- if client version supports j2ee and client is j2ee then ok (default)
 ;IF ENV="j2ee" GOTO VERQ
 ;
VERQ ;
 IF 'XOBERR SET XOBSYS("RPC REAUTH")=XOBRA
 QUIT XOBERR
 ;
