RCTCSPD4 ;ALB/LMH-CROSS-SERVICING NON-FINANCIAL TRANSACTIONS ;03/15/14 3:34 PM
 ;;4.5;Accounts Receivable;**315,339**;Mar 20, 1995;Build 2
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q 
 ;
STOP ; CS stop placed non-financial tx
 N PRCAEN,PRCAA1,DR,DIE,DA,D0,PRCAD,RCASK,PRCAA2,PRCA,PRCATY,RCUSER
 S PRCABN=BILL
 D SETTR^PRCAUTL,PATTR^PRCAUTL Q:'$D(PRCAEN)
 S PRCAA1=$S($D(^PRCA(433,PRCAEN,4,0)):+$P(^(0),U,4),1:0)
 Q:PRCAA1'>0  S PRCAA2=$P(^(0),U,3)
 S DIE="^PRCA(433,",DA=PRCAEN
 S DR=".03///"_PRCABN ;Bill Number
 S DR=DR_";3///0" ;Calm Code Done
 S DR=DR_";12///"_$O(^PRCA(430.3,"AC",33,0)) ;Transaction Type
 S DR=DR_";15///0" ;Transaction Amount
 S DR=DR_";42///"_DUZ ;Processed by user
 S DR=DR_";11///"_DT ;Transaction date
 S DR=DR_";4///2" ;Transaction status (complete)
 S DR=DR_";5.02///CS STOP PLACED" D ^DIE
 Q
 ;
DELSTOP ; CS delete stop non-financial tx
 N PRCAEN,PRCAA1,DR,DIE,DA,D0,PRCAD,RCASK,PRCAA2,PRCA,PRCATY,RCUSER
 S PRCABN=BILL
 D SETTR^PRCAUTL,PATTR^PRCAUTL Q:'$D(PRCAEN)
 S PRCAA1=$S($D(^PRCA(433,PRCAEN,4,0)):+$P(^(0),U,4),1:0)
 Q:PRCAA1'>0  S PRCAA2=$P(^(0),U,3)
 S DIE="^PRCA(433,",DA=PRCAEN
 S DR=".03///"_PRCABN ;Bill Number
 S DR=DR_";3///0" ;Calm Code Done
 S DR=DR_";12///"_$O(^PRCA(430.3,"AC",36,0)) ;Transaction Type
 S DR=DR_";15///0" ;Transaction Amount
 S DR=DR_";42///"_DUZ ;Processed by user
 S DR=DR_";11///"_DT ;Transaction date
 S DR=DR_";4///2" ;Transaction status (complete)
 S DR=DR_";5.02///CS STOP DELETED" D ^DIE
 Q
 ;
RCLL ; Recall from Cross-Servicing non-financial tx
 N PRCAEN,PRCAA1,DR,DIE,DA,D0,PRCAD,RCASK,PRCAA2,PRCA,PRCATY,RCUSER,DUZ
 ;DUZ is reserved, but in this case DUZ may be undefined due to batch background job
 S PRCABN=BILL,DUZ=.5,DUZ(0)="@",DUZ(2)=1 ; Server has no DUZ, use Postmaster
 D SETTR^PRCAUTL,PATTR^PRCAUTL Q:'$D(PRCAEN)
 S PRCAA1=$S($D(^PRCA(433,PRCAEN,4,0)):+$P(^(0),U,4),1:0)
 Q:PRCAA1'>0  S PRCAA2=$P(^(0),U,3)
 S DIE="^PRCA(433,",DA=PRCAEN
 S DR=".03///"_PRCABN ;Bill Number
 S DR=DR_";3///0" ;Calm Code Done
 S DR=DR_";12///"_$O(^PRCA(430.3,"AC",34,0)) ;Transaction Type
 S DR=DR_";15///0" ;Transaction Amount
 S DR=DR_";42///"_DUZ ;Processed by user
 S DR=DR_";11///"_DT ;Transaction date
 S DR=DR_";4///2" ;Transaction status (complete)
 S DR=DR_";5.02///CS BILL RECALL" D ^DIE
 Q
 ;
