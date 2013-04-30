HLOCLNT2 ;ALB/CJM- Performs message updates for the client - 10/4/94 1pm ;03/07/2012
 ;;1.6;HEALTH LEVEL SEVEN;**126,130,131,133,134,137,143,158**;Oct 13, 1995;Build 14
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
GETWORK(WORK) ;
 ;
 N OLD,DOLLARJ,SUCCESS,NOW
 S SUCCESS=0
 S NOW=$$NOW^XLFDT
 S (OLD,DOLLARJ)=$G(WORK("DOLLARJ"))
 F  S DOLLARJ=$O(^HLTMP("CLIENT UPDATES",DOLLARJ)) Q:DOLLARJ=""  D  Q:SUCCESS
 .L +^HLTMP("CLIENT UPDATES",DOLLARJ):0
 .Q:'$T
 .N TIME S TIME=$O(^HLTMP("CLIENT UPDATES",DOLLARJ,""))
 .I $$FMDIFF^XLFDT(NOW,TIME,2)<2 L -^HLTMP("CLIENT UPDATES",DOLLARJ) Q
 .S SUCCESS=1
 ;
 I OLD'="",'SUCCESS F  S DOLLARJ=$O(^HLTMP("CLIENT UPDATES",DOLLARJ)) Q:DOLLARJ=""  Q:DOLLARJ>OLD  D  Q:SUCCESS
 .L +^HLTMP("CLIENT UPDATES",DOLLARJ):0
 .Q:'$T
 .N TIME S TIME=$O(^HLTMP("CLIENT UPDATES",DOLLARJ,""))
 .I $$FMDIFF^XLFDT(NOW,TIME,2)<2 L -^HLTMP("CLIENT UPDATES",DOLLARJ) Q
 .S SUCCESS=1
 S WORK("DOLLARJ")=DOLLARJ,WORK("NOW")=NOW
 Q $S($L(WORK("DOLLARJ")):1,1:0)
 ;
DOWORK(WORK) ;
 ;
 N DOLLARJ,TIME,IEN,PARMS,SYSTEM
 S TIME=""
 S DOLLARJ=WORK("DOLLARJ")
 D SYSPARMS^HLOSITE(.SYSTEM)
 F  S TIME=$O(^HLTMP("CLIENT UPDATES",DOLLARJ,TIME)) Q:TIME=""  Q:$$FMDIFF^XLFDT(WORK("NOW"),TIME,2)<2  D
 .S IEN=0
 .F  S IEN=$O(^HLTMP("CLIENT UPDATES",DOLLARJ,TIME,IEN)) Q:'IEN  D
 ..N NODE
 ..S NODE=$G(^HLTMP("CLIENT UPDATES",DOLLARJ,TIME,IEN))
 ..S PARMS("LINK")=$P(NODE,"^")
 ..S PARMS("QUEUE")=$P(NODE,"^",2)
 ..S PARMS("STATUS")=$P(NODE,"^",3)
 ..S PARMS("PURGE")=$P(NODE,"^",4)
 ..S PARMS("ACK TO IEN")=+$P($P(NODE,"^",4),"-",2)
 ..S PARMS("ACCEPT ACK")=$P(NODE,"^",5)
 ..S PARMS("RECEIVING APP")=$P(NODE,"^",6)
 ..S:PARMS("RECEIVING APP")="" PARMS("RECEIVING APP")="UNKNOWN RECEIVING APPLICATION"
 ..S PARMS("MSA")=$G(^HLTMP("CLIENT UPDATES",DOLLARJ,TIME,IEN,"MSA"))
 ..S PARMS("ACTION")=$G(^HLTMP("CLIENT UPDATES",DOLLARJ,TIME,IEN,"ACTION"))
 ..D UPDATE(IEN,TIME,.PARMS)
 ..K ^HLTMP("CLIENT UPDATES",DOLLARJ,TIME,IEN)
 L -^HLTMP("CLIENT UPDATES",DOLLARJ)
 Q
 ;
