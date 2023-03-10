RCDPEM ;ALB/TMK/PJH - POST EFT, ERA MATCHING TO EFT ;Jun 06, 2014@19:11:19
 ;;4.5;Accounts Receivable;**173,255,269,276,283,298,304,318,321,326,345,349**;Mar 20, 1995;Build 44
 ;Per VA Directive 6402, this routine should not be modified.
 ; IA 4050 covers call to SPL1^IBCEOBAR
 ; Note - keep processing in line with RCDPXPAP
 ;
EN ; Post EFT deposits, auto-match EFT's and ERA's 
 ;
 K ^TMP($J,"RCDPETOT"),^TMP("RCDPEAP",$J)
 ; ^TMP($J,"RCDPETOT",344.3 or 344.31,file ien)=
 ;  (1) match (0/1/-1)   (2) total $   (3) posted (0/1)  (4) error ref
 ;  (5) EFT deposit ien 344.1 if added for EFT
 ;
 N RCZ,RCSUM,RCDEP,RECTDA,RC0,RCER,RCDUZ,Z,Z0,Z1,DA,X,Y,DIE,DR
 M RCDUZ=DUZ
 N DUZ S DUZ=+$O(^VA(200,"B","EDILOCKBOX,AUTOMATIC",0)),DUZ(0)="",DUZ(2)=$G(RCDUZ(2)) S:'DUZ DUZ=.5
 K ^TMP($J,"RCXM"),^TMP($J,"RCTOT")
 S ZTREQ="@"
 L +^RCY(344.3,"ALOCK"):5 I '$T D  G ENQ ; Lock record
 . ; Send bulletin that job could not be run
 . S ^TMP($J,"RCXM",1)="The nightly job to post EFT deposits and match EFTs to ERAs could not be run",^TMP($J,"RCXM",2)="Another match process was already running (lock on ^RCY(344.3,""ALOCK"") )"
 . D SENDBULL^RCDPEM1
 ;
 ; Post deposits for any unposted EFTs in file 344.3
 ; 'Unposted' EFTs have a 0 in AMOUNT POSTED field
 S ^TMP($J,"RCTOT","EFT_DEP")=0
 S RCZ=0 F  S RCZ=$O(^RCY(344.3,"APOST",0,RCZ)) Q:'RCZ  S RC0=$G(^RCY(344.3,RCZ,0))  I RC0'="",$P(RC0,U,8) D
 . S ^TMP($J,"RCTOT","EFT_DEP")=^TMP($J,"RCTOT","EFT_DEP")+1
 . ; Verify check sums
 . S RCSUM=$$CHKSUM^RCDPESR3(RCZ)
 . I RCSUM'=$P(RC0,U,9) D  Q
 .. ; Bulletin that check sums do not match
 .. ; Update record error list and checksum error field
 .. S RCER(1)=$$SETERR^RCDPEM0(2)
 .. S RCER(2)="  Checksum is invalid and the EFT deposit record is corrupted.",RCER(3)="  Stored Checksum = "_$P(RC0,U,9)_" Calculated Checksum: "_RCSUM,RCER(4)="  This EFT deposit cannot be sent to FMS.  You must ask for it to be"
 .. S RCER(5)="   retransmitted to your site."
 .. D BULL^RCDPEM1(344.3,RC0,.RCER)
 .. S $P(^TMP($J,"RCDPETOT",344.3,RCZ),U,4)=+$G(^TMP($J,"RCXM",0))
 .. D STORERR^RCDPEM0(RCZ,.RCER)
 .. S DIE="^RCY(344.3,",DA=RCZ,DR=".1////1" D ^DIE
 .. S ^TMP($J,"RCTOT","CSUM")=$G(^TMP($J,"RCTOT","CSUM"))+1
 . ;
 . S RCDEP=+$P(RC0,U,3),RECTDA=+$O(^RCY(344,"AD",RCDEP,0))
 . I RCDEP D LOCKDEP(RCDEP,1)
 . I 'RCDEP!'RECTDA D  ;  Add deposit and/or receipt to files 344.1, 344
 .. I 'RCDEP D  ; Add dep record RCDEP, update field .03 with the pointer
 ... S RCDEP=+$$ADDDEP^RCDPEM0($P(RC0,U,6),$P(RC0,U,7),RCZ)
 ... S ^TMP($J,"RCTOT","DEPOSIT")=$G(^TMP($J,"RCTOT","DEPOSIT"))+1
 .. ;
 .. I 'RECTDA,RCDEP D  ; Add receipt record, post to rev source cd 8NZZ
 ... S RECTDA=+$$ADDREC^RCDPEM0(RCDEP,RCZ)
 .. ;
 . I RCDEP D LOCKDEP(RCDEP,0)
 . ;
 . I 'RCDEP!'RECTDA D  Q  ; Could not add entry to file 344.1 or 344 
 .. ; Send a bulletin, update error text
 .. S RCER(1)=$$SETERR^RCDPEM0(2),RCER(2)="  "_$S('RCDEP:"Neither a deposit nor a receipt were able",1:"A receipt was not able")_" to be added - no match attempted"
 .. I RCDEP,'RECTDA S RCER(3)="  Deposit Ticket # created: "_$P($G(^RCY(344.1,+$P(RC0,U,3),0)),U)
 .. S RCER($O(RCER(""),-1)+1)="This EFT deposit can't be sent to FMS.  You must ask Austin to retransmit"
 .. D BULL^RCDPEM1(344.3,RC0,.RCER)
 .. S $P(^TMP($J,"RCDPETOT",344.3,RCZ),U,4)=+$G(^TMP($J,"RCXM",0))
 .. D STORERR^RCDPEM0(RCZ,.RCER)
 .. S ^TMP($J,"RCTOT","ERR")=$G(^TMP($J,"RCTOT","ERR"))+1
 . ;
 . S DIE="^RCY(344.31," S Z=0 F  S Z=$O(^RCY(344.31,"B",RCZ,Z)) Q:'Z  S DA=Z,DR=".11////1" D ^DIE
 ;
 ;Update payer table for new payers - PRCA*4.5*298
 D NEWPYR^RCDPESP
 ;Scan Non-Released Rx Exceptions for released Rx - PRCA*4.5*298
 D EN^RCDPEX4
 ;
 D MATCH(0,1)
 ;
 ;Auto Post - PRCA*4.5*298
 D EN^RCDPEAP
 ;Auto Decrease - PRCA*4.5*298
 D EN^RCDPEAD
 ;
 I $$GET1^DIQ(342,"1,",.14,"I") D EN^RCDPEAD3() ; PRCA*4.5*345 - 1st Party Auto-Decrease
 ;
 ;Workload Notifications - PRCA*4.5*321
 D EN^RCDPEM7
 ;
 L -^RCY(344.3,"ALOCK")
ENQ K ^TMP($J,"RCDPETOT"),^TMP("RCDPEAP",$J)
 ;
 ;ePayments 5010 part II enhancements
 ;Create Bulletins of EEOB Moved or Copied today
 D EN^RCDPEM8
 Q
 ;
MATCH(RCMAN,RCPROC) ; match unmatched EFTs with ERAs
 ; RCMAN = 1 if job run manually, outside of nightly processing
 ; RCPROC = 1 if called from EFT-EOB automatch, 0 if from manual match
 ;
 N RC0,RCER,RCZ,RCHAC
 I '$O(^RCY(344.31,"AMATCH",0,0)) D  G MATCHQ
 . ; Send bulletin - no unmatched EFTs found
 . N RCT
 . S RCT=+$O(^TMP($J,"RCXM"," "),-1)+1
 . S ^TMP($J,"RCXM",RCT)=$S('$G(RCMAN):"The nightly job",1:"The manual option")_" to match EFTs has found no EFTs are currently unmatched on your system"
 . I $G(RCMAN) S ^TMP($J,"RCXM",RCT+1)="The action was initiated by "_$P($G(^VA(200,DUZ,0)),U)
 . D SENDBULL^RCDPEM1
 ;
 S RCZ=0 F  S RCZ=$O(^RCY(344.31,"AMATCH",0,RCZ)) Q:'RCZ  D
 . K RCER
 . S RC0=$G(^RCY(344.31,RCZ,0)),RCHAC=($E($P($G(^RCY(344.3,+RC0,0)),U,6),1,3)="HAC")
 . Q:RC0=""  ; Bad xref
 . Q:$S('RCHAC:'$P(RC0,U,11),1:0)  ; EFT deposit must have been recorded
 . S ^TMP($J,"RCTOT","EFT")=$G(^TMP($J,"RCTOT","EFT"))+1
 . I RCHAC S ^TMP($J,"RCTOT","EFT_HAC")=$G(^TMP($J,"RCTOT","EFT_HAC"))+1
 . S ^TMP($J,"RCDPETOT",344.31,RCZ)=""
 . ;
 . D MATCH^RCDPEM0(RCZ,RCPROC)
 ;
 I '$O(^TMP($J,"RCXM",0)) K RCER S RCER(1)="",RCER(2)="NO EXCEPTIONS WHILE MATCHING EFTs-ERAs OR IN RECORDING THE DEPOSITS TO FMS" D BULL^RCDPEM1("","",.RCER) K RCER
 D EN2^RCDPEM1,BULL^RCDPEM1("","",.RCER)
 D SENDBULL^RCDPEM1
 ;
MATCHQ K ^TMP($J,"RCDPETOT"),^TMP($J,"RCTOT")
 Q
 ;
LOCKDEP(RCDEP,LOCK) ; Lock/confirm deposit ien RCDEP file 341.1
 ; If LOCK = 1 lock deposit
 ; If LOCK = 0 unlock deposit
 I $G(LOCK) D
 . L +^RCY(344.1,RCDEP,0):DILOCKTM
 . D CONFIRM^RCDPUDEP(RCDEP) ; confirm to prevent changes
 I '$G(LOCK) L -^RCY(344.1,RCDEP,0)
 Q
 ; PRCA*4.5*326 Add RCDUZ to parameters
RCPTDET(RCRZ,RECTDA1,RCER,RCDUZ) ; Adds detail to a receipt based on file 344.49
 ; RCRZ = ien of ERA entry in file 344.49
 ; RECTDA1 = ien of receipt entry in file 344
 ; RCER = error array returned if passed by reference
 ;
 N DA,DIE,DR,Q,RCR,RCSPL,RCZ0,RCTRANDA,RCQ,X,Y,Z0,Z1,Z ; PRCA*4.5*318
 ;
 S RCR=0 F  S RCR=$O(^RCY(344.49,RCRZ,1,RCR)) Q:'RCR  D
 . S RCZ0=$G(^RCY(344.49,RCRZ,1,RCR,0))
 . I $P(RCZ0,U)'["." S RCSPL(+RCZ0)=$P(RCZ0,U,9) Q
 . I $S(+$P(RCZ0,U,3)=0:$P($G(^RCY(344.49,RCRZ,0)),U,3),1:$P(RCZ0,U,3)<0) S RCSPL(RCZ0\1,+RCZ0)=RCZ0 Q
 . S RCTRANDA=$$ADDTRAN^RCDPURET(RECTDA1,$G(RCDUZ)) ; PRCA*4.5*326 Add RCDUZ to parameters
 . ;
 . I RCTRANDA'>0 D  Q  ; Error adding receipt detail - PRCA*4.5*318
 .. S RCER(1)=$$SETERR^RCDPEM0(1) ; PRCA*4.5*318 - pass RCPROC value to $$SETERR
 .. S RCER($O(RCER(""),-1)+1)="  NO DETAIL LINE ADDED TO RECEIPT "_$P($G(^RCY(344,RECTDA1,0)),U)_" FOR LINE #"_$P(RCZ0,U)_" IN EEOB WORKLIST SCRATCH PAD"
 . ;
 . ;Store receipt line detail
 . D DET(RCRZ,RCR,RECTDA1,RCTRANDA)
 . S RCSPL(RCZ0\1,+RCZ0)=RCZ0
 ;
 ; Update A/R CORRECTED PAYMENT multiple with apportionment for split lines
 S Z=0 F  S Z=$O(RCSPL(Z)) Q:'Z  S RCQ=+$G(RCSPL(Z)) I RCQ D
 . S Z1=$O(RCSPL(Z,"")) Q:Z1=""
 . I $O(RCSPL(Z,""),-1)=Z1,'$$SPLIT(Z,Z1,RCERA) Q  ; No split occurred
 . S Z1=0 F  S Z1=$O(RCSPL(Z,Z1)) Q:'Z1  S Z0=$G(RCSPL(Z,Z1)) D
 .. S Q=+$P($G(^RCY(344.4,RCRZ,1,RCQ,0)),U,2) ; EOB detail rec
 .. Q:'Q
 .. I '$P(Z0,U,7)!($P(Z0,U,2)="") D  ; Suspensed
 ... D SPL1^IBCEOBAR(Q,$S($P(Z0,U,2)="":"NO BILL",1:$P(Z0,U,2)),"",$P(Z0,U,6)) ; IA 4050
 .. E  D
 ... D SPL1^IBCEOBAR(Q,$P(Z0,U,2),$P(Z0,U,7),$P(Z0,U,6)) ; Add the split bill # ; IA 4050
 . ; BEGIN - PRCA*4.5*321
 . ;Move/Copy/Remove EEOB detail for split line
 . N CLAIM,IEN3611,RCSPLIT,RCSUB,RCZSAV
 . ; Sub-array of split claim detail for individual line
 . M RCSPLIT=RCSPL(Z)
 . ; Protect Z subscript variable from overwrite by triggers
 . S RCZSAV=Z
 . ; Get scratchpad line number for this ERA line
 . S RCSUB=$O(^RCY(344.49,RCRZ,1,"ASEQ",Z,""))
 . ; Original claim number from Scratchpad line
 . S CLAIM=$$GET1^DIQ(344.491,RCSUB_","_RCRZ_",",.02)
 . ; EOB for original claim from ERA line
 . S IEN3611=$$GET1^DIQ(344.41,RCQ_","_RCRZ_",",.02,"I")
 . ; Automatic Move/Copy/Remove EOB
 . I $$AUTO^RCDPEM5(CLAIM,.RCSPLIT,RCERA,"W",IEN3611)
 . ; Restore Z
 . S Z=RCZSAV
 . ; END  - PRCA*4.5*321
 ;
 Q
SPLIT(Z,Z1,RCERA) ;Check if worklist was split but to to single claim
 N SUB,NBILL,OBILL
 ;Find split line in scratchpad
 S SUB=$O(^RCY(344.49,RCERA,1,"B",Z1,"")) Q:'SUB 0
 ;Get original claim number from scratchpad
 S OBILL=$P($G(^RCY(344.49,RCERA,1,SUB-1,0)),U,2)
 ;New claim number
 S NBILL=$P(RCSPL(Z,Z1),U,2)
 ;If new and old claim are not the same this is a move via split
 I OBILL'="",OBILL'=NBILL Q 1
 ;Otherwise this is not a split
 Q 0
 ;
DET(RCZ,RCR,RECTDA1,RCTRANDA) ; Store receipt detail
 ; RCZ = ien of entry file 344.49
 ; RCR = ien of entry in file 344.491
 ; RCPROC = Function calling this subroutine
 ;        = 1 EFT match to ERA   = 0 manual add receipt
 ; RECTDA1 = ien of entry in file 344
 ; RCTRANDA = ien of entry in subfile 344.01
 ;
 N DIE,DA,DR,X,Y,Z,RCUP,RCCOM,RCZ0,RC0
 S RC0=$G(^RCY(344.49,RCZ,0))
 S RCZ0=$G(^RCY(344.49,RCZ,1,RCR,0))
 S DR="",RCUP=+$O(^RCY(344.49,RCZ,1,"B",+RCZ0/1,0)),RCUP=$G(^RCY(344.49,RCZ,1,RCUP,0))
 I $P(RCZ0,U,7) S DR=".09////^S X="_+$P(RCZ0,U,7)_"_$C(59)_""PRCA(430,"";"
 S DR=DR_".04////"_(+$P(RCZ0,U,3))_";.27////"_RCR_";"
 I $P(RC0,U,5)'="" S DR=DR_".1////"_$P(RC0,U,5)_";"
 I $P(RC0,U,6)'="" S DR=DR_".08////"_$P(RC0,U,6)_";"
 S Z=0 F  S Z=$O(^RCY(344.49,RCZ,1,RCR,1,Z)) Q:'Z  I $P($G(^(Z,0)),U,5)=1 S DR=DR_".28////1;" Q  ; Update receipt line with dec adj flag
 S RCCOM=$P(RCZ0,U,10)
 I $P(RCUP,U,2)["**ADJ" S RCCOM=RCCOM_$S(RCCOM'="":"/",1:"")_$S($P($P(RCUP,U,2),"ADJ",2):"ERA adjustment - no bill referenced",1:"Total of EFT mismatched to ERA")
 I RCCOM]"" S DR=DR_"1.02////"_$E(RCCOM,1,60)_";"
 I $P($G(^RCY(344.49,RCZ,0)),U,4)'="" S DR=DR_".07////"_$P($G(^RCY(344.49,RCZ,0)),U,4)_";"
 S DA(1)=RECTDA1,DA=RCTRANDA,DIE="^RCY(344,"_DA(1)_",1,"
 D ^DIE
 ;Update comment history - PRCA*4.5*321
 D:RCCOM]"" AUDIT^RCDPECH(RECTDA1,RCTRANDA,RCZ,RCR)
 Q
 ;
