RCDPXPAY ;WISC/RFJ-server top to receive electronic payments ;1 Jun 99
 ;;4.5;Accounts Receivable;**114,148,150**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
START ;  start receiving message
 N RCDPCNTL,RCDPCSUM,RCDPDATA,RCDPDATE,RCDPFLAG,RCDPFSUM,RCDPLIDA,RCDPLINE,RCDPNEXT,RCDPSEQ,RCDPSITE,RCDPTOTL,RCDPXMZ,X,Y
 K ^TMP($J,"RCDPXPAY")
 ;
 ;  not a valid mail message
 I '$D(^XMB(3.9,XMZ,0)) Q
 ;
 S RCDPXMZ=XMZ
 ;  find line 1 of data and make sure it is correctly formatted
 S RCDPLINE=.99 F  S RCDPLINE=$O(^XMB(3.9,RCDPXMZ,2,RCDPLINE)) Q:'RCDPLINE  S RCDPDATA=^(RCDPLINE,0) I $E(RCDPDATA,1,2)="RT" Q
 ;  first 2 characters of line 1 must equal RT
 I $E($G(RCDPDATA),1,2)'="RT" D ERROR^RCDPXPAM("",RCDPXMZ,"RT expected (line 1, piece 1)"),COMPLETE Q
 ;  check the station number
 S RCDPSITE=$$SITE^RCMSITE
 I $P(RCDPDATA,"^",4)'=RCDPSITE D ERROR^RCDPXPAM("",RCDPXMZ,"Wrong station number (line 1, piece 4), station number should be "_RCDPSITE),COMPLETE Q
 ;  get the transmission date and convert it to a fileman date
 S RCDPDATE=$$CONVDATE($P(RCDPDATA,"^",8)) I RCDPDATE<0 D ERROR^RCDPXPAM("",RCDPXMZ,"Invalid transmission date (line 1, piece 8)"),COMPLETE Q
 ;  get the sequence number
 S RCDPSEQ=+$P(RCDPDATA,"^",2) I 'RCDPSEQ D ERROR^RCDPXPAM("",RCDPXMZ,"Sequence number of the message is missing (line 1, piece 2)"),COMPLETE Q
 ;
 ;  check for zero payments on message
 ;  sequence=1          ,total sequence=1     ,no payments        ,no dollars on RT   ,no total dollars
 I +$P(RCDPDATA,"^",2)=1,+$P(RCDPDATA,"^",3)=1,'$P(RCDPDATA,"^",5),'$P(RCDPDATA,"^",6),'$P(RCDPDATA,"^",7) D ZEROMSG^RCDPXPAM($P(RCDPDATA,"^",8)) Q
 ;
 ;  stay and wait for lock to clear
 L +^RCY(344.2,RCDPDATE)
 ;
 ;  check for duplicate message, only store/process the first one
 ;  still go and check to see if all messages have been received and can be processed
 I $D(^RCY(344.2,RCDPDATE,1,RCDPSEQ,0)) D DUPLCATE^RCDPXPAM(RCDPDATE,RCDPSEQ,RCDPXMZ),STARPROC Q
 ;
 ;  add transmission date if not in file
 I '$$ADDTRAN^RCDPXPA1(RCDPDATE) D ERROR^RCDPXPAM("",RCDPXMZ,"Unable to add transmission to AR PAYMENT TRANSACTIONS file 344.2"),COMPLETE Q
 ;  store total sequences and dollars if available for transmission
 D TRANDOLL^RCDPXPA1(RCDPDATE,+$P(RCDPDATA,"^",3),+$P(RCDPDATA,"^",7)/100)
 ;
 ;  add the sequence to the transmission multiple
 S RCDPSEQ=$$ADDSEQ^RCDPXPA1(RCDPDATE,+$P(RCDPDATA,"^",2)) I 'RCDPSEQ D ERROR^RCDPXPAM(RCDPDATE,RCDPXMZ,"Unable to add the sequence number (line 1, piece 2)"),COMPLETE Q
 ;  store number of transactions, total dollars for the sequence, mail message number
 D SEQUDOLL^RCDPXPA1(RCDPDATE,RCDPSEQ,+$P(RCDPDATA,"^",5),+$P(RCDPDATA,"^",6)/100,RCDPXMZ)
 ;
 ;  once the sequence has been added, future errors must pass the
 ;  variable rcdpdate to the label error to set the status to error
 ;  and prevent further processing later on.
 ;
 ;  store control header line 1 for comparing count and dollars of transactions
 S RCDPCNTL=RCDPDATA
 ;
 ;  loop transactions and store the data
 S RCDPCSUM=0  ;used to compute checksum for sequence
 S RCDPLIDA=0  ;used to count entries stored in the data wp field
 S RCDPTOTL=0  ;used to total all payments (transactions)
 F  S RCDPLINE=$O(^XMB(3.9,RCDPXMZ,2,RCDPLINE)) Q:'RCDPLINE  D
 .   S RCDPDATA=^XMB(3.9,RCDPXMZ,2,RCDPLINE,0)
 .   I RCDPDATA=""!($E(RCDPDATA,1,4)="NNNN") Q
 .   ;  convert deposit date to fm
 .   S $P(RCDPDATA,"^",7)=$$CONVDATE($P(RCDPDATA,"^",7))
 .   I $P(RCDPDATA,"^",7)<0 S $P(RCDPDATA,"^",7)=0
 .   ;  check for errors
 .   I $E(RCDPDATA,1,2)'="RD" S ^TMP($J,"RCDPXPAY","ERROR",RCDPLINE)="RD expected (line "_RCDPLINE_", piece 1)"
 .   I '$P(RCDPDATA,"^",3) S ^TMP($J,"RCDPXPAY","ERROR",RCDPLINE)="No payment amount (line "_RCDPLINE_", piece 3)"
 .   I $P(RCDPDATA,"^",6)="" S ^TMP($J,"RCDPXPAY","ERROR",RCDPLINE)="Deposit/215 number missing (line "_RCDPLINE_", piece 6)"
 .   I '$P(RCDPDATA,"^",7) S ^TMP($J,"RCDPXPAY","ERROR",RCDPLINE)="Deposit date missing/invalid format (line "_RCDPLINE_", piece 7)"
 .   ;  add up dollars
 .   S RCDPTOTL=RCDPTOTL+($P(RCDPDATA,"^",3)/100)
 .   ;  remove RT, remove station number from account (based on site length)
 .   ;  since the station number is variable 3 to 5 characters
 .   S RCDPDATA=$P(RCDPDATA,"^",2,99),RCDPDATA=$E(RCDPDATA,$L(RCDPSITE)+1,99999)
 .   ;  store the data
 .   S RCDPLIDA=RCDPLIDA+1
 .   S ^RCY(344.2,RCDPDATE,1,RCDPSEQ,1,RCDPLIDA,0)=RCDPDATA
 .   ;  compute checksum
 .   S X=RCDPCSUM_RCDPDATA X $S($G(^%ZOSF("LPC"))'="":^("LPC"),1:"S Y=""""") S RCDPCSUM=Y
 ;
 ;  store 0th node with count of lines and date
 S ^RCY(344.2,RCDPDATE,1,RCDPSEQ,1,0)="^^"_RCDPLIDA_"^"_RCDPLIDA_"^"_DT_"^"
 ;  store the checksum for sequence
 D TRANCSUM^RCDPXPA1(RCDPDATE,RCDPSEQ,RCDPCSUM)
 ;
 ;  check number of transactions for sequence
 I $P(RCDPCNTL,"^",5)'=RCDPLIDA D ERROR^RCDPXPAM(RCDPDATE,RCDPXMZ,"Expected number of transactions not equal actual number (line 1, piece 5)"),COMPLETE Q
 ;  check total dollars for sequence
 I ($P(RCDPCNTL,"^",6)/100)'=RCDPTOTL D ERROR^RCDPXPAM(RCDPDATE,RCDPXMZ,"Expected dollars of transactions not equal actual dollars (line 1, piece 6)"),COMPLETE Q
 ;
 ;  if errors on rd lines, stop process
 I $O(^TMP($J,"RCDPXPAY","ERROR",0)) D ERROR^RCDPXPAM(RCDPDATE,RCDPXMZ,""),COMPLETE Q
 ;
STARPROC ;  start processing
 ;  check to see if all messages (sequences) have been received
 S RCDPFLAG=1
 S RCDPDATA=^RCY(344.2,RCDPDATE,0) I $P(RCDPDATA,"^",2) D
 .   S RCDPFLAG=0
 .   F RCDPSEQ=1:1:$P(RCDPDATA,"^",2) I '$D(^RCY(344.2,RCDPDATE,1,RCDPSEQ)) S RCDPFLAG=1 Q
 ;  not all sequences received yet
 I $G(RCDPFLAG) D COMPLETE Q
 ;
 ;  ***** all sequences received, start processing *****
 ;  if status is error, quit and wait for tomorrow to send retransmission
 ;  message to mail group
 I $P(^RCY(344.2,RCDPDATE,0),"^",4)="e" D COMPLETE Q
 ;  already processing/processed the payments
 I $P(^RCY(344.2,RCDPDATE,0),"^",4)="p" D COMPLETE Q
 ;
 ;  set status to processing
 D TRANSTAT^RCDPXPA1(RCDPDATE,"p")
 S RCDPTOTL=0
 S RCDPNEXT=0  ;used for making tmp global entry unique
 F RCDPSEQ=1:1 Q:'$D(^RCY(344.2,RCDPDATE,1,RCDPSEQ))  D
 .   S RCDPCSUM=0
 .   S RCDPTOTL=RCDPTOTL+$P(^RCY(344.2,RCDPDATE,1,RCDPSEQ,0),"^",3)
 .   F RCDPLIDA=1:1 Q:'$D(^RCY(344.2,RCDPDATE,1,RCDPSEQ,1,RCDPLIDA,0))  D
 .   .   S RCDPDATA=^RCY(344.2,RCDPDATE,1,RCDPSEQ,1,RCDPLIDA,0)
 .   .   ;  compute checksum
 .   .   S X=RCDPCSUM_RCDPDATA X $S($G(^%ZOSF("LPC"))'="":^("LPC"),1:"S Y=""""") S RCDPCSUM=Y
 .   .   ;  store transaction for processing
 .   .   ;  the deposit number and date should not be null unless the
 .   .   ;  data was modified after receipt
 .   .   I $P(RCDPDATA,"^",5)="" S $P(RCDPDATA,"^",5)=" " ; deposit number
 .   .   S RCDPNEXT=RCDPNEXT+1,^TMP($J,"RCDPXPAY","DEPOSIT",$P(RCDPDATA,"^",5),RCDPNEXT)=$P(RCDPDATA,"^",1,4)_"^"_$P(RCDPDATA,"^",7,99)
 .   .   ;  store deposit date for deposit if it is needed
 .   .   I $P(RCDPDATA,"^",6),'$G(^TMP($J,"RCDPXPAY","DEPDATE",$P(RCDPDATA,"^",5))) S ^TMP($J,"RCDPXPAY","DEPDATE",$P(RCDPDATA,"^",5))=$P(RCDPDATA,"^",6)
 .   ;  verify checksum
 .   I $P(^RCY(344.2,RCDPDATE,1,RCDPSEQ,0),"^",5)'=RCDPCSUM S RCDPFSUM=1
 ;
 ;  verify totals for all sequences
 I $P(^RCY(344.2,RCDPDATE,0),"^",3)'=RCDPTOTL D ERROR^RCDPXPAM(RCDPDATE,RCDPXMZ,"The total dollars for all sequences do not balance with expected total"),COMPLETE Q
 ;  checksum error
 I $G(RCDPFSUM) D ERROR^RCDPXPAM(RCDPDATE,RCDPXMZ,"The deposit information has been altered before processing occured"),COMPLETE Q
 ;
 ;  everything checks out, start processing
 ;  modify the lockbox lookup for accepting payment from other systems
 D PROCESS^RCDPXPAP(RCDPDATE,$O(^RC(341.1,"B","LOCKBOX",0)))
 ;
COMPLETE ;  complete the process
 ;  check for errors in the transmission file for prior dates
 ;  if they exist, mail a message to the users asking for retrans
 ;  remove the entries
 N DATA,DEPDATE,DEPOSIT,RCDPDA
 S RCDPDA=DT F  S RCDPDA=$O(^RCY(344.2,RCDPDA),-1) Q:'RCDPDA  D
 .   ;  if the status was last updated today, do not modify
 .   I $P(^RCY(344.2,RCDPDA,0),"^",5)=DT Q
 .   ;  try and find deposit number and deposit date
 .   S (DEPOSIT,DEPDATE)="",RCDPFLAG=0
 .   F RCDPSEQ=1:1 Q:'$D(^RCY(344.2,RCDPDA,1,RCDPSEQ))  D  Q:RCDPFLAG
 .   .   F RCDPLIDA=1:1 Q:'$D(^RCY(344.2,RCDPDA,1,RCDPSEQ,1,RCDPLIDA,0))  D  Q:RCDPFLAG
 .   .   .   S DATA=$G(^RCY(344.2,RCDPDA,1,RCDPSEQ,1,RCDPLIDA,0))
 .   .   .   I $P(DATA,"^",5)'="" S DEPOSIT=$P(DATA,"^",5)
 .   .   .   I $P(DATA,"^",6)'="" S DEPDATE=$P(DATA,"^",6)
 .   .   .   I DEPOSIT'="",DEPDATE'="" S RCDPFLAG=1  ; used to stop for loops
 .   ;
 .   S ^TMP($J,"RCDPXPAY","RETRAN",RCDPDA)=DEPOSIT_"^"_DEPDATE_"^"_$P(^RCY(344.2,RCDPDA,0),"^",4)
 .   ;  remove the entry from the file so it will not appear later
 .   D DELETRAN^RCDPXPA1(RCDPDA)
 ;  if there are any, send a message asking for retransmission
 I $O(^TMP($J,"RCDPXPAY","RETRAN",0)) D RETRAN^RCDPXPAM
 ;
 ;  clear the current transmission date lock, clear it here to prevent
 ;  two processes from sending the retransmission request message
 I $G(RCDPDATE) L -^RCY(344.2,RCDPDATE)
 ;
 ;  clean up
 K ^TMP($J,"RCDPXPAY")
 ;
 ;  remove message from server basket
 N K,X,XMK,XMSER,Y
 S XMSER="S.RCDP AUTOMATIC PAYMENTS",XMZ=RCDPXMZ
 D REMSBMSG^XMA1C
 Q
 ;
 ;
CONVDATE(DATE) ;  convert date from mmddyyyy to fm date cyymmdd
 Q ($E(DATE,5,6)-17)_$E(DATE,7,8)_$E(DATE,1,2)_$E(DATE,3,4)