UPDATE(MSGIEN,TIME,PARMS) ;
 S:PARMS("STATUS")]"" $P(^HLB(MSGIEN,0),"^",20)=PARMS("STATUS")
 I PARMS("STATUS")="ER" D
 .S ^HLB("ERRORS",PARMS("RECEIVING APP"),TIME,MSGIEN_"^")=""
 .D COUNT^HLOESTAT("OUT",PARMS("RECEIVING APP"),$$GETSAP(MSGIEN),$$GETMTYPE(MSGIEN))
 S:PARMS("ACCEPT ACK") $P(^HLB(MSGIEN,0),"^",17)=PARMS("ACCEPT ACK")
 S $P(^HLB(MSGIEN,0),"^",16)=TIME
 S:PARMS("MSA")]"" ^HLB(MSGIEN,4)=TIME_"^"_PARMS("MSA")
 I PARMS("PURGE"),PARMS("ACTION")="" D SETPURGE^HLOF778A(MSGIEN,PARMS("STATUS"),PARMS("ACK TO IEN"))
 D:PARMS("ACTION")]""
 .N PURGE
 .S PURGE=PARMS("PURGE")
 .S:PARMS("ACK TO IEN") PURGE("ACKTOIEN")=PARMS("ACK TO IEN")
 .D INQUE^HLOQUE(PARMS("LINK"),PARMS("QUEUE"),MSGIEN,PARMS("ACTION"),.PURGE)
 Q
 ;
GETMSG(IEN,MSG) ;
 ;
 ;Description: given the message ien=MSGIEN (required), it returns the MSG array containing information about the message, defined below.
 ;Input:
 ;  IEN - the ien of the message in file 778
 ;Output:
 ;  Function returns 1 on success, 0 on failure
 ;  MSG (pass by reference, required) These are the subscripts returned:
 ;    "ACCEPT ACK RESPONSE" - if the sending app requested notification of the accept ack, this is the routine to perform
 ;    "ACK TO IEN" - if this is an app ack to a message not in a batch, this is the ien of the original message
 ;    "ACK BY"
 ;    "STATUS"
 ;    "BATCH"  = 1 if this is a batch message, 0  if not
 ;    "CURRENT MESSAGE" - defined only for batch messages -  a counterused during building and parsing messages to indicate the current message.  It will be set to 0 initially.
 ;    "BODY" - ptr to file 778 which contains the body of the message.
 ;    "LINE COUNT" -  a counter used during writing of the
 ;     messages to indicate the current line. For
 ;     batch messages where each message within the batch is stored
 ;     separately, this field indicates the position within the current
 ;     individual message
 ;    "HDR" at these lower subscripts:
 ;       1    - components 1-6
 ;       2    - components 7-end
 ;       "ACCEPT ACK TYPE" = "AL" or "NE"
 ;       "APP ACK TYPE" = "AL" or "NE"
 ;       "MESSAGE CONTROL ID" - defined if NOT batch
 ;       "BATCH CONTROL ID" - defined if batch
 ;
 ;    "ID" - message id from the header
 ;    "IEN" - ien, file 778
 ;    "STATUS","SEQUENCE QUEUE")=name of the sequence queue (optional)
 ;
 K MSG
 Q:'$G(IEN) 0
 N NODE,FS,CS,REP,SUBCOMP,ESCAPE
 S MSG("IEN")=IEN
 S NODE=$G(^HLB(IEN,0))
 S MSG("BODY")=$P(NODE,"^",2)
 S MSG("ID")=$P(NODE,"^")
 Q:'MSG("BODY") 0
 ;
 S MSG("ACK BY")=$P(NODE,"^",7)
 S MSG("STATUS")=$P(NODE,"^",20)
 ;
 ;
 S MSG("STATUS","ACCEPTED")=$P(NODE,"^",17)
 S MSG("DT/TM")=$P(NODE,"^",16)
 S MSG("STATUS","QUEUE")=$P(NODE,"^",6)
 I MSG("STATUS","QUEUE")="" S MSG("STATUS","QUEUE")="DEFAULT"
 S MSG("ACCEPT ACK RESPONSE")=$P(NODE,"^",12,13)
 I MSG("ACCEPT ACK RESPONSE")="^" S MSG("ACCEPT ACK RESPONSE")=""
 ;
 S MSG("BATCH")=+$P($G(^HLA(MSG("BODY"),0)),"^",2)
 I MSG("BATCH") D
 .S MSG("BATCH","CURRENT MESSAGE")=0
 E  D
 .N ACKTO
 .S ACKTO=$P(NODE,"^",3)
 .I ACKTO]"" S ACKTO=$$ACKTOIEN^HLOMSG1(MSG("ID"),ACKTO)
 .I ACKTO,+ACKTO=ACKTO S MSG("ACK TO IEN")=ACKTO
 S MSG("LINE COUNT")=0
 S MSG("HDR",1)=$G(^HLB(IEN,1))
 S MSG("HDR",2)=$G(^HLB(IEN,2))
 S FS=$E(MSG("HDR",1),4)
 S CS=$E(MSG("HDR",1),5)
 S REP=$E(MSG("HDR",1),6)
 S ESCAPE=$E(MSG("HDR",1),7)
 S SUBCOMP=$E(MSG("HDR",1),8)
 S MSG("HDR","FIELD SEPARATOR")=FS
 S MSG("HDR","SENDING APPLICATION")=$$DESCAPE^HLOPRS1($P($P(MSG("HDR",1),FS,3),CS),FS,CS,SUBCOMP,REP,ESCAPE)
 S MSG("HDR","RECEIVING APPLICATION")=$$DESCAPE^HLOPRS1($P($P(MSG("HDR",1),FS,5),CS),FS,CS,SUBCOMP,REP,ESCAPE)
 I 'MSG("BATCH") D
 .S MSG("HDR","MESSAGE TYPE")=$P($P(MSG("HDR",2),FS,4),CS)
 .S MSG("HDR","EVENT")=$P($P(MSG("HDR",2),FS,4),CS,2)
 .S MSG("HDR","ACCEPT ACK TYPE")=$E($P(MSG("HDR",2),FS,10),1,2)
 .S MSG("HDR","APP ACK TYPE")=$E($P(MSG("HDR",2),FS,11),1,2)
 .S MSG("HDR","MESSAGE CONTROL ID")=MSG("ID")
 E  D
 .S MSG("HDR","BATCH CONTROL ID")=MSG("ID")
 .S MSG("HDR","ACCEPT ACK TYPE")=$E($P($P(MSG("HDR",2),FS,4),"ACCEPT ACK TYPE=",2),1,2)
 .S MSG("HDR","APP ACK TYPE")=$E($P($P(MSG("HDR",2),FS,4),"APP ACK TYPE=",2),1,2)
 S MSG("STATUS","SEQUENCE QUEUE")=$P($G(^HLB(IEN,5)),"^")
 Q 1
 ;
