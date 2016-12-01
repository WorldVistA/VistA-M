BPSOS03 ;BHAM ISC/FCS/DRS - 9002313.03 utilities ;06/01/2004
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5,10,20**;JUN 2004;Build 27
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ; General utilities for retrieval from 9002313.03, Claim Response
 ; $$INSPAID is used by BPSOSQL
INSPAID(N) ;EP - from BPSOSQL -  total amount paid by insurer
 N RX,TOT,X S (TOT,RX)=0
 F  S RX=$O(^BPSR(N,1000,RX)) Q:'RX  D
 . ; Try Gross Amount Due, and if that's zero, Usual and Customary
 . S X=$$INSPAID1(N,RX)
 . S TOT=TOT+X
 Q TOT
INSPAID1(N,RX) ;EP -
 N X S X=$$509(N,RX) Q X
NETPAID1(N,RX) ; EP - computed field in 9002313.57 and 9002313.59
 N X S X=$$509(N,RX) ; X = (#509) Total Amount Paid
 N SUB S SUB=1 ; Do we need to subtract (#505) Patient Pay Amount?
 N IEN02,INS,FMT S IEN02=$P(^BPSR(RESP,0),U)
 I IEN02 D
 . S INS=$P($G(^BPSC(IEN02,0)),U,2) Q:'INS    ;IHS/SD/lwj 9/11/02
 . S FMT=INS
 . N X S X=$P(^BPSF(9002313.92,FMT,1),U,10)
 . I X S SUB=0 ; Total paid means total paid by insurance
 I SUB S X=X-$$505(N,RX)
 I X<0,SUB D  ; apparently this format is supposed to be excl.
 . Q:'$G(FMT)
 . S $P(^BPSF(9002313.92,FMT,1),U,10)=1
 . S X=X+$$505(N,RX) ;*1.26*1*
 Q X
REJTEXT(RESP,POS,ARR) ; EP - fills array (passed by ref)
 K ARR
 N A,I,X,R S (A,I)=0
 F  S A=$O(^BPSR(RESP,1000,POS,511,A)) Q:'A  D
 . S R=$P(^BPSR(RESP,1000,POS,511,A,0),U)
 . Q:R=""
 . N S S S=$O(^BPSF(9002313.93,"B",R,0))
 . I S S X=$TR($G(^BPSF(9002313.93,S,0)),U,":")
 . E  S X=R_" unrecognized reject code"
 . S I=I+1,ARR(I)=X
 Q
MESSAGE(RESP,POS,N) ; EP - get additional message from response
 I '$G(RESP) Q ""
 I '$G(POS) S POS=1
 I $G(N)=1 Q $P($G(^BPSR(RESP,504)),U)
 I $G(N)=2 N MSG S MSG="" D  Q MSG
 . N ADDMESS,N
 . D ADDMESS^BPSSCRLG(RESP,POS,.ADDMESS)
 . S N="" F  S N=$O(ADDMESS(N)) Q:'N  S MSG=MSG_$S(N=1:"",1:"~")_ADDMESS(N)
 Q $$MESSAGE(RESP,POS,1)_$$MESSAGE(RESP,POS,2)
 ;
DFF2EXT(X) Q $$DFF2EXT^BPSECFM(X)
505(M,N) Q $$500(M,N,5) ; Patient Pay Amount
506(M,N) Q $$500(M,N,6) ; Ingredient Cost Paid
507(M,N) Q $$500(M,N,7) ; Dispensing Fee Paid
508(M,N) Q $$500(M,N,8) ; Sales Tax Paid
509(M,N) Q $$500(M,N,9) ; Total Amount Paid
512(M,N) Q $$500(M,N,12) ; Accumulated Deductible Amount
513(M,N) Q $$500(M,N,13) ; Remaining Deductible Amount
514(M,N) Q $$500(M,N,14) ; Remaining Benefit Amount
517(M,N) Q $$500(M,N,17) ; Amt Applied to Periodic Deduct
518(M,N) Q $$500(M,N,18) ; Amount of Copay/CoInsurance
519(M,N) Q $$500(M,N,19) ; Amt Attrib to Prod Selection
520(M,N) Q $$500(M,N,20) ; Amt Exceed Per Benefit Max
521(M,N) Q $$500(M,N,21) ; Incentive Fee Paid
523(M,N) Q $$500(M,N,23) ; Amount Attributed to Sales Tax
500(M,N,J) ; field #500+J signed numeric
 Q:'M!'N ""
 N X S X=$P($G(^BPSR(M,1000,N,500)),U,J)
 I $E(X,1,2)?2U S X=$E(X,3,$L(X))
 S X=$$DFF2EXT(X)
 Q X
 ;
RESPONSE(BPSRX,BPSFILL,BPSCOB) ; Pull fields from response.
 ; MRD;BPS*1.0*20 - Created this API to display additional information
 ; to the user when an RRR is successfully resubmitted.
 ; Input: (r) BPSRX   - Rx IEN (#52)
 ;        (o) BPSFILL - Refill#
 ;        (o) BPSCOB  - Payer Sequence
 ; Output: [1] Total Amount Paid, file# 9002313.0301, field #509
 ;         [2] Ingredient Cost Paid, field #506
 ;         [3] Amount of Copay/Coinsurance, field #518
 ;         [4] Dispensing Fee Paid, field #507
 ;         [5] Amount Applied to Periodic Deductible, field #517
 ;         [6] Remaining Deductible Amount, field #513
 ;
 N BPSPOS,BPSRESP,BPSTRAN,BPSX
 ;
 I '$G(BPSRX) Q ""             ; If no Rx passed in, Quit with "".
 I $G(BPSFILL)="" S BPSFILL=0  ; Default Fill to 0 if none.
 I '$G(BPSCOB) S BPSCOB=1      ; Default COB to 1/primary if none.
 ;
 ; Use $$CLAIM^BPSBUTL to determine the BPS Transaction and BPS Response
 ; based on the Rx, Fill, COB.
 ;
 S BPSX=$$CLAIM^BPSBUTL(BPSRX,BPSFILL,BPSCOB)
 S BPSTRAN=$P(BPSX,U,1)  ; BPS Transaction.
 S BPSRESP=$P(BPSX,U,3)  ; BPS Response.
 I BPSTRAN=""!(BPSRESP="") Q ""
 ;
 ; Pull the field Position in Claim from the BPS Transaction file.
 ;
 S BPSPOS=$$GET1^DIQ(9002313.59,BPSTRAN,14)
 I '$G(BPSPOS) S BPSPOS=1
 ;
 S BPSX=$$509(BPSRESP,BPSPOS)_"^"_$$506(BPSRESP,BPSPOS)
 S BPSX=BPSX_"^"_$$518(BPSRESP,BPSPOS)_"^"_$$507(BPSRESP,BPSPOS)
 S BPSX=BPSX_"^"_$$517(BPSRESP,BPSPOS)_"^"_$$513(BPSRESP,BPSPOS)
 ;
 Q BPSX
 ;
