RCTCSPD5 ;ALB/LMH-CROSS-SERVICING NON-FINANCIAL TRANSACTIONS ;03/15/14 3:34 PM
 ;;4.5;Accounts Receivable;**315,339,366**;Mar 20, 1995;Build 3
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;PRCA*4.5*366 Modify .03 pointer stuff to '////' in DR string
 ;
 Q
 ;
CSATRY ; Cross-Servicing Admin Adj Treasury Rev? Yes non-financial tx
 N PRCAEN,PRCAA1,DR,DIE,DA,D0,PRCAD,RCASK,PRCAA2,PRCA,PRCATY,RCUSER,X
 D SETTR^PRCAUTL,PATTR^PRCAUTL Q:'$D(PRCAEN)
 S PRCAA1=$S($D(^PRCA(433,PRCAEN,4,0)):+$P(^(0),U,4),1:0)
 Q:PRCAA1'>0  S PRCAA2=$P(^(0),U,3)
 S DIE="^PRCA(433,",DA=PRCAEN
 S DR=".03////"_PRCABN ;Bill Number
 S DR=DR_";3///0" ;Calm Code Done
 S DR=DR_";12///"_$O(^PRCA(430.3,"AC",53,0)) ;Transaction Type
 S DR=DR_";15///0" ;Transaction Amount
 S DR=DR_";42///"_DUZ ;Processed by user
 S DR=DR_";11///"_DT ;Transaction date
 S DR=DR_";4///2" ;Transaction status (complete)
 S DR=DR_";5.02///CS ADMIN ADJ TR REV?Y" D ^DIE
 Q
 ;
CSATRN ; Cross-Servicing Admin Adj Treasury Rev? No non-financial tx
 N PRCAEN,PRCAA1,DR,DIE,DA,D0,PRCAD,RCASK,PRCAA2,PRCA,PRCATY,RCUSER,X
 D SETTR^PRCAUTL,PATTR^PRCAUTL Q:'$D(PRCAEN)
 S PRCAA1=$S($D(^PRCA(433,PRCAEN,4,0)):+$P(^(0),U,4),1:0)
 Q:PRCAA1'>0  S PRCAA2=$P(^(0),U,3)
 S DIE="^PRCA(433,",DA=PRCAEN
 S DR=".03////"_PRCABN ;Bill Number
 S DR=DR_";3///0" ;Calm Code Done
 S DR=DR_";12///"_$O(^PRCA(430.3,"AC",54,0)) ;Transaction Type
 S DR=DR_";15///0" ;Transaction Amount
 S DR=DR_";42///"_DUZ ;Processed by user
 S DR=DR_";11///"_DT ;Transaction date
 S DR=DR_";4///2" ;Transaction status (complete)
 S DR=DR_";5.02///CS ADMIN ADJ TR REV?N" D ^DIE
 Q
 ;
CSITRY ; Cross-Servicing Incr Adj Treasury Rev? Yes non-financial tx
 N PRCAEN,PRCAA1,DR,DIE,DA,D0,PRCAD,RCASK,PRCAA2,PRCA,PRCATY,RCUSER,X
 D SETTR^PRCAUTL,PATTR^PRCAUTL Q:'$D(PRCAEN)
 S PRCAA1=$S($D(^PRCA(433,PRCAEN,4,0)):+$P(^(0),U,4),1:0)
 Q:PRCAA1'>0  S PRCAA2=$P(^(0),U,3)
 S DIE="^PRCA(433,",DA=PRCAEN
 S DR=".03////"_PRCABN ;Bill Number
 S DR=DR_";3///0" ;Calm Code Done
 S DR=DR_";12///"_$O(^PRCA(430.3,"AC",57,0)) ;Transaction Type
 S DR=DR_";15///0" ;Transaction Amount
 S DR=DR_";42///"_DUZ ;Processed by user
 S DR=DR_";11///"_DT ;Transaction date
 S DR=DR_";4///2" ;Transaction status (complete)
 S DR=DR_";5.02///CS INC ADJ TR REV?Y" D ^DIE
 Q
 ;
