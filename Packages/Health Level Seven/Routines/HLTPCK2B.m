HLTPCK2B ;OIFO-O/RJH - Message Header Validation (Con't) ; 09/22/2009  14:41
 ;;1.6;HEALTH LEVEL SEVEN;**120,133,122,148**;Oct 13, 1995;Build 3
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; splitted from HLTPCK2A
 ; to be called from HLTPCK2A
 ;
MS ;Check for Message Structure Code
 I $G(ARY("MTN_ETN"))'="" D
 . S ARY("MTP_ETP")=0
 . S ARY("MTP_ETP")=+$O(^HL(779.005,"B",ARY("MTN_ETN"),0))
 . I ('ARY("MTP_ETP")) S:(ERR="") ERR="Invalid Message Structure Code" Q
 ;
 ;Get server and client Protocols
MSA ;if ack, then get information and quit, we don't need to respond
 I $G(MSA)]"" D  Q
 . ;Message is an acknowledgement, find original message
 . S ARY("MSAID")=$P(MSA,FS,2),ARY("MTIENS")=0
 . I ARY("MSAID")="" S:(ERR="") ERR="Invalid Message Control ID in MSA Segment - No Message ID" Q
 . F  S ARY("MTIENS")=+$O(^HLMA("AH",ARY("SAP"),ARY("MSAID"),ARY("MTIENS"))) Q:'ARY("MTIENS")!($P($G(^HLMA(ARY("MTIENS"),0)),U,3)="O")
 . I 'ARY("MTIENS") S:(ERR="") ERR="Invalid Message Control ID in MSA Segment - No message IEN in ""AH"" x-ref" Q
 . ;get subscriber protocol and ack. to (show if this is an ack to an ack)
 . S X=$G(^HLMA(ARY("MTIENS"),0)),ARY("EIDS")=$P(X,U,8),ARY("ACK")=$P(X,U,10)
 . ;if no subscriber protocol then response msg. is invalid
 . ;
 . ; patch HL*1.6*122 start
 . ; comment out the following code: for patch 109- dynamic addressing
 . ; I ('ARY("EIDS")) S:(ERR="") ERR="Invalid Message Control ID in MSA Segment - No Subscr. IEN in 773" Q
 . ;get message text ien in file 772 and server protocol, 'EID'
 . S ARY("MTIEN")=+X,X=$G(^HL(772,+X,0)),ARY("EID")=$P(X,U,10)
 . I ('ARY("EID")) S:(ERR="") ERR="Event Protocol not found" Q
 . ; D EVENT^HLUTIL1(ARY("EIDS"),"770,773",.HLN)
 . I ARY("EIDS") D EVENT^HLUTIL1(ARY("EIDS"),"770,773",.HLN)
 . ; patch HL*1.6*122 end
 ;
 ;Find Server Protocol - based on sending application, message type,
 ;event type and version ID
 I ARY("ETP") S ARY("EID")=+$O(^ORD(101,"AHL1",ARY("SAP"),ARY("MTP"),ARY("ETP"),ARY("VEP"),0))
 ;
 ;Find Server Protocol - based on sending application, message type,
 ;and version ID
 I 'ARY("ETP") S ARY("EID")=+$O(^ORD(101,"AHL21",ARY("SAP"),ARY("MTP"),ARY("VEP"),0))
 ;
 I ('ARY("EID")) S:(ERR="") ERR="Event Protocol not found" Q
 ;Find Client Protocol - in ITEM multiple of Server Protocol
 S ARY("EIDS")=0
 F  S ARY("EIDS")=+$O(^ORD(101,ARY("EID"),775,"B",ARY("EIDS"))) Q:'ARY("EIDS")!($P($G(^ORD(101,ARY("EIDS"),770)),U,2)=ARY("RAP"))
 I 'ARY("EIDS") S ERR="Invalid Receiving Application for this Event" Q
 D EVENT^HLUTIL1(ARY("EIDS"),"770,773",.HLN)
 ;
LLP ;Get logical link pointer
 S ARY("LL")=$P($G(HLN(770)),"^",7)
 ;
FAC ;Get sending/rec facility, validate if necessary
 ;
 S HLCS=$E(ECH,1) ;Get component separator
 S ARY("RAF")=$$P^HLTPCK2(.HDR,6) ;Receiving Facility
 S ARY("SAF")=$$P^HLTPCK2(.HDR,4) ;Sending Facility
 ;Get sending/receiving facility from Application Parameter file(771)
 S HL771SF=$P($G(^HL(771,ARY("SAP"),0)),U,3)
 S HL771RF=$P($G(^HL(771,ARY("RAP"),0)),U,3)
 ;Sending/Receiving facility required?
 S X=$G(^ORD(101,ARY("EIDS"),773))
 S HLSFREQ=+X,HLRFREQ=+$P(X,U,2)
RF ;Validate Receiving Facility
 I HLRFREQ D
 .I ARY("RAF")="" S:ERR="" ERR="Missing required receiving facility"
 .I HL771RF]"" D  Q
 ..;Facility data in 771 overrides data in site paramter file
 ..Q
 .;Check against local default value (site parameters)
 .Q:ARY("RAF")=(HLINSTN_HLCS_HLDOM_HLCS_"DNS")
 .;
 .; patch HL*1.6*120 start
 .; I $P(ARY("RAF"),HLCS)=HLINSTN,$P(ARY("RAF"),HLCS,3)="DNS" D  Q
 . I $P(ARY("RAF"),HLCS,3)="DNS" D  Q
 .. N ERROR,HLDOMP1,HLDOMP2
 .. ; S HLDOMP1=$P(ARY("RAF"),HLCS,2),HLDOMP1=$$FIND1^DIC(4.2,"","BMX",HLDOMP1,"B^C","","ERROR")
 .. S HLDOMP1=$P(ARY("RAF"),HLCS,2)
 .. ;
 .. ; assume the format is <domain>:<port #>
 .. I HLDOMP1[":" S ARY("RAF-PORT")=$P(HLDOMP1,":",2)
 .. S HLDOMP1=$P(HLDOMP1,":")
 .. S ARY("RAF-DOMAIN")=HLDOMP1
 .. ;
 .. ; if first piece of domain is "HL7." or "MPI.", remove it
 .. I ($E(HLDOMP1,1,4)="HL7.")!($E(HLDOMP1,1,4)="MPI.") D
 ... S HLDOMP1=$P(HLDOMP1,".",2,99)
 .. S HLDOMP1=$$FIND1^DIC(4.2,"","BMX",HLDOMP1,"B^C","","ERROR")
 .. S HLDOMP2=HLDOM,HLDOMP2=$$FIND1^DIC(4.2,"","BMX",HLDOMP2,"B^C","","ERROR")
 .. I HLDOMP1&HLDOMP2&(HLDOMP1=HLDOMP2) Q
 .. ;
 .. ; check DNS domain and ip address
 .. ;initialize variable, HLDOMP("FLAG")
 .. S HLDOMP("FLAG")=0
 .. I ARY("RAF-DOMAIN")]"" D
 ... ;
 ... ; match DNS domain
 ... I $D(^HLCS(870,"DNS",ARY("RAF-DOMAIN"))) D  Q
 .... S HLDOMP("FLAG")=1
 .... S ARY("RAF-LL")=+$O(^HLCS(870,"DNS",ARY("RAF-DOMAIN"),0))
 ... I $D(^HLCS(870,"DNS",$$UP^XLFSTR(ARY("RAF-DOMAIN")))) D  Q
 .... S HLDOMP("FLAG")=1
 .... S ARY("RAF-LL")=+$O(^HLCS(870,"DNS",$$UP^XLFSTR(ARY("RAF-DOMAIN")),0))
 ... I $D(^HLCS(870,"DNS",$$LOW^XLFSTR(ARY("RAF-DOMAIN")))) D  Q
 .... S HLDOMP("FLAG")=1
 .... S ARY("RAF-LL")=+$O(^HLCS(870,"DNS",$$LOW^XLFSTR(ARY("RAF-DOMAIN")),0))
 ... ;
 ... ; match ip address
 ... I $D(^HLCS(870,"IP",ARY("RAF-DOMAIN"))) D  Q
 .... S HLDOMP("FLAG")=1
 .... S ARY("RAF-LL")=+$O(^HLCS(870,"IP",ARY("RAF-DOMAIN"),0))
 .. Q:HLDOMP("FLAG")=1
 .. I $P(ARY("RAF"),HLCS)=HLINSTN Q
 .. ;
 .. ; patch HL*1.6*148
 .. ; S:ERR="" ERR="Receiving Facility mismatch."
 .. S:ERR="" ERR="Receiving Facility Mismatch."
 . I $P(ARY("RAF"),HLCS)=HLINSTN Q
 . ; patch HL*1.6*148
 . ; S:ERR="" ERR="Receiving Facility mismatch."
 . S:ERR="" ERR="Receiving facility mismatch."
 ; patch HL*1.6*120 end
 ;
SF ;Validate Sending Facility
 I HLSFREQ D
 .I ARY("SAF")="" S:ERR="" ERR="Missing required sending facility"
 .I HL771SF]"" D  Q
 ..;Check for facility data in 771
 ..Q
 .;If default value was sent, validate that DOMAIN RESOLVES TO LOGICAL LINK
 .;If so, use this instead of Protocol definition for return path
 .;
 .; patch HL*1.6*120 start
 . N HLDOMP
 . ; S HLDOMP=$P(ARY("SAF"),HLCS,2),HLDOMP=$$FIND1^DIC(4.2,"","BMX",HLDOMP,"B^C","","ERROR")
 . S HLDOMP=$P(ARY("SAF"),HLCS,2)
 . ;
 . ; assume the format is <domain>:<port #>
 . I HLDOMP[":" S ARY("SAF-PORT")=$P(HLDOMP,":",2)
 . S HLDOMP=$P(HLDOMP,":")
 . S ARY("SAF-DOMAIN")=HLDOMP
 . ;
 . ; if first piece of domain is "HL7." or "MPI.", remove it
 . I ($E(HLDOMP,1,4)="HL7.")!($E(HLDOMP,1,4)="MPI.") D
 .. S HLDOMP=$P(HLDOMP,".",2,99)
 . S HLDOMP=$$FIND1^DIC(4.2,"","BMX",HLDOMP,"B^C","","ERROR")
 .;Note: This expects a unique domain in domain file. Multiple entries will fail
 . ; I 'HLDOMP S:ERR="" ERR="Unrecognized/ambiguous domain in sending facility"
 . ;
 . ; check DNS domain and ip address
 . I 'HLDOMP D
 .. ;
 .. ;initialize variable, HLDOMP("FLAG")
 .. S HLDOMP("FLAG")=0
 .. I ARY("SAF-DOMAIN")]"" D
 ... ;
 ... ; match DNS domain
 ... I $D(^HLCS(870,"DNS",ARY("SAF-DOMAIN"))) D  Q
 .... S HLDOMP("FLAG")=1
 .... S ARY("SAF-LL")=+$O(^HLCS(870,"DNS",ARY("SAF-DOMAIN"),0))
 ... I $D(^HLCS(870,"DNS",$$UP^XLFSTR(ARY("SAF-DOMAIN")))) D  Q
 .... S HLDOMP("FLAG")=1
 .... S ARY("SAF-LL")=+$O(^HLCS(870,"DNS",$$UP^XLFSTR(ARY("SAF-DOMAIN")),0))
 ... I $D(^HLCS(870,"DNS",$$LOW^XLFSTR(ARY("SAF-DOMAIN")))) D  Q
 .... S HLDOMP("FLAG")=1
 .... S ARY("SAF-LL")=+$O(^HLCS(870,"DNS",$$LOW^XLFSTR(ARY("SAF-DOMAIN")),0))
 ... ;
 ... ; match ip address
 ... I $D(^HLCS(870,"IP",ARY("SAF-DOMAIN"))) D  Q
 .... S HLDOMP("FLAG")=1
 .... S ARY("SAF-LL")=+$O(^HLCS(870,"IP",ARY("SAF-DOMAIN"),0))
 .. Q:HLDOMP("FLAG")=1
 .. ; quit if 1st component defined
 .. S ARY("SAF-COMPONENT1")=$P(ARY("SAF"),HLCS,1)
 .. Q:ARY("SAF-COMPONENT1")]""
 .. ; patch HL*1.6*148
 .. ; S:ERR="" ERR="Receiving Facility mismatch."
 .. S:ERR="" ERR="Sending Facility mismatch."
 . ; patch HL*1.6*120 end
 . ;
 .Q:HLDOMP=$P(HLPARAM,U)  ;This is local app to app
 .I HLDOMP N HLNK S HLNK=+$O(^HLCS(870,"D",HLDOMP,0))
 .I $G(HLNK) S ARY("LL")=HLNK
 ;
PID ;Validate processing ID
 I ("DTP"'[ARY("PID")) S:(ERR="") ERR="Invalid HL7 Processing ID"
 S HLPID=$P(HLPARAM,U,3) ;site param
 S X=$G(^ORD(101,ARY("EID"),770)),X=$P(X,U,6) ;event driver
 ;If message is 'debug' then event driver must be 'debug.'
 ;If message is 'test' or 'production', then site param must match
 I ARY("PID")="D"&(X'="D") S:ERR="" ERR="Processing ID Mismatch with Event Driver"
 I ARY("PID")'="D"&(HLPID'=ARY("PID")) S:ERR="" ERR="Processing ID Mismatch with Site Parameters"
 ;
SEC ;Validate security field - access code and electronic signature
 I ($P($G(HLN(773)),"^",3)) D
 .S X=$P($$P^HLTPCK2(.HDR,8),$E(ECH))
 .S X=$$UPPER^HLFNC(X)
 .D ^XUSHSH
 .I X="",(MSA="") S:(ERR="") ERR="Invalid access code" Q
 .S ARY("DUZ")=0
 .S:(X'="") ARY("DUZ")=+$O(^VA(200,"A",X,0))
 .I ('ARY("DUZ")) S:(ERR="") ERR="Invalid access code" Q
 .I (($P($G(^VA(200,ARY("DUZ"),.1)),"^")="")&('$D(MSA))) S ARY("DUZ")=0 S:(ERR="") ERR="Invalid access code" Q
 .S X=$P($$P^HLTPCK2(.HDR,8),$E(ECH),3) I (X'="") D
 ..S X1=$G(^VA(200,ARY("DUZ"),20))
 ..I (X1="") S:(ERR="") ERR="No Signature Code on File" Q
 ..S X=$$UPPER^HLFNC(X)
 ..D HASH^XUSHSHP
 ..I ((X'=$P(X1,"^",4))!($P(X1,"^",2)="")) S:(ERR="") ERR="Invalid Electronic Signature Code" Q
 ..S ARY("ESIG")=$P(X1,"^",2)
 I $D(ARY) M HLREC=ARY
 Q
