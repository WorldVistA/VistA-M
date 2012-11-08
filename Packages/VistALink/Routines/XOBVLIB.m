XOBVLIB ;; mjk/alb - VistaLink Programmer Library ; 07/27/2002  13:00
 ;;1.6;VistALink;;May 08, 2009;Build 15
 ;Per VHA directive 2004-038, this routine should not be modified.
 QUIT
 ; --------------------------------------------------------------
 ;              Application Developer Supported Calls
 ; --------------------------------------------------------------
 ;
XMLHDR() ; -- provides current XML standard header 
 QUIT "<?xml version=""1.0"" encoding=""utf-8"" ?>"
 ;
CHARCHK(STR) ; -- replace xml character limits with entities
 NEW A,I,X,Y,Z,NEWSTR
 SET (Y,Z)=""
 IF STR["&" SET NEWSTR=STR DO  SET STR=Y_Z
 . FOR X=1:1  SET Y=Y_$PIECE(NEWSTR,"&",X)_"&amp;",Z=$PIECE(STR,"&",X+1,999) QUIT:Z'["&"
 IF STR["<" FOR  SET STR=$PIECE(STR,"<",1)_"&lt;"_$PIECE(STR,"<",2,99) QUIT:STR'["<"
 IF STR[">" FOR  SET STR=$PIECE(STR,">",1)_"&gt;"_$PIECE(STR,">",2,99) QUIT:STR'[">"
 IF STR["'" FOR  SET STR=$PIECE(STR,"'",1)_"&apos;"_$PIECE(STR,"'",2,99) QUIT:STR'["'"
 IF STR["""" FOR  SET STR=$PIECE(STR,"""",1)_"&quot;"_$PIECE(STR,"""",2,99) QUIT:STR'[""""
 ;
 FOR I=1:1:$LENGTH(STR) DO
 . SET X=$EXTRACT(STR,I)
 . SET A=$ASCII(X)
 . IF A<31 SET STR=$PIECE(STR,X,1)_$PIECE(STR,X,2,99)
 QUIT STR
 ;
STOP() ; -- called by application to determine if processing should stop gracefully
 NEW XOBFLAG
 ;
 ; -- do checks (only one now is time out)
 DO TOFLAG
 ;
 ; -- set 'stop' flag
 SET XOBFLAG=$$TOCHK()
 ;
 QUIT XOBFLAG
 ;
GETTO() ; -- get time out value
 QUIT $GET(XOBDATA("XOB RPC","TIMEOUT"),300)
 ;
SETTO(TO) ; -- set time out value on the fly
 SET XOBDATA("XOB RPC","TIMEOUT")=TO
 QUIT 1
 ;
 ; --------------------------------------------------------------
 ;                 Foundations Developer Calls (Unsupported)
 ; --------------------------------------------------------------
 ; 
VLHDR(NUM) ; -- provides current VistaLink standard header
 NEW X,TYPE,SCHEMA
 ;
 ; -- get type info
 SET X=$PIECE($TEXT(TYPE+NUM),";;",2)
 SET TYPE=$PIECE(X,"^",2)
 SET SCHEMA=$PIECE(X,"^",3)
 QUIT $$ENVHDR(TYPE,SCHEMA)
 ;
TYPE ; -- return message types [ number ^ message type ^ schema file ]
 ;;1^gov.va.med.foundations.rpc.response^rpcResponse.xsd
 ;;2^gov.va.med.foundations.rpc.fault^rpcFault.xsd
 ;;3^gov.va.med.foundations.vistalink.system.fault^vlFault.xsd
 ;;4^gov.va.med.foundations.vistalink.system.response^vlSimpleResponse.xsd
 ;
ERROR(XOBDAT) ; -- send error type message
 NEW XOBI,XOBY,XOBOS
 SET XOBY="XOBY"
 ; -- build xml
 DO BUILD(.XOBY,.XOBDAT)
 ;
 USE XOBPORT
 DO OS^XOBVSKT
 ; -- write xml
 DO PRE^XOBVSKT
 SET XOBI=0 FOR  SET XOBI=$ORDER(XOBY(XOBI)) QUIT:'XOBI  DO WRITE^XOBVSKT(XOBY(XOBI))
 ; -- send eot and flush buffer
 DO POST^XOBVSKT
 QUIT
 ;
BUILD(XOBY,XOBDAT) ;  -- store built xml in passed store reference (XOBY)
 ; -- input format
 ; XOBDAT("MESSAGE TYPE") = # type of message (ex. 2 = gov.va.med.foundations.vistalink.rpc.fault :: See TYPE tag) 
 ; XOBDAT("ERRORS",<integer>,"CODE")         = error code
 ; XOBDAT("ERRORS",<integer>,"ERROR TYPE")   = type of error (system/application/security)
 ; XOBDAT("ERRORS",<integer>,"MESSAGE",<integer>) = error message
 ; 
 ;  -- SOAP related information
 ; XOBDAT("ERRORS",<integer>,"FAULT CODE")   = high level code on where error occurred (ex. Client, Server, etc.)
 ;          - Default: Server
 ; XOBDAT("ERRORS",<integer>,"FAULT STRING") = high level fault type text (ex. System Error)
 ;          - Default: System Error
 ; XOBDAT("ERRORS",<integer>,"FAULT ACTOR")  = RPC, routine, etc. running when error occurred
 ;          - Default: [none]
 ; 
 NEW XOBCODE,XOBI,XOBERR,XOBLINE,XOBETYPE
 SET XOBLINE=0
 ;
 DO ADD($$VLHDR($GET(XOBDAT("MESSAGE TYPE"))))
 DO ADD("<Fault>")
 DO ADD("<FaultCode>"_$GET(XOBDAT("ERRORS",1,"FAULT CODE"),"Server")_"</FaultCode>")
 DO ADD("<FaultString>"_$GET(XOBDAT("ERRORS",1,"FAULT STRING"),"System Error")_"</FaultString>")
 DO ADD("<FaultActor>"_$GET(XOBDAT("ERRORS",1,"FAULT ACTOR"))_"</FaultActor>")
 DO ADD("<Detail>")
 SET XOBERR=0
 FOR  SET XOBERR=$ORDER(XOBDAT("ERRORS",XOBERR)) QUIT:'XOBERR  DO
 . SET XOBCODE=$GET(XOBDAT("ERRORS",XOBERR,"CODE"),0)
 . SET XOBETYPE=$GET(XOBDAT("ERRORS",XOBERR,"ERROR TYPE"),0)
 . DO ADD("<Error type="""_XOBETYPE_""" code="""_XOBCODE_""" >")
 . DO ADD("<Message>")
 . IF $GET(XOBDAT("ERRORS",XOBERR,"CDATA")) DO ADD("<![CDATA[")
 . SET XOBI=0
 . FOR  SET XOBI=$ORDER(XOBDAT("ERRORS",XOBERR,"MESSAGE",XOBI)) QUIT:'XOBI  DO
 . . DO ADD(XOBDAT("ERRORS",XOBERR,"MESSAGE",XOBI))
 . IF $GET(XOBDAT("ERRORS",XOBERR,"CDATA")) DO ADD("]]>")
 . DO ADD("</Message>")
 . DO ADD("</Error>")
 DO ADD("</Detail>")
 DO ADD("</Fault>")
 DO ADD($$ENVFTR())
 ;
 QUIT
 ;
ADD(TXT) ; -- add line
 SET XOBLINE=XOBLINE+1
 SET @XOBY@(XOBLINE)=TXT
 QUIT
 ;
GETRATE() ; -- get J2SE heartbeat rate in seconds
 NEW X
 SET X=$PIECE($GET(^XOB(18.01,1,0)),"^",2)
 QUIT $SELECT(X:X,1:180)
 ;
GETDELTA() ; -- get J2SE latency delta in seconds
 NEW X
 SET X=$PIECE($GET(^XOB(18.01,1,0)),"^",3)
 QUIT $SELECT(X:X,1:180)
 ;
GETASTO() ; -- get J2EE application server time out in seconds (one day = 86400)
 NEW X
 SET X=$PIECE($GET(^XOB(18.01,1,0)),"^",4)
 QUIT $SELECT(X:X,1:86400)
 ;
GETRASTO() ; -- get J2EE application server reauthenticated session time out in seconds (ten minutes = 600)
 NEW X
 SET X=$PIECE($GET(^XOB(18.01,1,0)),"^",5)
 QUIT $SELECT(X:X,1:600)
 ;
TOFLAG ; -- set timed out flag
 ; -- if run in non-VistALink environment never time out ; set both now & start = $h
 SET XOBDATA("XOB RPC","TIMED OUT")=($$HDIFF^XLFDT($HOROLOG,$GET(XOBDATA("XOB RPC","START"),$HOROLOG),2)>$$GETTO())
 QUIT
 ;
TOCHK() ; -- did RPC timeout?
 QUIT +$GET(XOBDATA("XOB RPC","TIMED OUT"))
 ;
ENVHDR(TYPE,SCHEMA) ; -- vistalink beg tag (header)
 NEW X,VLVER
 SET X=$$XMLHDR()
 SET X=X_"<VistaLink"
 SET X=X_" messageType="""_TYPE_""""
 SET VLVER="1.6"
 ; -- indicates to VL v1.5 client that this VL v1.6 server is backwards compatible
 IF $GET(XOBDATA("VL VERSION"))="1.5" SET VLVER="1.5"
 ; -- indicates to VL v1.0 client that this VL v1.6 server is backwards compatible
 IF $GET(XOBDATA("VL VERSION"))="1.0" SET VLVER="1.0"
 SET X=X_" version="""_VLVER_""""
 SET X=X_" xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance"""
 SET X=X_" xsi:noNamespaceSchemaLocation="""_SCHEMA_""""
 ;SET X=X_" xmlns=""http://med.va.gov/Foundations"""
 SET X=X_">"
 QUIT X
 ;
ENVFTR() ; -- vistalink end tag (footer)
 QUIT "</VistaLink>"
 ;
SYSOS(XOBOS) ; -- get system operating system
 ; -- DBIA #3522
 QUIT $SELECT(XOBOS["OpenM":$$OS^%ZOSV(),XOBOS["DSM":"VMS",1:"Unknown")
 ;
