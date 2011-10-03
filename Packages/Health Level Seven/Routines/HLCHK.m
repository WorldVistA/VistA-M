HLCHK ;AISC/SAW-Validate HL7 Messages Received ;3/24/2004  14:09
 ;;1.6;HEALTH LEVEL SEVEN;**1,108**;Oct 13, 1995
 ;This routine is used for the Version 1.5 Interface Only
 D CHK D IN^HLTF(HLMTN,HLMID,HLTIME) S HLMT=$S(HLMTN="QRY":"ORF",HLMTN="ORM":"ORR",1:"ACK") D MSH G ACK:$D(HLERR)
 K HLDATA,HLL,HLMSA,HLMT,HLMTP,^TMP("HLR",$J) I HLROU="^NONE"!(HLROU="^") D KILL Q
 D @HLROU G REPLY
MSH ;Create MSH Segment for HL7 Reply
 I '$D(HLDT)!('$D(HLDT1)) N %,%H,%I D NOW^%DTC S HLDT=%,HLDT1=$$HLDATE^HLFNC(HLDT)
 S HLSDATA(1)="MSH"_HLFS_HLECH_HLFS_$P(HLDATA,HLFS,5,6)_HLFS_$P(HLDATA,HLFS,3,4)_HLFS_HLDT1_HLFS_HLFS_HLMT_HLFS_HLDT_HLFS_HLPID_HLFS_HLVER Q
CHK ;Validate Data in Header Segment of an HL7 Message
 K HLERR S HLDATA=HLL(1),HLFS=$E(HLDATA,4),HLECH=$P(HLDATA,HLFS,2),HLQ="""""",HLDAN=$P(HLDATA,HLFS,5),HLMNT="" D
 .I $E(HLDATA,1,3)="BHS" S HLMID=$P(HLDATA,HLFS,11),X=$P(HLDATA,HLFS,9),HLPID=$P(X,$E(HLECH),2),HLMTN=$E($P(X,$E(HLECH),3),1,3),HLVER=$P(X,$E(HLECH),4) S:$P(HLDATA,HLFS,10)]"" HLMSA=$P(HLDATA,HLFS,10),$P(HLMSA,$E(HLECH),2)=$P(HLDATA,HLFS,12)
 .I $E(HLDATA,1,3)="MSH" S HLMID=$P(HLDATA,HLFS,10),HLPID=$P(HLDATA,HLFS,11),HLMTN=$P($P(HLDATA,HLFS,9),$E(HLECH)),HLVER=$P(HLDATA,HLFS,12) S:HLMTN="" HLMTN=0 I $E($G(HLL(2)),1,3)="MSA" S HLMSA=HLL(2)
 I HLMTN']"" S HLERR="Invalid Message Type" Q
 I '$D(^HL(771.2,"B",HLMTN)) S HLERR="Invalid Message Type" Q
 I HLFS=""!(HLFS?.C) S HLERR="Invalid Header Segment" Q
 I $E(HLDATA,1,3)'="MSH",$E(HLDATA,1,3)'="BHS" S HLERR="Invalid Header Segment" Q
 I HLDAN']"" S HLERR="Invalid Receiving Application" Q
 ; patch HL*1.6*108 start
 ;S HLDAP=+$O(^HL(771,"B",HLDAN,0)) I 'HLDAP S HLDAN=$$UPPER^HLFNC(HLDAN),HLDAP=+$O(^HL(771,"B",HLDAN,0))
 S HLDAP=+$O(^HL(771,"B",$E(HLDAN,1,30),0)) I 'HLDAP S HLDAN=$$UPPER^HLFNC(HLDAN),HLDAP=+$O(^HL(771,"B",$E(HLDAN,1,30),0))
 ; patch HL*!.6*108 end
 ;
 I 'HLDAP S HLERR="Invalid Receiving Application" Q
 I '$D(^HL(771,HLDAP,0)) S HLERR="Invalid Receiving Application" Q
 I $P(^HL(771,HLDAP,0),"^",2)'="a" S HLERR="Receiving Application is Inactive" Q
 S X=$P(HLDATA,HLFS,3) I X']"" S HLERR="Invalid Sending Application" Q
 I '$D(^HL(770,"AF",X)) S X=$$UPPER^HLFNC(X)
 I '$D(^HL(770,"AF",X)) S HLERR="Invalid Sending Application" Q
 S HLSA=X,X=$P(HLDATA,HLFS,4) I X']"" S HLERR="Invalid Sending Facility" Q
 I '$D(^HL(770,"AF",HLSA,X)) S X=$$UPPER^HLFNC(X)
 I '$D(^HL(770,"AF",HLSA,X)) S HLERR="Invalid Sending Facility" Q
 S X=$P(HLDATA,HLFS,6),X=$$UPPER^HLFNC(X) I X']"" S HLERR="Invalid Receiving Facility" Q
 I '$D(^HL(770,"AE",HLSA,X)) S HLERR="Invalid Receiving Facility" Q
 I '$D(HLNDAP0) S HLNDAP=+$O(^HL(770,"B",HLSA,0)),HLNDAP0=$G(^HL(770,HLNDAP,0)) S:$P(HLNDAP0,"^",6)]"" HLION=$P(HLNDAP0,"^",6)
 I HLVER']"" S HLERR="Invalid HL7 Version" Q
 S X=$O(^HL(771.5,"B",HLVER,0)) I 'X S HLERR="Invalid HL7 Version" Q
 I X'=$P(^HL(770,+$O(^HL(770,"B",HLSA,0)),0),"^",7) S HLERR="Invalid HL7 version for Receiving Application" Q
 I "DTP"'[HLPID S HLERR="Inappropriate HL7 Processing ID" Q
 S HLMTP=+$O(^HL(771.2,"B",HLMTN,0)) I HLMTN'="ACK",'$O(^HL(771,HLDAP,"MSG","B",HLMTP,0)) S HLERR="Invalid Message Type for Receiving Application" Q
 S HLROU=$G(^HL(771,HLDAP,"MSG",+$O(^HL(771,HLDAP,"MSG","B",HLMTP,0)),"R")) I HLROU']""!(HLROU="NONE") I HLMTN'="ACK",HLMTN'="MCF" S HLERR="Invalid Message Type for Receiving Application" Q
 S X=$P($P(HLDATA,HLFS,8),$E(HLECH)),X=$$UPPER^HLFNC(X) D ^XUSHSH D  Q:$D(HLERR)
 .I X']"" S:HLMTN'="ACK"&(HLMTN'="MCF")&(HLMTN'="ORR") HLDUZ=0 Q
 .S HLDUZ=+$O(^VA(200,"A",X,0)) I '$D(^VA(200,HLDUZ,.1)) I HLMTN'="ACK",HLMTN'="MCF",HLMTN'="ORR" S HLDUZ=0
 S X=$P($P(HLDATA,HLFS,8),$E(HLECH),3) I X]"" D  Q:$D(HLERR)
 .I '$D(^VA(200,HLDUZ,20)) S HLERR="No Signature Code on File" Q
 .S X=$$UPPER^HLFNC(X) D HASH^XUSHSHP I X'=$P(^VA(200,HLDUZ,20),"^",4)!($P(^(20),"^",2)']"") S HLERR="Invalid Electronic Signature Code" Q
 .S HLESIG=$P(^VA(200,HLDUZ,20),"^",2)
 S:HLROU'["^" HLROU="^"_HLROU Q
