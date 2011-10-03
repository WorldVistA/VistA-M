BPSOSRB ;BHAM ISC/FCS/DRS/FLS - Process claim on processing queue ;06/01/2004
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5,7,8**;JUN 2004;Build 29
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
BACKGR ;
 I '$$LOCKNOW^BPSOSRX("BACKGROUND") Q
 N TYPE,RXI,RXR,IEN59,IEN59PR,BPNOW,BPUNTIL
 N BPIEN77,BPLCKRX,BPQ,BPCOBIND,GRPLAN
 S BPNOW=$$NOW^BPSOSRX()
 ;go through all ACTIVATED
 S RXI="" F  S RXI=$O(^BPS(9002313.77,"AC",1,RXI)) Q:RXI=""  D
 . S RXR="" F  S RXR=$O(^BPS(9002313.77,"AC",1,RXI,RXR)) Q:RXR=""  D
 . . S IEN59PR=+$$IEN59^BPSOSRX(RXI,RXR,0)
 . . S BPLCKRX=$$LOCKRF^BPSOSRX(RXI,RXR,10,IEN59PR,$T(+0)) I BPLCKRX=0 D  Q
 . . . D LOG^BPSOSL(IEN59PR,$T(+0)_"-Failed to $$LOCKRF^BPSOSRX.  Will retry later.")
 . . S BPQ=0
 . . S BPIEN77="" F  S BPIEN77=$O(^BPS(9002313.77,"AC",1,RXI,RXR,BPIEN77)) Q:(+BPIEN77=0)!(BPQ=1)  D
 . . . ;check DONT PROCESS UNTIL field #.08 and if it is greater than NOW then DO NOT process it
 . . . S BPUNTIL=+$P($G(^BPS(9002313.77,BPIEN77,0)),U,8) I BPUNTIL>BPNOW S BPQ=1 Q  ;D LOG^BPSOSL(IEN59,$T(+0)_"-The request cannot be processed until."_BPUNTIL_" Will retry later.") Q
 . . . ;check if PROCESS FLAG is IN PROCESS - if the earlier record for this RX refill is in progress - 
 . . . ;we should not process the next operation queued - go to the next refill (BPQ=1)
 . . . I $P($G(^BPS(9002313.77,BPIEN77,0)),U,4)=2 S BPQ=1 D  Q
 . . . . D LOG^BPSOSL(IEN59,$T(+0)_"-Status is 'IN PROCESS'.  Will retry later.")
 . . . S BPCOBIND=$P(^BPS(9002313.77,BPIEN77,0),U,3)
 . . . S IEN59=$$IEN59^BPSOSRX(RXI,RXR,BPCOBIND)
 . . . ; Removed code to check Insurer Asleep
 . . . S TYPE=$P($G(^BPS(9002313.77,+BPIEN77,1)),U,4),TYPE=$S(TYPE="C":"CLAIM",TYPE="U":"UNCLAIM",1:"UNKNW")
 . . . I TYPE="UNKNW" D LOG^BPSOSL(IEN59,$T(+0)_"-Request Type is unknown. Cannot be processed.") D INACTIVE^BPSOSRX4(+BPIEN77) Q  ;make it inactive
 . . . D LOG^BPSOSL(IEN59,$T(+0)_"-Processing the Activated request "_BPIEN77)
 . . . D LOG^BPSOSL(IEN59,$T(+0)_"-Dequeuing.  Type is "_TYPE)
 . . . ; if this is ACTIVATED then make it IN PROCESS (see SETPRFLG below)
 . . . S BPQ=1 ;
 . . . N TIME,MOREDATA
 . . . S TIME=$P($G(^BPS(9002313.77,+BPIEN77,6)),U,1) ; time requested
 . . . D READMORE^BPSOSRX4(BPIEN77,.MOREDATA)
 . . . ;now it is IN PROCESS - i.e. goes to BACKGR1 (as K ^XTMP("BPS-PROC",TYPE,RXI,RXR in old logic) 
 . . . I +$$INPROCES^BPSOSRX4(BPIEN77)=0 D LOG^BPSOSL(IEN59,$T(+0)_"-Cannot change the PROCESS FLAG to IN PROCESS. Cannot be processed.") Q
 . . . D LOG^BPSOSL(IEN59,$T(+0)_"-the request "_BPIEN77_" has been changed to IN PROCESS")
 . . . D BACKGR1(TYPE,RXI,RXR,TIME,.MOREDATA,IEN59,+BPIEN77)
 . . I BPLCKRX D UNLCKRF^BPSOSRX(RXI,RXR,IEN59PR,$T(+0))
 D UNLOCK^BPSOSRX("BACKGROUND")
 Q
 ;
 ;
 ; BACKGR1 - Further processing of the claim
 ; Besides the parameter below, IEN59 also needs to be defined
 ; TYPE - "CLAIM" or "UNCLAIM" 
 ; RXI - PRESCRIPTION file #52 ien
 ; RXR - refill number (0-original)
 ; TIME - time requested
 ; MOREDATA - array with claim data
 ; IEN59 - BPS TRANSACTION ien
 ; BPS77 - BPS REQUEST file ien
BACKGR1(TYPE,RXI,RXR,TIME,MOREDATA,IEN59,BPS77) ;
 ; Resolve multiple requests
 N SKIP S SKIP=0 ; skip if you already got desired result
 N SKIPREAS
 N BPCOBIND S BPCOBIND=$$COB59^BPSUTIL2(IEN59)
 N RESULT,BPSSTAT
 S BPSSTAT=$$STATUS^BPSOSRX(RXI,RXR,0,,BPCOBIND)
 S RESULT=$P(BPSSTAT,U)
 I TYPE="CLAIM" D
 . I $$RXDEL^BPSOS(RXI,RXR) D  Q
 .. S SKIP=1,SKIPREAS="Prescription is marked as DELETED or CANCELLED"
 . ; If it's never been through ECME before, good.
 . I RESULT="" Q
 . ; There's already a complete transaction for this RXI,RXR
 . ; (We screened out "IN PROGRESS" earlier)
 . ; The program to poll indexes would have set DO NOT RESUBMIT.
 . ; Calls from pharm pkg to ECME have '$D(MOREDATA("DO NOT RESUBMIT"))
 . I $D(MOREDATA("DO NOT RESUBMIT")) D
 .. S SKIP=1
 .. S SKIPREAS="MOREDATA(""DO NOT RESUBMIT"") is set"
 E  I TYPE="UNCLAIM" D
 . ; It must have gone through ECME with a payable result
 . I RESULT="E PAYABLE" Q
 . I RESULT="E DUPLICATE" Q
 . N RXACTION S RXACTION=$G(MOREDATA("RX ACTION"))
 . I $P($G(^BPST(IEN59,9)),U,4)="T",((RESULT="E REVERSAL REJECTED")!(RESULT="E REVERSAL UNSTRANDED")),RXACTION="ERES" Q  ;allow to resubmit rejected reversals for Tricare
 . I RESULT="E REVERSAL REJECTED",(",DE,EREV,RS,"[(","_RXACTION_",")) Q
 . ;
 . I RESULT="E REVERSAL UNSTRANDED",RXACTION="EREV" Q
 . ;
 . I RESULT="E REVERSAL OTHER",RXACTION="EREV" Q
 . ;
 . ;allow to process "insurer asleep" status = 31, other IN PROGRESS statuses are not allowed to be processed
 . I RESULT="IN PROGRESS",$P(BPSSTAT,U,4)=31 Q
 . ;
 . S SKIP=1
 . S SKIPREAS="Cannot reverse - previous result was "_RESULT
 E  D IMPOSS^BPSOSUE("P","TI","bad arg TYPE="_TYPE,,"BACKGR1",$T(+0))
 I SKIP D  Q
 . D LOG^BPSOSL(IEN59,$T(+0)_"-Skipping.  Reason: "_SKIPREAS)
 S MOREDATA("SUBMIT TIME")=TIME
 ;
 I TYPE="UNCLAIM" D REVERSE(IEN59,.MOREDATA,$G(BPS77))
 I TYPE="CLAIM" D CLAIM(IEN59,.MOREDATA,$G(BPS77))
 Q
 ;
 ; STARTTIM - Get START TIME field from BPS Transactions
STARTTIM(RXI,RXR) Q $P($G(^BPST($$IEN59^BPSOSRX(RXI,RXR),0)),U,11)
 ;
 ; Process claim request
 ; EP - Above and BPSOSU (for a resubmit after a reversal)
 ; BPS77 - BPS REQUEST file ien
CLAIM(IEN59,MOREDATA,BPS77) ;
 D LOG^BPSOSL(IEN59,$T(+0)_"-Initiating Claim")
 D EN^BPSOSIZ(IEN59,.MOREDATA,$G(BPS77))
 Q
 ;
 ; Process the reversal
REVERSE(IEN59,MOREDATA,BP77) ;
 N MSG,RETVAL,REV
 ;update/populate fields in BPS REQUEST and BPS TRANSACTION
 I $G(BP77)>0 D UPD7759^BPSOSRX4(BP77,IEN59)
 ;
 ; Log Reversal or Reversal/Resubmit message.
 ; Note that the reversal/resubmit message is needed
 ;   for Turn-Around Stats - Do NOT delete/alter!!
 S MSG=$T(+0)_"-Initiating Reversal"
 D LOG^BPSOSL(IEN59,MSG)
 ;
 ; Change status to 0% (Waiting to Start), which will reset START TIME,
 ;   and then to 10% (Building transaction)
 D SETSTAT^BPSOSU(IEN59,0)
 D SETSTAT^BPSOSU(IEN59,10)
 ;
 ; Update User (#13), RX Action (#1201), and Reversal Reason (#404)
 ;   in BPS Transactions
 N DIE,DR,DA
 S DIE=9002313.59,DA=IEN59
 S DR="6////"_$G(MOREDATA("SUBMIT TIME"))_";13////"_$G(MOREDATA("USER"))
 S DR=DR_";404////"_$G(MOREDATA("REVERSAL REASON"))_";1201////"_$G(MOREDATA("RX ACTION"))
 ;
 D ^DIE
 ;
 ; Store the Payer Sequence in the log
 N BPSCOB
 S BPSCOB=$$COB59^BPSUTIL2(IEN59),BPSCOB=$S(BPSCOB=2:"-Secondary",BPSCOB=3:"-Tertiary",1:"-Primary"),BPSCOB=BPSCOB_" Insurance"
 D LOG^BPSOSL(IEN59,$T(+0)_BPSCOB)
 ;
 ; Store contents of BPST in the Log
 D LOG^BPSOSL(IEN59,$T(+0)_"-Contents of ^BPST("_IEN59_") :")
 D LOG59^BPSOSQA(IEN59) ; Log contents of 9002313.59
 ;
 ; Add semi-colon to result text
 D PREVISLY^BPSOSIZ(IEN59)
 ;
 ; Construct reversal claim
 ;   If no reversal claim is returned, log error and quit.
 S REV=$$REVERSE^BPSECA8(IEN59)
 I REV=0 D  Q
 . D LOG^BPSOSL(IEN59,$T(+0)_"-Reversal claim not created for "_IEN59)
 . D ERROR^BPSOSU($T(+0),IEN59,100,"Reversal Claim not created")
 ;
 ; Update Reversal Field in the transaction
 S DIE=9002313.59,DA=IEN59,DR="401////"_REV
 D ^DIE
 ;
 ; Update Log
 D LOG^BPSOSL(IEN59,$T(+0)_"-Reversal claim "_$P(^BPSC(REV,0),U)_" ("_REV_")")
 ;
 ; Update status to 30% (Building the claim)
 D SETSTAT^BPSOSU(IEN59,30)
 ;
 ; Fire off task to get this on the HL7 queue
 D TASK^BPSOSQA
 Q