DELRCLL ; Cross-Servicing Delete Bill Recall non-financial tx
 ;
 N PRCAEN,PRCAA1,DR,DIE,DA,D0,PRCAD,RCASK,PRCAA2,PRCA,PRCATY,RCUSER
 S PRCABN=BILL
 D SETTR^PRCAUTL,PATTR^PRCAUTL Q:'$D(PRCAEN)
 S PRCAA1=$S($D(^PRCA(433,PRCAEN,4,0)):+$P(^(0),U,4),1:0)
 Q:PRCAA1'>0  S PRCAA2=$P(^(0),U,3)
 S DIE="^PRCA(433,",DA=PRCAEN
 S DR=".03///"_PRCABN ;Bill Number
 S DR=DR_";3///0" ;Calm Code Done
 S DR=DR_";12///"_$O(^PRCA(430.3,"AC",37,0)) ;Transaction Type
 S DR=DR_";15///0" ;Transaction Amount
 S DR=DR_";42///"_DUZ ;Processed by user
 S DR=DR_";11///"_DT ;Transaction date
 S DR=DR_";4///2" ;Transaction status (complete)
 S DR=DR_";5.02///CS DEL BILL RECALL" D ^DIE
 Q
 ;
NEWDEBTR ; CS add new debtor non-financial tx
 ;         Called by RCTCSPD
 N PRCAEN,PRCAA1,DR,DIE,DA,D0,PRCAD,RCASK,PRCAA2,PRCA,PRCATY,RCUSER,X,PRCABN
 S PRCABN=BILL,DUZ=.5,DUZ(0)="@",DUZ(2)=1 ; Server has no DUZ, use Postmaster
 D SETTR^PRCAUTL,PATTR^PRCAUTL Q:'$D(PRCAEN)
 S PRCAA1=$S($D(^PRCA(433,PRCAEN,4,0)):+$P(^(0),U,4),1:0)
 Q:PRCAA1'>0  S PRCAA2=$P(^(0),U,3)
 S DIE="^PRCA(433,",DA=PRCAEN
 S DR=".03///"_PRCABN ;Bill Number
 S DR=DR_";3///0" ;Calm Code Done
 S DR=DR_";12///"_$O(^PRCA(430.3,"AC",48,0)) ;Transaction Type
 S DR=DR_";15///0" ;Transaction Amount
 S DR=DR_";42///"_DUZ ;Processed by user
 S DR=DR_";11///"_DT ;Transaction date
 S DR=DR_";4///2" ;Transaction status (complete)
 S DR=DR_";5.02///CS NEW DBTR NEW BILL" D ^DIE
 Q
 ;
RCRSD ; CS Debtor Recall non-financial tx
 ; Set this debtor for Recall from Cross-Servicing
 N PRCAEN,PRCAA1,DR,DIE,DA,D0,PRCAD,RCASK,PRCAA2,PRCA,PRCATY,RCUSER,X
 ;DUZ is reserved, but in this case DUZ may be undefined due to batch background job
 S PRCABN=BILL,DUZ=.5,DUZ(0)="@",DUZ(2)=1 ; Server has no DUZ, use Postmaster
 D SETTR^PRCAUTL,PATTR^PRCAUTL Q:'$D(PRCAEN)
 S PRCAA1=$S($D(^PRCA(433,PRCAEN,4,0)):+$P(^(0),U,4),1:0)
 Q:PRCAA1'>0  S PRCAA2=$P(^(0),U,3)
 S DIE="^PRCA(433,",DA=PRCAEN
 S DR=".03///"_PRCABN ; BILL NUMBER
 S DR=DR_";3///0" ;Calm Code Done
 S DR=DR_";12///"_$O(^PRCA(430.3,"AC",35,0)) ;Transaction Type
 S DR=DR_";15///0" ;Transaction Amount
 S DR=DR_";42///"_DUZ ;Processed by user
 S DR=DR_";11///"_DT ;Transaction date
 S DR=DR_";4///2" ;Transaction status (complete)
 S DR=DR_";5.02///CS DEBTOR RECALL" D ^DIE
 Q
 ;
DELSETD(BILL) ; CS Delete Debtor Recall non-financial tx
 N PRCAEN,PRCAA1,DR,DIE,DA,D0,PRCAD,RCASK,PRCAA2,PRCA,PRCATY,RCUSERX
 S PRCABN=BILL
 D SETTR^PRCAUTL,PATTR^PRCAUTL Q:'$D(PRCAEN)
 S PRCAA1=$S($D(^PRCA(433,PRCAEN,4,0)):+$P(^(0),U,4),1:0)
 Q:PRCAA1'>0  S PRCAA2=$P(^(0),U,3)
 S DIE="^PRCA(433,",DA=PRCAEN
 S DR=".03///"_PRCABN ;Bill Number
 S DR=DR_";3///0" ;Calm Code Done
 S DR=DR_";12///"_$O(^PRCA(430.3,"AC",38,0)) ;Transaction Type
 S DR=DR_";15///0" ;Transaction Amount
 S DR=DR_";42///"_DUZ ;Processed by user
 S DR=DR_";11///"_DT ;Transaction date
 S DR=DR_";4///2" ;Transaction status (complete)
 S DR=DR_";5.02///CS DEL DEBTOR RECALL" D ^DIE
 Q
 ;
