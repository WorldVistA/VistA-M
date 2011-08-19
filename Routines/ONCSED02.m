ONCSED02 ;Hines OIFO/SG - EDITS 'RUN BATCH' (PARSER)  ; 8/16/06 1:07pm
 ;;2.11;ONCOLOGY;**47**;Mar 07, 1995;Build 19
 ;
 ;--- SOAP RESPONSE FROM THE ONCOLOGY WEB SERVICE
 ;
 ; <?xml version="1.0" encoding="utf-8"?>
 ; <soap:Envelope
 ;   xmlns:soap="http://www.w3.org/2001/12/soap-envelope"
 ;   soap:encodingStyle="http://www.w3.org/2001/12/soap-encoding">
 ;   <soap:Body>
 ;     <ED-RESPONSE xmlns="http://vista.med.va.gov/oncology">
 ;       <EDIT-SET NAME="..." ECNT="...">
 ;         <EDIT INDEX="..." NAME="..." ECNT="..." WCNT="...">
 ;           <FLD NAME="..." POS="..."> ... </FLD>
 ;           ...
 ;           <MSG CODE="..." TYPE="..."> ... </MSG>
 ;           ...
 ;         </EDIT>
 ;       </EDIT-SET>
 ;       <METAVER> ... </METAVER>
 ;       <VERSION> ... </VERSION>
 ;     </ED-RESPONSE>
 ;     <soap:Fault>
 ;       <faultcode> ... </faultcode>
 ;       <faultstring> ... </faultstring>
 ;       <detail>
 ;         <RC> ... </RC>
 ;       </detail>
 ;     </soap:Fault>
 ;   </soap:Body >
 ; </soap:Envelope>
 ;
 ;--- ATTRIBUTES
 ;
 ; TYPE          E - Error, W - Warning, M - Message
 ;
 Q
 ;
 ;***** END ELEMENT CALLBACK FOR THE SAX PARSER
 ;
 ; ELMT          Name of the element
 ;
ENDEL(ELMT) ;
 N L,LAST2
 S L=$L(ONCXML("PATH"),","),LAST2=$P(ONCXML("PATH"),",",L-1,L)
 D ENDEL^ONCSAPIX(ELMT)
 ;---
 I LAST2="EDIT,FLD"  D  Q
 . S @ONCXML@(ONCESIEN,"E",ONCEDIEN,"F",ONCFIEN,2)=$G(ONCXML("TEXT"))
 ;---
 I LAST2="EDIT,MSG"  D  Q
 . S @ONCXML@(ONCESIEN,"E",ONCEDIEN,"M",ONCMIEN,1)=$G(ONCXML("TEXT"))
 ;---
 I LAST2="ED-RESPONSE,METAVER"  D  Q
 . S $P(@ONCXML@(0),U,4)=$G(ONCXML("TEXT"))
 ;---
 I LAST2="ED-RESPONSE,VERSION"  D  Q
 . S $P(@ONCXML@(0),U,3)=$G(ONCXML("TEXT"))
 Q
 ;
 ;***** PARSES THE RESPONSE FROM THE EDITS API
 ;
 ; [.ONCSAPI]    Reference to the API descriptor (see ^ONCSAPI)
 ;
 ; ONC8RDAT      Closed root of the XML response
 ;
 ; ONCXML        Closed root of the output buffer.
 ;
