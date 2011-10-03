BPSOSQ4 ;BHAM ISC/FCS/DRS/DLF - Process responses ;12/7/07  15:48
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5,7**;JUN 2004;Build 46
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; This routine has two components
 ;   Procedures to report Response info
 ;   Procedures to handle insurer asleep functions
 Q
 ;
 ; The following are separate little utilities called from elsewhere.
 ;
PAID(IEN59) ;quick query to see if it's paid
 N TMP D RESPINFO(IEN59,.TMP) Q:'$D(TMP("RSP")) 0
 N X S X=TMP("RSP")
 I X="Payable" Q 1
 Q 0
RESPINFO(RXI,DST) ;EP - BPSOS6M
 ; quick way to get all the response info for a given RXI
 ; IMPORTANT!!  Do not change spelling, case, wording, or spacing!!!
 ; If a reversal was attempted, it complicates things.
 ;  fills DST array as follows:
 ; DST("HDR")=Response Status (header)
 ; DST("RSP")=Response Status (prescription)
 ;   This could be:  "Payable"  "Rejected"  "Captured"  "Duplicate"
 ;   or  "Accepted reversal"  or  "Rejected reversal"
 ;   or  "null"   or "null reversal"  (no response or corrupt response
 ;    or maybe someone without insurance, so no request was sent)
 ; DST("REJ",0)=count of reject codes
 ; DST("REJ",n)=each reject code
 ; DST("MSG")=message with the response
 ; All of these are defined, even if originals were '$D.
 ; The external forms are returned.
 N REVERSAL S REVERSAL=$G(^BPST(RXI,4))>0
 N RESP
 I 'REVERSAL S RESP=$P(^BPST(RXI,0),U,5)
 E  S RESP=$P(^BPST(RXI,4),U,2)
 I 'RESP Q
 N ECME S POS=$P(^BPST(RXI,0),U,9) Q:'POS
 N FMT S FMT="E"
 S DST("HDR")=$$RESP500(RESP,FMT)
 S DST("RSP")=$$RESP1000(RESP,POS,FMT)
 S DST("REJ",0)=$$REJCOUNT(RESP,POS,FMT)
 I DST("REJ",0) D
 . N I F I=1:1:DST("REJ",0) S DST("REJ",I)=$$REJCODE(RESP,POS,I,FMT)
 S DST("MSG")=$$RESPMSG(RESP,POS,FMT)
 ; Dealing with oddities of PCS (and others'?) response to reversals
 I REVERSAL,DST("RSP")["null" D
 . I DST("RSP")["null" S DST("RSP")=DST("HDR")_" reversal"
 Q
 ; In the following quickies:
 ; RESP = RESPIEN, pointer to 9002313.03
 ; FMT = "I" for internal, "E" for external, defaults to internal
RESP500(RESP,FMT) ;EP - BPSOS57,BPSOSUC
 ; returns the response header status
 N X S X=$P($G(^BPSR(RESP,500)),U)
 I $G(FMT)'="E" Q X
 I X="" S X="null"
 S X=$S(X="A":"Accepted",X="R":"Rejected",1:"?"_X)
 Q X
RESP1000(RESP,POS,FMT) ;EP - BPSOSUC
 ; returns the prescription response status
 ; Note!  Could be DP or DC for duplicates
 N X S X=$P($G(^BPSR(RESP,1000,POS,500)),U)
 I $G(FMT)'="E" Q X
 I X="" S X="null"
 ;
 ;IHS/SD/lwj 10/07/02 NCPDP 5.1 changes - they will send an "A" back
 ; now on the transaction level to indicate that it has been accepted
 ; Next code line remarked out - following added
 ;
 S X=$S(X="A":"Accepted",X="P":"Payable",X="R":"Rejected",X="C":"Captured",X="D"!(X="DP")!(X="DC"):"Duplicate",1:"?"_X)
 Q X
 ;
REJCOUNT(RESP,POS,FMT) ; returns rejection count
 Q +$P($G(^BPSR(RESP,1000,POS,511,0)),U,3)
 ;
REJCODE(RESP,POS,N,FMT) ; returns Nth rejection code
 ; if FMT="E", returns code:text
 N CODE S CODE=$P($G(^BPSR(RESP,1000,POS,511,N,0)),U)
 I CODE="" S CODE="null"
 I FMT'="E" Q CODE
 N X S X=$O(^BPSF(9002313.93,"B",CODE,0))
 I X]"" S CODE=CODE_":"_$P($G(^BPSF(9002313.93,X,0)),U,2)
 E  S CODE="?"_CODE
 Q CODE
 ;
 ; NCPDP 5.1 changes - message may not come back in 504.  They may
 ;  come back in 526 instead
RESPMSG(RESP,POS,FMT) ; response message - additional text from insurer
 ;
 N MSG
 S MSG=""
 S MSG=$G(^BPSR(RESP,504))
 S:MSG="" MSG=$G(^BPSR(RESP,1000,POS,504))
 S:MSG="" MSG=$G(^BPSR(RESP,1000,POS,526))
 Q MSG
 ;
 ;
NOW() ;
 Q $$NOW^XLFDT
 ;
 ; The xxxSLEEP functions are called from BPSOSQL
 ;
REJSLEEP(BPSRESP,BPSPOS,IEN59) ;
 ;
 ; - Check if the insurer should be asleep
 ;   based on the reject codes
 ; Input
 ;   BPSRESP - BPS Response IEN
 ;   BPSPOS  - Multiple IEN
 ;   IEN59   - BPS TRANSACTION IEN
 ; Return
 ;   1 if the insurer should go to sleep
 ;   0 if the insurer should not go to sleep
 ;
 N BPSSITE,BPSSLEEP,BPSI,BPSPLAN,BPAIEN,BPSRET
 ;
 ; Validate parameters
 I '$G(BPSRESP) Q 0
 I '$G(BPSPOS) Q 0
 ;
 ; Check site params to see if disabled
 S BPSSITE=$G(^BPS(9002313.99,1,0))
 I '$P(BPSSITE,"^",5)!('$P(BPSSITE,"^",6)) Q 0
 ;
 ; Find the Group Insurance Plan from the Submit Request
 S BPSPLAN=$$GETPLN77^BPSUTIL2(+$P($G(^BPST(IEN59,0)),U,12)) I 'BPSPLAN Q 0
 ;
 ; Is this a reject code to consider?
 S BPSRET=0 F BPSI=90,91,92,95,96,97,98 D  Q:BPSRET
 . I $D(^BPSR(BPSRESP,1000,BPSPOS,511,"B",BPSI)) S BPSRET=1
 ;
 ; Make sure reject 88 (DUR) or 79 (Refill Too Soon) doesn't exist (it shouldn't)
 I $D(^BPSR(BPSRESP,1000,BPSPOS,511,"B",88)) S BPSRET=0
 I $D(^BPSR(BPSRESP,1000,BPSPOS,511,"B",79)) S BPSRET=0
 ;
 ; Check to Ignore Asleep
 I BPSRET,$$IGNORE^BPSOSQF(+BPSPLAN) S BPSRET=0
 ;
 Q BPSRET
 ;
