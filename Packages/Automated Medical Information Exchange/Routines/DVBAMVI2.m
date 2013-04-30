DVBAMVI2 ;ALB/RPM - CAPRI MVI GET CORRESPONDING IDS ;8/6/2012
 ;;2.7;AMIE;**181**;Apr 10, 1995;Build 38
 ; Get Corresponding Ids is a function of the MVI service,
 ; used to retrieve all known MVI Identifiers as they relate
 ; to a source identifier. The transaction grouping for this
 ; interaction is a 1309 Request and 1310 Response.
 ;
 Q  ;NO DIRECT ENTRY
 ;
GETIDS(DVBRSLT,DVBIID) ;
 ;This procedure supports the DVBA MVI GET CORRESPONDING IDS remote
 ;procedure. An MVI patient identifier string is passed to the procedure.
 ;The procedure generates a 1309 Get Corresponding IDs HL7v3 request
 ;message and transmits it to the MVI.  A list of station numbers is
 ;returned in a 1310 HL7v3 message to represent the treating facility list.
 ;The INSTITUTION (#4) file IEN, station name, and station number is
 ;returned for each treating facility. 
 ;
 ;  Input:
 ;    DVBRSLT - RPC results parameter defined as an ARRAY
 ;    DVBIID = Patient identifier delimited using "^"
 ;      Piece 1: Id
 ;      Piece 2: IdType
 ;      Piece 3: Assigning location
 ;      Piece 4: Assigning issuer
 ;
 ;      Example: 1008523099V750710^NI^200M^USVHA
 ;
 ;  Output:
 ;    DVBRSLT - array of lines each containing station IEN, name ,
 ;              and station number delimited by a caret ("^").  The
 ;              first array node contains the total number of stations
 ;              returned and the query response.
 ;
 ;             Format: instutionIEN^stationName^stationNumber
 ;
 ;       Example:  DVBOUT(0)=2^OK
 ;                 DVBOUT(1)="516^BAY PINES VA HCS^516"
 ;                 DVBOUT(2)="523^BOSTON HCS VAMC^523"
 ;
 N DVBPRS  ;parsed results array
 N DVBXML  ;1309 HL7v3 XML request
 N DVBXMLR  ;1310 HL7v3 XML results
 ;
 ;create the 1309 request message
 S DVBXML=$$CRE81309(DVBIID)
 ;
 ;transmit the message to the MVI
 D XMIT(DVBXML,.DVBXMLR)
 ;
 ;parse the returned 1310 result message
 I $D(DVBXMLR) D
 . D PARSE(.DVBXMLR,.DVBPRS)
 . ;
 . ;format the output array
 . D OUTPUT(.DVBPRS,.DVBRSLT)
 E  D
 . S DVBRSLT(0)=0_U_"Communication error occurred"
 Q
 ;
CRE81309(DVBIID) ; create 1309 request xml document
 ; This function creates the HL7v3 1309 Get Corresponding IDs
 ; Request xml document.
 ;
 ; DVBIID = Patient identifier delimited using "^"
 ;   Piece 1: Id
 ;   Piece 2: IdType
 ;   Piece 3: Assigning location
 ;   Piece 4: Assigning issuer
 ;
 ;   ex.  1008523099V750710^NI^200M^USVHA
 ;
 ;   Returns formatted XML for the search
 ;
 ; $$PARAM^HLCS2 - #3552 (need)
 ;
 N DVBSKEY   ;site key
 N DVBPCODE  ;HL7 processing code
 N MPIXML    ;function result
 ;
 S DVBPCODE=$P($$PARAM^HLCS2,"^",3)
 S DVBSKEY="200CAPR"
 ;
 ;Header
 S MPIXML="<PRPA_IN201309UV02 xmlns=""urn:hl7-org:v3"" "
 S MPIXML=MPIXML_"xmlns:ps=""http://vaww.oed.oit.domain.ext"" "
 S MPIXML=MPIXML_"xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance"
 S MPIXML=MPIXML_""" xsi:schemaLocation=""urn:hl7-org:v3 ../../schema/"
 S MPIXML=MPIXML_"HL7V3/NE2008/multicacheschemas/PRPA_IN201309UV02.xsd"
 S MPIXML=MPIXML_""" ITSVersion=""XML_1.0"">"
 S MPIXML=MPIXML_"<id root=""2.16.840.1.113883.4.349"" "
 S MPIXML=MPIXML_"extension=""MCID-12345""/>"
 S MPIXML=MPIXML_"<creationTime value="""_$$FMTHL7^XLFDT($$NOW^XLFDT())_"""/>"
 S MPIXML=MPIXML_"<interactionId root=""2.16.840.1.113883.1.6"" "
 S MPIXML=MPIXML_"extension=""PRPA_IN201309UV02""/>"
 S MPIXML=MPIXML_"<processingCode code="""_DVBPCODE_"""/>"
 S MPIXML=MPIXML_"<processingModeCode code=""T""/>"
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
 S MPIXML=MPIXML_"<code code=""PRPA_TE201309UV02"" "
 S MPIXML=MPIXML_"codeSystem=""2.16.840.1.113883.1.6""/>"
 S MPIXML=MPIXML_"<queryByParameter><queryId extension="""_$J_""""
 S MPIXML=MPIXML_" root=""2.16.840.1.113883.4.349""/>"
 S MPIXML=MPIXML_"<statusCode code=""new""/>"
 S MPIXML=MPIXML_"<responsePriorityCode code=""I"" />"
 S MPIXML=MPIXML_"<parameterList>"
 S MPIXML=MPIXML_"<patientIdentifier>"
 S MPIXML=MPIXML_"<value root=""2.16.840.1.113883.4.349"" extension="""_DVBIID_"""/>"
 S MPIXML=MPIXML_"<semanticsText>Patient.Id</semanticsText>"
 S MPIXML=MPIXML_"</patientIdentifier>"
 S MPIXML=MPIXML_"</parameterList>"
 S MPIXML=MPIXML_"</queryByParameter></controlActProcess>"
 S MPIXML=MPIXML_"</PRPA_IN201309UV02>"
 Q MPIXML
 ;
XMIT(DVBXML,DVBXMLR) ;
 ;
 ; $$GETPROXY^XOBWLIB - #5421
 ;
 N $ETRAP,$ESTACK,SVC
 ;
 ; set error trap
 S $ETRAP="DO ERROR^DVBAHWSC"
 ;
 ; make the call
 S SVC=$$GETPROXY^XOBWLIB("DVB_PSIM_EXECUTE","DVB_MVI_SERVER")
 S DVBXMLR=SVC.execute(DVBXML)
 ;
 Q
 ;
PARSE(DVBXML,DVBOUT) ;
 ;
 ; EN^MXMLPRSE - #4149
 ;
 K ^TMP($J,"DVBAMVI2")
 N DVBCB     ;parser callback array
 N DVBCNT    ;record counter
 S DVBCNT=0
 S DVBCB("STARTELEMENT")="SE^DVBAMVI2"
 S ^TMP($J,"DVBAMVI2",1)=DVBXML
 D EN^MXMLPRSE($NA(^TMP($J,"DVBAMVI2")),.DVBCB)
 K ^TMP($J,"DVBAMVI2")
 Q
 ;
SE(DVBNM,DVBATTR) ; - used for the parser to call back with STARTELEMENT
 ;
 ; prevent any undefined errors
 S DVBNM=$G(DVBNM)
 S DVBATTR("extension")=$G(DVBATTR("extension"))
 ;
 ;
 I DVBNM="id",$E(DVBATTR("extension"),1,4)="MCID" Q
 I DVBNM="id",DVBATTR("extension")?3N.NA Q
 I DVBNM="id",DVBATTR("extension")="" Q
 I DVBNM="id",DVBATTR("extension")["NI^200M^USVHA^P" Q
 ;
 ;response code
 I DVBNM="queryResponseCode",$G(DVBOUT(0))="" D  Q
 . S DVBOUT(0)=$S(DVBATTR("code")="NF":"No match found for "_DVBIID,1:DVBATTR("code"))
 ;
 ;set station numbers
 ;pattern match DFN_"^PI^"_stationNumber_"^USVHA^"_alpha
 I DVBNM="id",DVBATTR("extension")?1.N1"^PI^"2N.NA1"^USVHA^".A D  Q
 . S DVBOUT($P(DVBATTR("extension"),U,3))=""
 Q
 ;
OUTPUT(DVBIN,DVBOUT) ;
 ;This procedure formats the individual record lines and builds
 ;the results array output for the remote procedure.
 ;
 ;  Input:
 ;    DVBIN - array of station numbers
 ;
 ;  Output:
 ;    DVBOUT - array of lines each containing station IEN, name ,
 ;             and station number delimited by a caret ("^"). The
 ;             first array node contains the returned station count
 ;             and the query response.
 ;                  
 ;       Example:  DVBOUT(0)=2^OK
 ;                 DVBOUT(1)="516^BAY PINES VA HCS^516"
 ;                 DVBOUT(2)="523^BOSTON HCS VAMC^523"
 ;
 N DVBSTA  ;station number
 N DVBCNT  ;results counter
 N DVBIEN  ;INSTITUTION (#4) file IEN
 S DVBSTA=""
 S DVBCNT=0
 F  S DVBSTA=$O(DVBIN(DVBSTA)) Q:(DVBSTA="")  D
 . S DVBIEN=+$$IEN^XUAF4(DVBSTA)
 . I DVBIEN D
 . . S DVBCNT=DVBCNT+1
 . . S DVBOUT(DVBCNT)=DVBIEN_U_$$NS^XUAF4(DVBIEN)
 S DVBOUT(0)=DVBCNT_U_$G(DVBIN(0))
 Q
