HLOCLNT ;ALB/CJM- Client for sending messages - 10/4/94 1pm ;08/17/2010
 ;;1.6;HEALTH LEVEL SEVEN;**126,130,131,134,137,139,143,147**;Oct 13, 1995;Build 15
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;GET WORK function for the process running under the Process Manager
GETWORK(QUE) ;
 ;Input:
 ;  QUE - (pass by reference) These subscripts are used:
 ;    ("LINK")  - <link name>_":"_<port> last obtained
 ;    ("QUEUE") - name of the queue last obtained
 ;Output:
 ;  Function returns 1 if success, 0 if no more work
 ;  QUE -  updated to identify next queue of messages to process.
 ;    ("LINK") - <link name>_":"_<port>
 ;    ("QUEUE") - the named queue on the link
 ;    ("DOWN") - =1 means that the last OPEN attempt failed
 ;
 N LINK,QUEUE
 S LINK=$G(QUE("LINK")),QUEUE=$G(QUE("QUEUE"))
TRY I (LINK]""),(QUEUE]"") D
 .L -^HLB("QUEUE","OUT",LINK,QUEUE)
 .I $$IFSHUT^HLOTLNK($P(LINK,":")) S QUEUE="" Q
 .I '$$CNNCTD(LINK),$$FAILING(.LINK) S QUEUE="" Q
 .F  S QUEUE=$O(^HLB("QUEUE","OUT",LINK,QUEUE)) Q:(QUEUE="")  I '$$STOPPED^HLOQUE("OUT",QUEUE) L +^HLB("QUEUE","OUT",LINK,QUEUE):0  Q:$T
 I (LINK]""),(QUEUE="") D
 .F  S LINK=$O(^HLB("QUEUE","OUT",LINK)) Q:LINK=""  D  Q:$L(QUEUE)
 ..Q:$$IFSHUT^HLOTLNK($P(LINK,":"))
 ..I '$$CNNCTD(LINK),$$FAILING(.LINK) Q
 ..S QUEUE="" F  S QUEUE=$O(^HLB("QUEUE","OUT",LINK,QUEUE)) Q:(QUEUE="")  I '$$STOPPED^HLOQUE("OUT",QUEUE) L +^HLB("QUEUE","OUT",LINK,QUEUE):0 Q:$T
 I LINK="" D
 .F  S LINK=$O(^HLB("QUEUE","OUT",LINK)) Q:LINK=""  D  Q:$L(QUEUE)
 ..Q:$$IFSHUT^HLOTLNK($P(LINK,":"))
 ..I '$$CNNCTD(LINK),$$FAILING(.LINK) Q
 ..S QUEUE="" F  S QUEUE=$O(^HLB("QUEUE","OUT",LINK,QUEUE)) Q:(QUEUE="")  I '$$STOPPED^HLOQUE("OUT",QUEUE) L +^HLB("QUEUE","OUT",LINK,QUEUE):0 Q:$T
 S QUE("LINK")=LINK,QUE("QUEUE")=QUEUE,QUE("DOWN")=$G(LINK("DOWN"))
 ;
 ;** P147 START CJM
 I $L(QUEUE),($R(100)>$$GETPRTY^HLOQUE(QUE("QUEUE"),QUE("LINK"))) G TRY
 ;** P148 END CJM
 ;
 Q:$L(QUEUE) 1
 D:$G(HLCSTATE("CONNECTED")) CLOSE^HLOT(.HLCSTATE)
 Q 0
 ;
FAILING(LINK) ;
 ;Returns 1 if the link has failed in the last 30 seconds, 0 otherwise
 ;Also returns LINK("DOWN")=1 if the link was failing > 30 seconds ago, not yet known if its up
 ;
 N LASTTIME,SET
 S LINK("DOWN")=0
 S LASTTIME=$G(^HLB("QUEUE","OUT",LINK))
 S SET=$S(LASTTIME]"":1,1:0)
 I SET D
 .I $$HDIFF^XLFDT($H,LASTTIME,2)>30 S ^HLB("QUEUE","OUT",LINK)="",SET=0,LINK("DOWN")=1
 I $D(^HLTMP("FAILING LINKS",LINK)) S LINK("DOWN")=1
 Q SET
 ;
