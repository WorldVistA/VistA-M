PRCAI16M ;ALB/LDB-post init patch 164, generate mail message ;19 Nov 00
 ;;4.5;Accounts Receivable;**164**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
MAIL ;  generate mail message to users
 ;  rcmessag variable passed as to the status of the patch install.
 ;  this variable appears on the first line of the message.
 D MES^XPDUTL("     ...generating mailman message to G.RCDP PAYMENTS.")
 ;
 N %,COUNT,DATA,DATE,LINE,PPBILL,PPTRAN1,PPTRANS,RCBILLDA,RCTRAN1,RCTRANDA,TOTAL,TYPE,XMDUN,XMY,XMZ
 ;
 ;  generate mailman message to user
 K ^TMP($J,"RCRJRCORMM")
 S ^TMP($J,"RCRJRCORMM",1)=RCMESSAG
 S ^TMP($J,"RCRJRCORMM",2)=" "
 S ^TMP($J,"RCRJRCORMM",3)="The following bills need to be reviewed.  Payments for deposit"
 S ^TMP($J,"RCRJRCORMM",4)="269296 were mailed from Austin to Accounts Receivable twice on"
 S ^TMP($J,"RCRJRCORMM",5)="November 10, 2000 and November 13, 2000.  Accounts Receivable"
 S ^TMP($J,"RCRJRCORMM",6)="patch PRCA*4.5*164 has been installed and has backed out the"
 S ^TMP($J,"RCRJRCORMM",7)="payments processed on November 13, 2000.  This mailman message"
 S ^TMP($J,"RCRJRCORMM",8)="shows those bills where payments were removed for the duplicate"
 S ^TMP($J,"RCRJRCORMM",9)="deposit.  You may want to review the bills and verify the"
 S ^TMP($J,"RCRJRCORMM",10)="balances."
 S ^TMP($J,"RCRJRCORMM",11)=" "
 ;
 S ^TMP($J,"RCRJRCORMM",12)="BILL                               PAYMENT     TRANS     "_$J("PAYMENT",10)_$J("NEW BILL",10)
 S ^TMP($J,"RCRJRCORMM",13)="NUMBER       BILL TYPE             TRANS#      DATE      "_$J("AMOUNT",10)_$J("AMOUNT",10)
 S ^TMP($J,"RCRJRCORMM",14)="-----------------------------------------------------------------------------"
 S LINE=14
 ;
 S TOTAL=0
 S RCBILLDA=0 F  S RCBILLDA=$O(^TMP("PRCAI164",$J,RCBILLDA)) Q:'RCBILLDA  D
 .   S COUNT=0
 .   S RCTRANDA=0 F  S RCTRANDA=$O(^TMP("PRCAI164",$J,RCBILLDA,RCTRANDA)) Q:'RCTRANDA  D
 .   .   S RCTRAN1=$G(^PRCA(433,RCTRANDA,1))
 .   .   S TYPE=$P($G(^PRCA(430.2,+$P($G(^PRCA(430,RCBILLDA,0)),"^",2),0)),"^")
 .   .   ;
 .   .   ;  show bill (use count to for showing it different the second time)
 .   .   S DATA=$E($P(^PRCA(430,RCBILLDA,0),"^")_"                ",1,13)_$E(TYPE_"               ",1,15)
 .   .   I COUNT=1 S DATA="             "_"               "
 .   .   S COUNT=1
 .   .   ;
 .   .   ;  show as increase or decrease
 .   .   S %="     "
 .   .   I TYPE["PREPAY" S %=$S($P(RCTRAN1,"^",2)=1:"INC",1:"DEC")_"  "
 .   .   S DATA=DATA_%
 .   .   ;
 .   .   ;  show transaction number
 .   .   S DATA=DATA_"  "_$E(RCTRANDA_"               ",1,12)
 .   .   ;
 .   .   ;  show transaction date
 .   .   S DATE=$P(RCTRAN1,"^",9) I DATE="" S DATE="       "
 .   .   S DATA=DATA_$E(DATE,4,5)_"/"_$E(DATE,6,7)_"/"_$E(DATE,2,3)_"  "
 .   .   ;
 .   .   ;  show amount paid (show decrease as negative)
 .   .   I $P(RCTRAN1,"^",2)=35 S $P(RCTRAN1,"^",5)=-$P(RCTRAN1,"^",5)
 .   .   S DATA=DATA_$J($P(RCTRAN1,"^",5),10,2)
 .   .   S TOTAL=TOTAL+$P(RCTRAN1,"^",5)
 .   .   ;
 .   .   ;  show new bill balance
 .   .   S %=$G(^PRCA(430,RCBILLDA,7)) S %=$P(%,"^")+$P(%,"^",2)+$P(%,"^",3)+$P(%,"^",4)+$P(%,"^",5)
 .   .   S DATA=DATA_$J(%,10,2)
 .   .   ;
 .   .   ;  store the line
 .   .   S LINE=LINE+1,^TMP($J,"RCRJRCORMM",LINE)=DATA
 .   .   ;
 .   .   ;  if there is a prepayment transaction on the bill, show that one also
 .   .   S PPTRANS=$P($G(^PRCA(433,RCTRANDA,5)),"^")
 .   .   I PPTRANS D
 .   .   .   S PPTRAN1=$G(^PRCA(433,PPTRANS,1))
 .   .   .   ;  show bill paid by the prepayment
 .   .   .   S PPBILL=+$P($G(^PRCA(433,PPTRANS,0)),"^",2)
 .   .   .   S DATA="             "_$E("PREPAID "_$P($G(^PRCA(430,PPBILL,0)),"^")_"                    ",1,20)
 .   .   .   S DATA=DATA_"  "_$E(PPTRANS_"            ",1,12)
 .   .   .   ;
 .   .   .   ;  show transaction date
 .   .   .   S DATE=$P(PPTRAN1,"^",9) I DATE="" S DATE="       "
 .   .   .   S DATA=DATA_$E(DATE,4,5)_"/"_$E(DATE,6,7)_"/"_$E(DATE,2,3)_"  "
 .   .   .   ;
 .   .   .   ;  show amount paid
 .   .   .   S DATA=DATA_$J($P(PPTRAN1,"^",5),10,2)
 .   .   .   S TOTAL=TOTAL+$P(PPTRAN1,"^",5)
 .   .   .   ;
 .   .   .   ;  show new bill balance
 .   .   .   S %=$G(^PRCA(430,PPBILL,7)) S %=$P(%,"^")+$P(%,"^",2)+$P(%,"^",3)+$P(%,"^",4)+$P(%,"^",5)
 .   .   .   S DATA=DATA_$J(%,10,2)
 .   .   .   ;
 .   .   .   ;  store the line
 .   .   .   S LINE=LINE+1,^TMP($J,"RCRJRCORMM",LINE)=DATA
 ;
 I LINE=14 S ^TMP($J,"RCRJRCORMM",15)="<<No Bills Or Transactions Found For You to Review>>"
 E  S LINE=LINE+1,^TMP($J,"RCRJRCORMM",LINE)="                                               TOTAL PAID"_$J(TOTAL,10,2)
 ;
 ;  send mail message
 N DIFROM  ;  need to be newed or mailman will not deliver the message
 S XMY("G.RCDP PAYMENTS")=""
 S XMY(.5)=""
 S XMY(DUZ)=""
 S XMZ=$$SENDMSG^RCRJRCOR("AR Patch 164 Duplicate Deposit 269296",.XMY)
 K ^TMP($J,"RCRJRCORMM")
 Q
