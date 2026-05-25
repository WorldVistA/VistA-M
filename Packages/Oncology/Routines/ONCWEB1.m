ONCWEB1 ;ALBANY OIFO/RVD - VACCR WEB SERVICE ;Nov 4, 2022@14:22:22
 ;;2.2;ONCOLOGY;**16,19,20,21,22**;Aug 1,2022;Build 6
 ;
 ; SAC EXEMPTION 202408071458-03 : non-ANSI standard M code
 ;
 Q
 ;
 ; EDITS CLOUD SERVER CALLS
 ;
T3 ;Edits call to HWSC
 N RESPONSE,ONCHR,ONCSYS,ONCTMP S (ONCTMP,RESPONSE)=""
 S ONCSYS=$$PROD^XUPROD() ;1=PROD, 0=PRE=PROD
 S ONCHR=$NA(^TMP($J,"ONCXML"))
 S:'$D(ONCWEB) ONCWEB="ONCO WEB SERVER"
 S:'$D(ONCSERV) ONCSERV="ONCO VACCR WEB SERVICE"
 S TIME=$$HTE^XLFDT($H,7)
 S TIME=$TR(TIME,"@","T")
 S SITE=+$P($$SITE^VASITE(),"^",3)
 S ONCHAND="OncoTrax Cloud XML Encryption"
 I $G(ONCEXEC)="P" W !," Calling Web Service..."
 ;globalName must be cleaned before a case set-up & deleted after done posting
 N globalName S globalName=$NA(^TMP("ONC",$J))
 S RESPONSE=$$PPOST3(ONCHAND,$G(ONCHR),globalName)
 I RESPONSE=0 S ONCTMP=^TMP($JOB,"OUT","EXCEPTION")
 ;RESPONSE = server message back
 Q
PPOST3(ONCHAND,XML,globalName) ;POST request
 ; @DESC Sends an HTTP request to SERVER as a POST or GET
 ; @ONCHAND Handle to XML document
 ; @XML XML request as string
 ; @globalName the name of global to use
 ; @RESPONSE A handle to response XML document
 ;           1 for success, 0 for failure
 N ONC,ONCERR,$ETRAP,$ESTACK,ONCFERR
 S:'$D(ONCWEB) ONCWEB="ONCO WEB SERVER"
 S:'$D(ONCSERV) ONCSERV="ONCO VACCR WEB SERVICE"
 S ONC("Ocp-Apim-Subscription-Key")="d27e1428f71e47239327d7e77e1439c6"
 ; Set error trap
 S $ETRAP="D ERROR^ONCWEB1"
 S ONC("server")=ONCWEB
 S ONC("webserviceName")=ONCSERV
 ;
 K ^TMP($JOB,"OUT","EXCEPTION")
 ; Get instance of client REST request object
 ;
 S ONC("restObject")=$$GETREST^XOBWLIB(ONC("webserviceName"),ONC("server"))
 ;W !,"REST OBJECT= ",ONC("restObject")
 I $DATA(^TMP($JOB,"OUT","EXCEPTION"))>0 Q 0
 ;
 N xmlString S xmlString=""
 N XMLQUIT S XMLQUIT="^TMP(""ONC"","_$J
 F  D  Q:globalName'[XMLQUIT
 . S xmlString=xmlString_$G(@globalName,"")
 . S globalName=$Q(@globalName)
 D ONC("restObject").EntityBody.Write(xmlString)
 ;
 I $DATA(^TMP($JOB,"OUT","EXCEPTION"))>0 Q 0
 ; Execute HTTP Post method ($$POST^XOBWLIB) or Get method ($$GET^XOBWLIB)
 I $G(ONCEXEC)="G" D
 .;S:ONCSYS=0 ONC("path")="/development1/api/RunEdit/GetVersion"
 .S:ONCSYS=0 ONC("path")="/ppd/api/RunEdit/GetVersion"
 .;S:ONCSYS=1 ONC("path")="/development1/api/RunEdit/GetVersion"
 .S:ONCSYS=1 ONC("path")="/prda/api/RunEdit/GetVersion"
 .S ONC("Content-Type")="application/json"
 .S ONC("restObject").ContentType="application/json"
 .S ONC("postResult")=$$GET^XOBWLIB(ONC("restObject"),ONC("path"),.ONCERR)
 I $G(ONCEXEC)="P" D
 .;S:ONCSYS=0 ONC("path")="/development1/api/RunEdit/VaccrProcessCaseFile"
 .S:ONCSYS=0 ONC("path")="/ppd/api/RunEdit/VaccrProcessCaseFile"
 .;S:ONCSYS=1 ONC("path")="/development1/api/RunEdit/VaccrProcessCaseFile"
 .S:ONCSYS=1 ONC("path")="/prda/api/RunEdit/VaccrProcessCaseFile"
 .S ONC("Content-Type")="application/xml"
 .S ONC("restObject").ContentType="application/xml"
 .S ONC("postResult")=$$POST^XOBWLIB(ONC("restObject"),ONC("path"),.ONCERR)
 K ONCEXEC
 ;W !,"Post method...",!,"ERROR...= ",$G(ONCERR, "NONE")
 ;
 N stream s stream=##class(%Stream.TmpCharacter).%New()
 d stream.CopyFrom(ONC("restObject").HttpResponse.Data)
 ;
 n result s result=""
 N ONC1 S ONC1=1
 f  q:stream.AtEnd=1  d
 . S ^TMP("ONCSED01R",$J,ONC1)=stream.ReadLine()
 . S ONC1=ONC1+1
 I $DATA(^TMP($JOB,"OUT","EXCEPTION"))>0 Q 0
 D:'ONC("postResult")
 . S ^TMP($JOB,"OUT","EXCEPTION")="Unable to make http request."
 . S ONC("result")=0
 . Q
 Q result
 ;
