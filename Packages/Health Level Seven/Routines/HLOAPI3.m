HLOAPI3 ;ALB/CJM-HL7 - Developer API's for sending application acks ;07/21/2008
 ;;1.6;HEALTH LEVEL SEVEN;**126,133,134,137,138**;Oct 13, 1995;Build 34
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
BATCHACK(HLMSTATE,PARMS,ACK,ERROR) ;; Starts a batch message that is the response to a batch message. Individual acks are placed in the batch by calling $$ADDACK.
 ;;$$SENDACK^HLOAPI2 must be called when the batch of acks is complete. The return destination is determined automatically from the original message.
 ;;
 ;;Input:
 ;;  HLMSTATE (pass by reference, required) the array obtained by calling $$STARTMSG^HLOPRS when parsing the original message 
 ;;  PARMS (optional, pass by reference) These subscripts may be defined:
 ;;    "ACCEPT ACK RESPONSE")=<tag^routine> to call when the commit ack is received (optional)
 ;;    "ACCEPT ACK TYPE") = <AL,NE> (optional, defaults to AL)
 ;;    "COUNTRY") - a 3 character country code from the HL7 standard table (optional)
 ;;     "ENCODING CHARACTERS" - the 4 HL7 encoding characters (optional,defaults to "^~\&"
 ;;    "FAILURE RESPONSE" (optional) the <tag>^<routine> that the sending application routine should execute if the transmission of the message fails, i.e., the message can not be sent or a requested commit ack is not received.
 ;;     "FIELD SEPARATOR" - the field separator (optional, defaults to "|")
 ;;     "QUEUE" (optional) An application can name a private queue (a string under 20 characters, namespaced). The default is the name of the queue of the original message
 ;;     "SECURITY" - security information to include in the header segment, SEQ 8 (optional)
 ;;    "VERSION" - the HL7 Version ID (optional, defaults to 2.4)
 ;;Output:
 ;;  Function returns 1 on success, 0 on failure
 ;;  PARMS - left undefined upon completion
 ;;  ACK (pass by reference, required) the batch acknowledgment message being built.
 ;;  ERROR (pass by reference) error message
 ;;  
 ;
 N I,TOLINK,SUCCESS
 S SUCCESS=0
 ;
 D
 .N PORT
 .I '$G(HLMSTATE("IEN")) S ERROR="ORIGINAL MESSAGE TO ACKNOWLEDGMENT IS NOT IDENTIFIED" Q
 .;if the return link can not be determined, the HL Logical Link file has a problem
 .S TOLINK=$$ACKLINK^HLOAPI2(.HLMSTATE)
 .I TOLINK="" S ERROR="TRANSMISSION LINK FOR APPLICATION ACK CANNOT BE DETERMINED" Q
 .S PORT=$P(HLMSTATE("HDR","SENDING FACILITY",2),":",2)
 .I 'PORT S PORT=$$PORT2^HLOTLNK(TOLINK)
 .;
 .I $$NEWBATCH^HLOAPI(.PARMS,.ACK)  ;can't fail!
 .S ACK("STATUS","QUEUE")=$G(PARMS("QUEUE"),$G(HLMSTATE("STATUS","QUEUE")))
 .I ACK("STATUS","QUEUE")="" S ACK("STATUS","QUEUE")="DEFAULT"
 .;
 .S ACK("STATUS","PORT")=PORT
 .S ACK("HDR","SECURITY")=$G(PARMS("SECURITY"))
 .S ACK("HDR","SENDING APPLICATION")=$G(HLMSTATE("HDR","RECEIVING APPLICATION"))
 .S ACK("HDR","RECEIVING APPLICATION")=$G(HLMSTATE("HDR","SENDING APPLICATION"))
 .F I=1:1:3 S ACK("HDR","RECEIVING FACILITY",I)=$G(HLMSTATE("HDR","SENDING FACILITY",I))
 .S ACK("HDR","APP ACK TYPE")="NE"
 .S ACK("HDR","ACCEPT ACK TYPE")=$G(PARMS("ACCEPT ACK TYPE"),"AL")
 .S ACK("ACK TO")=$G(HLMSTATE("HDR","BATCH CONTROL ID"))
 .S ACK("ACK TO","IEN")=HLMSTATE("IEN")
 .S ACK("ACK TO","BODY")=$G(HLMSTATE("BODY"))
 .S ACK("STATUS","LINK NAME")=TOLINK
 .S ACK("LINE COUNT")=0
 .S SUCCESS=1
 K PARMS
 Q SUCCESS
 ;
ADDACK(ACK,PARMS,ERROR) ;;This API adds an application acknowledgment to a batch
 ;;of acknowledgments that was started by calling $$BATCHACK.
 ;;The Default behavior is to return a general application ack.
 ;;The application may optionally specify the message
 ;;type and event and/or call $$ADDSEG^HLOAPI to add segments.
 ;;A generic MSA segment (components 1-3) will be added automatically
 ;;if the application doesn't call $$ADDSEG^HLOAPI to add an MSA segment
 ;;as the FIRST segment following the MSH segment.
 ;;$$SENDACK^HLOAPI2 must be called when the batch is complete.
 ;;
 ;;Input:
 ;;  ACK (pass by reference,required) the batch of acks that is being built 
 ;;  PARMS (pass by reference) These subscripts may be defined:
 ;;    "ACK CODE" (required) MSA1[ {AA,AE,AR}
 ;;    "ERROR MESSAGE" (optional) MSA3, should be used only if AE or AR
 ;;    "EVENT" - 3 character event type (optional, defaults to the event code of the original message)
 ;;    "MESSAGE CONTROL ID" (required) this is the message control id of the original individual message within the batch which is being acknowledged
 ;;    "MESSAGE STRUCTURE" (optional)
 ;;    "MESSAGE TYPE" (optional, defaults to ACK)
 ;;    "SECURITY" (optional) security information to include in the header segment SEQ 8
 ;;Output:
 ;;  Function returns 1 on success, 0 on failure
 ;;  ACK (pass by reference, required) The batch, updated with another ack
 ;;  PARMS  - left undefined when this function returns
 ;;  ERROR (pass by reference) error msg
 ;;
 ;
 N SUB,SUCCESS
 S SUCCESS=0
 D
 .I $G(PARMS("ACK CODE"))'="AA",$G(PARMS("ACK CODE"))'="AE",$G(PARMS("ACK CODE"))'="AR" S ERROR="INVALID ACK CODE" Q
 .;
 .I $G(PARMS("MESSAGE CONTROL ID"))="" S ERROR="MESSAGE CONTROL ID MUST EXIST TO RETURN AN APPLICATION ACK" Q
 .S SUB=""
 .F  S SUB=$O(^HLB("AE",PARMS("MESSAGE CONTROL ID"),SUB)) Q:SUB=""  I $P(SUB,"^")=ACK("ACK TO","IEN"),$P(SUB,"^",2) S PARMS("ACK TO","IEN")=SUB Q
 .S PARMS("MESSAGE TYPE")=$G(PARMS("MESSAGE TYPE"),"ACK")
 .S:PARMS("MESSAGE TYPE")="ACK" PARMS("MESSAGE STRUCTURE")="ACK"
 .S PARMS("EVENT")=$G(PARMS("EVENT"))
 .I PARMS("EVENT")="",ACK("ACK TO","BODY"),$P(SUB,"^",2) S PARMS("EVENT")=$P($G(^HLA(ACK("ACK TO","BODY"),2,$P(SUB,"^",2),0)),"^",3)
 .S PARMS("ACK TO")=PARMS("MESSAGE CONTROL ID")
 .S PARMS("ACK TO","STATUS")=$S(PARMS("ACK CODE")="AA":"SU",1:"ER")
 .Q:'$$ADDMSG^HLOAPI(.ACK,.PARMS,.ERROR)
 .;Next line modified for HL*1.6*138 - RBN
 .;S ACK("MSA")="MSA|"_PARMS("ACK CODE")_"|"_PARMS("MESSAGE CONTROL ID")_"|"_$G(PARMS("ERROR MESSAGE"))
 .S ACK("MSA")="MSA|"_PARMS("ACK CODE")_"|"_PARMS("MESSAGE CONTROL ID")_"|"_$$ESCAPE^HLOPBLD(.ACK,$G(PARMS("ERROR MESSAGE")))
 .S SUCCESS=1
 K PARMS
 Q SUCCESS
 ;
RESEND(MSGIEN,ERROR) ;;  Retransmit message
 ;;This message will re-transmit an out-going message. It copies a copy the message, reusing all the original parameters. Then the message is requeued.
 ;;
 ;;Input:
 ;;  MSGIEN - the ien (file #778) of the message that is to be sent
 ;;Output:
 ;;  Function returns the ien of the message in file 778 on success, 0 on failure
 ;;  ERROR (pass by reference, optional)an error message
 ;;
 N MSG,SUB,HDR
 I '$$STARTMSG^HLOPRS(.MSG,MSGIEN) S ERROR="MESSAGE NOT FOUND" Q 0
 I MSG("DIRECTION")'="OUT" S ERROR="MESSAGE IS NOT OUTGOING" Q 0
 I MSG("STATUS","LINK NAME")="" S ERROR="LINK NOT DEFINED" Q 0
 I MSG("BATCH") D
 .N MSH
 .D NEXTMSG^HLOPRS(.MSG,.MSH)
 .S MSG("HDR","VERSION")=MSH("VERSION")
 F SUB="ID","IEN","DT/TM","ACK BY","STATUS" S MSG(SUB)=""
 F SUB="PURGE" K MSG("STATUS",SUB)
 D GETSYS^HLOAPI(.MSG)
 I $$SAVEMSG^HLOF778(.MSG) D OUTQUE^HLOQUE(MSG("STATUS","LINK NAME"),$G(MSG("STATUS","PORT")),MSG("STATUS","QUEUE"),MSG("IEN")) Q +MSG("IEN")
 Q 0
 ;
SETPURGE(MSGIEN,TIME) ;;  Set message up for purging.
 ;;Resets the purge date/time.
 ;;Input:
 ;;   MSGIEN (required) ien of the message, file #778
 ;;   TIME (optional) dt/time to set the purge time to, defaults to NOW
 ;;Output:
 ;;   Function returns 1 on success, 0 on failure
 ;;   
 N NODE,OLDTIME,HLDIR
 Q:'$G(MSGIEN) 0
 S NODE=$G(^HLB(MSGIEN,0))
 Q:NODE="" 0
 S OLDTIME=$P(NODE,"^",9)
 S:'$G(TIME) TIME=$$NOW^XLFDT
 S HLDIR=$S($E($P(NODE,"^",4))="I":"IN",1:"OUT")
 K:OLDTIME ^HLB("AD",HLDIR,OLDTIME,MSGIEN)
 S $P(^HLB(MSGIEN,0),"^",9)=TIME
 S ^HLB("AD",HLDIR,TIME,MSGIEN)=""
 Q 1
 ;
REPROC(MSGIEN,ERROR) ;;  Reprocess message.
 ;;This message will re-process an incoming message by placing it on an incoming queue. If successful the message will be purged.
 ;;
 ;;Input:
 ;;  MSGIEN - the ien (file #778) of the message that is to be processed
 ;;Output:
 ;;  Function returns 1 on success, 0 on failure
 ;;  ERROR (pass by reference, optional) an error message
 ;;
 N MSG,HDR,ACTION,QUEUE,FROM
 ;
 I '$$STARTMSG^HLOPRS(.MSG,MSGIEN) S ERROR="MESSAGE NOT FOUND" Q 0
 I MSG("DIRECTION")'="IN" S ERROR="MESSAGE IS NOT INCOMING" Q 0
 M HDR=MSG("HDR")
 ;** START HL*1.6*138 CJM
 ;I $G(MSG("ACK TO"))]"" S ACTION=MSG("STATUS","APP ACK RESPONSE")
 S ACTION=MSG("STATUS","ACTION")
 S QUEUE=MSG("STATUS","QUEUE")
 ;** END HL*1.6*138 CJM
 I ACTION="",'$$ACTION^HLOAPP(.HDR,.ACTION,.QUEUE),$G(MSG("ACK TO"))="" S ERROR="RECEIVING APPLICATION NOT DEFINED"
 ;If this message references an earlier message, get the action specified by the original message
 I ACTION="",$G(MSG("ACK TO"))]"" D
 .N NODE,IEN
 .S IEN=$O(^HLB("B",$P(MSG("ACK TO"),"-"),0))
 .S:IEN NODE=$G(^HLB(IEN,0))
 .I ($P(NODE,"^",11)]"") S ACTION=$P(NODE,"^",10,11),QUEUE=$S($P(NODE,"^",6)]"":$P(NODE,"^",6),1:"DEFAULT")
 I ACTION="" S ERROR="NO ACTION SPECIFIED FOR RECEIVING APPLICATION" Q 0
 S FROM=$S(MSG("HDR","SENDING FACILITY",2)]"":MSG("HDR","SENDING FACILITY",2),1:MSG("HDR","SENDING FACILITY",1))
 D INQUE^HLOQUE(FROM,QUEUE,MSGIEN,ACTION,1)
 Q 1
 ;
