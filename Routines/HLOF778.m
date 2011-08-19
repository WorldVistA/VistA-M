HLOF778 ;ALB/CJM-HL7 - Saving messages to file 778 ;07/31/2008
 ;;1.6;HEALTH LEVEL SEVEN;**126,134,137,138**;Oct 13, 1995;Build 34
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;
SAVEMSG(HLMSTATE) ;
 ;If a record has not yet been created in file 778, then it will be created. Will file any segments into 777 not yet stored.  For batch messages, will store the MSH segments in 778 as the individual messages are stored in 777.
 ;Input:
 ;  HLMSTATE (pass by reference) - contains information about the message
 ;    These subscripts must be defined:
 ;  ("BATCH")=1 if batch, 0 otherwise
 ;  ("BATCH","BTS")=BTS segment if end of batch reached
 ;  ("BODY")=ien file 777 if stored
 ;  ("DIRECTION")=<"IN" or "OUT">
 ;  ("IEN")=ien,file 778 if stored
 ;  ("UNSTORED LINES") - count of lines to be stored.  The lines are at the a lower subscript level <msg>,<segment>,<line>=<line to be stored>
 ;  ("UNSTORED MSH") For batch messages, set to 1 if there are MSH in cache. Cached MSH at ("UNSTORED MSH",<subfile ien>,<1 & 2>)
 ;
 ;Output:
 ;  Function - returns the ien of the msg (file 778)
 ;  HLMSTATE
 ;   ("BODY") - set to ien, file 777 if newly created
 ;   ("IEN") - set to ien, file 778 if newly created
 ;   ("UNSTORED LINES")-set to 0 as this function will store them
 ;   ("UNSTORED MSH")- set to 0 as this function will store it
 ;
 ;
 I '$D(HLMSTATE("DT/TM")) S HLMSTATE("DT/TM")=$S(HLMSTATE("DIRECTION")="IN":$$NOW^XLFDT,1:"")
 ;
 ;insure that 777 entry created & all segments stored
 I ('HLMSTATE("BODY"))!($G(HLMSTATE("UNSTORED LINES")))!($L($G(HLMSTATE("BATCH","BTS")))),'$$SAVEMSG^HLOF777(.HLMSTATE) Q 0
 ;
 ;insure 778 entry created
 I 'HLMSTATE("IEN") Q:'$$NEW^HLOF778A(.HLMSTATE) 0
 ;
 ;for batch messages, store MSH segments in 778
 I HLMSTATE("BATCH") D
 .N IEN S IEN=HLMSTATE("IEN")
 .;
 .;incoming messages cache the MSH segments in memory
 .I HLMSTATE("DIRECTION")="IN",HLMSTATE("UNSTORED MSH") D
 ..N ORDER S ORDER=0
 ..F  S ORDER=$O(HLMSTATE("UNSTORED MSH",ORDER)) Q:'ORDER  D
 ...N FS,MSGID
 ...S FS=$E(HLMSTATE("UNSTORED MSH",ORDER,1),4)
 ...S MSGID=$P(HLMSTATE("UNSTORED MSH",ORDER,2),FS,5)
 ...S ^HLB(IEN,3,ORDER,0)=ORDER_"^"_MSGID_"^"_$G(HLMSTATE("BATCH","ACK TO",ORDER))
 ...S ^HLB(IEN,3,ORDER,1)=HLMSTATE("UNSTORED MSH",ORDER,1)
 ...S ^HLB(IEN,3,ORDER,2)=HLMSTATE("UNSTORED MSH",ORDER,2)
 ...S ^HLB(IEN,3,"B",ORDER,ORDER)=""
 ...I MSGID]"" S ^HLB("AE",MSGID,IEN_"^"_ORDER)="" ;whole file index for individual message id
 ..K HLMSTATE("UNSTORED MSH") S HLMSTATE("UNSTORED MSH")=0
 .;
 .;
 .I HLMSTATE("DIRECTION")="OUT" D
 ..;must build the MSH segments!
 ..N HDR,FS,MSG,CS
 ..S FS=HLMSTATE("HDR","FIELD SEPARATOR")
 ..S CS=$E(HLMSTATE("HDR","ENCODING CHARACTERS"),1)
 ..S HLMSTATE("HDR","MESSAGE TYPE")="   "
 ..S HLMSTATE("HDR","EVENT")="   "
 ..D BUILDHDR^HLOPBLD1(.HLMSTATE,"MSH",.HDR)
 ..S HLMSTATE("BATCH","CURRENT MESSAGE")=$O(^HLB(HLMSTATE("IEN"),3,"B",";"),-1)
 ..F  Q:'$$NEXTMSG(.HLMSTATE,.MSG)  D
 ...N MSGID,CUR
 ...S CUR=HLMSTATE("BATCH","CURRENT MESSAGE")
 ...S MSGID=HLMSTATE("HDR","BATCH CONTROL ID")_"-"_CUR
 ...S $P(HDR(2),FS,4)=MSG("MESSAGE TYPE")_CS_MSG("EVENT")
 ...S $P(HDR(2),FS,5)=MSGID
 ...S ^HLB(IEN,3,CUR,0)=CUR_"^"_MSGID_"^"_$G(HLMSTATE("BATCH","ACK TO",CUR))
 ...S ^HLB(IEN,3,CUR,1)=HDR(1)
 ...S ^HLB(IEN,3,CUR,2)=HDR(2)
 ...S ^HLB(IEN,3,"B",CUR,CUR)=""
 ...S ^HLB("AE",MSGID,IEN_"^"_CUR)="" ;whole file index for individual message id
 ..;
 .;if the messages are application acks, then update the original message
 .N SUBIEN S SUBIEN=0
 .F  S SUBIEN=$O(HLMSTATE("BATCH","ACK TO",SUBIEN)) Q:'SUBIEN  I $G(HLMSTATE("BATCH","ACK TO",SUBIEN,"IEN"))]"" D
 ..N ACKTO
 ..M ACKTO=HLMSTATE("BATCH","ACK TO",SUBIEN)
 ..;
 ..;for outgoing msgs, we just created the msgid, for incoming msgs we already had it
 ..S:HLMSTATE("DIRECTION")="OUT" ACKTO("ACK BY")=HLMSTATE("HDR","BATCH CONTROL ID")_"-"_SUBIEN
 ..;
 ..D ACKTO(.HLMSTATE,.ACKTO)
 .K HLMSTATE("BATCH","ACK TO")
 ;
 ;if the msg is an app ack, update the original if not done already
 I $G(HLMSTATE("ACK TO","IEN"))]"",'$G(HLMSTATE("ACK TO","DONE")) D
 .N ACKTO
 .M ACKTO=HLMSTATE("ACK TO")
 .S ACKTO("ACK BY")=$S(HLMSTATE("BATCH"):HLMSTATE("HDR","BATCH CONTROL ID"),1:HLMSTATE("HDR","MESSAGE CONTROL ID"))
 .D ACKTO(.HLMSTATE,.ACKTO)
 .S HLMSTATE("ACK TO","DONE")=1 ;so the update isn't done again
 Q HLMSTATE("IEN")
 ;
