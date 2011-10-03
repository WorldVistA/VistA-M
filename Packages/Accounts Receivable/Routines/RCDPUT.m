RCDPUT ;WASH-ISC@ALTOONA,PA/RGY-UTILITIES ;3/3/95  10:13 AM
V ;;4.5;Accounts Receivable;**69,90,106,114,169**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
RECEIPTS ;  check receipts
 N DATA,PAYDA,RCCOUNT,RCDATA0,RCDATE,RCRECTDA,STATUS,TOTAL,X,XCNP,XMDUZ,XMZ
 K ^TMP("RCDPUT",$J)
 ;  check receipts which are 4 days old
 S RCDATE=$$FMADD^XLFDT(DT,-4)
 S RCCOUNT=7
 S RCRECTDA=0 F  S RCRECTDA=$O(^RCY(344,RCRECTDA)) Q:'RCRECTDA  D
 .   ;  if no payments, quit
 .   I '$O(^RCY(344,RCRECTDA,1,0)) Q
 .   ;
 .   S RCDATA0=$G(^RCY(344,RCRECTDA,0))
 .   ;
 .   ;  receipt is marked as processed
 .   I $P(RCDATA0,"^",8) D  Q
 .   .   ;  check the last payment and see if it was processed
 .   .   ;  the last payment must have a paid amount and no processed
 .   .   ;  amount AND the payment did not go to suspense.
 .   .   S PAYDA=9999999,TOTAL=0
 .   .   F  S PAYDA=$O(^RCY(344,RCRECTDA,1,PAYDA),-1) Q:'PAYDA  S DATA=$G(^RCY(344,RCRECTDA,1,PAYDA,0)),TOTAL=TOTAL+$P(DATA,"^",4) I $P(DATA,"^",4),$P(DATA,"^",3),$P($G(^RCY(344,RCRECTDA,1,PAYDA,2)),"^",5)="" Q
 .   .   ;  no total paid on the receipt
 .   .   I 'TOTAL Q
 .   .   ;  found the last payment and it is not processed
 .   .   I PAYDA,'$P(^RCY(344,RCRECTDA,1,PAYDA,0),"^",5) D BUILDLN(RCDATA0,"All payments NOT completely processed.") Q
 .   .   ;
 .   .   ;  if no deposit ticket, receipt is processed
 .   .   I '$P(RCDATA0,"^",6) Q
 .   .   ;
 .   .   ;  receipts is marked as entered on line
 .   .   I $P($G(^RCY(344,RCRECTDA,2)),"^",2)=1 Q
 .   .   ;
 .   .   ;  fms document has not been sent
 .   .   I $P($G(^RCY(344,RCRECTDA,2)),"^")="" D BUILDLN(RCDATA0,"CR has NOT been sent to FMS.") Q
 .   .   ;
 .   .   ;  get the status of the fms code sheet and see if it is
 .   .   ;  accepted
 .   .   S STATUS=$$FMSSTAT^RCDPUREC(RCRECTDA)
 .   .   ;  document is accepted or entered on line
 .   .   I $E($P(STATUS,"^",2))="A" Q
 .   .   I $E($P(STATUS,"^",2))="O" Q
 .   .   ;  not been more than 4 days
 .   .   I $$FMDIFF^XLFDT(DT,$P(RCDATA0,"^",8))<4 Q
 .   .   D BUILDLN(RCDATA0,"CR NOT accepted in FMS ("_$P(STATUS," ")_").")
 .   ;
 .   ;  receipt not that old
 .   I $P(RCDATA0,"^",3)>RCDATE Q
 .   ;
 .   ;  not processed in a timely manner
 .   D BUILDLN(RCDATA0,"NOT processed in a timely manner.")
 ;
 I '$O(^TMP("RCDPUT",$J,0)) Q
 ;
 ;  send mail message
 S ^TMP("RCDPUT",$J,1)="Sent to: PRCA ERROR mailgroup"
 S ^TMP("RCDPUT",$J,2)="         RCDP PAYMENTS mailgroup"
 S ^TMP("RCDPUT",$J,3)="         PRCAY PAYMENT SUP security key holders"
 S ^TMP("RCDPUT",$J,4)=" "
 S ^TMP("RCDPUT",$J,5)="RECEIPT        OPENED   PROCESS  WARNING"
 S ^TMP("RCDPUT",$J,6)="------------------------------------------------------------------------------"
 S XMY("G.PRCA ERROR")=""
 S XMY("G.RCDP PAYMENTS")=""
 F X=0:0 S X=$O(^XUSEC("PRCAY PAYMENT SUP",X)) Q:'X  S XMY(X)=""
 S XMDUZ="Accounts Receivable Package"
 S XMTEXT="^TMP(""RCDPUT"",$J,"
 S XMSUB="Error in Agent Cashier Receipt(s)"
 D ^XMD
 K ^TMP("RCDPUT",$J)
 Q
 ;
 ;
