HLTPCK2A ;SF/RSD - Message Header Validation (Con't) ;09/24/2008 17:11
 ;;1.6;HEALTH LEVEL SEVEN;**19,57,59,66,108,120,133,142**;Oct 13, 1995;Build 17
 ;Per VHA Directive 2004-038, this routine should not be modified.
 S ERR=""
 S HLPARAM=$$PARAM^HLCS2,HLDOM=$P(HLPARAM,U,2),HLINSTN=$P(HLPARAM,U,6)
MT ;Validate message type
 I (ARY("MTN")="") S:(ERR="") ERR="Invalid Message Type" Q
 S ARY("MTP")=0
 S:(ARY("MTN")'="") ARY("MTP")=+$O(^HL(771.2,"B",ARY("MTN"),0))
 I ('ARY("MTP")) S:(ERR="") ERR="Invalid Message Type" Q
 ;
AT ;Determine if message is an acknowledgement type
 I (("ACK,ADR,MCF,MFK,MFR,ORF,ORR,RRA,RRD,RRE,RRG,TBR"[ARY("MTN"))&($G(MSA)="")) S:(ERR="") ERR="MSA Segment Missing" Q
 ;commit ack, quit
 ; patch HL*1.6*142
 ; in order to get data for ien of sending application,
 ; receiving application, and subscriber protocol.
 ; I $E($G(MSA))="C" D  Q
 I $E($G(MSA))="C" D
 . ;find original msg.
 . S ARY("MSAID")=$P(MSA,FS,2),ARY("MTIENS")=0
 . I ARY("MSAID")="" S:(ERR="") ERR="Invalid Message Control ID in MSA Segment - No Message ID " Q
 . F  S ARY("MTIENS")=+$O(^HLMA("C",ARY("MSAID"),ARY("MTIENS"))) Q:'ARY("MTIENS")!($P($G(^HLMA(ARY("MTIENS"),0)),U,3)="O")
 . I 'ARY("MTIENS") S:(ERR="") ERR="Invalid Message Control ID in MSA Segment - No message IEN in ""C"" x-ref" Q
 . Q
AAT ;Validate accept ack type and application ack type
 I ($G(ARY("ACAT"))'="") I ("AL,NE,ER,SU"'[ARY("ACAT")) S:(ERR="") ERR="Invalid accept ack type" Q
 I ($G(ARY("APAT"))'="") I ("AL,NE,ER,SU"'[ARY("APAT")) S:(ERR="") ERR="Invalid application ack type" Q
 ;
 ;
RA ;Validate receiving application
 I (ARY("RAN")']"") S:(ERR="") ERR="Invalid Receiving Application" Q
 S ARY("RAP")=0
 S:ARY("RAN")]"" ARY("RAP")=+$O(^HL(771,"B",$E(ARY("RAN"),1,30),0))
 I 'ARY("RAP"),ARY("RAN")'="" D
 .S X=$$UPPER^HLFNC(ARY("RAN"))
 .S ARY("RAP")=+$O(^HL(771,"B",$E(ARY("RAN"),1,30),0))
 ;
 ; patch HL*1.6*120 start
 I ($L(ARY("RAN"),ECH(1))>1) D
 . S ARY("RAN-SUB1")=$P(ARY("RAN"),ECH(1))
 . S ARY("RAN-SUB2")=$P(ARY("RAN"),ECH(1),2)
 . S ARY("RAN-SUB3")=$P(ARY("RAN"),ECH(1),3)
 . I 'ARY("RAP"),ARY("RAN-SUB1")]"" D
 .. S ARY("RAP")=+$O(^HL(771,"B",$E(ARY("RAN-SUB1"),1,30),0))
 . I ARY("RAN-SUB1")[ECH(3) D
 .. S ARY("RAN-SUB1-DEESCAPE")=$$DEESCAPE(ARY("RAN-SUB1"))
 . I ARY("RAN-SUB2")[ECH(3) D
 .. S ARY("RAN-SUB2-DEESCAPE")=$$DEESCAPE(ARY("RAN-SUB2"))
 . I ARY("RAN-SUB3")[ECH(3) D
 .. S ARY("RAN-SUB3-DEESCAPE")=$$DEESCAPE(ARY("RAN-SUB3"))
 . I 'ARY("RAP"),$G(ARY("RAN-SUB1-DEESCAPE"))]"" D
 .. S ARY("RAP")=+$O(^HL(771,"B",$E(ARY("RAN-SUB1-DEESCAPE"),1,30),0))
 I ARY("RAN")[ECH(3) D
 . S ARY("RAN-DEESCAPE")=$$DEESCAPE(ARY("RAN"))
 I 'ARY("RAP"),$G(ARY("RAN-DEESCAPE"))]"" D
 . S ARY("RAP")=+$O(^HL(771,"B",$E(ARY("RAN-DEESCAPE"),1,30),0))
 ; patch HL*1.6*120 end
 ;
 I ('ARY("RAP")) S:(ERR="") ERR="Invalid Receiving Application" Q
 S X2=$G(^HL(771,ARY("RAP"),0))
 I (X2="") S:(ERR="") ERR="Invalid Receiving Application" Q
 I ($P(X2,"^",2)'="a") S:(ERR="") ERR="Receiving Application is Inactive" Q
 ;
SA ;Validate sending application
 I (ARY("SAN")']"") S:(ERR="") ERR="Invalid Sending Application" Q
 S ARY("SAP")=0
 S:(ARY("SAN")]"") ARY("SAP")=+$O(^HL(771,"B",$E(ARY("SAN"),1,30),0))
 I (('ARY("SAP"))&(ARY("SAN")'="")) D
 .S X=$$UPPER^HLFNC(ARY("SAN"))
 .S ARY("SAP")=+$O(^HL(771,"B",$E(ARY("SAN"),1,30),0))
 ;
 ; patch HL*1.6*120 start
 I ($L(ARY("SAN"),ECH(1))>1) D
 . S ARY("SAN-SUB1")=$P(ARY("SAN"),ECH(1))
 . S ARY("SAN-SUB2")=$P(ARY("SAN"),ECH(1),2)
 . S ARY("SAN-SUB3")=$P(ARY("SAN"),ECH(1),3)
 . I 'ARY("SAP"),ARY("SAN-SUB1")]"" D
 .. S ARY("SAP")=+$O(^HL(771,"B",$E(ARY("SAN-SUB1"),1,30),0))
 . I ARY("SAN-SUB1")[ECH(3) D
 .. S ARY("SAN-SUB1-DEESCAPE")=$$DEESCAPE(ARY("SAN-SUB1"))
 . I ARY("SAN-SUB2")[ECH(3) D
 .. S ARY("SAN-SUB2-DEESCAPE")=$$DEESCAPE(ARY("SAN-SUB2"))
 . I ARY("SAN-SUB3")[ECH(3) D
 .. S ARY("SAN-SUB3-DEESCAPE")=$$DEESCAPE(ARY("SAN-SUB3"))
 . I 'ARY("SAP"),$G(ARY("SAN-SUB1-DEESCAPE"))]"" D
 .. S ARY("SAP")=+$O(^HL(771,"B",$E(ARY("SAN-SUB1-DEESCAPE"),1,30),0))
 I ARY("SAN")[ECH(3) D
 . S ARY("SAN-DEESCAPE")=$$DEESCAPE(ARY("SAN"))
 I 'ARY("SAP"),$G(ARY("SAN-DEESCAPE"))]"" D
 . S ARY("SAP")=+$O(^HL(771,"B",$E(ARY("SAN-DEESCAPE"),1,30),0))
 ; patch HL*1.6*120 end
 ;
 I ('ARY("SAP")) S:(ERR="") ERR="Invalid Sending Application" Q
 ;
VN ;Validate version number
 ; patch HL*1.6*142
 ; do not check version number of commit ACK because the batch commit ACK
 ; does not have version number in it.
 I $E($G(MSA))="C" G ET
 ;
 I (ARY("VER")="") S:(ERR="") ERR="Missing HL7 Version" Q
 S X=0
 S:(ARY("VER")'="") X=+$O(^HL(771.5,"B",ARY("VER"),0))
 S ARY("VEP")=X
 I ('X) S:(ERR="") ERR="Invalid HL7 Version" Q
 ;I (X'=$P($G(HLN(770)),"^",10)) S:(ERR="") ERR="Invalid HL7 Version for Receiving Application" Q
 ;
ET ;Event Type Checks
 ;
 ;I ARY("ETN")="",ARY("VER")>2.1,$G(MSA)'="" D
 ;. ;N Z,ZEP,ZP
 ;. ;S Z=0 I $P(MSA,FS,2)]"" S Z=+$O(^HLMA("C",$P(MSA,FS,2),0))
 ;. ;I '$G(^HLMA(Z,0)) S:(ERR="") ERR="Original Outgoing Message not found" Q
 ;. ;S ZEP=$P(^HLMA(Z,0),U,8)
 ;. ;I 'ZEP S:(ERR="") ERR="Event Protocol pointer (field #773,8) missing" Q
 ;. ;S ZP=$G(^ORD(101,ZEP,770)),ARY("ETN")=$P($G(^HL(779.001,+$P(ZP,U,4),0)),U)
 ;
 ;Validate event type
 I (ARY("ETN")=""),ARY("VER")>2.1,$G(MSA)="" S ERR="Event Type Required" Q
 S ARY("ETP")=0
 S:(ARY("ETN")'="") ARY("ETP")=+$O(^HL(779.001,"B",ARY("ETN"),0))
 I $G(MSA)="",ARY("VER")>2.1,('ARY("ETP")) S ERR="Invalid Event Type" Q
 ;
 D ^HLTPCK2B
 Q
DEESCAPE(INPUT) ;
 ; patch HL*1.6*120 - de-escape delimiters
 ; (assuming "\" is the escape character):
 ; - field separator (de-escape from \F\)
 ; - component separator (de-escape from \S\)
 ; - repetition separator (de-escape from \R\)
 ; - escape character (de-escape from \E\)
 ; - subcomponent separator (de-escape from \T\)
 ; \F\ will be de-escaped only if the length of FS is 1.
 ;
 ; input:
 ; INPUT - input string to be de-escaped
 ; FS - field separator
 ; ECH - encoding characters
 ; 
 ; output: de-escaped string
 ;
 N HLDATA,HLESCAPE,HLI,HLCHAR,HLCHAR23,HLEN,HLOUT
 S HLDATA=$G(INPUT)
 Q:HLDATA']"" HLDATA
 ;
 ; patch HL*1.6*133
 Q:$L($G(ECH))<3 HLDATA
 ;
 S ECH(1)=$E(ECH,1)
 S ECH(2)=$E(ECH,2)
 S ECH(3)=$E(ECH,3)
 S ECH(4)=$E(ECH,4)
 ;
 S HLEN=$L(HLDATA)
 S HLOUT=""
 F HLI=1:1:HLEN D
 . S HLCHAR=$E(HLDATA,HLI)
 . I HLCHAR=ECH(3) D
 . S HLCHAR23=$E(HLDATA,HLI+1,HLI+2)
 . I $L($G(FS))=1,(HLCHAR23=("F"_ECH(3))) D  Q
 .. S HLOUT=HLOUT_FS
 .. S HLI=HLI+2
 . I HLCHAR23=("S"_ECH(3)) D  Q
 .. S HLOUT=HLOUT_ECH(1)
 .. S HLI=HLI+2
 . I HLCHAR23=("R"_ECH(3)) D  Q
 .. S HLOUT=HLOUT_ECH(2)
 .. S HLI=HLI+2
 . I HLCHAR23=("E"_ECH(3)) D  Q
 .. S HLOUT=HLOUT_ECH(3)
 .. S HLI=HLI+2
 . I $L($G(ECH))>3,(HLCHAR23=("T"_ECH(3))) D  Q
 .. S HLOUT=HLOUT_ECH(4)
 .. S HLI=HLI+2
 . S HLOUT=HLOUT_HLCHAR
 ;
 Q HLOUT
