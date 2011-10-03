HLTRANS ;AISC/SAW-Create Mail Message and Entry in the HL7 Transmission File ;03/24/2004  16:22
 ;;1.6;HEALTH LEVEL SEVEN;**108**;Oct 13, 1995
 ;This routine is used for the Version 1.5 Interface Only
EN ;Compile 'MSH' Segment
 I '$D(HLERR1) S HLEVN=1,HLSDATA(0)=$$MSH^HLFNC1($G(HLMTN),$G(HLSEC)) I $D(HLSDT) S ^TMP("HLS",$J,HLSDT,0)=HLSDATA(0) K HLSDATA
EN1 ;Create Mail Message (Package Supplies MSH Segment(s))
 S XMSUB="HL7 Message "_HLDT_" from "_HLDAN_" at Station "_$P(HLNDAP0,"^",2),XMDUZ=.5 D GET^XMA2 G EN1:XMZ<1 S HLXMZ=XMZ
 I '$D(HLERR1) N X,Y D
 .I '$D(HLSDT) S HLI="",HLCHAR=0 F HLI0=1:1 S HLI=$O(HLSDATA(HLI)) Q:HLI=""  S ^XMB(3.9,HLXMZ,2,HLI0,0)=HLSDATA(HLI),HLCHAR=HLCHAR+$L(HLSDATA(HLI)) S X=HLSDATA(HLI) I $E(X,1,3)="MSA"!($E(X,1,3)="BHS") D:'$D(HLMSA)
 ..I $E(X,1,3)="MSA" S HLMSA=X
 ..I $E(X,1,3)="BHS",$P(X,HLFS,10)]"" S HLMSA=$P(X,HLFS,10)
 .I $D(HLSDT) S HLI="",HLCHAR=0 F HLI0=1:1 S HLI=$O(^TMP("HLS",$J,HLSDT,HLI)) Q:HLI=""  S X=^TMP("HLS",$J,HLSDT,HLI),^XMB(3.9,HLXMZ,2,HLI0,0)=X,HLCHAR=HLCHAR+$L(X) I $E(X,1,3)="MSA"!($E(X,1,3)="BHS") D:'$D(HLMSA)
 ..I $E(X,1,3)="MSA" S HLMSA=X
 ..I $E(X,1,3)="BHS",$P(X,HLFS,10)]"" S HLMSA=$P(X,HLFS,10)
 .S HLI0=HLI0-1,^XMB(3.9,HLXMZ,2,0)="^3.92A^"_HLI0_"^"_HLI0_"^"_DT,XMDUN="POSTMASTER"
 .I $P(HLNDAP0,"^",10) D
 ..S X=$G(^XMB(3.8,$P(HLNDAP0,"^",10),0)) I $P(X,"^")]"" S XMY("G."_$P(X,"^"))=""
 ..E  K XMY S HLERR1=1,HLERR="Unable to determine receipients for mail message.",XMY(.5)="" K ^XMB(3.9,HLXMZ,2)
 .I '$P(HLNDAP0,"^",10) S XMY(.5)=""
 .I '$D(HLERR1) D ENT1^XMD
EN2 ;Enter Data into HL7 Transmission File/Record Error Messages
 S:$D(HLERR) HLMSG="Application Error" D OUT^HLTF(HLDA,HLDT,HLMTN) I $D(HLERR1) D
 .S ^XMB(3.9,HLXMZ,2,1,0)="Unable to transmit HL7 message due to the following Application Error:",^XMB(3.9,HLXMZ,2,2,0)=HLERR,^XMB(3.9,HLXMZ,2,0)="^3.92A^2^2^"_DT
 .S XMY(.5)="" D ENT1^XMD
