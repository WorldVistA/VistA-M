HLOSRVR1 ;IRMFO-ALB/CJM/OAK/PIJ - Reading messages, sending acks;03/24/2004  14:43 ;07/28/2009
 ;;1.6;HEALTH LEVEL SEVEN;**126,130,131,133,134,137,138,139,143,146,147**;Oct 13, 1995;Build 15
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
READMSG(HLCSTATE,HLMSTATE) ;
 ;Reads a message.  The header is parsed. Does these checks:
 ; 1) Duplicate?
 ; 2) Wrong Receiving Facility?
 ; 3) Can the Receiving App accept this message, based message type & event?
 ; 4) Processing ID must match the receiving system
 ; 5) Must have an ID
 ; 6) Header must be BHS or MSH
 ;
 ;Output:
 ;  Function returns 1 if the message was read fully, 0 otherwise
 ;  HLMSTATE (pass by reference) the message.  It will include the fields for the return ack in HLMSTATE("MSA")
 ;
 N ACK,SEG,STORE,I
 ;
 S STORE=1
 Q:'$$READHDR^HLOT(.HLCSTATE,.SEG) 0
 D SPLITHDR(.SEG)
 ;
 ;parse the header, stop if unsuccessful because the server cannot know what to do next
 I '$$PARSEHDR^HLOPRS(.SEG) D  Q 0
ZB29 .S HLCSTATE("MESSAGE ENDED")=0
 .D CLOSE^HLOT(.HLCSTATE)
 ;
 ;** P143 START CJM**
 S I=$S(SEG("SEGMENT TYPE")="MSH":$G(SEG("MESSAGE CONTROL ID")),1:$G(SEG("BATCH CONTROL ID")))
 I I'="" L +HLO("MSGID",I):5 I '$T D  Q 0
 .S HLCSTATE("MESSAGE ENDED")=0
 .D CLOSE^HLOT(.HLCSTATE)
 ;** P143 END CJM
 ;
 D NEWMSG^HLOSRVR2(.HLCSTATE,.HLMSTATE,.SEG)
 I HLMSTATE("ID")="" D
 .S STORE=0
 .I HLMSTATE("HDR","ACCEPT ACK TYPE")="AL" S HLMSTATE("MSA",1)="CE",HLMSTATE("MSA",3)="CONTROL ID MISSING"
 I STORE,$$DUP(.HLMSTATE) D
