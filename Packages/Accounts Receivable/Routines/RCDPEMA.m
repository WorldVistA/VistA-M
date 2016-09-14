RCDPEMA ;ALB/PJH - AUTO-POSTING RECEIPT CREATION ;Oct 15, 2014@12:37:52
 ;;4.5;Accounts Receivable;**298,304**;Mar 20, 1995;Build 104
 ;Per VA Directive 6402, this routine should not be modified.
 ;
RCPTDET(RCRZ,RECTDA1,RCLINES,RCER) ; Adds detail to a receipt based on file 344.49 and exceptions in array RCLINES
 ; RCRZ = ien of ERA entry in file 344.49
 ; RECTDA1 = ien of receipt entry in file 344
 ; RCER = error array returned if passed by reference
 ; RCLINES = array to indicate which scratchpad lines can be posted (assigned a receipt)
 ;
 N DA,DIE,DR,Q,RCLINE,RCQ,RCR,RCSPL,RCTRANDA,RCZ0,SEQLINES,RCSEQ,X,Y,Z,Z0,Z1
 ;
 S RCR=0 F  S RCR=$O(^RCY(344.49,RCRZ,1,RCR)) Q:'RCR  D
 . S RCZ0=$G(^RCY(344.49,RCRZ,1,RCR,0)),RCSEQ=$P(RCZ0,U)
 . ;Check first line for prefix to see if ERA line is valid for auto-post
 . I RCSEQ?1N.N,$P(RCZ0,U,9),$P($G(RCLINES($P(RCZ0,U,9))),U) S SEQLINES(RCSEQ)=""
 . ;Skip WORKLIST lines that do not need associated receipt detail
 . Q:'$D(SEQLINES(RCSEQ\1))
 . I RCSEQ'["." S RCSPL(+RCZ0)=$P(RCZ0,U,9) Q
 . I $S(+$P(RCZ0,U,3)=0:$P($G(^RCY(344.49,RCRZ,0)),U,3),1:$P(RCZ0,U,3)<0) S RCSPL(RCZ0\1,+RCZ0)=RCZ0 Q
 . S RCTRANDA=$$ADDTRAN^RCDPURET(RECTDA1)
 . ;
 . I 'RCTRANDA D  Q  ; Error adding receipt detail
 .. S RCER(1)=$$SETERR^RCDPEM0() S RCER($O(RCER(""),-1)+1)="  NO DETAIL LINE ADDED TO RECEIPT "_$P($G(^RCY(344,RECTDA1,0)),U)_" FOR LINE #"_$P(RCZ0,U)_" IN EEOB WORKLIST SCRATCH PAD"
 . ;
 . ;Store receipt line detail
 . D DET(RCRZ,RCR,RECTDA1,RCTRANDA)
 . S RCSPL(RCZ0\1,+RCZ0)=RCZ0
 S Z=0 F  S Z=$O(RCSPL(Z)) Q:'Z  S RCQ=+$G(RCSPL(Z)) I RCQ D
 .; Move EEOB if one claim entered-changed 10/19/11-see +25^RCDPEWL8
 . S Z1=$O(RCSPL(Z,"")) Q:Z1=""
 . I $O(RCSPL(Z,""),-1)=Z1,'$$SPLIT(Z,Z1,RCERA) Q  ; No split occurred
 . S Z1=0 F  S Z1=$O(RCSPL(Z,Z1)) Q:'Z1  S Z0=$G(RCSPL(Z,Z1)) D
 .. S Q=+$P($G(^RCY(344.4,RCRZ,1,RCQ,0)),U,2) ; EOB detail rec
 .. Q:'Q
 .. I '$P(Z0,U,7)!($P(Z0,U,2)="") D  ; Suspense
 ... D SPL1^IBCEOBAR(Q,$S($P(Z0,U,2)="":"NO BILL",1:$P(Z0,U,2)),"",$P(Z0,U,6)) ; IA 4050
 .. E  D
 ... D SPL1^IBCEOBAR(Q,$P(Z0,U,2),$P(Z0,U,7),$P(Z0,U,6)) ; Add the split bill # ; IA 4050
 ;
 Q
 ;
SPLIT(Z,Z1,RCERA) ;Check if worklist was split to single claim
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
 Q
 ;
BLDRCPT(RCERA) ; Create a receipt for Auto Posting ERA with multiple Receipts - alpha char at the 10th character
 ; LAYGO new entry to AR BATCH PAYMENT file (#344)
 ; input - RCERA = Pointer to 344.4
 ; returns new IEN on success, else zero
 ; called by auto-post process (RCDPEAP)
 ;
 N RECEIPT,TYPE,LASTREC
 S TYPE=$E($G(^RC(341.1,+$O(^RC(341.1,"AC",14,0)),0)))  ; ^RC(341.1,0) = AR EVENT TYPE
 ; retrieve the last receipt recorded on the ERA (if it exists)
 S LASTREC=$$GETREC(RCERA)
 ; Make sure last receit for the ERA is 10-chars long and the last char is between A - Y (can't be Z),
 ; Otherwise grab a new number and append "A"
 I LASTREC'="",$L(LASTREC)=10,$A($E(LASTREC,10))>64,$A($E(LASTREC,10))<90 D
 . S RECEIPT=$E(LASTREC,1,9)_$C($A($E(LASTREC,10))+1)
 E  D
 . S RECEIPT=$$NEXT^RCDPUREC(TYPE_$E(DT,2,7))_"A"
 ;
 ; Prevents duplicate Receipt # entries from being filed
 F  Q:'$D(^RCY(344,"B",RECEIPT))  D
 . S RECEIPT=$E(RECEIPT,1)_$E(1000001+$E(RECEIPT,2,7),2,7)_$E(RECEIPT,8,9)_"A"
 ;
 L +^RCY(344,"B",RECEIPT):DILOCKTM E  Q 0  ; if LOCK timeout return zero
 ;
 ; add entry to AR BATCH PAYMENT file (#344)
 N %,%DT,D0,DA,DD,DI,DIC,DIE,DLAYGO,DO,DQ,DR,X,Y
 S DIC="^RCY(344,",DIC(0)="L",DLAYGO=344
 ;  .02 = opened by                  .03 = date opened = transmission dt
 ;  .04 = type of payment           
 ;  .14 = status (set to 1:open)
 S DIC("DR")=".02////"_DUZ_";.03///"_DT_";.04////14;.14////1;"
 S X=RECEIPT
 D FILE^DICN
 L -^RCY(344,"B",RECEIPT)
 I Y>0 Q +Y  ; Y set by DICN, return new IEN
 Q 0  ; entry not created
 ;
GETREC(RCERA) ; returns the receipt number
 ; input - RCERA = ien of entry in 344.4
 ; output - returns the receipt number in external form
 N X,RECEIPT
 S RECEIPT=""
 S X=$O(^RCY(344.4,RCERA,1,"RECEIPT",""),-1)  ; get last RECEIPT ien from 344.41 subfile
 S:X RECEIPT=$P($G(^RCY(344,X,0)),U)  ; get external form of receipt  
 Q RECEIPT
