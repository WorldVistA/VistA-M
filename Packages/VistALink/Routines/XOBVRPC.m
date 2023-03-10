XOBVRPC ;; mjk/alb - VistaLink RPC Server Listener Code ; 07/27/2002  13:00
 ;;1.6;VistALink Security;**4**;May 08, 2009;Build 7
 ; ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
 ; ------------------------------------------------------------------------
 ;                   RPC Server: Message Request Handler         
 ; ------------------------------------------------------------------------
 ; 
EN(XOBDATA) ; -- handle parsed messages request
 N DX,DY,RPC0,RPCNAME,RPCIEN,TAG,ROU,METHSIG,XOBERR,XOBR,XOBSEC,XOBWRAP,XOBPTYPE,XRTN,XOBRA,XOBVER
 ;
 I $G(XOBDATA("XOB RPC","RPC NAME"))="" D  G ENQ
 . D ERROR(182001,"[No RPC]","")
 ;
 S RPCNAME=XOBDATA("XOB RPC","RPC NAME")
 ;
 I $D(^XWB(8994,"B",RPCNAME))=0 D  G ENQ
 . D ERROR(182002,RPCNAME,RPCNAME)
 ;
 I $D(^XWB(8994,"B",RPCNAME))=10 S RPCIEN=+$O(^XWB(8994,"B",RPCNAME,""))
 ;
 ; -- get zero node
 S RPC0=$G(^XWB(8994,RPCIEN,0))
 ;
 ; -- make sure there is data on node
 I RPC0="" D  G ENQ
 . D ERROR(182003,RPCNAME,RPCNAME)
 ;
 ; -- make sure x-ref is not corrupt and found the wrong entry
 I RPCNAME'=$P(RPC0,U) D  G ENQ
 . N PARAMS S PARAMS(1)=RPCNAME,PARAMS(2)=$P(RPC0,U)
 . D ERROR(182008,RPCNAME,.PARAMS)
 ;
 ; -- check inactive flag
 I $P(RPC0,U,6)=1!($P(RPC0,U,6)=2) D  G ENQ
 . D ERROR(182004,RPCNAME,RPCNAME)
 ;
 ; -- if not already performed, check version, environment and set re-auth check flag
 S XOBERR=$S($D(XOBSYS("RPC REAUTH")):0,1:$$VER())
 I XOBERR D  G ENQ
 . D ERROR(XOBERR,RPCNAME)
 ;
 ; -- reauthentication checks
 S XOBERR=0
 I +$G(XOBSYS("RPC REAUTH")) D  G:XOBERR ENQ
 . ;
 . ; -- reauthenticate user based on type (i.e. DUZ,AV,VPID,CCOW,APPPROXY)
 . S XOBERR=$$SETUPDUZ^XOBSRA()
 . I XOBERR D ERROR(XOBERR,RPCNAME) Q
 . ;
 . ; -- if application proxy user, check if allowed to run RPC
 . I $$UP^XLFSTR(XOBDATA("XOB RPC","SECURITY","TYPE"))="APPPROXY",'$$RPC^XUSAP($G(RPCIEN)) D  Q
 .. S XOBERR=182010
 .. D ERROR(XOBERR,RPCNAME,RPCNAME)
 ;
 ; -- set context
 S XOBSEC=$$CRCONTXT^XOBSCAV($G(XOBDATA("XOB RPC","RPC CONTEXT")))
 I '+XOBSEC D  G ENQ
 . D ERROR(182005,RPCNAME,XOBSEC)
 ;
 ; -- check if appropriate context created
 S XOBSEC=$$CHKCTXT^XOBSCAV(RPCNAME)
 I '+XOBSEC D  G ENQ
 . D ERROR(182006,RPCNAME,XOBSEC)
 ;
 ; -- setup timeout info
 S XOBDATA("XOB RPC","TIMED OUT")=0
 S XOBDATA("XOB RPC","START")=$H
 ;
 ; -- setup info needed for RPC execution
 S TAG=$P(RPC0,U,2)
 S ROU=$P(RPC0,U,3)
 S XOBPTYPE=$P(RPC0,U,4)
 S XOBWRAP=$P(RPC0,U,8)
 S XOBVER=$$GETVER^XOBVRPCX()
 ;
 ; -- build method signature
 S METHSIG=TAG_"^"_ROU_"(.XOBR"_$G(XOBDATA("XOB RPC","PARAMS"))_")"
 ;
 ; -- start RTL
 D:$D(XRTL) T0^%ZOSV
 ;
 ; -- use null device in case of writing during RPC execution
 U XOBNULL
 ;
 ; -- start RUM for RPC Name
 D LOGRSRC^%ZOSV(RPCNAME,2,1)
 ;
 ; -- execute RPC
 D CALLRPC(.XOBPTYPE,.XOBWRAP,.XOBVER,METHSIG)
 ;
 ; -- re-start RUM for VistaLink Handler
 D LOGRSRC^%ZOSV("$VISTALINK HANDLER$",2,1)
 ;
 ; -- stop RTL
 S:$D(XRT0) XRTN=RPCNAME D:$D(XRT0) T1^%ZOSV
 ;
 ; -- empty write buffer of null device
 U XOBNULL S DX=0,DY=0 X ^%ZOSF("XY")
 ;
 ; -- reset to use tcp port device to send results
 U XOBPORT
 ;
 ; -- check for RPC processing timeout
 I $$TOCHK^XOBVLIB() D  G ENQ
 . N PARAMS S PARAMS(1)=RPCNAME,PARAMS(2)=$$GETTO^XOBVLIB()
 . D ERROR(182007,RPCNAME,.PARAMS)
 ;
 ; -- send results
 D SEND(.XOBR)
 ;
