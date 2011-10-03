VBECRPCC ;HOIFO/bnt - VBECS VistALink RPC Client Utilities ;07/27/2002  13:00
 ;;1.0;VBECS;;Apr 14, 2005;Build 35
 ;
 ; Note: This routine supports data exchange with an FDA registered
 ; medical device. As such, it may not be changed in any way without
 ; prior written approval from the medical device manufacturer.
 ; 
 ; Integration Agreements:
 ;  Reference to $$GET^XPAR supported by IA #2263
 ;  Reference to $$XMLHDR^XOBVLIB supported by IA #4090
 ;
 QUIT
 ;
 ; -------------------------------------------------------------------
 ;                  RPC Client:  Methods Calls
 ; -------------------------------------------------------------------
 ;
EXECUTE(VBECPRMS) ; -- execute rpc call
 ;
 ; -- validate parmeters passed
 IF '$$VALIDATE(.VBECPRMS) QUIT 0
 ;
 ; -- call method to build request from parameters array
 DO REQUEST(.VBECPRMS)
 SET VBECPRMS("CLOSE MESSAGE")="<VistaLink messageType='gov.va.med.foundations.rpc.request' ></VistaLink>"
 IF $G(VBECPRMS("RESULTS"))="" SET VBECPRMS("RESULTS")=$NA(^TMP("VBECRPC",$J,"XML"))
 QUIT $$EXECUTE^VBECVLC(.VBECPRMS)
 ;
VALIDATE(VBECPRMS) ; -- validate parameters sent in
 ; // TODO: Do checks and build validate error message
 QUIT 1
 ;
