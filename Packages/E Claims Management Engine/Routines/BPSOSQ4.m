BPSOSQ4 ;BHAM ISC/FCS/DRS/DLF - Process responses ;12/7/07  15:48
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5,7,10**;JUN 2004;Build 27
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
RESPINFO(IEN59,DST) ;EP - BPSOS6M
 ; quick way to get all the response info for a given BPS Transaction
 ; IMPORTANT!!  Do not change spelling, case, wording, or spacing!!!
 ; If a reversal was attempted, it complicates things.
 ;  fills DST array as follows:
 ; DST("HDR")=Response Status (header)
 ; DST("RSP")=Response Status (transaction)
 ;   This could be: "Payable", "Rejected", "Accepted", "Captured",
 ;                  "Duplicate", or  "null"
 ; DST("REJ",0)=count of reject codes
 ; DST("REJ",n)=each reject code
 ; DST("MSG")=message with the response
 ; All of these are defined, even if originals were '$D.
 ; The external forms are returned.
 N REVERSAL S REVERSAL=$G(^BPST(IEN59,4))>0
 N RESP
 I 'REVERSAL S RESP=$P(^BPST(IEN59,0),U,5)
 E  S RESP=$P(^BPST(IEN59,4),U,2)
 I 'RESP Q
 N ECME S POS=$P(^BPST(IEN59,0),U,9) Q:'POS
 N FMT S FMT="E"
 S DST("HDR")=$$RESP500(RESP,FMT)
 S DST("RSP")=$$RESP1000(RESP,POS,FMT)
 S DST("REJ",0)=$$REJCOUNT(RESP,POS,FMT)
 I DST("REJ",0) D
 . N I F I=1:1:DST("REJ",0) S DST("REJ",I)=$$REJCODE(RESP,POS,I,FMT)
 S DST("MSG")=$$RESPMSG(RESP,POS)
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
 ; returns the transaction response status
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
 ; NCPDP D.0 change - 526 is a repeating field
RESPMSG(RESP,POS) ; response message - additional text from insurer
 ;
 I '$G(RESP) Q ""
 I '$G(POS) S POS=1
 N MSG
 S MSG=""
 S MSG=$G(^BPSR(RESP,504))
 I MSG]"" Q MSG
 N ADDMESS,N
 D ADDMESS^BPSSCRLG(RESP,POS,.ADDMESS)
 S N="" F  S N=$O(ADDMESS(N)) Q:'N  S MSG=MSG_$S(N=1:"",1:"~")_ADDMESS(N)
 Q MSG
 ;
 ;
NOW() ;
 Q $$NOW^XLFDT
 ;
 ; The xxxSLEEP functions are called from BPSOSQL
 ; ISASLEEP also called by BPSOSQA
 ;
REJSLEEP(BPSRESP,BPSPOS,IEN59) ;
 ; Check if the insurer should be asleep based on the reject codes
 ; Input
 ;   BPSRESP - BPS Response IEN
 ;   BPSPOS  - Multiple IEN
 ;   IEN59   - BPS TRANSACTION IEN
 ; Return
 ;   1 if the insurer should go to sleep
 ;   0 if the insurer should not go to sleep
 ;
 N BPSSITE,REJCD,GRPLAN,BPSRET
 ;
 ; Validate parameters
 I '$G(BPSRESP) Q 0
 I '$G(BPSPOS) Q 0
 I '$G(IEN59) Q 0
 ;
 ; Check asleep parameters to see asleep functionality is disabled
 S BPSSITE=$G(^BPS(9002313.99,1,0))
 I '$P(BPSSITE,"^",5)!('$P(BPSSITE,"^",6)) Q 0
 ;
 ; Do not do insurer asleep for Eligibility Verification requests
 I $P($G(^BPST(IEN59,0)),U,15)="E" Q 0
 ; 
 ; Get the Group Insurance Plan and verify if asleep functionality is on
 S GRPLAN=$$GETPLN59^BPSUTIL2(IEN59) I 'GRPLAN Q 0
 I $$IGNORE^BPSOSQF(+GRPLAN) Q 0
 ;
 ; Don't sleep if response has reject 88 (DUR) or 79 (Refill Too Soon)
 I $D(^BPSR(BPSRESP,1000,BPSPOS,511,"B",88)) Q 0
 I $D(^BPSR(BPSRESP,1000,BPSPOS,511,"B",79)) Q 0
 ;
 ; Is this a reject code to consider?
 S BPSRET=0
 F REJCD=90,91,92,95,96,97,98 I $D(^BPSR(BPSRESP,1000,BPSPOS,511,"B",REJCD)) S BPSRET=1 Q
 ;
 Q BPSRET
 ;
