XWBRPC ;OIFO-Oakland/REM - M2M Broker Server MRH  ;08/20/2002  12:13
 ;;1.1;RPC BROKER;**28,34**;Mar 28, 1997
 ;
 QUIT
 ;
 ; ---------------------------------------------------------------------
 ;                   RPC Server: Message Request Handler (MRH)         
 ; ---------------------------------------------------------------------
 ;
 ;p34 -added $$CHARCHK^XWBUTL before writing to WRITE^XWBRL to escape CR - PROCESS.
 ;    -remove $C(13). CR were not being stripped out in result - PROCESS.
 ;
 ; 
EN(XWBDATA) ; -- handle parsed messages request
 NEW RPC0,RPCURI,RPCIEN,TAG,ROU,METHSIG,XWBR
 ;
 IF $G(XWBDATA("URI"))="" DO  GOTO ENQ
 . DO ERROR(1,"NONE","No Remote Procedure Specified.")
 ;
 SET RPCURI=XWBDATA("URI")
 ;
 SET U="^"
 ;May want to build/call common broker api for RPC lookup.  See XWBBRK
 SET RPCIEN=$O(^XWB(8994,"B",RPCURI,""))
 IF RPCIEN'>0 DO  GOTO ENQ
 . DO ERROR(2,RPCURI,"Remote Procedure Unknown:  "_RPCURI_" cannot be found.")
 .D ERROR^XWBM2MC(7) ;Write error in TMP **M2M
 ;
 SET RPC0=$GET(^XWB(8994,RPCIEN,0))
 IF RPC0="" DO  GOTO ENQ
 . DO ERROR(3,RPCURI,"Remote Procedure Blank: '"_RPCURI_"' contains no information.")
 ;
 SET RPCURI=$P(RPC0,U)
 SET TAG=$P(RPC0,U,2)
 SET ROU=$P(RPC0,U,3)
 ;
 ; -- check inactive flag
 IF $P(RPC0,U,6)=1!($P(RPC0,U,6)=2) DO  GOTO ENQ
 . DO ERROR(4,RPCURI,"Remote Procedure InActive: '"_RPCURI_"' cannot be run at this time.")
 ;
 SET XWBPTYPE=$P(RPC0,U,4)
 SET XWBWRAP=$P(RPC0,U,8)
 ;
 ; -- build method signature and call rpc
 SET METHSIG=TAG_"^"_ROU_"(.XWBR"_$G(XWBDATA("PARAMS"))_")"
 ;
 I $G(XWBDEBUG) D LOG(METHSIG)
 ;See that the NULL device is current
 DO @METHSIG
 ;
 ; -- send results
 D USE^%ZISUTL("XWBM2M SERVER") U IO ;**M2M use server IO 
 ;
 I $G(XWBDEBUG) D LOG(.XWBR)
 DO SEND(.XWBR)
 ;
ENQ ; -- end message handler
 DO CLEAN
 ;
 QUIT
 ;
CLEAN ; -- clean up message handler environment
 NEW POS
 ; -- kill parameters
 SET POS=0
 FOR  S POS=$O(XWBDATA("PARAMS",POS)) Q:'POS  K @XWBDATA("PARAMS",POS)
 Q
 ;