ADDSLEEP(BPSIEN59) ;
 ; Adds a payer (if not already there) to the Asleep file
 ;     BPSIEN59 - BPS TRANSACTION IEN
 ;
 N BPSPLAN,DIC,X,Y,DO,DTOUT,DUOUT,BPSIEN77
 ;
 ; Get BPS Request entry for Prober
 S BPSIEN77=+$P($G(^BPST(BPSIEN59,0)),U,12)
 ;
 ; Find the Group Insurance Plan
 S BPSPLAN=$$GETPLN77^BPSUTIL2(BPSIEN77) I 'BPSPLAN Q 0
 ;
 ; If already in file quit
 I $D(^BPS(9002313.15,"B",+BPSPLAN)) Q 0
 ;
 S DIC=9002313.15,DIC(0)="",X=+BPSPLAN
 S DIC("DR")=".02///0;.03///0;.04////^S X=BPSIEN77"
 D FILE^DICN
 ;
 Q Y
 ;
INCSLEEP(BPSIEN59) ; called from BPSOSQL
 ; INCSLEEP - Increment sleep time for this insurer
 ; Input
 ;   BPSIEN59 - BPS TRANSACTION IEN
 ; Return the scheduled retry time
 ;
 N BPSPLAN,BPSIEN15,BPS15Z,BPSPARAM,BPSRETRY,BPSIEN77,BPERRMSG
 ;
 S BPERRMSG="Cannot populate in BPS REQUEST, field#: "
 ; Get BPS Request entry for Prober
 S BPSIEN77=+$P($G(^BPST(BPSIEN59,0)),U,12)
 ; Get GROUP INSURANCE PLAN
 S BPSPLAN=$$GETPLN59^BPSUTIL2(BPSIEN59) I 'BPSPLAN Q 0
 ; Get BPS PARAMETERS
 S BPSPARAM=^BPS(9002313.99,1,0)
 ;
 ; If the payer is not already asleep, add it to the BPS ASLEEP PAYERS file
 S BPSIEN15=$O(^BPS(9002313.15,"B",+BPSPLAN,0)) I 'BPSIEN15 S BPSIEN15=+$$ADDSLEEP(BPSIEN59)
 I BPSIEN15<1 Q 0
 ; If the BPS TRANSACTION is not already pointing to the asleep payer, update it
 I '$D(^BPST("ASL",BPSIEN15,BPSIEN59)) D
 . S DA=BPSIEN59,DIE=9002313.59,DR="801////^S X=BPSIEN15" D ^DIE
 ;
 S BPS15Z=^BPS(9002313.15,BPSIEN15,0)
 ; If maximum retries reached, flag to ignore and set status to complete.
 I $P(BPS15Z,"^",2)+1>$P(BPSPARAM,"^",6) D  Q 0
 . I $$FILLFLDS^BPSUTIL2(9002313.15,".03",BPSIEN15,1)<1 Q
 . D LOG^BPSOSL(BPSIEN59,$T(+0)_"Maximum retries reached for insurer. Completing BPS TRANSACTION: "_BPSIEN59)
 . D SETSTAT^BPSOSU(BPSIEN59,99)
 ;
 ; Set RETRY TIME based on site parameters
 S BPSRETRY=$$FMADD^XLFDT($$NOW^XLFDT,,,$P(BPSPARAM,"^",5),10) ; add 10 seconds
 ; Increment the RETRY COUNT and RETRY TIME
 I $$FILLFLDS^BPSUTIL2(9002313.15,".02",BPSIEN15,$P(BPS15Z,U,2)+1)<1 Q 0
 I $$FILLFLDS^BPSUTIL2(9002313.15,".05",BPSIEN15,BPSRETRY)<1 Q 0
 ;S DIE=9002313.15,DA=BPSIEN15,DR=".02////^S X=$P(BPS15Z,U,2)+1;.05///^S X=BPSRETRY" D ^DIE
 ; Update BPS REQUEST to ACTIVATED with the DON'T PROCESS UNTIL field set to retry time.
 I $$FILLFLDS^BPSUTIL2(9002313.77,".08",BPSIEN77,BPSRETRY)<1 Q "0^"_BPERRMSG_".08"
 I $$FILLFLDS^BPSUTIL2(9002313.77,".04",BPSIEN77,1)<1 Q "0^"_BPERRMSG_".04"
 N BPZ S BPZ=$$UPUSRTIM^BPSOSRX6(BPSIEN77,$S($G(DUZ):+DUZ,1:.5)) Q:+BPZ=0 BPZ
 ; queue prober based on site params
 D TASK(BPSRETRY)
 ;
 Q BPSRETRY
 ;
