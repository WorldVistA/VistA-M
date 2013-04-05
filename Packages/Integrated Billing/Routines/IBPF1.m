IBPF1 ;ALB/CPM - FIND BILLING DATA TO ARCHIVE (CON'T.) ; 20-APR-92
 ;;2.0;INTEGRATED BILLING;**45,347**;21-MAR-94;Build 24
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
BILL ; Find all UB-82's which may be archived.  Check only those bills
 ; whose First Printed Date is prior to the last date on which a
 ; bill must have been closed out in Accounts Receivable.
 ;
 ;  Input:  IBEDT  --  last valid date on which a bill may be closed out
 ;         IBTMPL  --  search template in which to store entries
 ;  Output: IBCNT  --  number of IB Actions which may be archived.
 ;
 S (IBDT,IBN)="",IBCNT=0
 F  S IBDT=$O(^DGCR(399,"AP",IBDT)) Q:'IBDT!(IBDT>IBEDT)  F  S IBN=$O(^DGCR(399,"AP",IBDT,IBN)) Q:'IBN  I $$ALL(IBN,IBEDT) S IBCNT=IBCNT+1,^DIBT(IBTMPL,1,IBN)=""
 K IBCLO,IBDT,IBN
 Q
 ;
 ;
IB ; Find Pharmacy Co-pay IB Actions which may be archived.  Check
 ; only those Pharmacy Co-pay IB Actions which have been added to the
 ; database prior to the last date on which a bill must have been
 ; closed out in Accounts Receivable.  Only "parent actions" will
 ; be checked, and if the parent action may be archived, the parent
 ; and its "children" will all be marked for archiving.
 ;
 ;  Input:  IBEDT  --  last valid date on which a bill may be closed out
 ;         IBTMPL  --  search template in which to store entries
 ;  Output: IBCNT  --  number of IB Actions which may be archived.
 ;
 ; - first find all Pharmacy action types.
 K IBA F I=1:1 S IBATYPN=$P($T(PSO+I),";;",2,99) Q:IBATYPN=""  S IBATYP=$O(^IBE(350.1,"B",IBATYPN,0)) I IBATYP S IBA(IBATYP)=""
 ;
 ; - locate all Pharmacy Co-pay actions which may be archived.
 S (IBDT,IBN)="",IBCNT=0
 F  S IBDT=$O(^IB("D",IBDT)) Q:'IBDT!(IBDT>(IBEDT+.3))  D
 . F  S IBN=$O(^IB("D",IBDT,IBN)) Q:'IBN  D:$D(^IB("AD",IBN))
 ..  S IBND=$G(^IB(IBN,0)) Q:IBND=""  ; 0th node missing
 ..  Q:'$D(IBA(+$P(IBND,"^",3)))  ; not a Pharmacy co-pay action
 ..  Q:$$RXFILE(IBND)  ; billed prescription has not been archived
 ..  S IBAR=$P(IBND,"^",11) Q:IBAR=""
 ..  S X="RCFN03" X ^%ZOSF("TEST")
 ..  S IBAR=$S($T:$$BIEN^RCFN03(IBAR),1:$O(^PRCA(430,"B",IBAR,0)))
 ..  I IBAR,$$CLO(IBAR,IBEDT) F DA=0:0 S DA=$O(^IB("AD",IBN,DA)) Q:'DA  S IBCNT=IBCNT+1,^DIBT(IBTMPL,1,DA)=""
 ;
 ; - kill variables and quit.
 K DA,IBA,IBAR,IBATYP,IBATYPN,IBCLO,IBDT,IBN,IBND,X
 Q
 ;
 ;
RXFILE(IBND) ; Is the prescription still resident on-line?
 ;         Input:    IBND  --  zeroth node of IB Action
 ;         Output:     1   --  the rx is still on file
 ;                     0   --  the rx is no longer on file (archived)
 N IBSL,RXCHK
 S IBSL=$P(IBND,"^",4) I +IBSL'=52 Q 0
 S IBSL=$P(IBSL,":",2)
 S RXCHK=$$FILE^IBRXUTL(+IBSL,.01)
 I RXCHK'="" Q 1
 Q 0
 ;
ALL(IBN,DATE) ; Are all bills for an episode of care closed before DATE?
 ;         Input:     IBN  --  ien of bill in file #399
 ;                   DATE  --  the date by which the bills must be closed
 ;         Output:     1   --  all bills are closed
 ;                     0   --  at least one bill is not closed
 N I,X
 S X=$$CLO(IBN,DATE)
 I X S I=0 F  S I=$O(^DGCR(399,"AC",IBN,I)) Q:'I  I I'=IBN,'$$CLO(I,DATE) S X=0 Q
 Q X
 ;
CLO(IBN,DATE) ; Is the bill closed before DATE?
 ;         Input:     IBN  --  ien of bill in file #399
 ;                   DATE  --  the date by which the bill must be closed
 ;         Output:     1   --  the bill is closed
 ;                     0   --  the bill is not closed
 N CLO S CLO=$$PUR^PRCAFN(IBN)
 Q $S(CLO=-2:1,CLO=-1:0,1:CLO'>DATE)
 ;
 ;
PSO ; Pharmacy Co-pay Action Types
 ;;PSO NSC RX COPAY CANCEL
 ;;PSO NSC RX COPAY NEW
 ;;PSO NSC RX COPAY UPDATE
 ;;PSO SC RX COPAY CANCEL
 ;;PSO SC RX COPAY NEW
 ;;PSO SC RX COPAY UPDATE
 ;