ADDSLEEP(IEN59) ;
 ; Adds a payer (if not already there) to the Asleep file
 ; Input
 ;   IEN59 - BPS TRANSACTION IEN
 ; Return
 ;   0 - No BPS Asleep Payer record created
 ;   BPS Asleep Payer IEN
 ;
 I '$G(IEN59) Q 0
 N GRPLAN,DIC,X,Y,DO,DTOUT,DUOUT
 ;
 ; Find the Group Insurance Plan
 S GRPLAN=$$GETPLN59^BPSUTIL2(IEN59) I 'GRPLAN Q 0
 ;
 ; If already in file quit
 I $D(^BPS(9002313.15,"B",+GRPLAN)) Q 0
 ;
 S DIC=9002313.15,DIC(0)="",X=+GRPLAN
 S DIC("DR")=".02///0;.03///0;.04////^S X=IEN59"
 D FILE^DICN
 ;
 Q Y
 ;
INCSLEEP(IEN59) ; called from BPSOSQL
 ; INCSLEEP - Increment sleep time for this insurer
 ; Input
 ;   IEN59 - BPS TRANSACTION IEN
 ; Return
 ;    0 - Awake now 
 ;    1 - Still asleep
 ;
 I '$G(IEN59) Q 0
 N GRPLAN,BPSIEN15,RETCNT,BPSPARAM,BPSRETRY,PROBER,IEN59T
 N DIE,DA,DR,DTOUT
 ;
 ; Get GROUP INSURANCE PLAN
 S GRPLAN=$$GETPLN59^BPSUTIL2(IEN59) I 'GRPLAN Q 0
 ;
 ; If the payer is not already asleep, add it to the BPS ASLEEP PAYERS file
 S BPSIEN15=$O(^BPS(9002313.15,"B",+GRPLAN,0))
 I 'BPSIEN15 S BPSIEN15=+$$ADDSLEEP(IEN59)
 I BPSIEN15<1 Q 0
 ;
 ; Get the prober.
 S PROBER=$P($G(^BPS(9002313.15,BPSIEN15,0)),U,4)
 ;
 ; If there is a prober and this is not it, just put this transaction to sleep and quit
 I PROBER,IEN59'=PROBER D SETSLEEP(IEN59,BPSIEN15,$T(+0)_"-Insurer Asleep-Waiting for Prober Transaction "_PROBER_" to complete") Q 1
 ; 
 ; Get Asleep Paramters from BPS SETUP
 ; If the parameters are off, return 0
 S BPSPARAM=^BPS(9002313.99,1,0)
 I '$P(BPSPARAM,"^",5)!('$P(BPSPARAM,"^",6)) Q 0
 ;
 ; If maximum retries reached, flag to wake up and set status to complete.
 S RETCNT=$P($G(^BPS(9002313.15,BPSIEN15,0)),U,2)+1
 I RETCNT>$P(BPSPARAM,"^",6) D  Q 0
 . D LOG^BPSOSL(IEN59,$T(+0)_"-Maximum retries reached for insurer. Completing BPS TRANSACTION: "_IEN59)
 ;
 ; Set RETRY TIME based on site parameters and update retry count and retry time
 S BPSRETRY=$$FMADD^XLFDT($$NOW^XLFDT,,,$P(BPSPARAM,"^",5))
 I $$FILLFLDS^BPSUTIL2(9002313.15,".02",BPSIEN15,RETCNT)<1 Q 0
 I $$FILLFLDS^BPSUTIL2(9002313.15,".05",BPSIEN15,BPSRETRY)<1 Q 0
 ;
 ; Put the prober to Sleep
 S MSG="Retry number "_RETCNT_" scheduled for "_$$FMTE^XLFDT(BPSRETRY)
 D SETSLEEP(IEN59,BPSIEN15,$T(+0)_"-Insurer Asleep for "_$P(GRPLAN,U,2)_". "_MSG)
 ;
 ; Update the Last Update date/time for associated claims so that they don't
 ;   end up on the View/Unstand Submission Screen
 S IEN59T="" F  S IEN59T=$O(^BPST("ASL",BPSIEN15,IEN59T)) Q:IEN59T=""  D
 . I IEN59T=PROBER Q
 . S DIE=9002313.59,DA=IEN59T,DR="7///NOW" D ^DIE
 . D LOG^BPSOSL(IEN59T,$T(+0)_"-INCSLEEP is resetting the LAST UPDATE field to the current date/time")
 ;
 ; Queue packeter to restart at next retry time+10 seconds
 D TASKAT^BPSOSQA($$FMADD^XLFDT(BPSRETRY,,,,10))
 ;
 Q 1
 ;
