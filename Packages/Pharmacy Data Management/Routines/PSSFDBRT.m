PSSFDBRT ;WOIFO/PO - Sends XML Request to PEPS via HWSC ;09/20/07
 ;;1.0;PHARMACY DATA MANAGEMENT;**136,160,201**;9/30/97;Build 25
 ;
 ; Reference to ^PSNDF(50.68 is supported by DBIA #3735
 ; Reference to ^MXMLDOM is supported by DBIA #3561
 ;
 Q
GROUTE(PSSIEN,PSSOUT) ; get the routes for given drug ien in drug file from PESPS via HWSC
 ;  input: drug IEN from drug file (#50)
 ; output: PSSOUT - array containing the list of route names for the given drug.
 ;             e.g.  error/exception:  PSSOUT(0)= (-1 for database cannot be reached, 0 for exceptions or 1 for successfull call) ^ error or exception message 
 ;
 ;                    e.g. successfull:  PSSOUT(0)=1
 ;                                                PSSOUT("CONTINUOUS INFUSION")=""
 ;                                                PSSOUT("INTRAOSSEOUS")=""
 ;  if for any reason can not get the route, it kills the PSSOUT
 ;
 N PSSXML,GCNSEQ,BASE,PSSRETR1
 S BASE=$T(+0)_" GROUTE"
 S GCNSEQ=$$DRUGGCN(PSSIEN)    ; get the GCN sequence number.
 I GCNSEQ=0 S PSSOUT(0)="-1^GCN sequence number is not defined." Q  ; no GCN sequence number
 S PSSXML=$$BLDXML(GCNSEQ)   ; build the xml request
RETRY ;retry line tag
 D POST(PSSXML,.PSSOUT)    ; post the request and process the results
 I '$G(PSSRETR1),$P($G(PSSOUT(0)),"^")=-1 K PSSOUT S PSSRETR1=1 H 3 G RETRY
 Q
 ;
DRUGGCN(DRGIEN) ; for given drug ien return the GCN sequence number.
 ;  input: drug IEN from drug file (#50)
 ; output: returns the GCN sequence number
 ;
 N GCN,VAPROD
 S GCN=0  ; default
 D
 .S VAPROD=$P($G(^PSDRUG(+DRGIEN,"ND")),U,3) Q:'VAPROD
 .S GCN=+$P($G(^PSNDF(50.68,+VAPROD,1)),U,5)
 Q GCN
 ;
BLDXML(GCNSEQ) ; build and return the XML request with drug information for given GCN sequence number
 ;  input: drug GCN from national drug file (#50.68)
 ; output: returns the XML request for given GCN sequence number
 ;
 N PSSXML,DRUGIEN,DRUGTAG,ENDTAG
 S PSSXML=""
 D GETHEAD(.PSSXML)
 D GETREQ(.PSSXML)
 S DRUGTAG="<drug "
 S ENDTAG="/>"
 S PSSXML=PSSXML_DRUGTAG_$$ATRIBUTE^PSSHRCOM("gcnSeqNo",GCNSEQ)_ENDTAG
 D ENDREQ(.PSSXML)
 Q PSSXML
 ;
POST(XML,PSSOUT) ; post the XML request to PEPS server and return the routes
 ;  input: XML request
 ; output: PSSOUT - array containing the list of route names for the given drug.
 ;
 N PSS,PSSERR,PSSFDBRT S PSSFDBRT=1
 N $ETRAP,$ESTACK
 ; Set error trap
 SET $ETRAP="DO ERROR^PSSHTTP"
 K ^TMP($J,"OUT")    ; if exists from previous runs, posting would not execute.
 ;
 SET PSS("server")="PEPS"
 SET PSS("webserviceName")="DRUG_INFO"
 SET PSS("path")="druginfo"
 SET PSS("parameterName")="xmlRequest"
 SET PSS("parameterValue")=XML
 ;
 ; get instance of client REST request object
 SET PSS("restObject")=$$GETREST^XOBWLIB(PSS("webserviceName"),PSS("server"))
 IF $DATA(^TMP($JOB,"OUT","EXCEPTION"))>0 S PSSOUT(0)="-1^"_^TMP($JOB,"OUT","EXCEPTION") K ^TMP($JOB,"OUT","EXCEPTION") Q PSSOUT
 ;
 ; insert XML as parameter
 DO PSS("restObject").InsertFormData(PSS("parameterName"),PSS("parameterValue"))
 IF $DATA(^TMP($JOB,"OUT","EXCEPTION"))>0 S PSSOUT(0)="-1^"_^TMP($JOB,"OUT","EXCEPTION") K ^TMP($JOB,"OUT","EXCEPTION") QUIT PSSOUT
 ;
 ; execute HTTP Post method
 SET PSS("postResult")=$$POST^XOBWLIB(PSS("restObject"),PSS("path"),.PSSERR)
 IF $DATA(^TMP($JOB,"OUT","EXCEPTION"))>0 S PSSOUT(0)="-1^"_^TMP($JOB,"OUT","EXCEPTION") K ^TMP($JOB,"OUT","EXCEPTION") QUIT PSSOUT
 ;
 ; error handling
 DO:'PSS("postResult")
 . SET PSSOUT(0)=-1_U_"Unable to make http request."
 . SET PSS("result")=0
 . QUIT
 ;
 ; if every thing is ok parse the returned xml result
 D:PSS("postResult")
 .S PSS("result")=##class(gov.va.med.pre.ws.XMLHandler).getHandleToXmlDoc(PSS("restObject").HttpResponse.Data, .DOCHAND) 
 .S PSSOUT(0)=0 ; this will be set to 1 if non-null route text value(s) are found in line tag PARSRTE
 .D PARSXML(DOCHAND,.PSSOUT)
 .Q
 ; Clean up after using the handle
 D DELETE^MXMLDOM(DOCHAND)
 K ^TMP($J,"OUT XML")
 Q PSS("result")
 ;
PARSXML(DOCHAND,PSSOUT) ; read result
 ; @DOCHAND = Handle to XML Document
 ; @PSSOUT  = output array
 S PSS("rootName")=$$NAME^MXMLDOM(DOCHAND,1)
 S PSS("child")=0
 F  S PSS("child")=$$CHILD^MXMLDOM(DOCHAND,1,PSS("child")) Q:PSS("child")=0  D 
 .S PSS("childName")=$$NAME^MXMLDOM(DOCHAND,PSS("child"))
 .D:PSS("childName")="drug" PARSDRUG(DOCHAND,PSS("child"),.PSSOUT)
 Q
 ;
PARSDRUG(DOCHAND,NODE,PSSOUT) ; read drug element
 ; @DOCHAND = Handle to XML Document
 ; @NODE    = Document node
 ; @PSSOUT  = output array
 N PSS
 S PSS("child")=0
 F  S PSS("child")=$$CHILD^MXMLDOM(DOCHAND,NODE,PSS("child")) Q:PSS("child")=0  D 
 .S PSS("childName")=$$NAME^MXMLDOM(DOCHAND,PSS("child"))
 .D:PSS("childName")="routes" PARSRTES(DOCHAND,PSS("child"),.PSSOUT)
 Q
 ;
PARSRTES(DOCHAND,NODE,PSSOUT) ; read routes element
 ; @DOCHAND = Handle to XML Document
 ; @NODE    = Document node
 ; @PSSOUT  = output array
 N PSS
 S PSS("child")=0
 F  S PSS("child")=$$CHILD^MXMLDOM(DOCHAND,NODE,PSS("child")) Q:PSS("child")=0  D 
 .S PSS("childName")=$$NAME^MXMLDOM(DOCHAND,PSS("child"))
 .D:PSS("childName")="route" PARSRTE(DOCHAND,PSS("child"),.PSSOUT)
 Q
 ;
PARSRTE(DOCHAND,NODE,PSSOUT) ; read route element, add to array if value
 ; @DOCHAND = Handle to XML Document
 ; @NODE    = Document node
 ; @PSSOUT  = output array
 N PSS
 S PSS("child")=0
 F  S PSS("child")=$$CHILD^MXMLDOM(DOCHAND,NODE,PSS("child")) Q:PSS("child")=0  D 
 .S PSS("childName")=$$NAME^MXMLDOM(DOCHAND,PSS("child"))
 .D:PSS("childName")="name" 
 ..S PSS("childText")=$$GETTEXT^PSSHRCOM(DOCHAND,PSS("child"))
 ..D:PSS("childText")'="" 
 ...S PSSOUT(PSS("childText"))=""
 ...S PSSOUT(0)=1
 Q
 ;
GETHEAD(PSSXML) ;  return <?xml version="1.0" encoding="utf-8" ?>
 ;  input: PSSXML string (by ref)
 ; output: returns the XML header info string
 ;
 ;xml header info
 S PSSXML=PSSXML_$$XMLHDR^MXMLUTL
 Q
 ;
GETREQ(PSSXML) ; build and return the <drugInfoRequest... portion of XML request.
 ;  input: PSSXML string (by ref)
 ; output: returns the XML string. for example:
 ;      <drugInfoRequest  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 ;       xsi:schemaLocation="gov/va/med/pharmacy/peps/external/common/preencapsulation/vo/drug/info/request
 ;       drugInfoSchemaInput.xsd" xmlns="gov/va/med/pharmacy/peps/external/common/preencapsulation/vo/drug/info/request">
 ;
 N TAG,SUBXML,SCHEMA,XMLNS,SPACE
 S SPACE=$C(32)
 S SCHEMA="gov/va/med/pharmacy/peps/external/common/preencapsulation/vo/drug/info/request drugInfoSchemaInput.xsd"
 S XMLNS="gov/va/med/pharmacy/peps/external/common/preencapsulation/vo/drug/info/request"
 S TAG="<drugInfoRequest"_SPACE
 S SUBXML=TAG
 ;S SUBXML=SUBXML_$$ATRIBUTE^PSSHRCOM("xmlns",XMLNS
 S SUBXML=SUBXML_$$ATRIBUTE^PSSHRCOM(SPACE_"xmlns:xsi","http://www.w3.org/2001/XMLSchema-instance")
 S SUBXML=SUBXML_$$ATRIBUTE^PSSHRCOM(SPACE_"xsi:schemaLocation",SCHEMA)
 S SUBXML=SUBXML_$$ATRIBUTE^PSSHRCOM(SPACE_"xmlns",XMLNS)
 S PSSXML=PSSXML_SUBXML_">"
 Q
 ;
ENDREQ(PSSXML) ; return the end tag </drugInfoRequest> portion of XML request
 ;  input: PSSXML string (by ref)
 ; output: returns the XML string
 S PSSXML=PSSXML_"</drugInfoRequest>"
 Q
 ;
