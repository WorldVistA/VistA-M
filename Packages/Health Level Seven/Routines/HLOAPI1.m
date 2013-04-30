HLOAPI1 ;;ALB/CJM-HL7 - Developer API's for sending & receiving messages(continued) ;03/12/2012
 ;;1.6;HEALTH LEVEL SEVEN;**126,132,134,137,146,158**;Oct 13, 1995;Build 14
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
SENDONE(HLMSTATE,PARMS,WHOTO,ERROR) ;Sends the message to a single receiving application.
 ;;
 ;;Input:
 ;;HLMSTATE() - (pass by reference, required) This array is used by the HL7 package to track the progress of the message.  The application MUST NOT touch it
 ;;PARMS( *pass by reference*
 ;;  "APP ACK RESPONSE")=<tag^routine> to call when the app ack is received (optional)
 ;;    (NOTE: For batch messages, HLO best supports returning application
 ;;     acknowledgments via a batch response.  However, non-VistA systems
 ;;     may return individual messages as application acknowledgments to
 ;;     messages within the original batch message, so for applications
 ;;     sending batch messages might best code the "APP ACK RESPONSE"
 ;;     routine to first check whether the response message is a batch.
 ;; 
 ;;  "ACCEPT ACK RESPONSE")=<tag^routine> to call when the commit ack is received (optional)
 ;;  "ACCEPT ACK TYPE") = <AL,NE> (optional, defaults to AL)
 ;;  "APP ACK TYPE") = <AL,NE> (optional, defaults to NE)
 ;;  "FAILURE RESPONSE" - <tag>^<routine> (optional) The sending application routine to execute when the transmission of the message fails, i.e., the message can not be sent or no commit ack is received.
 ;;  "QUEUE" - (optional) An application can name its own private queue - just a string up to 20 characters, it should be namespaced.
 ;;  "SECURITY")=security information to include in the header segment, SEQ 8 (optional)
 ;;  "SEQUENCE QUEUE") (optional) sequence queue to use, up to 30 characters, shoud lbe namespaced.  Requires that application acks be used.
 ;;  "SENDING APPLICATION")=name of sending app (required, 60 maximum length)
 ;;
 ;;  WHOTO (required,pass by reference) an array specifying a single recipient. These subscripts are allowed:
 ;;
 ;;    "RECEIVING APPLICATION" - (string, 60 char max, required)
 ;;
 ;;  EXACTLY ONE of these parameters must be provided to identify the Receiving Facility:
 ;;
 ;;   "FACILITY LINK IEN" - ien of the logical link 
 ;;   "FACILITY LINK NAME" - name of the logical link 
 ;;   "INSTITUTION IEN" - ptr to the INSTITUTION file
 ;;   "STATION NUMBER" -  station # with suffix
 ;;
 ;;  EXACTLY ONE of these MAY be provided - optionally - to identify the interface engine to route the message through:
 ;;
 ;;   *"IE LINK IEN" (obsolete)  ptr to a logical link for the interface engine 
 ;;   *"IE LINK NAME" (obsolete) name of the logical link for the interface engine
 ;;   "MIDDLEWARE LINK IEN" -  ptr to a logical link for the middleware 
 ;;   "MIDDLEWARE LINK NAME" - the name of the logical link for the middleware
 ;;
 ;;Output:
 ;;  Function returns the ien of the message in file 778 on success, 0 on failure
 ;;   HLMSTATE() - (pass by reference, required) This array is used by the HL7 package to track the progress of the message.  The application MUST NOT touch it!
 ;;   ERROR (pass by reference, optional) - on failure, will contain an error message
 ;;   PARMS - left undefined when the function returns
 ;;   WHOTO - left undefined when the function returns
 ;;
 ;;
 N SUCCESS,ERR1,ERR2
 S SUCCESS=0
 D
 .I '$G(HLMSTATE("BODY")),'$G(HLMSTATE("UNSTORED LINES")) S ERROR="MESSAGE NOT YET CREATED" Q
 .;;
 .I $$CHKPARMS^HLOAPI2(.HLMSTATE,.PARMS,.ERR1)&$$CHKWHO^HLOAPI2(.HLMSTATE,.WHOTO,.ERR2) D
 ..I $$SEND(.HLMSTATE,.ERROR) S SUCCESS=1
 .E  D
 ..S ERROR=$G(ERR1)_": "_$G(ERR2)
 ..D DONTSEND(.HLMSTATE,ERROR)
 K PARMS,WHOTO
 Q $S(SUCCESS:HLMSTATE("IEN"),1:0)
 ;;
