HLCS ;ALB/RJS,MTC,JRP - COMMUNICATIONS SERVER - ;10/04/2007  14:34
 ;;1.6;HEALTH LEVEL SEVEN;**2,9,14,19,43,57,109,132,122**;Oct 13, 1995;Build 14
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;The SEND function is invoked by the transaction processor.
 ;It's function is to $O through the ITEM multiple of the Event Driver
 ;Protocol and create child entries in the Message Text file (#772)
 ;for the message at HLMTIEN.  These child messages point back
 ;to the parent message so that message text does not need to
 ;be duplicated when a message is sent to multiple applications.
 ;
 ;The SENDACK function is also invoked by the transaction processor.
 ;It's function is to create a child entry in the Message Text file
 ;for the message at HLMTIENA and deliver the message to the
 ;application the requested/sent information.
 ;
 ;For DHCP to DHCP messaging (i.e. internal to internal), an incoming
 ;message is created in the Message Text file which is a duplication
 ;of the outgoing message.  The incoming message is then processed by
 ;calling the transaction processor.
 ;
 ;For DHCP to COTS messaging (i.e. internal to external), the message
 ;is filed in the Message Text file with the Logical Link defined and
 ;a status of PENDING TRANSMISSION.  These entries are picked up by
 ;the background filer and transmitted to the appropriate COTS system.
 ;
SEND(HLMTIEN,HLEID,HLRESULT) ;Send an HL7 message
 ;HLMTIEN=The IEN of the parent message in file # 772
 ;HLEID=The IEN of the Event Driver protocol in file #101
 ;HLRESULT=Variable for any error text (pass by reference)
 ;
 ;Declare variables
 N HLARY,HLERROR,HLEIDS,HLCLIENT,HLOGLINK,HLMTIENS,HLMSGPTR
 S HLERROR=""
 ;Direct connect
 I HLPRIO="I" D  Q
 . D DC^HLMA2
 . S HLRESULT=HLERROR
 ;Get all subscribers to the message
 D ITEM^HLUTIL2(HLEID,"PTR")
 ;Quit if no subscribers (considered successful delivery)
 G:($G(HLARY(0))'>0) EXIT
 ;Deliver message to each subscriber
 S HLEIDS=0
 F  S HLEIDS=$O(HLARY(HLEIDS)) Q:(HLEIDS'>0)  D
 .;
 .;**132 excluded subscribers **
 .N I,EXCLUDE
 .S (EXCLUDE,I)=0
 . ;
 . ; patch HL*1.6*122
 . ; F  S I=$O(HLP("EXCLUDE SUBSCRIBER",I)) Q:'I  I $G(HLP("EXCLUDE SUBSCRIBER",I))=HLEIDS S EXCLUDE=1 Q
 . F  S I=$O(HLP("EXCLUDE SUBSCRIBER",I)) Q:'I  D  Q:EXCLUDE
 .. N TEMP
 .. S TEMP=HLP("EXCLUDE SUBSCRIBER",I)
 .. I 'TEMP,TEMP]"" S TEMP=$O(^ORD(101,"B",TEMP,0))
 .. I TEMP=HLEIDS S EXCLUDE=1
 . ; patch HL*1.6*122
 . ;
 .Q:EXCLUDE
 .;** 132 end **
 .;
 .;Get pointer to receiving application
 .S HLCLIENT=+HLARY(HLEIDS),HL("EIDS")=HLEIDS,HLERROR=""
 .Q:(HLCLIENT'>0)
 .;Check and execute ROUTING LOGIC **CIRN**
 .S HLX=$G(^ORD(101,HLEIDS,774))
 .I HLX]"" D  Q
 ..N HLQUIT,HLNODE,HLNEXT
 ..S HLQUIT=0,HLNODE="",HLNEXT="D HLNEXT^HLCSUTL"
 ..X HLX I $D(HLL("LINKS")) D FWD^HLCS2 K HLL ;**CIRN**
 .;Get pointer to logical link
 .S HLOGLINK=$P(HLARY(HLEIDS),"^",2)
 .;Determine if receiving application is internal or external
 .;  Logical link has a value for external applications
 .;  Logical link is NULL for internal applications
 .I (HLOGLINK) D COTS Q
 .;Create 'incoming' message based on 'outgoing' message (internal)
 .D DHCP(HLMTIEN,HLEIDS,HLCLIENT)
 .Q:(HLERROR)
 .;Process the 'incoming' message
 .S HLERROR=""
 .D PROCESS^HLTP0(HLMSGPTR,"DHCP","",.HLERROR)
 .;Update Status of 'incoming' message to SUCCESSFULLY COMPLETED
 .; or ERROR DURING TRANSMISSION
 .D STATUS^HLTF0(HLMSGPTR,$S(HLERROR:4,1:3),$S(HLERROR:+HLERROR,1:""),$S(HLERROR:$P(HLERROR,"^",2),1:""),,$S($G(HLERR("SKIP_EVENT"))=1:1,1:0))
 .I $D(HLL("LINKS")) D FWD^HLCS2 K HLL ;**CIRN**
 D ADD^HLCS2 ;**CIRN**
EXIT S HLRESULT=HLERROR
 Q
COTS ;Internal to external communication
 ;Create child entry in Message Text file
 N HLTCP,HLTCPI,HLTCPO
 D SEND^HLMA2(HLEIDS,HLMTIEN,HLCLIENT,"D",.HLMTIENS,HLOGLINK)
 I ((+HLMTIENS)'>0) S HLERROR=HLMTIENS Q
 ;'Pass' message to background filer by setting status of child
 ;  to PENDING TRANSMISSION
 D STATUS^HLTF0(HLMTIENS,1)
 Q
DHCP(HLMTIEN,HLEIDS,HLCLIENT) ;Internal to internal communication
 ;
 ;Input  : HLMTIEN - Pointer to parent outgoing message (file #772)
 ;         HLEIDS - Pointer to subscribing protocol (file #101)
 ;         HLCLIENT - Pointer to receiving application (file # 771)
 ;
 ;Output : HLMTIENS - Pointer to child outgoing message (file #772)
 ;         HLMSGPTR - Pointer to [parent] incoming message (file #772)
 ;         HLERROR - ErrorCode ^ ErrorText
 ;
 ;Notes  : This module only copies the outgoing message into an incoming
 ;         message.  Delivery of the message (i.e. processing of it)
 ;         must be done by the calling application.
 ;       : Message/batch header (MSH/BSH) is built and placed in the
 ;         incoming message
 ;       : HLMTIENS, HLMSGPTR, and HLERROR will be initialized
 ;       : Existance and validity of input is assumed
 ;
 ;Declare variables
 N MSGID,MSGDT,MSGDTH,HDR2BLD,TMP,HLHDR,BHSHDR
 S HLERROR=""
 S HLMTIENS=0
 S HLMSGPTR=0
 ;Create child entry in Message Text file
 D SEND^HLMA2(HLEIDS,HLMTIEN,HLCLIENT,"D",.HLMTIENS)
 I ((+HLMTIENS)'>0) S HLERROR=HLMTIENS Q
 ;'Receive' message by making an incoming message
 ;Determine type of header to build
 S TMP=$G(^HL(772,HLMTIEN,0))
 S HDR2BLD=$P(TMP,"^",14)
 ;Build message header (MSH)
 I (HDR2BLD="M") D  Q:(HLERROR)
 .S TMP=""
 .D HEADER^HLCSHDR(HLMTIENS,.TMP)
 .Q:(TMP="")
 .;Error building header
 .S HLERROR="4^Unable to build message header => "_TMP
 .D STATUS^HLTF0(HLMTIENS,4,0,$P(HLERROR,"^",2))
 ;Build batch header (BHS or FHS)
 I (HDR2BLD'="M") D  Q:(HLERROR)
 .S TMP=""
 .D BHSHDR^HLCSHDR(HLMTIENS)
 .S:($E(HLHDR(1),1)="-") TMP=$P(HLHDR(1),"^",2)
 .Q:(TMP="")
 .;Error building header
 .S HLERROR="4^Unable to build batch header => "_TMP
 .D STATUS^HLTF0(HLMTIENS,4,0,$P(HLERROR,"^",2))
 ;Create entry for 'incoming' message
 D CREATE^HLTF(.MSGID,.HLMSGPTR,.MSGDT,.MSGDTH)
 ;Move header and rest of message into 'incoming' message
 I (HDR2BLD="M") D
 .;Use MSH as header
 .D MRGINT^HLTF1(HLMTIEN,HLMSGPTR,"HLHDR")
 I (HDR2BLD'="M") D
 .;Use BHS or FHS as header
 .D MRGINT^HLTF1(HLMTIEN,HLMSGPTR,"BHSHDR")
 ;Set status of outgoing message to AWAITING ACKNOWLEDGEMENT
 D STATUS^HLTF0(HLMTIENS,$S($P(^HL(772,HLMTIEN,0),U,7):3,1:2))
 ;Set status of 'incoming' message to AWAITING PROCESSING
 D STATUS^HLTF0(HLMSGPTR,9)
 Q
SENDACK(HLMTIENA,HLEID,HLEIDS,HLRESULT) ;Send an HL7 acknowledgement/response
 ;HLMTIENA=The IEN of the parent acknowledgment/response message in
 ;         file # 772
 ;HLEIDS=The IEN of the Subscribing protocol in file # 101
 ;HLEID=The IEN of the Event Driver protocol in file #101
 ;HLRESULT=Variable for any error text (pass by reference)
 ;
 N HLERROR,HLOGLINK,HLCLIENT,HLMTIENS,HLMSGPTR,HLCLNODE
 I $G(HLMTIENA)=""!($G(HLEID)="")!($G(HLEIDS)="") S HLERROR="0^7^"_$G(^HL(771.7,7,0))_"at SENDACK^HLCS entry point" G EXIT2
 S HLCLNODE=$G(^ORD(101,HLEID,770))
 ;Get pointers to Logical Link & receiving application
 S HLOGLINK=$P($G(^ORD(101,HLEIDS,770)),U,7)
 ;Application needed to dynamically address the ACK (tcp/ip)
 ;(set HLL("LINKS") array before calling GENACK)
 I $D(HLL("LINKS")) D  Q:'HLOGLINK
 .S HLOGLINK=$P(HLL("LINKS",1),"^",2) Q:HLOGLINK=""
 .K HLL("LINKS")
 .I +HLOGLINK'=HLOGLINK S HLOGLINK=$O(^HLCS(870,"B",HLOGLINK,0))
 S HLCLIENT=$P(HLCLNODE,U,1)
 Q:('HLCLIENT)
 ;Determine if receiving application is internal or external
 ;  Logical link has a value for external applications
 ;  Logical link is NULL for internal applications
 I (HLOGLINK) D COTSACK Q
 ;Create 'incoming' message based on 'outgoing' message (internal)
 D DHCP(HLMTIENA,HLEID,HLCLIENT)
 ;Process the 'incoming' message
 I (HLMSGPTR) D
 .S HLERROR=""
 .D PROCESS^HLTP0(HLMSGPTR,"DHCP","",.HLERROR)
 ;Update Status of 'incoming' message to SUCCESSFULLY COMPLETED
 ; or ERROR DURING TRANSMISSION
 D STATUS^HLTF0(HLMSGPTR,$S(HLERROR:4,1:3),$S(HLERROR:+HLERROR,1:""),$S(HLERROR:$P(HLERROR,"^",2),1:""))
EXIT2 ;
 S HLRESULT=$G(HLERROR)
 Q
COTSACK ;Internal to external communication of acknowledgements/responses
 ;Create child entry in Message Text file
 D SEND^HLMA2(HLEID,HLMTIENA,HLCLIENT,"D",.HLMTIENS,HLOGLINK)
 ;'Pass' message to background filer by setting status of child
 ;  to PENDING TRANSMISSION
 D STATUS^HLTF0(HLMTIENS,1)
 Q
