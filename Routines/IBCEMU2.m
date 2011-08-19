IBCEMU2 ;ALB/DSM - IB MRA Utility ;01-MAY-2003
 ;;2.0;INTEGRATED BILLING;**155,320,349,436**;21-MAR-94;Build 31
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
QMRA ; This is a background procedure that is spun off of the IB BATCH
 ; Print option. This process scans a queue in ^XTMP("IBMRA"_#,$J) and checks
 ; each Bill to see if a printable MRA exist, if so, prints them. MRA's print
 ; on the device associated with the 'Bill Addendum' Form Type.
 ; This process doesn't interact with users.
 ;
 ; IB*2*320:  MCS - Resubmit by Print produces a scratch global also
 ;            ^XTMP("IBCFP6",$J,.... for MRA's to print here
 ;
 ; Input:
 ;      IBJ   = $J of starting job
 ;      IBFTP = "IBMRA"_# (ien of form type) or "IBCFP6"
 ;
 N IBS1,IBS2,IBS3,IBIFN,IBQ,IBPGN
 S (IBS1,IBIFN,IBQ)=0
 F  S IBS1=$O(^XTMP(IBFTP,IBJ,IBS1)) Q:IBS1=""  D  I IBQ Q
 . S IBS2=0 F  S IBS2=$O(^XTMP(IBFTP,IBJ,IBS1,IBS2)) Q:IBS2=""  D  I IBQ Q
 . . S IBS3=0 F  S IBS3=$O(^XTMP(IBFTP,IBJ,IBS1,IBS2,IBS3)) Q:IBS3=""  D  I IBQ Q
 . . . S IBIFN=0 F  S IBIFN=$O(^XTMP(IBFTP,IBJ,IBS1,IBS2,IBS3,IBIFN)) Q:IBIFN=""  D  I $$STOP S IBQ=1 Q
 . . . . I $$MRAEXIST^IBCEMU1(IBIFN) D PROC^IBCEMRAA W @IOF ;must have IBIFN set
 K ^XTMP(IBFTP,IBJ) S ZTREQ="@"
 Q  ;QMRA
 ;
STOP() ;determine if user has requested the queued report to stop
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1 K ZTREQ I +$G(IBPGN) W !,"***TASK STOPPED BY USER***"
 Q +$G(ZTSTOP)
 ;
 ;
STAT(IBIFN,STATUS,MRAONLY) ; Update the review status in the EOB file
 ; This procedure updates field .16 in file 361.1 for all EOB's for
 ; the given bill#
 ; 
 ;   IBIFN   - Internal Bill# (required)
 ;   STATUS  - Internal Value of the Review Status field (required)
 ;   MRAONLY - Optional Flag with a default of 0 if not passed in
 ;             1:only update MRA EOB's for this bill
 ;             0:update all EOB's for this bill
 ;
 NEW RESULT,IBEOB,IBM
 NEW DIE,DA,DR,D,D0,DI,DIC,DICR,DIG,DIH,DISYS,DIU,DIV,DIW,DQ,DIERR,X,Y
 S IBIFN=+$G(IBIFN),STATUS=$G(STATUS)
 S MRAONLY=$G(MRAONLY,0)
 ;
 I '$D(^IBM(361.1,"B",IBIFN)) G STATX    ; no EOB's for this bill
 D CHK^DIE(361.1,.16,,STATUS,.RESULT)
 I RESULT="^" G STATX                    ; invalid status passed in
 ;
 S IBEOB=0        ; loop thru all EOB's for the bill
 F  S IBEOB=$O(^IBM(361.1,"B",IBIFN,IBEOB)) Q:'IBEOB  D
 . S IBM=$G(^IBM(361.1,IBEOB,0))
 . I $P(IBM,U,16)=STATUS Q           ; no change
 . I MRAONLY,'$P(IBM,U,4) Q          ; skip because of parameter
 . S DIE=361.1,DA=IBEOB,DR=".16////"_STATUS D ^DIE
 . Q
 ;
STATX ;
 Q
 ;
MRAWL(IBIFN) ; Do any MRA EOB's for this bill appear on the worklist?
 ;
 ; This function returns 1 if at least one MRA EOB for the given bill
 ; appears on the MRA management worklist.  Otherwise, this function
 ; returns 0.
 ;
 NEW OK,IBEOB
 S OK=0,IBIFN=+$G(IBIFN)
 I '$D(^IBM(361.1,"B",IBIFN)) G MRAWLX     ; no EOB's for this bill
 S IBEOB=0        ; loop thru all EOB's for the bill
 F  S IBEOB=$O(^IBM(361.1,"B",IBIFN,IBEOB)) Q:'IBEOB  D  Q:OK
 . I $$ELIG^IBCECOB1(IBEOB) S OK=1
 . Q
MRAWLX ;
 Q OK
 ;
TXSTS(IBIFN,IB364,REJFLG,IBZ) ; Claim transmission status information
 ; Input   IBIFN - required
 ;         IB364 - optional (defaults to most recent transmission#)
 ; Output  REJFLG (pass by reference) - 1/0 flag if any rejection status
 ;                                      messages on file
 ;         IBZ (pass by reference) - array of information
 ;
 NEW IEN,SMCNT,SEV,BCH,BCHD0,BCHD1
 S REJFLG=0 K IBZ
 S IBIFN=+$G(IBIFN) I 'IBIFN G TXSTSX
 S IB364=+$G(IB364)
 I 'IB364 S IB364=$$LAST364^IBCEF4(IBIFN) I 'IB364 G TXSTSX
 I $P($G(^IBA(364,IB364,0)),U,1)'=IBIFN G TXSTSX
 S IEN=0,SMCNT=0
 F  S IEN=$O(^IBM(361,"AERR",IB364,IEN)) Q:'IEN  D
 . S SMCNT=SMCNT+1
 . S SEV=$P($G(^IBM(361,IEN,0)),U,3)   ; status message severity
 . I SEV="R" S REJFLG=1
 . Q
 S BCH=+$P($G(^IBA(364,IB364,0)),U,2)  ; batch ien
 S BCHD0=$G(^IBA(364.1,BCH,0))
 S BCHD1=$G(^IBA(364.1,BCH,1))
 S IBZ("DATE LAST SENT")=$P(BCHD1,U,3)
 S IBZ("NUMBER OF STATUS MESSAGES")=SMCNT
 S IBZ("BATCH NUMBER")=$P(BCHD0,U,1)
 S IBZ("TRANSMISSION STATUS")=$P($G(^IBA(364,IB364,0)),U,3)
TXSTSX ;
 Q
 ;
MRACALC(IBEOB,IBIFN,AR,PRCASV) ; Calculates Two Amounts:
 ;  Unreimbursable Medicare Expense and Medicare Contract Adjustment
 ;  Amount for a given EOB.
 ;
 ; Input   IBIFN= ien of Claim file 399 - Required
 ;         IBEOB= ien of EOB file 361.1 - Required
 ;         AR=    Flag indicating this was called from AR function
 ; Input/Output  PRCASV= array with the two calculated values
 ;         PRCASV("MEDURE")=Unreimbursable Medicare Expense
 ;         PRCASV("MEDCA")=Medicare Contract Adjustment Amount
 ;
 ; For multiple EOB's, add up the calculated values across EOB's
 ;
 N I,LNLVL,EOBADJ,IBCOBN,INPAT,FRMTYP
 ;
 S FRMTYP=$$FT^IBCEF(IBIFN)       ;Form Type 2=1500; 3=UB
 S INPAT=$$INPAT^IBCEF(IBIFN)     ;Inpat/Outpat Flag
 S AR=$G(AR,0)    ;initialize AR flag
 F I=0,1,2 S IBEOB(I)=$G(^IBM(361.1,IBEOB,I))
 I $P(IBEOB(0),U,4)'=1 Q  ;make sure it's an MRA
 S IBCOBN=$$COBN^IBCEF(IBIFN) ;get current bill sequence
 ; Make sure we're on the right insurance sequence when AR flag is on
 I AR I $P(IBEOB(0),U,15)'=(IBCOBN-1) Q
 ;
 ; Unreimburseable Medicare Expense (same calc regardless of form type)
 ; For multiple EOB's, add up the amounts across EOB's
 S PRCASV("MEDURE")=$G(PRCASV("MEDURE"))+IBEOB(1)
 ;
 ; Handle CMS-1500 Form Type Next:
 I FRMTYP=2 D MEDCARE(IBEOB,.PRCASV) Q
 ;
 ; Handle UB Form Type Next:
 ; If Inpatient Calculate from Claim level data
 I INPAT D  Q  ;
 . K EOBADJ M EOBADJ=^IBM(361.1,IBEOB,10)
 . S PRCASV("MEDCA")=$G(PRCASV("MEDCA"))+$$CALCMCA(.EOBADJ)
 ;
 ; If Outpatient Calculate from Service Line level data
 D MEDCARE(IBEOB,.PRCASV)
 Q  ;MRACALC
 ;
MEDCARE(IBEOB,PRCASV) ; If Outpatient Calculate from Service Line level data
 N LNLVL,EOBADJ
 S LNLVL=0
 F  S LNLVL=$O(^IBM(361.1,IBEOB,15,LNLVL)) Q:'LNLVL  D  ;
 . K EOBADJ
 . M EOBADJ=^IBM(361.1,IBEOB,15,LNLVL,1)
 . ; Total up the Medicare Contract Adjustment across ALL Service Lines
 . S PRCASV("MEDCA")=$G(PRCASV("MEDCA"))+$$CALCMCA(.EOBADJ)
 Q  ;MEDCARE
 ;
CALCMCA(EOBADJ) ; FUNCTION - Calculate Medicare Contract Adjustment
 ; Sums up Amounts on ALL Reason Codes under ALL Group Codes = 'CO' and
 ; returns that value (which is Medicare Contract Adjustment).
 ;
 ; Input  EOBADJ = Array of Group Codes & Reason Codes from either the Claim 
 ;                 Level (10) or Service Line Level (15) of EOB file (#361.1)
 ; Output  returns Medicare Contract Adjustment
 ;
 N GRPLVL,RSNLVL,RSNAMT,MCA
 S (GRPLVL,MCA)=0
 F  S GRPLVL=$O(EOBADJ(GRPLVL)) Q:'GRPLVL  D  ;
 . I $P($G(EOBADJ(GRPLVL,0)),U)'="CO" Q
 . S RSNLVL=0
 . F  S RSNLVL=$O(EOBADJ(GRPLVL,1,RSNLVL)) Q:'RSNLVL  D  ;
 . . S RSNAMT=$P($G(EOBADJ(GRPLVL,1,RSNLVL,0)),U,2)
 . . S MCA=MCA+RSNAMT
 Q MCA  ;CALCMCA
 ;
ALLOWED(IBEOB) ; Returns Total Allowed Amount by summing up all Allowed Amounts 
 ; from Line Level Adjustment
 ; Input: IBEOB = ien of EOB file (361.1)
 ; 
 N LNLVL,LNLVLD,ALWD,TOTALWD
 S (LNLVL,TOTALWD)=0
 F  S LNLVL=$O(^IBM(361.1,IBEOB,15,LNLVL)) Q:'LNLVL  S LNLVLD=^(LNLVL,0) D
 . S ALWD=$P(LNLVLD,U,13),TOTALWD=TOTALWD+ALWD   ; Allowed Amount
 Q TOTALWD  ;ALLOWED
 ;
MRATYPE(BILL,ARDATE) ; Function - determines the MRA Receivable Type for a Third
 ; Party Receivable. This is accomplished by comparing DATE MRA FIRST ACTIVATED
 ; with AR Activation Date for the Bill.
 ; 
 ; Input     BILL= ien of a given Bill Number (Required)
 ;         ARDATE= Date Account Receivable was Activated - date only  (Required)
 ;
 ; Output - Possible Types:
 ;          1 = Pre-MRA implementation
 ;          2 = Post MRA Medicare Receivable
 ;          3 = Post MRA non-Medicare Receivable
 ;
 N MRADTACT,MRAMT
 I '$G(ARDATE)!'$G(BILL) Q 1
 ;
 ; get DATE MRA FIRST ACTIVATED at site
 S MRADTACT=$$MRADTACT()
 ;
 ; MRA not Activated at site
 I MRADTACT="" Q 1 ;MRATYPE
 ; 
 ; Bill from pre-MRA implementation era
 I ARDATE<MRADTACT Q 1 ;MRATYPE
 ;
 ; Post-MRA Medicare bill; get Medicare amounts
 S MRAMT=$G(^PRCA(430,BILL,13))
 ; check Medicare Contractual Adjustment Amount
 I $P(MRAMT,U,1) Q 2 ;MRATYPE
 ; check Medicare Unreimburseable Amout
 I $P(MRAMT,U,2) Q 2 ;MRATYPE
 ; check if bill is a Medicare one
 I $$MRAEXIST^IBCEMU1(BILL) Q 2 ;MRATYPE
 ; check if bill is a Medicare Supplemental one
 I $P($$CRIT^IBRFN2(BILL),U)=2 Q 2 ;MRATYPE
 ;
 ; all others are Post-MRA non-Medicare bills
 Q 3 ;MRATYPE
 ;
MRADTACT() ; Function - returns DATE MRA FIRST ACTIVATED at site
 Q $P($G(^IBE(350.9,1,8)),U,13)
 ;
 ;** start IB*2.0*436 **
MRACALC2(IBIFN) ; Function - This tag will add all EOB's for a given claim number. 
 ; Returns the sum of the Medicare Contractual Adj Amt
 ;
 ; Input:  IBIFN            - ien of Claim file 399
 ; Output: PRCASV("MEDCA")  - Medicare Contractual Adj Amt
 ;
 ; Variables IBEOB          = ien of EOB file 361.1
 ;           PRCASV("MEDCA")= Medicare Contractual Adj Amt
 ; Note:
 ;   For clarification, the following terms mean exactly the same thing.
 ;   "Medicare Contractual Adj Amt" = "Medicare Unpaid Amt" = "Medicare Unallowable Amt"
 N IBEOB,I,LNLVL,EOBADJ,IBCOBN,INPAT,FRMTYP,PRCASV
 ;
 S PRCASV("MEDCA")=0
 S FRMTYP=$$FT^IBCEF(IBIFN)       ;Form Type 2=1500; 3=UB
 S INPAT=$$INPAT^IBCEF(IBIFN)     ;Inpat/Outpat Flag
 ; Get EOB data
 S IBEOB=0
 F  S IBEOB=$O(^IBM(361.1,"B",IBIFN,IBEOB)) Q:'IBEOB  D
 . F I=0,1,2 S IBEOB(I)=$G(^IBM(361.1,IBEOB,I))
 . I $P(IBEOB(0),U,4)'=1 Q  ;make sure it's an MRA
 . S IBCOBN=$$COBN^IBCEF(IBIFN) ;get current bill sequence
 . ;
 . ; Handle CMS-1500 Form Type Next:
 . I FRMTYP=2 D MEDCARE(IBEOB,.PRCASV) Q
 . ;
 . ; Handle UB Form Type Next:
 . ; If Inpatient Calculate from Claim level data
 . I INPAT D  Q  ;
 . . K EOBADJ M EOBADJ=^IBM(361.1,IBEOB,10)
 . . S PRCASV("MEDCA")=$G(PRCASV("MEDCA"))+$$CALCMCA(.EOBADJ)
 . ; If Outpatient Calculate from Service Line level data
 . D MEDCARE(IBEOB,.PRCASV)
 Q PRCASV("MEDCA") ;MRACALC2
 ;** end IB*2.0*436 **