PARSE(ONCSAPI,ONC8RDAT,ONCXML) ;
 N ONCEDIEN      ; Current edit IEN
 N ONCESIEN      ; Current edit set IEN
 N ONCFIEN       ; Current field IEN
 N ONCMIEN       ; Current message IEN
 ;
 N CBK,EDIEN,ESIEN,ESTOTALS,I,RC,TMP,TOTALS
 D SETCBK(.CBK),EN^MXMLPRSE(ONC8RDAT,.CBK,"W")
 D:$G(ONCSAPI("DEBUG"))
 . D ZW^ONCSAPIU(ONCXML,"*** PARSED 'RUN BATCH' RESPONSE ***")
 ;--- Calculate the totals
 S ESIEN=0
 F  S ESIEN=$O(@ONCXML@(ESIEN))  Q:ESIEN'>0  D
 . S EDIEN=0  K ESTOTALS
 . F  S EDIEN=$O(@ONCXML@(ESIEN,"E",EDIEN))  Q:EDIEN'>0  D
 . . S TMP=$G(@ONCXML@(ESIEN,"E",EDIEN,0))
 . . F I=1,2  S ESTOTALS(I)=$G(ESTOTALS(I))+$P(TMP,U,I)
 . F I=1,2  S TOTALS(I)=$G(TOTALS(I))+$G(ESTOTALS(I))
 . S $P(@ONCXML@(ESIEN,0),U,1,2)=$G(ESTOTALS(1),0)_U_$G(ESTOTALS(2),0)
 S $P(@ONCXML@(0),U,1,2)=$G(TOTALS(1),0)_U_$G(TOTALS(2),0)
 ;--- Check for parsing and web-service errors
 Q $$CHKERR^ONCSAPIR(.ONCXML)
 ;
 ;***** SETS THE EVENT INTERFACE ENTRY POINTS
SETCBK(CBK) ;
 ;;CHARACTERS  ^   TEXT^ONCSED02
 ;;ENDELEMENT  ^  ENDEL^ONCSED02
 ;;STARTELEMENT^STARTEL^ONCSED02
 ;
 D SETCBK^ONCSAPIX(.CBK,"SETCBK^ONCSED02")
 Q
 ;
 ;***** START ELEMENT CALLBACK FOR THE SAX PARSER
 ;
 ; ELMT          Name of the element
 ;
 ; .ATTR         List of attributes and their values
 ;
STARTEL(ELMT,ATTR) ;
 N L,LAST2,TMP
 D STARTEL^ONCSAPIX(ELMT,.ATTR)
 S L=$L(ONCXML("PATH"),","),LAST2=$P(ONCXML("PATH"),",",L-1,L)
 ;--- Field
 I LAST2="EDIT,FLD"  D  Q
 . S ONCFIEN=$G(ONCFIEN)+1
 . S @ONCXML@(ONCESIEN,"E",ONCEDIEN,"F",ONCFIEN,0)=$G(ATTR("POS"))
 . S @ONCXML@(ONCESIEN,"E",ONCEDIEN,"F",ONCFIEN,1)=$G(ATTR("NAME"))
 ;--- Message
 I LAST2="EDIT,MSG"  D  Q
 . S ONCMIEN=$G(ONCMIEN)+1
 . S TMP=$G(ATTR("CODE"))_U_$G(ATTR("TYPE"))
 . S @ONCXML@(ONCESIEN,"E",ONCEDIEN,"M",ONCMIEN,0)=TMP
 ;--- Edit
 I LAST2="EDIT-SET,EDIT"  D  Q
 . S ONCEDIEN=$G(ONCEDIEN)+1,(ONCFIEN,ONCMIEN)=0
 . S TMP=$G(ATTR("ECNT"))_U_$G(ATTR("WCNT"))_U_$G(ATTR("INDEX"))
 . S @ONCXML@(ONCESIEN,"E",ONCEDIEN,0)=TMP
 . S @ONCXML@(ONCESIEN,"E",ONCEDIEN,1)=$G(ATTR("NAME"))
 . S @ONCXML@("ES",ONCEDIEN)=ONCESIEN
 ;--- Edit Set
 I LAST2="ED-RESPONSE,EDIT-SET"  D  Q
 . S ONCESIEN=$G(ONCESIEN)+1
 . S @ONCXML@(ONCESIEN,0)=$G(ATTR("ECNT"))_U_$G(ATTR("WCNT"))
 . S @ONCXML@(ONCESIEN,1)=$G(ATTR("NAME"))
 Q
 ;
 ;***** TEXT CALLBACK FOR THE SAX PARSER
 ;
 ; TXT           Line of unmarked text
 ;
TEXT(TXT) ;
 S ONCXML("TEXT")=$G(ONCXML("TEXT"))_TXT
 ;--- Default processing
 D TEXT^ONCSAPIX(TXT)
 Q
