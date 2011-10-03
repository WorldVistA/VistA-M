HLOAPI7 ;IRMFO-ALB/PIJ -API for retrieving HLO or HL7 information about a message;03/24/2004  14:43 ;06/04/2009
 ;;1.6;HEALTH LEVEL SEVEN;**146**;Oct 13, 1995;Build 16
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
GETMSG(IEN,MSG,FLAG) ; Description:  This function allows the user to toggle
 ;between HL7 and HLO messages and to return message information in a local array or a global.
 ;I '$G(FLAG)  then MSG, IEN and file 778 are used for HLO messages.
 ;I $G(FLAG) then MSG, IEN and file 773 are used for HL7 messages.
 ;Input: 
 ;  IEN - The internal entry number of the message.
 ;  MSG - The array name used to return the message information.  Can be a local array or global.
 ;  FLAG - I '$G(FLAG)  use variables for HLO messages.
 ;  FLAG - I $G(FLAG) use variables for HL7 messages.
 ;Output:
 ;  Function returns 1 on success, 0 on failure.  Failure would indicate that the
 ;  message was not found or variable IEN or MSG was not passed
 ;  MSG(0)= IEN (HL7 or HLO)
 ; HLO...
 ;  MSG(1)= ^HLB(IEN,0)
 ;  MSG(2)= ^HLB(IEN,1)
 ;  MSG(3)= ^HLB(IEN,2)
 ;  MSG(4)= ^HLB(IEN,3)
 ;  MSG(5)= ^HLB(IEN,4)
 ;  MSG(6)=""
 ;  MSG(7)="^HLA(IEN,...
 ;  
 ; HL7...
 ; Multiple MSG(1) = ^HLMA(IEN,"MSH",I,0)
 ; Multiple MSG(i)= ^HL(772,R772,"IN",I,0)
 ;
 K DATA,@MSG
 N CTR,DATA,I,N1,N2,N3,R772,R777,STAT
 Q:'$G(IEN) 0
 Q:'$D(MSG) 0
 Q:MSG="FLAG" 0 ;  may not need...
 S (CTR,STAT)=1
 I '$G(FLAG) Q:'$D(^HLB(IEN)) 0  D  Q STAT
 . ;HLO
 . S N1=""
 . F  S N1=$O(^HLB(IEN,N1)) Q:N1=""  D
 . . I $D(^HLB(IEN,N1))=1 D
 . . . S DATA=^HLB(IEN,N1)
 . . . S:N1=0 R777=$P(DATA,U,2)
 . . . S @MSG@(CTR)=DATA
 . . . S CTR=CTR+1
 . . I $D(^HLB(IEN,N1))=10 D  ; this part is for Batch messages ^HLB(D0,3)
 . . . S N2=""
 . . . F  S N2=$O(^HLB(IEN,N1,N2)) Q:N2=""  D
 . . . . F I=0:1:2  I $D(^HLB(IEN,N1,N2,I))=1 S @MSG@(CTR)=^HLB(IEN,N1,N2,I),CTR=CTR+1
 . ; get Segments for HLO
 . I 'R777 S STAT=0 Q
 . S @MSG@(CTR)="",CTR=CTR+1  ; add blank line between message header and message body
 . S (N1,N2,N3)=""
 . F  S N1=$O(^HLA(R777,N1)) Q:N1=""  D
 . . I $D(^HLA(R777,N1))=1 D
 . . . S @MSG@(CTR)=^HLA(R777,N1)
 . . . S CTR=CTR+1
 . . I $D(^HLA(R777,N1))=10 D
 . . . S N2=""
 . . . F  S N2=$O(^HLA(R777,N1,N2)) Q:N2=""  D
 . . . . I $D(^HLA(R777,N1,N2))=1 D
 . . . . . S DATA=^HLA(R777,N1,N2)
 . . . . . S @MSG@(CTR)=^HLA(R777,N1,N2),CTR=CTR+1
 . . . . I $D(^HLA(R777,N1,N2,0))=1 D
 . . . . . S DATA=^HLA(R777,N1,N2,0)
 . . . . . S @MSG@(CTR)=^HLA(R777,N1,N2,0),CTR=CTR+1
 . . . . S N3=""
 . . . . F  S N3=$O(^HLA(R777,N1,N2,1,N3)) Q:N3=""  D
 . . . . . I $D(^HLA(R777,N1,N2,1,N3,0))=1 D
 . . . . . . S DATA=^HLA(R777,N1,N2,1,N3,0)
 . . . . . . S @MSG@(CTR)=^HLA(R777,N1,N2,1,N3,0),CTR=CTR+1
 ;
 ;HL7
 Q:'$D(^HLMA(IEN,0)) 0
 S DATA=^HLMA(IEN,0) Q:'DATA 0  D
 . S R772=$P(DATA,U,1)
 . I 'R772 S STAT=0 Q
 . ; get HL7 Message Header
 . S N1=""
 . F  S N1=$O(^HLMA(IEN,N1)) Q:N1=""  D
 . . I $D(^HLMA(IEN,N1))=1 D
 . . . S DATA=^HLMA(IEN,N1)
 . . . S @MSG@(CTR)=DATA
 . . . S CTR=CTR+1
 . . S N2=""
 . . F  S N2=$O(^HLMA(IEN,N1,N2)) Q:N2=""  D
 . . . I $D(^HLMA(IEN,N1,N2))=1 D
 . . . . S DATA=^HLMA(IEN,N1,N2)
 . . . . S @MSG@(CTR)=DATA
 . . . . S CTR=CTR+1
 . . . S N3=""
 . . . F  S N3=$O(^HLMA(IEN,N1,N2,N3)) Q:N3=""  D
 . . . . I $D(^HLMA(IEN,N1,N2,N3))=1 D
 . . . . . S DATA=^HLMA(IEN,N1,N2,N3)
 . . . . . S @MSG@(CTR)=DATA
 . . . . . S CTR=CTR+1
 . ; get HL7 Message Body
 . S @MSG@(CTR)="",CTR=CTR+1  ; add blank line between message header and message body
 . S N1=""
 . F  S N1=$O(^HL(772,R772,N1)) Q:N1=""  D
 . . I $D(^HL(772,R772,N1))=1 D
 . . . S DATA=^HL(772,R772,N1)
 . . . S @MSG@(CTR)=DATA
 . . . S CTR=CTR+1
 . . S N2=""
 . . F  S N2=$O(^HL(772,R772,N1,N2)) Q:N2=""  D
 . . . I $D(^HL(772,R772,N1,N2))=1 D
 . . . . S DATA=^HL(772,R772,N1,N2)
 . . . . S @MSG@(CTR)=DATA
 . . . . S CTR=CTR+1
 . . . S N3=""
 . . . F  S N3=$O(^HL(772,R772,N1,N2,N3)) Q:N3=""  D
 . . . . I $D(^HL(772,R772,N1,N2,N3))=1 D
 . . . . . S DATA=^HL(772,R772,N1,N2,N3)
 . . . . . S @MSG@(CTR)=DATA
 . . . . . S CTR=CTR+1
 Q STAT
