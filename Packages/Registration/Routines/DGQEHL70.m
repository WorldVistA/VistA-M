DGQEHL70 ;ALB/JFP - VIC HL7 Utility Bulletins; 09/01/96
 ;;V5.3;REGISTRATION;**73**;DEC 11,1996
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
ERRBULL(REASON) ; -- Sends error bulletin
 ;
 ;Input:   REASON - Why transmission of data could not be completed
 ;Output:  None
 ;
 ; -- Check input, reason in piece 2
 S REASON=$P($G(REASON),"^",2)
 ; -- Declare variables
 N MSGTXT,XMB,XMTEXT,XMY,XMDUZ,XMDT,XMZ
 ; -- Send message text
 S MSGTXT(1)="Transmission of data to photo capture station"
 S MSGTXT(2)=" "
 S MSGTXT(3)="could not be completed for the following reason:"
 S MSGTXT(4)=" "
 S MSGTXT(5)=" "_REASON
 ; -- Send bulletin subject
 S XMB(1)="** Transmission of data to Photo station not complete **"
 ; -- Deliver bulletin
 S XMB="DGQE PHOTO CAPTURE"
 S XMTEXT="MSGTXT("
 D ^XMB
 Q
 ;
CMPLBULL(SENT,ERRARY) ;Send completion bulletin
 ;
 ;Input  : SENT - Number of encounters sent to NPCDB (Defaults to 0)
 ;         ERRARRY - Array containing list of transactions that
 ;                   could not be transmitted (full global reference)
 ;
 ;         ERRARY(Ptr) = Reason
 ;             Ptr - Pointer to entry in Patient file (#2)
 ;             Reason - Why the encounter could not be transmitted
 ;Output : None
 ;
 ; -- Check input
 S SENT=+$G(SENT)
 S ERRARY=$G(ERRARY)
 S:(ERRARY="") ERRARY="^TMP(""DGQE-XMIT-BLD"","_$J_",""ERRORS"")"
 ; -- Declare variables
 N MSGTXT,XMB,XMTEXT,XMY,XMDUZ,XMDT,XMZ,XMITPTR,LINE
 N NAME,TMP,SSN,PATZND,CNT
 S MSGTXT="^TMP(""DGQE-XMIT-BLD"","_$J_",""BULLETIN"")"
 K @MSGTXT
 ; -- Put number of transactions transmitted into message text
 S @MSGTXT@(1)="Transmission of data to the Photo Capture Station completed."
 S @MSGTXT@(2)="A total of "_SENT_" transactions were sent."
 S @MSGTXT@(3)=" "
 ; -- Put nontransmitted encounter information into message text
 I (+$O(@ERRARY@(0))) D
 .S @MSGTXT@(4)=" "
 .S @MSGTXT@(5)="The following transactions could not be sent:"
 .S @MSGTXT@(6)=" "
 .S LINE=7
 .S XMITPTR=0
 .S CNT=0
 .F  S XMITPTR=+$O(@ERRARY@(XMITPTR)) Q:('XMITPTR)  D
 ..S CNT=CNT+1
 ..; -- Get patient's name & SSN - truncate name to 24 characters
 ..S PATZND=$G(^DPT(XMITPTR,0))
 ..S NAME=$E($P(PATZND,"^",1),1,24)
 ..S:(NAME="") NAME="Unknown Patient"
 ..S SSN=$E($P(PATZND,"^",9),6,10)
 ..S:(SSN="") SSN="????"
 ..; -- Put info into bulletin
 ..S TMP=CNT_" - "
 ..S TMP=$$INSERT^SCDXUTL1(NAME,TMP,5)
 ..S TMP=$$INSERT^SCDXUTL1("("_SSN_")",TMP,29)
 ..S @MSGTXT@(LINE)=TMP
 ..; -- insert reason
 ..S @MSGTXT@(LINE+1)=$G(@ERRARY@(XMITPTR))
 ..S @MSGTXT@(LINE+2)=" "
 ..S LINE=LINE+3
 ; -- Set bulletin subject
 S XMB(1)="Transmission of data to Photo Capture station completed"
 ; -- Deliver bulletin
 S XMB="DGQE PHOTO CAPTURE"
 S XMTEXT=$P(MSGTXT,")",1)_","
 D ^XMB
 ; -- Done: (clean up and quit)
 K @MSGTXT
 Q
 ;
END ; -- End of code
 Q
 ;
