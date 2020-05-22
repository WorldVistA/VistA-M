DGENUPL ;ALB/CJM,ISA,KWP,TDM,CKN,BAJ,LMD - PROCESS INCOMING (Z11 EVENT TYPE) HL7 MESSAGES ;8/15/08 12:40pm
 ;;5.3;REGISTRATION;**147,222,232,363,472,497,564,677,672,688,871,909,952**;Aug 13,1993;Build 160
 ;
 ;Phase II Moved Z11 to DGENUPL7
ORUZ11(MSGIEN,ERRCOUNT) ;
 ;Description:  This procedure is used to process a batch of ORU~Z11
 ;messages or a single ORU~Z11 message. The processing consists of
 ;uploading the patient enrollment and eligibility data.
 ;
 ;Input:
 ;  MSGIEN - the ien of the HL7 message in the HL7 MESSAGE TEXT file
 ;Output:
 ;  ERRCOUNT - count of messages that were not processed due to
 ;    errors encountered  (pass by reference)
 ;
 N CURLINE,SSN,DOB,SEX,SEG,MSGID,DFN,ERRMSG,TMPARRY,ICN
 ;
 K ^TMP("IVM","HLS",$J)
 ;
 ;initialize HL7 variable
 S HLSDT="IVMQ" ;location of error message
 ;
 S CURLINE=1
 D ADVANCE(MSGIEN,.CURLINE)
 Q:'CURLINE
 F  Q:'CURLINE  D  D ADVANCE(MSGIEN,.CURLINE)
 .D GETSEG(MSGIEN,CURLINE,.SEG)
 .S MSHDT=SEG(7)
 .S MSGID=SEG(10)
 .D NXTSEG(MSGIEN,CURLINE,.SEG)
 .I SEG("TYPE")'="PID" D ADDERROR(MSGID,,"PID SEGMENT MISSING",.ERRCOUNT) Q
 .;S DFN=$$LOOKUP^DGENPTA(SEG(19),$$FMDATE^HLFNC(SEG(7)),SEG(8),.ERRMSG)
 .M TMPARY(3)=SEG(3) D PARSPID3^IVMUFNC(.TMPARY,.PID3ARY)
 .S DFN=$G(PID3ARY("PI")),ICN=$G(PID3ARY("NI"))
 .K TMPARY,PID3ARY
 .I '$$MATCH^IVMUFNC(DFN,ICN,"","","I",.ERRMSG) D ADDERROR(MSGID,SEG(19),ERRMSG,.ERRCOUNT) Q
 .;I 'DFN D ADDERROR(MSGID,SEG(19),ERRMSG,.ERRCOUNT) Q
 .D Z11^DGENUPL7(MSGIEN,MSGID,.CURLINE,DFN,.ERRCOUNT)
 S HLEVN=+$G(ERRCOUNT) ;# of events included in the reply
 M ^TMP("HLS",$J)=^TMP("IVM","HLS",$J)                     ;DG*5.3*472
 K ^TMP("IVM","HLS",$J)
 Q
 ;
