HLTP01 ;AISC/SAW-Transaction Processor Module (Cont'd) ;02/16/2000  11:15
 ;;1.6;HEALTH LEVEL SEVEN;**2,25,34,47,60**;Oct 13, 1995
 ;
 ;Validate message header
 D CHK^HLTPCK1(HLHDR,.HL,$S($G(HLMSA)'="":$P(HLMSA,$E(HLHDR,4),2,4),1:""))
 ;
 ;Change stored message ID to match that of the incoming message
 S HL("TMP")=$$CHNGMID^HLTF(HLMTIEN,HL("MID"))
 ;
 ;Remember new message ID if it was changed
 I ('HL("TMP")) S HLMID=HL("MID")
 ;
 ;Update zero node in Message Text file of incoming message
 D UPDATE^HLTF0(HLMTIEN,$S($D(HL("MTIENS")):HL("MTIENS"),1:HLMTIEN),"I",$G(HL("EID")),"",$G(HL("SAP")),"I")
 ;
 ;Update status of incoming message
 D STATUS^HLTF0(HLMTIEN,$S($G(HL):4,1:9),$S($G(HL):+HL,1:""),$S($G(HL):$P(HL,"^",2),1:""))
 ;
 ;Update Logical Link file statistics for message received through MailMan
 ;The protocols associated with dynamically addressed messages
 ;should not have a logical link defined.
 ;This results in the monitor not being updated correctly and
 ;acks cannot be addressed properly.
 ;Get sender from mailman variable XMFROM and try to resolve link from
 ;domain info (pointer in 870).
 I HLLD0="XM",$G(XMFROM)]"" D
 .N HLDOM,HLLINK,HLROUT
 .S HLDOM=$P(XMFROM,"@",2)
 .I $G(HL("EIDS"))]"" S HL("LL")=$P(^ORD(101,HL("EIDS"),770),U,7),HLROUT=$G(^ORD(101,HL("EIDS"),774))
 .Q:$G(HLROUT)=""
 .D LINK^HLUTIL3(HLDOM,.HLLINK,"D")
 .I $O(HLLINK(0)) S HL("LL")=$O(HLLINK(0))
 .;If Ack is required, dynamically address it to sender:
 .;Note-first piece (recipient) not required here
 .I $O(HLLINK(0)) S $P(HLL("LINKS",1),U,2)=HL("LL")
 I HLLD0="XM",$G(HL("LL"))]"" D
 . S X=$$ENQUEUE^HLCSQUE(HL("LL"),"IN")
 . D MONITOR^HLCSDR2("P",2,HL("LL"),$P(X,U,2),"IN")
 ;
 ;Quit if this is acknowledgment to acknowledgement message
 I $G(HL("ACK")) D  G EXIT
 .;Update status of original acknowledgment message to successfully
 .;  completed if no error occurred
 .I '$G(HL) D STATUS^HLTF0(HL("MTIENS"),3)
 ;
 ;Create message ID and Message Text IEN for subscriber entry in Message
 ;  Text file - carry over message ID of original message
 S HLMIDS=HLMID
 D CREATE^HLTF(.HLMIDS,.HLMTIENS,.HLDTS,.HLDT1S)
 K HLDTS,HLDT1S,HLMIDS
 ;
 ;Update zero node in Message Text file of subscriber entry
 D UPDATE^HLTF0(HLMTIENS,HLMTIEN,"I",$G(HL("EIDS")),$G(HL("RAP")),"","I")
 ;
 ;Create and send COMMIT acknowledgment if required
 I $G(HLMSA)="",$G(HL("RAP"))&$G(HL("SAP")) D
 .I '$D(HL("ACAT")),'$D(HL("APAT")),'HL Q
 .I $G(HL("ACAT"))="NE" Q
 .I $G(HL("ACAT"))="ER",'HL Q
 .I $G(HL("ACAT"))="SU",HL Q
 .;Version 2.1 messages always ORIGINAL MODE-application must generate
 .;ack. if error in hdr, hl7 rejects-quits.
 .S HLA("HLA",1)="MSA"_HL("FS")_$S(HL:$S(HL("VER")=2.1:"AR",1:"CR"),1:"CA")_HL("FS")_HL("MID")_HL("FS")_$P(HL,"^",2)
 .;I $D(HLA("HLA")) S HLP("MSACK")=1 D GENACK^HLMA1(HL("EID"),HLMTIENS,HL("EIDS"),"LM",1,.HLRESLT,"",.HLP)
 .S HLP("MSACK")=1
 .;added next line to save off HL* variables due to recursive call;sfciofo/ac
 .N HLSAVE M HLSAVE=HL
 .D GENACK^HLMA1(HL("EID"),HLMTIENS,HL("EIDS"),"LM",1,.HLRESLT,"",.HLP)
 .I $D(HLSAVE) M HL=HLSAVE
 ;
 ;Quit processing if error with header
 ;Potential problem with patch 25 that may affect internal DHCP to DHCP
 ;messaging.  As a test, replaced next line with following line to correct:
 ;I HL'="" S HLRESLT=HL G EXIT
 I $G(HL)]"" S HLRESLT=HL G EXIT
 ;Comment out next line.  Potential problem with patch 34 affecting
 ;dhcp to dhcp messaging:
 ;I HL("TMP")'=0 S HLRESLT="13^"_$P(HL("TMP"),"^",2)
 I $G(HL("TMP")) S HLRESLT="13^"_$P(HL("TMP"),"^",2)
 ;
 ;Set special HL variables
 S HLQUIT=0,HLNODE="",HLNEXT="D HLNEXT^HLCSUTL"
 ;
 ;Check if message is an acknowledgement
 I ($G(HLMSA)'="") D  G EXIT
 .;Update status of original subscriber message
 .D STATUS^HLTF0(HL("MTIENS"),$S("AA,CA"[$P(HLMSA,HL("FS"),2):3,1:4),"",$S("AA,CA"[$P(HLMSA,HL("FS"),2):"",1:$P(HLMSA,HL("FS"),3)))
 .D PROCACK^HLTP2(HLMTIEN,HL("EID"),.HLRESLT,.HL)
 ;
 ;Get entry action, exit action and processing routine
 K HLHDR,HLLD0,HLLD1,HLMSA
 I $G(HL("EIDS"))="",$G(HLEIDS)]"" S HL("EIDS")=HLEIDS ;**CIRN**
 D EVENT^HLUTIL1(HL("EIDS"),"15,20,771",.HLN)
 S HLENROU=$G(HLN(20)),HLEXROU=$G(HLN(15))
 S HLPROU=$G(HLN(771)) I HLPROU']"" S HLRESLT="10^"_$G(^HL(771.7,10,0)) G EXIT
 ;
 ;Execute entry action of client protocol
 X:HLENROU]"" HLENROU K HLENROU
 ;
 ;Execute processing routine
 X HLPROU S HLRESLT=0 S:($D(HLERR)) HLRESLT="9^"_$G(^HL(771.7,9,0))
EXIT K HL,HLHDR,HLMSA
 Q
