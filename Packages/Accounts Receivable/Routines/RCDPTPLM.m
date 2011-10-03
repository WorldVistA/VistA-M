RCDPTPLM ;WISC/RFJ-transaction profile listmanager top routine ;1 Jun 99
 ;;4.5;Accounts Receivable;**114,198**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;  called from menu option (19)
 ;
 N RCTRANDA,RCDPFXIT
 ;
 F  D  Q:'RCTRANDA
 .   W !! S RCTRANDA=$$SELTRAN
 .   I RCTRANDA<1 S RCTRANDA=0 Q
 .   ;
 .   ;  check for transaction incomplete, do not enter lm
 .   I $P($G(^PRCA(433,RCTRANDA,0)),"^",4)=1 D  Q
 .   .   W !!,"  This transaction is INCOMPLETE.  The transaction must be complete"
 .   .   W !,"  before running this option."
 .   ;
 .   D EN^VALM("RCDP TRANS PROFILE")
 .   ;  fast exit
 .   I $G(RCDPFXIT) S RCTRANDA=0
 Q
 ;
 ;
INIT ;  initialization for list manager list
 ;  requires rctranda
 ;  fast exit
 I $G(RCDPFXIT) S VALMQUIT=1 Q
 D INIT^RCDPTPLI
 D HDR
 Q
 ;
 ;
HDR ;  header code for list manager display
 N RCBILLDA,RCTOTAL
 S RCBILLDA=$P($G(^PRCA(433,RCTRANDA,0)),"^",2)
 S RCTOTAL=$$BILLBAL^RCRJRCOB(RCBILLDA,DT)
 D HDR^RCDPBTLM
 Q
 ;
 ;
EXIT ;  exit list manager option and clean up
 K ^TMP("RCDPTPLM",$J),^TMP("RCDPBTLMX",$J)
 Q
 ;
 ;
SELTRAN() ;  select a transaction
 ;  returns -1 for timeout or ^, 0 for no selection, or ien of trans
 N %,%Y,C,DIC,DTOUT,DUOUT,X,Y
 N DPTNOFZY,DPTNOFZK S (DPTNOFZY,DPTNOFZK)=1
 S DIC="^PRCA(433,",DIC(0)="QEAM",DIC("A")="Select TRANSACTION: "
 D ^DIC
 I Y<0,'$G(DUOUT),'$G(DTOUT) S Y=0
 Q +Y
 ;
 ;
DIQ433(DA,DR) ;  diq call to retrieve data for dr fields in file 433
 N D0,DIC,DIQ,DIQ2
 K RCDPDATA(433,DA)
 S DIQ(0)="IE",DIC="^PRCA(433,",DIQ="RCDPDATA" D EN^DIQ1
 Q
 ;
 ;
NEWTRANS ;  select a new transaction
 D FULL^VALM1
 S VALMBCK="R"
 ;
 W !!,"This option will allow you to select a new transaction to display."
 W ! S %=$$SELTRAN
 I %<1 Q
 S RCTRANDA=%
 ;
 ;  if called from bill profile, pick new bill
 I $D(^TMP("RCDPBPLM",$J)) S RCBILLDA=$P(^PRCA(433,RCTRANDA,0),"^",2)
 ;  if called from account profile, pick new account
 I $D(^TMP("RCDPAPLM",$J)),RCBILLDA S RCDEBTDA=$P(^PRCA(430,RCBILLDA,0),"^",9)
 ;
 D INIT
 Q