TASK(BPSDELAY) ;
 ; This will resubmit an entry in BPS REQUEST based on the time distance passed in
 ;    BPSDELAY = Delay time to resubmit (if any)
 ;
 N ZTDTH,ZTRTN,ZTSAVE,ZTDESC,ZTIO,ZTSK
 S ZTDTH=BPSDELAY
 S ZTRTN="BACKGR^BPSOSRB"
 S ZTDESC="Resubmit a prober claim for a sleeping payer."
 S ZTIO=""
 D ^%ZTLOAD
 Q
 ;
 ; Clear insurer sleeping condition
 ; GRPLAN = Group Insurance Plan IEN
CLRSLEEP(GRPLAN) ;EP - BPSOSQL
 N RETRY,BPS15IEN,PROBER,DA,DIE,DR,DIK
 ; Get the BPS ASLEEP PAYER record
 S BPS15IEN=$O(^BPS(9002313.15,"B",+GRPLAN,0))
 Q:BPS15IEN=""
 ; Delete the BPS ASLEEP PAYER record
 S DA=BPS15IEN,DIK="^BPS(9002313.15," D ^DIK
 ; If there are other BPS TRANSACTIONS with the asleep payer pointer
 ; defined, remove it. (This shouldn't happen since DIK removes the pointers,
 ; but just in case.)
 I $D(^BPST("ASL",BPS15IEN)) D
 . N IEN59
 . S IEN59=""
 . F  S IEN59=$O(^BPST("ASL",BPS15IEN,IEN59)) Q:IEN59=""  D
 . . S DA=IEN59,DIE=9002313.59,DR="801///@" D ^DIE
 ; If this insurer was asleep and there are other asleep transactions, fire off
 ; the Packeter task to see if they should be done
 I $D(^BPST("AD",31)) D
 . N IEN59,IEN77 S IEN59=0
 . F  S IEN59=$O(^BPST("AD",31,IEN59)) Q:'IEN59  D
 . . ; Set status back to 0
 . . D SETSTAT^BPSOSU(IEN59,0)
 . . S IEN77=+$P($G(^BPST(IEN59,0)),U,12)
 . . Q:IEN77=""
 . . ; Activate BPS REQUEST
 . . I $$FILLFLDS^BPSUTIL2(9002313.77,".04",IEN77,1)<1 Q
 D TASK($$NOW^XLFDT())
 Q
 ;
