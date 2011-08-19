EASPREC2 ;ALB/KCL - ROUTE INCOMING HL7 (ORU) MESSAGES BY EVENT TYPE ; 11/22/02 1:56pm
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**23**; 21-OCT-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; This routine will process (ORU) HL7 messages received from the Edb
 ; via e*Gate. Currently only the Z06 is being transmitted.
 ; Event type code indicating type of transmission is in the BHS segment.
 ; Routines based on type will be called to process these messages.  For
 ; each batch an ACK will be sent to the Edb indicating errors found.
 ; If any errors are found a batch message with AE(indicating error(s))
 ; is sent.  If no errors only a MSH and MSA with AA(no errors) is sent.
 ; The following event type codes are processed in the following 
 ; routine(s):
 ;
 ;    EVENT CODE    TRANSMISSION TYPE             PROCESSING ROUTINE
 ;    ==============================================================
 ;       Z06        MEANS TEST TRANSMISSIONS           EASPREC7
 ;
 ;
ORU ; - Receive Observational Results Unsolicited Message
 ;
 N DIC,%,%H,%I D NOW^%DTC S HLDT=%
 K HLERR,IVMSEG1,IVMSEG2,IVMSEG3
 S (HLEVN,IVMCT,IVMERROR,IVMCNTR)=0
 ; Make sure POSTMASTER DUZ instead of DUZ of Person who
 ; started Incoming Logical Link
 S DUZ=.5
 ;
 ; - get incoming segment from HL7 (#772) file
 N IVMRTN,SEGCNT,CNT,STATION,HLEID,HLEIDS
 S IVMRTN="IVMPREC2" K ^TMP($J,IVMRTN),^TMP("HLA",$J),^TMP("HLS",$J)
 F SEGCNT=1:1 X HLNEXT Q:HLQUIT'>0  D
 . S CNT=0
 . S ^TMP($J,IVMRTN,SEGCNT,CNT)=HLNODE
 . F  S CNT=$O(HLNODE(CNT)) Q:'CNT  S ^TMP($J,IVMRTN,SEGCNT,CNT)=HLNODE(CNT)
 ;
 S HLDA=HLMTIEN
 S IVMSEG=$G(^TMP($J,IVMRTN,1,0)) I IVMSEG']"" G ORUQ
 ;
 ; - check for BHS 
 I $E(IVMSEG,1,3)'="BHS" G ORUQ
 ;
 ; - get batch control id
 S HLFS=HL("FS")
 S HLECH=HL("ECH")
 S HLQ=$G(HL("HLQ")) S:HLQ="" HLQ=""""""
 S IVMHLMID=$P(IVMSEG,HLFS,11)
 S STATION=$P(IVMSEG,HLFS,6)
 ;
 ; - get event type code
 S IVMETC=$P($P(IVMSEG,HLFS,9),$E(HLECH),3)
 S IVMETC=$P(IVMETC,$E(HLECH,2),2)
 S HLEID="EAS EDB ORU-"_IVMETC_" SERVER"
 S HLEID=$O(^ORD(101,"B",HLEID,0)),HLEIDS=""
 I HLEID]"" S HLEIDS=$O(^ORD(101,HLEID,775,"B",0))
 ;
 ; - process the message according to the event type code
 S IVMDO=$S(IVMETC="Z06":"EN^EASPREC7",1:"ORUQ")
 D @IVMDO
 Q:IVMDO="ORUQ" 
 ;
 ; - if no error send ACK 'AA' message
 S HLMTN="ACK"
 K HLARYTYP,HLMTIENA,HLRESLTA,HLP
 I 'IVMERROR S HLMID=IVMHLMID D ACK^IVMPREC S HLARYTYP="GM",HLMTIENA=""
 I IVMERROR S HLARYTYP="GB",HLMTIENA=HLMTIEN  ;HLMTIEN comes from ACK^IVMPREC
 K ^TMP("HLA",$J) M ^TMP("HLA",$J)=^TMP("HLS",$J) K ^TMP("HLS",$J)
 D GENACK^HLMA1(HLEID,HLMTIENS,HLEIDS,HLARYTYP,1,.HLRESLTA,HLMTIENA,.HLP)
 ;
ORUQ ;
 K DFN,IVMCNTR,IVMCT,IVMDA,IVMERR,IVMERROR,IVMHLMID,IVMNDE,IVMPTID
 K IVMSEG,IVMSEG1,IVMSEG2,IVMSEG3,IVMTEXT,XMSUB
 K HLARYTYP,HLMTIENA,HLRESLTA,HLP
 K ^TMP($J,IVMRTN),^TMP("HLA",$J),^TMP("HLS",$J)
 Q
