BPSOSRX7 ;ALB/SS - ECME REQUESTS ;04-JAN-08
 ;;1.0;E CLAIMS MGMT ENGINE;**7**;JUN 2004;Build 46
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
 ;Input:
 ;BPRXIEN - RX ien (#52)
 ;BPREFIL - refill number
 ;BPREQS (by reference)- local array to convey results back to the caller
 ;   BPREQS = number of nodes stored in the array
 ;   BPREQS(n)=BPS REQUEST ien ^ Claim type ^ COB
 ;
 ;return values:
 ; -5 : Unexpected ACTIVATED or IN PROCESS request has been found
 ; -4 : Multiple BPS REQUEST records with the same NEXT REQUEST value
 ; -3 : SCHEDULED request(s) were found but they is not ACTIVATED for some reason
 ; -2 : duplicate ACTVATED / IN PROCESS requests for the same RX/RF - this should not happen
 ; -1 : cannot be accepted - because reversal was requested 
 ; and there are requests already for this RX/RF in the queue
 ; and the last one is REVERSAL too for the same COB
 ; so we will return "-1^Sequential duplicate reversal"
 ; 0 : can be accepted because there are NO requests for this RX/RF 
 ; we will create a new record in BPS REQUEST for it and ACTIVATE it.
 ; >0 : IEN of the last BPS REQUEST in the queue - there are requests already for this RX/RF.
 ;
CHKREQST(BPRXIEN,BPREFIL,BPREQS) ;
 N BPPRFLG,BPCURNT,BPNEXT,BPCOB,BPRCUR,BPRNXT,BPQ,BPCNT,BPZ
 ;get the current IN PROCESS request for this RX/refill
 S BPPRFLG=2 D  I BPCURNT>0 I $O(^BPS(9002313.77,"AC",2,BPRXIEN,BPREFIL,+BPCURNT))>0 Q "-2^Error: More than one IN PROCESS request for RXIEN="_BPRXIEN_", REFILL="_BPREFIL
 . S BPCURNT=$O(^BPS(9002313.77,"AC",BPPRFLG,BPRXIEN,BPREFIL,""))
 ;if there is no IN PROCESS then check ACTIVATED
 I BPCURNT="" S BPPRFLG=1 D  I BPCURNT>0 I $O(^BPS(9002313.77,"AC",BPPRFLG,BPRXIEN,BPREFIL,+BPCURNT))>0 Q "-2^Error: More than one ACTIVATED request for RXIEN="_BPRXIEN_", REFILL="_BPREFIL
 . S BPCURNT=$O(^BPS(9002313.77,"AC",BPPRFLG,BPRXIEN,BPREFIL,""))
 ;if there is no IACTIVATED then check SCHEDULED
 I BPCURNT="" S BPPRFLG=0 D  I BPCURNT>0 Q "-3^Error: There is a SCHEDULED request without ACTIVATED requests, RXIEN="_BPRXIEN_", REFILL="_BPREFIL
 . S BPCURNT=$O(^BPS(9002313.77,"AC",BPPRFLG,BPRXIEN,BPREFIL,""))
 ;if there is no any requests then return 0 
 I BPCURNT="" Q 0  ;can be accepted because there are NO requests for this RX/RF
 ;Otherwise...
 S BPQ=0,BPREQS=1
 S BPRCUR=BPCURNT
 ;save current_ien ^ actype ^ COB
 S BPREQS(BPREQS)=BPCURNT_U_$P($G(^BPS(9002313.77,BPCURNT,1)),U,4)_U_$P($G(^BPS(9002313.77,BPCURNT,0)),U,3)
 ;loop thru all SCHEDULED,ACTIVATED and IN PROCESS records starting with BPCURNT
 F  S BPRNXT=$O(^BPS(9002313.77,"AN",BPRCUR,"")) Q:BPRNXT=""  Q:BPQ'=0  D
 . I $D(BPREQS("R",BPRNXT)) S BPQ=-1 Q  ;error - more than one records with the same next request
 . ;BPZ - process flag ^ act type ^ COB
 . S BPZ=$G(^BPS(9002313.77,"AN",BPRCUR,BPRNXT))
 . I BPRCUR'=BPCURNT I +BPZ>0 S BPQ=+BPZ Q  ;except the first record in the loop - all others should be SCHEDULED (i.e. process flag =0)
 . S BPREQS=BPREQS+1
 . S BPREQS(BPREQS)=BPRNXT_U_$P($G(^BPS(9002313.77,BPRNXT,1)),U,4)_U_$P($G(^BPS(9002313.77,BPRNXT,0)),U,3)
 . S BPREQS("R",BPRNXT)="" ;used to check uniqueness
 . S BPRCUR=BPRNXT
 ;
 K BPREQS("R")
 I BPQ=-1 Q "-4^Error: Multiple BPS REQUEST records with the same NEXT REQUEST value for RXIEN="_BPRXIEN_", REFILL="_BPREFIL
 I BPQ=1 Q "-5^Error: Unexpected ACTIVATED request has been found for RXIEN="_BPRXIEN_", REFILL="_BPREFIL
 I BPQ=2 Q "-5^Error: Unexpected IN PROCESS request has been found for RXIEN="_BPRXIEN_", REFILL="_BPREFIL
 S BPZ=BPREQS(BPREQS)
 Q +BPZ
 ;
 ;
 ;BPTYPE: C -CLAIM, U- UNCLAIM
 ;BPCLMST:
 ;     For submissions (type =C):
 ;       E PAYABLE, E CAPTURED, E DUPLICATE, E REJECTED, E OTHER, and
 ;       E STRANDED
 ;
 ;     For Reversals (type =U):
 ;       E REVERSAL ACCEPTED, E REVERSAL REJECTED, E REVERSAL OTHER, and
 ;       E REVERSAL STRANDED
 ;returns:
 ;1 - request was succesful 
 ;0 - request failed
SUCCESS(BPTYPE,BPCLMST) ;
 I BPTYPE="C" Q $S((BPCLMST="E PAYABLE")!(BPCLMST="E DUPLICATE"):1,1:0)
 I BPTYPE="U" Q $S((BPCLMST="E REVERSAL ACCEPTED"):1,1:0)
 Q 0
 ;delete all sequential requests and quit
DELALLRQ(BP77,IEN59) ;
 N BPNXT77
 F  S BPNXT77=+$P($G(^BPS(9002313.77,BP77,0)),U,5) D  Q:+BPNXT77=0
 . D LOG^BPSOSL(IEN59,$T(+0)_" deleting "_$P($G(^BPS(9002313.77,BP77,1)),U,4)_"-type request = "_BP77)
 . D DELREQST^BPSOSRX4(BP77)
 . S BP77=BPNXT77
 Q
 ; All this does is to put it on a list and start a background job.
 ; Process both types of requests - CLAIMs and UNCLAIMs
 ;
 ; Input: see MKRQST
 ; $G(DONTACTV)=1 - do not ACTIVATE schduled request
 ; Return values:
 ;  1^BPS REQUEST ien = accepted for processing
 ;  0^reason = failure (should never happen)
UPDINSDT(BPIEN77,MOREDATA,IEN59) ;
 N BPRETV,BPIENS78
 N BPZ,RXI,RXR
 N BPCOB,BPQ,BPIEN772
 S BPZ=$G(^BPS(9002313.77,BPIEN77,0))
 S RXI=$P(BPZ,U,1),RXR=$P(BPZ,U,2)
 D LOG^BPSOSL(IEN59,$T(+0)_"- Gathering IB data for the request: "_BPIEN77)
 S BPRETV=$$MKINSUR^BPSOSRX2(RXI,RXR,.MOREDATA,.BPIENS78)
 I +BPRETV=0 Q BPRETV
 ;
 ;store ins to IB INSURER DATA multiple
 S BPQ=0
 S BPCOB=0 F  S BPCOB=$O(BPIENS78(BPCOB)) Q:+BPCOB=0!(BPQ=1)  D
 . I '$D(^BPS(9002313.77,BPIEN77,5,BPCOB)) D  I BPQ=1 Q
 . . S BPIEN772=$$INSITEM^BPSUTIL2(9002313.772,BPIEN77,BPCOB,BPCOB,"",,0)
 . . I BPIEN772<1 S BPERRMSG="Cannot create record in IBDATA multiple of the BPS REQUEST file",BPQ=1 Q
 . S BPERRMSG="Cannot populate a field in IBDATA multiple"
 . I $$FILLFLDS^BPSUTIL2(9002313.772,".02",BPCOB_","_BPIEN77,$S(BPCOBIND=BPCOB:1,1:0))<1 S BPQ=1 Q
 . I $$FILLFLDS^BPSUTIL2(9002313.772,".03",BPCOB_","_BPIEN77,BPIENS78(BPCOB))<1 S BPQ=1 Q
 I BPQ=1 Q "0^"_BPERRMSG_"INSURER DATA"
 ;
 Q "1^"_BPIEN77
 ;get eligibility
ELIG(DFN) ;
 N BPSARRY
 Q $P($$RX^IBNCPDP(DFN,.BPSARRY),U,3)  ;Call IB again
 ;BPSOSRX7
