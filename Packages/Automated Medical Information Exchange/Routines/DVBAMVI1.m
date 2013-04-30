DVBAMVI1 ;ALB/RPM - CAPRI MVI SEARCH 1305/1306 PROCESSING ;6/27/2012
 ;;2.7;AMIE;**181**;Apr 10, 1995;Build 38
 ;
 Q  ;NO DIRECT ENTRY
 ;
FNDPAT(DVBRSLT,DVBDEM,DVBQUANT,DVBFRMT) ;
 ;This procedure supports the DVBA MVI SEARCH PERSON remote procedure.
 ;
 ;  Input:
 ;    DVBRSLT - RPC results parameter defined as an ARRAY
 ;    DVBDEM  - Patient demographics used for search delimited using "^"
 ;         FIRSTNAME                      - piece 1 (required)
 ;         MIDDLENAME or INITIAL          - piece 2 (optional)
 ;         LASTNAME                       - piece 3 (required)
 ;         SSN (9 digits)                 - piece 4 (required)
 ;         DATE OF BIRTH (FileMan format) - piece 5 (optional)
 ;
 ;         ex.  CAPRI^TEST^PATIENT^999999999^2540101
 ;    DVBQUANT - optional initialQuantity value passed to web service.
 ;               Defaults to 10.
 ;    DVBFRMT - optional name format type.
 ;       0 (Default) - Return name in First Middle Last Suffix format
 ;       1           - Return name in Last,First Middle Suffix format
 ;
 ; Output:
 ;   DVBRSLT - array of matching patient records in caret-delimited
 ;             format.
 ;
 ;      FULLNAME                        - piece 1
 ;      SSN  (9 digits)                 - piece 2
 ;      DATE OF BIRTH (external format) - piece 3          
 ;      MVI ID                          - pieces 4-7
 ;        ID
 ;        IdType
 ;        Assigning Location
 ;        Assigning Issuer
 ;
 ; Example results:
 ;  CAPRI TEST PATIENT^999999999^1/1/1980^1062212234V192931^NI^200M^USVHA
 ;   or
 ;  PATIENT,CAPRI TEST^999999999^1/1/1980^1062212234V192931^NI^200M^USVHA
 ;
 N DVBXML   ;1305 HL7v3 XML
 N DVBXMLR  ;1306 HL7v3 XML
 N DVBCNT  ;number of results
 N DVBPRS  ;parsed results
 S DVBCNT=0
 ;
 ;create the 1305 request message
 I (+$G(DVBQUANT)<1)!(+$G(DVBQUANT)>10) S DVBQUANT=10
 I +$G(DVBFRMT)'=1 S DVBFRMT=0
 S DVBXML=$$CRE81305(DVBDEM,DVBQUANT)
 ;
 ;transmit the message to the MVI
 D XMIT(DVBXML,.DVBXMLR)
 ;
 ;parse the returned 1306 request message
 I $D(DVBXMLR) D
 . D PARSE(.DVBXMLR,.DVBPRS)
 . ;
 . ;format the output array
 . D OUTPUT(.DVBPRS,.DVBRSLT)
 E  D
 . S DVBRSLT(0)=0_U_"Communication error occurred"
 Q
 ;