SEND(XWBR) ; -- stream rpc data to client
 NEW XWBFMT,XWBFILL
 SET XWBFMT=$$GETFMT()
 ; -- prepare socket for writing
 DO PRE^XWBRL
 ; -- initialize
 DO WRITE^XWBRL($$XMLHDR^XWBUTL())
 ;DO DOCTYPE
 DO WRITE^XWBRL("<vistalink type=""Gov.VA.Med.RPC.Response"" ><results type="""_XWBFMT_""" ><![CDATA[")
 ; -- results
 DO PROCESS
 ; -- finalize
 DO WRITE^XWBRL("]]></results></vistalink>")
 ; -- send eot and flush buffer
 DO POST^XWBRL
 ;
 QUIT
 ;
DOCTYPE ;
 DO WRITE^XWBRL("<!DOCTYPE vistalink [<!ELEMENT vistalink (results) ><!ELEMENT results (#PCDATA)><!ATTLIST vistalink type CDATA ""Gov.VA.Med.RPC.Response"" ><!ATTLIST results type (array|string) >]>")
 QUIT
 ;
GETFMT() ; -- determine response format type
 IF XWBPTYPE=1!(XWBPTYPE=5)!(XWBPTYPE=6) QUIT "string"
 IF XWBPTYPE=2 QUIT "array"
 ;
 QUIT $S(XWBWRAP:"array",1:"string")
 ;
PROCESS ; -- send the real results
 NEW I,T,DEL,V
 ;
 ;*p34-Remove $C(13). CR were not being stripped out in results to escape CR.
 ;S DEL=$S(XWBMODE="RPCBroker":$C(13,10),1:$C(10))
 S DEL=$S(XWBMODE="RPCBroker":$C(10),1:$C(10))
 ;
 ;*p34-When write XWBR, go thru $$CHARCHK^XWBUTL first.
 ; -- single value
 IF XWBPTYPE=1 SET XWBR=$G(XWBR) DO WRITE^XWBRL($$CHARCHK^XWBUTL($G(XWBR))) QUIT
 ; -- table delimited by CR+LF - ARRAY
 IF XWBPTYPE=2 DO  QUIT
 . SET I="" FOR  SET I=$O(XWBR(I)) QUIT:I=""  DO WRITE^XWBRL($$CHARCHK^XWBUTL($G(XWBR(I)))),WRITE^XWBRL(DEL)
 ; -- word processing
 IF XWBPTYPE=3 DO  QUIT
 . SET I="" FOR  SET I=$O(XWBR(I)) QUIT:I=""  DO WRITE^XWBRL($$CHARCHK^XWBUTL($G(XWBR(I)))) DO:XWBWRAP WRITE^XWBRL(DEL)
 ; -- global array
 IF XWBPTYPE=4 DO  QUIT
 . SET I=$G(XWBR) QUIT:I=""  SET T=$E(I,1,$L(I)-1)
 . I $D(@I)>10 S V=@I D WRITE^XWBRL($$CHARCHK^XWBUTL($G(V)))
 . FOR  SET I=$Q(@I) QUIT:I=""!(I'[T)  S V=@I D WRITE^XWBRL($$CHARCHK^XWBUTL($G(V))) D:XWBWRAP&(V'=DEL) WRITE^XWBRL(DEL)
 . IF $D(@XWBR) KILL @XWBR
 ; -- global instance
 IF XWBPTYPE=5 S XWBR=$G(@XWBR) D WRITE^XWBRL($$CHARCHK^XWBUTL($G(XWBR))) QUIT
 ; -- variable length records only good up to 255 char)
 IF XWBPTYPE=6 SET I="" FOR  SET I=$O(XWBR(I)) QUIT:I=""  DO WRITE^XWBRL($C($L(XWBR(I)))),WRITE^XWBRL(XWBR(I))
 QUIT
 ;
ERROR(CODE,RPCURI,MSG) ; -- send rpc application error
 DO PRE^XWBRL
 DO WRITE^XWBRL($$XMLHDR^XWBUTL())
 DO WRITE^XWBRL("<vistalink type=""VA.RPC.Error"" >")
 DO WRITE^XWBRL("<errors>")
 DO WRITE^XWBRL("<error code="""_CODE_""" uri="""_$G(RPCURI)_""" >")
 DO WRITE^XWBRL("<msg>"_$G(MSG)_"</msg>")
 DO WRITE^XWBRL("</error>")
 DO WRITE^XWBRL("</errors>")
 DO WRITE^XWBRL("</vistalink>")
 ; -- send eot and flush buffer
 DO POST^XWBRL
 QUIT
 ;
 ; ---------------------------------------------------------------------
 ;             RPC Server: Request Message XML SAX Parser Callbacks         
 ; ---------------------------------------------------------------------
ELEST(ELE,ATR) ; -- element start event handler
 IF ELE="vistalink" KILL XWBSESS,XWBPARAM,XWBPN,XWBPTYPE QUIT
 ;
 IF ELE="rpc" SET XWBDATA("URI")=$$ESC^XWBRMX($G(ATR("uri"),"##Unkown RPC##")) QUIT
 ;
 IF ELE="param" DO  QUIT
 . SET XWBPARAM=1
 . SET XWBPN="XWBP"_ATR("position")
 . SET XWBDATA("PARAMS",ATR("position"))=XWBPN
 . SET XWBPTYPE=ATR("type")
 . S XWBCHRST="" ;To accumulate char
 ;
 IF ELE="index" DO  QUIT
 . ;SET @XWBPN@($$ESC^XWBRMX(ATR("name")))=$$ESC^XWBRMX(ATR("value"))
 . S XWBPN("name")=$$ESC^XWBRMX(ATR("name")) ;rwf
 . S XWBCHRST=""
 ;
 QUIT
 ;
ELEND(ELE) ; -- element end event handler
 IF ELE="vistalink" KILL XWBPOS,XWBSESS,XWBPARAM,XWBPN,XWBPTYPE,XWBCHRST QUIT
 ;
 IF ELE="params" DO  QUIT
 . NEW POS,PARAMS
 . SET PARAMS="",POS=0
 . FOR  SET POS=$O(XWBDATA("PARAMS",POS)) Q:'POS  SET PARAMS=PARAMS_",."_XWBDATA("PARAMS",POS)
 . SET XWBDATA("PARAMS")=PARAMS
 ;
 IF ELE="param" D  Q
 . I $G(XWBDEBUG),$D(XWBPN),$D(@XWBPN) D LOG(.@XWBPN)
 . KILL XWBPARAM,XWBCHRST
 ;
 QUIT
 ;
 ;This can be called more than once for one TEXT string.
CHR(TEXT) ; -- character value event handler <tag>TEXT</tag)
 ;
 IF $G(XWBPARAM) DO
 . ;What to do if string gets too long?
 . ;IF XWBPTYPE="string" SET XWBCHRST=XWBCHRST_$$ESC^XWBRMX(TEXT),@XWBPN=XWBCHRST QUIT
 . IF XWBPTYPE="string" SET XWBCHRST=XWBCHRST_TEXT,@XWBPN=XWBCHRST  QUIT
 . ;IF XWBPTYPE="ref" SET @XWBPN=$G(@$$ESC^XWBRMX(TEXT)) QUIT
 . IF XWBPTYPE="ref" SET XWBCHRST=XWBCHRST_TEXT,@XWBPN=@XWBCHRST QUIT
 . I XWBPTYPE="array" S XWBCHRST=XWBCHRST_TEXT,@XWBPN@(XWBPN("name"))=XWBCHRST Q  ;rwf
 QUIT
 ;
 ; ---------------------------------------------------------------------
 ;            Parse Results of Successful Legacy RPC Request
 ; ---------------------------------------------------------------------
 ;              
 ; [Public/Supported Method]
PARSE(XWBPARMS,XWBY) ; -- parse legacy rpc results ; uses SAX parser
 NEW XWBCHK,XWBOPT,XWBTYPE,XWBCNT
 ;
 ;**M2M Result will go here.
 I XWBY="" D
 .IF $G(XWBY)="" SET XWBY=$NA(^TMP("XWBM2MRPC",$J,"RESULTS"))
 .SET XWBYX=XWBY
 .KILL @XWBYX
 ;
 DO SET
 SET XWBOPT=""
 DO EN^MXMLPRSE(XWBPARMS("RESULTS"),.XWBCBK,.XWBOPT)
 Q
 ;
SET ; -- set the event interface entry points ;
 SET XWBCBK("STARTELEMENT")="RESELEST^XWBRPC"
 SET XWBCBK("ENDELEMENT")="RESELEND^XWBRPC"
 SET XWBCBK("CHARACTERS")="RESCHR^XWBRPC"
 QUIT
 ;
RESELEST(ELE,ATR) ; -- element start event handler
 IF ELE="results" SET XWBTYPE=$G(ATR("type")),XWBCNT=0
 QUIT
 ;
RESELEND(ELE) ; -- element end event handler
 KILL XWBCNT,XWBTYPE
 QUIT
 ;
RESCHR(TEXT) ; -- character value event handler
 QUIT:$G(XWBTYPE)=""
 QUIT:'$L(TEXT)  ; -- Sometimes sends in empty string
 ;
 IF XWBCNT=0,TEXT=$C(10) QUIT  ; -- bug in parser? always starts with $C(10)
 ;
 IF XWBTYPE="string" DO  QUIT
 . SET XWBCNT=XWBCNT+1
 . SET @XWBY@(XWBCNT)=TEXT
 ;
 IF XWBTYPE="array" DO
 . SET XWBCNT=XWBCNT+1
 . SET @XWBY@(XWBCNT)=$P(TEXT,$C(10))
 QUIT
 ;
PARSEX(XWBPARMS,XWBY) ; -- parse legacy rpc results ; uses DOM parser
 NEW XWBDOM
 SET XWBDOM=$$EN^MXMLDOM(XWBPARMS("RESULTS"),"")
 DO TEXT^MXMLDOM(XWBDOM,2,XWBY)
 DO DELETE^MXMLDOM(XWBDOM)
 QUIT
 ;
LOG(MSG) ;Debug log
 N CNT
 S CNT=$G(^TMP("XWBM2ML",$J))+1,^($J)=CNT
 M ^TMP("XWBM2ML",$J,CNT)=MSG
 Q
 ;
 ; -------------------------------------------------------------------
 ;                   Response Format Documentation
 ; -------------------------------------------------------------------
 ; 
 ;                   
 ; [ Sample XML produced by a successful call of EN^XWBRPC(.XWBPARMS). 
 ;   SEND^XWBRPC does the actual work to produce response.             ]
 ; 
 ; <?xml version="1.0" encoding="utf-8" ?>
 ; <vistalink type="Gov.VA.Med.RPC.Response" >
 ;     <results type="array" >
 ;         <![CDATA[4261;;2961001.08^2^274^166^105^^2961001.1123^1^^9^2^8^10^^^^^^^10G1-ALN
 ;         4270;;2961002.08^2^274^166^112^^^1^^9^2^8^10^^^^^^^10G8-ALN
 ;         4274;;2961003.08^2^274^166^116^^^1^^9^2^8^10^^^^^^^10GD-ALN
 ;         4340;;2961117.08^2^274^166^182^^2961118.1425^1^^9^2^8^10^^^^^^^10K0-ALN
 ;         4342;;2961108.13^2^108^207^183^^2961118.1546^1^^9^2^8^10^^^^^^^10K2-ALN
 ;         6394;;3000607.084^2^165^68^6479^^3000622.13^1^^9^1^8^10^^^^^^^197M-ALN]]>
 ;     </results>
 ; </vistalink>
 ; 
 ; -------------------------------------------------------------------
 ; 
 ; [ Sample XML produced by a unsuccessful call of EN^XWBRPC(.XWBPARMS). 
 ;   ERROR^XWBRPC does the actual work to produce response.             ]
 ; 
 ; <?xml version="1.0" encoding="utf-8" ?>
 ; <vistalink type="Gov.VA..Med.RPC.Error" >
 ;    <errors>
 ;       <error code="2" uri="XWB BAD NAME" >
 ;           <msg>
 ;              Remote Procedure Unknown: 'XWB BAD NAME' cannot be found.
 ;           </msg>
 ;       </error>
 ;    </errors>
 ; </vistalink>
 ; 
 ; -------------------------------------------------------------------
 ; 