ZB30 .S STORE=0
 ;
 ;if the message is not to be stored, just read it and discard the segments
 I 'STORE D
 .F  Q:'$$READSEG^HLOT(.HLCSTATE,.SEG)
 ;
 E  D
 .N FS,NEWMSGID
 .S NEWMSGID=""
 .S FS=HLMSTATE("HDR","FIELD SEPARATOR")
 .F  Q:'$$READSEG^HLOT(.HLCSTATE,.SEG)  D
 ..N MSA,SEGTYPE,OLDMSGID,CODE,IEN,TEXT
 ..S SEGTYPE=$E($E(SEG(1),1,3)_$E($G(SEG(2)),1,2),1,3)
 ..I SEGTYPE="MSA" D
 ...S MSA=SEG(1)_$G(SEG(2))_$G(SEG(3))
 ...;; ** Start HL*1.6*138 PIJ **
 ...;;S OLDMSGID=$P(MSA,FS,3),CODE=$P(MSA,FS,2),TEXT=$E($P(MSA,FS,4),1,30)
 ...S OLDMSGID=$P(MSA,FS,3),CODE=$P(MSA,FS,2)
 ...S TEXT=$$ESCAPE^HLOPBLD(.HLMSTATE,$P(MSA,FS,4))
 ...;; ** End HL*1.6*138 **
 ...I $E(CODE,1)'="A" S SEGTYPE="" Q
 ...;** P143 START CJM
 ...;S:$P(OLDMSGID,"-")]"" IEN=$O(^HLB("B",$P(OLDMSGID,"-"),0))
 ...;S:$G(IEN) IEN=IEN_"^"_$P(OLDMSGID,"-",2)
 ...S IEN=$$ACKTOIEN^HLOMSG1("",OLDMSGID)
 ...;** P143 END CJM
 ..I 'HLMSTATE("BATCH") D
 ...D:SEGTYPE="MSA"
 ....S HLMSTATE("ACK TO")=OLDMSGID
 ....S HLMSTATE("ACK TO","ACK BY")=HLMSTATE("ID")
 ....S HLMSTATE("ACK TO","STATUS")=$S(CODE="AA":"SU",1:"ER")
 ....I $G(IEN) D
 .....S HLMSTATE("ACK TO","IEN")=IEN
 .....S HLMSTATE("ACK TO","SEQUENCE QUEUE")=$P($G(^HLB(+IEN,5)),"^")
 ....S HLMSTATE("ACK TO","ERROR TEXT")=TEXT
 ...D ADDSEG^HLOMSG(.HLMSTATE,.SEG)
 ..E  D  ;batch
 ...I SEGTYPE="MSH" D
 ....D SPLITHDR(.SEG)
 ....S NEWMSGID=$P(SEG(2),FS,5)
 ....D ADDMSG2^HLOMSG(.HLMSTATE,.SEG)
 ...E  D  ;not MSH
 ....D:SEGTYPE="MSA"
 .....N SUBIEN S SUBIEN=HLMSTATE("BATCH","CURRENT MESSAGE")
 .....S HLMSTATE("BATCH","ACK TO",SUBIEN)=OLDMSGID
 .....S HLMSTATE("BATCH","ACK TO",SUBIEN,"ACK BY")=NEWMSGID
 .....S HLMSTATE("BATCH","ACK TO",SUBIEN,"STATUS")=$S(CODE="AA":"SU",1:"ER")
 .....S:$D(IEN) HLMSTATE("BATCH","ACK TO",SUBIEN,"IEN")=IEN
 ....D ADDSEG^HLOMSG(.HLMSTATE,.SEG)
 .I HLMSTATE("UNSTORED LINES"),HLCSTATE("MESSAGE ENDED"),$$SAVEMSG^HLOF778(.HLMSTATE)
 ;
 I STORE,'HLCSTATE("MESSAGE ENDED") D
 .;reading failed, don't store
 .D:HLMSTATE("IEN") DEL778(HLMSTATE("IEN")) D:HLMSTATE("BODY") DEL777(HLMSTATE("BODY"))
 .S HLMSTATE("IEN")="",HLMSTATE("BODY")=""
 E  D:STORE
 .D CHECKMSG(.HLMSTATE)
 .D ADDAC(.HLMSTATE) ;so future duplicates are detected
 .D COUNT^HLOSTAT(.HLCSTATE,HLMSTATE("HDR","RECEIVING APPLICATION"),HLMSTATE("HDR","SENDING APPLICATION"),$S(HLMSTATE("BATCH"):"BATCH",1:HLMSTATE("HDR","MESSAGE TYPE")_"~"_HLMSTATE("HDR","EVENT")))
 ;
 D:'HLCSTATE("MESSAGE ENDED") CLOSE^HLOT(.HLCSTATE)
 Q HLCSTATE("MESSAGE ENDED")
 ;
ADDAC(HLMSTATE) ;adds the AC xref for duplicates detection
 ;
 N FROM
 S FROM=$S(HLMSTATE("HDR","SENDING FACILITY",2)]"":HLMSTATE("HDR","SENDING FACILITY",2),1:HLMSTATE("HDR","SENDING FACILITY",1))
 S ^HLB("AC",FROM_HLMSTATE("HDR","SENDING APPLICATION")_HLMSTATE("ID"),HLMSTATE("IEN"))=""
 Q
 ;
DUP(HLMSTATE) ;
 ;Returns 1 if the message is a duplicate and its ack (if requested) is found, 0 otherwise
 ;Input:
 ; HLMSTATE (pass by reference) the message being read
 ;Output:
 ;  Function returns 1 if the message is a duplicate, 0 otherwise
 ;  HLMSTATE (pass by reference) IF the message is a duplicate:
 ;     returns the prior MSA segment in HLMSTATE("MSA")
 ;
 N IEN,FROM,DUP
 S (IEN,DUP)=0
 ;
 ;no way to determine!  Bad header will be rejected
 Q:(HLMSTATE("ID")="") 0
 ;
 S FROM=$S(HLMSTATE("HDR","SENDING FACILITY",2)]"":HLMSTATE("HDR","SENDING FACILITY",2),1:HLMSTATE("HDR","SENDING FACILITY",1))
 F  S IEN=$O(^HLB("AC",FROM_HLMSTATE("HDR","SENDING APPLICATION")_HLMSTATE("ID"),IEN)) Q:'IEN  D  Q:DUP
 .I HLMSTATE("HDR","ACCEPT ACK TYPE")="NE" S DUP=1 Q
 .;need the MSA to return
 .D  Q
 ..N NODE
 ..S NODE=$P($G(^HLB(IEN,4)),"^",3,10)
 ..S HLMSTATE("MSA",1)=$P(NODE,"|",2)
 ..Q:$L(HLMSTATE("MSA",1))'=2
 ..S HLMSTATE("MSA",2)=$P(NODE,"|",3)
 ..S HLMSTATE("MSA",3)=$P(NODE,"|",4,10)
 ..S DUP=1
 ;
 Q DUP
 ;
