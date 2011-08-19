RCDPRECT ;WISC/RFJ-print a receipt ;1 Jun 99
 ;;4.5;Accounts Receivable;**114,148,217,244**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
RECEIPT(RCRECTDA,RCTRANDA) ;  control printing of receipt for device selection
 N %,IOP,PRINT
 S PRINT=$$OPTCK^RCDPRPL2("RECEIPT",2)_"^"_$$OPTCK^RCDPRPL2("RECEIPT",3)
 ;  if not defined by user, ask for the device
 I PRINT="" S PRINT=2
 ;
 ;  never print receipt
 I $P(PRINT,"^")=0 Q
 ;
 ;  always print receipt to default device
 I $P(PRINT,"^")=1 D
 .   ;  test device without opening it
 .   S IOP=$P(PRINT,"^",2) I IOP="" S PRINT=2 Q
 .   S %ZIS="N"
 .   D ^%ZIS I POP S PRINT=2 Q
 .   D QUEUEIT
 ;
 ;  ask to print receipt
 I $P(PRINT,"^")=2 S %=$$DEVICE
 Q
 ;
 ;
DEVICE() ;  select the device and print receipt
 ;  returns 0 if not successful
 S %ZIS("A")="Print Receipt on DEVICE: "
 S %ZIS("B")=$$OPTCK^RCDPRPL2("RECEIPT",3)
 S %ZIS="Q"
 W ! D ^%ZIS
 I POP D ^%ZISC Q 0
 I $D(IO("Q")) D QUEUEIT Q "Print Receipt Queued"
 D PRINT
 Q "Receipt Printed"
 ;
 ;
QUEUEIT ;  queue printing receipt
 N ZTSK
 S ZTDTH=$H,ZTDESC="Print Payment Receipt",ZTRTN="PRINT^RCDPRECT"
 S ZTSAVE("RCRECTDA")="",ZTSAVE("RCTRANDA")="",ZTSAVE("ZTREQ")="@"
 D ^%ZTLOAD
 D ^%ZISC
 Q
 ;
 ;
PRINT ;  print a receipt
 ;  requires variables rcrectda and rctranda
 N %,%H,%I,ADDRESS,DATA,LINE,RCTYPE,X,Y
 U IO
 ;
 ;  print address for station at top
 S ADDRESS=$$SADD^RCFN01(1)
 W !?25,"Department Of Veterans Affairs"
 F %=1,2,3 I $P(ADDRESS,"^",%)'="" W !?((80-$L($P(ADDRESS,"^",%)))/2),$P(ADDRESS,"^",%)
 S ADDRESS=$P(ADDRESS,"^",4)_", "_$P(ADDRESS,"^",5)_"  "_$P(ADDRESS,"^",6)
 I $TR(ADDRESS,", ")'="" W !?((80-$L(ADDRESS))/2),ADDRESS
 ;
 S LINE="",$P(LINE,"-",80)=""
 W !,LINE
 ;
 S %="*** Payment Receipt ***"
 W !!?((80-$L(%))/2),%
 ;
 ;  account and name
 S DATA=$G(^RCY(344,RCRECTDA,1,RCTRANDA,0))
 I $P(DATA,"^",3)'="" D
 .   W !
 .   ;  account from patient file
 .   I $P(DATA,"^",3)[";DPT(" D  Q
 .   .   W $P($G(^DPT(+$P(DATA,"^",3),0)),"^")
 .   .   S %=$$SSN^RCFN01($P(DATA,"^",3))
 .   .   I $E(%,6,9)'="" W " (",$E(%,6,9),")"
 .   ;
 .   ;  account from bill file
 .   W $P($G(^PRCA(430,+$P(DATA,"^",3),0)),"^")
 .   W "  "
 .   W $$NAM^RCFN01($P($G(^PRCA(430,+$P(DATA,"^",3),0)),"^",9))
 .   S %=$$SSN^RCFN01($P($G(^PRCA(430,+$P(DATA,"^",3),0)),"^",9))
 .   I $E(%,6,9)'="" W " (",$E(%,6,9),")"
 ;
 W !,"     Receipt #: ",$P(^RCY(344,RCRECTDA,0),"^"),"/",$P(DATA,"^")
 D NOW^%DTC S Y=X D DD^%DT
 W ?53,"Date: ",Y
 W !,"  Payment Type: ",$P($G(^RC(341.1,+$P(^RCY(344,RCRECTDA,0),"^",4),0)),"^")
 S Y=$P(DATA,"^",6) I Y D DD^%DT
 W ?45,"Payment Date: ",Y
 ;
 S RCTYPE=$P($G(^RC(341.1,+$P(^RCY(344,RCRECTDA,0),"^",4),0)),"^",2)
 ;  type = 3 (district counsel), 4 (check), 5 (dept of justice)
 I RCTYPE=3!(RCTYPE=4)!(RCTYPE=5) D
 .   W !,"       Check #: ",$P(DATA,"^",7)
 .   S Y=$P(DATA,"^",10) I Y D DD^%DT
 .   W ?47,"Check Date: ",Y
 .   W !,"        Bank #: ",$P(DATA,"^",8)
 ;
 ;  type = 7 (credit card)
 I RCTYPE=7 D
 .   W !," Last 4 of Credit Card #: ",$E($P(DATA,"^",11),$L($P(DATA,"^",11))-3,$L($P(DATA,"^",11)))
 .   W !," Confirmation#: ",$P(DATA,"^",2)
 ;
 W !,"Payment Amount: $ ",$J($P(DATA,"^",4),0,2)
 W ?42,"Account Balance: $ ",$J($$BAL^PRCAFN($S($P(DATA,"^",3)[";PRCA(430":$P(^PRCA(430,+$P(DATA,"^",3),0),"^",9),1:$P(DATA,"^",3))),0,2)
 ;
 W !!,"IMPORTANT"
 W !!,"Note that checks or drafts are not valid until paid by your bank."
 W !!,"This receipt should be retained for your records."
 W !,"A detailed listing of how your payment has been applied to your"
 W !,"account will be provided on your patient statement, which you"
 W !,"will receive in the mail at a later date."
 W !!,LINE
 D ^%ZISC
 Q
