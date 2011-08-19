BPSOSRX5 ;ALB/SS - ECME REQUESTS ;10-JAN-08
 ;;1.0;E CLAIMS MGMT ENGINE;**7,8**;JUN 2004;Build 29
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; if Resubmit then check was the previous UNCLAIM accepted 
 ; (Cannot resubmit reversed claims unless they are accepted)
 ;
TODAY() ;
 D NOW^%DTC
 Q $P(%,".",1)
 ;
 ;check if according the last response the payer IS going to PAY
 ;(Note: reversals can be done only on previously payable claims, if reversal failed then the claim stays PAYABLE)
PAYABLE(BPRESP) ;
 Q ",E PAYABLE,E DUPLICATE,E REVERSAL REJECTED,E REVERSAL OTHER,E REVERSAL UNSTRANDED,"[(","_BPRESP_",")
 ;
 ;Action type
ACTTYPE(BWHR) ;
 Q:",AREV,CRLR,CRLX,DC,DDED,DE,EREV,HLD,RS,"[(","_BWHR_",") "U"  ;UNCLAIM (reversal)
 Q:",CRLB,ED,ERES,RL,RRL,"[(","_BWHR_",") "UC"  ;UNCLAIM (reversal) + CLAIM (resubmit)
 Q:",ARES,BB,OF,PC,PE,PL,PP,RF,RN,"[(","_BWHR_",") "C"  ;CLAIM (the very first submit OR resubmit only)
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
 ;is called by STATUS99^BPSOSU when the status of the current claim becomes 99%
 ;Activates the next scheduled request if any
 ;
 ;input:
 ;IEN59 - BPS TRANSACTION ien
 ;BPCLMST - claim status
 ;     For submissions (type =C):
 ;       E PAYABLE, E CAPTURED, E DUPLICATE, E REJECTED, E OTHER, and
 ;       E STRANDED
 ;
 ;     For Reversals (type =U):
 ;       E REVERSAL ACCEPTED, E REVERSAL REJECTED, E REVERSAL OTHER, and
 ;       E REVERSAL STRANDED
 ;
 ;output:
 ; return 0 if there is no any next request for the RX/refill
 ; otherwise - return IEN of next BPS REQUEST
REQST99(IEN59,BPCLMST) ;
 N BPLCK,BPRXRF,RXI,RXR,BPRETV,BPTYPE,RESAFTRV,BPRETACT,BPPAYSEQ,BPTYPREQ
 N BFILLDAT,BWHERE,BILLNDC,REVREAS,DURREC,BPOVRIEN,BPSCLARF,BPSAUTH,BPCOBIND,BPDUR,BPTYPNXT
 S RESAFTRV=0
 ;get RX and Rf by ien59
 S BPRXRF=$$RXREF^BPSSCRU2(IEN59)
 S RXI=+BPRXRF,RXR=$P(BPRXRF,U,2)
 ;get lock - to decide what to do with the new next request
 ;Example 
 ;if this request (Request A) is the last one in the chain and we just received a new request (Request B)
 ;for the same RX/RF, - then the Request B needs to be activated after Request A has been completed. 
 ;Who will be doing this?
 ;Situation 1:
 ;if this code REQST99^BPSOSRX5 gets the lock first then it will not be able to activate Request B (because we don't have it 
 ;in the NEXT REQUEST field). So Request A will be completed and when the REQST^BPSOSRX code gets the lock it will 
 ;find Request A as completed and will not populate the NEXT REQUEST field of Request A - instead it will just activate
 ;the new Request B.
 ;Situation 2:
 ;if the REQST^BPSOSRX code gets the lock first then it will check the status of the Request A and since it is still "IN PROCESS"
 ;then it will populate the NEXT REQUEST field of the Request 1 with ien of Request 2, and then release the lock.
 ;Then when the REQST99^BPSOSRX5 gets the lock it checks the NEXT REQUEST field and activate the request 2
 ;
 S BPLCK=$$LOCKRF^BPSOSRX(RXI,RXR,10,IEN59,$T(+0))
 I 'BPLCK D  Q 0
 . D LOG^BPSOSL(IEN59,$T(+0)_"-RX/RF Locked")
 . D LOG^BPSOSL(IEN59,$T(+0)_"-Cannot lock RX/RF in REQST99 (STATUS99) "_$P(BPRETV,U,2))
 N BP77,BPNXT77,BPRET
 S BP77=+$P($G(^BPST(IEN59,0)),U,12)
 I BP77=0 D LOG^BPSOSL(IEN59,$T(+0)_"-SUBMIT REQUEST not populated") D:BPLCK UNLCKRF^BPSOSRX(RXI,RXR,IEN59,$T(+0)) Q 0
 S BPRETV=$$COMPLETD^BPSOSRX4(BP77) I +BPRETV=0 D  Q 0
 . D LOG^BPSOSL(IEN59,$T(+0)_"-Cannot change the PROCESS FLAG to COMPLETED: "_$P(BPRETV,U,2))
 . D:BPLCK UNLCKRF^BPSOSRX(RXI,RXR,IEN59,$T(+0))
 D LOG^BPSOSL(IEN59,$T(+0)_"-The request "_BP77_" has been changed to COMPLETED ("_+$P($G(^BPS(9002313.77,BP77,0)),U,4)_")")
 S BPTYPE=$P($G(^BPS(9002313.77,BP77,1)),U,4)
 ;
 ;Skip and delete duplicate requests if any
 ;and get the NEXT REQUEST
 S BPNXT77=+$$GETNXREQ^BPSOSRX6(BP77,1,1,IEN59)
 ;
 ;if this was reversal (UNCLAIM)
 ;- the following request is scheduled
 ;- the next request is "CLAIM"
 ;- the RX action is = resubmit (ERES)
 ;then this is a submit after reversal
 I BPTYPE="U",$P($G(^BPS(9002313.77,+BPNXT77,1)),U,4)="C",$P($G(^BPS(9002313.77,+BPNXT77,1)),U,1)="ERES" S RESAFTRV=1
 I RESAFTRV=1 D LOG^BPSOSL(IEN59,$T(+0)_"-Reverse then Resubmit attempt")
 ;
 S BPPAYSEQ=$$COB59^BPSUTIL2(IEN59) ;payer sequence
 ;
 ;if the current request is failed then cancel and delete all sequential requests and quit
 I $$SUCCESS^BPSOSRX7(BPTYPE,BPCLMST)=0 D  D:BPLCK UNLCKRF^BPSOSRX(RXI,RXR,IEN59,$T(+0)) Q 0
 . ;if secondary claim was rejected with certain reject codes - send it to Pharmacy worklist
 . I BPTYPE="C",BPPAYSEQ=2 I $$SENDREJ^BPSWRKLS(RXI,RXR,IEN59,BPPAYSEQ)
 . D LOG^BPSOSL(IEN59,$T(+0)_" request failed - removing this and all sequential requests")
 . I RESAFTRV=1 D LOG^BPSOSL(IEN59,$T(+0)_"Cannot - Reversal failed - E REVERSAL REJECTED")
 . D DELALLRQ^BPSOSRX7(BP77,IEN59)
 ;
 ;If there is no any "next request" for the RX/refill - delete the completed request and quit with 0
 I BPNXT77=0 D  Q 0
 . D LOG^BPSOSL(IEN59,$T(+0)_"-There is no NEXT REQUEST")
 . D DELREQST^BPSOSRX4(BP77) D:BPLCK UNLCKRF^BPSOSRX(RXI,RXR,IEN59,$T(+0))
 ;
 ;if NEXT REQUEST
 D LOG^BPSOSL(IEN59,$T(+0)_"-The NEXT "_$P($G(^BPS(9002313.77,+BPNXT77,1)),U,4)_"-type REQUEST is "_BPNXT77)
 ;
 S BPTYPREQ=$P($G(^BPS(9002313.77,+BPNXT77,1)),U,4) ;action type
 ;if secondary claim AND action type ="C"
 ;- don't do billing determination again - it was done manually by the user, so we can't do it here
 I BPPAYSEQ>1,BPTYPREQ="C" S BPRETACT=$$ACTIVATE^BPSNCPD4(BPNXT77,"C") G:BPRETACT=0 SUCC G UNSUCC
 ;
 I RESAFTRV=1 D LOG^BPSOSL(IEN59,$T(+0)_"-Now resubmit")
 S BFILLDAT=+$P($G(^BPS(9002313.77,BPNXT77,2)),U)
 S BWHERE=$P($G(^BPS(9002313.77,BPNXT77,1)),U)
 S BILLNDC=$P($G(^BPS(9002313.77,BPNXT77,2)),U,6) ;if we do not send it then BPSNCPDP will get the latest NDC
 S REVREAS=$P($G(^BPS(9002313.77,BPNXT77,2)),U,2)
 S DURREC=""
 S BPDUR=$O(^BPS(9002313.77,BPNXT77,3,"")) I BPDUR S DURREC=^BPS(9002313.77,BPNXT77,3,BPDUR,0)
 S BPOVRIEN=$P($G(^BPS(9002313.77,BPNXT77,2)),U,4)
 S BPSCLARF=$P($G(^BPS(9002313.77,BPNXT77,2)),U,5)
 S BPSAUTH=$P($G(^BPS(9002313.77,BPNXT77,2)),U,7) I BPSAUTH'="" S BPSAUTH=BPSAUTH_U_$P($G(^BPS(9002313.77,BPNXT77,2)),U,8)
 S BPCOBIND=+$P($G(^BPS(9002313.77,BPNXT77,0)),U,3)
 ;S BPJOBFLG="B"
 ;S BPREQIEN=BPNXT77
 ;call ECME engine in "B" (background) mode to:
 ; perform checks if necessary,
 ; update billing info if this is a CLAIM
 ; and then activate the request
 S BPRET=$$EN^BPSNCPDP(RXI,RXR,BFILLDAT,BWHERE,BILLNDC,REVREAS,DURREC,BPOVRIEN,BPSCLARF,BPSAUTH,BPCOBIND,"B",BPNXT77)
UNSUCC ;if wasn't successful
 I +BPRET'=0 D  Q 0
 . D LOG^BPSOSL(IEN59,$T(+0)_"-Cannot activate the next request: "_$P(BPRET,U,2))
 . D DELALLRQ^BPSOSRX7(BP77,IEN59)
 . D:BPLCK UNLCKRF^BPSOSRX(RXI,RXR,IEN59,$T(+0))
SUCC ;if successful
 D LOG^BPSOSL(IEN59,$T(+0)_"-The NEXT "_$P($G(^BPS(9002313.77,+BPNXT77,1)),U,4)_"-type REQUEST "_BPNXT77_" has been activated")
 ;delete the completed REQUEST only if the next one has been activated successfully
 D DELREQST^BPSOSRX4(BP77)
 D:BPLCK UNLCKRF^BPSOSRX(RXI,RXR,IEN59,$T(+0))
 ;run background process to pick up the activated request for secondary claim (for primary only - it is done when we call EN^BPSNCPDP above)
 I BPPAYSEQ>1,BPTYPREQ="C" D RUNNING^BPSOSRX()
 Q BPNXT77
 ;BPSOSRX5
