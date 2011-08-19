IVMPREC1 ;ALB/SEK/BRM - PROCESS INCOMING HL7 (ACK) MESSAGES ; 07/28/2003
 ;;2.0;INCOME VERIFICATION MATCH;**9,17,26,52,34,72,82,129**; 21-OCT-94;Build 4
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; This routine will process ACK HL7 messages received from the
 ; IVM center.
 ;
ACK ; - Receive ACK Message from IVM Center stored in ^TMP("HLR".
 ;   If 1st segment is BHS then set(s) of MSH, MSA(AE) will follow
 ;   indicating error(s) in transmission received by IVM Center
 ;   If 1st segment is MSH than MSA (AA) indicating batch or individual
 ;   query was received ok.  MSA (AE) indicates error in transmission of
 ;   individual query.
 ; 
 ; - When acknowledgment code = "AA" (application accept)
 ;   Stuff 1 into STATUS field (.03) of ^IVM(301.6 indicating IVM Center
 ;   has received transmission.  
 ;
 K HLNODE,IVMRTN,SEGCNT,CNT
 S IVMRTN="IVMPREC1"
 S HLFS=HL("FS"),HLQ=HL("Q"),HLECH=HL("ECH")
 K ^TMP($J,IVMRTN)
 F SEGCNT=1:1 X HLNEXT Q:HLQUIT'>0  D
 . S CNT=0,^TMP($J,IVMRTN,SEGCNT,CNT)=HLNODE
 . F  S CNT=$O(HLNODE(CNT)) Q:'CNT  D
 . . S ^TMP($J,IVMRTN,SEGCNT,CNT)=HLNODE(CNT)
 S HLDA=HLMTIEN
 K HLNODE,SEGCNT,CNT
 ;
 S IVMSEG=$G(^TMP($J,IVMRTN,1,0))
 I IVMSEG="" G ACKQ
 I $P(IVMSEG,HLFS)'="BHS",$P(IVMSEG,HLFS)'="MSH" G ACKQ
 ;
 ; - process batches of acknowledges
 I $P(IVMSEG,HLFS)="BHS" D AE G ACKQ
 ;
 ; - process MSH MSA message
 S IVMSEG=$G(^TMP($J,IVMRTN,2,0))
 I $P(IVMSEG,HLFS)'="MSA" G ACKQ
 S IVMADDT=$P(IVMSEG,HLFS,3)
 I $P(IVMSEG,HLFS,2)="AA" D  G ACKQ
 .F IVMDA=0:0 S IVMDA=$O(^IVM(301.6,"AE",IVMADDT,IVMDA)) Q:'IVMDA  I $$SETSTAT^IVMTLOG(IVMDA,1)
 ;
 I $P(IVMSEG,HLFS,2)="AE" D  G ACKQ
 .S IVMMCI=$P(IVMSEG,HLFS,3)
 .S IVMEM=$P(IVMSEG,HLFS,4)
 .S IVMDA=$O(^IVM(301.6,"AE",IVMADDT,"")) I 'IVMDA D OTH Q
 .I $$SETSTAT^IVMTLOG(IVMDA,3,IVMEM)
 ;
ACKQ ;
 K ^TMP($J,IVMRTN)
 K DA,DIE,DR,IVMADDT,IVMI,IVMCT,IVMDA,IVMMCI,IVMEM,IVMNAME,IVMPAT,IVMRTN,IVMSEG,IVMSSN,IVMTEXT,XMSUB
 ;
 Q
 ;
AE ; - When acknowledgment code = "AE" (application error)
 ;   Stuff 3 into STATUS field(.03), error message into ERROR MESSAGE
 ;   field(.04), and 1 (NEW) into the ERROR PROCESSING STATUS field.
 ;   Stuff 1 into STATUS field(.03) for transmissions (no 'AE' code
 ;   received) received by IVM Center.
 ;
 N Z07FLG,Z07RET
 S IVMI=0 F  S IVMI=$O(^TMP($J,IVMRTN,IVMI)) Q:'IVMI  S IVMSEG=$G(^(IVMI,0)) D
 .D:$E(IVMSEG,1,3)="MSH"
 ..S Z07RET=0
 ..I $P(IVMSEG,HLFS,9)["ORU~Z07" S Z07FLG=1 Q
 ..K Z07FLG
 .Q:IVMSEG']""!($E(IVMSEG,1,3)'="MSA")!($P(IVMSEG,HLFS,2)'="AE")
 .S IVMMCI=$P(IVMSEG,HLFS,3)
 .S IVMEM=$P(IVMSEG,HLFS,4)
 .S IVMDA=$O(^IVM(301.6,"ADS",IVMMCI,"")) I 'IVMDA D  Q:'Z07RET
 ..I $D(Z07FLG) D  Q
 ...S Z07RET=$$Z07CHK(IVMI,IVMMCI,IVMEM)
 ...S:Z07RET IVMDA=$O(^IVM(301.6,"ADS",IVMMCI,""))
 ..D OTH
 .I $$SETSTAT^IVMTLOG(IVMDA,3,IVMEM)
 ;
 ; - update messages in batch with no error
 F IVMDA=0:0 S IVMDA=$O(^IVM(301.6,"AE",+$G(IVMMCI),IVMDA)) Q:'IVMDA  I $$SETSTAT^IVMTLOG(IVMDA,1)
 Q
 ;
OTH ; Generate message for errors other than Full/Initial Transmissions.
 N IVMRMM,IVMNAM,IVMPID,IVMMCID,IVMTMP,HLDA,HLDAT,HLSEG,DIC,DR,DA,DIQ
 S (IVMNAM,IVMPID,HLDA,IVMTMP)=""
 S HLDA=$O(^HL(772,"C",$P($G(IVMMCI),"-"),0))
 Q:+$G(HLDA)'>0
 Q:'$D(^HL(772,+HLDA,0))
 S DIC="^HL(772,",DR=200,DA=HLDA,DR(200.02)=.01,DA(200.02)=17,DIQ="HLDAT"
 D EN^DIQ1
 F  S IVMTMP=$O(HLDAT(772,HLDA,200,IVMTMP)) Q:((IVMTMP="")!($G(HLSEG)="PID"))  D
 .S HLSEG=$P($G(HLDAT(772,HLDA,200,IVMTMP)),"^")
 .I HLSEG="MSH" S IVMMCID=$P($G(HLDAT(772,HLDA,200,IVMTMP)),"^",10)
 .D:HLSEG="PID"
 ..;Find PID segment for the same message control ID only
 ..I IVMMCID'=IVMMCI S HLSEG="NOT CORRECT PID" Q
 ..; If PID segment was split, reconnect records
 ..I $L($G(HLDAT(772,HLDA,200,IVMTMP)))=245,$L($G(HLDAT(772,HLDA,200,IVMTMP)),U)<20 S HLDAT(772,HLDA,200,IVMTMP)=$$REBLDPID("HLDAT(772,"_HLDA_",200)",IVMTMP)
 ..S IVMNAM=$P($G(HLDAT(772,HLDA,200,IVMTMP)),"^",6)  ;PATIENT NAME
 ..S IVMNAM=$P(IVMNAM,"~")_", "_$P(IVMNAM,"~",2)
 ..S IVMPID=$P($G(HLDAT(772,HLDA,200,IVMTMP)),"^",20)  ;SSN
 ..;S IVMPID=$P(IVMPID,"~")
 ..S IVMPID=$E(IVMPID,1,3)_"-"_$E(IVMPID,4,5)_"-"_$E(IVMPID,6,9)
 ..S XMSUB="ERROR MESSAGE FROM THE HEC"
 ..S IVMTEXT(1)="An Insurance Confirmation message or a Billing/Collections Transmission"
 ..S IVMTEXT(2)="was rejected by the Health Eligibility Center with the following error:"
 ..S IVMTEXT(3)=" ",IVMTEXT(4)=IVMEM,IVMTEXT(5)=" "
 ..S IVMTEXT(6)="NAME: "_IVMNAM
 ..S IVMTEXT(7)="PID : "_IVMPID,IVMTEXT(8)=" "
 ..S IVMRMM=$$MMN^IVMPTRN4($P(IVMMCI,"-"))
 ..S IVMTEXT(9)="Mailman Message # of Acknowledged Transmission: "_$S(IVMRMM:IVMRMM,1:"<unknown>")
 ..S IVMTEXT(10)=" "
 ..S IVMTEXT(11)="If you are unable to find the source of this problem,"
 ..S IVMTEXT(12)="please contact your ISC Support Group or the HEC."
 ..D MAIL^IVMUFNC()
 Q
 ;
Z07CHK(CURSEQ,CURMCI,CUREM) ; Function ;
 ; INPUT
 ;      CURSEQ : Current Sequence # reviewing in batch
 ;      CURMCI : Current Message Control ID reviewing in batch
 ;      CUREM  : Current Error Message reviewing in batch
 ;
 ; Check for duplicate ACK sequence on the same batch
 N SEQ,CHKSEG,CHKSEGN,DUP
 S (SEQ,DUP)=0
 F  S SEQ=$O(^TMP($J,IVMRTN,SEQ)) Q:SEQ=""  D
 . S CHKSEG=^TMP($J,IVMRTN,SEQ,0),CHKSEGN=$E(CHKSEG,1,3)
 . Q:CHKSEGN'="MSA"
 . Q:SEQ=CURSEQ
 . S:$P(CHKSEG,"^",3)=CURMCI DUP=1
 I DUP Q "0^DUPLICATE SEQUENCE ON ACK BATCH"
 ;
 ; Check to see if ADS x-ref missing in last 1000 entries
 N END,IEN,MCI,FND,LOG,RET,TMPCTR
 S FND=0,RET="",IEN=" "
 F TMPCTR=1:1:1000 S IEN=$O(^IVM(301.6,IEN),-1) Q:+IEN=0  D  Q:FND
 . S MCI=$P(^IVM(301.6,IEN,0),"^",5)
 . I MCI=CURMCI S FND=1 D  Q
 . . S LOG=^IVM(301.6,IEN,0)
 . . I $P(LOG,"^",3)=3&($P(LOG,"^",4)=CUREM) S RET="0^ACK TO THIS SEQUENCE HAS ALREADY BEEN PROCESSED" Q
 . . S ^IVM(301.6,"ADS",CURMCI,IEN)="" S RET="1^ADS X-REF MISSING.  X-REF HAS BEEN RESET."
 Q RET
 ;
REBLDPID(ARRAY,SEQ) ; Reconnect the pieces of the PID segment
 ; ARRAY contains the HL7 message reference to be accessed indirectly
 ;  It should look similar in structure to the HL7 message text in
 ;  file 772
 ; @ARRAY@(SEQ) should = the first 'PID' segment record text and should
 ; be 245 characters long
 N PID,SEQX
 S PID=$G(@ARRAY@(SEQ)),SEQX=SEQ
 G:$L(PID)'=245 PIDQ
 F  S SEQX=$O(@ARRAY@(SEQX)) Q:SEQX=""  I $G(@ARRAY@(SEQX))'="" S PID=PID_$G(@ARRAY@(SEQX)) Q
PIDQ Q PID
 ;
