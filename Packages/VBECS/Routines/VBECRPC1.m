VBECRPC1 ;HINES OIFO/BNT - RPC Server Listener Code ;12/28/03  11:20
 ;;1.0;VBECS;;Apr 14, 2005;Build 35
 ;
 ; Note: This routine supports data exchange with an FDA registered
 ; medical device. As such, it may not be changed in any way without
 ; prior written approval from the medical device manufacturer.
 ; 
 ; Integration Agreements:
 ; Reference DBIA 4149 - M XML Parser
 ; Reference to EN^MXMLPRSE supported by IA #4149
 ;
 QUIT
 ;
 ; -----------------------------------------------------------------------
 ;            Parse Results of Successful Legacy RPC Request
 ; -----------------------------------------------------------------------
 ;              
 ; [Public/Supported Method]
PARSE(VBECPRMS,VBECY) ; -- parse legacy rpc results ; uses SAX parser
 NEW VBECCBK,VBECOPT,VBECTYPE,VBECCNT
 S VBMT=$NA(^TMP("VBECS_MAIL_TEXT",$J)) K @VBMT
 DO SET(.VBECCBK)
 SET VBECOPT=""
 DO EN^MXMLPRSE(VBECPRMS("RESULTS"),.VBECCBK,.VBECOPT)
 I $D(@VBECY@("ERROR")) D
 . D BLDERMSG^VBECRPC(.VBECPRMS,VBECY,VBMT)
 . D SENDMSG^VBECRPC(VBMT,"VBECS VistALink Client","G.VBECS INTERFACE ADMIN","VBECS VistALink Error")
 . M ^TMP("ZBNT_ERROR",$J)=@VBMT
 . K @VBMT
 Q
 ;
SET(VBECCBK) ; -- set the event interface entry points
 SET VBECCBK("STARTELEMENT")="RESELEST^VBECRPC1"
 SET VBECCBK("ENDELEMENT")="RESELEND^VBECRPC1"
 SET VBECCBK("CHARACTERS")="RESCHR^VBECRPC1"
 QUIT
 ;
RESELEST(ELE,ATR) ; -- element start event handler
 IF ELE="Response" SET VBECTYPE=$G(ATR("type")),VBECCNT=0 QUIT
 IF ELE="Message" SET VBECTYPE="fault",VBECCNT=0 QUIT
 QUIT
 ;
RESELEND(ELE) ; -- element end event handler
 KILL VBECCNT,VBECTYPE
 QUIT
 ;
RESCHR(TEXT) ; -- character value event handler
 QUIT:$G(VBECTYPE)=""
 QUIT:'$L(TEXT)  ; -- bug in parser? sends in empty string
 ;
 IF VBECCNT=0,TEXT=$C(10) QUIT  ; -- bug in parser? always starts with $C(10)
 ;
 IF VBECTYPE="string" DO  QUIT
 . SET VBECCNT=VBECCNT+1
 . SET @VBECY@(VBECCNT)=TEXT
 ;
 IF VBECTYPE="array" DO
 . SET VBECCNT=VBECCNT+1
 . SET @VBECY@(VBECCNT)=$P(TEXT,$C(10))
 ;
 IF VBECTYPE="fault" DO
 . SET VBECCNT=VBECCNT+1
 . SET @VBECY@("ERROR")=TEXT
 QUIT
 ;
PARSEX(VBECPRMS,VBECY) ; -- parse legacy rpc results ; uses DOM parser
 NEW VBECDOM
 SET VBECDOM=$$EN^MXMLDOM(VBECPRMS("RESULTS"),"")
 DO TEXT^MXMLDOM(VBECDOM,2,VBECY)
 DO DELETE^MXMLDOM(VBECDOM)
 QUIT
 ;
 ; -------------------------------------------------------------------
 ;                   Response Format Documentation
 ; -------------------------------------------------------------------
 ; 
 ;                   
 ; [ Sample XML produced by a successful call of EN^XOBRPC(.VBECPRMS). 
 ;   SEND^XOBRPC does the actual work to produce response.             ]
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
 ; [ Sample XML produced by a unsuccessful call of EN^XOBRPC(.XOBPARMS). 
 ;   ERROR^XOBRPC does the actual work to produce response.             ]
 ; 
 ; <?xml version="1.0" encoding="utf-8" ?>
 ; <vistalink type="Gov.VA..Med.RPC.Error" >
 ;    <errors>
 ;       <error code="2" uri="XOB BAD NAME" >
 ;           <msg>
 ;              Remote Procedure Unknown: 'XOB BAD NAME' cannot be found.
 ;           </msg>
 ;       </error>
 ;    </errors>
 ; </vistalink>
 ; 
 ; -------------------------------------------------------------------
 ;
