ONCSAPIR ;Hines OIFO/SG - COLLABORATIVE STAGING (REQUEST)  ; 2/8/07 8:28am
 ;;2.11;ONCOLOGY;**40,41,44,47**;Mar 07, 1995;Build 19
 ;
 ; ONC8DST ------------- DESCRIPTOR OF THE DESTINATION BUFFER
 ;                       (a parameter of HEADER, PUT, and TRAILER)
 ;
 ; ONC8DST(              Closed root of the destination buffer
 ;   "PTR")              Pointer in the destination buffer
 ;   "PTRC")             Continuation pointer (optional)
 ;   "REQ")              Name of the root tag of the request
 ;
 Q
 ;
 ;***** APPENDS THE STRING TO THE LAST LINE OF THE DESTINATION BUFFER
 ;
 ; .ONC8DST      Reference to a descriptor of the destination buffer.
 ;
 ; STR           String
 ;
 ; [NOENC]       Disable XML encoding (enabled by default)
 ;
 ; This procedure appends the string as the continuation node
 ; to the last line added by the PUT^ONCSAPIR.
 ;
APPEND(ONC8DST,STR,NOENC) ;
 Q:$G(ONC8DST("PTR"))'>0
 N ENCSTR,I1,I2,S1
 S ENCSTR=$S('$G(NOENC):$$SYMENC^MXMLUTL(STR),1:STR)
 S I2=0
 F  S I1=I2+1,I2=I1+249,S1=$E(ENCSTR,I1,I2)  Q:S1=""  D
 . S ONC8DST("PTRC")=$G(ONC8DST("PTRC"))+1
 . S @ONC8DST@(ONC8DST("PTR"),ONC8DST("PTRC"))=S1
 Q
 ;
 ;***** CHECKS FOR PARSING AND WEB SERVICE ERRORS
 ;
 ; .ONCXML       Reference to the XML parsing descriptor
 ;
 ; [ONC8INFO]    Closed root of the variable that contains
 ;               additional information related to the error
 ;
 ; Return values:
 ;
 ;       <0  Error Descriptor
 ;        0  Ok
 ;        1  Warning(s)
 ;
CHKERR(ONCXML,ONC8INFO) ;
 N RC,TMP
 I $G(ONCXML("ERR"))>0  Q $$ERROR^ONCSAPIE(-5)
 I $G(ONCXML("FAULTCODE"))'=""  D  Q RC
 . S TMP=$TR($G(ONCXML("FAULTSTRING")),"^","~")
 . S:TMP="" TMP="Unknown error"
 . S RC="-2"_U_ONCXML("FAULTCODE")_": "_TMP
 . D STORE^ONCSAPIE(RC,$G(ONC8INFO))
 . ;--- Error code -11 is returned by the web-service if the
 . ;    CStage_calculate function calculated only some staging
 . ;--- values and returned warning(s).
 . S:+$G(ONCXML("RC"))=-11 RC=1
 Q 0
 ;
 ;***** STORES THE REQUEST HEADER INTO THE DESTINATION BUFFER
 ;
 ; .ONC8DST      Reference to a descriptor of the destination buffer.
 ;
 ; REQUEST       Name of the root tag of the request.
 ;
 ; [.ATTS]       Reference to a local variable that stores a list
 ;               of attribute values (ATTS(name)=value).
 ;
HEADER(ONC8DST,REQUEST,ATTS) ;
 ;;<soap:Envelope xmlns:soap="http://www.w3.org/2001/12/soap-envelope"
 ;; soap:encodingStyle="http://www.w3.org/2001/12/soap-encoding">
 ;;<soap:Body>
 ;
 N I,TAG,TMP
 S ONC8DST("PTR")=0  K @ONC8DST
 D PUT(.ONC8DST,,$$XMLHDR^MXMLUTL())
 F I=1:1  S TMP=$P($T(HEADER+I),";;",2)  Q:TMP=""  D
 . D PUT(.ONC8DST,,TMP)
 S TAG=REQUEST,I=""
 F  S I=$O(ATTS(I))  Q:I=""  D
 . S TAG=TAG_" "_I_"="""_$$SYMENC^MXMLUTL(ATTS(I))_""""
 S TAG=TAG_" ver=""2.0"" xmlns=""http://websrv.oncology.med.va.gov"""
 D PUT(.ONC8DST,TAG,,1)
 S ONC8DST("REQ")=REQUEST
 Q
 ;
 ;***** CONVERTS INPUT PARAMETERS INTO XML FORMAT
 ;
 ; ONC8DST       Closed root of the destination buffer
 ;
 ; REQUEST       Name of the root tag of the request.
 ;
 ; [.INPUT]      Reference to a local variable containg
 ;               input parameters.
 ;
 ; Return values:
 ;
 ;       <0  Error Descriptor
 ;        0  Ok
 ;
PARAMS(ONC8DST,REQUEST,INPUT) ;
 N I,NAME,VAL
 D HEADER(.ONC8DST,REQUEST)
 ;---
 S NAME=""
 F  S NAME=$O(INPUT(NAME))  Q:NAME=""  D
 . S VAL=$G(INPUT(NAME))  D:VAL'="" PUT(.ONC8DST,NAME,VAL)
 ;---
 D TRAILER(.ONC8DST)
 Q 0
 ;
 ;***** ADDS THE ELEMENT/TEXT TO THE DESTINATION BUFFER
 ;
 ; .ONC8DST      Reference to a descriptor of the destination buffer.
 ;
 ; [NAME]        Name of the element. If omitted or empty then the
 ;               text line defined by the second parameter is added
 ;               to the buffer.
 ;
 ; [VAL]         Value of the element.
 ;
 ; [TAGONLY]     Ignore the value and output only the tag defined
 ;               by the NAME parameter
 ;
PUT(ONC8DST,NAME,VAL,TAGONLY) ;
 S (ONC8DST("PTR"),PTR)=ONC8DST("PTR")+1  K ONC8DST("PTRC")
 I $G(NAME)=""  S @ONC8DST@(PTR)=$G(VAL)        Q
 I $G(TAGONLY)  S @ONC8DST@(PTR)="<"_NAME_">"   Q
 I $G(VAL)=""   S @ONC8DST@(PTR)="<"_NAME_"/>"  Q
 S @ONC8DST@(PTR)="<"_NAME_">"_$$SYMENC^MXMLUTL(VAL)_"</"_NAME_">"
 Q
 ;
 ;***** SENDS THE REQUEST AND GETS THE RESPONSE
 ;
 ; URL           URL (http://host:port/path)
 ;
 ; ONC8RSP       Closed root of the variable where the
 ;               response text will be returned.
 ;
 ; [ONC8REQ]     Closed root of the variable containing
 ;               the text of the request.
 ;
 ; Return Values:
 ;        0  Ok
 ;       <0  Error code
 ;
REQUEST(URL,ONC8RSP,ONC8REQ) ;
 N HS,ONCINFO,ONCRHDR,ONCSHDR,RC,REPCNT,REPEAT,TMP
 ;--- Prepare the request header
 S ONCSHDR("Content-Type")="text/xml"
 ;---
 S (RC,REPCNT)=0  D
 . F  S REPEAT=0  D  Q:'REPEAT
 . . ;--- Call the web service
 . . S RC=$$GETURL^ONCX10(URL,60,ONC8RSP,.ONCRHDR,$G(ONC8REQ),.ONCSHDR)
 . . S HS=+RC  Q:HS=200
 . . ;--- Temporary redirection
 . . I HS=302  D  Q
 . . . S REPCNT=REPCNT+1
 . . . I REPCNT>5  S RC=$$ERROR^ONCSAPIE(-12,,REPCNT)  Q
 . . . S URL=$G(ONCRHDR("LOCATION"))
 . . . I URL?." "  S RC=$$ERROR^ONCSAPIE(-18)          Q
 . . . D ERROR^ONCSAPIE(-7,,URL)  S REPEAT=1,RC=0
 . . ;--- Permanent redirection
 . . I HS=301  D  Q
 . . . S REPCNT=REPCNT+1
 . . . I REPCNT>5  S RC=$$ERROR^ONCSAPIE(-12,,REPCNT)  Q
 . . . S URL=$G(ONCRHDR("LOCATION"))
 . . . I URL?." "  S RC=$$ERROR^ONCSAPIE(-18)          Q
 . . . S RC=$$UPDCSURL^ONCSAPIU(URL)                   Q:RC<0
 . . . D ERROR^ONCSAPIE(-8,,URL)  S REPEAT=1,RC=0
 . . ;--- Record the HTTP client error
 . . K ONCINFO  S ONCINFO(1)=$P(RC,U,2)_" ("_$P(RC,U)_")"
 . . S RC=$$ERROR^ONCSAPIE(-10,.ONCINFO)
 . Q:RC<0
 ;---
 Q $S(RC<0:RC,1:0)
 ;
 ;***** APPENDS THE REQUEST TRAILER TO THE DESTINATION BUFFER
 ;
 ; .ONC8DST      Reference to a descriptor of the destination buffer.
 ;
TRAILER(ONC8DST) ;
 S ONC8DST("PTR")=+$O(@ONC8DST@(""),-1)
 D PUT(.ONC8DST,"/"_ONC8DST("REQ"),,1)
 D PUT(.ONC8DST,"/soap:Body",,1)
 D PUT(.ONC8DST,"/soap:Envelope",,1)
 Q
