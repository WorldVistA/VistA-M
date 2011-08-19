HLOCNRT ;DAOU/ALA-Generate HL7 Optimized Message ;05/12/2009
 ;;1.6;HEALTH LEVEL SEVEN;**126,132,134,137,146**;Oct 13, 1995;Build 16
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;**Program Description**
 ;  This program uses the traditional protocol setup and hard-coded
 ;  message builders  of HL7 1.6 to send messages via HL7 Optimized code.
 Q
 ;
EN(HLOPRTCL,ARYTYP,HLP,HLL,RESULT) ;
 ;Input:
 ;   HLOPRTCL (required) Protocol IEN or Protocol Name
 ;   ARYTYP   (required) set to "GM" if the message is contained in the global array ^TMP("HLS",$J), or set to "LM" if the message is contained in the local array HLA("HLS").
 ;   HLP  (optional, pass-by-reference) Additional HL7 message
 ;        parameters. These optional subscripts to HLP are supported:
 ;             "APP ACK RESPONSE" = <tag^routine> to call when the app ack is received
 ;             "CONTPTR"
 ;             "SECURITY"
 ;             "SEQUENCE QUEUE" - A queue used to maintain the order of
 ;                   the messages via application acks. If used, the
 ;                   application MUST specify that both an accept ack
 ;                   and application ack be returned. 
 ;        
 ;   HLL  (optional, pass-by-reference) Used to dynamically add message
 ;        recipients.  The format is HLL("LINKS",<i>)=<destination protocol name or ien>^<destination link or ien>.
 ;       
 ;
 ;  Output
 ;    RESULT (pass-by-reference)
 ;            On success:
 ;                 <subscriber protocol ien>^<link ien>^<message id>^0
 ;            On failure:
 ;                 <subscriber protocol ien>^<link ien>^<message id>^<error code>^<optional error message>
 ;
 ;    RESULT("IEN")=the ien, file 778, if a message record in file 778
 ;                  was created, regardless of whether or not the message
 ;                  was successfully queued for transmission.
 ;
 ;            If the message was sent to more than 1 destination,
 ;            the addtional message statuses are returned as RESULT(1),
 ;            RESULT(2), etc., in the same format as above, as the iens
 ;            of message records created are returned as RESULT(1,"IEN"),
 ;            RESULT(2,"IEN"), etc.
 ;    ZTSTOP = Stop processing flag (used by HDR)
 ;    Function returns:
 ;            On success:  1
 ;            On failure:  ^<error code>^<error message>
 ;
 NEW HLORESL,HLMSTATE,APPARMS,WHOTO,ERROR,WHO
 S ZTSTOP=0,HLORESL=1,RESULT=""
 ;
 ;  Get IEN of protocol if name is passed
 I '$L(HLOPRTCL) S HLORESL="^99^HL7 1.6 Protocol not found",RESULT="^^"_HLORESL,ZTSTOP=1 Q HLORESL
 I ('HLOPRTCL)!(HLOPRTCL'=+HLOPRTCL) S HLOPRTCL=+$O(^ORD(101,"B",HLOPRTCL,0))
 I 'HLOPRTCL S HLORESL="^99^HL7 1.6 Protocol not found",RESULT="^^"_HLORESL,ZTSTOP=1 Q HLORESL
 I '$D(^ORD(101,HLOPRTCL)) S HLORESL="^99^HL7 1.6 Protocol not found",RESULT="^^"_HLORESL,ZTSTOP=1 Q HLORESL
 ;
 ;  If the VistA HL7 Protocol exists, call the Conversion Utility
 ;  to set up the APPARMS, WHOTO arrays from protocol logical link,
 ;   and the optional HLL and HLP arrays
 D APAR^HLOCVU(HLOPRTCL,.APPARMS,.WHO,.WHOTO,.HLP,.HLL)
 ;
 ; If special HLP parameters are defined, convert them
 I $D(HLP) D
 . I $G(HLP("SECURITY"))'="" S APPARMS("SECURITY")=HLP("SECURITY")
 . I $G(HLP("CONTPTR"))'="" S APPARMS("CONTINUATION POINTER")=HLP("CONTPTR")
 . I $G(HLP("QUEUE"))'="" S APPARMS("QUEUE")=HLP("QUEUE")
 . I $G(HLP("SEQUENCE QUEUE"))'="" S APPARMS("SEQUENCE QUEUE")=HLP("SEQUENCE QUEUE")
 . I $G(HLP("APP ACK RESPONSE"))'="" S APPARMS("APP ACK RESPONSE")=HLP("APP ACK RESPONSE")
 ;
 ;  Create HL Optimized message
 I '$$NEWMSG^HLOAPI(.APPARMS,.HLMSTATE,.ERROR) S HLORESL="^99^"_ERROR,ZTSTOP=1,RESULT="^^"_HLORESL Q HLORESL
 I $E(ARYTYP,1)="G" S HLOMESG="^TMP(""HLS"",$J)"
 I $E(ARYTYP,1)="L" S HLOMESG="HLA(""HLS"")"
 ;
 ;  Move the existing message from array into HL Optimized
 D MOVEMSG^HLOAPI(.HLMSTATE,HLOMESG)
 ; 
 ;  Send message via HL Optimized
 I $D(WHOTO) D
 .N COUNT
 .I '$$SENDMANY^HLOAPI1(.HLMSTATE,.APPARMS,.WHOTO) D
 ..S HLORESL="^99^Unable to send message",ZTSTOP=1
 .I $G(WHOTO(1,"IEN")) D
 ..S RESULT=WHO(1)_"^"_$P($G(^HLB(WHOTO(1,"IEN"),0)),"^")_"^"_$S($G(WHOTO(1,"QUEUED")):0,1:1)_"^"_$G(WHOTO(1,"ERROR"))
 ..;**P146 START CJM
 ..S RESULT("IEN")=WHOTO(1,"IEN")
 ..;**P146 END CJM
 .E  D
 ..S RESULT=$G(WH0(1))_"^^1^"_$G(WHOTO(1,"ERROR"))
 ..;**P146 START CJM
 ..S RESULT("IEN")=""
 ..;**P146 END CJM
 ..S HLORESL="^99^"_$G(WHOTO(1,"ERROR")),ZTSTOP=1
 .S COUNT=1
 .F  S COUNT=$O(WHOTO(COUNT)) Q:'COUNT  D
 ..I $G(WHOTO(COUNT,"IEN")) D
 ...S RESULT(COUNT-1)=WHO(COUNT)_"^"_$P($G(^HLB(WHOTO(COUNT,"IEN"),0)),"^")_"^"_$S($G(WHOTO(COUNT,"QUEUED")):0,1:1)_"^"_$G(WHOTO(COUNT,"ERROR"))
 ...;**P146 START CJM
 ...S RESULT(COUNT-1,"IEN")=WHOTO(COUNT,"IEN")
 ...;**P146 END CJM
 ..E  D
 ...S RESULT(COUNT-1)=WH0(COUNT)_"^^1^"_$G(WHOTO(COUNT,"ERROR"))
 ...;**P146 START CJM
 ...S RESULT(COUNT-1,"IEN")=""
 ...;**P146 END CJM
 ;
 E  S HLORESL="^99^Unable to send message",ZTSTOP=1,RESULT="^^"_HLORESL
 Q HLORESL
