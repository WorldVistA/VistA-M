HLTP4 ;SFIRMFO/RSD - Transaction Processor for TCP ;06/24/2008  10:47
 ;;1.6;HEALTH LEVEL SEVEN;**19,57,59,91,109,116,117,125,120,142**;Oct 13, 1995;Build 17
 ;Per VHA Directive 2004-038, this routine should not be modified.
GENACK ;called from HLMA1
 ;Entry point to generate an acknowledgement message
 ;for TCP
 ;INPUT:
 ;   HLMTIENS=original msg. ien #773
 ;   HLEID=original msg. event protocol
 ;   HLEIDS=original msg. subscriber protocol
 ;   HLMTIENA=ien of ack in 772, for batch only
 ;   Note:  if the HLP(...) array exists, it will be "honored" by
 ;          UPDATE^HLTF0 below. This includes the HLP("NAMESPACE")
 ;          variable. - HL*1.6*91
 ;
 ;OUTPUT: HLTCP=ien of response
 N HLDT,HLDT1,HLQ,HLOGLINK,HLMIDA,HLMTIEN,HLREC,HLSAN,HLTYPE,X
 ;Extract data from original message and store in separate variables
 ;reverse sending and receiving application from original msg.
 S X=$G(^HLMA(HLMTIENS,0)),HLREC=$P(X,U,11),HLSAN=$P(X,U,12),HLOGLINK=$G(HLTCPO)
 ;HLMTIENA defined, create msg in 773
 I $G(HLMTIENA) S HLDT=+$G(^HL(772,HLMTIENA,0)),HLMTIENA=$$MA^HLTF(HLMTIENA,.HLMIDA)
 ;create message in 772 & 773, HLMTIENA=new msg ien #773
 I '$G(HLMTIENA) D TCP^HLTF(.HLMIDA,.HLMTIENA,.HLDT)
 ;
 ;**109**
 ;lock new record
 ;F  L +^HLMA(HLMTIENA):1 Q:$T  H 1
 ;
 ;HLMTIEN=ien in 772
 S HLTCP=HLMTIENA,HLMTIEN=+^HLMA(HLMTIENA,0),HLDT1=$$HLDATE^HLFNC(HLDT),(HLTYPE,HLP("MSGTYPE"))=$E(HLARYTYP,2)
 ;
 ;**** HL*1.6*116 ****
 ;no open link, check dynamic routing of ack
 S X=$G(^ORD(101,HLEIDS,770)),HLP("MTYPE")=$P(X,U,11),HLP("EVENT")=$P(X,U,4)
 ;
 ; patch HL*1.6*125- change from $G to $D
 I '$D(HLL("SET FOR APP ACK")) D  Q:'HLOGLINK
 .K HLL("LINKS")
 .I 'HLOGLINK D
 .. S HLOGLINK=$P(X,U,7)
 .. Q:HLOGLINK
 .. N DOMAIN,SFAC,MSH,FS,CS,HLI,INST
 .. S MSH=$G(^HLMA(HLMTIENS,"MSH",1,0))
 .. Q:'$L(MSH)
 .. S FS=$E(MSH,4)
 .. Q:'$L(FS)
 .. S CS=$E(MSH,5)
 .. Q:'$L(CS)
 .. S DOMAIN=$P($P(MSH,FS,4),CS,2)
 .. ;
 .. ; patch HL*1.6*120 start
 .. ; assume the format is <domain>:<port #>
 .. I DOMAIN[":" S HLP("PORT")=$P(DOMAIN,":",2)
 .. S DOMAIN=$P(DOMAIN,":")
 .. S HLP("DNS-DOMAIN")=DOMAIN
 .. ;
 .. ; if first piece of domain is "HL7." or "MPI.", remove it
 .. I ($E(DOMAIN,1,4)="HL7.")!($E(DOMAIN,1,4)="MPI.") D
 ... S DOMAIN=$P(DOMAIN,".",2,99)
 .. ;
 .. ; lookup Mailman domain
 .. I $L(DOMAIN) D
 ... D LINK^HLUTIL3(DOMAIN,.HLI,"D")
 ... S HLOGLINK=$O(HLI(0))
 .. Q:HLOGLINK
 .. S INST=$P($P(MSH,FS,4),CS,1)
 .. I $L(INST) D
 .. .D LINK^HLUTIL3(INST,.HLI,"I")
 ... S HLOGLINK=$O(HLI(0))
 .. Q:HLOGLINK
 .. ;
 .. ; check DNS domain and ip address
 .. I $L(HLP("DNS-DOMAIN")) D
 ... ;
 ... ; match DNS domain
 ... I $D(^HLCS(870,"DNS",HLP("DNS-DOMAIN"))) D
 .... S HLOGLINK=+$O(^HLCS(870,"DNS",HLP("DNS-DOMAIN"),0))
 ... Q:HLOGLINK
 ... ;
 ... I $D(^HLCS(870,"DNS",$$UP^XLFSTR(HLP("DNS-DOMAIN")))) D
 .... S HLOGLINK=+$O(^HLCS(870,"DNS",$$UP^XLFSTR(HLP("DNS-DOMAIN")),0))
 ... Q:HLOGLINK
 ... ;
 ... I $D(^HLCS(870,"DNS",$$LOW^XLFSTR(HLP("DNS-DOMAIN")))) D
 .... S HLOGLINK=+$O(^HLCS(870,"DNS",$$LOW^XLFSTR(HLP("DNS-DOMAIN")),0))
 ... Q:HLOGLINK
 ... ;
 ... ; match ip address
 ... I $D(^HLCS(870,"IP",HLP("DNS-DOMAIN"))) D
 .... S HLOGLINK=+$O(^HLCS(870,"IP",HLP("DNS-DOMAIN"),0))
 .. ;
 ; patch HL*1.6*116 and patch HL*1.6*120 end
 ;
 ;** HL*1.6*117 **
 ; patch HL*1.6*125- change from $G to $D
 I $D(HLL("SET FOR APP ACK")) D  Q:'HLOGLINK
 .N I
 .S I=$O(HLL("LINKS",0))
 .I 'I S HLOGLINK="" Q
 .S HLOGLINK=$P(HLL("LINKS",I),"^",2) Q:HLOGLINK=""
 .I +HLOGLINK'=HLOGLINK S HLOGLINK=$O(^HLCS(870,"B",HLOGLINK,0))
 ;**END HL*1.6*117 **
 ;
 S:$P(X,U,5) HLP("MTYPE_EVENT")=$P(X,U,5)
 ;HLTCPI=initial message
 S:$G(HLTCPI) HLP("HLTCPI")=HLTCPI
 ;Update zero node of Message Admin file #773
 D UPDATE^HLTF0(HLTCP,,"O",HLEIDS,HLREC,HLSAN,"I",HLMTIENS,HLOGLINK,.HLP)
 ;
 ;Update status to Being Generated
 D STATUS^HLTF0(HLTCP,8)
 ;
 ;**109**
 ;tcp link is open, don't need x-ref, msg will be sent over link
 ;I $G(HLTCPO) K ^HLMA("AC","O",HLOGLINK,HLTCP)
 ;
 ;update zero node of Message Text file #772
 D
 . N HLTCP D UPDATE^HLTF0(HLMTIEN,,"O",HLEID)
 ;
 ;Execute entry action for subscriber protocol
 I HLENROU]"" X HLENROU
 S HLQ=""""
 ;Check that local/global array exists and store in Message Text file
 ; if pre-compiled
 I HLFORMAT D  I (+$G(HLRESLTA)) D STATUS^HLTF0(HLMTIENA,4,+HLRESLTA) G ERR
 . I $E(HLARYTYP)="G" D
 .. I $O(^TMP("HLA",$J,0))']"" S HLRESLTA="8^"_$G(^HL(771.7,8,0)) Q
 .. D MERGE^HLTF1("G",HLMTIEN,"HLA")
 . I $E(HLARYTYP)="L" D
 .. I $O(HLA("HLA",0))']"" S HLRESLTA="8^"_$G(^HL(771.7,8,0)) Q
 .. D MERGE^HLTF1("L",HLMTIEN,"HLA")
 ;If array is not pre-compiled, call message generation routine
 I 'HLFORMAT N HLERR D  I $D(HLERR) S HLRESLTA="9^"_HLERR D STATUS^HLTF0(HLMTIENA,4,9,HLERR) G ERR
 .S HLP("GROUTINE")=HLP("GROUTINE")_"("_HLMIDA_","_HLMTIENA_","_HLQ_HLARYTYP_HLQ_","_HLSAN_","_$P($G(^HL(771.2,$P(HLN(770),"^",3),0)),"^")_","_$P($G(^HL(779.001,$P(HLN(770),"^",4),0)),"^")_","_HLQ_$TR($P(HLN(770),"^",6),"id","ID")_HLQ_")"
 .X HLP("GROUTINE")
 ;
 ;create header for message in 773
 I (HLTYPE="M") D HEADER^HLCSHDR1(HLTCP,HLREC,.HLRESLT)
 I (HLTYPE'="M") D BHSHDR^HLCSHDR1(HLTCP,HLREC,.HLRESLT)
 ;if error set status to ERROR DURING TRANSMISSION
 I ($G(HLRESLT)'="") D STATUS^HLTF0(HLTCP,4,12,HLRESLT) G ERR
 ;set header, HLHDR in 773
 K HLQ S X=HLTCP_",",HLQ(773,X,200)="HLHDR"
 D FILE^HLDIE("","HLQ","","GENACK","HLTP4") ;HL*1.6*109
 ;D FILE^DIE("","HLQ")
 ;update status of 773 to PENDING TRANSMISSION
 D STATUS^HLTF0(HLTCP,1)
 ;Execute exit action for subscriber protocol
 X:HLEXROU]"" HLEXROU
 ;
 ;**109**
 ;tcp link is NOT open, need x-ref
 I '$G(HLTCPO) D ENQUE^HLCSREP(HLOGLINK,"O",HLTCP)
 ;
EXIT ;**109**
 ;L -^HLMA(HLMTIENA)
 Q
ERR D EXIT S HLTCP=""
 S:$G(HLRESLT) HLRESLTA=$G(HLRESLTA)_"^"_HLRESLT
 Q
ACK(HLTACK,HLMG) ;build response based on original msg header
 ;for Bi-directional TCP
 ;INPUT:
 ;   HLTACK=type of ack. CA,CR, or AR
 ;   HLMG=text for MSA segment
 ;   HLMTIENS=original msg. ien #773
 ;   HL(array) from original header
 ;RETURNS:  HLTCP=ien of response msg. in 773
 N HLDT,HLDT1,HLQ,HLFS,HLHDR,HLMIDA,HLMTIEN,HLMTIENA,HLP,HLREC,HLSAN,X
 ;quit if we don't have enough to make a msg.
 I $G(HL("ECH"))=""!($G(HL("FS"))="")!($G(HL("TYPE"))="") Q
 ;Extract data from original message and store in separate variables
 ;reverse sending and receiving application from original msg.
 S HLFS=HL("FS"),HLREC=$G(HL("SAN")),HLSAN=$G(HL("RAN"))
 ;create message in 772 & 773, HLMTIENA=new msg ien #773
 D TCP^HLTF(.HLMIDA,.HLMTIENA,.HLDT)
 ;lock new record
 ;**109**
 ;F  L +^HLMA(HLMTIENA):1 Q:$T  H 1
 ;
 ;HLMTIEN=ien in 772
 S HLTCP=HLMTIENA,HLMTIEN=+^HLMA(HLMTIENA,0),HLDT1=$$FMTHL7^XLFDT(HLDT)
 ;get 'msgtype'=B or M, message type and event type
 S HLP("MSGTYPE")=$E(HL("TYPE")),HLP("MTYPE")=$G(HL("MTP")),HLP("EVENT")=$G(HL("ETP")),HLP("HLTCPI")=HLMTIENS
 S:$G(HL("MTP_ETP")) HLP("MTYPE_EVENT")=$G(HL("MTP_ETP"))
 ; HL*1.6*117 start
 ; change the order of when updates are done on file 773
 ;Update zero node of Message Admin file #773
 ;D UPDATE^HLTF0(HLTCP,,"O",,HLREC,HLSAN,"I",HLMTIENS,HLDP,.HLP)
 ;
 ;don't need x-ref, msg will be sent back over open tcp link
 ;**109**
 ;D LLCNT^HLCSTCP(HLDP,3)
 ;K ^HLMA("AC","O",HLDP,HLTCP)
 ;
 ;Update status to Being Generated
 ;D STATUS^HLTF0(HLTCP,8)
 ; HL*1.6*117 end
 ;update zero node of Message Text file #772
 D
 . N HLTCP D UPDATE^HLTF0(HLMTIEN,,"O")
 ;
 ;build MSA segment
 K HLA
 S HLA("HLS",1)="MSA"_HLFS_HLTACK_HLFS_$G(HL("MID"))
 S:$G(HLMG)]"" HLA("HLS",1)=HLA("HLS",1)_HLFS_HLMG
 ;update file 772 with msg text
 D MERGE^HLTF1("L",HLMTIEN,"HLS")
 D HDR
 ;update file 773 with msg header
 K HLQ S HLQ(773,HLTCP_",",200)="HLHDR"
 D FILE^HLDIE("","HLQ","","ACK","HLTP4") ; HL*1.6*109
 ;D FILE^DIE("","HLQ")
 ; HL*1.6*117 start
 ; finally commit updates to 773 that will affect behavior of messaging
 ;Update status to Being Generated
 D STATUS^HLTF0(HLTCP,8)
 ;Update zero node of Message Admin file #773
 ; patch HL*1.6*142
 ; update ien of sending application (from HL("RAP") of the incoming msg),
 ; ien of receiving application (from HL("SAP") of the incoming msg),
 ; and subscriber protocol
 ; D UPDATE^HLTF0(HLTCP,,"O",,HLREC,HLSAN,"I",HLMTIENS,HLDP,.HLP)
 D UPDATE^HLTF0(HLTCP,,"O",$G(HL("EIDS")),$G(HL("SAP")),$G(HL("RAP")),"I",HLMTIENS,HLDP,.HLP)
 ; update message sent count
 D LLCNT^HLCSTCP(HLDP,3)
 ; HL*1.6*117 end
 G EXIT
 ;
HDR ; build header for commit ack
 K HLHDR
 S HLHDR(1)=HL("TYPE")_HLFS_HL("ECH")_HLFS_HLSAN_HLFS_$G(HL("RFN"))_HLFS_HLREC_HLFS_$G(HL("SFN"))_HLFS_HLDT1_HLFS_HLFS
 I HLP("MSGTYPE")="M" S HLHDR(1)=HLHDR(1)_"ACK"_HLFS_HLMIDA_HLFS_$G(HL("PID"))_HLFS_$G(HL("VER")) Q
 ;batch
 S X=$E(HL("ECH"))
 S HLHDR(1)=HLHDR(1)_X_$G(HL("PID"))_X_"ACK"_HLFS_HLTACK_HLFS_HLMIDA_HLFS_$G(HL("MID"))
 Q
