PSOERXO1 ;ALB/BWF - eRx Outbound Error messages ; 8/3/2016 5:14pm
 ;;7.0;OUTPATIENT PHARMACY;**467,520**;DEC 1997;Build 52
 ;
 Q
 ;
MSGERR() ;check errors from XML return
 ; note - not currently in use
 ;returns empty string "" if there was no error
 ;returns empty string "" if the only error was "ALL_PATIENT_IDS_EXCLUDED"
 ;otherwise returns the exceptionMessage string from the errorSection
 N ORRET S ORRET=""
 I $D(^TMP($J,"ORRDI","ClinicalData",0,"errorSection")) D
 .N I F I="fatalErrors","errors","warnings" D
 ..N J S J="" F  S J=$O(^TMP($J,"ORRDI","ClinicalData",0,"errorSection",0,I,J)) Q:J=""  D
 ...N ORSTR S ORSTR=$G(^TMP($J,"ORRDI","ClinicalData",0,"errorSection",0,I,J,"errorCode",0))
 ...I ORSTR'="ALL_PATIENT_IDS_EXCLUDED" S ORRET=ORSTR
 Q ORRET
ERRHNDL(DFN) ;handle any errors that may get thrown in call to GET^ORRDI1
 K ^TMP($J,"ORRDI"),^XTMP("ORRDI","PSOO",DFN),^XTMP("ORRDI","ART",DFN)
 D UNWIND^%ZTER
 Q
