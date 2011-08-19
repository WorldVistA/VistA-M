BPSJHLI ;BHAM ISC/LJF - Incoming HL7 E-PHARM messages ;21-NOV-2003
 ;;1.0;E CLAIMS MGMT ENGINE;**1**;JUN 2004
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;**Program Description**
 ;  This program processes incoming HL7 message.
 ;
EN ;  Starting point - put message into a TMP global
 N SEGCNT,CNT,SEGMT,EVENT,MSG,MCT,FSHLI
 ;
 K ^TMP($J,"BPSJHLI") S MCT=0
 F SEGCNT=1:1 X HLNEXT Q:HLQUIT'>0  D
 . S CNT=0,^TMP($J,"BPSJHLI",SEGCNT,CNT)=HLNODE
 . F  S CNT=$O(HLNODE(CNT)) Q:'CNT  D
 .. S ^TMP($J,"BPSJHLI",SEGCNT,CNT)=HLNODE(CNT)
 ;
 ; Check MSH seg
 S SEGMT=$G(^TMP($J,"BPSJHLI",1,0))
 S FSHLI=$G(HL("FS")) I FSHLI="" S (FS,FSHLI)=$E(SEGMT,4)
 ;
 I $E(SEGMT,1,3)'="MSH" D  D MSG^BPSJUTL(.MSG,"BPSJHLI") G EXIT
 . S MCT=MCT+1,MSG(MCT)="MSH Segment is not the first segment found"
 ;
 S EVENT=$P(SEGMT,FSHLI,9)
 ;
 ;  Acknowledgement Processing
 I EVENT="MFK^M01" D EN^BPSJACK(.HL) G EXIT
 ;
 ;  Table Update Processing for Payer Sheets
 I EVENT="MFN^M01" D
 . S HL("HLMTIENS")=$G(HLMTIENS)
 . D EN^BPSJHLT(.HL)
 ;
EXIT ;
 K ^TMP($J,"BPSJHLI"),SEGCNT,CNT,HL,HLREC,HLNEXT,HLNODE
 Q
