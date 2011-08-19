HLOMSG ;ALB/CJM-HL7 - APIs for files 777/778 ;07/31/2008
 ;;1.6;HEALTH LEVEL SEVEN;**126,134,137,138**;Oct 13, 1995;Build 34
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
GETMSG(IEN,MSG) ;
 ;Description: given the message ien=MSGIEN (required), it returns the MSG array containing information about the message, defined below.
 ;Input:
 ;  IEN - the ien of the message in file 778
 ;Output:
 ;  Function returns 1 on success, 0 on failure
 ;  MSG (pass by reference, required) These are the subscripts returned:
 ;
 ;   "ACK BY" - msg id of msg that acknowledges this one
 ;   "ACK BY IEN" - msg IEN of msg that acknowledges this one.  If the message is in the batch, the value is <ien>^<subien>
 ;   "ACK TO" - msg id of msg that this msg acknowledges
 ;   "ACK TO IEN" - msg IEN of msg that this msg acknowledges. If the message is in a batch, the value is <ien>^<subien>
 ;  "BATCH"  = 1 if this is a batch message, 0  if not
 ;     "CURRENT MESSAGE" - defined only for batch messages -  a counter used during building and parsing messages to indicate the current message.  It will be set to 0 initially.
 ;  "BODY" - ptr to file 778 which contains the body of the message.
 ;  "DIRECTION" - "IN" if incoming, "OUT" if outgoing
 ;  "DT/TM" - date/time the message was sent or received
 ;  "DT/TM CREATED" - date/time the record was created (.01 field, file #777)
 ;  "LINE COUNT" -  a counter used during building and parsing of
 ;     messages to indicate the current line within the message. For
 ;     batch messages where each message within the batch is stored
 ;     separately, this field indicates the position within the current
 ;     individual message
 ;  "HDR" - the header segment, NOT parsed, as HDR(1) and HDR(2)
 ;  "ID" - Message Control ID for an individual message, Batch Control ID for a batch message
 ;  "IEN" - ien, file 778
 ;  "EVENT" - HL7 event, only defined if NOT batch
 ;  "MESSAGE TYPE" - HL7 message type, only defined if NOT batch
 ;  "STATUS" - the completion status
 ;
 ;     These are lower level subscripts of "STATUS":
 ;     "ACCEPT ACK RESPONSE" - the application's <tag>^<rtn> to Xecute when the accept ack is received
 ;     "ACCEPT ACK'D" - 1 if an accept ack was sent or received in response to this message
 ;     "APP ACK RESPONSE" - the application's <tag>^<rtn> to Xecute when app ack is received
 ;     "APP ACK'D" - 1 if an application ack was sent or received in response to this message
 ;     "ERROR TEXT" - if in error status, a description of the error
 ;     "LINK NAME" the link the message was transmitted through
 ;     "PORT" - remote port over which the message was transmitted
 ;     "PURGE" - scheduled purge dt/tm
 ;     "QUEUE" - the queue that the message was placed on
 ;     "SEQUENCE QUEUE" - the sequence queue (optional)
 ;
 K MSG
 Q:'$G(IEN) 0
 N NODE
 S MSG("IEN")=IEN
 S NODE=$G(^HLB(IEN,0))
 S MSG("ID")=$P(NODE,"^")
 S MSG("BODY")=$P(NODE,"^",2)
 S MSG("DIRECTION")=$S($E($P(NODE,"^",4))="O":"OUT",$E($P(NODE,"^",4))="I":"IN",1:"")
 S MSG("ACK TO")=$P(NODE,"^",3)
 S MSG("ACK BY")=$P(NODE,"^",7)
 I MSG("ACK TO")]"" S MSG("ACK TO IEN")=$$ACKTOIEN^HLOMSG1($P(NODE,"^"),MSG("ACK TO"))
 I MSG("ACK BY")]"" S MSG("ACK BY IEN")=$$ACKBYIEN^HLOMSG1($P(NODE,"^"),MSG("ACK BY"))
 S MSG("DT/TM")=$P(NODE,"^",16)
 S MSG("STATUS")=$P(NODE,"^",20)
 ;
 D
 .N NODE4
 .S NODE4=$G(^HLB(IEN,4))
 .S MSG("STATUS","QUEUE")=$P(NODE,"^",6)
 .S MSG("STATUS","LINK NAME")=$P(NODE,"^",5)
 .S MSG("STATUS","PORT")=$P(NODE,"^",8)
 .S MSG("STATUS","PURGE")=$P(NODE,"^",9)
 .S MSG("STATUS","ERROR TEXT")=$P(NODE,"^",21)
 .S MSG("STATUS","APP ACK RESPONSE")=$P(NODE,"^",10,11)
 .I MSG("STATUS","APP ACK RESPONSE")="^" S MSG("STATUS","APP ACK RESPONSE")=""
 .;** START 138 cjm
 .I MSG("DIRECTION")="IN" S MSG("STATUS","ACTION")=MSG("STATUS","APP ACK RESPONSE")
 .;**END 138 CJM
 .S MSG("STATUS","ACCEPT ACK RESPONSE")=$P(NODE,"^",12,13)
 .I MSG("STATUS","ACCEPT ACK RESPONSE")="^" S MSG("STATUS","ACCEPT ACK RESPONSE")=""
 .S MSG("STATUS","ACCEPT ACK'D")=$P(NODE,"^",17)
 .S MSG("STATUS","APP ACK'D")=$P(NODE,"^",18)
 .S MSG("STATUS")=$P(NODE,"^",20)
 .S MSG("STATUS","APP HANDOFF")=$P(NODE,"^",19)
 .S MSG("STATUS","ACCEPT ACK DT/TM")=$P(NODE4,"^")
 .S MSG("STATUS","ACCEPT ACK ID")=$P(NODE4,"^",2)
 .S MSG("STATUS","ACCEPT ACK MSA")=$P(NODE4,"^",3,99)
 ;
 S MSG("LINE COUNT")=0
 S MSG("HDR",1)=$G(^HLB(IEN,1))
 S MSG("HDR",2)=$G(^HLB(IEN,2))
 I 'MSG("BODY") D  Q 0
 .S MSG("DT/TM CREATED")=""
 .S MSG("BATCH")=""
 .S MSG("MESSAGE TYPE")=""
 .S MSG("EVENT")=""
 ;
 S NODE=$G(^HLA(MSG("BODY"),0))
 S MSG("DT/TM CREATED")=+NODE
 S MSG("BATCH")=+$P(NODE,"^",2)
 I MSG("BATCH") S MSG("BATCH","CURRENT MESSAGE")=0
 I 'MSG("BATCH") D
 .S MSG("MESSAGE TYPE")=$P(NODE,"^",3)
 .S MSG("EVENT")=$P(NODE,"^",4)
 I MSG("DIRECTION")="OUT" D
 .N NODE5
 .S NODE5=$G(^HLB(IEN,5))
 .S MSG("STATUS","SEQUENCE QUEUE")=$P(NODE5,"^")
 .S MSG("STATUS","MOVED TO OUT QUEUE")=$P(NODE5,"^",2)
 .S MSG("STATUS","SEQUENCE EXCEPTION RAISED")=$P(NODE5,"^",3)
 Q 1
 ;