SENDMANY(HLMSTATE,PARMS,WHOTO) ;;
 ;;Sends the message to a list of receiving applications
 ;;
 ;;Input: Same as for $$SENDONE, except WHOTO is a list.
 ;;  WHOTO (pass by reference)
 ;;    Specifies a list of recipients.  Each recipient should be on the
 ;;    list as WHOTO(i), where i=1,2,3,4, etc. for as many messages as to
 ;;    send.  At each subscript WHOTO(i), the same lower level subscripts
 ;;    may be defined as in the $$SENDONE API.  For example:
 ;;
 ;;      WHOTO(1,"FACILITY LINK NAME")="VAALB"
 ;;      WHOTO(1,"RECEIVING APPLICATION")="MPI"
 ;;      WHOTO(2,"STATION NUMBER")=500
 ;;      WHOTO(2,"RECEIVING APPLICATION")="MPI"
 ;;
 ;;
 ;;Output:
 ;;  Function returns 1 if a message is queued to be sent to each intended recipient, 0 otherwise
 ;;  PARMS - left undefined when the function returns
 ;;  WHOTO (pass by reference) returns the status of each message to be sent in the format:
 ;;    (<i>,"QUEUED")= <1 if queued to be sent, 0 otherwise)
 ;;   (<i>,"IEN")=<ien, file 778>
 ;;   (<i>,"ERROR")= error message if an error was encountered (status=0), not defined otherwise
 ;;
 ;;
 N ERROR,RETURN,WHO,STATE,I
 S RETURN=1
 I '$G(HLMSTATE("BODY")),'$G(HLMSTATE("UNSTORED LINES")) D  K PARMS Q 0
 .S ERROR="MESSAGE NOT YET CREATED"
 .S I=0 F  S I=$O(WHOTO(I)) Q:'I  S WHOTO(I,"QUEUED")=0,WHOTO(I,"IEN")=0,WHOTO(I,"ERROR")=ERROR
 ;;
 I '$$CHKPARMS^HLOAPI2(.HLMSTATE,.PARMS,.ERROR) D  K PARMS Q 0
 .S I=0 F  S I=$O(WHOTO(I)) Q:'I  D
 ..K WHO M WHO=WHOTO(I)
 ..K STATE M STATE=HLMSTATE S STATE("IEN")=""
 ..S WHOTO(I,"QUEUED")=0
 ..D DONTSEND(.STATE,$G(ERROR))
 ..S WHOTO(I,"IEN")=$G(STATE("IEN"))
 ..S WHOTO(I,"ERROR")=ERROR
 ;;
 S I=0 F  S I=$O(WHOTO(I)) Q:'I  D
 .K WHO M WHO=WHOTO(I)
 .K STATE M STATE=HLMSTATE S STATE("IEN")=""
 .S ERROR=""
 .I $$CHKWHO^HLOAPI2(.STATE,.WHO,.ERROR) D
 ..I $$SEND(.STATE,.ERROR) D
 ...S WHOTO(I,"QUEUED")=1
 ...S WHOTO(I,"IEN")=STATE("IEN")
 ...S WHOTO(I,"ERROR")=""
 ..E  D
 ...S WHOTO(I,"QUEUED")=0
 ...S WHOTO(I,"IEN")=$G(STATE("IEN"))
 ...S WHOTO(I,"ERROR")=$G(ERROR)
 ...S RETURN=0
 .E  D  ;;who not adequately determined
 ..S WHOTO(I,"QUEUED")=0,RETURN=0
 ..D DONTSEND(.STATE,$G(ERROR))
 ..S WHOTO(I,"IEN")=$G(STATE("IEN")),WHOTO(I,"ERROR")=$G(ERROR)
 K PARMS
 Q RETURN
 ;;