ORFZ11(MSGIEN,MSGID) ;
 ;Description:  This procedure is used to process an ORF~Z11 message
 ;It uploads the patient enrollment and eligibility data.
 ;An acknowledgment is returned.
 ;
 ;Input:
 ;  MSGIEN - the internal entry number of the HL7 message in the HL7 MESSAGE TEXT file (772)
 ;  MSGID - the message control id from the MSH segment
 ;
 ;Output: none
 ;
 N CURLINE,DFN,QUERYIEN,QARRAY,QRYMSGID,ERRCOUNT,HECERROR,SEG,DGRESENT
 N TMPARRY,PID3ARRY,ICN
 ;CURLINE tracks current line in the message
 ;QUERYIEN  the ien of query in the ENROLLMENT QUERY LOG
 ;QRYMSGID  the Message Control ID of the query
 ;QARRAY  array containing the ENROLLMENT QUERY LOG record
 ;HECERROR  error message returned by HEC in response to query
 ;DGRESENT  flag=1 if query was resent
 ;
 S (QUERYIEN,ERRCOUNT)=0
 ;
 ;initialize HL7 variable
 S HLSDT="IVMQ" ;subscript in ^TMP( global for ACK message
 ;
 K ^TMP("IVM","HLS",$J)
 ;
 S CURLINE=1
 S HECERROR=""
 D GETSEG(MSGIEN,CURLINE,.SEG)  ; DG*5.3*871
 S MSHDT=SEG(7)                 ; DG*5.3*871
 S MSGID=SEG(10)                ; DG*5.3*871
 ;
 D  ;drops out on error
 .D NXTSEG(MSGIEN,.CURLINE,.SEG)
 .I SEG("TYPE")'="MSA" D ADDERROR(MSGID,,"MISSING MSA SEGMENT",.ERRCOUNT) Q
 .;trace the reply back to the query
 .S QRYMSGID=SEG(2)
 .S QUERYIEN=$$FINDMSG^DGENQRY(QRYMSGID)
 .I 'QUERYIEN D ADDERROR(MSGID,,"NO RECORD OF QUERY",.ERRCOUNT) Q
 .I QUERYIEN,'$$GET^DGENQRY(QUERYIEN,.QARRAY) D ADDERROR(MSGID,,"NO RECORD OF QUERY",.ERRCOUNT) Q
 .S DFN=QARRAY("DFN")
 .I (SEG(1)="AR")!(SEG(1)="AE") D  Q
 ..;HEC was unable to reply to the query. If due to incorrect patient
 ..;info, then resend the query, otherwise just log it as unsuccessful
 ..N SSN,DOB,SEX,DGPAT,HECMSG
 ..S HECMSG=SEG(3)
 ..D NXTSEG(MSGIEN,.CURLINE,.SEG)
 ..Q:(SEG("TYPE")'="QRD")
 ..S SSN=SEG(8)
 ..D NXTSEG(MSGIEN,.CURLINE,.SEG)
 ..Q:(SEG("TYPE")'="QRF")
 ..S DOB=$$FMDATE^HLFNC(SEG(4))
 ..S SEX=SEG(5)
 ..;if patient id info incorrect, resend the query
 ..I $$GET^DGENPTA(DFN,.DGPAT),((DOB'=DGPAT("DOB"))!(SEX'=DGPAT("SEX"))) I $$RESEND^DGENQRY1(QUERYIEN) S DGRESENT=1 Q
 ..S HECERROR="HEC UNABLE TO RESPOND TO QUERY- "_HECMSG Q
 .;
 .F SEG="QRD","QRF" D NXTSEG(MSGIEN,.CURLINE,.SEG) I SEG("TYPE")'=SEG D ADDERROR(MSGID,,SEG_" SEGMENT MISSING",.ERRCOUNT) Q
 .S SEG="PID" D NXTSEG(MSGIEN,CURLINE,.SEG) I SEG("TYPE")'=SEG D ADDERROR(MSGID,,SEG_" SEGMENT MISSING",.ERRCOUNT) Q
 .;S CURLINE=CURLINE-1 ;should point to line before PID
 .;I $$SSN^DGENPTA(DFN)'=SEG(19) D ADDERROR(MSGID,,"SSN DOES NOT MATCH",.ERRCOUNT) Q
 .M TMPARY(3)=SEG(3) D PARSPID3^IVMUFNC(.TMPARY,.PID3ARY)
 .S DFN=$G(PID3ARY("PI")),ICN=$G(PID3ARY("NI"))
 .K TMPARY,PID3ARY
 .I '$$MATCH^IVMUFNC(DFN,ICN,"","","I",.ERRMSG) D ADDERROR(MSGID,,ERRMSG,.ERRCOUNT) Q
 .D Z11^DGENUPL7(MSGIEN,MSGID,.CURLINE,DFN,.ERRCOUNT)
 ;
 ;update the query log
 I $G(HECERROR)="",ERRCOUNT S HECERROR="UPLOAD FAILED DUE TO CONSISTENCY CHECKS"
 I '$G(DGRESENT),$$RECEIVE^DGENQRY1(QUERYIEN,HECERROR,MSGID)
 ;
 S HLEVN=+$G(ERRCOUNT) ;# of events included in the reply
 ;
 ;if there was no error, create an 'AA' ack
 ;I 'ERRCOUNT D ACCEPT^DGENUPL1(MSGID)                  ;DG*5.3*472
 ;D MVERRORS^DGENUPL1                                   ;DG*5.3*472
 ;transmit the ack
 ;********************************************************
 ;7.12.01;KSD; COMMENTED OUT. DON'T SEND ACK TO ORF
 ;I $D(HLTRANS) S HLARYTYP="GB",HLFORMAT=1 D GENACK^HLMA1(HLEID,HLMTIENS,HLEIDS,HLARYTYP,HLFORMAT,.HLRESLTA,HLMTIEN)
 ;
 Q
 ;
ADDERROR(MSGID,SSN,ERRMSG,ERRCOUNT) ;
 ;Description - writes an error message to a global. It will be
 ;transmitted in the ack later.
 ;
 ;Inputs:
 ;  MSGID -message control id of HL7 msg in the MSH segment
 ;  SSN - patient social security number
 ;  ERRMSG - the error message
 ;  ERRCOUNT - count of errors written so far
 ;
 ;Outputs: none
 ;
 S ERRCOUNT=+$G(ERRCOUNT)
 ;
 I (ERRCOUNT*2)+1=1 D
 . K HL,HLMID,HLMTIEN,HLDT,HLDT1
 . D INIT^HLFNC2(HLEID,.HL)
 . D CREATE^HLTF(.HLMID,.HLMTIEN,.HLDT,.HLDT1)
 K HLRES
 S MID=HLMID_"-"_((ERRCOUNT*2)+1)
 D MSH^HLFNC2(.HL,MID,.HLRES)
 S ^TMP("IVM","HLS",$J,(ERRCOUNT*2)+1)=HLRES
 S ^TMP("IVM","HLS",$J,(ERRCOUNT*2)+2)="MSA"_HLFS_"AE"_HLFS_MSGID_HLFS_ERRMSG_" - SSN "_$S($L($G(SSN)):SSN,1:"NOT FOUND")
 S ERRCOUNT=ERRCOUNT+1
 ;Put in error message in HECERROR to be included in the NOTIFY message for a solicited query
 I $D(HECERROR) S HECERROR=ERRMSG
 Q
 ;
NXTSEG(MSGIEN,CURLINE,SEG) ;
 ;Description: Returns the next segment
 ;
 ;Input:
 ;  MSGIEN - ien in HL7 MESSAGE TEXT file
 ;  CURLINE - subscript of the current segment
 ;
 ;Output:
 ;  SEG - an array with the fields of the segment (pass by reference)
 ;  CURLINE - upon exiting, will be the subscript of the next segment
 ;
 S CURLINE=CURLINE+1
 D GETSEG(MSGIEN,.CURLINE,.SEG)
 Q
 ;
GETSEG(MSGIEN,CURLINE,SEG) ;
 ;returns the current segment
 ;
 ;Input:
 ;  MSGIEN - ien in HL7 MESSAGE TEXT file
 ;  CURLINE - subscript of the current segment
 ;
 ;Output:
 ;  SEG - an array with the fields of the segment (pass by reference)
 ;
 N SEGMENT,I,CNTR,NOPID,PIDSTR,IVMPID,SEGHLD,CNTR2
 I $G(SEG)'="" S SEGHLD=SEG
 K SEG
 S SEG=$G(SEGHLD)
 S CNTR=1,NOPID=0
 S:$G(HLFS)="" HLFS=$G(HL("FS")) S:HLFS="" HLFS="^"
 S SEGMENT=$G(^TMP($J,IVMRTN,CURLINE,0))
 S SEG("TYPE")=$E(SEGMENT,1,3)
 ;Strip double quotes from the following segments.  DG*5.3*688
 I SEG("TYPE")="ZRD" D
 .S SEGMENT=$$CLEARF^IVMPRECA(SEGMENT,HLFS)
 I SEG("TYPE")="PID" D  Q
 .S PIDSTR(CNTR)=$P(SEGMENT,HLFS,2,99)
 .F I=1:1 D  Q:NOPID
 ..S CURLINE=CURLINE+1,SEGMENT=$G(^TMP($J,IVMRTN,CURLINE,0))
 ..I $E(SEGMENT,1,4)="ZPD^" S NOPID=1,CURLINE=CURLINE-1 Q
 ..S CNTR=CNTR+1,PIDSTR(CNTR)=SEGMENT
 .D BLDPID^IVMPREC6(.PIDSTR,.IVMPID)
 .;convert "" to null for PID segment
 .S CNTR="" F  S CNTR=$O(IVMPID(CNTR)) Q:CNTR=""  D
 ..I $O(IVMPID(CNTR,"")) D  Q
 ...S CNTR2="" F  S CNTR2=$O(IVMPID(CNTR,CNTR2)) Q:CNTR2=""  D
 ....S IVMPID(CNTR,CNTR2)=$$CLEARF^IVMPRECA(IVMPID(CNTR,CNTR2),$E(HLECH))
 ..I IVMPID(CNTR)="""""" S IVMPID(CNTR)=""
 .M SEG=IVMPID
 ;
 ;the MSH & BHS segs contain as their first piece the field separator, which makes breaking the segment into fields a bit different
 I (SEG("TYPE")="MSH")!(SEG("TYPE")="BHS") D
 .S SEG(1)=$E(SEGMENT,4)
 .F I=2:1:30 S SEG(I)=$P(SEGMENT,HLFS,I)
 E  D
 .; Expanded to 48 from 45 to allow for OTH fields DG*5.3*952
 .F I=2:1:48 S SEG(I-1)=$P(SEGMENT,HLFS,I)
 Q
 ;
ADVANCE(MSGIEN,CURLINE) ;
 ;Description: Used to find the beginning of the next message in the batch.
 ;
 ;Input:
 ;  MSGIEN - ien of message in the HL7 MESSAGE TEXT file.
 ;  CURLINE - current position in the message
 ;Output:
 ;  CURLINE - starting position of next message in the batch, or 0 if 
 ;    the end of the message is reached
 ;
 Q:'CURLINE
 F  S CURLINE=$O(^TMP($J,IVMRTN,CURLINE)) Q:'CURLINE  Q:$E($G(^TMP($J,IVMRTN,CURLINE,0)),1,3)="MSH"
 S CURLINE=+CURLINE
 Q
