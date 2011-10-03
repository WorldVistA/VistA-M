DGQEACK ;ALB/JFP - Process VIC ACK message (Batch/Single) ; 09/01/96
 ;;V5.3;REGISTRATION;**73**;DEC 11,1996
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; This routine will process both single and batch acknowledgements
 ; Format of HL7 message:
 ; 
 ; -- Batch         Single
 ;     BHS           MSH
 ;    [MSH           MSA
 ;     MSA]
 ;     BTS
 ;Note:  This code does not handle the optional ERR segment
 ;
 ;Input  : All variables set by HL7 package
 ;Output :
 ;
EN ; - entry point to process HL7 ACK message
 ; -- Declare variables
 N EXCARR,DGQESEG,BCID,MCID,HLMSG,ACKCODE
 N REFFLG,DELFLG,DGQEND,J,I,X
 N REASON,DGQEMSG,DONE
 ;
 ; -- define exception array
 S EXCARR="^TMP(""DGQE-ACK"","_$J_",""EXC"")"
 K @EXCARR
 ;
 I '$D(HL("FS")) S HL("FS")="^"
 S HLFS=HL("FS")
 S (HLMSG,DONE)=0
BLD ; -- Builds HL7 message text for error processing
 D BLDMSG
START ; -- Get first segment
 D NEXT Q:DONE
 ; -- Check for header message (BHS or MSH)
 I DGQESEG="MSH" D SINGLE Q
 I DGQESEG="BHS" D BATCH Q
 ; -- Wrong segment
 S HLMSG="-1^Missing BHS or MSH segment on ACK, segment received was: "_DGQESEG
 D NOTIFY(HLMSG)
 Q
 ;
SINGLE ; -- Parse single ACK message
 D NEXT Q:DONE
 D MSA
 ; -- Delete entry from 39.4, acknowledged
 S:MCID'="" DELFLG=$$DEL^DGQEHL74(MCID)
 K @EXCARR
 Q
 ;
BATCH ; -- Parse batch ACK message
 ; -- get batch control ID from BHS segment
 S BCID=$P(DGQEND,HLFS,11)
 ; -- get next segment
 D NEXT Q:DONE
 ; -- Check to see if all entries in batch successful
 I DGQESEG="BTS" D DELACK Q
 I DGQESEG'="MSH" D  Q
 .S HLMSG="-1^Missing MSH or BTS segment in processing ACK, segment received was: "_DGQESEG
 .D NOTIFY(HLMSG)
 .D DELACK
 ; -- otherwise process exception batch
 D EXC
 ; -- Delete all transactions in batch
 D DELACK
 K @EXCARR
 Q
 ;
EXC ; -- Processes of exceptions in batch ACK
 D MSH Q:DONE
 D NEXT Q:DONE
 D MSA Q:DONE
 ; -- Loop through remaining entries
 F  D NEXT D  Q:DONE
 .Q:DONE
 .I DGQESEG="BTS" S DONE=1 Q
 .D MSH Q:DONE
 .D NEXT Q:DONE
 .D MSA Q:DONE
 Q
 ; 
MSH ; -- Process MSH segment
 I DGQESEG'="MSH" D  Q
 .S HLMSG="-1^Missing MSH segment on ACK, segment received was: "_DGQESEG
 .D NOTIFY(HLMSG)
 .S DONE=1
 Q
 ;
MSA ; -- Process MSA segment
 I DGQESEG'="MSA" D  Q
 .S HLMSG="-1^Missing MSA segment on ACK, segment received was: "_DGQESEG
 .D NOTIFY(HLMSG)
 .S DONE=1
 ; -- Extract Segment MSA segment Data
 S ACKCODE=$P(DGQEND,HLFS,1)
 S MCID=$P(DGQEND,HLFS,2)
 ; -- Check for error
 I ACKCODE'="AA" D  Q
 .S @EXCARR@(MCID)=""
 .S REASON="-1^"_$P(DGQEND,HLFS,3)
 .S REFFLG=$$REJ^DGQEHL74(MCID,"1",REASON)
 .D NOTIFY(REASON)
 Q
 ;
DELACK ; -- Deletes all entries from 39.4, related to message ID
 Q:BCID=""
 N ID
 S ID=BCID_"-0"
 F  S ID=$O(^VAT(39.4,"B",ID)) Q:$P(ID,"-")'=BCID  D
 .S:ID'="" DELFLG=$$DEL^DGQEHL74(ID)
 Q
 ;
NEXT ; -- Gets the next HL7 segment to process
 S (DGQESEG,DGQEND)=""
 X HLNEXT
 I HLQUIT'>0 S DONE=1 Q
 S DGQEND=HLNODE
 ; -- Check for segment lengths greater than 245
 I $D(HLNODE(1)) D
 .S J=0
 .F  S J=$O(HLNODE(J)) Q:'J  S DGQEND=DGQEND_HLNODE(J)
 ; -- Pull off segment
 S DGQESEG=$E(DGQEND,1,3)
 S DGQEND=$P(DGQEND,HLFS,2,9999)
 Q
 ;
BLDMSG ; -- GET MESSAGE TEXT
 F I=1:1 X HLNEXT Q:(HLQUIT'>0)  D
 .S DGQEMSG(I,1)=HLNODE
 .; -- Check for segment lengths greater than 245
 .S X=0 F  S X=+$O(HLNODE(X)) Q:('X)  S DGQEMSG(I,(X+1))=HLNODE(X)
 Q
 ;
NOTIFY(REASON) ; -- Sends error bulletin on negative acknowledgment
 ;Input:   REASON    - problem with acknowledgment
 ;         DGQEMSG() - Array containing HL7 message that was received
 ;Output:  None
 ;
 ; -- Check input, reason in piece 2
 Q:'$D(REASON)
 S REASON=$P($G(REASON),"^",2)
 ; -- Declare variables
 N MSGTXT,XMB,XMTEXT,XMY,XMDUZ,XMDT,XMZ,LINE
 ; -- Send message text
 S MSGTXT(1)="Acknowledgment received from photo capture station"
 S MSGTXT(2)="with the following problem:"
 S MSGTXT(3)=" "
 S MSGTXT(4)=" ** "_REASON
 ; -- Check to see if hl7 message is available for display
 N X,Y
 I $D(DGQEMSG(1)) D
 .S MSGTXT(5)=" "
 .S MSGTXT(6)="The message received looks like this: "
 .S MSGTXT(7)=" "
 .S LINE=8,X=0
 .F  S X=+$O(DGQEMSG(X)) Q:('X)  D
 ..S Y=0
 ..F  S Y=+$O(DGQEMSG(X,Y)) Q:('Y)  D
 ...S MSGTXT(LINE)=DGQEMSG(X,Y)
 ...S LINE=LINE+1
 ; -- Send bulletin subject
 S XMB(1)="** Problem with ACK for VIC **"
 ; -- Deliver bulletin
 S XMB="DGQE PHOTO CAPTURE"
 S XMTEXT="MSGTXT("
 D ^XMB
 Q
 ;
END ; -- End of code
 Q