TCS ;Collaborative Stage call to HWSC
 N RESPONSE,ONCHR,ONCSYS,ONCTMP S (ONCTMP,RESPONSE)=""
 S ONCSYS=$$PROD^XUPROD() ;1=PROD, 0=PRE=PROD
 S ONCHR=$NA(^TMP($J,"ONCXML"))
 S:'$D(ONCWEB) ONCWEB="ONCO WEB SERVER"
 S:'$D(ONCSERV) ONCSERV="ONCO VACCR WEB SERVICE"
 S TIME=$$HTE^XLFDT($H,7)
 S TIME=$TR(TIME,"@","T")
 S SITE=+$P($$SITE^VASITE(),"^",3)
 S ONCHAND="OncoTrax Calculate Collaborative Stage Cloud Server"
 W !," Call Web Service to calculate CS..."
 ;globalName must be cleaned before a case set-up & deleted after done posting
 N globalName S globalName=$NA(^TMP("ONCINPUT",$J))
 S RESPONSE=$$PPOSTCS(ONCHAND,$G(ONCHR),globalName)
 I RESPONSE=0 S ONCTMP=^TMP($JOB,"OUT","EXCEPTION")
 ;RESPONSE = server message back
 Q
PPOSTCS(ONCHAND,XML,globalName) ;POST request
 ; @DESC Sends an HTTP request to SERVER as a POST or GET
 ; @ONCHAND Handle to XML document
 ; @XML XML request as string
 ; @globalName the name of global to use
 ; @RESPONSE A handle to response XML document
 ;           1 for success, 0 for failure
 N ONC,ONCERR,$ETRAP,$ESTACK,ONCFERR
 S:'$D(ONCWEB) ONCWEB="ONCO WEB SERVER"
 S:'$D(ONCSERV) ONCSERV="ONCO VACCR WEB SERVICE"
 ; Set error trap
 S $ETRAP="D ERROR^ONCWEB1"
 S ONC("server")=ONCWEB
 S ONC("webserviceName")=ONCSERV
 ;
 K ^TMP($JOB,"OUT","EXCEPTION")
 ; Get instance of client REST request object
 ;
 S ONC("restObject")=$$GETREST^XOBWLIB(ONC("webserviceName"),ONC("server"))
 ;W !,"REST OBJECT= ",ONC("restObject")
 I $DATA(^TMP($JOB,"OUT","EXCEPTION"))>0 Q 0
 ;
 N xmlString S xmlString=""
 N XMLQUIT S XMLQUIT="^TMP(""ONCINPUT"","_$J
 F  D  Q:globalName'[XMLQUIT
 . S xmlString=xmlString_$G(@globalName,"")
 . S globalName=$Q(@globalName)
 D ONC("restObject").EntityBody.Write(xmlString)
 ;
 I $DATA(^TMP($JOB,"OUT","EXCEPTION"))>0 Q 0
 ; Execute HTTP Post method ($$POST^XOBWLIB) or Get method ($$GET^XOBWLIB)
 I $G(ONCEXEC)="G" D
 .;S:ONCSYS=0 ONC("path")="/development1/api/RunEdit/GetVersion"
 .S:ONCSYS=0 ONC("path")="/ppd/api/RunEdit/GetVersion"
 .;S:ONCSYS=1 ONC("path")="/development1/api/RunEdit/GetVersion"
 .S:ONCSYS=1 ONC("path")="/prda/api/RunEdit/GetVersion"
 .S ONC("Content-Type")="application/json"
 .S ONC("restObject").ContentType="application/json"
 .S ONC("postResult")=$$GET^XOBWLIB(ONC("restObject"),ONC("path"),.ONCERR)
 I $G(ONCEXEC)="P" D
 .;S:ONCSYS=0 ONC("path")="/development1/api/RunEdit/VaccrProcessCStageCalculate"
 .S:ONCSYS=0 ONC("path")="/ppd/api/RunEdit/VaccrProcessCStageCalculate"
 .;S:ONCSYS=1 ONC("path")="/development1/api/RunEdit/VaccrProcessCStageCalculate"
 .S:ONCSYS=1 ONC("path")="/prda/api/RunEdit/VaccrProcessCStageCalculate"
 .S ONC("Content-Type")="application/xml"
 .S ONC("restObject").ContentType="application/xml"
 .S ONC("postResult")=$$POST^XOBWLIB(ONC("restObject"),ONC("path"),.ONCERR)
 K ONCEXEC
 ;W !,"Post method...",!,"ERROR...= ",$G(ONCERR, "NONE")
 ;
 N stream s stream=##class(%Stream.TmpCharacter).%New()
 d stream.CopyFrom(ONC("restObject").HttpResponse.Data)
 ;
 n result s result=""
 N ONC1 S ONC1=1
 f  q:stream.AtEnd=1  d
 . S ^TMP("ONCCSRSP",$J,ONC1)=stream.ReadLine()
 . S ONC1=ONC1+1
 I $DATA(^TMP($JOB,"OUT","EXCEPTION"))>0 Q 0
 D:'ONC("postResult")
 . S ^TMP($JOB,"OUT","EXCEPTION")="Unable to make http request."
 . S ONC("result")=0
 . Q
 Q result
 ;
 ;
