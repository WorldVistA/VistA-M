IVMPRECZ ;ALB/SEK,RTK,TDM - ROUTINE TO PROCESS V1.5 ORF-Z06 INCOMING HL7 MESSAGES ; 8/15/08 10:28am
 ;;2.0;INCOME VERIFICATION MATCH;**34,64,71,115**;21-OCT-94;Build 28
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
GET ; get HL7 segment from ^HL
 S IVMDA=$O(^HL(772,HLDA,"IN",+IVMDA)),IVMSEG=$G(^(+IVMDA,0))
 S IVMSEG1=$E(IVMSEG,1,3)
 I IVMSEG1="PID" D  Q
 .N NOPID,PIDCNTR,PIDSTR
 .K IVMPID
 .S (NOPID,PIDCNTR)=1,PIDSTR(PIDCNTR)=$P(IVMSEG,HLFS,2,99)
 .F I=1:1 D  Q:NOPID
 ..I $E($G(^HL(772,HLDA,"IN",IVMDA+1,0)),1,4)="ZMT^" S NOPID=1 Q
 ..S IVMDA=$O(^HL(772,HLDA,"IN",+IVMDA))
 ..S IVMSEG=$G(^HL(772,HLDA,"IN",+IVMDA,0))
 ..S PIDCNTR=PIDCNTR+1,PIDSTR(PIDCNTR)=IVMSEG
 .D BLDPID^IVMPREC6(.PIDSTR,.IVMPID)
 Q
 ;
ACK ; - prepare acknowledgment (ACK) message
 S IVMCT=$G(IVMCT)+1
 S HLSDT="IVMQ",^TMP("HLS",$J,HLSDT,IVMCT)=HLSDATA(1),IVMCT=IVMCT+1
 S ^TMP("HLS",$J,HLSDT,IVMCT)="MSA"_HLFS_$S($D(HLERR):"AE",1:"AA")_HLFS_HLMID_$S($D(HLERR):HLFS_HLERR_" - SSN "_$S($G(DFN):$P($$PT^IVMUFNC4(DFN),"^",2),1:"NOT FOUND"),1:"")
 I $D(HLERR) S HLEVN=HLEVN+1,IVMERROR=1
 Q
 ;
NXTSEG(MSGIEN,CURLINE,SEG) ;
 ;Description: Returns the next segment
 ;
 ;Input:
 ;  MSGIEN - IEN in HL7 MESSAGE TEXT file
 ;  CURLINE - subscript of the current segment
 ;
 ;Output:
 ;  SEG - an array with the fields of the segment (pass by reference)
 ;  CURLINE - upone exiting, will be the subscript of the next segment
 ;
 S CURLINE=CURLINE+1
 S SEGMENT=$G(^HL(772,MSGIEN,"IN",CURLINE,0))
 S SEG("TYPE")=$E(SEGMENT,1,3)
 ;
 ; MSH & BHS segs first piece is the field separator, which makes breaking the segment into fields a bit different
 I (SEG("TYPE")="MSH")!(SEG("TYPE")="BHS") D
 . S SEG(1)=$E(SEGMENT,4)
 . F I=2:1:30 S SEG(I)=$P(SEGMENT,HLFS,I)
 E  D
 . F I=2:1:31 S SEG(I-1)=$P(SEGMENT,HLFS,I)
 Q
 ;
ERRBULL ; build mail message for transmission to IVM mail group notifying site
 ; of upload error.
 S IVMPAT=$$PT^IVMUFNC4(DFN)
 S XMSUB="MT SIGNATURE UPLOAD "_$E($P(IVMPAT,"^"),1)_$P(IVMPAT,"^",3)
 S IVMTEXT(1)="Unable to upload a MT Signature.  A Means Test was not found that"
 S IVMTEXT(2)="matches the Centralized Anniversary Date (CAD) on file at the HEC."
 S IVMTEXT(3)=" "
 S IVMTEXT(4)="    NAME:     "_$P(IVMPAT,"^")
 S IVMTEXT(5)="    ID:       "_$P(IVMPAT,"^",2)
 S IVMTEXT(6)="    ERROR:    "_IVMTEXT(6)
 Q