REQUEST(VBECPRMS) ; -- build xml request
 NEW VBECLINE,VBECPI,PTYPE,VBECREQ
 SET VBECLINE=0
 SET VBECPRMS("MESSAGE TYPE")="gov.va.med.foundations.rpc.request"
 SET VBECPRMS("MODE")="singleton"
 IF $G(VBECPRMS("REQUEST"))="" SET VBECPRMS("REQUEST")=$NA(VBECPRMS("REQUEST","XML"))
 SET VBECREQ=VBECPRMS("REQUEST")
 KILL @VBECREQ
 ;
 DO ADD($$XMLHDR^XOBVLIB())
 DO ADD("<VistaLink messageType="""_$G(VBECPRMS("MESSAGE TYPE"))_""" mode="""_$G(VBECPRMS("MODE"))_""" version=""1.0"" xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance"" xsi:noNamespaceSchemaLocation=""rpcRequest.xsd"" ")
 DO ADD("xmlns=""http://med.va.gov/Foundations"">")
 DO ADD("<RpcHandler version=""1.0"" />")
 DO ADD("<Request rpcName="""_$G(VBECPRMS("RPC NAME"))_""" version=""1.0"" rpcClientTimeOut=""900"" >")
 DO ADD("<RpcContext><![CDATA["_$G(VBECPRMS("RPC CONTEXT"))_"]]></RpcContext>")
 DO ADD("<Params>")
 IF $D(VBECPRMS("PARAMS"))>9 DO
 . SET VBECPI=0
 . FOR  SET VBECPI=$O(VBECPRMS("PARAMS",VBECPI)) Q:'VBECPI  DO
 . . SET PTYPE=$G(VBECPRMS("PARAMS",VBECPI,"TYPE"))
 . . IF PTYPE="STRING" DO STRING QUIT
 . . IF PTYPE="ARRAY" DO ARRAY QUIT
 . . IF PTYPE="REF" DO REF QUIT
 DO ADD("</Params>")
 DO ADD("</Request>")
 DO ADD("</VistaLink>")
 QUIT
 ;
STRING ;
 DO ADD("<Param type=""string"" position="""_VBECPI_""" >"_$G(VBECPRMS("PARAMS",VBECPI,"VALUE"))_"</Param>")
 QUIT
 ;
ARRAY ;
 NEW VBECNAME
 DO ADD("<Param type=""array"" position="""_VBECPI_""" >")
 DO ADD("<Indices>")
 SET VBECNAME="" FOR  SET VBECNAME=$O(VBECPRMS("PARAMS",VBECPI,"VALUE",VBECNAME)) Q:VBECNAME=""  DO
 . DO ADD("<Index name="""_VBECNAME_""" value="""_$G(VBECPRMS("PARAMS",VBECPI,"VALUE",VBECNAME))_""" />")
 DO ADD("</Indices>")
 DO ADD("</Param>")
 QUIT
 ;
REF ;
 DO ADD("<Param type=""ref"" position="""_VBECPI_""" >"_$G(VBECPRMS("PARAMS",VBECPI,"VALUE"))_"</Param>")
 QUIT
 ;
ADD(STR) ; -- add string to array
 SET VBECLINE=VBECLINE+1
 SET @VBECREQ@(VBECLINE)=STR
 QUIT
 ;
INITV(RPC) ; Initialize VBECS VistALink Client parameters
 ; Input:  RPC = Parameter Toolkit Instance of RPC Name
 ; Output: VBECPRMS or -1^"error specific text" if error occurs setting any VBECPRMS parameter
 ;
 NEW ENT,PAR
 KILL VBECPRMS
 SET VBECPRMS("ERROR")=0
 IF RPC']"" DO ERR("NO RPC NAME SUPPLIED") QUIT
 ; Parameter Toolkit variables
 SET ENT="PKG.VBECS" ;Entity
 SET PAR="VBECS VISTALINK" ;Parameter
 SET VBECPRMS("ADDRESS")=$$GET^XPAR(ENT,PAR,"LISTENER IP ADDRESS","Q")
 IF VBECPRMS("ADDRESS")="" DO ERR("NO LISTENER IP ADDRESS FOUND") QUIT
 SET VBECPRMS("PORT")=$$GET^XPAR(ENT,PAR,"LISTENER PORT NUMBER","Q")
 IF VBECPRMS("PORT")="" DO ERR("NO LISTENER PORT NUMBER FOUND") QUIT
 SET VBECPRMS("RPC NAME")=RPC
 SET VBECPRMS("RPC CONTEXT")=$$GET^XPAR(ENT,PAR,RPC,"Q")
 IF VBECPRMS("RPC CONTEXT")="" DO ERR("UNABLE TO RETRIEVE RPC CONTEXT FOR "_RPC) QUIT
 QUIT
 ;
CHGADPRT(IP,PORT) ; Change the IP Address and Port of the VBECS VistALink Listner
 NEW ERR,ENT,PAR
 SET ENT="PKG.VBECS" ; Entity
 SET PAR="VBECS VISTALINK" ; Parameter
 IF IP]"" DO
 . DO EN^XPAR(ENT,PAR,"LISTENER IP ADDRESS",IP,.ERR)
 . IF ERR QUIT
 ;
 IF PORT]"" DO
 . DO EN^XPAR(ENT,PAR,"LISTENER PORT NUMBER",PORT,.ERR)
 . IF ERR QUIT
 QUIT ERR
 ;
CONTEXT(INSTANCE,CONTEXT) ; Adds, or changes, an RPC Instance and
 ; it's associated context
 ; Set CONTEXT to "@" to delete the instance of the RPC.
 ;
 NEW ERR,ENT,PAR
 SET ENT="PKG.VBECS" ; Entity
 SET PAR="VBECS VISTALINK" ; Parameter
 DO EN^XPAR(ENT,PAR,INSTANCE,CONTEXT,.ERR)
 QUIT ERR
 ;
ERR(ERRTXT) ; Set VBECPRMS("ERROR") node with error text and quit
 S VBECPRMS("ERROR")="1^"_ERRTXT
 QUIT
 ;
 ; -------------------------------------------------------------------
 ;                   Request Format Documentation
 ; -------------------------------------------------------------------
 ; 
 ; [ Parameter Array Format -->> passed to REQUEST^VBECRPCC(.VBECPRMS) ] 
 ; 
 ; -- general information
 ; VBECPRMS("ADDRESS")="10.3.21.12"
 ; VBECPRMS("PORT")=19811
 ; VBECPRMS("RPC NAME")="VBECS Order Entry"
 ; VBECPRMS("RPC CONTEXT")="VBECS VISTALINK CONTEXT"
 ;
 ; -- string parameter type
 ; VBECPRMS("PARAMS",1,"TYPE")="STRING"
 ; VBECPRMS("PARAMS",1,"VALUE")=2
 ; VBECPRMS("PARAMS",2,"TYPE")="STRING"
 ; VBECPRMS("PARAMS",2,"VALUE")=2961001
 ; VBECPRMS("PARAMS",3,"TYPE")="STRING"
 ; VBECPRMS("PARAMS",3,"VALUE")=3030101
 ;
 ; -- sample array parameter type
 ; VBECPRMS("PARAMS",4,"TYPE")="ARRAY"
 ; VBECPRMS("PARAMS",4,"VALUE","FNAME")="JOE"
 ; VBECPRMS("PARAMS",4,"VALUE","LNAME")="GOODMAN"
 ;                   
 ; -------------------------------------------------------------------
 ;                   
 ; [ Sample XML produced by calling REQUEST^VBECRPCC(.VBECPRMS) ]
 ; 
 ; <?xml version="1.0" encoding="utf-8" ?>
 ; <VistaLink type="gov.va.med.foundations.rpc.request" mode="singleton" 
 ;   version="1.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 ;   xsi:noNamespaceSchemaLocation="rpcRequest.xsd"
 ;   xmlns="http://med.va.gov/Foundations">
 ;   <RpcHandler version="1.0" />
 ;   <Request rpcName="VBECS Order Entry" version="1.0"
 ;     rpcClientTimeOut="900">
 ;      <RpcContext>
 ;        <![CDATA[ VBECS VISTALINK ]]>
 ;      </RpcContext>
 ;      <Params>
 ;         <Param type="string" position="1" >2</Param>
 ;         <Param type="string" position="2" >2961001</Param>
 ;         <Param type="string" position="3" >3030101</Param>
 ;         <Param type="array" position="4" >
 ;            <Indices>
 ;               <Index name="status" value="veteran" />
 ;               <Index name="gender" value="male" />
 ;            </Indices>
 ;         </Param>
 ;      </Params>
 ;   </Request>
 ; </VistaLink>
 ;
 ; -------------------------------------------------------------------
 ;
