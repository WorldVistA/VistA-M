HLMSG ;ALB/CJM-HL7 - APIs for files 772/773 ;02/04/2004
 ;;1.6;HEALTH LEVEL SEVEN;**118**;Oct 13, 1995
 ;
GETMSG(IEN,MSG) ;
 ;Description: given the message ien=MSGIEN (required), it returns the MSG array containing information about the message, defined below.
 ;Input:
 ;  IEN - the ien of the message in file 773
 ;Output:
 ;  Function returns 1 on success, 0 on failure
 ;  MSG (pass by reference, required) These are the subscripts returned:
 ;    "BATCH"  = 1 if this is a batch message, 0  if not
 ;       "CURRENT MESSAGE" - defined only for batch messages -  a counter used during building and parsing messages to indicate the current message.  It will be set to 0 initially.
 ;  "BODY" - ptr to file 772 which contains the body of the message.
 ;  "CURRENT LINE" -  a counter used during building and parsing of
 ;     messages to indicate the current line within the message. For
 ;     batch messages where each message within the batch is stored
 ;     separately, this field indicates the position within the current
 ;     individual message
 ;  "HDR" - the header segment, NOT parsed, as a sequence of lines HDR(i)
 ;  "IEN" - ien, file 773
 ;
 K MSG
 Q:'$G(IEN) 0
 N I
 S MSG("IEN")=IEN
 S MSG("BODY")=$P($G(^HLMA(IEN,0)),"^")
 Q:'MSG("BODY") 0
 ;
 S MSG("BATCH")=$S($P(^HL(772,MSG("BODY"),0),"^",14)="B":1,1:0)
 I MSG("BATCH") S MSG("BATCH","CURRENT MESSAGE")=0
 S MSG("CURRENT LINE")=0
 S I=0
 F  S I=$O(^HLMA(IEN,"MSH",I)) Q:'I  S MSG("HDR",I)=$G(^HLMA(IEN,"MSH",I,0))
 Q 1
 ;
NEXTSEG(MSG,SEG) ;
 ;Description:  Returns the next segment as a set of lines stored in SEG.
 ;Input:
 ;  MSG (pass by reference, required)
 ;Output:
 ;  Function returns 1 on success, 0 on failure (no more segments)
 ;  SEG (pass by reference, required)
 ;
 K SEG
 Q:MSG("CURRENT LINE")=-1 0
 I 'MSG("BATCH") D
 .N I,J
 .S J=1,I=MSG("CURRENT LINE")
 .F  S I=$O(^HL(772,MSG("BODY"),"IN",I)) Q:'I  Q:$G(^HL(772,MSG("BODY"),"IN",I,0))=""  S SEG(J)=^HL(772,MSG("BODY"),"IN",I,0),J=J+1
 .I 'I S MSG("CURRENT LINE")=-1
 .I I S MSG("CURRENT LINE")=I
 I MSG("BATCH") D
 .N I,J
 .S I=MSG("CURRENT LINE")
 .F  S I=$O(^HL(772,MSG("BODY"),"IN",I)) Q:'I  I $G(^HL(772,MSG("BODY"),"IN",I,0))'="" D  Q
 ..Q:$E($G(^HL(772,MSG("BODY"),"IN",I,0)),1,3)="MSH"
 ..I $E($G(^HL(772,MSG("BODY"),"IN",I,0)),1,3)="BTS" S MSG("CURRENT LINE")=-1,MSG("BATCH","CURRENT MESSAGE")=-1 Q
 ..S SEG(1)=$G(^HL(772,MSG("BODY"),"IN",I,0))
 ..S J=2
 ..F  S I=$O(^HL(772,MSG("BODY"),"IN",I)) Q:'I  Q:$G(^HL(772,MSG("BODY"),"IN",I,0))=""  S SEG(J)=^HL(772,MSG("BODY"),"IN",I,0),J=J+1
 .I 'I S MSG("CURRENT LINE")=-1
 .I I S MSG("CURRENT LINE")=I-1
 Q $S($D(SEG):1,1:0)
 ;
NEXTMSG(MSG,HDR) ;
 ;Advances to the next message in the batch
 ;Input:
 ;  MSG (pass by reference, required) - defined by $$GETMSG()
 ;Output:
 ;  Function returns 1 on success, 0 if no more messages
 ;  MSH - updated with current position in the message
 ;  HDR (pass by reference, required) returns the header as an array of 2lines HDR(1),HDR(2)
 ;
 K HDR
 N ARY,I,J
 S ARY="^HL(772,"_MSG("BODY")_",""IN"")"
 S I=MSG("CURRENT LINE")
 F  S I=$O(@ARY@(I)) Q:'I  D:$G(@ARY@(I,0))'=""  Q:$D(HDR)  Q:MSG("CURRENT LINE")=-1
 .I $E($G(@ARY@(I,0)),1,3)="BTS" S MSG("CURRENT LINE")=-1,MSG("BATCH","CURRENT MESSAGE")=-1 Q
 .I $E($G(@ARY@(I,0)),1,3)="MSH" D
 ..S J=1
 ..S HDR(J)=$G(@ARY@(I,0)),MSG("CURRENT LINE")=I,MSG("BATCH","CURRENT MESSAGE")=$G(MSG("BATCH","CURRENT MESSAGE"))+1
 ..F  S I=$O(@ARY@(I)) Q:'I  Q:$G(@ARY@(I,0))=""  S J=J+1,HDR(J)=$G(@ARY@(I,0))
 .E  D
 ..F  S I=$O(@ARY@(I)) Q:'I  Q:$G(@ARY@(I,0))=""
 Q $S($D(HDR):1,1:0)