ORF ;entry point for Means Test Signature Z06 msgs.
 N SEG,EVENT,MSGID,COMP,TMPARY,PID3ARY,DFN,ICN
 S:'$D(HLEVN) HLEVN=0
 D NXTSEG(HLDA,0,.SEG)
 Q:(SEG("TYPE")'="MSH")  ;wouldn't have reached here if this happened!
 S EVENT=$P(SEG(9),$E(HLECH),2)
 I EVENT'="Z06" G ORF^IVMCM
 I $G(HLFS)="" S HLFS="^"
 I $G(HLECH)="" S HLECH="~"
 F IVMDA=0:0 S IVMDA=$O(^HL(772,HLDA,"IN",IVMDA)) Q:'IVMDA  S IVMSEG=$G(^(IVMDA,0)) I $E(IVMSEG,1,3)="MSH" D  Q:'IVMDA
 .K HLERR
 .S HLMID=$P(IVMSEG,HLFS,10) ; message control id from MSH
 .S IVMFLGC=0
 .D GET I IVMSEG1'="PID" D  Q
 ..S HLERR="Missing PID segment" D ACK
 .;S DFN=$P($P(IVMSEG,HLFS,4),$E(HLECH))
 .M TMPARY(3)=IVMPID(3) D PARSPID3^IVMUFNC(.TMPARY,.PID3ARY)
 .S DFN=$G(PID3ARY("PI")),ICN=$G(PID3ARY("NI"))
 .I '$$MATCH^IVMUFNC(DFN,ICN,"","","I",.ERRMSG) S HLERR=ERRMSG D ACK Q
 .K TMPARY,PID3ARY
 .;I $P(IVMSEG,HLFS,20)'=$P(^DPT(DFN,0),"^",9) S HLERR="Couldn't match IVMSSN with DHCP SSN" D ACK Q
 .S IVMDAP=IVMDA ; save IVMDA for veteran PID segment
 .D GET I IVMSEG1'="ZMT" D  Q
 ..S HLERR="Missing ZMT segment" D ACK
 .; IVMMTDT - means test date
 .; DGLY - income year
 .; if Means Test not in DHCP don't upload IVM Means Test
 .S IVMMTDT=$$FMDATE^HLFNC($P(IVMSEG,HLFS,3)) ; means test date from ZMT  segment
 .S DGLY=$$LYR^DGMTSCU1(IVMMTDT)
 .; get means test to be updated
 .N UPMTS
 .S MTDATE=-IVMMTDT,IVMMTIEN="",(UPMTS,MTFND)=0
 .F  S IVMMTIEN=$O(^DGMT(408.31,"AID",1,DFN,MTDATE,IVMMTIEN),-1) Q:MTFND!(IVMMTIEN="")  D
 ..; match site completing in case multiple tests for same date
 ..I $P(IVMSEG,HLFS,23)=$P(^DGMT(408.31,IVMMTIEN,2),HLFS,5) S UPMTS=IVMMTIEN,MTFND=1 Q
 .S (IVMMT31,DGMTP)=$G(^DGMT(408.31,UPMTS,0)) ; DGMTP is event driver  variable
 .I $P(IVMMT31,"^")'=IVMMTDT D  Q
 ..S Y=IVMMTDT X ^DD("DD")
 ..S IVMTEXT(6)="Means Test of "_Y_" not found in VistA."
 ..D ERRBULL,MAIL^IVMUFNC()
 ..S HLERR="Means test not in VistA" D ACK
 ..Q
 .I $P(IVMMT31,"^",23)=2 S Y=IVMMTDT X ^DD("DD") S HLERR="2nd means test  sent for "_Y D ACK Q
 .; do not upload IVM means test if primary means test status is
 .; 3-no longer required
 .; or if hardship case
 .S IVMSTAT=$P(IVMMT31,"^",3)
 .I IVMSTAT=3 S HLERR="NOT UPLOADED no longer required" D ACK Q
 .I $P(IVMMT31,"^",20)=1 S HLERR="NOT UPLOADED hardship case" D ACK Q
 .;get MT signature and date/time edited info, update means test
 .N DATA
 .S DATA(.29)=$P(IVMSEG,HLFS,28),DATA(2.02)=$$FMDATE^HLFNC($P(IVMSEG,HLFS,26)) I $D(DATA(.29)) D
 ..I $$UPD^DGENDBS(408.31,UPMTS,.DATA)
 .I '$D(HLERR) D ACK
 .;
 .; cleanup
 .K DGLY,DGMTP,IVMDAP,IVMDAS,IVMDAZ,IVMDGLY,IVMFLG7,IVMFLGC,IVMMT31,IVMMTDT,IVMMTIEN,IVMSEG,IVMSEG1,IVMSTAT,IVMTEXT,XMSUB,FMDATE,MTDATE
 .Q
 Q
