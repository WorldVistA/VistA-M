RCDPDPLU ;WISC/RFJ-deposit profile utilities ;1 Jun 99
 ;;4.5;Accounts Receivable;**114,173**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
CHECKDEP(DEPTDA) ;  check the deposit to stop edit/change if approved
 ;  return 0^message to stop edit/change
 ;         1         to continue
 N MESSAGE,RECTDA,RESULT
 ;
 ;  already confirmed, status = 3 confirmed
 I $P($G(^RCY(344.1,DEPTDA,0)),"^",12)=3 Q "0^Deposit has been confirmed."
 ;  lockbox
 S RECTDA=$O(^RCY(344,"AD",$P(^RCY(344.1,DEPTDA,0),"^"),0))
 I RECTDA,$P($G(^RC(341.1,+$P($G(^RCY(344,RECTDA,0)),"^",4),0)),"^",2)=12 Q "0^Lockbox type deposit."
 I RECTDA,$$EDILB^RCDPEU(RECTDA)=1 Q "0^EDI Lockbox type deposit."
 ;  open
 Q 1
 ;
 ;
LOCKDEP(DEPTDA) ;  lock the deposit, call only from listmanager options
 ;  if deposit not passed, return 2
 I 'DEPTDA Q 2
 N RESULT
 S RESULT=1
 L +^RCY(344.1,DEPTDA):5
 I '$T D
 .   S VALMSG="Another user is editing the deposit."
 .   D WRITE^RCDPRPLU(VALMSG)
 .   S RESULT=0
 Q RESULT
 ;
 ;
MAILMSG(RCDEPTDA,ACTION) ;  mail a message to supervisor key holders
 N %,LINE,VALMHDR,VALMSG,XMDUZ,XMZ,YY
 K ^TMP($J,"RCDPDPLU")
 S LINE=0
 ;
 ;  ---- start build mailman message ----
 D SETLINE("Sent to: PRCAY PAYMENT SUP security key holders")
 D SETLINE(" ")
 ;
 ;  build the header line
 D HDR^RCDPDPLM
 F %=1:1 Q:'$D(VALMHDR(%))  D SETLINE(VALMHDR(%))
 ;
 D SETLINE(" ")
 D SETLINE("This deposit was confirmed and the following action occurred:")
 D SETLINE("  ACTION: "_ACTION)
 D SETLINE("      BY: "_$P(^VA(200,DUZ,0),"^"))
 ;  ---- end build mailman message ----
 ;
 S XMSUB="Deposit Processing Audit"
 S XMDUZ="Accounts Receivable Package"
 S XMTEXT="^TMP($J,""RCDPDPLU"","
 S %=0 F  S %=$O(^XUSEC("PRCAY PAYMENT SUP",%)) Q:'%  S XMY(%)=""
 D ^XMD
 K ^TMP($J,"RCDPDPLU")
 Q
 ;
 ;
SETLINE(MESSAGE) ;  set the line for the mail message
 S LINE=LINE+1
 S ^TMP($J,"RCDPDPLU",LINE)=MESSAGE
 Q