BUILDLN(RCDATA0,WARNING) ;  build line in mail message with receipt data
 N DATA,DATE
 S RCCOUNT=RCCOUNT+1
 S DATA=$E($P(RCDATA0,"^")_"           ",1,11)_"  "
 S DATE=$P(RCDATA0,"^",3) I DATE S DATE=$E(DATE,4,5)_"/"_$E(DATE,6,7)_"/"_$E(DATE,2,3)
 S DATA=DATA_$E(DATE_"        ",1,8)_"  "
 S DATE=$P(RCDATA0,"^",8) I DATE S DATE=$E(DATE,4,5)_"/"_$E(DATE,6,7)_"/"_$E(DATE,2,3)
 S DATA=DATA_$E(DATE_"        ",1,8)_"  "
 S DATA=DATA_WARNING
 S RCCOUNT=RCCOUNT+1
 S ^TMP("RCDPUT",$J,RCCOUNT)=DATA
 Q
 ;
 ;
PURGE ;  purge receipts and deposits
 N %,D0,D1,DA,DG,DIC,DICR,DIG,DIH,DIK,DIU,DIV,DIW,RCDATE,RCDEPDA,RCRECTDA,X,Y
 ;
 ;  purge receipts
 S RCDATE=$$FPS^RCAMFN01(DT,-12)
 S RCRECTDA=0 F  S RCRECTDA=$O(^RCY(344,RCRECTDA)) Q:'RCRECTDA  D
 .   ;  receipt not processed, do not purge
 .   I '$P(^RCY(344,RCRECTDA,0),"^",8) Q
 .   ;  receipt processed less than 12 months ago, do not purge
 .   I $P(^RCY(344,RCRECTDA,0),"^",8)>RCDATE Q
 .   ;  purge receipt
 .   L +^RCY(344,RCRECTDA,0)
 .   S DIK="^RCY(344,",DA=RCRECTDA D ^DIK
 .   L -^RCY(344,RCRECTDA,0)
 ;
 ;  purge deposits
 S RCDATE=$$FPS^RCAMFN01(DT,-12)
 S RCDEPDA=0 F  S RCDEPDA=$O(^RCY(344.1,RCDEPDA)) Q:'RCDEPDA  D
 .   ;  if receipts are on deposit, do not purge
 .   I $O(^RCY(344,"AD",RCDEPDA,0)) Q
 .   ;  deposit not confirmed, do not purge
 .   I '$P(^RCY(344.1,RCDEPDA,0),"^",11) Q
 .   ;  deposit confirmed less than 12 months ago, do not purge
 .   I $P(^RCY(344.1,RCDEPDA,0),"^",11)>RCDATE Q
 .   ;  purge deposit
 .   L +^RCY(344.1,RCDEPDA,0)
 .   S DIK="^RCY(344.1,",DA=RCDEPDA D ^DIK
 .   L -^RCY(344.1,RCDEPDA,0)
 Q
 ;
 ;
MAN ;  Entry point for nightly process for managing receipts and deposits
 D PURGE
 D RECEIPTS
 Q
