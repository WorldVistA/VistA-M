BPSOSRX5 ;ALB/SS - ECME REQUESTS ;10-JAN-08
 ;;1.0;E CLAIMS MGMT ENGINE;**7,8,10,11,20**;JUN 2004;Build 27
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;check if according the last response the payer IS going to PAY
 ;(Note: reversals can be done only on previously payable claims, if reversal failed then the claim stays PAYABLE)
PAYABLE(BPRESP) ;
 Q ",E PAYABLE,E DUPLICATE,E REVERSAL REJECTED,E REVERSAL OTHER,E REVERSAL UNSTRANDED,"[(","_BPRESP_",")
 ;
 ;Action type
ACTTYPE(BWHR) ;
 Q:",AREV,CRLR,CRLX,DC,DE,EREV,HLD,OREV,RS,"[(","_BWHR_",") "U"  ;UNCLAIM (reversal)
 Q:",CRLB,ED,ERES,P2S,"[(","_BWHR_",") "UC"  ;UNCLAIM (reversal) + CLAIM (resubmit)
 Q:",BB,CRRL,ERWV,ERNB,OF,PC,PE,PL,PP,RF,RN,RRL,RSNB,P2,"[(","_BWHR_",") "C"  ;CLAIM (the very first submit OR resubmit only)
 Q:BWHR="ELIG" "E"
 Q ""  ;unknown
 ;
 ;Check ECME availability at the site
 ;return :
 ; 1^CLMSTAT -off
 ; null -on
ECMESITE(SITE) ;
 I '$G(SITE) Q "1^No Site Information"
 I '$$ECMEON^BPSUTIL(SITE) Q "1^ECME switch is not on for the site"
 Q ""
 ;
 ; This is called by STATUS99^BPSOSU when the status of the current claim becomes 99%.
 ; The purpose is to decide what to with the new next request in the chain
 ;
 ; Example:
 ;  If this request (Request A) is the last one in the chain and we just received a new request
 ;   (Request B) for the same keys, then Request B needs to be activated after Request A has been completed.  Who will do this?
 ;  Situation 1:
 ;    If this code REQST99^BPSOSRX5 gets the lock first then it will not be able to activate Request B (because we
 ;    don't have it in the NEXT REQUEST field). So Request A will be completed and when the REQST^BPSOSRX code gets
 ;    the lock it will find Request A marked as completed and will not populate the NEXT REQUEST field of Request A.
 ;    Instead it will just activate Request B.
 ;  Situation 2:
 ;    If the REQST^BPSOSRX code gets the lock first then it will check the status of the Request A and since it is
 ;    still "IN PROCESS", then it will populate the NEXT REQUEST field of the Request 1 with ien of Request 2, and
 ;    then release the lock.  Then when the REQST99^BPSOSRX5 gets the lock it checks the NEXT REQUEST field and
 ;    activate the request 2
 ;
 ;Input:
 ;IEN59 - BPS TRANSACTION IEN
 ;BPCLMST - claim status
 ;     For Billing Requests (type= C):
 ;       E PAYABLE, E CAPTURED, E DUPLICATE, E REJECTED, E OTHER, and
 ;       E UNSTRANDED
 ;
 ;     For Reversals (type=U):
 ;       E REVERSAL ACCEPTED, E REVERSAL REJECTED, E REVERSAL OTHER, and
 ;       E REVERSAL UNSTRANDED
 ;
 ;     For Eligibility (type=E):
 ;       E ELIGIBILITY ACCEPTED, E ELIGIBILITY REJECTED, E ELIGIBILITY OTHER, and
 ;       E ELIGIBILITY UNSTRANDED
 ;
 ;Output:
 ; return 0 if there is no next request
 ; otherwise - return IEN of next BPS REQUEST
REQST99(IEN59,BPCLMST) ;
 N BP77,KEY1,KEY2,BPRETV,BPTYPE,RESAFTRV,BPPAYSEQ,BPTYPNXT,BPFLG
 N DOS,BWHERE,BILLNDC,REVREAS,DURREC,BPOVRIEN,BPSCLARF,BPSAUTH,BPSDELAY,BPCOBIND,BPDUR
 S RESAFTRV=0
 I '$G(IEN59) D LOG^BPSOSL(IEN59,$T(+0)_"-Transaction IEN not passed in") Q 0
 S BPCLMST=$G(BPCLMST)
 ;
 ; Get Keys to the request file
 S BP77=$$GETRQST^BPSUTIL2(IEN59)
 I 'BP77 D LOG^BPSOSL(IEN59,$T(+0)_"-BPS Request Pointer not found") Q 0
 S KEY1=$P($G(^BPS(9002313.77,BP77,0)),U,1)
 S KEY2=$P($G(^BPS(9002313.77,BP77,0)),U,2)
 I 'KEY1!(KEY2="") D LOG^BPSOSL(IEN59,$T(+0)_"-Request keys not found for "_BP77) Q 0
 ;
 ; Get lock
 D LOG^BPSOSL(IEN59,$T(+0)_"-Attempting to lock request with keys "_KEY1_", "_KEY2)
 S BPRETV=$$LOCKRF^BPSOSRX(KEY1,KEY2,10,IEN59,$T(+0))
 I 'BPRETV D LOG^BPSOSL(IEN59,$T(+0)_"-Cannot lock keys in REQST99") Q 0
 ;
 ; Mark this request as completed
 N BPNXT77
 S BPRETV=$$COMPLETD^BPSOSRX4(BP77) I +BPRETV=0 D  Q 0
 . D LOG^BPSOSL(IEN59,$T(+0)_"-Cannot change the PROCESS FLAG to COMPLETED: "_$P(BPRETV,U,2))
 . D UNLCKRF^BPSOSRX(KEY1,KEY2,IEN59,$T(+0))
 D LOG^BPSOSL(IEN59,$T(+0)_"-The request "_BP77_" has been changed to COMPLETED ("_+$P($G(^BPS(9002313.77,BP77,0)),U,4)_")")
 ;
 ; Get the request type and get the next request in the list
 ; For eligibility, do not deleted duplicate request.
 ; For others, do delete duplicate request
 S BPTYPE=$P($G(^BPS(9002313.77,BP77,1)),U,4)
 S BPFLG=$S(BPTYPE="E":0,1:1)
 S BPNXT77=+$$GETNXREQ^BPSOSRX6(BP77,BPFLG,BPFLG,IEN59)
 ;
 ; If this was reversal (UNCLAIM), the next request is "CLAIM", 
 ;   and the RX action is = resubmit (ERES), then this is a submit after reversal
 I BPTYPE="U",$P($G(^BPS(9002313.77,+BPNXT77,1)),U,4)="C",$P($G(^BPS(9002313.77,+BPNXT77,1)),U,1)="ERES" S RESAFTRV=1
 I RESAFTRV=1 D LOG^BPSOSL(IEN59,$T(+0)_"-Reverse then Resubmit attempt")
 ;
 S BPPAYSEQ=$$COB59^BPSUTIL2(IEN59) ;payer sequence
 ;
 ; If not eligibility and the current request failed, then cancel and delete all subsequent requests and quit
 I BPTYPE'="E",$$SUCCESS^BPSOSRX7(BPTYPE,BPCLMST)=0 D  Q 0
 . ; If secondary claim was rejected with certain reject codes - send it to Pharmacy worklist
 . ; DMB-Not sure if this is valid.  Call from BPSOSQL to DURSYNC should have sent these already.
 . I BPTYPE="C",BPPAYSEQ=2 I $$SENDREJ^BPSWRKLS(KEY1,KEY2,IEN59,BPPAYSEQ)
 . D LOG^BPSOSL(IEN59,$T(+0)_"-Current request failed with "_BPCLMST_" - removing this and all sequential requests")
 . I RESAFTRV=1 D LOG^BPSOSL(IEN59,$T(+0)_"-Cannot do Reverse then Resubmit attempt - Reversal status: "_BPCLMST)
 . D DELALLRQ^BPSOSRX7(BP77,IEN59)
 . D UNLCKRF^BPSOSRX(KEY1,KEY2,IEN59,$T(+0))
 ;
 ; If there is no "next request" for the RX/refill - delete the completed request and quit with 0
 I BPNXT77=0 D  Q 0
 . D LOG^BPSOSL(IEN59,$T(+0)_"-There is no NEXT REQUEST.  Deleting the current request")
 . D DELREQST^BPSOSRX4(BP77,IEN59)
 . D UNLCKRF^BPSOSRX(KEY1,KEY2,IEN59,$T(+0))
 ;
 ; If there is a NEXT REQUEST
 D LOG^BPSOSL(IEN59,$T(+0)_"-The NEXT "_$P($G(^BPS(9002313.77,+BPNXT77,1)),U,4)_"-type REQUEST is "_BPNXT77)
 ;
 S BPTYPNXT=$P($G(^BPS(9002313.77,+BPNXT77,1)),U,4) ;action type of the next request
 ;
 ; If eligibility, activate the next request
 I BPTYPE="E" S BPRETV=$$ACTIVATE^BPSNCPD4(BPNXT77,"E") G END
 ;
 ; If secondary claim AND action type ="C", don't redo billing determination again, just activate
 I BPPAYSEQ>1,BPTYPNXT="C" S BPRETV=$$ACTIVATE^BPSNCPD4(BPNXT77,"C") G END
 ;
 I RESAFTRV=1 D LOG^BPSOSL(IEN59,$T(+0)_"-Now resubmit")
 S DOS=+$P($G(^BPS(9002313.77,BPNXT77,2)),U)
 S BWHERE=$P($G(^BPS(9002313.77,BPNXT77,1)),U)
 S BILLNDC=$P($G(^BPS(9002313.77,BPNXT77,2)),U,6) ;if we do not send it then BPSNCPDP will get the latest NDC
 S REVREAS=$P($G(^BPS(9002313.77,BPNXT77,2)),U,2)
 S DURREC=""
 S BPDUR=$O(^BPS(9002313.77,BPNXT77,3,"")) I BPDUR S DURREC=^BPS(9002313.77,BPNXT77,3,BPDUR,0)
 S BPOVRIEN=$P($G(^BPS(9002313.77,BPNXT77,2)),U,4)
 S BPSCLARF=$P($G(^BPS(9002313.77,BPNXT77,2)),U,5)
 S BPSAUTH=$P($G(^BPS(9002313.77,BPNXT77,2)),U,7) I BPSAUTH'="" S BPSAUTH=BPSAUTH_U_$P($G(^BPS(9002313.77,BPNXT77,2)),U,8)
 S BPCOBIND=+$P($G(^BPS(9002313.77,BPNXT77,0)),U,3)
 S BPSDELAY=$P($G(^BPS(9002313.77,BPNXT77,2)),U,10)
 ; Call ECME engine in "B" (background) mode to:
 ;   Perform checks if necessary,
 ;   Update billing info if this is a CLAIM
 ;   Activate the request
 S BPRETV=$$EN^BPSNCPDP(KEY1,KEY2,DOS,BWHERE,BILLNDC,REVREAS,DURREC,BPOVRIEN,BPSCLARF,BPSAUTH,BPCOBIND,"B",BPNXT77,"","","","",BPSDELAY)
 ; Code falls through to here but is also called above
END ;
 ; If unsuccessful, deactivate all subsequent request and quit
 I +BPRETV'=0 D  Q 0
 . D LOG^BPSOSL(IEN59,$T(+0)_"-Cannot activate the next request: "_$P(BPRETV,U,2))
 . D DELALLRQ^BPSOSRX7(BP77,IEN59)
 . D UNLCKRF^BPSOSRX(KEY1,KEY2,IEN59,$T(+0))
 ; If was successful, do the next steps:
 ;   Log an entry
 ;   Delete the completed request
 ;   Run background process, if neeeded 
 D LOG^BPSOSL(IEN59,$T(+0)_"-The NEXT "_$P($G(^BPS(9002313.77,+BPNXT77,1)),U,4)_"-type REQUEST "_BPNXT77_" has been activated")
 D DELREQST^BPSOSRX4(BP77,IEN59)
 D UNLCKRF^BPSOSRX(KEY1,KEY2,IEN59,$T(+0))
 ; Run background process to pick up the activated request for secondary claim (for primary only - it is done when we call EN^BPSNCPDP above)
 I BPTYPNXT="E"!(BPPAYSEQ>1&(BPTYPNXT="C")) D RUNNING^BPSOSRX()
 Q BPNXT77
 ;BPSOSRX5