SENDSUB(HLMSTATE,PARMS,MESSAGES) ;;
 ;;Sends the message to a list of receiving applications based on the HL7 Subscription Registry
 ;;
 ;;Input:
 ;;  HLMSTATE (pass by reference, required) same as $$SENDMANY
 ;;  PARMS (pass by reference, required) same as $$SENDMANY, with one additional subscript:
 ;;    "SUBSCRIPTION IEN" - the ien of an entry in the HL7 Subscription Registry, defining the intended recipients of this message
 ;;
 ;;Output:
 ;;  Function returns 1 if a message is queued to be sent to each intended recipient, 0 otherwise
 ;;  PARMS - left undefined when the function returns
 ;;  MESSAGES (pass by reference) returns the status of each message to be sent in this format, where subien is the ien of the recipient in the RECIPEINTS subfile of the HL7 Subscription Registry
 ;;   (<subien>,"QUEUED")= <1 if queued to be sent, 0 otherwise)
 ;;   (<subien>,"IEN")=<ien, file 778>
 ;;   (<subien>,"ERROR")= error message if an error was encountered (status=0), not defined otherwise
 ;;
 ;;
 K MESSAGES
 N ERROR,RETURN,STATE,SUBIEN,WHO
 ;;
 S RETURN=1
 ;;
 ;;
 I '$G(HLMSTATE("BODY")),'$G(HLMSTATE("UNSTORED LINES")) S ERROR="MESSAGE NOT YET CREATED" K PARMS Q 0
 I '$G(PARMS("SUBSCRIPTION IEN")) S ERROR="SUBSCRIPTION REGISTRY IEN NOT PROVIDED" K PARMS Q 0
 ;;
 I '$$CHKPARMS^HLOAPI2(.HLMSTATE,.PARMS,.ERROR) D  K PARMS Q 0
 .S SUBIEN=0 F  S SUBIEN=$$NEXT^HLOASUB(PARMS("SUBSCRIPTION IEN"),.WHO) Q:'SUBIEN  D
 ..N SARY,HARY
 ..S HARY="STATE(""HDR"")"
 ..S SARY="STATE(""STATUS"")"
 ..K STATE M STATE=HLMSTATE S STATE("IEN")=""
 ..;;move parameters into HLMSTATE
 ..S @SARY@("LINK IEN")=WHO("LINK IEN")
 ..S @SARY@("LINK NAME")=WHO("LINK NAME")
 ..S @HARY@("RECEIVING APPLICATION")=WHO("RECEIVING APPLICATION")
 ..M @HARY@("RECEIVING FACILITY")=WHO("RECEIVING FACILITY")
 ..D DONTSEND(.STATE,$G(ERROR))
 ..S MESSAGES(SUBIEN,"QUEUED")=0
 ..S MESSAGES(SUBIEN,"IEN")=$G(STATE("IEN"))
 ..S MESSAGES(SUBIEN,"ERROR")=$G(ERROR)
 ;;
 F  S SUBIEN=$$NEXT^HLOASUB(PARMS("SUBSCRIPTION IEN"),.WHO) Q:'SUBIEN  D
 .N SARY,HARY
 .S HARY="STATE(""HDR"")"
 .S SARY="STATE(""STATUS"")"
 .K STATE M STATE=HLMSTATE S STATE("IEN")=""
 .;;move parameters into HLMSTATE
 .S @SARY@("LINK IEN")=WHO("LINK IEN")
 .S @SARY@("LINK NAME")=WHO("LINK NAME")
 .S @HARY@("RECEIVING APPLICATION")=WHO("RECEIVING APPLICATION")
 .M @HARY@("RECEIVING FACILITY")=WHO("RECEIVING FACILITY")
 .S ERROR=""
 .I $$SEND(.STATE,.ERROR) D
 ..S MESSAGES(SUBIEN,"QUEUED")=1
 .E  D
 ..S MESSAGES(SUBIEN,"QUEUED")=0,RETURN=0
 .S MESSAGES(SUBIEN,"IEN")=$G(STATE("IEN")),MESSAGES(SUBIEN,"ERROR")=$G(ERROR)
 K PARMS
 Q RETURN
 ;;
SEND(HLMSTATE,ERROR) ;
 ;;
 K ERROR
 I HLMSTATE("UNSTORED LINES"),'$$SAVEMSG^HLOF777(.HLMSTATE) S ERROR="$$SAVE^HLOF777 FAILED!" Q 0
 ;;
 I '$$SAVEMSG^HLOF778(.HLMSTATE) S ERROR="$$SAVE^HLOF778 FAILED!" Q 0
 I HLMSTATE("BATCH"),$L($G(HLMSTATE("STATUS","SEQUENCE QUEUE"))) S ERROR="SEQUENCE QUEUES NOT SUPPORTED FOR BATCH MESSAGES" Q 0
 I $L($G(HLMSTATE("STATUS","SEQUENCE QUEUE"))) D
 .S HLMSTATE("STATUS","MOVED TO OUT QUEUE")=$$SQUE^HLOQUE(HLMSTATE("STATUS","SEQUENCE QUEUE"),HLMSTATE("STATUS","LINK NAME"),$G(HLMSTATE("STATUS","PORT")),HLMSTATE("STATUS","QUEUE"),HLMSTATE("IEN")) D:HLMSTATE("STATUS","MOVED TO OUT QUEUE")
 ..S $P(^HLB(HLMSTATE("IEN"),5),"^",2)=1
 E  D
 .D OUTQUE^HLOQUE(HLMSTATE("STATUS","LINK NAME"),$G(HLMSTATE("STATUS","PORT")),HLMSTATE("STATUS","QUEUE"),HLMSTATE("IEN"))
 Q HLMSTATE("IEN")
 ;
DONTSEND(HLMSTATE,ERROR) ;
 ;;This procedure does NOT send a message.  Rather, it creates an entry in file 778 with the status ER.  
 ;;Input:
 ;;       HLMSTATE - pass-by-reference
 ;;       ERROR (optional, pass-by-value) error text to store with the message
 ;;Output: none
 ;;
 D:HLMSTATE("UNSTORED LINES") SAVEMSG^HLOF777(.HLMSTATE)
 ;;
 S HLMSTATE("STATUS")="ER"
 ;
 S HLMSTATE("STATUS","ERROR TEXT")=$G(ERROR)
 D SAVEMSG^HLOF778(.HLMSTATE)
 D SETPURGE^HLOF778A($G(HLMSTATE("IEN")),"ER",$S($G(HLMSTATE("ACK TO IEN")):HLMSTATE("ACK TO IEN"),1:""))
 Q
