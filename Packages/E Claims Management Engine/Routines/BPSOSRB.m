BPSOSRB ;BHAM ISC/FCS/DRS/FLS - Process claim on processing queue ;06/01/2004
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5,7,8,10,11**;JUN 2004;Build 27
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
BACKGR ;
 I '$$LOCKNOW^BPSOSRX("BACKGROUND") Q
 N TYPE,KEY1,KEY2,IEN59,IEN59PR,BPNOW,BPUNTIL
 N BPIEN77,BPLCKRX,BPQ,BPCOBIND,GRPLAN
 S BPNOW=$$NOW^BPSOSRX()
 ;go through all ACTIVATED
 S KEY1="" F  S KEY1=$O(^BPS(9002313.77,"AC",1,KEY1)) Q:KEY1=""  D
 . S KEY2="" F  S KEY2=$O(^BPS(9002313.77,"AC",1,KEY1,KEY2)) Q:KEY2=""  D
 . . S IEN59PR=+$$IEN59^BPSOSRX(KEY1,KEY2,0)
 . . S BPLCKRX=$$LOCKRF^BPSOSRX(KEY1,KEY2,10,IEN59PR,$T(+0)) I BPLCKRX=0 D  Q
 . . . D LOG^BPSOSL(IEN59PR,$T(+0)_"-Failed to $$LOCKRF^BPSOSRX.  Will retry later.")
 . . S BPQ=0
 . . S BPIEN77="" F  S BPIEN77=$O(^BPS(9002313.77,"AC",1,KEY1,KEY2,BPIEN77)) Q:(+BPIEN77=0)!(BPQ=1)  D
 . . . ;check DONT PROCESS UNTIL field #.08 and if it is greater than NOW then DO NOT process it
 . . . S BPUNTIL=+$P($G(^BPS(9002313.77,BPIEN77,0)),U,8) I BPUNTIL>BPNOW S BPQ=1 Q  ;D LOG^BPSOSL(IEN59,$T(+0)_"-The request cannot be processed until."_BPUNTIL_" Will retry later.") Q
 . . . ;check if PROCESS FLAG is IN PROCESS - if the earlier record for this RX refill is in progress - 
 . . . ;we should not process the next operation queued - go to the next refill (BPQ=1)
 . . . I $P($G(^BPS(9002313.77,BPIEN77,0)),U,4)=2 S BPQ=1 D  Q
 . . . . D LOG^BPSOSL(IEN59,$T(+0)_"-Status is 'IN PROCESS'.  Will retry later.")
 . . . S BPCOBIND=$P(^BPS(9002313.77,BPIEN77,0),U,3)
 . . . S IEN59=$$IEN59^BPSOSRX(KEY1,KEY2,BPCOBIND)
 . . . ; Removed code to check Insurer Asleep
 . . . S TYPE=$P($G(^BPS(9002313.77,+BPIEN77,1)),U,4),TYPE=$S(TYPE="C":"CLAIM",TYPE="U":"UNCLAIM",TYPE="E":"ELIGIBILITY",1:"UNKNW")
 . . . I TYPE="UNKNW" D ERROR(+BPIEN77,IEN59,"Request Type is unknown. Cannot be processed.") Q
 . . . D LOG^BPSOSL(IEN59,$T(+0)_"-Processing the Activated request "_BPIEN77)
 . . . D LOG^BPSOSL(IEN59,$T(+0)_"-Dequeuing.  Type is "_TYPE)
 . . . ; if this is ACTIVATED then make it IN PROCESS (see SETPRFLG below)
 . . . N TIME,MOREDATA
 . . . S TIME=$P($G(^BPS(9002313.77,+BPIEN77,6)),U,1) ; time requested
 . . . D READMORE^BPSOSRX4(BPIEN77,.MOREDATA)
 . . . ;now it is IN PROCESS - i.e. goes to BACKGR1 (as K ^XTMP("BPS-PROC",TYPE,KEY1,KEY2 in old logic) 
 . . . I +$$INPROCES^BPSOSRX4(BPIEN77)=0 D ERROR(+BPIEN77,IEN59,"Cannot change the PROCESS FLAG to IN PROCESS. Cannot be processed.") Q
 . . . D LOG^BPSOSL(IEN59,$T(+0)_"-The request "_BPIEN77_" has been changed to IN PROCESS")
 . . . I +$$BACKGR1(TYPE,KEY1,KEY2,TIME,.MOREDATA,IEN59,+BPIEN77)=0 Q
 . . . S BPQ=1 ; This will skip requests with the same keys as the one just processed
 . . I BPLCKRX D UNLCKRF^BPSOSRX(KEY1,KEY2,IEN59PR,$T(+0))
 D UNLOCK^BPSOSRX("BACKGROUND")
 Q
 ;
 ;
 ; BACKGR1 - Further processing of the claim
 ; Besides the parameter below, IEN59 also needs to be defined
 ; TYPE - "CLAIM", "UNCLAIM", or "ELIGIBILITY"
 ; KEY1 - First key of the request
 ; KEY2 - Second key of the request
 ; TIME - time requested
 ; MOREDATA - array with claim data
 ; IEN59 - BPS TRANSACTION ien
 ; BPS77 - BPS REQUEST file ien
BACKGR1(TYPE,KEY1,KEY2,TIME,MOREDATA,IEN59,BPS77) ;
 ; Resolve multiple requests
 N SKIP,SKIPREAS,BPCOBIND,RESULT,PAYABLE
 D LOG^BPSOSL(IEN59,$T(+0)_"-Processing request "_BPS77_" with keys "_KEY1_", "_KEY2_" and type "_TYPE)
 S SKIP=0
 S BPCOBIND=$$COB59^BPSUTIL2(IEN59)
 S RESULT=$P($$STATUS^BPSOSRX(KEY1,KEY2,0,,BPCOBIND),U)
 S PAYABLE=$$PAYABLE^BPSOSRX5(RESULT)
 I TYPE="CLAIM" D
 . I $$RXDEL^BPSOS(KEY1,KEY2) S SKIP=1,SKIPREAS="Prescription is marked as DELETED or CANCELLED in Outpatient Pharmacy" Q
 . I PAYABLE S SKIP=1,SKIPREAS="Prescription is currently paid.  Previous Result is "_RESULT Q
 I TYPE="UNCLAIM",'PAYABLE S SKIP=1,SKIPREAS="Cannot reverse - previous result was "_RESULT
 ;
 ; If the SKIP flag message is set, handle error and quit
 I SKIP D ERROR(BPS77,IEN59,SKIPREAS) Q 0
 ;
 ; Submit claim
 S MOREDATA("SUBMIT TIME")=TIME
 ;
 ; If reversal, execute reversal code and quit
 I TYPE="UNCLAIM" D REVERSE(IEN59,.MOREDATA,$G(BPS77)) Q 1
 ;
 ; Claims and Eligibility will fall through to here
 D LOG^BPSOSL(IEN59,$T(+0)_"-Initiating Claim")
 D EN^BPSOSIZ(IEN59,.MOREDATA,$G(BPS77))
 Q 1
 ;
 ; Error handling - If a record can not be processed, then it needs to be
 ; inactivated and the next request activated
 ; 
 ; This is also called by ERROR^BPSOSIZ
ERROR(BPS77,IEN59,ERROR) ;
 I '$G(BPS77) Q
 I $G(ERROR)="" S ERROR="Unknown"
 N BPNXT77,BPRETV
 D LOG^BPSOSL(IEN59,$T(+0)_"-Skipping "_BPS77_" because of ERROR: "_ERROR)
 ;
 ; Inactivate the current request
 S BPRETV=$$INACTIVE^BPSOSRX4(BPS77,ERROR)
 I 'BPRETV D LOG^BPSOSL(IEN59,$T(+0)_"-Could not inactivate the request: "_BPRETV) Q
 D LOG^BPSOSL(IEN59,$T(+0)_"-Request is inactivated")
 ;
 ; See if there is a next request linked to this one
 ; If there is, activate it
 S BPNXT77=+$$GETNXREQ^BPSOSRX6(BPS77,0,0,$G(IEN59))
 I BPNXT77 D
 . S BPRETV=$$ACTIVATE^BPSOSRX4(BPNXT77)
 . D LOG^BPSOSL(IEN59,$T(+0)_"-The next request "_BPNXT77_" has "_$S('BPRETV:"not ",1:"")_"been activated")
 Q
 ;
 ; Process the reversal
REVERSE(IEN59,MOREDATA,BP77) ;
 N MSG,RETVAL,REV
 ;
 ; Update BPS REQUEST with the BPS TRANSACTION IEN
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
 ; Update specific fields of the BPS Transaction record - Submit Date (#6),
 ;   User (#13), Request Type (#19), Reversal Claim (#401), Reversal Response (#402),
 ;   Reversal Reason (#404), Reversal Request (#405), Reversal Request Date and Time (#406),
 ;   and RX Action (#1201)
 N DIE,DR,DA
 S DIE=9002313.59,DA=IEN59
 S DR="6////"_$G(MOREDATA("SUBMIT TIME"))_";13////"_$G(MOREDATA("USER"))
 S DR=DR_";404////"_$G(MOREDATA("REVERSAL REASON"))_";1201////"_$G(MOREDATA("RX ACTION"))
 S DR=DR_";19////"_$G(MOREDATA("REQ TYPE"))_";405////"_$G(MOREDATA("REQ IEN"))
 S DR=DR_";406////"_MOREDATA("REQ DTTM")_";401////@;402////@"
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