NEXTMSG(HLMSTATE,MSG) ;
 ;Traverses file 777 to return the next message in the batch - as
 ;indicated by HLMSTATE("BATCH","CURRENT MESSAGE")  Set to 0 to start,
 ;returns 0 when there are no more messages
 ;
 ;Input:  HLMSTATE (pass by reference,required)
 ;Output:
 ;  HLMSTATE
 ;     ("BATCH","CURRENT MESSAGE")
 ;  MSG -pass by reference:
 ;     ("EVENT")
 ;     ("MESSAGE TYPE")
 ;
 ;
 N SUBIEN,NODE
 K MSG
 Q:'$G(HLMSTATE("BODY")) 0
 S SUBIEN=$O(^HLA(HLMSTATE("BODY"),2,HLMSTATE("BATCH","CURRENT MESSAGE")))
 Q:'SUBIEN 0
 S NODE=$G(^HLA(HLMSTATE("BODY"),2,SUBIEN,0))
 S MSG("MESSAGE TYPE")=$P(NODE,"^",2)
 S MSG("EVENT")=$P(NODE,"^",3)
 S HLMSTATE("BATCH","CURRENT MESSAGE")=SUBIEN
 Q SUBIEN
 ;
ACKTO(HLMSTATE,ACKTO) ;if this is an application ack, update the original message - but do not overlay if already valued
 ;ACKTO = (msgid of msg being ack'd)
 ;        uses these subscripts ("IEN"=ien^subien),("ACK BY"=msgid of acking msg),("STATUS"=status for the initial msg determined by the ack)
 ;
 N STATUS,IEN,SUBIEN,NODE,SKIP
 S SKIP=0
 S STATUS=$G(ACKTO("STATUS"))
 S IEN=+ACKTO("IEN"),SUBIEN=$P(ACKTO("IEN"),"^",2)
 S NODE=$G(^HLB(IEN,0))
 I 'SUBIEN D
 .;ack is to a message NOT in a batch
 .I $P(NODE,"^",7)'="",$P(NODE,"^",7)'=ACKTO("ACK BY") S SKIP=1 Q
 .I STATUS="" S STATUS="SU"
 .S $P(NODE,"^",7)=ACKTO("ACK BY")
 .S $P(NODE,"^",18)=1
 .S $P(NODE,"^",20)=STATUS
 .S $P(NODE,"^",21)=$G(ACKTO("ERROR TEXT"))
 .S ^HLB(IEN,0)=NODE
 E  D
 .;ack is to a message that IS in a batch
 .S $P(^HLB(IEN,3,SUBIEN,0),"^",4)=$G(ACKTO("ACK BY"))
 .S $P(^HLB(IEN,3,SUBIEN,0),"^",5)=STATUS
 I (STATUS="ER"),'SKIP D
 .N APP
 .S APP=HLMSTATE("HDR","RECEIVING APPLICATION")
 .I APP="" S APP="UNKNOWN"
 .S ^HLB("ERRORS",APP,$$NOW^XLFDT,ACKTO("IEN"))=""
 .;don't count the error - the app ack was already counted as an error.
 .D COUNT^HLOESTAT("IN",$G(HLMSTATE("HDR","RECEIVING APPLICATION")),$G(HLMSTATE("HDR","SENDING APPLICATION")),$S(HLMSTATE("BATCH"):"BATCH",1:$G(HLMSTATE("HDR","MESSAGE TYPE"))),$G(HLMSTATE("HDR","EVENT")))
 Q
