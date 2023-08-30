PSOERXO1 ;ALB/BWF - eRx Outbound Error messages ; 8/3/2016 5:14pm
 ;;7.0;OUTPATIENT PHARMACY;**467,520,508,581,617,715**;DEC 1997;Build 1
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
 ; RXVERIFY - if this is set to 1, then this is an rxVerify message.
 ;          - 0 or null, this is an error message
 ;          - 2 cancel request/response
 ; OVRESP - override response if the response was built elsewhere
POST(ERXIEN,PSSOUT,ECODE,DESCODE,DESC,RXVERIFY,INST,OVRESP) ;
 N PSS,PSSERR,PSSFDBRT,PSREQ,GBL,C,PON,RXREFN,VAR,NEWRXIEN,FFILL,TOTREFL,REFL
 N TOQUAL,FRQUAL,TO,FROM,MID,RTMID,ERXIENS,F,PSODAT,RXIEN,LRDATE,NERXIEN,ERRSEQ,S2017
 S F=52.49,C=0
 S PSSFDBRT=1
 S INST=$G(INST,"")
 S GBL=$NA(^TMP("POST^PSOERXO1",$J)) K @GBL
 Q:'$G(ERXIEN)
 S ERXIENS=ERXIEN_","
 S NEWRXIEN=$$RESOLV^PSOERXU2(ERXIEN)
 D GETS^DIQ(F,ERXIENS,".01;.02;.09;.1;.13;22.1:22.4;24.1;25","IE","PSODAT")
 I 'INST S INST=$G(PSODAT(F,ERXIENS,24.1,"I")) I 'INST S PSSOUT(0)=-1_U_"Unable to identify institution. Cannot send message." Q
 ; message ID needs to be unique from vista - Site#.DUZ.erxIEN.date.time??
 S MID=INST_"."_ERXIEN_"."_$$NOW^XLFDT
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
 ; encode XML sensitive characters
 F VAR="TOQUAL","TO","FRQUAL","FROM","RTMID","RXREFN","PON","MID","ECODE","DESCODE","DESC" D
 .S @VAR=$$SYMENC^MXMLUTL($G(@VAR))
 ;/JSG/ POS*7.0*581 - BEGIN CHANGE
 S S2017=$$GET1^DIQ(52.49,ERXIEN,312.1,"I")
 I 1 D  ; Always use new header format
 .D MSG2017(.GBL,.C)
 .D HDR2017(.GBL,.C,.PSODAT,ERXIEN,TOQUAL,TO,FRQUAL,FROM,MID,RTMID,RXREFN,PON,INST)
 I 0 D   ; Deprecated
 .D C S @GBL@(C,0)="<?xml version = '1.0' encoding = 'UTF-8'?><Message version=""010"" release=""006"" xmlns=""http://www.ncpdp.org/schema/SCRIPT"">"
 .D C S @GBL@(C,0)="<Header><To Qualifier="""_TOQUAL_""">"_TO_"</To><From Qualifier="""_FRQUAL_""">"_FROM_"</From><MessageID>"_MID_"</MessageID>"
 .D C S @GBL@(C,0)="<RelatesToMessageID>"_RTMID_"</RelatesToMessageID><SentTime>"_$$EXTIME()_"</SentTime>"
 .I $L(RXREFN) D C S @GBL@(C,0)="<RxReferenceNumber>"_RXREFN_"</RxReferenceNumber>"
 .I $L(PON) D C S @GBL@(C,0)="<PrescriberOrderNumber>"_PON_"</PrescriberOrderNumber>"
 .D C S @GBL@(C,0)="</Header>"
 ; /JSG/ - END CHANGE
 ; PSO*7*520 - /BLB/ - END CHANGE add handling of rxVerify Messages
 ; rxVerify
 I $G(RXVERIFY)=1 D  Q
 .D C S @GBL@(C,0)="<Body><Verify><VerifyStatus><Code>010</Code><Description>Accepted By Pharmacy.</Description></VerifyStatus></Verify></Body></Message>"
 .D RESTPOST(.PSSOUT,.GBL)
 .K @GBL,C
 ; PSO*7*520 - end
 ; cancel response - denied type
 I $G(RXVERIFY)>1 D  Q
 .N RESPONSE,RESTYP,RESTAG
 .S RESPONSE=$S(RXVERIFY=2:"Rx not canceled - Rx not found in pharmacy system.",RXVERIFY=3:"Rx was never dispensed. Canceled at Pharmacy",1:"Response Unknown")
 .I $D(OVRESP) S RESPONSE=OVRESP
 .I $D(RXIEN),'$D(OVRESP) D
 ..S FFILL=$$GET1^DIQ(52,RXIEN,22,"I") I FFILL]"" S FFILL=$$FMTE^XLFDT(FFILL,"2D")
 ..S TOTREFL=$$GET1^DIQ(52,RXIEN,9,"I")
 ..S REFL=TOTREFL,I=0 F  S I=$O(^PSRX(RXIEN,1,I)) Q:'I  S REFL=REFL-1
 ..; p715 Use last release date instead of last dispense date
 ..S LRDATE=$$RXRLDT^PSOBPSUT(RXIEN),LRDATE=$$FMTE^XLFDT(LRDATE,"2D")
 ..S RESPONSE="First Fill:"_FFILL_", Last fill:"_$S(LRDATE:LRDATE,1:"      ")_", Refills remaining:"_REFL
 .S RESTYP=$S(RXVERIFY=2:"D",RXVERIFY=3:"A",1:"")
 .S RESTAG=$S(RXVERIFY=2:"Denied",RXVERIFY=3:"Approved",1:"") Q:RESTAG=""
 .D C S @GBL@(C,0)="<Body><CancelRxResponse><Response><"_RESTAG_">"
 .I RESTYP="D" D C S @GBL@(C,0)="<DenialReason>"_RESPONSE_"</DenialReason>"
 .I RESTYP="A" D C S @GBL@(C,0)="<Note>"_RESPONSE_"</Note>"
 .D C S @GBL@(C,0)="</"_RESTAG_"></Response></CancelRxResponse></Body></Message>"
 .D RESTPOST(.PSSOUT,.GBL)
 .; if the post was unsuccessful, inform the user and quit.
 .I $P(PSSOUT(0),U)<1 S PSSOUT("errorMessage")=$P(PSSOUT(0),U,2)
 .S HUBID=$G(PSSOUT("outboundMsgId")) I 'HUBID S PSSOUT("errorMessage")="The eRx Processing hub did not return a Hub identification number."
 .I $D(PSSOUT("errorMessage")) D  Q
 ..D UPDSTAT^PSOERXU1(ERXIEN,"CAX")
 ..S ERRSEQ=$$ERRSEQ^PSOERXU1(ERXIEN) Q:'ERRSEQ
 ..D FILERR^PSOERXU1(ERXIENS,ERRSEQ,"PX","V",$G(PSSOUT("errorMessage")))
 .; vista generated message will be V12345 (V concatenated to the hubId)
 .S HUBID="V"_HUBID
 .;file the cancel response in the holding queue.
 .D CMFILE(HUBID,MID,RTMID,TOQUAL,TO,FRQUAL,FROM,RXREFN,PON,RESPONSE,RESTYP,"CN",INST)
 .K @GBL,C
 ; outbound error
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
 ;
 ; get instance of client REST request object
 SET PSS("restObject")=$$GETREST^XOBWLIB(PSS("webserviceName"),PSS("server"))
 IF $DATA(^TMP($JOB,"OUT","EXCEPTION"))>0 S PSSOUT(0)="-1^"_^TMP($JOB,"OUT","EXCEPTION") K ^TMP($JOB,"OUT","EXCEPTION") Q PSSOUT
 ;
 ; insert XML as parameter
 S PSS("restObject").ContentType="application/xml"
 S GLOOP=0 F  S GLOOP=$O(@GBL@(GLOOP)) Q:'GLOOP  D
 .S GDAT=$G(@GBL@(GLOOP,0))
 .DO PSS("restObject").EntityBody.Write(GDAT)
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
 .I ATOKEN="success" D POSTRES(AREADER,.PSSOUT,ATOKEN)
 .I ATOKEN="outboundMsgId" D POSTRES(AREADER,.PSSOUT,ATOKEN)
 Q
 ;
POSTRES(AREADER,PSSOUT,ATOKEN) ; get value of success/failure
 N TOKEN,TYPE,QPARAM
 S QPARAM="/"_ATOKEN
 F  D  Q:TOKEN=QPARAM
 .S TOKEN=$$GETTOKEN(AREADER)
 .S TYPE=$P(TOKEN,"<>"),TOKEN=$P(TOKEN,"<>",2)
 .Q:'$L(TOKEN)!(TOKEN=QPARAM)
 .S PSSOUT(ATOKEN)=TOKEN
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
 ;
 ; HUBID - hub identification number returned upon successful transmission
 ; MID - message id
 ; RTMID - relates to message ID
 ; TOQUAL - to qualifier
 ; TO - to value (the 'from' value from the original message)
 ; FRQUAL - from qualifier
 ; FROM - who the message was from the 'to' value from the original message
 ; RXREFN - rx reference number
 ; PON - prescriber order number
 ; RESPONSE - response text in the response XML
 ; RESTYPE - 'A' = approved, 'D' = denied
 ; RELIEN - related message ien
 ; RESTAT - response status
 ; MTYPE - CANCEL REQUEST/CANCEL RESPONSE
CMFILE(HUBID,MID,RTMID,TOQUAL,TO,FRQUAL,FROM,RXREFN,PON,RESPONSE,RESTYPE,MTYPE,INST) ;
 N FDA,F,NRXIEN,CREQ,NEWRX
 S F=52.49
 ; if there is no related message id, use the division passed by the hub for the cancelRx
 S FDA(F,"+1,",.01)=HUBID
 S FDA(F,"+1,",.02)=RTMID
 S FDA(F,"+1,",.03)=$$NOW^XLFDT
 S FDA(F,"+1,",.06)=$G(INST)
 S FDA(F,"+1,",.08)=MTYPE
 S FDA(F,"+1,",1)=$$PRESOLV^PSOERXA1("CNP","ERX")
 S FDA(F,"+1,",.14)=$G(RXREFN)
 S FDA(F,"+1,",22.1)=FROM
 S FDA(F,"+1,",22.2)=FRQUAL
 S FDA(F,"+1,",22.3)=TO
 S FDA(F,"+1,",22.4)=TOQUAL
 S FDA(F,"+1,",24.1)=$G(INST)
 S FDA(F,"+1,",25)=MID
 S FDA(F,"+1,",51.1)=$G(DUZ)
 S FDA(F,"+1,",52.1)=RESTYPE
 S FDA(F,"+1,",52.2)=RESPONSE
 S FDA(F,"+1,",312.1)=1
 D UPDATE^DIE(,"FDA","NRXIEN","ERR") K FDA
 S NERXIEN=$O(NRXIEN(0)),NERXIEN=$G(NRXIEN(NERXIEN)) Q:'NERXIEN
 S CREQ=$$GETREQ^PSOERXU2(NERXIEN)
 S NEWRX=$$FINDNRX^PSOERXU6(CREQ)
 ; If there is no new Rx, link this to the cancel request
 I 'NEWRX S NEWRX=CREQ
 ; link both records
 I '$D(^PS(52.49,NEWRX,201,"B",NERXIEN)) D
 .S FDA(52.49201,"+1,"_NEWRX_",",.01)=NERXIEN D UPDATE^DIE(,"FDA") K FDA
 I '$D(^PS(52.49,NERXIEN,201,"B",NEWRX)) D
 .S FDA(52.49201,"+1,"_NERXIEN_",",.01)=NEWRX D UPDATE^DIE(,"FDA") K FDA
 Q
 ;
MSG2017(GBL,CNT) ; ADAPTED FROM PSOERXX2
 ;/JSG/ POS*7.0*581 - BEGIN CHANGE
 N X
 S X="<?xml version=""1.0"" encoding=""UTF-8""?>"
 S X=X_"<Message TransportVersion=""20170715"" DatatypesVersion=""20170715"""
 S X=X_" TransactionDomain=""SCRIPT"" TransactionVersion=""20170715"""
 S X=X_" StructuresVersion=""20170715"" ECLVersion=""20170715"""
 S X=X_" xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance"">"
 D C S @GBL@(CNT,0)=X
 ;/JSG/ - END CHANGE
 Q
 ;