CHECKMSG(HLMSTATE) ;
 ;Checks the header & MSA segment, sets HLMSTATE("STATUS","ACTION") if the message needs to be passed, determines if completion status should be set
 ;Input:
 ;  HLMSTATE("HDR") - the parsed header segment
 ;Output:
 ;  HLMSTATE("STATUS")="ER" if an error is detected
 ;  HLMSTATE("STATUS","QUEUE") queue to put the message on
 ;  HLMSTATE("STATUS","ACTION")  <tag^rtn> that is the processing routine for the receiving application
 ;  HLMSTATE("MSA") - MSA(1)=accept code to be returned, MSA(3)= error txt
 ;
 N WANTACK,PASS,ACTION,QUEUE,ERROR
 M HDR=HLMSTATE("HDR")
 S ERROR=0
 I HDR("ACCEPT ACK TYPE")="NE",'HLMSTATE("ORIGINAL MODE") D
 .S WANTACK=0
 E  D
 .S WANTACK=1
 I HLMSTATE("ORIGINAL MODE") S HLMSTATE("MSA",1)="AE",HLMSTATE("MSA",3)="THIS INTERFACE DOES NOT IMPLEMENT ORIGINAL MODE APPLICATION ACKOWLEDGMENTS",HLMSTATE("STATUS")="ER" Q
 I $G(HLMSTATE("ACK TO"))="" D  Q:ERROR
 .;
 .;** do not immplement the Pass Immediate parameter **
 .;N IMMEDIATE
 .;I '$$ACTION^HLOAPP(.HDR,.ACTION,.QUEUE,.IMMEDIATE) S ERROR=1 S:WANTACK HLMSTATE("MSA",1)="CR" S HLMSTATE("MSA",3)="RECEIVING APPLICATION NOT DEFINED",HLMSTATE("STATUS")="ER" Q
 .;S HLMSTATE("STATUS","ACTION")=$G(ACTION),HLMSTATE("STATUS","QUEUE")=$G(QUEUE),HLMSTATE("STATUS","PASS IMMEDIATE")=$G(IMMEDIATE)
 .;
 .I '$$ACTION^HLOAPP(.HDR,.ACTION,.QUEUE) S ERROR=1 S:WANTACK HLMSTATE("MSA",1)="CR" S HLMSTATE("MSA",3)="RECEIVING APPLICATION NOT DEFINED",HLMSTATE("STATUS")="ER" Q
 .S HLMSTATE("STATUS","ACTION")=$G(ACTION),HLMSTATE("STATUS","QUEUE")=$G(QUEUE)
 E  D  Q:ERROR  ;this is an app ack
 .;does the original message exist?
 .;
 .;** do not immplement the Pass Immediate parameter **
 .;N NODE,IMMEDIATE
 .;
 .N NODE
 .S:+$G(HLMSTATE("ACK TO","IEN")) NODE=$G(^HLB(+HLMSTATE("ACK TO","IEN"),0))
 .I $G(NODE)="" S ERROR=1,HLMSTATE("STATUS")="ER",HLMSTATE("ACK TO","IEN")="" S:WANTACK HLMSTATE("MSA",1)="CE" S HLMSTATE("MSA",3)="INITIAL MESSAGE TO APPLICATION ACKNOWLEDGMENT NOT FOUND" Q
 .I $P(NODE,"^",7)'="",$P(NODE,"^",7)'=HLMSTATE("ID") S ERROR=1,HLMSTATE("STATUS")="ER",HLMSTATE("ACK TO","IEN")="" S:WANTACK HLMSTATE("MSA",1)="CE" S HLMSTATE("MSA",3)="INITIAL MESSAGE WAS ALREADY ACKED" Q
 .I ($P(NODE,"^",11)]"") S HLMSTATE("STATUS","ACTION")=$P(NODE,"^",10,11),HLMSTATE("STATUS","QUEUE")=$S($P(NODE,"^",6)]"":$P(NODE,"^",6),1:"DEFAULT")  Q
 .;processing routine for the app ack wasn't found with the original message, look in the HLO Application Registry
 .I HLMSTATE("HDR","MESSAGE TYPE")="ACK",HLMSTATE("HDR","EVENT")="" S HDR("EVENT")=$$GETEVENT^HLOCLNT2(+HLMSTATE("ACK TO","IEN"))
 .;
 .;** do not immplement the Pass Immediate parameter **
 .;I $$ACTION^HLOAPP(.HDR,.ACTION,.QUEUE,.IMMEDIATE) S HLMSTATE("STATUS","ACTION")=$G(ACTION),HLMSTATE("STATUS","QUEUE")=$G(QUEUE),HLMSTATE("STATUS","PASS IMMEDIATE")=$G(IMMEDIATE)
 .;
 .I $$ACTION^HLOAPP(.HDR,.ACTION,.QUEUE) S HLMSTATE("STATUS","ACTION")=$G(ACTION),HLMSTATE("STATUS","QUEUE")=$G(QUEUE)
 ;
 I HDR("PROCESSING ID")'=HLCSTATE("SYSTEM","PROCESSING ID") S:WANTACK HLMSTATE("MSA",1)="CR" S HLMSTATE("STATUS")="ER",HLMSTATE("MSA",3)="SYSTEM PROCESSING ID="_HLCSTATE("SYSTEM","PROCESSING ID") Q
 ;
 ;wrong receiving facility?  This is hard to check if the sender is not VistA, because the HL7 standard permits different coding systems to be used. This check is only for DNS or station number.
 S PASS=0
 D
 .;if its an ack to an existing message, don't check the receiving facility
 .I $G(HLMSTATE("ACK TO"))]"" S PASS=1 Q
 .I HDR("RECEIVING FACILITY",1)=HLCSTATE("SYSTEM","STATION") S PASS=1 Q
 .I HDR("RECEIVING FACILITY",3)'="DNS" S PASS=1 Q
 .I HDR("RECEIVING FACILITY",2)="" S PASS=1 Q
 .I $P(HDR("RECEIVING FACILITY",2),":")[HLCSTATE("SYSTEM","DOMAIN") S PASS=1 Q
 .I HLCSTATE("SYSTEM","DOMAIN")[$P(HDR("RECEIVING FACILITY",2),":") S PASS=1 Q
 I 'PASS S HLMSTATE("STATUS")="ER",HLMSTATE("MSA",3)="RECEIVING FACILITY IS "_HLCSTATE("SYSTEM","DOMAIN") S:WANTACK HLMSTATE("MSA",1)="CE"
 I PASS,WANTACK S HLMSTATE("MSA",1)="CA"
 Q
 ;
DEL777(IEN777) ;delete a record from file 777 where the read did not complete
 ;
 K ^HLA(IEN777,0)
 Q
DEL778(IEN778) ;delete a record from file 778 where the read did not complete
 ;
 K ^HLB(IEN778,0)
 Q
 ;
SPLITHDR(HDR) ;
 ;splits hdr segment into two lines, first being just components 1-6
 ;
 N TEMP,FS
 D SQUISH(.HDR)
 S FS=$E($G(HDR(1)),4)
 S TEMP(1)=$P($G(HDR(1)),FS,1,6)
 S TEMP(2)=""
 I $L(TEMP(1))<$L($G(HDR(1))) S TEMP(2)=FS_$P($G(HDR(1)),FS,7,20)
 S HDR(2)=TEMP(2)_$G(HDR(2))
 S HDR(1)=TEMP(1)
 Q
 ;
SQUISH(SEG) ;
 ;reformat the segment array into full lines
 ;
 ;nothing to do if less than 2 lines
 Q:'$O(SEG(1))
 ;
 N A,I,J,K,MAX,COUNT,LEN
 S MAX=$S($G(HLCSTATE("SYSTEM","MAXSTRING"))>256:HLCSTATE("SYSTEM","MAXSTRING"),1:256)
 S (COUNT,I)=0,J=1
 F  S I=$O(SEG(I)) Q:'I  D
 .S LEN=$L(SEG(I))
 .F K=1:1:LEN D
 ..S A(J)=$G(A(J))_$E(SEG(I),K)
 ..S COUNT=COUNT+1
 ..I (COUNT>(MAX-1)) S COUNT=0,J=J+1
 K SEG
 M SEG=A
 Q