LINKDOWN(HLCSTATE) ;
 N TO
 D:$G(HLCSTATE("CONNECTED")) CLOSE^HLOT(.HLCSTATE)
 I $D(HLCSTATE("LINK","NAME")),$D(HLCSTATE("LINK","PORT")) D
 .S TO=HLCSTATE("LINK","NAME")_":"_HLCSTATE("LINK","PORT")
 .S ^HLB("QUEUE","OUT",TO)=$H
 .S:'$D(^HLTMP("FAILING LINKS",TO)) ^HLTMP("FAILING LINKS",TO)=$H
 Q
 ;
ERROR ;error trap
ZB3 ;
 ;
 S $ETRAP="Q:$QUIT """" Q"
 ;
 D END
 D LINKDOWN(.HLCSTATE)
 ;
 ;return to the Process Manager error trap
 D UNWIND^%ZTER
 Q:$QUIT "" Q
 ;
DOWORK(QUEUE) ;sends the messages on the queue
ZB0 ;
 N $ETRAP,$ESTACK S $ETRAP="G ERROR^HLOCLNT"
 N MSGIEN,DEQUE,SUCCESS,MSGCOUNT,MAXIMUM
 S DEQUE=0
 S SUCCESS=1
 ;
 I '$$CNNCTD(QUEUE("LINK")),'$$CONNECT^HLOCLNT1($P(QUEUE("LINK"),":"),$P(QUEUE("LINK"),":",2),30,.HLCSTATE) Q
 S (MSGCOUNT,MSGIEN)=0
 S MAXIMUM=$$GETPRTY^HLOQUE(QUEUE("QUEUE"),QUEUE("LINK"))*2
 F  S MSGIEN=$O(^HLB("QUEUE","OUT",QUEUE("LINK"),QUEUE("QUEUE"),MSGIEN)) D  Q:'SUCCESS  Q:MSGCOUNT>MAXIMUM  Q:$$STOPPED^HLOQUE("OUT",QUEUE("QUEUE"))  Q:$$IFSHUT^HLOTLNK($P(QUEUE("LINK"),":"))
 .S:'MSGIEN SUCCESS=0
ZB4 .;
 .Q:'SUCCESS
 .N UPDATE
 .S ^HLB(MSGIEN,"TRIES")=$G(^HLB(MSGIEN,"TRIES"))+1
 .S SUCCESS=0
 .S:$$TRANSMIT(.HLCSTATE,MSGIEN,.UPDATE) SUCCESS=1
 .Q:('SUCCESS)!('$D(UPDATE))
 .D DEQUE(.UPDATE)
 .S MSGCOUNT=MSGCOUNT+1
 .D:HLCSTATE("COUNTS")>4 SAVECNTS^HLOSTAT(.HLCSTATE)
 .;
 .;if the queue was on the down list, and not since shutdown, mark it as up, since a message has been successfully transmitted across it
 .I $G(QUEUE("DOWN"))!$$FAILING(QUEUE("LINK")),'$$IFSHUT^HLOTLNK(QUEUE("LINK")) S QUEUE("DOWN")=0,^HLB("QUEUE","OUT",QUEUE("LINK"))="" K ^HLTMP("FAILING LINKS",QUEUE("LINK"))
 ;
ZB5 ;
END D DEQUE()
 D SAVECNTS^HLOSTAT(.HLCSTATE)
 Q
CNNCTD(LINK) ;
 ;Connected to LINK?  HLCSTATE must be defined, LINK=<link name>:<port>
 ;
 I ($G(HLCSTATE("LINK","NAME"))=$P(LINK,":")),($G(HLCSTATE("LINK","PORT"))=$P(LINK,":",2)),$G(HLCSTATE("CONNECTED")) Q 1
 Q 0
 ;
DEQUE(UPDATE) ;
 ;**P143 START CJM
ZB25 ;
 ;**P143 END CJM
 I $D(UPDATE) S DEQUE=DEQUE+1,DEQUE(+UPDATE)=$P(UPDATE,"^",2,99) S:$G(UPDATE("MSA"))]"" DEQUE(+UPDATE,"MSA")=UPDATE("MSA") S:$G(UPDATE("ACTION"))]"" DEQUE(+UPDATE,"ACTION")=UPDATE("ACTION")
 I '$D(UPDATE)!(DEQUE>15) D
 .N MSGIEN S MSGIEN=0
 .F  S MSGIEN=$O(DEQUE(MSGIEN)) Q:'MSGIEN  D
 ..N NODE,TIME
 ..D DEQUE^HLOQUE(QUEUE("LINK"),QUEUE("QUEUE"),"OUT",MSGIEN)
 ..S TIME=$P(DEQUE(MSGIEN),"^")
 ..Q:'TIME
 ..S NODE=QUEUE("LINK")_"^"_QUEUE("QUEUE")_"^"_$P(DEQUE(MSGIEN),"^",2,99)
 ..S ^HLTMP("CLIENT UPDATES",$J,TIME,MSGIEN)=NODE
 ..S:$G(DEQUE(MSGIEN,"MSA"))]"" ^HLTMP("CLIENT UPDATES",$J,TIME,MSGIEN,"MSA")=DEQUE(MSGIEN,"MSA")
 ..S:$G(DEQUE(MSGIEN,"ACTION"))]"" ^HLTMP("CLIENT UPDATES",$J,TIME,MSGIEN,"ACTION")=DEQUE(MSGIEN,"ACTION")
 .K DEQUE S DEQUE=0
 Q
 ;
TRANSMIT(HLCSTATE,MSGIEN,UPDATE) ;
 ;Transmits a single message and if a commit ack was requested reads it.  Updates file 778 with the result.  Queues for the infiler the application accept action if one was requested.
 ;Input:
 ;   HLCSTATE (pass by reference)
 ;   MSGIEN - ien, file 778, of message to be transmitted
 ;Output:
 ;  Function returns 1 on success, 0 on failure
 ;  UPDATE - (pass by reference) to contain updates needed for message
 ;
 N HLMSTATE,MSA,HDR,SUCCESS
 ;
 S SUCCESS=0
 S HLCSTATE("ATTEMPT")=0
 ;
 ;start saving updates needed after the message is transmitted
 S UPDATE=MSGIEN
 Q:'$$GETMSG^HLOCLNT2(MSGIEN,.HLMSTATE) 1  ;returns 1 so the message will be removed from the queue
 I HLMSTATE("DT/TM"),HLMSTATE("STATUS","ACCEPTED")!(HLMSTATE("HDR","ACCEPT ACK TYPE")="NE") D  Q 1  ;the message was already transmitted
ZB20 .;**P143 START CJM
 .;**P143 END CJM
 ;
 ;**P143 START CJM
 I HLMSTATE("ACK BY")]"",HLMSTATE("STATUS")]"",$G(^HLB(MSGIEN,"TRIES"))>1 Q 1  ;The app ack was already returned, so don't keep transmitting
 ;**P143 END CJM
 ;
 S UPDATE=UPDATE_"^"_$$NOW^XLFDT
RETRY D
 .S HLCSTATE("ATTEMPT")=HLCSTATE("ATTEMPT")+1
 .I 'HLCSTATE("CONNECTED") D OPEN^HLOT(.HLCSTATE) Q:'HLCSTATE("CONNECTED")
 .;
 .;try to send the message
 .;
 .;
 .Q:'$$WRITEMSG^HLOCLNT1(.HLCSTATE,.HLMSTATE)
 .;does the message need an accept ack?
 .I HLMSTATE("HDR","ACCEPT ACK TYPE")="AL" D
 ..N FS
 ..Q:'$$READACK^HLOCLNT1(.HLCSTATE,.HDR,.MSA)
 ..;does the MSA refer to the correct control id?
 ..S FS=$E(HDR(1),4)
 ..I $P(MSA,FS,3)'=HLMSTATE("ID") D  Q
ZB21 ...;**P143 START CJM
 ...;**P43 END CJM
 ..N ACKID,ACKCODE
 ..S ACKCODE=$P(MSA,FS,2)
 ..S ACKID=$S($E(HDR(1),1,3)="MSH":$P(HDR(2),FS,5),1:$P(HDR(2),FS,6))
 ..S $P(UPDATE,"^",5)=1
 ..S UPDATE("MSA")=ACKID_"^"_MSA
 ..I '(ACKCODE="CA") D
 ...S $P(UPDATE,"^",3)="ER",$P(UPDATE,"^",4)=2
ZB22 ...;**P143 START CJM
 ...;**P143 END CJM
 ..I ACKCODE="CA",HLMSTATE("HDR","APP ACK TYPE")="NE" S $P(UPDATE,"^",3)="SU",$P(UPDATE,"^",4)=$S(HLMSTATE("BATCH"):"2",1:1)
 ..I ($P(UPDATE,"^",3)="ER") S $P(UPDATE,"^",6)=$P(HLMSTATE("HDR",1),FS,5) ;errors need the application for xref
 ..;
 ..;if it's from a sequence queue, timestamp the queue
 ..I $L($G(HLMSTATE("STATUS","SEQUENCE QUEUE"))) D
 ...L +^HLB("QUEUE","SEQUENCE",HLMSTATE("STATUS","SEQUENCE QUEUE")):200
 ...I $P($G(^HLB("QUEUE","SEQUENCE",HLMSTATE("STATUS","SEQUENCE QUEUE"))),"^")'=MSGIEN L -^HLB("QUEUE","SEQUENCE",HLMSTATE("STATUS","SEQUENCE QUEUE")) Q
 ...I ACKCODE="CA" D
 ....S $P(^HLB("QUEUE","SEQUENCE",HLMSTATE("STATUS","SEQUENCE QUEUE")),"^",2)=$$FMADD^XLFDT($P(UPDATE,"^",2),,,$$TIMEOUT^HLOAPP($$GETSAP^HLOCLNT2(MSGIEN))) L -^HLB("QUEUE","SEQUENCE",HLMSTATE("STATUS","SEQUENCE QUEUE"))
ZB23 ....;**P143 START CJM
 ....;**P143 END CJM
 ...;if the message wasn't accepted, need to notify without waiting
 ...S $P(^HLB("QUEUE","SEQUENCE",HLMSTATE("STATUS","SEQUENCE QUEUE")),"^",2)=$P(UPDATE,"^",2)
 ...L -^HLB("QUEUE","SEQUENCE",HLMSTATE("STATUS","SEQUENCE QUEUE"))
 ..;
 ..;does the app need notification of accept ack?
 ..S UPDATE("ACTION")=HLMSTATE("ACCEPT ACK RESPONSE")
 ..;
 ..S SUCCESS=1
 .E  D  ;accept ack wasn't requested
 ..S SUCCESS=1
 ..I HLMSTATE("HDR","APP ACK TYPE")="NE" S $P(UPDATE,"^",3)="SU",$P(UPDATE,"^",4)=$S(HLMSTATE("BATCH"):2,1:1)
 ;
 I 'SUCCESS,'HLCSTATE("CONNECTED"),(HLCSTATE("ATTEMPT")<2) G RETRY
 I SUCCESS D
 .D COUNT^HLOSTAT(.HLCSTATE,HLMSTATE("HDR","RECEIVING APPLICATION"),HLMSTATE("HDR","SENDING APPLICATION"),$S(HLMSTATE("BATCH"):"BATCH",1:HLMSTATE("HDR","MESSAGE TYPE")_"~"_HLMSTATE("HDR","EVENT")))
 .;if this is an ack to a message need to purge the original message, so store its ien with the purge date
 .S:$G(HLMSTATE("ACK TO IEN")) $P(UPDATE,"^",4)=$P(UPDATE,"^",4)_"-"_HLMSTATE("ACK TO IEN")
 I ('HLCSTATE("CONNECTED"))!('SUCCESS) D LINKDOWN(.HLCSTATE)
 Q SUCCESS
