PSSHTTP ;WOIFO/AV - REENGINERING Sends XML Request to PEPS via HWSC ;09/20/07
 ;;1.0;PHARMACY DATA MANAGEMENT;**136**;9/30/97;Build 89
 ;
 ; @author  - Alex Vazquez, Chris Flegel, Timothy Sabat, S Gordon
 ; @date    - September 19, 2007
 ; @version - 1.0
 ;
 QUIT
 ;;
PEPSPOST(DOCHAND,XML) ;
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
 ; Set error trap
 SET $ETRAP="DO ERROR^PSSHTTP"
 ;
 SET PSS("server")="PEPS"
 SET PSS("webserviceName")="ORDER_CHECKS"
 SET PSS("path")="ordercheck"
 ;
 SET PSS("parameterName")="xmlRequest"
 SET PSS("parameterValue")=XML
 ;
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
 . SET PSS("result")=##class(gov.va.med.pre.ws.XMLHandler).getHandleToXmlDoc(PSS("restObject").HttpResponse.Data, .DOCHAND)
 . QUIT
 ;
 DO:'PSS("postResult")
 . SET ^TMP($JOB,"OUT","EXCEPTION")="Unable to make http request."
 . SET PSS("result")=0
 . QUIT
 ;
 QUIT PSS("result")
 ;;
ERROR ;
 ; @DESC Handles error during request to PEPS via webservice.
 ;
 ; Depends on GLOBAL variable PSSERR to be set in previous call.
 ;
 ; @RETURNS Nothing. Value store in global.
 ;
 NEW ERRARRAY
 ;
 ; Get error object from Error Object Factory
 IF $GET(PSSERR)="" SET PSSERR=$$EOFAC^XOBWLIB()
 ; Store the error object in the error array
 DO ERR2ARR^XOBWLIB(PSSERR,.ERRARRAY)
 ;
 ; Parse out the error text and store in global
 SET ^TMP($JOB,"OUT","EXCEPTION")=$$GETTEXT(.ERRARRAY)
 ;
 ; Set ecode to empty to return to calling function
 SET $ECODE=""
 ;
 QUIT
 ;;
GETTEXT(ERRARRAY) ;
 ; @DESC Gets the error text from the array
 ;
 ; @ERRARRAY Error array stores error in format defined by web service product.
 ;
 ; @RETURNS Error info as a single string
 ;
 NEW PSS
 ;
 ; Loop through the text subscript of error array and concatenate
 SET PSS("errorText")=""
 SET PSS("I")=""
 FOR  SET PSS("I")=$ORDER(ERRARRAY("text",PSS("I"))) QUIT:PSS("I")=""  DO
 . SET PSS("errorText")=PSS("errorText")_ERRARRAY("text",PSS("I"))
 . QUIT
 ;
 QUIT PSS("errorText")
 ;;
