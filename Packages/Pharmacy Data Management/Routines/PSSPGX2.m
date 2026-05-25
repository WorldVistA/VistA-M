PSSPGX2 ;BIR/MV - PHARMACOGENOMICS API CONTINUE ;09/20/07
 ;;1.0;PHARMACY DATA MANAGEMENT;**262**;9/30/97;Build 66
 ;
 ; Reference to ^MXMLDOM is supported by DBIA #3561
 ;
 ;POST is cloned from PEPSPOST^PSSHTTP
POST(DOCHAND,PSSXML,PSSWS) ; post the XML request to PEPS server and return the routes
 ; PSSXML: XML request (header and input data...)
 ; PSSWS : An array
 ;   PSSWS("SERVICE_NAME") - Webservice name. Ex: "PGX_ORDER_CHECKS"
 ;   PSSWS("PATH") - Ex: "pgxwarning"
 ;   PSSWS("SERVER") - the server name. Ex: "PEPS"
 ; output: PSSOUT - array containing the list of route names for the given drug.
 ;
 ; @DESC Sends an HTTP request to PEPS as a POST
 ;
 ; @DOCHAND Handle to XML document
 ; @XML XML request as string
 ;
 ; @RETURNS A handle to response XML document
 ;          1 for success, 0 for failure
 ;
 NEW PSS,PSSERR,$ETRAP,$ESTACK
 ;
 I ($G(PSSWS("SERVER"))="")!($G(PSSWS("SERVICE_NAME"))="")!($G(PSSWS("PATH"))="") S PSSOUT(0)="-1^Either the Server name or Path is missing" Q 0
 ; Set error trap
 SET $ETRAP="DO ERROR^PSSHTTP"
 ;
 SET PSS("server")=PSSWS("SERVER")
 SET PSS("webserviceName")=PSSWS("SERVICE_NAME")
 SET PSS("path")=PSSWS("PATH")
 SET PSS("parameterName")="xmlRequest"
 SET PSS("parameterValue")=PSSXML
 ; Get instance of client REST request object
 SET PSS("restObject")=$$GETREST^XOBWLIB(PSS("webserviceName"),PSS("server"))
 IF $DATA(^TMP($JOB,"OUT","EXCEPTION"))>0 QUIT 0
 ;
 ; Insert XML as parameter
 DO PSS("restObject").InsertFormData(PSS("parameterName"),PSS("parameterValue"))
 IF $DATA(^TMP($JOB,"OUT","EXCEPTION"))>0 QUIT 0
 ;
 ; Execute HTTP Post method
 SET PSS("postResult")=$$POST^XOBWLIB(PSS("restObject"),PSS("path"),.PSSERR)
 IF $DATA(^TMP($JOB,"OUT","EXCEPTION"))>0 QUIT 0
 ;
 DO:PSS("postResult")
 . SET PSS("result")=##class(gov.va.med.pre.ws.XMLHandler).getHandleToXmlDoc(PSS("restObject").HttpResponse.Data,.DOCHAND)
 . QUIT
 ;
 DO:'PSS("postResult")
 . SET ^TMP($JOB,"OUT","EXCEPTION")="Unable to make http request."
 . SET PSS("result")=0
 . QUIT
 ;
 QUIT PSS("result")
