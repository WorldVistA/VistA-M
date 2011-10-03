RCDPRPLU ;WISC/RFJ-receipt profile utilities ;1 Jun 99
 ;;4.5;Accounts Receivable;**114,173**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
CHECKREC(RECTDA) ;  check the receipt to stop edit/change if approved
 ;  return 0^message to stop edit/change
 ;         1         to continue
 N MESSAGE,RESULT
 ;
 ;  closed
 I $P($G(^RCY(344,RECTDA,0)),"^",14)=0 Q "0^Receipt has been PROCESSED to AR and FMS."
 I $$EDILB^RCDPEU(RECTDA)=1,$P($G(^RCY(344,RECTDA,0)),U,6) Q "0^EDI 3rd Party Lockbox deposit type receipt."
 ;  lockbox
 ;  this screen was removed so sites could hand enter lockbox receipts
 ;I $P($G(^RC(341.1,+$P($G(^RCY(344,RECTDA,0)),"^",4),0)),"^",2)=12 Q "0^Lockbox type receipt."
 ;  open
 Q 1
 ;
 ;
LOCKREC(RECTDA) ;  lock the receipt, call only from listmanager options
 ;  if receipt not passed, return 2
 I 'RECTDA Q 2
 N RESULT
 S RESULT=1
 L +^RCY(344,RECTDA):5
 I '$T D
 .   S VALMSG="Another user is editing the receipt."
 .   D WRITE(VALMSG)
 .   S RESULT=0
 Q RESULT
 ;
 ;
WRITE(MESSAGE) ;  write message on screen with delay
 N %
 W !,MESSAGE
 W !,"press RETURN to continue: "
 R %:DTIME
 Q
 ;
 ;
MAILMSG(RCRECTDA,ACTION) ;  mail a message to supervisor key holders
 N %,LINE,VALMHDR,VALMSG,XMDUZ,XMZ,YY,XMSUB,XMTEXT,XMY
 K ^TMP($J,"RCDPRPLU")
 S LINE=0
 ;
 ;  ---- start build mailman message ----
 D SETLINE("Sent to: PRCAY PAYMENT SUP security key holders")
 D SETLINE(" ")
 ;
 ;  build the header line
 D HDR^RCDPRPLM
 F %=1:1 Q:'$D(VALMHDR(%))  D SETLINE(VALMHDR(%))
 ;
 D SETLINE(" ")
 D SETLINE("This receipt was approved and the following action occurred:")
 D SETLINE("  ACTION: "_ACTION)
 D SETLINE("      BY: "_$P(^VA(200,DUZ,0),"^"))
 ;  ---- end build mailman message ----
 ;
 S XMSUB="Receipt Processing Audit"
 S XMDUZ="Accounts Receivable Package"
 S XMTEXT="^TMP($J,""RCDPRPLU"","
 S %=0 F  S %=$O(^XUSEC("PRCAY PAYMENT SUP",%)) Q:'%  S XMY(%)=""
 D ^XMD
 K ^TMP($J,"RCDPRPLU")
 Q
 ;
 ;
SETLINE(MESSAGE) ;  set the line for the mail message
 S LINE=LINE+1
 S ^TMP($J,"RCDPRPLU",LINE)=MESSAGE
 Q
