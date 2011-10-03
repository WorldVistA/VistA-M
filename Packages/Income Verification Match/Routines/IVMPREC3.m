IVMPREC3 ;ALB/KCL/CKN,TDM - PROCESS INCOMING (Z04 EVENT TYPE) HL7 MESSAGES ; 8/15/08 10:21am
 ;;2.0;INCOME VERIFICATION MATCH;**3,17,34,111,115**;21-OCT-94;Build 28
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; This routine will process batch ORU insurance(event type Z04) HL7
 ; messages received from the IVM center.  Format of batch:
 ;       BHS
 ;       {MSH
 ;        PID
 ;        IN1    could be a continuation of IN1
 ;        ZIV
 ;       }
 ;       BTS
 ;
EN ; - entry point to process insurance messages
 ;
 N IVMPID,PIDSTR,COMP,CNTR,NOPID,TMPARY,PID3ARY,ICN,DFN,CNTR2
 F IVMDA=1:0 S IVMDA=$O(^TMP($J,IVMRTN,IVMDA)) Q:'IVMDA  S IVMSEG=$G(^(IVMDA,0)) I $E(IVMSEG,1,3)="MSH" D
 .K HLERR
 .;
 .; - message control id from MSH segment
 .S MSGID=$P(IVMSEG,HLFS,10)
 .;
 .; - get message segments from (#772) file
 .S IVMDA=$O(^TMP($J,IVMRTN,IVMDA)),IVMSEG=$G(^(+IVMDA,0)) I $E(IVMSEG,1,3)'="PID" D  Q
 ..S HLERR="Missing PID segment" D ACK^IVMPREC
 .S CNTR=1,NOPID=0,PIDSTR(CNTR)=$P(IVMSEG,HLFS,2,999)
 .;Handle wrapped PID segment
 .F I=1:1 D  Q:NOPID
 ..S IVMDA=$O(^TMP($J,IVMRTN,IVMDA)),IVMSEG=$G(^(+IVMDA,0))
 ..I $E(IVMSEG,1,4)="IN1^" S NOPID=1,IVMDA=IVMDA-1 Q
 ..S CNTR=CNTR+1,PIDSTR(CNTR)=IVMSEG
 .D BLDPID^IVMPREC6(.PIDSTR,.IVMPID)  ;Create IVMPID subscripted by seq #
 .;convert "" to null for PID segment
 .S CNTR="" F  S CNTR=$O(IVMPID(CNTR)) Q:CNTR=""  D
 ..I $O(IVMPID(CNTR,"")) D  Q
 ...S CNTR2="" F  S CNTR2=$O(IVMPID(CNTR,CNTR2)) Q:CNTR2=""  D
 ....S IVMPID(CNTR,CNTR2)=$$CLEARF^IVMPRECA(IVMPID(CNTR,CNTR2),$E(HLECH))
 ..I IVMPID(CNTR)=HLQ S IVMPID(CNTR)=""
 .M TMPARY(3)=IVMPID(3) D PARSPID3^IVMUFNC(.TMPARY,.PID3ARY)
 .S DFN=$G(PID3ARY("PI")),ICN=$G(PID3ARY("NI"))
 .K TMPARY,PID3ARY
 .I '$$MATCH^IVMUFNC(DFN,ICN,"","","I",.ERRMSG) S HLERR=ERRMSG D ACK^IVMPREC Q
 .S IVMDA=$O(^TMP($J,IVMRTN,IVMDA)),IVMSEG=$G(^(+IVMDA,0)) I $E(IVMSEG,1,3)'="IN1" D  Q
 ..S HLERR="Missing IN1 segment" D ACK^IVMPREC
 .S IVMSEG1=$$CLEARF^IVMPRECA($P(IVMSEG,HLFS,2,999),HLFS,",5,")
 .S $P(IVMSEG1,HLFS,5)=$$CLEARF^IVMPRECA($P(IVMSEG1,HLFS,5),$E(HLECH))
 .I $P(IVMSEG1,HLFS,4)']"" D  Q
 ..S HLERR="Missing insurance company name" D ACK^IVMPREC
 .I $P(IVMSEG1,HLFS,8)']"",($P(IVMSEG1,HLFS,9)']"") D  Q
 ..S HLERR=$S($P(IVMSEG1,HLFS,7)']"":"Missing group number",1:"Missing group name") D ACK^IVMPREC
 .I $P(IVMSEG1,HLFS,17)']"" D  Q
 ..S HLERR="Missing insured's relation to patient" D ACK^IVMPREC
 .I $P(IVMSEG1,HLFS,17)'="v",($P(IVMSEG1,HLFS,16)']"") D  Q
 ..S HLERR="Missing name of insured" D ACK^IVMPREC
 .S IVMDA=$O(^TMP($J,IVMRTN,IVMDA)),IVMSEG=$G(^(+IVMDA,0)) I $E(IVMSEG,1,3)'="ZIV",$L(IVMSEG1)'=241 D  Q
 ..S HLERR="Missing ZIV segment" D ACK^IVMPREC
 .S IVMSEG=$$CLEARF^IVMPRECA(IVMSEG,HLFS)
 .I $P(IVMSEG,HLFS,10)']"" D  Q
 ..S HLERR="Missing IVM internal entry number" D ACK^IVMPREC
 .I $L(IVMSEG1)=241 D  Q:$D(IVMERR)
 ..K IVMERR
 ..S IVMSEG3=IVMSEG
 ..S IVMDA=$O(^TMP($J,IVMRTN,IVMDA)),IVMSEG=$$CLEARF^IVMPRECA($G(^(+IVMDA,0)),HLFS)
 ..I $E(IVMSEG,1,3)'="ZIV" S HLERR="Missing ZIV segment",IVMERR="" D ACK^IVMPREC
 .;S IVMSEG2=$P(IVMSEG,"^",10)
 .;
 .; - check for date of death from IVM
 .I $P(IVMSEG,"^",13)]"" S $P(IVMSEG,"^",13)=$$FMDATE^HLFNC($P(IVMSEG,"^",13))
 .;
 .; - ivm ien/fm date of death
 .S IVMSEG2=$S($P(IVMSEG,"^",13)']"":$P(IVMSEG,"^",10),1:$P(IVMSEG,"^",10)_"/"_$P(IVMSEG,"^",13))
 .S IVMDOD=IVMSEG2
 .;
 .; - if no error encountered - store insurance fields in VistA
 .I '$D(HLERR) D
 ..N IVMRTN,IVMDA
 ..D STORE
 ;
 Q
 ;
 ;
STORE ; - store IN1 segment fields in (#301.5) file and in buffer file
 ;  (remove data from 301.5 'ASEG' xref on successful buffer file filing)
 ;
 N IVMI,IVMJ,IVMIN1,IVMADD
 S DA(1)=$O(^IVM(301.5,"B",DFN,0)),X=$$IEN^IVMUFNC4("IN1")
 I DA(1)']"" S HLERR="patient missing from IVM PATIENT file" D ACK^IVMPREC Q
 I X<0 S HLERR="IN1 segment not in HL7 SEGMENT NAME file" D ACK^IVMPREC Q
 I $G(^IVM(301.5,DA(1),"IN",0))']"" S ^(0)="^301.501PA^^"
 S DIC="^IVM(301.5,"_DA(1)_",""IN"",",DIC(0)="L"
 S DIC("DR")=".03///NOW;.07////^S X=IVMSEG2;10////^S X=IVMSEG1",DLAYGO=301.501
 S:$D(IVMSEG3) DIC("DR")=".03///NOW;.07////^S X=IVMSEG2;10////^S X=IVMSEG1;11////^S X=IVMSEG3"
 K DD,DO D FILE^DICN K DIC,DLAYGO
 Q:Y'>0
 S IVMI=DA(1),IVMJ=+Y
 ; Patch IVMB*2*111 automatically files the record into the buffer file
 ; and removes the notification bulletin to IVM and the segment from
 ; file 301.501
 K DA,X,Y
 S IVMIN1=$$GETIN1^IVMLINS1(IVMI,IVMJ),IVMADD=$P(IVMIN1,U,5)
 D TRANSFER^IVMLINS3(1),IVMQ^IVMLINS1
 Q
 ;