HLNEXT(MSG,SEG) ;
 ;Description:  Returns the next segment as a set of lines stored in SEG.
 ;Input:
 ;  MSG (pass by reference, required)
 ;Output:
 ;  Function returns 1 on success, 0 on failure (no more segments)
 ;  SEG (pass by reference, required)
 ;
 K SEG
 Q:MSG("LINE COUNT")=-1 0
 I 'MSG("BATCH") D
 .N I,J,NODE,START
 .S START=0
 .S J=1,I=MSG("LINE COUNT")
 .F  S I=$O(^HLA(MSG("BODY"),1,I)) Q:'I  S NODE=$G(^HLA(MSG("BODY"),1,I,0)) Q:(START&(NODE=""))  I NODE'="" S SEG(J)=NODE,J=J+1,START=1
 .I 'I D
 ..S MSG("LINE COUNT")=-1
 .E  S MSG("LINE COUNT")=I
 I MSG("BATCH") D
 .N I,J,NODE,START
 .S J=1,I=MSG("LINE COUNT"),START=0
 .F  S I=$O(^HLA(MSG("BODY"),2,MSG("BATCH","CURRENT MESSAGE"),1,I)) Q:'I  S NODE=$G(^HLA(MSG("BODY"),2,MSG("BATCH","CURRENT MESSAGE"),1,I,0)) Q:(START&(NODE=""))  I NODE'="" S SEG(J)=NODE,J=J+1,START=1
 .I 'I D
 ..S MSG("LINE COUNT")=-1
 .E  S MSG("LINE COUNT")=I
 Q $S($D(SEG):1,1:0)
 ;
NEXTMSG(MSG,HDR) ;
 ;Advances to the next message in the batch
 ;Input:
 ;  MSG (pass by reference, required) - defined by $$GETMSG()
 ;Output:
 ;  Function returns 1 on success, 0 if no more messages
 ;  MSG - updated with current position in the message
 ;  HDR (pass by reference, required) returns the header as an array of lines
 ;
 ;
 K HDR
 S MSG("LINE COUNT")=0
 N SUBIEN,I
 ;
 ;if completed parsing, don't start over
 I MSG("BATCH","CURRENT MESSAGE")=-1 Q 0
 ;
 S I=$O(^HLB(MSG("IEN"),3,"B",MSG("BATCH","CURRENT MESSAGE")))
 I 'I S MSG("BATCH","CURRENT MESSAGE")=-1 Q 0
 S MSG("BATCH","CURRENT MESSAGE")=I
 S SUBIEN=$O(^HLB(MSG("IEN"),3,"B",I,0))
 S HDR(1)=$G(^HLB(MSG("IEN"),3,SUBIEN,1))
 S HDR(2)=$G(^HLB(MSG("IEN"),3,SUBIEN,2))
 Q $S($D(HDR):1,1:0)
 ;