ERROR ;
 ; @DESC Handles error during request to DC SERVER via webservice.
 ; Depends on GLOBAL variable ONCERR to be set in previous call.
 ; @RETURNS Nothing. Value store in global.
 N ERRARRAY
 ; Get error object from Error Object Factory
 I $GET(ONCERR)="" SET ONCERR=$$EOFAC^XOBWLIB()
 ; Store the error object in the error array
 D ERR2ARR^XOBWLIB(ONCERR,.ERRARRAY)
 ; Parse out the error text and store in global
 S ^TMP($JOB,"OUT","EXCEPTION")=$$GETTEXT(.ERRARRAY)
 ; Set ecode to empty to return to calling function
 S $ECODE=""
 Q
 ;
GETTEXT(ERRARRAY) ;
 ; @DESC Gets the error text from the array
 ; @ERRARRAY Error array stores error in format defined by web service product.
 ; @RETURNS Error info as a single string
 N ONC
 ; Loop through the text subscript of error array and concatenate
 S ONC("errorText")=""
 S ONC("I")=""
 F  S ONC("I")=$ORDER(ERRARRAY("text",ONC("I"))) QUIT:ONC("I")=""  D
 . SET ONC("errorText")=ONC("errorText")_ERRARRAY("text",ONC("I"))
 . Q
 Q ONC("errorText")