DEBTOR ; CS New Bill Existing Debtor non-financial tx
 ;
 N PRCAEN,PRCAA1,DR,DIE,DA,D0,PRCAD,RCASK,PRCAA2,PRCA,PRCATY,RCUSER,PRCABN
 S PRCABN=BILL,DUZ=.5,DUZ(0)="@",DUZ(2)=1 ; Server has no DUZ, use Postmaster
 D SETTR^PRCAUTL,PATTR^PRCAUTL Q:'$D(PRCAEN)
 S PRCAA1=$S($D(^PRCA(433,PRCAEN,4,0)):+$P(^(0),U,4),1:0)
 Q:PRCAA1'>0  S PRCAA2=$P(^(0),U,3)
 S DIE="^PRCA(433,",DA=PRCAEN
 S DR=".03///"_PRCABN ;Bill Number
 S DR=DR_";3///0" ;Calm Code Done
 S DR=DR_";12///"_$O(^PRCA(430.3,"AC",39,0)) ;Transaction Type
 S DR=DR_";15///0" ;Transaction Amount
 S DR=DR_";42///"_DUZ ;Processed by user
 S DR=DR_";11///"_DT ;Transaction date
 S DR=DR_";4///2" ;Transaction status (complete)
 S DR=DR_";5.02///CS DEBTOR NEW BILL" D ^DIE ; Revised as requested
 Q
 ;
CSCASE ;  Add Case Info non-financial tx 
 N PRCAEN,PRCAA1,DR,DIE,DA,D0,PRCAD,RCASK,PRCAA2,PRCA,PRCATY,RCUSER
 S PRCABN=BILL,DUZ=.5,DUZ(0)="@",DUZ(2)=1 ; Server has no DUZ, use Postmaster
 D SETTR^PRCAUTL,PATTR^PRCAUTL Q:'$D(PRCAEN)
 S PRCAA1=$S($D(^PRCA(433,PRCAEN,4,0)):+$P(^(0),U,4),1:0)
 Q:PRCAA1'>0  S PRCAA2=$P(^(0),U,3)
 S DIE="^PRCA(433,",DA=PRCAEN
 S DR=".03///"_PRCABN ;Bill Number
 S DR=DR_";3///0" ;Calm Code Done
 S DR=DR_";12///"_$O(^PRCA(430.3,"AC",47,0)) ;Transaction Type
 S DR=DR_";15///0" ;Transaction Amount
 S DR=DR_";42///"_DUZ ;Processed by user
 S DR=DR_";11///"_DT ;Transaction date
 S DR=DR_";4///2" ;Transaction status (complete)
 S DR=DR_";5.02///CS ADD CASE INFO" D ^DIE
 Q
 ;
DELSETC ; Cross-Servicing delete case recall non-financial tx
 N PRCAEN,PRCAA1,DR,DIE,DA,D0,PRCAD,RCASK,PRCAA2,PRCA,PRCATY,RCUSER
 S PRCABN=BILL
 D SETTR^PRCAUTL,PATTR^PRCAUTL Q:'$D(PRCAEN)
 S PRCAA1=$S($D(^PRCA(433,PRCAEN,4,0)):+$P(^(0),U,4),1:0)
 Q:PRCAA1'>0  S PRCAA2=$P(^(0),U,3)
 S DIE="^PRCA(433,",DA=PRCAEN
 S DR=".03///"_PRCABN ;Bill Number
 S DR=DR_";3///0" ;Calm Code Done
 S DR=DR_";12///"_$O(^PRCA(430.3,"AC",46,0)) ;Transaction Type
 S DR=DR_";15///0" ;Transaction Amount
 S DR=DR_";42///"_DUZ ;Processed by user
 S DR=DR_";11///"_DT ;Transaction date
 S DR=DR_";4///2" ;Transaction status (complete)
 S DR=DR_";5.02///CS DEL CASE RECALL" D ^DIE
 Q
 ;