CRE81305(DVBDEM,DVBQUANT) ; create 1305 request xml document
 ; This function creates the HL7v3 1305 Search Person Request
 ; (Match criteria with person trait data) xml document
 ;
 ; DVBDEM = Patient demographics delimited using "^"
 ;         DVBFNAME: FIRSTNAME  - piece 1
 ;         DVBMNAME: MIDDLENAME - piece 2
 ;         DVBLNAME: LASTNAME   - piece 3
 ;         DVBSSN:   SSN        - piece 4
 ;         DVBDOB:   DATE OF BIRTH - piece 5
 ;         ex.  CAPRI^TEST^PATIENT^999999999^2540101
 ;
 ; DVBQUANT = initialQuantity value parameter
 ;
 ;    Returns formatted XML for the search
 ;
 ; $$PARAM^HLCS2 - #3552 (need)
 ;
 N DVBFNAME  ;first name
 N DVBLNAME  ;last name
 N DVBMNAME  ;middle name or initial
 N DVBSSN    ;social security #
 N DVBDOB    ;date of birth
 N DVBSKEY   ;site key
 N DVBPCODE  ;HL7 processing code
 N MPIXML    ;function result
 ;
 S DVBPCODE=$P($$PARAM^HLCS2,"^",3)
 S DVBSKEY="200CAPR"
 S DVBFNAME=$P(DVBDEM,U,1)
 S DVBMNAME=$P(DVBDEM,U,2)
 S DVBLNAME=$P(DVBDEM,U,3)
 S DVBSSN=$P(DVBDEM,U,4)
 S DVBDOB=$P(DVBDEM,U,5)
 ;
 ;Header
 S MPIXML="<PRPA_IN201305UV02 xmlns=""urn:hl7-org:v3"" "
 S MPIXML=MPIXML_"xmlns:ps=""http://vaww.oed.oit.domain.ext"" "
 S MPIXML=MPIXML_"xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance"
 S MPIXML=MPIXML_""" xsi:schemaLocation=""urn:hl7-org:v3 ../../schema/"
 S MPIXML=MPIXML_"HL7V3/NE2008/multicacheschemas/PRPA_IN201305UV02.xsd"
 S MPIXML=MPIXML_""" ITSVersion=""XML_1.0"">"
 S MPIXML=MPIXML_"<id root=""2.16.840.1.113883.4.349"" "
 S MPIXML=MPIXML_"extension=""MCID-12345""/>"
 S MPIXML=MPIXML_"<creationTime value="""_$$FMTHL7^XLFDT($$NOW^XLFDT())_"""/>"
 S MPIXML=MPIXML_"<interactionId root=""2.16.840.1.113883.1.6"" "
 S MPIXML=MPIXML_"extension=""PRPA_IN201305UV02""/>"
 S MPIXML=MPIXML_"<processingCode code="""_DVBPCODE_"""/>"
 S MPIXML=MPIXML_"<processingModeCode code=""I""/>"
 S MPIXML=MPIXML_"<acceptAckCode code=""AL""/>"
 ;
 ;<receiver> start
 S MPIXML=MPIXML_"<receiver typeCode=""RCV"">"
 S MPIXML=MPIXML_"<device classCode=""DEV"" determinerCode=""INSTANCE"">"
 S MPIXML=MPIXML_"<id root=""2.16.840.1.113883.4.349""/>"
 S MPIXML=MPIXML_"<telecom value=""http://servicelocation/PDQuery""/>"
 S MPIXML=MPIXML_"</device></receiver>"
 ;
 ;<sender> start
 S MPIXML=MPIXML_"<sender typeCode=""SND"">"
 S MPIXML=MPIXML_"<device classCode=""DEV"" determinerCode=""INSTANCE"">"
 S MPIXML=MPIXML_"<id extension="""_DVBSKEY_""" root=""2.16.840.1.113883.4.349""/>"
 S MPIXML=MPIXML_"</device></sender>"
 ;
 ;<controlActProcess> start
 S MPIXML=MPIXML_"<controlActProcess "
 S MPIXML=MPIXML_"classCode=""CACT"" moodCode=""EVN"">"
 S MPIXML=MPIXML_"<code code=""PRPA_TE201305UV02"" "
 S MPIXML=MPIXML_"codeSystem=""2.16.840.1.113883.1.6""/>"
 S MPIXML=MPIXML_"<queryByParameter><queryId extension="""_$J_""""
 S MPIXML=MPIXML_" root=""2.16.840.1.113883.3.933""/>"
 S MPIXML=MPIXML_"<statusCode code=""new""/>"
 S MPIXML=MPIXML_"<initialQuantity value="""_DVBQUANT_"""/>"
 S MPIXML=MPIXML_"<parameterList>"
 I DVBDOB'="" D
 . S MPIXML=MPIXML_"<livingSubjectBirthTime>"
 . S MPIXML=MPIXML_"<value value="""_$$FMTHL7^XLFDT(DVBDOB)_"""/>"
 . S MPIXML=MPIXML_"<semanticsText>LivingSubject..birthTime</semanticsText>"
 . S MPIXML=MPIXML_"</livingSubjectBirthTime>"
 S MPIXML=MPIXML_"<livingSubjectId>"
 S MPIXML=MPIXML_"<value root=""2.16.840.1.113883.4.1"" extension="""_DVBSSN_"""/>"
 S MPIXML=MPIXML_"<semanticsText>SSN</semanticsText>"
 S MPIXML=MPIXML_"</livingSubjectId>"
 S MPIXML=MPIXML_"<livingSubjectName>"
 S MPIXML=MPIXML_"<value use=""L"">"
 S MPIXML=MPIXML_"<given>"""_DVBFNAME_"""</given>"
 I $G(DVBMNAME)'="" D  ;optional middle name or initial
 . S MPIXML=MPIXML_"<given>"""_DVBMNAME_"""</given>"
 S MPIXML=MPIXML_"<family>"""_DVBLNAME_"""</family>"
 S MPIXML=MPIXML_"</value>"
 S MPIXML=MPIXML_"<semanticsText>Legal Name</semanticsText>"
 S MPIXML=MPIXML_"</livingSubjectName>"
 S MPIXML=MPIXML_"</parameterList>"
 S MPIXML=MPIXML_"</queryByParameter></controlActProcess>"
 S MPIXML=MPIXML_"</PRPA_IN201305UV02>"
 Q MPIXML
 ;
XMIT(DVBXML,DVBXMLR) ;
 ;This procedure transmits the formatted 1305 HL7v3 XML document
 ;and returns the 1306 HL7v3 XML results document.
 ;
 ; $$GETPROXY^XOBWLIB - #5421
 ;
 N $ETRAP,$ESTACK,SVC
 ;
 ; set error trap
 S $ETRAP="DO ERROR^DVBAHWSC"
 ;
 ; make the call
 ;  $$GETPROXY(web_service_name (#18.02), web_server_name (#18.12))
 S SVC=$$GETPROXY^XOBWLIB("DVB_PSIM_EXECUTE","DVB_MVI_SERVER")
 S DVBXMLR=SVC.execute(DVBXML)
 ;
 Q
 ;
PARSE(DVBXML,DVBOUT) ;
 ;This procedure parses the resulting 1306 HL7v3 XML document and
 ;builds an output array subscripted by record count and field item.
 ;
 ; EN^MXMLPRSE - #4149
 ;
 K ^TMP($J,"DVBAMVI1")
 N DVBCB     ;parser callback array
 N DVBVAR    ;character values
 S DVBVAR=""
 S DVBCB("STARTELEMENT")="SE^DVBAMVI1"
 S DVBCB("ENDELEMENT")="EE^DVBAMVI1"
 S DVBCB("CHARACTERS")="VALUE^DVBAMVI1"
 S ^TMP($J,"DVBAMVI1",1)=DVBXML
 D EN^MXMLPRSE($NA(^TMP($J,"DVBAMVI1")),.DVBCB)
 K ^TMP($J,"DVBAMVI1")
 Q
 ;
SE(DVBNM,DVBATTR) ; - used for the parser to call back with STARTELEMENT
 ;
 ; prevent any undefined errors
 S DVBNM=$G(DVBNM)
 S DVBATTR("extension")=$G(DVBATTR("extension"))
 S DVBATTR("code")=$G(DVBATTR("code"))
 ;
 ; set patient counter
 I DVBNM="patient" S DVBCNT=DVBCNT+1 Q
 ;
 I DVBNM="id",$E(DVBATTR("extension"),1,4)="MCID" Q
 I DVBNM="id",DVBATTR("extension")?3N.NA Q
 I DVBNM="id",DVBATTR("extension")="" Q
 ;
 ;set ICN
 I DVBNM="id",DVBATTR("extension")["NI^200M^USVHA^P" D  Q
 . S DVBOUT(DVBCNT,"ICN")=$P(DVBATTR("extension"),U,1,4)
 ;
 ;set SSN
 I DVBNM="id",DVBATTR("extension")["^SS" D  Q
 . S DVBOUT(DVBCNT,"SSN")=$P(DVBATTR("extension"),U,1)
 ;
 ;set DOB
 I DVBNM="birthTime" D  Q
 . S DVBOUT(DVBCNT,"DOB")=$$FMTE^XLFDT($$HL7TFM^XLFDT($G(DVBATTR("value"))),"5Z")
 ;
 ;set Name to start collecting name field data
 I DVBNM="name",DVBATTR("use")="L" D
 . S DVBVAR="NAME"
 . S DVBOUT(DVBCNT,DVBVAR)=""
 ;
 ;set Family Name when using Last,First Middle format
 I DVBFRMT,DVBNM="family",DVBVAR="NAME" D
 . S DVBVAR="FAMILY"
 . S DVBOUT(DVBCNT,DVBVAR)=""
 ;
 ;response code
 I DVBNM="queryResponseCode",$G(DVBOUT(0))="" D  Q
 . S DVBOUT(0)=$S(DVBATTR("code")="NF":"No match found for patient",DVBATTR("code")="QE":"More than 10 potential matches found",1:DVBATTR("code"))
 ;
 ;set acknowledgementDetail
 I DVBNM="acknowledgementDetail" D  Q
 . S DVBVAR="ACKNOWLEDGEMENTDETAIL"
 . S DVBOUT(DVBCNT,DVBVAR)=""
 ;
 Q
 ;
VALUE(DVBTXT) ; - used by the parser to call back with CHARACTERS
 I DVBVAR'="" D
 . S DVBOUT(DVBCNT,DVBVAR)=DVBOUT(DVBCNT,DVBVAR)_$S($L(DVBOUT(DVBCNT,DVBVAR)):" ",1:"")_DVBTXT
 Q
 ;
EE(DVBNM) ; - used for the the parser to call back with ENDELEMENT
 ;
 ; prevent any undefined errors
 S DVBNM=$G(DVBNM)
 ;
 ;set back to "NAME" to append any suffix onto given name - only
 ;used for Last,First Middle Suffix format
 I DVBNM="family",DVBVAR="FAMILY" S DVBVAR="NAME" Q
 ;
 ;stop reading name fields
 I DVBNM="name",DVBVAR="NAME" S DVBVAR="" Q
 ;
 ;stop reading acknowledgmentDetail field
 I DVBNM="acknowledgementDetail",DVBVAR="ACKNOWLEDGEMENTDETAIL" S DVBVAR="" Q
 ;
 Q
 ;
OUTPUT(DVBIN,DVBOUT) ;
 ;This procedure formats the individual record lines and builds
 ;the results array output for the remote procedure.
 ;
 N DVBCNT  ;line count
 N DVBTOT  ;total lines
 S DVBCNT=0
 S DVBTOT=0
 F  S DVBCNT=$O(DVBIN(DVBCNT)) Q:'DVBCNT  D
 . S DVBTOT=DVBTOT+1
 . I DVBFRMT D  ;Last,First Middle Suffix
 . . S DVBOUT(DVBCNT)=$G(DVBIN(DVBCNT,"FAMILY"))_","_$G(DVBIN(DVBCNT,"NAME"))
 . E  D  ;First Middle Last Suffix
 . . S DVBOUT(DVBCNT)=$G(DVBIN(DVBCNT,"NAME"))
 . S DVBOUT(DVBCNT)=DVBOUT(DVBCNT)_U_$G(DVBIN(DVBCNT,"SSN"))
 . S DVBOUT(DVBCNT)=DVBOUT(DVBCNT)_U_$G(DVBIN(DVBCNT,"DOB"))
 . S DVBOUT(DVBCNT)=DVBOUT(DVBCNT)_U_$G(DVBIN(DVBCNT,"ICN"))
 I $G(DVBIN(0))="AE" D
 . S DVBOUT(0)=DVBTOT_U_"Acknowledgement Error: "_$G(DVBIN(0,"ACKNOWLEDGEMENTDETAIL"))
 E  D
 . S DVBOUT(0)=DVBTOT_U_$G(DVBIN(0))
 Q