SETSLEEP(IEN59,BPSIEN15,MSG) ;
 ; Put transaction to sleep
 ; Input
 ;   IEN59 - BPS Transaction IEN
 ;   BPSIEN15 - BPS Asleep Payer IEN
 ;   MSG - Message used for Log
 ;
 I '$G(IEN59) Q
 I '$G(BPSIEN15) Q
 N DIE,DA,DR,DTOUT
 ;
 ; If the BPS TRANSACTION is not already pointing to the asleep payer, update it
 I '$D(^BPST("ASL",BPSIEN15,IEN59)) S DIE=9002313.59,DA=IEN59,DR="801////^S X=BPSIEN15" D ^DIE
 ;
 ; Set to 31% (Wait for retry (insurer asleep)) and log message
 D SETSTAT^BPSOSU(IEN59,31)
 I $G(MSG)="" S MSG=$T(+0)_"-Transaction being put to sleep by SETSLEEP"
 D LOG^BPSOSL(IEN59,MSG)
 Q
 ;
CLRSLEEP(GRPLAN,IEN59) ;EP - BPSOSQL
 ; Clear insurer sleeping condition
 ; Input:
 ;   GRPLAN - Group Insurance Plan IEN
 ;   IEN59 - BPS Transaction IEN 
 ;
 I '$G(GRPLAN) Q
 N BPSIEN15,DA,DIE,DR,DTOUT,DIK,IEN59T
 ;
 ; Get the BPS ASLEEP PAYER record
 S BPSIEN15=$O(^BPS(9002313.15,"B",+GRPLAN,0))
 I BPSIEN15="" Q
 ;
 ; Logging message and creating a comment
 I $G(IEN59) D LOG^BPSOSL(IEN59,$T(+0)_"-Clearing sleep for "_$P(GRPLAN,U,2))
 ;
 ; Delete the BPS ASLEEP PAYER record
 S DA=BPSIEN15,DIK="^BPS(9002313.15," D ^DIK
 ;
 ; Clear any pointers to the sleep payer
 S IEN59T="" F  S IEN59T=$O(^BPST("ASL",BPSIEN15,IEN59T)) Q:IEN59T=""  D
 . S DIE=9002313.59,DA=IEN59T,DR="801///@" D ^DIE
 . D LOG^BPSOSL(IEN59T,$T(+0)_"-CLRSLEEP is clearing pointer to ASLEEP PAYER")
 ;
 ; Run the packeter to resubmit any other claims for the this payer
 D TASK^BPSOSQA
 Q
