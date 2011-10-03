XWBVL ;OIFO-Oakland/REM - M2M Broker Server Link Utl  ;05/17/2002  17:46
 ;;1.1;RPC BROKER;**28**;Mar 28, 1997
 ;
 QUIT
 ;
START(PORT) ; -- start listener
 ; // TODO: Add checks and structure to not start listener if already active on port
 DO START^XWBVLL(PORT)
 QUIT
 ;
 ; ---------------------------------------------------------------------
 ;                  Close Socket:  Methods Calls
 ; ---------------------------------------------------------------------
 ; 
EXECUTE(XWBPARMS) ; -- execute rpc call
 NEW STATUS
 IF $G(XWBPARMS("RESULTS"))="" SET XWBPARMS("RESULTS")=$NA(^TMP("XWB CLOSE SOCKET",$J,"XML"))
 SET STATUS=$$EXECUTE^XWBVLC(.XWBPARMS)
 QUIT STATUS
 ; 
REQUEST(XWBPARMS) ; -- build xml request
 NEW XWBLINE
 SET XWBLINE=0
 SET XWBPARMS("MESSAGE TYPE")="Gov.VA.Med.Foundations.CloseSocketRequest"
 IF $G(XWBPARMS("REQUEST"))="" SET XWBPARMS("REQUEST")=$NA(XWBPARMS("REQUEST","XML"))
 SET XWBREQ=XWBPARMS("REQUEST")
 KILL @XWBREQ
 ;
 ; -- build request
 DO ADD($$XMLHDR^XWBUTL())
 DO ADD("<vistalink type="""_$G(XWBPARMS("MESSAGE TYPE"))_"""/>")
 QUIT
 ;
ADD(STR) ; -- add string to array
 SET XWBLINE=XWBLINE+1
 SET @XWBREQ@(XWBLINE)=STR
 QUIT
 ;
RESPONSE() ; -- build xml response
 ; -- initialize
 DO PRE^XWBRL
 DO WRITE^XWBRL($$XMLHDR^XWBUTL())
 DO WRITE^XWBRL("<vistalink type=""Gov.VA.Med.Foundations.CloseSocketResponse"">")
 DO WRITE^XWBRL("<results success=""1"" />")
 DO WRITE^XWBRL("</vistalink>")
 ; -- send eot and flush buffer
 DO POST^XWBRL
 QUIT
 ;
 ; ---------------------------------------------------------------------
 ;                Parse Results of Successful RPC Request
 ; ---------------------------------------------------------------------
 ;
PARSE(XWBPARMS,XWBY) ; -- parse legacy rpc results ; uses DOM parser
 NEW XWBDOM
 SET XWBDOM=$$EN^MXMLDOM(XWBPARMS("RESULTS"),"")
 SET @XWBY=$$VALUE^MXMLDOM(XWBDOM,2,"success")
 DO DELETE^MXMLDOM(XWBDOM)
 QUIT
 ;
