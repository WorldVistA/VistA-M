BPSJHLI ;BHAM ISC/LJF - Incoming HL7 E-PHARM messages ;21-NOV-2003
 ;;1.0;E CLAIMS MGMT ENGINE;**1,20**;JUN 2004;Build 27
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;**Program Description**
 ;  This program processes incoming HL7 message.
 ;
EN ;  Starting point - put message into a TMP global
 N SEGCNT,CNT,SEGMT,EVENT,MSG,MCT,FSHLI
 N HCT,ERRFLAG,BPSJSEG,BPSFILE1,BPSFLN1,IDUZ,APP,HLECH,HLFS,HLQ,SEG
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
 S HLECH=$$GET1^DIQ(771,$$GET1^DIQ(101,$G(HL("EID")),770.1,"I"),101)
 I HLECH="" S HLECH=$G(HL("ECH"))
 S HLFS=$G(HL("FS"),"|"),HLQ=$G(HL("Q"),""),HCT=1,ERRFLAG=0,APP=""
 F  D  Q:'HCT  I ERRFLAG Q
 . K BPSJSEG S HCT=$O(^TMP($J,"BPSJHLI",HCT))
 . D SPAR^BPSJUTL(.HL,.BPSJSEG,HCT) S SEG=$G(BPSJSEG(1))
 . ;
 . I SEG="MFI" D  Q
 .. S BPSFILE1=$G(BPSJSEG(2))
 .. S BPSFLN1=$P(BPSFILE1,"^")
 .. I ",366.01,366.02,366.03,"[(","_BPSFLN1_",") D  Q
 ... S APP="TABLE"
 ... ;
 ... ; Set non-human user to POSTMASTER
 ... S IDUZ=.5
 ;
 I EVENT="MFK^M01",APP="TABLE" G EXIT
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