POST(ERXIEN,PSSOUT,ECODE,DESCODE,DESC,RXVERIFY) ;
 N PSS,PSSERR,PSSFDBRT,PSREQ,INST,GBL,C,RXREFN,PON
 N TOQUAL,FRQUAL,TO,FROM,MID,RTMID,ERXIENS,F,PSODAT
 S F=52.49,C=0
 S PSSFDBRT=1
 S GBL=$NA(^TMP("POST^PSOERXO1",$J)) K @GBL
 Q:'$G(ERXIEN)
 S ERXIENS=ERXIEN_","
 D GETS^DIQ(F,ERXIENS,".01;.02;22.1:22.4;24.1;25","IE","PSODAT")
 S INST=$G(PSODAT(F,ERXIENS,24.1,"I")) I 'INST S PSSOUT(0)=-1_U_"Unable to identify institution. Cannot send message." Q
 ; message ID needs to be unique from vista - Site#.DUZ.erxIEN.date.time??
 S MID=INST_"."_DUZ_"."_ERXIEN_"."_$$NOW^XLFDT
 ; relates to message ID is the incoming message id from CH for outbound messages.
 S RTMID=$G(PSODAT(F,ERXIENS,25,"E"))
 ; from is TO from the erx.
 S FROM=$G(PSODAT(F,ERXIENS,22.3,"E"))
 S FRQUAL=$G(PSODAT(F,ERXIENS,22.4,"I"))
 ; to is FROM from the erx
 S TO=$G(PSODAT(F,ERXIENS,22.1,"E"))
 S TOQUAL=$G(PSODAT(F,ERXIENS,22.2,"I"))
 ; /BLB/ - BEGIN CHANGE PSO*7*520 - adding prescriber order number and rxReferencenumber (.01 in the case of verify and error)
 S PON=$G(PSODAT(F,ERXIENS,.09,"E"))
 S RXREFN=$G(PSODAT(F,ERXIENS,.01,"E"))
 ;
 D C S @GBL@(C,0)="<?xml version = '1.0' encoding = 'UTF-8'?><Message version=""010"" release=""006"" xmlns=""http://www.ncpdp.org/schema/SCRIPT"">"
 D C S @GBL@(C,0)="<Header><To Qualifier="""_TOQUAL_""">"_TO_"</To><From Qualifier="""_FRQUAL_""">"_FROM_"</From><MessageID>"_MID_"</MessageID>"
 D C S @GBL@(C,0)="<RelatesToMessageID>"_RTMID_"</RelatesToMessageID><SentTime>"_$$EXTIME()_"</SentTime>"
 I $L(RXREFN) D C S @GBL@(C,0)="<RxReferenceNumber>"_RXREFN_"</RxReferenceNumber>"
 I $L(PON) D C S @GBL@(C,0)="<PrescriberOrderNumber>"_PON_"</PrescriberOrderNumber>"
 D C S @GBL@(C,0)="</Header>"
 ; PSO*7*520 - /BLB/ - END CHANGE add handling of rxVerify Messages
 ; rxVerify
 I $G(RXVERIFY) D  Q
 .D C S @GBL@(C,0)="<Body><Verify><VerifyStatus><Code>010</Code><Description>Accepted By Pharmacy.</Description></VerifyStatus></Verify></Body></Message>"
 .D RESTPOST(.PSSOUT,.GBL)
 ; PSO*7*520 - end
 D C S @GBL@(C,0)="<Body><Error><Code>"_$G(ECODE)_"</Code>"
 I $L(DESCODE) D C S @GBL@(C,0)="<DescriptionCode>"_$G(DESCODE)_"</DescriptionCode>"
 D C S @GBL@(C,0)="<Description>"_$G(DESC)_"</Description>"
 D C S @GBL@(C,0)="</Error></Body></Message>"
 D RESTPOST(.PSSOUT,.GBL)
 K @GBL,C
 Q
C ;
 S C=C+1
 Q
RESTPOST(PSSOUT,GBL) ;
 N $ETRAP,$ESTACK,PSREQ
 N PSREQ,PSS,PSSERR,GLOOP,GDAT
 ; Set error trap
 SET $ETRAP="DO ERROR^PSSHTTP"
 K ^TMP($J,"OUT")    ; if exists from previous runs, posting would not execute.
 SET PSS("server")="PSO WEB SERVER"
 SET PSS("webserviceName")="PSO ERX WEB SERVICE"
 SET PSS("path")="services/rest/vistaoutboundMsg/processXMLMessage"
 SET PSS("parameterName")="xmlRequest"
 ;SET PSS("parameterValue")=PSREQ
 ;
 ; get instance of client REST request object
 SET PSS("restObject")=$$GETREST^XOBWLIB(PSS("webserviceName"),PSS("server"))
 IF $DATA(^TMP($JOB,"OUT","EXCEPTION"))>0 S PSSOUT(0)="-1^"_^TMP($JOB,"OUT","EXCEPTION") K ^TMP($JOB,"OUT","EXCEPTION") Q PSSOUT
 ;
 ; insert XML as parameter
 ;DO PSS("restObject").InsertFormData(PSS("parameterName"),PSS("parameterValue"))
 S PSS("restObject").ContentType="application/xml"
 S GLOOP=0 F  S GLOOP=$O(@GBL@(GLOOP)) Q:'GLOOP  D
 .S GDAT=$G(@GBL@(GLOOP,0))
 .;SET PSS("parameterValue")=$G(PSS("parameterValue"))_$G(@GBL@(GLOOP,0))
 .DO PSS("restObject").EntityBody.Write(GDAT)
 ;DO PSS("restObject").InsertFormData(PSS("parameterName"),PSS("parameterValue"))
 IF $DATA(^TMP($JOB,"OUT","EXCEPTION"))>0 S PSSOUT(0)="-1^"_^TMP($JOB,"OUT","EXCEPTION") K ^TMP($JOB,"OUT","EXCEPTION") QUIT PSSOUT
 ;
 ; execute HTTP Post method
 SET PSS("postResult")=$$POST^XOBWLIB(PSS("restObject"),PSS("path"),.PSSERR)
 IF $DATA(^TMP($JOB,"OUT","EXCEPTION"))>0 S PSSOUT(0)="-1^"_^TMP($JOB,"OUT","EXCEPTION") K ^TMP($JOB,"OUT","EXCEPTION") QUIT PSSOUT
 ;
 ; response coming back
 ;<vistaOutboundResponse><success>true</success></vistaOutboundResponse>
 ; error handling
 DO:'PSS("postResult")
 . SET PSSOUT(0)=-1_U_"Unable to make http request."
 . SET PSS("result")=0
 . QUIT
 ;
 ; if everything is ok parse the returned xml result
 I PSS("postResult") S PSS("result")=1 D PRSSTRM(PSS("restObject"),.PSSOUT) S PSSOUT(0)=1
 ; for now we do not pass back the message ID for storage into 52.49
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
 N ATOKEN,NODETYPE
 F  D  Q:AREADER.EOF
 .S ATOKEN=$$GETTOKEN(AREADER)
 .I '$L(ATOKEN) Q
 .S NODETYPE=$P(ATOKEN,"<>"),ATOKEN=$P(ATOKEN,"<>",2)
 .I ATOKEN="errorMessage" D POSTERR(AREADER,.PSSOUT)
 .I ATOKEN="success" D POSTRES(AREADER,.PSSOUT)
 Q
 ;
POSTRES(AREADER,PSSOUT) ; get value of success/failure
 N TOKEN,TYPE
 F  D  Q:TOKEN="/success"
 .S TOKEN=$$GETTOKEN(AREADER)
 .S TYPE=$P(TOKEN,"<>"),TOKEN=$P(TOKEN,"<>",2)
 .Q:'$L(TOKEN)!(TOKEN="/success")
 .S PSSOUT("success")=TOKEN
 Q
POSTERR(AREADER,PSSOUT) ; get error message
 N TOKEN,TYPE
 F  D  Q:TOKEN="/errorMessage"
 .S TOKEN=$$GETTOKEN(AREADER)
 .S TYPE=$P(TOKEN,"<>"),TOKEN=$P(TOKEN,"<>",2)
 .Q:'$L(TOKEN)!(TOKEN="/errorMessage")
 .S PSSOUT("errorMessage")=$TR(TOKEN,$C(10)," ")
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
EXTIME(IDTTM) ;
 N YY,MM,DD,TIME,EXDT,TLEN,I,TZONE,DTTM
 S IDTTM=$G(IDTTM,"")
 S DTTM=$S($L(IDTTM):$$FMTHL7^XLFDT(IDTTM),1:$$FMTHL7^XLFDT($$NOW^XLFDT()))
 S TZONE=$P(DTTM,"-",2)
 I 'TZONE S TZONE=$P($$FMTHL7^XLFDT($$NOW^XLFDT()),"-",2)
 S DTTM=$P(DTTM,"-"),TZONE=$E(TZONE,1,2)_":"_$E(TZONE,3,4)
 S YY=$E(DTTM,1,4),MM=$E(DTTM,5,6),DD=$E(DTTM,7,8),TIME=$E(DTTM,9,$L(DTTM))
 I $L(TIME)<6 D
 .S TLEN=$L(TIME)
 .F I=TLEN:1:6 D
 ..S TIME=TIME_0
 ; now construct the date
 S EXDT=YY_"-"_MM_"-"_DD_"T"_$E(TIME,1,2)_":"_$E(TIME,3,4)_":"_$E(TIME,5,6)_$S($L(TZONE):"-"_TZONE,1:"")
 Q EXDT
