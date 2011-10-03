HLTPCK1A ;SAW/AISC-Message Header Validation Routine for HL7 (Con't) ;03/24/2004  15:12
 ;;1.6;HEALTH LEVEL SEVEN;**2,25,34,57,59,108**;Oct 13, 1995
 S ERR=""
SP ;Get local site parameters
 S HLPARAM=$$PARAM^HLCS2,HLDOM=$P(HLPARAM,U,2),HLINSTN=$P(HLPARAM,U,6)
MT ;Validate message type
 I (ARY("MTN")="") S:(ERR="") ERR="Invalid Message Type" Q
 S ARY("MTP")=0
 S:(ARY("MTN")'="") ARY("MTP")=+$O(^HL(771.2,"B",ARY("MTN"),0))
 I ('ARY("MTP")) S:(ERR="") ERR="Invalid Message Type" Q
 ;
AT ;Determine if message is an acknowledgement type
 I (("ACK,ADR,MCF,MFK,MFR,ORF,ORR,RRA,RRD,RRE,RRG,TBR"[ARY("MTN"))&($G(MSA)="")) S:(ERR="") ERR="MSA Segment Missing" Q
 ;
AAT ;Validate accept ack type and application ack type
 I ($G(ARY("ACAT"))'="") I ("AL,NE,ER,SU"'[ARY("ACAT")) S:(ERR="") ERR="Invalid accept ack type" Q
 I ($G(ARY("APAT"))'="") I ("AL,NE,ER,SU"'[ARY("APAT")) S:(ERR="") ERR="Invalid application ack type" Q
 ;
RA ;Validate receiving application
 S ARY("RAN")=$P(HDR,FS,5)
 I (ARY("RAN")="") S:(ERR="") ERR="Invalid Receiving Application" Q
 S ARY("RAP")=0
 ;
 ; patch HL*1.6*108 start
 ;S:(ARY("RAN")'="") ARY("RAP")=+$O(^HL(771,"B",ARY("RAN"),0))
 S:(ARY("RAN")'="") ARY("RAP")=+$O(^HL(771,"B",$E(ARY("RAN"),1,30),0))
 I (('ARY("RAP"))&(ARY("RAN")'="")) D
 .S X=$$UPPER^HLFNC(ARY("RAN"))
 .;S ARY("RAP")=+$O(^HL(771,"B",ARY("RAN"),0))
 .S ARY("RAP")=+$O(^HL(771,"B",$E(ARY("RAN"),1,30),0))
 ; patch HL*1.6*108 end
 ;
 I ('ARY("RAP")) S:(ERR="") ERR="Invalid Receiving Application" Q
 S X2=$G(^HL(771,ARY("RAP"),0))
 I (X2="") S:(ERR="") ERR="Invalid Receiving Application" Q
 I ($P(X2,"^",2)'="a") S:(ERR="") ERR="Receiving Application is Inactive" Q
 ;
SA ;Validate sending application
 S ARY("SAN")=$P(HDR,FS,3)
 I (ARY("SAN")="") S:(ERR="") ERR="Invalid Sending Application" Q
 S ARY("SAP")=0
 ;
 ; patch HL*1.6*108 start
 ;S:(ARY("SAN")'="") ARY("SAP")=+$O(^HL(771,"B",ARY("SAN"),0))
 S:(ARY("SAN")'="") ARY("SAP")=+$O(^HL(771,"B",$E(ARY("SAN"),1,30),0))
 I (('ARY("SAP"))&(ARY("SAN")'="")) D
 .S X=$$UPPER^HLFNC(ARY("SAN"))
 .;S ARY("SAP")=+$O(^HL(771,"B",ARY("SAN"),0))
 .S ARY("SAP")=+$O(^HL(771,"B",$E(ARY("SAN"),1,30),0))
 ; patch HL*1.6*108 end
 ;
 I ('ARY("SAP")) S:(ERR="") ERR="Invalid Sending Application" Q
 ;
VN ;Validate version number
 I (ARY("VER")="") S:(ERR="") ERR="Missing HL7 Version" Q
 S X=0
 S:(ARY("VER")'="") X=+$O(^HL(771.5,"B",ARY("VER"),0))
 S ARY("VEP")=X
 I ('X) S:(ERR="") ERR="Invalid HL7 Version" Q
 ;
ET ; Check for Event Type if version 2.2 or above
 ; if response use message id/original message to resolve event type
 ;I ARY("ETN")="",ARY("VER")>2.1,$G(MSA)'="" D  Q:ERR]""
 ;. ;N HLZMID,HLZEP,HLZ770
 ;. ;S HLZMID=$O(^HL(772,"C",+$P(MSA,FS,2),0))
 ;. ;I HLZMID D
 ;..  ;I '$G(^HL(772,HLZMID,0)) S:(ERR="") ERR="Original Outgoing Message not found" Q
 ;..  ;S HLZEP=$P($G(^HL(772,HLZMID,0)),U,10)
 ;..  ;I HLZEP'>0 S:(ERR="") ERR="Event Protocol pointer (field #772,10) missing" Q
 ;..  ;S HLZ770=$G(^ORD(101,HLZEP,770))
 ;..  ;S ARY("ETN")=$P($G(^HL(779.001,+$P(HLZ770,U,4),0)),U)
 ;. ;K HLZMID,HLZEP,HLZ770
 ;
 I (ARY("ETN")=""),ARY("VER")>2.1,$G(MSA)="" S:(ERR="") ERR="Event Type REQUIRED" Q
 S ARY("ETP")=0
 I $G(MSA)="",(ARY("ETN")'="") S ARY("ETP")=+$O(^HL(779.001,"B",ARY("ETN"),0)) I ('ARY("ETP")) S:(ERR="") ERR="Invalid Event Type" Q
 ;
MS ;Check for Message Structure Code
 I $G(ARY("MTN_ETN"))'="" D
 . S ARY("MTP_ETP")=0
 . S ARY("MTP_ETP")=+$O(^HL(779.005,"B",ARY("MTN_ETN"),0))
 . I ('ARY("MTP_ETP")) S:(ERR="") ERR="Invalid Message Structure Code" Q
 ;
MSA ;Get receiving application data from Protocol file
 ;I (ARY("SAP")) D  Q:ERR]""
 I $D(MSA) D  Q
 .;Message is an acknowledgement - deliver to Server Protocol that
 .;  message came from
 .I '$G(ARY("SAP")) S ERR="Missing Sending Application" Q
 .S ARY("MTIENS")=0
 .F  S ARY("MTIENS")=+$O(^HL(772,"AH",ARY("SAP"),$P(MSA,FS,2),ARY("MTIENS"))) Q:'ARY("MTIENS")!($P($G(^HL(772,+ARY("MTIENS"),0)),U,4)="O")
 .S X=$G(^HL(772,+ARY("MTIENS"),0))
 .S ARY("EIDS")=$P(X,"^",10)
 .I ('ARY("EIDS")) S:(ERR="") ERR="Invalid Message Control ID in MSA Segment" Q
 .S ARY("MTIEN")=+$P(X,"^",8)
 .S ARY("ACK")=$P(X,"^",7)
 .S X=$G(^HL(772,+$P(X,"^",8),0))
 .S ARY("EID")=$P(X,"^",10)
 .I ('ARY("EID")) S:(ERR="") ERR="Event Protocol not found" Q
 .D EVENT^HLUTIL1(ARY("EIDS"),"770,773",.HLN)
 .;Get Logical Link info if defined on subscriber
 .S ARY("LL")=$P($G(HLN(770)),"^",7)
 ;
 I ARY("MTP") D
 .;Find Server Protocol - based on sending application, message type,
 .;event type and version ID
 .I ARY("ETP") S ARY("EID")=+$O(^ORD(101,"AHL1",ARY("SAP"),ARY("MTP"),ARY("ETP"),ARY("VEP"),0))
 .;
 .;Find Server Protocol - based on sending application, message type,
 .;and version ID
 .I 'ARY("ETP") S ARY("EID")=+$O(^ORD(101,"AHL21",ARY("SAP"),ARY("MTP"),ARY("VEP"),0))
 .;
 .I ('ARY("EID")) S:(ERR="") ERR="Event Protocol not found" Q
 .;Find Client Protocol - in ITEM multiple of Server Protocol
 .S ARY("EIDS")=0
 .F  S ARY("EIDS")=+$O(^ORD(101,ARY("EID"),775,"B",ARY("EIDS"))) Q:('ARY("EIDS"))  D  Q:$G(X1)
 ..S (X,X1)=0
 ..S X=$G(^ORD(101,ARY("EIDS"),770))
 ..I $P(X,U,2)=ARY("RAP") S X1=1
 .I 'ARY("EIDS") S:(ERR="") ERR="Invalid Receiving Application for this Event" Q
 .D EVENT^HLUTIL1(ARY("EIDS"),"770,773",.HLN)
 ;
LLP ;Get logical link pointer
 S ARY("LL")=$P($G(HLN(770)),"^",7)
 ;
FAC ;Get sending/rec facility, validate if necessary
 ;
 S HLCS=$E(ECH,1) ;Get component separator
 S ARY("RAF")=$P(HDR,FS,6) ;Receiving Facility
 S ARY("SAF")=$P(HDR,FS,4) ;Sending Facility
 ;Get sending/receiving facility from Application Parameter file(771)
 S HL771SF=$P($G(^HL(771,ARY("SAP"),0)),U,3)
 S HL771RF=$P($G(^HL(771,ARY("RAP"),0)),U,3)
 ;Sending/Receiving facility required?
 S X=$G(^ORD(101,ARY("EIDS"),773))
 S HLSFREQ=+X,HLRFREQ=+$P(X,U,2)
RF ;Validate Receiving Facility
 I HLRFREQ D
 .I ARY("RAF")="" S:ERR="" ERR="Missing required receiving facility" Q
 .I HL771RF]"" D  Q
 ..;Facility data in 771 overrides data in site paramter file
 ..;For backward compatibility, don't validate
 ..Q
 ..Q:HL771RF=ARY("RAF")
 ..S:ERR="" ERR="Receiving Facility/App Parameter mismatch."
 .;Check against local default value (site parameters)
 .Q:ARY("RAF")=(HLINSTN_HLCS_HLDOM_HLCS_"DNS")
 .S:ERR="" ERR="Receiving Facility mismatch."
SF ;Validate Sending Facility
 I HLSFREQ D
 .I ARY("SAF")="" S:ERR="" ERR="Missing required sending facility" Q
 .I HL771SF]"" D  Q
 ..;Check for facility data in 771
 ..Q
 ..Q:HL771SF=ARY("SAF")
 ..S:ERR="" ERR="Sending Facility/App Parameter mismatch."
 .;If default value was sent, validate that DOMAIN RESOLVES TO LOGICAL LINK
 .;If so, use this instead of Protocol definition for return path
 .S HLDOMP=$P(ARY("SAF"),HLCS,2),HLDOMP=$O(^DIC(4.2,"B",HLDOMP,0))
 .I 'HLDOMP S:ERR="" ERR="Unrecognized domain in sending facility"
 .Q:HLDOMP=$P(HLPARAM,U)  ;This is local app to app
 .I HLDOMP N HLNK S HLNK=+$O(^HLCS(870,"D",HLDOMP,0))
 .I HLNK S ARY("LL")=HLNK
 ;
PID ;Validate processing ID
 I ("DTP"'[ARY("PID")) S:(ERR="") ERR="Invalid HL7 Processing ID" Q
 S HLPID=$P(HLPARAM,U,3) ;site param
 S X=$G(^ORD(101,ARY("EID"),770)),X=$P(X,U,6) ;event driver
 ;I X=""&($G(HLPID))="" S:ERR="" ERR="Cannot validate PROCESSING ID"
 ;If message is 'debug' then event driver must be 'debug.'
 ;If message is 'test' or 'production', then site param must match
 I ARY("PID")="D"&(X'="D") S:ERR="" ERR="Processing ID Mismatch with Event Driver"
 I ARY("PID")'="D"&(HLPID'=ARY("PID")) S:ERR="" ERR="Processing ID Mismatch with Site Parameters"
 ;
SEC ;Validate security field - access code and electronic signature
 I ($P($G(HLN(773)),"^",3)) D
 .S X=$P($P(HDR,FS,8),$E(ECH))
 .S X=$$UPPER^HLFNC(X)
 .D ^XUSHSH
 .I ((X="")&('$D(MSA))) S:(ERR="") ERR="Invalid access code" Q
 .S ARY("DUZ")=0
 .S:(X'="") ARY("DUZ")=+$O(^VA(200,"A",X,0))
 .I ('ARY("DUZ")) S:(ERR="") ERR="Invalid access code" Q
 .I (($P($G(^VA(200,ARY("DUZ"),.1)),"^")="")&('$D(MSA))) S ARY("DUZ")=0 S:(ERR="") ERR="Invalid access code" Q
 .S X=$P($P(HDR,FS,8),$E(ECH),3) I (X'="") D
 ..S X1=$G(^VA(200,ARY("DUZ"),20))
 ..I (X1="") S:(ERR="") ERR="No Signature Code on File" Q
 ..S X=$$UPPER^HLFNC(X)
 ..D HASH^XUSHSHP
 ..I ((X'=$P(X1,"^",4))!($P(X1,"^",2)="")) S:(ERR="") ERR="Invalid Electronic Signature Code" Q
 ..S ARY("ESIG")=$P(X1,"^",2)
 I $D(ARY) M HLREC=ARY
 Q