ENQ ; -- end message handler
 D CLEAN
 Q
 ;
CALLRPC(XWBPTYPE,XWBWRAP,XWBAPVER,METHSIG) ;-- execute RPC (use Broker RPC return type & wrap flag if there)
 D @METHSIG
 Q
 ;
CLEAN ; -- clean up message handler environment
 N POS
 ; -- kill parameters
 S POS=0
 F  S POS=$O(XOBDATA("XOB RPC","PARAMS",POS)) Q:'POS  K @XOBDATA("XOB RPC","PARAMS",POS)
 Q
 ;
SEND(XOBR) ; -- stream rpc data to client
 N XOBFMT,XOBFILL
 ;
 S XOBFMT=$$GETFMT()
 ; -- prepare socket for writing
 D PRE^XOBVSKT
 ; -- initialize XML headers
 D WRITE^XOBVSKT($$VLHDR^XOBVLIB(1))
 ; -- start response
 D WRITE^XOBVSKT("<Response type="""_XOBFMT_""" ><![CDATA[")
 ; -- results
 D PROCESS
 ; -- finalize
 D WRITE^XOBVSKT("]]></Response>"_$$ENVFTR^XOBVLIB())
 ; -- send eot and flush buffer
 D POST^XOBVSKT
 ;
 Q
 ;
DOCTYPE ;
 D WRITE^XOBVSKT("<!DOCTYPE vistalink [<!ELEMENT vistalink (results) ><!ELEMENT results (#PCDATA)><!ATTLIST vistalink type CDATA ""Gov.VA.Med.RPC.Response"" ><!ATTLIST results type (array|string) >]>")
 Q
 ;
GETFMT() ; -- determine response format type
 I XOBPTYPE=1!(XOBPTYPE=5)!(XOBPTYPE=6) Q "string"
 I XOBPTYPE=2 Q "array"
 ;
 Q $S(XOBWRAP:"array",1:"string")
 ;
PROCESS ; -- send the real results
 N I,T,D
 ; -- single value
 I XOBPTYPE=1 S XOBR=$G(XOBR) D WRITE^XOBVSKT(XOBR) Q
 ; -- table delimited by CR+LF
 I XOBPTYPE=2 D  Q
 . S I="" F  S I=$O(XOBR(I)) Q:I=""  D WRITE^XOBVSKT(XOBR(I)),WRITE^XOBVSKT($C(10))
 ; -- word processing
 I XOBPTYPE=3 D  Q
 . S I="" F  S I=$O(XOBR(I)) Q:I=""  D WRITE^XOBVSKT(XOBR(I)) D:XOBWRAP WRITE^XOBVSKT($C(10))
 ; -- global array
 I XOBPTYPE=4 D  Q
 . I $E($G(XOBR))'="^" Q
 . S I=$G(XOBR) Q:I=""  S T=$E(I,1,$L(I)-1)
 . ;Only send root node if non-null.
 . I $D(@I)>10 S D=@I I $L(D) D WRITE^XOBVSKT(D),WRITE^XOBVSKT($C(10)):XOBWRAP&(D'=$C(10))
 . F  S I=$Q(@I) Q:I=""!(I'[T)  S D=@I D WRITE^XOBVSKT(D),WRITE^XOBVSKT($C(10)):XOBWRAP&(D'=$C(10))
 . I $D(@XOBR) K @XOBR
 ; -- global instance
 I XOBPTYPE=5 D  Q
 . I $E($G(XOBR))'="^" Q
 . S XOBR=$G(@XOBR) D WRITE^XOBVSKT(XOBR)
 ; -- variable length records only good up to 255 char)
 I XOBPTYPE=6 D
 . S I="" F  S I=$O(XOBR(I)) Q:I=""  D WRITE^XOBVSKT($C($L(XOBR(I)))),WRITE^XOBVSKT(XOBR(I))
 Q
 ;
ERROR(CODE,RPCNAME,PARAMS) ; -- send rpc application error
 N XOBI,XOBDAT,$ET,$ES
 ; -- if parameters are passed as in CODE (where CODE = code^param1^param2^...)
 ; -- parse CODE and put parameters into PARAMS array.
 I CODE[U,$D(PARAMS)=0 D
 . K PARAMS
 . F XOBI=2:1:$L(XOBERR,U) S PARAMS(XOBI-1)=$P(XOBERR,U,XOBI)
 . S CODE=+CODE
 ;
 S XOBDAT("MESSAGE TYPE")=2
 S XOBDAT("ERRORS",1,"FAULT STRING")="Internal Application Error"
 S XOBDAT("ERRORS",1,"FAULT ACTOR")=RPCNAME
 S XOBDAT("ERRORS",1,"CODE")=CODE
 S XOBDAT("ERRORS",1,"ERROR TYPE")=RPCNAME
 S XOBDAT("ERRORS",1,"CDATA")=0
 S XOBDAT("ERRORS",1,"MESSAGE",1)=$$EZBLD^DIALOG(CODE,.PARAMS)
 D ERROR^XOBVLIB(.XOBDAT)
 ;
 ; -- save info in error system
 D APPERROR^%ZTER("VistALink Error "_CODE) ;*4
 Q
 ;
VER() ; -- check version and if re-authentication check is needed
 ; -- IMPORTANT: This tag needs updating for version numbers for each target release.
 ; -- This call needs only be called once per connection.
 ; 
 N XOBERR,CV,SV,ENV
 ;
 K XOBSYS("RPC REAUTH")
 ;
 S XOBERR=0
 ; -- default re-auh flag to true
 S XOBRA=1
 ; -- client version
 S CV=XOBDATA("XOB RPC","RPC HANDLER VERSION")
 ; -- current server version
 S SV="1.6"
 ; -- client environment
 S ENV=XOBSYS("ENV")
 ;
 ; -- if client version is not supported then return error
 I ("^1.0^1.5^1.6^")'[(U_CV_U) D  G VERQ
 . S XOBERR=182009_U_CV_U_SV_U_"Client version not supported"
 ;
 ; -- if client environment is not supported then return error
 I ("^j2se^j2ee^.net^")'[(U_ENV_U) D  G VERQ
 . S XOBERR=182009_U_CV_U_SV_U_"Client environment ("_$$UP^XLFSTR(ENV)_") not supported"
 ;
 ; -- if client/server environment then ok
 I ("^j2se^.net^")[(U_ENV_U) S XOBRA=0 G VERQ
 ;
 ; -- if client version is "1.0" and client is j2ee then return error
 I CV="1.0",ENV="j2ee" D  G VERQ
 . S XOBERR=182009_U_CV_U_SV_U_"Client RPC version does not support "_$$UP^XLFSTR(ENV)
 ;
 ; -- if client version supports j2ee and client is j2ee then ok (default)
 ;IF ENV="j2ee" GOTO VERQ
 ;
VERQ ;
 I 'XOBERR S XOBSYS("RPC REAUTH")=XOBRA
 Q XOBERR
 ;