DECADJ ; non-financial decrease adjustment transaction for 5b cross-servicing record
 N PRCAEN,PRCAA1,DR,DIE,DA,D0,PRCAD,RCASK,PRCAA2,PRCA,PRCATY,RCUSER
 S PRCABN=BILL
 D SETTR^PRCAUTL,PATTR^PRCAUTL Q:'$D(PRCAEN)
 S PRCAA1=$S($D(^PRCA(433,PRCAEN,4,0)):+$P(^(0),U,4),1:0)
 Q:PRCAA1'>0  S PRCAA2=$P(^(0),U,3)
 S DIE="^PRCA(433,",DA=PRCAEN
 S DR=".03///"_PRCABN ;Bill Number
 S DR=DR_";3///0" ;Calm Code Done
 S DR=DR_";12///"_$O(^PRCA(430.3,"AC",49,0)) ;Transaction Type
 S DR=DR_";15///0" ;Transaction Amount
 S DR=DR_";42///"_DUZ ;Processed by user
 S DR=DR_";11///"_DT ;Transaction date
 S DR=DR_";4///2" ;Transaction status (complete)
 S DR=DR_";5.02///CS DECREASE ADJ" D ^DIE
 Q 
 ;
DECADJ0 ; decrease adjustment transaction deletes cs date
 ; 5B tx takes bal. of bill to 0 
 ; if node 7 balances = 0.  Called by RCTCSPD
 N PRCAEN,PRCAA1,DR,DIE,DA,D0,PRCAD,RCASK,PRCAA2,PRCA,PRCATY,RCUSER
 S PRCABN=BILL
 D SETTR^PRCAUTL,PATTR^PRCAUTL Q:'$D(PRCAEN)
 S PRCAA1=$S($D(^PRCA(433,PRCAEN,4,0)):+$P(^(0),U,4),1:0)
 Q:PRCAA1'>0  S PRCAA2=$P(^(0),U,3)
 S DIE="^PRCA(433,",DA=PRCAEN
 S DR=".03///"_PRCABN ;Bill Number
 S DR=DR_";3///0" ;Calm Code Done
 S DR=DR_";12///"_$O(^PRCA(430.3,"AC",40,0)) ;Transaction Type
 S DR=DR_";15///0" ;Transaction Amount
 S DR=DR_";42///"_DUZ ;Processed by user
 S DR=DR_";11///"_DT ;Transaction date
 S DR=DR_";4///2" ;Transaction status (complete)
 S DR=DR_";5.02///CS DECR ADJ NOT APP" D ^DIE
 D CHKS
 Q 
 ;
RCRSC ; Cross-Servicing case recall non-financial tx
 N PRCAEN,PRCAA1,DR,DIE,DA,D0,PRCAD,RCASK,PRCAA2,PRCA,PRCATY,RCUSER
 ;DUZ is reserved, but in this case DUZ may be undefined due to batch background job
 S PRCABN=BILL,DUZ=.5,DUZ(0)="@",DUZ(2)=1 ; Server has no DUZ, use Postmaster
 D SETTR^PRCAUTL,PATTR^PRCAUTL Q:'$D(PRCAEN)
 S PRCAA1=$S($D(^PRCA(433,PRCAEN,4,0)):+$P(^(0),U,4),1:0)
 Q:PRCAA1'>0  S PRCAA2=$P(^(0),U,3)
 S DIE="^PRCA(433,",DA=PRCAEN
 S DR=".03///"_PRCABN ;Bill Number
 S DR=DR_";3///0" ;Calm Code Done
 S DR=DR_";12///"_$O(^PRCA(430.3,"AC",45,0)) ;Transaction Type
 S DR=DR_";15///0" ;Transaction Amount
 S DR=DR_";42///"_DUZ ;Processed by user
 S DR=DR_";11///"_DT ;Transaction date
 S DR=DR_";4///2" ;Transaction status (complete)
 S DR=DR_";5.02///CS CASE RECALL" D ^DIE
 Q
 ;
CHKS ;Leave validation checks in place
 I $P($G(^PRCA(433,PRCAEN,5)),"^",2)=""!'$P(^PRCA(433,PRCAEN,1),"^") S PRCACOMM="TRANSACTION INCOMPLETE" D DELETE^PRCAWO1 K PRCACOMM Q
 I '$D(PRCAD("DELETE")) S RCASK=1 D TRANUP^PRCAUTL,UPPRIN^PRCADJ
 I $P($G(^RCD(340,+$P(^PRCA(430,PRCABN,0),"^",9),0)),"^")[";DPT(" D
 .;Ensure comment does not appear on patient statement
 .S $P(^PRCA(433,PRCAEN,0),"^",10)=1
 Q
 ; End of RCTCSPD4
