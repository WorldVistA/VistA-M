RCBEUDEB ;WISC/RFJ-utilties for debtors (in file 340)                ;1 Jun 00
 ;;4.5;Accounts Receivable;**153**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
EDIT340(RCDEBTDA,DR) ;  edit the field in 340 with the DR string passed
 I '$D(^RCD(340,RCDEBTDA)) Q
 N %,D,D0,D1,DA,DDH,DI,DIC,DIE,DQ,J,X,Y
 S (DIC,DIE)="^RCD(340,",DA=RCDEBTDA
 D ^DIE
 ;  user pressed up-arrow
 I $D(Y) Q "0^DEBTOR FIELDS NOT UPDATED"
 Q 1
 ;
 ;
TOPAMT(RCBILLDA,AMOUNT) ;  increase or decrease current top debt amount
 ;  field 4.03
 ;  pass the bill number and amount, - to decrease.
 N RCDEBTDA,TOPAMT
 S RCDEBTDA=+$P($G(^PRCA(430,RCBILLDA,0)),"^",9)
 I '$D(^RCD(340,RCDEBTDA,0)) Q
 S TOPAMT=$P($G(^RCD(340,RCDEBTDA,4)),"^",3)+AMOUNT
 I TOPAMT<0 S TOPAMT=0
 S $P(^RCD(340,RCDEBTDA,4),"^",3)=TOPAMT
 Q
