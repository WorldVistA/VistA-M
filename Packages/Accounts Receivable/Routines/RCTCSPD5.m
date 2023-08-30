RCTCSPD5 ;ALB/LMH - CROSS-SERVICING NON-FINANCIAL TRANSACTIONS ;03/15/14 3:34 PM
 ;;4.5;Accounts Receivable;**315,339,366,369,400**;Mar 20, 1995;Build 13
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;PRCA*4.5*369 Add text transaction for auto recall <$25
 Q
 ;
CSATRY ; Cross-Servicing Admin Adj Treasury Rev? Yes non-financial tx  PRCA*4.5*400
 ;
 ; assumes that BILL variable is defined and contains bill number
 ;
 D FILETRN(BILL,53,DUZ,"CS ADMIN ADJ TR REV?Y")
 Q
 ;
CSATRN ; Cross-Servicing Admin Adj Treasury Rev? No non-financial tx  PRCA*4.5*400
 ;
 ; assumes that BILL variable is defined and contains bill number
 ;
 D FILETRN(BILL,54,DUZ,"CS ADMIN ADJ TR REV?N")
 Q
 ;
CSITRY ; Cross-Servicing Incr Adj Treasury Rev? Yes non-financial tx  PRCA*4.5*400
 ;
 ; assumes that BILL variable is defined and contains bill number
 ;
 D FILETRN(BILL,57,DUZ,"CS INC ADJ TR REV?Y")
 Q
 ;
CSITRN ; Cross-Servicing Incr Adj Treasury Rev? No non-financial tx  PRCA*4.5*400
 ;
 ; assumes that BILL variable is defined and contains bill number
 ;
 D FILETRN(BILL,58,DUZ,"CS INC ADJ TR REV?N")
 Q
 ;
CSPRTR ; Cross-Servicing PENDING RECONCILIATION non-financial tx  PRCA*4.5*400
 ;       Called by R1^RCTCSPRS
 ;
 ; assumes that BILL variable is defined and contains bill number
 ;
 N DUZ
 S DUZ=.5,DUZ(0)="@",DUZ(2)=1 ; Server has no DUZ, use Postmaster
 D FILETRN(BILL,61,DUZ,"CS PEND RECON")
 Q
 ;
CSRCLPL ; CS RECALL placed non-financial tx  PRCA*4.5*400
 ;
 ; assumes that BILL variable is defined and contains bill number
 ;
 D FILETRN(BILL,62,DUZ,"CS RECALL PLACED")
 Q
 ;
CSRCLPL1 ; CS RECALL placed non-financial tx with "HRFS RECALL" comment (recall due to HRFS patient flag being set)  PRCA*4.5*400
 ;
 ; assumes that BILL variable is defined and contains bill number
 ;
 N CMNT
 S CMNT(1)="HRFS RECALL"
 D FILETRN(BILL,62,DUZ,"CS RECALL PLACED",.CMNT)
 Q
 ;
CSAUTORC ; Recall from Cross-Servicing non-financial tx    ; PRCA*4.5*400
 ;
 ; assumes that BILL variable is defined and contains bill number
 ;
 N DUZ
 S DUZ=.5,DUZ(0)="@",DUZ(2)=1 ; Server has no DUZ, use Postmaster
 D FILETRN(BILL,66,DUZ,"CS AUTO RECALL BILL <$25")
 Q
 ;
FILETRN(PRCABN,PRCATYP,DUZ,BRCMNT,CMNT) ; file transaction  PRCA*4.5*400
 ;
 ; PRCABN  - bill number
 ; PRCATYP - transaction type
 ; DUZ     - user DUZ to use
 ; BRCMNT  - brief comment
 ; CMNT    = comment (array containing data for WP field, format is CMNT(1)=line 1...CMNT(n)=line n)
 ;
 N FDA,IENS,PRCAEN,PRCAA1
 N DA,X  ; set and used in SETTR^PRCAUTL
 D SETTR^PRCAUTL,PATTR^PRCAUTL Q:'$D(PRCAEN)
 S PRCAA1=$S($D(^PRCA(433,PRCAEN,4,0)):+$P(^(0),U,4),1:0) Q:PRCAA1'>0
 S IENS=PRCAEN_","
 S FDA(433,IENS,.03)=PRCABN ; Bill Number
 S FDA(433,IENS,3)=0 ; Calm Code Done
 S FDA(433,IENS,4)=2 ; Transaction status (complete)
 S FDA(433,IENS,5.02)=$E(BRCMNT,1,30) ; Brief Comment
 S FDA(433,IENS,11)=DT ; Transaction Date
 S FDA(433,IENS,12)=$O(^PRCA(430.3,"AC",PRCATYP,0)) ; Transaction Type
 S FDA(433,IENS,15)=0 ; Transaction Amount
 S FDA(433,IENS,42)=DUZ ; Processed By User
 D FILE^DIE("","FDA")
 I $D(CMNT) D WP^DIE(433,IENS,41,"","CMNT")
 Q
