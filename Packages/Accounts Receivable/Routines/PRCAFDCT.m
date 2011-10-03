PRCAFDCT ;WASH-ISC@ALTOONA/CLH-View Stacker information ;1/12/95  2:58 PM
V ;;4.5;Accounts Receivable;**198**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
BILL ;View status for bills
 N DIC,BILL,X,D,REC,RECN,BILLN,Y,D0
 N DPTNOFZY,DPTNOFZK S (DPTNOFZY,DPTNOFZK)=1
 S DIC="^PRCA(430,",DIC(0)="AEMNQZ",DIC("A")="Select A/R BILL: "
 D ^DIC Q:+Y<0
 S BILLN=+Y,X="B"_BILLN
 K DIC
 S DIC="^RC(347,",DIC(0)="XMN",D="D" D MIX^DIC1
 I +Y<0 W !!,"Unable to locate bill in A/R Document file.",!! K BILL,BILLN,REC,RECN G BILL
 S RECN=+Y
 S D0=RECN D ^PRCATF1
 G BILL
 ;
TRANS ;View status for transactions
 N DIC,TN,X,D,Y,D0,REC
 N DPTNOFZY,DPTNOFZK S (DPTNOFZY,DPTNOFZK)=1
 S DIC="^PRCA(433,",DIC(0)="AEMNQ",DIC("A")="Select A/R TRANSACTION: " D ^DIC K DIC
 Q:+Y<0
 S TN=+Y,X="T"_TN
 S DIC="^RC(347,",DIC(0)="XMN",D="D" D MIX^DIC1
 I +Y<0 W !!,"Unable to locate transaction in A/R Document file.",!! K TN G TRANS
 S REC=+Y
 S D0=REC D ^PRCATF2
 G TRANS
 ;
