PSNPPSNC ;HP/SXT-PPSN update NDF data ; 05 Mar 2014  1:20 PM
 ;;4.0;NATIONAL DRUG FILE;**513**; 30 Oct 98;Build 53
 ;
 ; taken mostly from: PSSHTTP ;WOIFO/AV - REENGINERING Sends XML Request to PEPS via HWSC ;09/20/07
 ;
 Q
 ;;
 ;
SEND(STATUS,VERSION,MESSAGE) ;
 ;
 NEW TIME,SITE,XML,OK,DOCHAND
 ;TIME FORMAT:  yyyy/mm/ddThh:mm:ss i.e. - 2014/3/24T13:20:27
 S TIME=$$HTE^XLFDT($H,7)
 S TIME=$TR(TIME,"@","T")
 S SITE=$P($$SITE^VASITE(),"^")
 S XML="<vistaUpdateStatus><message>"_MESSAGE_"</message><site>"_SITE_"</site><status>"_STATUS_"</status>"
 S XML=XML_"<timeApplied>"_TIME_"</timeApplied><version>"_VERSION_"</version></vistaUpdateStatus>"
 S OK=$$PPSNPOST(.DOCHAND,XML)
 Q:'OK 0
 Q 1
 ; 
TEST ;
 S X=$$SEND("STARTED","PPS_1PRV_11NEW.DAT","")
 W !,$S(X:"Sent",1:"Failed")
 Q
 ;
 N RESPONSE,X S (X,RESPONSE)=""
 S XML="<vistaUpdateStatus><message></message><site>512</site><status>STARTED</status>"
 S XML=XML_"<timeApplied>2014-02-25T19:32:39.911-05:00</timeApplied><version>PPS_0PRV_6NEW.DAT</version></vistaUpdateStatus>"
 ;S XML=XML_"<vistaUpdateStatus><version>PPS_5PRV_6NEW.DAT</version><site>512</site><status>COMPLETED</status><message></message></vistaUpdateStatus"
 S X="TEST"
 U 0 W !,"calling function"
 S RESPONSE=$$PPSNPOST(.X,XML)
 Q
 ;
PPSNPOST(DOCHAND,XML) ;
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
 SET $ETRAP="DO ERROR^PSNPPSNC"
 ;
 SET PSS("server")="PPSN"
 ;SET PSS("server")="TIM" ;DEBUG
 SET PSS("webserviceName")="UPDATE_STATUS"
 SET PSS("path")="status"
 ;
 SET PSS("parameterName")="xmlRequest"
 SET PSS("parameterValue")=XML
 K ^TMP($JOB,"OUT","EXCEPTION")
 ;
 ; Get instance of client REST request object
 ;***W !,"get instance"
 SET PSS("restObject")=$$GETREST^XOBWLIB(PSS("webserviceName"),PSS("server"))
 IF $DATA(^TMP($JOB,"OUT","EXCEPTION"))>0 QUIT 0
 ;
 ; Insert XML as parameter
 ;*** W !,"insert XML parameter"
 DO PSS("restObject").InsertFormData(PSS("parameterName"),PSS("parameterValue"))
 IF $DATA(^TMP($JOB,"OUT","EXCEPTION"))>0 QUIT 0
 ;
 ; Execute HTTP Post method
 ;***W !,"execute POST ?" R Z I Z'="Y" B
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