ADDSEG(HLMSTATE,SEG) ;Adds a segment to the message.
 ;Input:
 ;  HLMSTATE() - (pass by reference, required)
 ;  SEG() - (pass by reference, required) The segment as lines SEG(<i>)
 ;
 ;Output:
 ;   HLMSTATE()
 ;
 N I,J S I=0
 S J=HLMSTATE("LINE COUNT")
 ;
 ;insure a blank line between segments
 I J S J=J+1,HLMSTATE("UNSTORED LINES",$S(HLMSTATE("BATCH"):HLMSTATE("BATCH","CURRENT MESSAGE"),1:1),HLMSTATE("CURRENT SEGMENT"),J)=""
 ;
 S HLMSTATE("CURRENT SEGMENT")=HLMSTATE("CURRENT SEGMENT")+1
 F  S I=$O(SEG(I)) Q:'I  D
 .S J=J+1
 .S HLMSTATE("UNSTORED LINES",$S(HLMSTATE("BATCH"):HLMSTATE("BATCH","CURRENT MESSAGE"),1:1),HLMSTATE("CURRENT SEGMENT"),J)=SEG(I),HLMSTATE("UNSTORED LINES")=HLMSTATE("UNSTORED LINES")+$L(SEG(I))+50
 .I HLMSTATE("UNSTORED LINES")>HLMSTATE("SYSTEM","BUFFER") D
 ..I HLMSTATE("DIRECTION")="IN",$$SAVEMSG^HLOF778(.HLMSTATE) Q
 ..I HLMSTATE("DIRECTION")="OUT",$$SAVEMSG^HLOF777(.HLMSTATE)
 ;
 S HLMSTATE("LINE COUNT")=J
 Q
 ;
ADDMSG(HLMSTATE,PARMS) ;
 ;For outgoing messages, adds a message in the batch. There is no MSH yet, just the message type and event.  
 ;Input:
 ;  HLMSTATE() - (pass by reference, required)
 ;  PARMS("EVENT")
 ;  PARMS("MESSAGE TYPE")
 ;
 ;Output:
 ;   HLMSTATE() - (pass by reference, required)
 ;
 N I
 S I=HLMSTATE("BATCH","CURRENT MESSAGE")+1,HLMSTATE("BATCH","CURRENT MESSAGE")=I
 S HLMSTATE("UNSTORED LINES",I)=PARMS("MESSAGE TYPE")_"^"_PARMS("EVENT")
 M:$G(PARMS("ACK TO"))]"" HLMSTATE("BATCH","ACK TO",I)=PARMS("ACK TO")
 S HLMSTATE("CURRENT SEGMENT")=0
 S HLMSTATE("LINE COUNT")=0
 S HLMSTATE("UNSTORED LINES")=HLMSTATE("UNSTORED LINES")+100
 Q
 ;
ADDMSG2(HLMSTATE,MSH) ;
 ;For incoming messages adds a message to the batch. This differs from ADDMSG in that the MSH segment is passed in to be stored in file 778.
 ;Input:
 ;  HLMSTATE() - (pass by reference, required)
 ;  MSH(<i>) - the MSH segment as a set of lines
 ;
 ;Output:
 ;   HLMSTATE() - (pass by reference, required)
 ;
 N FS,CS,VALUE
 I (HLMSTATE("UNSTORED LINES")+200)>HLMSTATE("SYSTEM","BUFFER"),$$SAVEMSG^HLOF778(.HLMSTATE) ;first stores body in 777, then headers in file 778
 ;
 S HLMSTATE("BATCH","CURRENT MESSAGE")=HLMSTATE("BATCH","CURRENT MESSAGE")+1
 S FS=$E(MSH(1),4)
 S CS=$E(MSH(1),5)
 S VALUE=$P(MSH(2),FS,4)
 S HLMSTATE("UNSTORED LINES",HLMSTATE("BATCH","CURRENT MESSAGE"))=$P(VALUE,CS)_"^"_$P(VALUE,CS,2)
 S HLMSTATE("UNSTORED MSH")=1
 M HLMSTATE("UNSTORED MSH",HLMSTATE("BATCH","CURRENT MESSAGE"))=MSH
 S HLMSTATE("CURRENT SEGMENT")=0
 S HLMSTATE("LINE COUNT")=0
 S HLMSTATE("UNSTORED LINES")=HLMSTATE("UNSTORED LINES")+200
 ;I HLMSTATE("UNSTORED LINES")>HLMSTATE("SYSTEM","BUFFER"),$$SAVEMSG^HLOF778(.HLMSTATE) ;first stores stuff in 777, then headers in file 778
 Q