PROCNOW(MSGIEN,PURGE,ERROR) ;;
 ;;This message will re-process an incoming message immediately.
 ;;
 ;;Input:
 ;;  MSGIEN - the ien (file #778) of the message that is to be processed
 ;;Output:
 ;;  Function returns 1 on success, 0 on failure
 ;;  PURGE (optional) a date/time to purge the message
 ;;  ERROR (pass by reference, optional) an error message
 ;;
 N MSG,HDR,ACTION,MCODE,HLMSGIEN
 ;
 S ERROR=""
 I '$$STARTMSG^HLOPRS(.MSG,MSGIEN) S ERROR="MESSAGE NOT FOUND" Q 0
 I MSG("DIRECTION")'="IN" S ERROR="MESSAGE IS NOT INCOMING" Q 0
 M HDR=MSG("HDR")
 ;** START HL*1.6*138 CJM
 ;I $G(MSG("ACK TO"))]"" S ACTION=MSG("STATUS","APP ACK RESPONSE")
 S ACTION=MSG("STATUS","ACTION")
 ;** END HL*1.6*138 CJM
 I ACTION="",'$$ACTION^HLOAPP(.HDR,.ACTION,.QUEUE),$G(MSG("ACK TO"))="" S ERROR="RECEIVING APPLICATION NOT DEFINED" Q 0
 ;If this message references an earlier message, get the action specified by the original message
 I $G(ACTION)="",$G(MSG("ACK TO IEN")) S ACTION=$P($G(^HLB(+MSG("ACK TO IEN"),0)),"^",10,11) I $P(ACTION,"^",2)="" S ERROR="ACTION SPECIFIED BY ORIGINAL APPLICATION NOT FOUND" Q 0
 I $P(ACTION,"^",2)="" S ERROR="ACTION SPECIFIED BY APPLICATION NOT FOUND" Q 0
 D:$G(PURGE)
 .K:MSG("STATUS","PURGE") ^HLB("AD","IN",MSG("STATUS","PURGE"),MSGIEN)
 .S $P(^HLB(MSGIEN,0),"^",9)=PURGE
 .S ^HLB("AD","IN",PURGE,MSGIEN)=""
 .I $G(MSG("ACK TO IEN")),$D(^HLB(MSG("ACK TO IEN"),0)) K ^HLB("AD","OUT",MSG("STATUS","PURGE"),MSG("ACK TO IEN")) S $P(^HLB(MSG("ACK TO IEN"),0),"^",9)=PURGE,^HLB("AD","OUT",PURGE,MSG("ACK TO IEN"))=""
 S HLMSGIEN=MSGIEN
 S $P(^HLB(MSGIEN,0),"^",19)=1
 S MCODE="D "_ACTION
 X MCODE
 Q 1
