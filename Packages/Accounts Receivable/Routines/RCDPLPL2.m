RCDPLPL2 ;WISC/RFJ-link payments listmanager options ;1 Jun 99
 ;;4.5;Accounts Receivable;**114,148**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
SHOWPAY ;  this will show how a payment was applied to an account
 D FULL^VALM1
 S VALMBCK="R"
 ;
 N %,ACCOUNT,BILLDA,DATA,RCRECTDA,RCTRANDA,RECEIPT,TRANDA
 ;
 F  W ! S RCRECTDA=+$$SELRECT^RCDPUREC(0,0) Q:RCRECTDA<1  D
 .   S RCTRANDA=+$$SELTRAN^RCDPURET(RCRECTDA) Q:RCTRANDA<1
 .   ;
 .   S ACCOUNT=$P(^RCY(344,RCRECTDA,1,RCTRANDA,0),"^",3)
 .   I 'ACCOUNT W !,"This payment is not linked, there is no account." Q
 .   ;
 .   S RECEIPT=$P(^RCY(344,RCRECTDA,0),"^")
 .   W !!,"                       Receipt: ",RECEIPT
 .   W !,"                   Transaction: ",RCTRANDA
 .   W !,"      Unapplied Deposit Number: ",$P($G(^RCY(344,RCRECTDA,1,RCTRANDA,2)),"^",5)
 .   W !,"             Total Paid Amount: ",$J($P($G(^RCY(344,RCRECTDA,1,RCTRANDA,0)),"^",4),10,2)
 .   W !,"<searching>"
 .   ;
 .   S TRANDA=0
 .   F  S TRANDA=$O(^PRCA(433,"AF",RECEIPT,TRANDA)) Q:'TRANDA  D
 .   .   S BILLDA=+$P($G(^PRCA(433,TRANDA,0)),"^",2)
 .   .   I $P($G(^RCD(340,+$P($G(^PRCA(430,BILLDA,0)),"^",9),0)),"^")=ACCOUNT D
 .   .   .   S DATA=$G(^PRCA(433,TRANDA,3))
 .   .   .   F %=1:1:11 W $C(8)  ;backspace
 .   .   .   W "           "
 .   .   .   W !?5,"Transaction: ",TRANDA
 .   .   .   W !?9,"  Principal Collected: ",$J($P(DATA,"^"),10,2)
 .   .   .   W !?9,"   Interest Collected: ",$J($P(DATA,"^",2),10,2)
 .   .   .   W !?9,"      Admin Collected: ",$J($P(DATA,"^",3),10,2)
 .   .   .   W !?9,"Marshal Fee Collected: ",$J($P(DATA,"^",4),10,2)
 .   .   .   W !?9," Court Cost Collected: ",$J($P(DATA,"^",5),10,2)
 .   .   .   W !,"<searching>"
 .   ;
 .   F %=1:1:11 W $C(8)  ;backspace
 .   W "           "
 ;
 S VALMBCK="R"
 Q
