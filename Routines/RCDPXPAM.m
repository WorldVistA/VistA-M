RCDPXPAM ;WISC/RFJ-auto process payments, message generation ;1 Jun 99
 ;;4.5;Accounts Receivable;**114,153**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
ERROR(RCDPDATE,RCDPXMZ,ERROR) ;  reply to server message with error
 ;  pass ^tmp($j,"rcdpxpay","error",#) for additional/multiple errors
 N LINE,MESSAGE,RCDPERR
 ;
 ;  build error message
 S MESSAGE(1)="This message was received by the Automatic Payment Processing Server"
 S MESSAGE(2)="and was NOT processed because of the following error(s):"
 S MESSAGE(3)=" "
 S MESSAGE(4)=" "
 I ERROR'="" S MESSAGE(4)="  "_ERROR_"." D TRANERR^RCDPXPA1(RCDPDATE,RCDPXMZ,ERROR)
 ;  display multiple errors
 S LINE=4,RCDPERR=0 F  S RCDPERR=$O(^TMP($J,"RCDPXPAY","ERROR",RCDPERR)) Q:'RCDPERR  D
 .   S LINE=LINE+1,MESSAGE(LINE)="  "_^TMP($J,"RCDPXPAY","ERROR",RCDPERR)_"."
 .   D TRANERR^RCDPXPA1(RCDPDATE,RCDPXMZ,^TMP($J,"RCDPXPAY","ERROR",RCDPERR))
 ;
 ;  send message with response
 D MAILRESP(RCDPXMZ,.MESSAGE)
 ;
 ;  set the transmissions status to error
 I $G(RCDPDATE) D TRANSTAT^RCDPXPA1(RCDPDATE,"e")
 Q
 ;
 ;
DUPLCATE(RCDPDATE,SEQUENCE,RCDPXMZ) ;  reply with duplicate warning message
 N MESSAGE,ORIGXMZ
 S ORIGXMZ=$P($G(^RCY(344.2,RCDPDATE,1,SEQUENCE,0)),"^",4) I 'ORIGXMZ S ORIGXMZ="unknown"
 ;  same message sent to server twice
 I ORIGXMZ=RCDPXMZ Q
 ;
 S MESSAGE(1)="* * * * *  W A R N I N G  * * * * *"
 S MESSAGE(2)=" "
 S MESSAGE(3)="This message was received by the Automatic Payment Processing Server"
 S MESSAGE(4)="and is a duplicate sequence number ["_SEQUENCE_"] (line 1, piece 2)."
 S MESSAGE(5)=" "
 S MESSAGE(6)="The Automatic Payment Processing Server will only process the first"
 S MESSAGE(7)="message it receives for a sequence.  The first message for the sequence"
 S MESSAGE(8)="was in mail message number "_ORIGXMZ_" and has been forwarded to you for"
 S MESSAGE(9)="review.  Message number "_ORIGXMZ_" will be used for payment processing."
 S MESSAGE(10)="This message will not be used."
 ;
 I ORIGXMZ D MAILRESP(ORIGXMZ,"") ;  forward original
 D MAILRESP(RCDPXMZ,.MESSAGE)     ;  send response to duplicate
 Q
 ;
 ;
RETRAN ;  ask for retransmission
 N %Z,COUNT,DATA,DATE,MESSAGE,RCDPDA,STATUS,X9,XCNP,XMDUZ,XMZ
 S MESSAGE(1)="The following Automatic Payment(s) have not been processed and need"
 S MESSAGE(2)="to be retransmitted to the Automatic Payment Processing Server."
 S MESSAGE(3)=""
 S MESSAGE(4)="  TranDate    Deposit#    DepositDate    Reason"
 S MESSAGE(5)="  --------    --------    -----------    ------"
 S COUNT=5
 S RCDPDA=0 F  S RCDPDA=$O(^TMP($J,"RCDPXPAY","RETRAN",RCDPDA)) Q:'RCDPDA  D
 .   S DATE=$E($P(RCDPDA,"^"),4,5)_"-"_$E($P(RCDPDA,"^"),6,7)_"-"_$E($P(RCDPDA,"^"),2,3)
 .   S DATA=^TMP($J,"RCDPXPAY","RETRAN",RCDPDA)
 .   I $P(DATA,"^")="" S $P(DATA,"^")="unknown"
 .   I $P(DATA,"^",2)="" S $P(DATA,"^",2)="unknown"
 .   I $P(DATA,"^",3)="" S $P(DATA,"^",3)="unknown"
 .   S $P(DATA,"^")=$E($P(DATA,"^")_"        ",1,8)
 .   S $P(DATA,"^",2)=$E($P(DATA,"^",2)_"           ",1,11)
 .   S $P(DATA,"^",3)=$S($P(DATA,"^",3)="r":"Partial Payment Received",$P(DATA,"^",3)="p":"Partial Payment Processed",1:"Error in Payment Message")
 .   S COUNT=COUNT+1
 .   S MESSAGE(COUNT)="  "_DATE_"    "_$P(DATA,"^")_"    "_$P(DATA,"^",2)_"    "_$P(DATA,"^",3)
 S XMTEXT="MESSAGE("
 S XMSUB="Request Auto Payment Retransmission"
 S XMDUZ="AR Package",XMY("G.RCDP PAYMENTS")=""
 D ^XMD
 Q
 ;
 ;
MAILRESP(RCDPXMZ,MESSAGE) ;  enter response and forward message to mail group
 N %H,%I,%Z,ER,X,X9,XMA,XMC0,XMQF,XMZ,XMZ2,Z
 ;  create response
 I $G(MESSAGE(1))'="" S %=$$ENT^XMA2R(RCDPXMZ,"Automatic Payment Processing Server Response",.MESSAGE,"","AR Package")
 ;  forward original message
 S XMDUZ="AR Package",XMY("G.RCDP PAYMENTS")=""
 S XMZ=RCDPXMZ
 D ENT1^XMD
 Q
 ;
 ;
PROCMSG ;  show the message with processed deposits and receipts
 N %Z,MESSAGE,RCCOUNT,RCDPDATA,RCRECTDA,RCERROR,RCFLAG,RCUNLINK,X9,XCNP,XMDUZ,XMZ
 S MESSAGE(1)="The following Automatic Payment(s) have been processed by the"
 S MESSAGE(2)="Automatic Payment Processing Server."
 S MESSAGE(4)="  Deposit#    Receipt#  FMS Document#   Total Amount  Unlinked Accts"
 S MESSAGE(5)="  --------  ----------  -------------   ------------  --------------"
 S RCCOUNT=5
 I '$O(^TMP($J,"RCDPXPAP","PROCESS",0)) S MESSAGE(6)="  <<none>>",RCCOUNT=6
 S RCRECTDA=0 F  S RCRECTDA=$O(^TMP($J,"RCDPXPAP","PROCESS",RCRECTDA)) Q:'RCRECTDA  D
 .   D DIQ344^RCDPRPLM(RCRECTDA,".01;.06;.15;200;")
 .   S RCUNLINK=+^TMP($J,"RCDPXPAP","PROCESS",RCRECTDA)
 .   S RCCOUNT=RCCOUNT+1
 .   S MESSAGE(RCCOUNT)=$J($G(RCDPDATA(344,RCRECTDA,.06,"E")),10)
 .   S MESSAGE(RCCOUNT)=MESSAGE(RCCOUNT)_$J($G(RCDPDATA(344,RCRECTDA,.01,"E")),12)
 .   S MESSAGE(RCCOUNT)=MESSAGE(RCCOUNT)_$J($G(RCDPDATA(344,RCRECTDA,200,"E")),16)
 .   S MESSAGE(RCCOUNT)=MESSAGE(RCCOUNT)_$J($G(RCDPDATA(344,RCRECTDA,.15,"E")),14,2)
 .   S MESSAGE(RCCOUNT)=MESSAGE(RCCOUNT)_$J(+RCUNLINK,16)
 .   ;  set error flag if receipt did not process (no fms document)
 .   I $G(RCDPDATA(344,RCRECTDA,200,"E"))="" S RCERROR=1
 ;
 ;  show if any receipts need to manually be processed due to errors
 I $G(RCERROR) D
 .   S RCCOUNT=RCCOUNT+1,MESSAGE(RCCOUNT)=" "
 .   S RCCOUNT=RCCOUNT+1,MESSAGE(RCCOUNT)="Warning: The receipts listed above that are missing the FMS Document# did not"
 .   S RCCOUNT=RCCOUNT+1,MESSAGE(RCCOUNT)="completely process due to an error.  Use the Receipt Processing option to view"
 .   S RCCOUNT=RCCOUNT+1,MESSAGE(RCCOUNT)="the error and reprocess the receipt."
 .   S RCCOUNT=RCCOUNT+1,MESSAGE(RCCOUNT)=" "
 ;
 ;  show duplicate receipts, previously received/processed
 I $O(^TMP($J,"RCDPXPAP","DUPLICATE",0)) D
 .   S RCCOUNT=RCCOUNT+1,MESSAGE(RCCOUNT)=" "
 .   S RCCOUNT=RCCOUNT+1,MESSAGE(RCCOUNT)="The following receipts were received as duplicates."
 .   S RCCOUNT=RCCOUNT+1,MESSAGE(RCCOUNT)="  Deposit#    Receipt#  FMS Document#   Total Amount"
 .   S RCCOUNT=RCCOUNT+1,MESSAGE(RCCOUNT)="  --------  ----------  -------------   ------------"
 .   S RCRECTDA=0 F  S RCRECTDA=$O(^TMP($J,"RCDPXPAP","DUPLICATE",RCRECTDA)) Q:'RCRECTDA  D
 .   .   D DIQ344^RCDPRPLM(RCRECTDA,".01;.06;.15;200;")
 .   .   S RCCOUNT=RCCOUNT+1
 .   .   S MESSAGE(RCCOUNT)=$J($G(RCDPDATA(344,RCRECTDA,.06,"E")),10)
 .   .   S MESSAGE(RCCOUNT)=MESSAGE(RCCOUNT)_$J($G(RCDPDATA(344,RCRECTDA,.01,"E")),12)
 .   .   S MESSAGE(RCCOUNT)=MESSAGE(RCCOUNT)_$J($G(RCDPDATA(344,RCRECTDA,200,"E")),16)
 .   .   ;  show ** if fms document processed
 .   .   I $P(^TMP($J,"RCDPXPAP","DUPLICATE",RCRECTDA),"^",2)=1 S MESSAGE(RCCOUNT)=MESSAGE(RCCOUNT)_"**",RCFLAG=1
 .   .   E  S MESSAGE(RCCOUNT)=MESSAGE(RCCOUNT)_"  "
 .   .   S MESSAGE(RCCOUNT)=MESSAGE(RCCOUNT)_$J($G(RCDPDATA(344,RCRECTDA,.15,"E")),12,2)
 .   .   S MESSAGE(RCCOUNT)=MESSAGE(RCCOUNT)_"  "_$P(^TMP($J,"RCDPXPAP","DUPLICATE",RCRECTDA),"^")
 ;
 I $G(RCFLAG) S RCCOUNT=RCCOUNT+1,MESSAGE(RCCOUNT)="                                      ** FMS Document Processed"
 S XMTEXT="MESSAGE("
 S XMSUB="Auto Payment Processing Completed"
 S XMDUZ="AR Package",XMY("G.RCDP PAYMENTS")=""
 D ^XMD
 Q
 ;
 ;
ZEROMSG(DATE) ;  show RT received with no payments for a date
 ;  date in the form MMDDYYYY
 S DATE=$E(DATE,1,2)_"/"_$E(DATE,3,4)_"/"_$E(DATE,5,8)
 N %Z,MESSAGE,X9,XCNP,XMDUZ,XMZ
 S MESSAGE(1)="The Automatic Payment Processing Server received a Lockbox"
 S MESSAGE(2)="transmission for "_DATE_" with no payments to process."
 S XMTEXT="MESSAGE("
 S XMSUB="Auto Payment Processing Completed"
 S XMDUZ="AR Package",XMY("G.RCDP PAYMENTS")=""
 D ^XMD
 Q
