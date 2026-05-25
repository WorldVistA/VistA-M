ONCWEB2 ;ALBANY OIFO/RTK - VACCR WEB SERVICE ;Feb 14, 2024@14:22:22
 ;;2.2;ONCOLOGY;**19,20,21,22**;Aug 1,2022;Build 6
 ;
 ; SAC EXEMPTION 202408071458-03 : non-ANSI standard M code
 ;
 Q
 ;
 ; COLLABORATIVE STAGE CLOUD SERVER CALLS
 ; MODIFIED FROM ONCWEB1
 ;
 ;
T3 ;Collaborative Stage call to HWSC
 N RESPONSE,ONCHR,ONCSYS,ONCTMP S (ONCTMP,RESPONSE)=""
 S ONCSYS=$$PROD^XUPROD() ;1=PROD, 0=PRE=PROD
 K ^TMP("ONCSCRSP",$J),^TMP("ONCTBRSP",$J)
 S ONCHR=$NA(^TMP($J,"ONCXML"))
 S:'$D(ONCWEB) ONCWEB="ONCO WEB SERVER"
 S:'$D(ONCSERV) ONCSERV="ONCO VACCR WEB SERVICE"
 S TIME=$$HTE^XLFDT($H,7)
 S TIME=$TR(TIME,"@","T")
 S SITE=+$P($$SITE^VASITE(),"^",3)
 S ONCHAND="OncoTrax Cloud xml Encryption"
 ;W !," Calling Web Service..."
 ;globalName must be cleaned before a case set-up & deleted after done posting
 I $G(ONCCSRQT)="SCHEMA" N globalName S globalName=$NA(^TMP("ONCCSCMA",$J))
 I $G(ONCCSRQT)="TABLE" N globalName S globalName=$NA(^TMP("ONCCSTBL",$J))
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
 I $G(ONCCSRQT)="SCHEMA" N XMLQUIT S XMLQUIT="^TMP(""ONCCSCMA"","_$J
 I $G(ONCCSRQT)="TABLE" N XMLQUIT S XMLQUIT="^TMP(""ONCCSTBL"","_$J
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
 .I $G(ONCCSRQT)="SCHEMA" D
 ..;S:ONCSYS=0 ONC("path")="/development1/api/RunEdit/VaccrProcessIsSchemaRecordComplete"
 ..S:ONCSYS=0 ONC("path")="/ppd/api/RunEdit/VaccrProcessIsSchemaRecordComplete"
 ..;S:ONCSYS=1 ONC("path")="/development1/api/RunEdit/VaccrProcessIsSchemaRecordComplete"
 ..S:ONCSYS=1 ONC("path")="/prda/api/RunEdit/VaccrProcessIsSchemaRecordComplete"
 .I $G(ONCCSRQT)="TABLE" D
 ..;S:ONCSYS=0 ONC("path")="/development1/api/RunEdit/VaccrProcessIsTableRecordComplete"
 ..S:ONCSYS=0 ONC("path")="/ppd/api/RunEdit/VaccrProcessIsTableRecordComplete"
 ..;S:ONCSYS=1 ONC("path")="/development1/api/RunEdit/VaccrProcessIsTableRecordComplete"
 ..S:ONCSYS=1 ONC("path")="/prda/api/RunEdit/VaccrProcessIsTableRecordComplete"
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
 . I $G(ONCCSRQT)="SCHEMA" S ^TMP("ONCSCRSP",$J,ONC1)=stream.ReadLine()
 . I $G(ONCCSRQT)="TABLE" S ^TMP("ONCTBRSP",$J,ONC1)=stream.ReadLine()
 . S ONC1=ONC1+1
 I $DATA(^TMP($JOB,"OUT","EXCEPTION"))>0 Q 0
 D:'ONC("postResult")
 . S ^TMP($JOB,"OUT","EXCEPTION")="Unable to make http request."
 . S ONC("result")=0
 . Q
 Q result
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
