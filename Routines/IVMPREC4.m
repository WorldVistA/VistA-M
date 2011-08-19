IVMPREC4 ;ALB/KCL - PROCESS INCOMING (Z08 EVENT TYPE) HL7 MESSAGES ; 3/6/01 4:38pm
 ;;2.0;INCOME VERIFICATION MATCH;**34**;21-OCT-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; This routine will process batch ORU Case Status(event type Z08) HL7
 ; messages received from the IVM center.  Format of batch:
 ;       BHS
 ;       {MSH
 ;        PID
 ;        ZIV
 ;       }
 ;       BTS
 ;
EN ; entry point to process case status messages 
 ;
 F IVMDA=1:0 S IVMDA=$O(^TMP($J,IVMRTN,IVMDA)) Q:'IVMDA  S IVMSEG=$G(^(IVMDA,0)) I $E(IVMSEG,1,3)="MSH" D
 .K HLERR
 .S HLMID=$P(IVMSEG,HLFS,10) ; message control id from MSH
 .S IVMDA=$O(^TMP($J,IVMRTN,IVMDA)),IVMSEG=$G(^(+IVMDA,0)) I $E(IVMSEG,1,3)'="PID" D  Q
 ..S HLERR="Missing PID segment" D ACK^IVMPREC
 .S DFN=$P($P(IVMSEG,HLFS,4),$E(HLECH),1)
 .I ('DFN!(DFN'=+DFN)!('$D(^DPT(+DFN,0)))) D  Q
 ..S HLERR="Invalid DFN" D ACK^IVMPREC
 .I $P(IVMSEG,HLFS,20)'=$P(^DPT(DFN,0),"^",9) D  Q
 ..S HLERR="Couldn't match IVM SSN with DHCP SSN" D ACK^IVMPREC
 .S IVMDA=$O(^TMP($J,IVMRTN,IVMDA)),IVMSEG=$G(^(+IVMDA,0)) I $E(IVMSEG,1,3)'="ZIV" D  Q
 ..S HLERR="Missing ZIV segment" D ACK^IVMPREC
 .S IVMSEG=$P(IVMSEG,HLFS,2,999),IVMIY=$P(IVMSEG,HLFS,2)
 .S IVMIY=$$FMDATE^HLFNC(IVMIY) I $E(IVMIY,4,7)'="0000"!($E(IVMIY,1,3)<292) S HLERR="Invalid Income Year" D ACK^IVMPREC Q
 .I $P(IVMSEG,HLFS,8)'=1 D  Q
 ..S HLERR="Case Status not 1" D ACK^IVMPREC
 .D CLOSE^IVMPTRN1(IVMIY,DFN,1,4)
 Q
