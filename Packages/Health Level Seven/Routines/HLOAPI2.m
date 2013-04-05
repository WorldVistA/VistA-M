HLOAPI2 ;ALB/CJM/OAK/RBN-HL7 - Developer API's for sending application acks ;07/12/2012
 ;;1.6;HEALTH LEVEL SEVEN;**126,131,133,134,137,138,146,158**;Oct 13, 1995;Build 14
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
ACK(HLMSTATE,PARMS,ACK,ERROR) ;; Default behavior is to return a general
 ;;application ack. The application may optionally specify the message
 ;;type and event or call $$ADDSEG^HLOAPI to add segments.
 ;;A generic MSA segment (components 1-3) is added automatically IF the
 ;;application doesn't call $$ADDSEG^HLOAPI to add an MSA segment as the
 ;;FIRST segment following the header.
 ;;$$SENDACK must be called when the ack is completed. The return
 ;;destination is determined automatically from the original message
 ;;
 ;;This API should NOT be called for batch messages, use $$BATCHACK instead.
 ;;Input:
 ;;  HLMSTATE (pass by reference, required) the array obtained by calling $$STARTMSG^HLOPRS when parsing the original message 
 ;;  PARMS (pass by reference) These subscripts may be defined:
 ;;    "ACK CODE" (required) MSA1[ {AA,AE,AR}
 ;;    "ERROR MESSAGE" - MSA3, should be used only if AE or AR
 ;;    "ACCEPT ACK RESPONSE" - the <tag^routine> to call when the commit ack is received (optional)
 ;;    "ACCEPT ACK TYPE" - {AL,NE} (optional, defaults to AL)
 ;;    "CONTINUATION POINTER" (optional)indicates a fragmented message
 ;;    "COUNTRY" - the 3 character country code (optional)
 ;;    "EVENT" - the 3 character event type (optional, defaults to the event code of the original message)
 ;;    "ENCODING CHARACTERS" - the four HL7 encoding characters (optional,defaults to "^~\&"
 ;;    "FAILURE RESPONSE" (optional) the <tag>^<routine> that the sending application routine should execute if the transmission of the message fails, i.e., the message can not be sent or a requested commit ack is not received.
 ;;    "FIELD SEPARATOR" - field separator (optional, defaults to "|")
 ;;    "MESSAGE TYPE" - if not defined, ACK is used
 ;;    "MESSAGE STRUCTURE" (optional)
 ;;    "RETURN LINK NAME" (optional)
 ;;    "RETURN LINK IEN" (optional)
 ;;    "QUEUE" - (optional) An application can name its own private queue (a string under 20 characters,namespaced). The default is the name of the queue of the original message
 ;;    "SECURITY" (optional) security information to include in the header segment, SEQ 8 (optional)
 ;;    "VERSION" - the HL7 Version ID (optional, defaults to 2.4)
 ;;Output:
 ;;  Function returns 1 on success, 0 on failure
 ;;  PARMS - left undefined when the function returns
 ;;  ACK (pass by reference, required) the acknowledgment message being built.
 ;;  ERROR (pass by reference) error msg
 ;;  
 N I,SEG,TOLINK,SUCCESS
 S SUCCESS=0,(TOLINK,ERROR)=""
 ;
 D
 .N PORT S PORT=""
 .I $G(PARMS("ACK CODE"))'="AA",$G(PARMS("ACK CODE"))'="AE",$G(PARMS("ACK CODE"))'="AR" S ERROR="INVALID ACK CODE" Q
 .;
 .I '$G(HLMSTATE("IEN")) S ERROR="ORIGINAL MESSAGE TO ACKNOWLEDGE IS NOT IDENTIFIED" Q
 .I $G(HLMSTATE("BATCH")) S ERROR="BATCH ACKNOWLEDGMENTS MUST USE $$BATCHACK^HLOAPI3" Q
 .;
 .I $G(HLMSTATE("HDR","MESSAGE CONTROL ID"))="" S ERROR="MESSAGE CONTROL ID MUST EXIST TO RETURN AN APPLICATION ACK" Q
 .S PARMS("MESSAGE TYPE")=$G(PARMS("MESSAGE TYPE"),"ACK")
 .S:PARMS("MESSAGE TYPE")="ACK" PARMS("MESSAGE STRUCTURE")="ACK"
 .S PARMS("EVENT")=$G(PARMS("EVENT"),$G(HLMSTATE("HDR","EVENT")))
 .I $$NEWMSG^HLOAPI(.PARMS,.ACK)  ;can't fail!
 .;
 .;if the return link can not be determined, the HL Logical Link file has a problem that must be fixed at the site
 .I $G(PARMS("RETURN LINK IEN")) D
 ..S TOLINK=$P($G(^HLCS(870,PARMS("RETURN LINK IEN"),0)),"^")
 ..S PORT=$$PORT2^HLOTLNK(TOLINK)
 .E  I $L($G(PARMS("RETURN LINK NAME"))) D
 ..S TOLINK=PARMS("RETURN LINK NAME")
 ..S PORT=$$PORT2^HLOTLNK(TOLINK)
 .E  D
 ..S TOLINK=$$ACKLINK(.HLMSTATE,.PORT)
 .I (TOLINK="")!('PORT) S ERROR="TRANSMISSION LINK FOR APPLICATION ACK CANNOT BE DETERMINED" Q
 .;
 .S ACK("HDR","APP ACK TYPE")="NE"
 .S ACK("HDR","ACCEPT ACK TYPE")=$G(PARMS("ACCEPT ACK TYPE"),"AL")
 .S ACK("STATUS","QUEUE")=$G(PARMS("QUEUE"),$G(HLMSTATE("STATUS","QUEUE")))
 .S ACK("STATUS","PORT")=PORT
 .S ACK("HDR","SECURITY")=$G(PARMS("SECURITY"))
 .S ACK("HDR","SENDING APPLICATION")=$G(HLMSTATE("HDR","RECEIVING APPLICATION"))
 .S ACK("HDR","RECEIVING APPLICATION")=$G(HLMSTATE("HDR","SENDING APPLICATION"))
 .F I=1:1:3 S ACK("HDR","RECEIVING FACILITY",I)=$G(HLMSTATE("HDR","SENDING FACILITY",I))
 .S ACK("ACK TO","STATUS")=$S(PARMS("ACK CODE")="AA":"SU",1:"ER")
 .S ACK("ACK TO")=$G(HLMSTATE("HDR","MESSAGE CONTROL ID"))
 .S ACK("ACK TO IEN")=HLMSTATE("IEN")
 .S ACK("STATUS","LINK NAME")=TOLINK
 .S ACK("LINE COUNT")=0
 . ;; Next line modified for HL*1.6*138 - RBN
 .;;S ACK("MSA")="MSA"_ACK("HDR","FIELD SEPARATOR")_PARMS("ACK CODE")_ACK("HDR","FIELD SEPARATOR")_$G(HLMSTATE("HDR","MESSAGE CONTROL ID"))_ACK("HDR","FIELD SEPARATOR")_$G(PARMS("ERROR MESSAGE"))
 .S ACK("MSA")="MSA"_ACK("HDR","FIELD SEPARATOR")_PARMS("ACK CODE")_ACK("HDR","FIELD SEPARATOR")_$G(HLMSTATE("HDR","MESSAGE CONTROL ID"))_ACK("HDR","FIELD SEPARATOR")_$$ESCAPE^HLOPBLD(.HLMSTATE,$G(PARMS("ERROR MESSAGE")))
 .S SUCCESS=1
 K PARMS
 K:'SUCCESS ACK
 Q SUCCESS
 ;
SENDACK(ACK,ERROR) ;;This is used to signal that an application acknowledgment is complete.
 ;;Input:
 ;;  ACK (pass by reference,required) An array that contains the acknowledgment msg
 ;;Output:
 ;; Function returns 1 on success, 0 on failure
 ;; ERROR (pass by reference) error msg
 ;;
 N SEG
 ;if the application added its own MSA, then the ACK("MSA") node was killed
 I $D(ACK("MSA")) S SEG(1)=ACK("MSA") D ADDSEG^HLOMSG(.ACK,.SEG)
 ;
 I $$SEND^HLOAPI1(.ACK,.ERROR) Q 1
 Q 0
 ;
ACKLINK(HLMSTATE,PORT) ; Finds the link & port to return the application ack to.
 N LINK
 S LINK=$$RTRNLNK^HLOAPP($G(HLMSTATE("HDR","RECEIVING APPLICATION")))
 I LINK]"" S PORT=$$PORT2^HLOTLNK(LINK) Q LINK
 S LINK=$$RTRNLNK^HLOTLNK($G(HLMSTATE("HDR","SENDING FACILITY",1)),$G(HLMSTATE("HDR","SENDING FACILITY",2)),$G(HLMSTATE("HDR","SENDING FACILITY",3)))
 S:$G(HLMSTATE("HDR","SENDING FACILITY",3))="DNS" PORT=$P(HLMSTATE("HDR","SENDING FACILITY",2),":",2)
 I LINK]"",'PORT S PORT=$$PORT2^HLOTLNK(LINK)
 Q LINK
 ;
CHKPARMS(HLMSTATE,PARMS,ERROR) ;
 N LEN,SARY,HARY
 ;
 ;shortcut to reference the header sub-array
 S HARY="HLMSTATE(""HDR"")"
 ;
 ;shortcut to reference the status sub-array
 S SARY="HLMSTATE(""STATUS"")"
 ;
 S ERROR=""
 I $G(PARMS("ACCEPT ACK TYPE"))="" S PARMS("ACCEPT ACK TYPE")="AL"
 I $G(PARMS("APP ACK TYPE"))="" S PARMS("APP ACK TYPE")="NE"
 I PARMS("ACCEPT ACK TYPE")'="NE",PARMS("ACCEPT ACK TYPE")'="AL" S ERROR="INVALID ACCEPT ACKNOWLEDGMENT TYPE"
 I PARMS("APP ACK TYPE")'="NE",PARMS("APP ACK TYPE")'="AL" S ERROR="INVALID APPLICATION ACKNOWLEDGMENT TYPE"
 S LEN=$L($G(PARMS("QUEUE")))
 I $G(PARMS("QUEUE"))["^" S ERROR="QUEUE NAME MAY NOT CONTAIN '^'"
 I LEN>20 S ERROR="QUEUE PARAMETER IS MAX 20 LENGTH",PARMS("QUEUE")=$E(PARMS("QUEUE"),1,20)
 I 'LEN S PARMS("QUEUE")="DEFAULT"
 D
 .N APPIEN
 .I $G(PARMS("SENDING APPLICATION"))="" D  Q
 ..S ERROR="SENDING APPLICATION IS REQUIRED"
 ..S PARMS("SENDING APPLICATION")=""
 .E  D  Q:'APPIEN
 ..S APPIEN=$$GETIEN^HLOAPP(PARMS("SENDING APPLICATION"))
 ..I 'APPIEN S ERROR="SENDING APPLICATION NOT FOUND IN THE HLO APPLICATION REGISTRY"
 .I $L($G(PARMS("SEQUENCE QUEUE"))) D
 ..I ($L(PARMS("SEQUENCE QUEUE"))>30) S ERROR="SEQUENCE QUEUE NAME > 30 CHARACTERS" Q
 ..I PARMS("SEQUENCE QUEUE")["^" S ERROR="SEQUENCE QUEUE NAME MAY NOT CONTAIN '^'" Q
 ..I $G(PARMS("APP ACK TYPE"))'="AL" S ERROR="SEQUENCE QUEUES REQUIRE AN APPLICATION ACKNOWLEDGMENT" Q
 ..I $G(PARMS("ACCEPT ACK TYPE"))'="AL" S ERROR="SEQUENCE QUEUES REQUIRE AN ACCEPT ACKNOWLEDGMENT" Q
 ;
 ;move parameters into HLMSTATE
 S @HARY@("ACCEPT ACK TYPE")=PARMS("ACCEPT ACK TYPE")
 S @HARY@("APP ACK TYPE")=PARMS("APP ACK TYPE")
 S @HARY@("SENDING APPLICATION")=$E(PARMS("SENDING APPLICATION"),1,60)
 S @HARY@("SECURITY")=$G(PARMS("SECURITY"))
 S @SARY@("APP ACK RESPONSE")=$G(PARMS("APP ACK RESPONSE"))
 S @SARY@("ACCEPT ACK RESPONSE")=$G(PARMS("ACCEPT ACK RESPONSE"))
 S @SARY@("FAILURE RESPONSE")=$G(PARMS("FAILURE RESPONSE"))
 S @SARY@("QUEUE")=PARMS("QUEUE")
 S @SARY@("SEQUENCE QUEUE")=$G(PARMS("SEQUENCE QUEUE"))
 Q:$L(ERROR) 0
 Q 1
 ;
 ;
SETCODE(SEG,VALUE,FIELD,COMP,REP) ; Implements SETCNE and SETCWE
 ;
 N SUB,VAR
 Q:'$G(FIELD)
 S:'$G(REP) REP=1
 I '$G(COMP) D
 .S VAR="COMP",SUB=1
 E  D
 .S VAR="SUB"
 S @VAR=1,SEG(FIELD,REP,COMP,SUB)=$G(VALUE("ID"))
 S @VAR=2,SEG(FIELD,REP,COMP,SUB)=$G(VALUE("TEXT"))
 S @VAR=3,SEG(FIELD,REP,COMP,SUB)=$G(VALUE("SYSTEM"))
 S @VAR=4,SEG(FIELD,REP,COMP,SUB)=$G(VALUE("ALTERNATE ID"))
 S @VAR=5,SEG(FIELD,REP,COMP,SUB)=$G(VALUE("ALTERNATE TEXT"))
 S @VAR=6,SEG(FIELD,REP,COMP,SUB)=$G(VALUE("ALTERNATE SYSTEM"))
 S @VAR=7,SEG(FIELD,REP,COMP,SUB)=$G(VALUE("SYSTEM VERSION"))
 S @VAR=8,SEG(FIELD,REP,COMP,SUB)=$G(VALUE("ALTERNATE SYSTEM VERSION"))
 S @VAR=9,SEG(FIELD,REP,COMP,SUB)=$G(VALUE("ORIGINAL TEXT"))
 Q
 ;
CHKWHO(HLMSTATE,WHOTO,ERROR) ;
 N RETURN,I
 S RETURN=1
 I '$$CHECKWHO^HLOASUB1(.WHOTO,.RETURN,.ERROR) S RETURN=0
 ;
 ;move parameters into HLMSTATE
 S HLMSTATE("STATUS","LINK IEN")=$G(RETURN("LINK IEN"))
 S HLMSTATE("STATUS","LINK NAME")=$G(RETURN("LINK NAME"))
 ;** P158 START **
 ;S HLMSTATE("STATUS","PORT")=$P($G(RETURN("RECEIVING FACILITY",2)),":",2)
 S HLMSTATE("STATUS","PORT")=$G(RETURN("LINK PORT"))
 ;** P158 END **
 S HLMSTATE("HDR","RECEIVING APPLICATION")=$G(RETURN("RECEIVING APPLICATION"))
 F I=1:1:3 S HLMSTATE("HDR","RECEIVING FACILITY",I)=$G(RETURN("RECEIVING FACILITY",I))
 Q RETURN
