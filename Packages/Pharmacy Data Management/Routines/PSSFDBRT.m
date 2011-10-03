PSSFDBRT ;WOIFO/Parviz Ostovari - Sends XML Request to PEPS via HWSC ;09/20/07
 ;;1.0;PHARMACY DATA MANAGEMENT;**136**;9/30/97;Build 89
 ;
 ;
 ; this code is copied and modified from PSZZDI routine.
 ; this routine is responsible for performing drug information queries against a drug database.
 ; the architecture parses the XML stream into tokens
 ;
 Q
GROUTE(PSSIEN,PSSOUT) ; get the routes for given drug ien in drug file from PESPS via HWSC
 ;  input: drug IEN from drug file (#50)
 ; output: PSSOUT - array containing the list of route names for the given drug.
 ;             e.g. PSSOUT("CONTINUOUS INFUSION")=""
 ;                  PSSOUT("INTRAOSSEOUS")=""
 ;  if for any reason can not get the route, it kills the PSSOUT
 ;
 N PSSXML,GCNSEQ
 K PSSOUT
 S GCNSEQ=$$DRUGGCN(PSSIEN)    ; get the GCN sequence number.
 Q:GCNSEQ=0                  ; no GCN sequence number
 S PSSXML=$$BLDXML(GCNSEQ)   ; build the xml request
 D POST(PSSXML,.PSSOUT)    ; post the request and process the results
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
 ;  input: drug IEN from drug file (#50)
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
 N PSS,PSSERR
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
 IF $DATA(^TMP($JOB,"OUT","EXCEPTION"))>0 QUIT 0
 ;
 ; insert XML as parameter
 DO PSS("restObject").InsertFormData(PSS("parameterName"),PSS("parameterValue"))
 IF $DATA(^TMP($JOB,"OUT","EXCEPTION"))>0 QUIT 0
 ;
 ; execute HTTP Post method
 SET PSS("postResult")=$$POST^XOBWLIB(PSS("restObject"),PSS("path"),.PSSERR)
 IF $DATA(^TMP($JOB,"OUT","EXCEPTION"))>0 QUIT 0
 ;
 DO:'PSS("postResult")
 . SET ^TMP($JOB,"OUT","EXCEPTION")=-1_U_"Unable to make http request."
 . SET PSS("result")=0
 . QUIT
 ;
 ; if every thing is ok parse the returned xml result
 I PSS("postResult") S PSS("result")=1 D PRSSTRM(PSS("restObject"),.PSSOUT)
 Q PSS("result")
 ;
PRSSTRM(RESTOBJ,PSSOUT) ;  parse the XML into token
 ;  input: RESTOBJ--a rest object
 ; output: PSSOUT - array containing the list of route names for the given drug.
 ;
 ; parse the XML into tokens. the first part of the token is the type of node being read.
 ; the second part is the data--either the name of the node, or data. these fields are delimited using "<>".
 ; if the node is type attribute, each attribute is separated by a caret ("^").
 ;
 N AREADER
 S AREADER=$$GETREADR(RESTOBJ)
 D PARSXML(AREADER,.PSSOUT)
 Q
 ;
PARSXML(AREADER,PSSOUT) ; extract the list of routes from XML results
 ;  input: AREADER-%XML.TextReader object.
 ; output: PSSOUT - array containing the list of route names for the given drug.
 ;
 N ATOKEN,NODETYPE,GCNSEQ
 F  D  Q:AREADER.EOF
 .S ATOKEN=$$GETTOKEN(AREADER)
 .I '$L(ATOKEN) Q
 .S NODETYPE=$P(ATOKEN,"<>"),ATOKEN=$P(ATOKEN,"<>",2)
 .I NODETYPE["exception" Q
 .I NODETYPE["drugNotFound" Q  ; nodrug tag
 .; inside drug attributes
 .I NODETYPE["drug",ATOKEN["gcnSeqNo" S GCNSEQ=$P(ATOKEN,"=",2)
 .; if routes token get list of the routes
 .I ATOKEN="routes",$G(GCNSEQ) D ROUTES(AREADER,GCNSEQ,.PSSOUT)
 .I ATOKEN="/drug" S GCNSEQ=0
 Q
ROUTES(AREADER,GCN,PSSOUT) ; extract list of routes
 ;  input: AREADER-%XML.TextReader object
 ;         GCN - GCN sequence number from FDB
 ; output: PSSOUT - array containing the list of route names for the given drug.
 ;
 N ROUTEID,ID,TOKEN,TYPE,ROUTNM
 F  D  Q:TOKEN="/routes"
 .S TOKEN=$$GETTOKEN(AREADER)
 .S TYPE=$P(TOKEN,"<>"),TOKEN=$P(TOKEN,"<>",2)
 .Q:'$L(TOKEN)
 .I TOKEN="id" D  Q
 ..S TOKEN=$$GETTOKEN(AREADER)
 ..S ROUTEID=$P(TOKEN,"<>",2)
 .I TOKEN="name" S TOKEN=$$GETTOKEN(AREADER) D
 ..;S PSSOUT(GCN,ROUTEID)=$P(TOKEN,"<>",2)
 ..S ROUTNM=$P(TOKEN,"<>",2)
 ..S:$L(ROUTNM)>0 PSSOUT(ROUTNM)=""
 Q
 ;
GETREADR(RESTOBJ) ; set up and return a Textreader object to be used to parse the XML stream
 ;  input: RESTOBJ-  REST object
 ; output: returns a %XML.TextReader object.
 ;
 N AREADER
 S AREADER=##class(%XML.TextReader).%New("%XML.TextReader")
 D ##class(%XML.TextReader).ParseStream(RESTOBJ.HttpResponse.Data,.AREADER)
 Q AREADER
 ;
GETTOKEN(READER) ; get a token at a time
 ;  input: AREADER-%XML.TextReader object
 ; Output: returns a token
 ;
 ;   this is the key to the parsing of the XML stream.
 ;   each element is parsed with its associated data (if any)
 ;   the nodetype is concatenated with "<>" with the Token
 ;   which can be the tag or the data.
 ;   for example each time is called return one of the following:
 ;     . . .
 ;     . . .
 ;     drug(attributes)<>gcnSeqNo=17240
 ;     element<>routes
 ;     element<>route
 ;     element<>id
 ;     chars<>006
 ;     endelement<>/id
 ;     element<>name
 ;     chars<>CONTINUOUS INFUSION
 ;     endelement<>/name
 ;     endelement<>/route
 ;     . . .
 ;     . . .
 ;
 N TOKEN,NODETYPE,SUBTOKEN,ALLTOKEN
 S TOKEN="",SUBTOKEN="",NODETYPE="",ALLTOKEN=""
 D
 .Q:READER.EOF
 .D READER.Read()  ; go to first node
 .Q:READER.EOF     ; try before and after read
 .;W !,READER.NodeTypeGet()
 .;S NODETYPE=READER.NodeTypeGet()
 .I READER.HasAttributes D
 ..S NODETYPE=READER.Name_"(attributes)"
 ..S TOKEN=$$GETATTS(READER)
 .I '$L(TOKEN) S NODETYPE=READER.NodeTypeGet() D
 ..I NODETYPE="element" S TOKEN=READER.Name Q
 ..I NODETYPE="chars" S TOKEN=READER.Value Q
 ..I NODETYPE="endelement" S TOKEN="/"_READER.Name Q
 ..I NODETYPE="comment" S TOKEN="^"
 ..I NODETYPE="processinginstruction" S TOKEN=READER.Value Q
 ..I NODETYPE="ignorablewhitespace" S TOKEN="^" Q
 ..I NODETYPE="startprefixmapping" S TOKEN=READER.Value Q
 ..I NODETYPE="warning" S TOKEN=READER.Value Q
 ..I '$L(TOKEN) S TOKEN="^"
 ..;
 .I $L(NODETYPE) S ALLTOKEN=NODETYPE_"<>"_TOKEN
 ;W !,"TOKEN="_ALLTOKEN
 Q ALLTOKEN
 ;
GETATTS(AREADER) ; get attributes
 ;  input: AREADER-%XML.TextReader object
 ; Output: returns the attributes
 ;
 N I,INDEX,TOKEN,SUBTOKEN,ATTRB
 S (TOKEN,SUBTOKEN)=""
 S INDEX=AREADER.AttributeCountGet()
 FOR I=1:1:INDEX D
 .S ATTRB=AREADER.MoveToAttributeIndex(I) D
 .S SUBTOKEN=AREADER.Name_"="_AREADER.Value
 .I '$L(TOKEN) S TOKEN=SUBTOKEN Q
 .S TOKEN=TOKEN_"^"_SUBTOKEN
 ;W !,"  ATT=",TOKEN
 Q TOKEN
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