HDR2017(GLB,CNT,PSDAT,IEN,TOQUAL,TOVAL,FRQUAL,FRVAL,MID,RTMID,ERXHID,PON,INST) ; ADAPTED FROM PSOERXX2
 N F,STIME,STERTID,RTERTID,RETREC,REQREF,PSDAT,SSECID,RSECID,IENS
 S F=52.49
 S IENS=IEN_","
 D CONVXML^PSOERXX1("PSDAT")
 ; return receipt and request reference # currently not stored. Do we need to add a field in 52.49?
 S RETREC=$G(PSDAT(F,IENS,1,"E"))
 S REQREF=$G(PSDAT(F,IENS,1,"E"))
 S RETREC="ACA",REQREF=""
 S SSECID=$G(PSDAT(F,IENS,24.5,"E"))
 ; leaving this in place for now CH wanted the tertiary ID to be TECHNATOMY. I suspect this will
 ; need to be something different in the long run
 ;S STERTID=$G(PSDAT(F,IENS,24.6,"E"))
 S STERTID="TECHNATOMY"
 S RSECID=$G(PSDAT(F,IENS,24.3,"E"))
 ;S RTERTID=$G(PSDAT(F,IENS,24.4,"E"))
 S RTERTID="ERXPAD"
 D C S @GBL@(CNT,0)="<Header><To Qualifier="""_TOQUAL_""">"_TOVAL_"</To>"
 D C S @GBL@(CNT,0)="<From Qualifier="""_FRQUAL_""">"_FRVAL_"</From>"
 D C S @GBL@(CNT,0)="<MessageID>"_MID_"</MessageID>"
 ; relatesToMessageID is the CH messageID - FIELD 25
 I $L(RTMID) D C S @GBL@(CNT,0)="<RelatesToMessageID>"_RTMID_"</RelatesToMessageID>"
 D C S @GBL@(CNT,0)="<SentTime>"_$$EXTIME^PSOERXO1()_"</SentTime>"
 ; bwf - LOOK AT THE SECURITY SECTION AGAIN
 D C S @GBL@(CNT,0)="<Security>"
 ; bwf -  missing UsernameToken - consider as part of v3
 D C S @GBL@(CNT,0)="<Sender>"
 ; for now we are not using secondary identifications, this will stay in place for future activation.
 ;I $L(SSECID) D C S @GBL@(CNT,0)="<SecondaryIdentification>"_SSECID_"</SecondaryIdentification>"
 I $L(STERTID) D C S @GBL@(CNT,0)="<TertiaryIdentification>"_STERTID_"</TertiaryIdentification>"
 D C S @GBL@(CNT,0)="</Sender>"
 D C S @GBL@(CNT,0)="<Receiver>"
 ;I $L(RSECID) D C S @GBL@(CNT,0)="<SecondaryIdentification>"_RSECID_"</SecondaryIdentification>"
 I $L(RTERTID) D C S @GBL@(CNT,0)="<TertiaryIdentification>"_RTERTID_"</TertiaryIdentification>"
 D C S @GBL@(CNT,0)="</Receiver>"
 D C S @GBL@(CNT,0)="</Security>"
 ;/JSG/ POS*7.0*581 - BEGIN CHANGE
 D C S @GBL@(CNT,0)="<SenderSoftware>"
 D C S @GBL@(CNT,0)="<SenderSoftwareDeveloper>VA</SenderSoftwareDeveloper>"
 D C S @GBL@(CNT,0)="<SenderSoftwareProduct>VA-Inbound eRx</SenderSoftwareProduct>"
 D C S @GBL@(CNT,0)="<SenderSoftwareVersionRelease>V5.0</SenderSoftwareVersionRelease>"
 D C S @GBL@(CNT,0)="</SenderSoftware>"
 ;/JSG/ - END CHANGE
 ; missing 'Mailbox' - note for future enhancement. Was not needed for CH certification.
 D C S @GBL@(CNT,0)="<RxReferenceNumber>"_ERXHID_"</RxReferenceNumber>"
 I $L(PON) D C S @GBL@(CNT,0)="<PrescriberOrderNumber>"_PON_"</PrescriberOrderNumber>"
 D C S @GBL@(CNT,0)="</Header>"
 Q