EXIT K HLERR1,HLI,HLI0,HLMSA,HLXMZ,VAT,VATERR,VATNAME,XMDUN,XMDUZ,XMSUB,XMY,XMZ Q
INIT ;Initialize Variables for Creating HL7 Segments
 ;The following variables are returned by this entry point:
 ;HLNDAP  - Non-DHCP Application Pointer from file 770
 ;HLNDAP0 - Zero node from file 770 corresponding to HLNDAP
 ;HLDAP   - DHCP Application Pointer from file 771
 ;HLDAN   - The DHCP Application Name (.01 field, file 771) for HLDAP
 ;HLPID   - HL7 processing ID from file 770
 ;HLVER   - HL7 version number from file 770
 ;HLFS    - HL7 Field Separater from the 'FS' node of file 771
 ;HLECH   - HL7 Encoding Characters from the 'EC' node of file 771
 ;HLQ     - Double quotes ("") for use in building HL7 segments
 ;HLERR   - if an error is encountered, an error message is returned
 ;          in the HLERR variable.
 ;HLDA    - the internal entry number for the entry created in file 772.
 ;HLDT    - the transmission date/time (associated with the entry in 
 ;          in file 772 identified by HLDA) in internal VA FileMan
 ;          format.
 ;HLDT1   - the same transmission date/time as the HLDT variable, only
 ;          in HL7 format.
 ;
 ; patch HL*1.6*108 start
 ;I $D(HLDAP) S:'HLDAP HLDAN=HLDAP S HLDAP=$S('HLDAP:$O(^HL(771,"B",HLDAP,0)),1:HLDAP),HLNDAP=$O(^HL(770,"AG",+HLDAP,0)) I 'HLDAP!('HLNDAP) S HLERR="Invalid "_$S('HLDAP:"DHCP",1:"Non-DHCP")_" Application Name" G SET
 I $D(HLDAP) S:'HLDAP HLDAN=HLDAP S HLDAP=$S('HLDAP:$O(^HL(771,"B",$E(HLDAP,1,30),0)),1:HLDAP),HLNDAP=$O(^HL(770,"AG",+HLDAP,0)) I 'HLDAP!('HLNDAP) S HLERR="Invalid "_$S('HLDAP:"DHCP",1:"Non-DHCP")_" Application Name" G SET
 ; patch HL*1.6*108 end
 ;
 S HLNDAP=$S('$D(HLNDAP):0,HLNDAP:HLNDAP,1:$O(^HL(770,"B",HLNDAP,0))) I 'HLNDAP S HLERR="Invalid Non-DHCP Application Name" G SET
 S HLNDAP0=$S($D(^HL(770,HLNDAP,0)):^(0),1:"") I HLNDAP0']"" S HLERR="Invalid Non-DHCP Application Name" G SET
 I '$D(HLDAP) S HLDAP=$P(HLNDAP0,"^",8) I 'HLDAP S HLERR="Invalid DHCP Application Name" G SET
 I '$D(HLDAN) S HLDAN=$S($D(^HL(771,HLDAP,0)):$P(^(0),"^"),1:"") I HLDAN']"" S HLERR="Invalid DHCP Application Name" G SET
 S HLPID=$P(HLNDAP0,"^",14) I HLPID']"" S HLPID="P"
 S HLVER=$S($D(^HL(771.5,+$P(HLNDAP0,"^",7),0)):$P(^(0),"^"),1:2.1) I HLVER']"" S HLVER=2.1
 S HLQ="""""",HLFS=$S($D(^HL(771,HLDAP,"FS")):$E(^("FS")),1:"^"),HLECH=$S($D(^("EC")):$E(^("EC"),1,4),1:"~|\&")
SET D CREATE^HLTF(.HLMID,.HLDA,.HLDT,.HLDT1) K HLMID
 I $D(HLERR) S:'$G(HLDAP) HLDAP="" S:'HLNDAP HLNDAP="" S:$G(HLDAN)']"" HLDAN="UNKNOWN" S:'$G(HLNDAP0) HLNDAP0="^UNKNOWN" S HLMTN="UNKNOWN",HLERR1=1,HLFS="" D EN K HLFS,HLMSG,HLMTN
 Q
KILL ;Delete HL variables created by calls to INIT^HLTRANS and FILE^HLTF
 K HLCHAR,HLDA,HLDAN,HLDAP,HLDT,HLDT1,HLDUZ,HLECH,HLERR,HLFS,HLNDAP,HLNDAP0,HLPID,HLQ,HLVER Q
