IVMPREC7 ;ALB/SEK,RTK - ROUTINE TO PROCESS INCOMING (Z06 EVENT TYPE) HL7 MESSAGES ; 31 May 94
 ;;2.0;INCOME VERIFICATION MATCH;**1,17,44,34,77**;21-OCT-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; This routine will process (validate) batch ORU Means Test(event type
 ; Z06) HL7 messages received from the IVM center.  Format of batch:
 ;       BHS
 ;       {MSH
 ;        PID
 ;        ZIC
 ;        ZIR
 ;        {ZDP
 ;         ZIC
 ;         ZIR
 ;        }
 ;        ZMT
 ;       }
 ;       BTS
 ;
EN ; entry point to validate Means Test messages 
 ;
 F IVMDA=1:0 S IVMDA=$O(^TMP($J,IVMRTN,IVMDA)) Q:'IVMDA  S IVMSEG=$G(^(IVMDA,0)) I $E(IVMSEG,1,3)="MSH" D  Q:'IVMDA
 .K HLERR
EN1 .S HLMID=$P(IVMSEG,HLFS,10) ; message control id from MSH
 .S IVMFLGC=0
 .D GET I IVMSEG1'="PID" D  Q
 ..S HLERR="Missing PID segment" D ACK^IVMPREC
 .S DFN=$P($P(IVMSEG,HLFS,4),$E(HLECH))
 .I ('DFN!(DFN'=+DFN)!('$D(^DPT(+DFN,0)))) D  Q
 ..S HLERR="Invalid DFN" D ACK^IVMPREC
 .I $P(IVMSEG,HLFS,20)'=$P(^DPT(DFN,0),"^",9) S HLERR="Couldn't match IVM SSN with DHCP SSN" D ACK^IVMPREC Q
 .S IVMDAP=IVMDA ; save IVMDA for veteran PID segment
 .;
 .; check for veteran's ZIC and ZIR segments
 .D GET I IVMSEG1'="ZIC" D  Q
 ..S HLERR="Missing veteran's ZIC segment" D ACK^IVMPREC
 .S IVMDGLY=$P(IVMSEG,"^",3) ; income year
 .D GET I IVMSEG1'="ZIR" D  Q
 ..S HLERR="Missing veteran's ZIR segment" D ACK^IVMPREC
 .;
 .; check for spouse's ZDP, ZIC, ZIR segments
 .D GET I IVMSEG1'="ZDP" D  Q
 ..S HLERR="Missing spouse's ZDP segment" D ACK^IVMPREC
 .S IVMDAS=IVMDA ; save IVMDA for spouse ZDP segment
 .D GET I IVMSEG1'="ZIC" D  Q
 ..S HLERR="Missing spouse's ZIC segment" D ACK^IVMPREC
 .D GET I IVMSEG1'="ZIR" D  Q
 ..S HLERR="Missing spouse's ZIR segment" D ACK^IVMPREC
 .;
 .; check for dependent children's ZDP, ZIC, ZIR segments and ZMT segment
 .K IVMERR
 .S IVMFLG7=0
 .F  D  Q:$D(IVMERR)!(IVMSEG1="ZMT")
 ..D GET I IVMSEG1'="ZDP"&(IVMSEG1'="ZMT") D  Q
 ...S HLERR="Missing child's ZDP segment or ZMT segment",IVMERR="" D ACK^IVMPREC
 ..I IVMSEG1="ZMT" D  Q
 ...S:$P(IVMSEG,"^",4)=HLQ IVMFLG7=1 ; delete MT if status is HLQ
 ...S IVMDAZ=IVMDA ; ZMT segment ivmda
 ..I $P(IVMSEG,"^",2)']""!($P(IVMSEG,"^",3)']"")!($P(IVMSEG,"^",4)']"") D  Q
 ... S HLERR="Missing child data from ZDP segment",IVMERR="" D ACK^IVMPREC
 ..D GET I IVMSEG1'="ZIC" D  Q
 ...S HLERR="Missing child's ZIC segment",IVMERR="" D ACK^IVMPREC
 ..D GET I IVMSEG1'="ZIR" D  Q
 ...S HLERR="Missing child's ZIR segment",IVMERR="" D ACK^IVMPREC
 ..S IVMFLGC=IVMFLGC+1 ; # of children
 .;
 .Q:$D(IVMERR)&(IVMSEG1'="MSH")
 .G EN1:IVMSEG1="MSH"
 .;
 .; get primary means test
 .; ivmmtdt - means test date
 .; dgly - income year
 .; if Means Test not in DHCP don't upload IVM Means Test
 .S IVMMTDT=$$FMDATE^HLFNC($P(IVMSEG,HLFS,3)) ; means test date from ZMT segment
 .S DGLY=$$LYR^DGMTSCU1(IVMMTDT)
 .S IVMMTIEN=+$$LST^DGMTU(DFN,IVMMTDT) ; primary means test IEN
 .;
 .I IVMFLG7 D ^IVMUM7 Q  ; delete means test
 .;
 .S (IVMMT31,DGMTP)=$G(^DGMT(408.31,IVMMTIEN,0)) ; dgmtp is event driver variable
 .I $P(IVMMT31,"^")'=IVMMTDT D  Q
 ..S Y=IVMMTDT X ^DD("DD")
 ..S IVMTEXT(6)="Means Test of "_Y_" not in DHCP."
 ..D ERRBULL,MAIL^IVMUFNC()
 ..S HLERR="Means test not in DHCP" D ACK^IVMPREC
 ..Q
 .I $P(IVMMT31,"^",23)=2 S Y=IVMMTDT X ^DD("DD") S HLERR="2nd means test sent for "_Y D ACK^IVMPREC Q
 .;
 .; do not upload IVM means test if primary means test status is
 .; 3-no longer required
 .; or if hardship case
 .S IVMSTAT=$P(IVMMT31,"^",3)
 .I IVMSTAT=3 S HLERR="NOT UPLOADED no longer required" D ACK^IVMPREC Q
 .I $P(IVMMT31,"^",20)=1 S HLERR="NOT UPLOADED hardship case" D ACK^IVMPREC Q
 .D ^IVMUM1 ; upload means test
 .I $D(HLERR) D ACK^IVMPREC
 .;
 .; cleanup
 .K DGLY,DGMTP,IVMDAP,IVMDAS,IVMDAZ,IVMDGLY,IVMFLG7,IVMFLGC,IVMMT31,IVMMTDT,IVMMTIEN,IVMSEG,IVMSEG1,IVMSTAT,IVMTEXT,XMSUB
 .Q
 Q
 ;
GET ; get HL7 segment from ^HL
 S IVMDA=$O(^TMP($J,IVMRTN,+IVMDA)),IVMSEG=$G(^(+IVMDA,0))
 S IVMSEG1=$E(IVMSEG,1,3)
 Q
 ;
ERRBULL ; build mail message for transmission to IVM mail group notifying site
 ; of upload error.
 S IVMPAT=$$PT^IVMUFNC4(DFN)
 S XMSUB="IVM - MEANS TEST UPLOAD"
 S IVMTEXT(1)="The following error occured when an Income Verification Match"
 S IVMTEXT(2)="verified Means Test was being uploaded for the following patient:"
 S IVMTEXT(3)=" "
 S IVMTEXT(4)="    NAME:     "_$P(IVMPAT,"^")
 S IVMTEXT(5)="    ID:       "_$P(IVMPAT,"^",2)
 S IVMTEXT(6)="    ERROR:    "_IVMTEXT(6)
 Q
ORF ;entry point for Means Test Signature Z06 msgs.
 I $G(HLFS)="" S HLFS="^"
 I $G(HLECH)="" S HLECH="~"
 F IVMDA=0:0 S IVMDA=$O(^TMP($J,IVMRTN,IVMDA)) Q:'IVMDA  S IVMSEG=$G(^(IVMDA,0)) I $E(IVMSEG,1,3)="MSH" D  Q:'IVMDA
 .K HLERR
 .S HLMID=$P(IVMSEG,HLFS,10) ; message control id from MSH
 .S IVMFLGC=0
 .D GET I IVMSEG1'="PID" D  Q
 ..S HLERR="Missing PID segment" D ACK^IVMPREC
 .S DFN=$P($P(IVMSEG,HLFS,4),$E(HLECH))
 .I ('DFN!(DFN'=+DFN)!('$D(^DPT(+DFN,0)))) D  Q
 ..S HLERR="Invalid DFN" D ACK^IVMPREC
 .I $P(IVMSEG,HLFS,20)'=$P(^DPT(DFN,0),"^",9) S HLERR="Couldn't match IVMSSN with DHCP SSN" D ACK^IVMPREC Q
 .S IVMDAP=IVMDA ; save IVMDA for veteran PID segment
 .D GET I IVMSEG1'="ZMT" D  Q
 ..S HLERR="Missing ZMT segment" D ACK^IVMPREC
 .; IVMMTDT - means test date
 .; DGLY - income year
 .; if Means Test not in DHCP don't upload IVM Means Test
 .S IVMMTDT=$$FMDATE^HLFNC($P(IVMSEG,HLFS,3)) ; means test date from ZMT  segment
 .S DGLY=$$LYR^DGMTSCU1(IVMMTDT)
 .; get means test to be updated
 .N UPMTS
 .S MTDATE=-IVMMTDT,IVMMTIEN="",MTFND=0
 .F  S IVMMTIEN=$O(^DGMT(408.31,"AID",1,DFN,MTDATE,IVMMTIEN),-1) Q:MTFND!(IVMMTIEN="")  D
 ..I $$Z06MT^EASPTRN1(IVMMTIEN) Q    ;EDB Z06 - Don't use this one
 ..; match site completing in case multiple tests for same date
 ..I $P(IVMSEG,HLFS,23)=$P(^DGMT(408.31,IVMMTIEN,2),HLFS,5) S UPMTS=IVMMTIEN,MTFND=1 Q
 .S (IVMMT31,DGMTP)=$G(^DGMT(408.31,UPMTS,0)) ; DGMTP is event driver  variable
 .I $P(IVMMT31,"^")'=IVMMTDT D  Q
 ..S Y=IVMMTDT X ^DD("DD")
 ..S IVMTEXT(6)="Means Test of "_Y_" not in DHCP."
 ..D ERRBULL,MAIL^IVMUFNC()
 ..S HLERR="Means test not in DHCP" D ACK^IVMPREC
 ..Q
 .I $P(IVMMT31,"^",23)=2 S Y=IVMMTDT X ^DD("DD") S HLERR="2nd means test  sent for "_Y D ACK^IVMPREC Q
 .; do not upload IVM means test if primary means test status is
 .; 3-no longer required
 .; or if hardship case
 .S IVMSTAT=$P(IVMMT31,"^",3)
 .I IVMSTAT=3 S HLERR="NOT UPLOADED no longer required" D ACK^IVMPREC Q
 .I $P(IVMMT31,"^",20)=1 S HLERR="NOT UPLOADED hardship case" D ACK^IVMPREC Q
 .;get MT signature and date/time edited info, update means test
 .N DATA
 .S DATA(.29)=$P(IVMSEG,HLFS,28),DATA(2.02)=$$FMDATE^HLFNC($P(IVMSEG,HLFS,26)) I $D(DATA(.29)) D
 ..I $$UPD^DGENDBS(408.31,UPMTS,.DATA)
 .I '$D(HLERR) D ACK^IVMPREC
 .;
 .; cleanup
 .K DGLY,DGMTP,IVMDAP,IVMDAS,IVMDAZ,IVMDGLY,IVMFLG7,IVMFLGC,IVMMT31,IVMMTDT,IVMMTIEN,IVMSEG,IVMSEG1,IVMSTAT,IVMTEXT,XMSUB,FMDATE,MTDATE
 .Q
 Q