ACK ;Create and Send 'AR' Error Type Acknowledgement Message
 K HLDATA,HLL,^TMP("HLR",$J) S HLSDATA(2)="MSA"_HLFS_"AR"_HLFS_HLMID_HLFS_HLERR
 K HLERR D SEND^HLLP,KILL
 Q
 ;
REPLY ;Send a Reply/Ack to a HL7 Message Received
 N I,HLAC,HLMSG,HLERR
 I $D(HLSDT) S I="",I=$O(^TMP("HLS",$J,HLSDT,I)),I=$O(^(I)),HLMSA=$G(^(+I))
 I '$D(HLSDT),$D(HLSDATA) S I="",I=$O(HLSDATA(I)),I=$O(HLSDATA(I)),HLMSA=$G(HLSDATA(+I))
 I $D(HLMSA),$D(HLDAP),HLDAP,$E(HLMSA,1,3)="MSA" S HLMSG="" D
 . S HLAC=$P(HLMSA,HLFS,2)
 . Q:(HLAC="")!('$D(HLNDAP))
 . I $P(HLMSA,HLFS,4)]"" S HLERR=$P(HLMSA,HLFS,4)
 . S HLAC=$S(HLMTN="MCF":2,HLAC'="AA":4,1:3)
 . D STATUS^HLTF0(HLDA,HLAC,$G(HLMSG))
 ;
 I $D(HLSEC) D
 . I $D(HLSDT) S I="",I=$O(^TMP("HLS",$J,HLSDT,I)),$P(^TMP("HLS",$J,HLSDT,I),HLFS,8)=HLSEC
 . I '$D(HLSDT) S I="",I=$O(HLSDATA(I)),$P(HLSDATA(I),HLFS,8)=HLSEC
 ;
 K HLERR
 D SEND^HLLP,KILL
 K ^TMP("HLS",$J)
 Q
 ;
KILL ;Kill variables before receiving another HL7 message
 K HLB,HLC,HLC1,HLC2,HLCSUM,HLDA,HLDAN,HLDAP,HLDT,HLDT1,HLDUZ,HLECH,HLERR,HLESIG,HLFS,HLI,HLII,HLK,HLMID,HLMSA,HLMTN,HLPID,HLQ,HLROU,HLSA,HLSDATA,HLSDT,HLVER,X,X0,X1
 D NOW^%DTC S HLTIME=% K %,%H,%I Q