CSITRN ; Cross-Servicing Incr Adj Treasury Rev? No non-financial tx
 N PRCAEN,PRCAA1,DR,DIE,DA,D0,PRCAD,RCASK,PRCAA2,PRCA,PRCATY,RCUSER,X
 D SETTR^PRCAUTL,PATTR^PRCAUTL Q:'$D(PRCAEN)
 S PRCAA1=$S($D(^PRCA(433,PRCAEN,4,0)):+$P(^(0),U,4),1:0)
 Q:PRCAA1'>0  S PRCAA2=$P(^(0),U,3)
 S DIE="^PRCA(433,",DA=PRCAEN
 S DR=".03////"_PRCABN ;Bill Number
 S DR=DR_";3///0" ;Calm Code Done
 S DR=DR_";12///"_$O(^PRCA(430.3,"AC",58,0)) ;Transaction Type
 S DR=DR_";15///0" ;Transaction Amount
 S DR=DR_";42///"_DUZ ;Processed by user
 S DR=DR_";11///"_DT ;Transaction date
 S DR=DR_";4///2" ;Transaction status (complete)
 S DR=DR_";5.02///CS INC ADJ TR REV?N" D ^DIE
 Q
 ;
CSPRTR ; Cross-Servicing PENDING RECONCILIATION non-financial tx  
 ;       Called by R1^RCTCSPRS
 N PRCAEN,PRCAA1,DR,DIE,DA,D0,PRCAD,RCASK,PRCAA2,PRCA,PRCATY,RCUSER,DUZ
 ; DUZ is reserved, but in this case DUZ may be undefined due to a server background job, but we don't want to overwrite DUZ if it exists
 S PRCABN=BILL,DUZ=.5,DUZ(0)="@",DUZ(2)=1 ; Server has no DUZ, use Postmaster
 D SETTR^PRCAUTL,PATTR^PRCAUTL Q:'$D(PRCAEN)
 S PRCAA1=$S($D(^PRCA(433,PRCAEN,4,0)):+$P(^(0),U,4),1:0)
 Q:PRCAA1'>0  S PRCAA2=$P(^(0),U,3)
 S DIE="^PRCA(433,",DA=PRCAEN
 S DR=".03////"_PRCABN ;Bill Number
 S DR=DR_";3///0" ;Calm Code Done
 S DR=DR_";12///"_$O(^PRCA(430.3,"AC",61,0)) ;Transaction Type
 S DR=DR_";15///0" ;Transaction Amount
 S DR=DR_";42///"_DUZ ;Processed by user
 S DR=DR_";11///"_DT ;Transaction date
 S DR=DR_";4///2" ;Transaction status (complete)
 S DR=DR_";5.02///CS PEND RECON" D ^DIE
 Q
 ;
CSRCLPL ; CS RECALL placed non-financial tx
 N PRCAEN,PRCAA1,DR,DIE,DA,D0,PRCAD,RCASK,PRCAA2,PRCA,PRCATY,RCUSER
 S PRCABN=BILL
 D SETTR^PRCAUTL,PATTR^PRCAUTL Q:'$D(PRCAEN)
 S PRCAA1=$S($D(^PRCA(433,PRCAEN,4,0)):+$P(^(0),U,4),1:0)
 Q:PRCAA1'>0  S PRCAA2=$P(^(0),U,3)
 S DIE="^PRCA(433,",DA=PRCAEN
 S DR=".03////"_PRCABN ;Bill Number
 S DR=DR_";3///0" ;Calm Code Done
 S DR=DR_";12///"_$O(^PRCA(430.3,"AC",62,0)) ;Transaction Type
 S DR=DR_";15///0" ;Transaction Amount
 S DR=DR_";42///"_DUZ ;Processed by user
 S DR=DR_";11///"_DT ;Transaction date
 S DR=DR_";4///2" ;Transaction status (complete)
 S DR=DR_";5.02///CS RECALL PLACED" D ^DIE
 Q
 ; End of RCTCSPD5