GETMTYPE(MSGIEN) ;returns <message type>~<event> OR "BATCH"
 Q:'$G(MSGIEN) "UNKNOWN"
 N FS,CS,HDR1,HDR2
 S HDR1=$G(^HLB(IEN,1))
 I $E(HDR1,1,3)="BHS" Q "BATCH"
 S HDR2=$G(^HLB(IEN,2))
 S FS=$E(HDR1,4)
 S CS=$E(HDR1,5)
 Q $P($P(HDR2,FS,4),CS)_"~"_$P($P(HDR2,FS,4),CS,2)
 ;
GETEVENT(MSGIEN) ; returns event if not a batch message
 Q:'$G(MSGIEN) ""
 N FS,CS,HDR1,HDR2
 S HDR1=$G(^HLB(MSGIEN,1))
 I $E(HDR1,1,3)="BHS" Q ""
 S HDR2=$G(^HLB(MSGIEN,2))
 S FS=$E(HDR1,4)
 S CS=$E(HDR1,5)
 Q $P($P(HDR2,FS,4),CS,2)
 ;
GETSAP(MSGIEN) ;
 ;
 ;
 Q:'$G(MSGIEN) "UNKNOWN"
 N FS,CS,HDR1,REP,ESCAPE,SUBCOMP
 S HDR1=$G(^HLB(MSGIEN,1))
 S FS=$E(HDR1,4)
 S CS=$E(HDR1,5)
 S REP=$E(HDR1,6)
 S ESCAPE=$E(HDR1,7)
 S SUBCOMP=$E(HDR1,8)
 Q $$DESCAPE^HLOPRS1($P($P(HDR1,FS,3),CS),FS,CS,SUBCOMP,REP,ESCAPE)
