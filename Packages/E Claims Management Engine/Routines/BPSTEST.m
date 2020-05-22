BPSTEST ;OAK/ELZ - ECME TESTING TOOL ;11/15/07  09:55
 ;;1.0;E CLAIMS MGMT ENGINE;**6,7,8,10,11,15,19,20,22,23,24,26**;JUN 2004;Build 24
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Look at BPSTEST1 for additional documentation of the Testing Tool
 ;
GETOVER(KEY1,KEY2,BPSORESP,BPSWHERE,BPSTYPE,BPPAYSEQ) ;
 ; called by BPSNCPDP to enter overrides for a particular RX
 ; INPUT
 ;    KEY1      - Prescription IEN/Patient IEN
 ;    KEY2      - Fill Number/Policy Number
 ;    BPSORESP  - Previous response when this claim was processed
 ;    BPSWHERE  - RX Action passed into BPSNCPDP
 ;    BPSTYPE   - R (Reversal), S (Submission), E (Eligibility)
 ;    BPPAYSEQ  - payer sequence 1 - primary, 2 - secondary 
 ; OUTPUT
 ;    None - Table BPS PAYER RESPONSE OVERRIDE entry is created.
 ;
 N BPSTRANS,BPSTIEN,BPSSRESP,DIC,X,Y,DIR,DIK,DA
 ;
 ; Check if testing is enabled
 I '$$CHECK() Q
 ;
 ; Option can not be run for Date of Death option as it causes errors
 I $G(XQY0)["DG DEATH ENTRY" W !,"The testing tool can not be run from Date of Death option" Q
 ;
 ; Do not run for background jobs
 I $D(ZTQUEUED)!(",AREV,CRLB,CRLR,CRLX,CRRL,PC,PL,"[(","_BPSWHERE_",")) Q
 ;
 ; Create Transaction Number
 S BPSTRANS=$$IEN59^BPSOSRX(KEY1,KEY2,$S($G(BPPAYSEQ)>0:+BPPAYSEQ,1:1))
 ;
 ; Lookup the record in the BPS PAYER RESPONSE OVERRIDE table
 S DIC=9002313.32,DIC(0)="",X=BPSTRANS
 D ^DIC
 S BPSTIEN=+Y
 ;
 ; Prompt if user wants to do overrides
 W !!,"Payer Overrides are enabled at this site.  If this is production environment,"
 W !,"do not enter overrides (enter No at the next prompt) and disable this"
 W !,"functionality in the BPS SETUP table."
 W !!,"Entering No at the next prompt will delete any current overrides for the"
 W !,"request, if they exist.",!
 S DIR(0)="SA^Y:Yes;N:No"
 S DIR("A")="Do you want to enter overrides for this request? ",DIR("B")="NO"
 D ^DIR
 ;
 ; If no, delete the transaction (if it exists) and quit
 I Y'="Y" D:BPSTIEN'=-1  Q
 . S DIK="^BPS(9002313.32,",DA=BPSTIEN
 . D ^DIK
 ;
 ; If the record does not exist, create it
 I BPSTIEN=-1 S BPSTIEN=$$CREATE(BPSTRANS)
 I BPSTIEN=-1 W !,"Failed to create the BPS PAYER RESPONSE OVERRIDE record",! Q
 ;
 ; If BPSTYPE is 'S' (submission) and old response is 'E Payable', change BPSTYPE to 'RS'
 ; But don't change BPSTYPE to 'RS' if the BPSWHERE value is "ERWV" which is the Resubmit Without Reversal action (BPS*1*20)
 I BPSTYPE="S",BPSWHERE'="ERWV",BPSORESP="E PAYABLE"!(BPSORESP="E DUPLICATE")!(BPSORESP="E REVERSAL REJECTED")!(BPSORESP="E REVERSAL UNSTRANDED") S BPSTYPE="RS"
 ;
 ; Update with the BPSTYPE
 D FILE("^BPS(9002313.32,",BPSTIEN,.02,BPSTYPE)
 ;
 ; Message for RS
 I BPSTYPE="RS" D
 . W !!,"This submission may also have a reversal so you will be prompted for the"
 . W !,"reversal overrides."
 ;
 ; If BPSTYPE is equal to 'E', then prompt for eligibility response
 I BPSTYPE["E" D
 . W !!,"Eligibility Questions"
 . D PROMPT(BPSTIEN,.08,"A")
 . N BPSRESP
 . S BPSRESP=$$GET1^DIQ(9002313.32,BPSTIEN_",",.08,"I")
 . I BPSRESP="R" D REJECTS(BPSTIEN) ; BPS*1*22
 ;
 ; If BPSTYPE contains 'R', then prompt for reversal response
 I BPSTYPE["R" D
 . W !!,"Reversal Questions"
 . D PROMPT(BPSTIEN,.05,"A")
 . N BPSRESP
 . S BPSRESP=$$GET1^DIQ(9002313.32,BPSTIEN_",",.05,"I")
 . I BPSRESP="R" D ENREVRJ(BPSTRANS)
 ;
 ; If BPSTYPE contains 'S', do submission response
 I BPSTYPE["S" D
 . W !!,"Submission Questions"
 . D PROMPT(BPSTIEN,.03,"P")
 . S BPSSRESP=$$GET1^DIQ(9002313.32,BPSTIEN_",",.03,"I")
 . I BPSSRESP="P"!(BPSSRESP="D") D PROMPT(BPSTIEN,.04,40)       ; total amount paid (509-F9)
 . I BPSSRESP="P"!(BPSSRESP="D") D PROMPT(BPSTIEN,.06,9)        ; copay amount (518-FI)
 . I BPSSRESP="R" D REJECTS(BPSTIEN) ; BPS*1*22
 . ;
 . ; This section is for new D1-E7 fields and other fields so we can test that they are filed correctly
 . ; At some point, these can probably be removed
 . I BPSSRESP="P"!(BPSSRESP="D")!(BPSSRESP="R") D
 .. ;
 .. ; Ask if user wants to enter data for additional response file fields - Quit if user says no
 .. N DIR,DTOUT,DUOUT,DIROUT,DIRUT
 .. S DIR(0)="YA",DIR("A")="Populate Additional Response Fields? ",DIR("B")="No" W ! D ^DIR
 .. I Y'=1 Q
 .. ;
 .. ; Overrides to test functionality of BPS*1*20
 .. D PROMPT(BPSTIEN,.15,0)        ; Ingredient Cost Paid (506)
 .. D PROMPT(BPSTIEN,.16,0)        ; Dispensing Fee Paid (507)
 .. D PROMPT(BPSTIEN,.17,0)        ; Remaining Deductible Amount (513)
 .. D PROMPT(BPSTIEN,.18,0)        ; Amount Applied to Periodic Deductible (517)
 .. ;
 .. ; Additional overrides for D1-D9 (BPS*1*15)
 .. D PROMPT(BPSTIEN,.09,"")       ; next available fill date
 .. D PROMPT(BPSTIEN,.1,"")        ; adjudicated payment type
 .. ;
 .. ; Additional overrides for E0-E6 (BPS*1*19)
 .. D PROMPT(BPSTIEN,2.01,"04")    ; % sales tax basis pd
 .. D PROMPT(BPSTIEN,2.02,11)      ; other amount paid qualifier
 .. D PROMPT(BPSTIEN,2.03,"01")    ; payer id qualifier
 .. D PROMPT(BPSTIEN,2.04,"")      ; help desk phone# ext
 .. D PROMPT(BPSTIEN,2.05,"")      ; pro service fee cont/reim amt
 .. D PROMPT(BPSTIEN,2.06,"")      ; other payer help desk phone# ext
 .. D PROMPT(BPSTIEN,2.07,"")      ; response intermed auth type id
 .. D PROMPT(BPSTIEN,2.08,"")      ; response intermed auth id
 .. D PROMPT(BPSTIEN,3.01,"")      ; response intermed message
 .. ;
 .. ; E7 overrides (BPS*1*20)
 .. D PROMPT(BPSTIEN,.11,"")          ; quan limit per specific time period
 .. D PROMPT(BPSTIEN,.12,"")          ; quan limit time period
 .. D PROMPT(BPSTIEN,.13,"")          ; days supp limit per specific time period
 .. D PROMPT(BPSTIEN,.14,"")          ; days supp limit time period
 .. ; Overrides to test functionality - BPS*1*22
 .. D PROMPT(BPSTIEN,2.09,"")         ; reconciliation id
 .. ;
 .. D PROMPT(BPSTIEN,2.1,"")          ; Patient Pay Amount
 .. D PROMPT(BPSTIEN,2.11,"")         ; Reason for Service Code
 .. ;
 .. D PROMPT(BPSTIEN,4.01,"")         ; Maximum Age Qualifier
 .. D PROMPT(BPSTIEN,4.02,"")         ; Maximum Age
 .. D PROMPT(BPSTIEN,4.03,"")         ; Maximum Amount
 .. D PROMPT(BPSTIEN,4.04,"")         ; Maximum Amount Qualifier
 .. D PROMPT(BPSTIEN,4.05,"")         ; Maximum Amount Time Period
 .. D PROMPT(BPSTIEN,4.06,"")         ; Maximum Amount Time Period Start Date
 .. D PROMPT(BPSTIEN,4.07,"")         ; Maximum Amount Time Period End Date
 .. D PROMPT(BPSTIEN,4.08,"")         ; Maximum Amount Time Period Units
 .. D PROMPT(BPSTIEN,4.09,"")         ; Minimum Age Qualifier
 .. D PROMPT(BPSTIEN,4.1,"")          ; Minimum Age
 .. D PROMPT(BPSTIEN,4.11,"")         ; Other Payer Adjudicated Program Type
 .. D PROMPT(BPSTIEN,4.12,"")         ; Patient Pay Component Amount
 .. D PROMPT(BPSTIEN,4.13,"")         ; Patient Pay Component Count
 .. D PROMPT(BPSTIEN,4.14,"")         ; Patient Pay Component Qualifier
 .. D PROMPT(BPSTIEN,4.15,"")         ; Minimum Amount
 .. D PROMPT(BPSTIEN,4.16,"")         ; Minimum Amount Qualifier
 .. D PROMPT(BPSTIEN,4.17,"")         ; Other Payer Name
 .. D PROMPT(BPSTIEN,4.18,"")         ; Remaining Amount
 .. D PROMPT(BPSTIEN,4.19,"")         ; Remaining Amount Qualifier
 .. D PROMPT(BPSTIEN,4.2,"")          ; Other Payer Relationship Type
 ;
 W ! D PROMPT(BPSTIEN,.07,0)
 Q
 ;
SETOVER(BPSTRANS,BPSTYPE,BPSDATA) ;
 ; called by BPSECMPS to set the override data
 ; Input
 ;    BPSTRANS - Transaction IEN
 ;    BPSTYPE  - B1 for submission, B2 for reversals
 ; Output
 ;    BPSDATA    - Passed by reference and updated with appropriate overrides
 ;
 N BPSTIEN,BPSRRESP,BPSSRESP,BPSPAID,BPSRCNT,BPSRIEN,BPSRCODE,BPSRCD,BPSCOPAY,BPSXXXX,BPSUNDEF
 N BPSAJPAY,BPSNFLDT,BPSX
 N BPS506,BPS507,BPS513,BPS517
 ;
 ; Check the Test Flag in set in BPS SETUP
 I '$$CHECK() Q
 ;
 ; Check if the Transaction Number is defined in BPS RESPONSE OVERRIDES
 S BPSTIEN=$O(^BPS(9002313.32,"B",BPSTRANS,""))
 I BPSTIEN="" Q
 ;
 ; If a eligibility, check for specific reversal overrides and set
 ; If a reversal, check for specific reversal overrides and set
 ; If a submission, check for specific submission overrides and set
 ;   the code for the above checks was moved to SETOVER^BPSTEST2
 D SETOVER^BPSTEST2
 Q
 ;
SELOVER ;
 ; Used to create overrides for prescription that will processed in the
 ; background (CMOP, auto-reversals).  The user is prompted for the
 ; prescription and other information and then calls GETOVER.  It is called
 ; by option BPS PROVIDER RESPONSE OVERRIDES
 ;
 ; This does not work for eligibility but we don't do them in the background 
 ;   right now.
 ;
 N BPSRXIEN,BPSRXNM,BPSRXFL,BPSRFL,BPSORESP,BPSTYPE,BPSRXARR,BPSRARR,DIC,Y,DIR
 ;
 ; Check if test mode is on
 I '$$CHECK() Q
 ;
 ; Prompt for the Prescription
 S BPSRXIEN=$$PROMPTRX^BPSUTIL1 Q:BPSRXIEN<1
 D RXAPI^BPSUTIL1(BPSRXIEN,".01;22","BPSRXARR","IE")
 S BPSRXNM=$G(BPSRXARR(52,BPSRXIEN,.01,"E"))
 ;
 ; Prompt for Fill/Refill
 S DIR(0)="S^0:"_$G(BPSRXARR(52,BPSRXIEN,22,"E"))
 F BPSRFL=1:1 D RXSUBF^BPSUTIL1(BPSRXIEN,52,52.1,BPSRFL,.01,"BPSRARR","E") Q:$G(BPSRARR(52.1,BPSRFL,.01,"E"))=""  D
 . S DIR(0)=DIR(0)_";"_BPSRFL_":"_BPSRARR(52.1,BPSRFL,.01,"E")
 S DIR("A")="Select fill/refill for prescription "_BPSRXNM,DIR("B")=0
 D ^DIR
 I Y'=+Y Q
 S BPSRXFL=Y
 ;
 ; Prompt for BPSTYPE
 S DIR(0)="S^R:Reversal;RS:Resubmit with Reversal;S:Submit"
 S DIR("A")="Enter BPSTYPE of transaction",DIR("B")="SUBMIT"
 D ^DIR
 I ",R,RS,S,"'[","_Y_"," Q
 S BPSTYPE=Y
 ;
 ; Set up parameters
 S BPSORESP=""
 I BPSTYPE="RS" S BPSTYPE="S",BPSORESP="E PAYABLE"
 ;
 ; Call GETOVER
 D GETOVER(BPSRXIEN,BPSRXFL,BPSORESP,"",BPSTYPE)
 Q
 ;
CHECK() ;
 ; Check if Test Mode is ON in the BPS Setup table
 ; Also called by BPSNCPDP and BPSEMCPS
 ;
 ;IA#4440
 Q $S($$PROD^XUPROD:0,1:$P($G(^BPS(9002313.99,1,0)),"^",3))
 ;
CREATE(BPSTRANS) ;
 ; Create the Override record
 ;
 N DIC,X,Y,BPSTIEN,DA
 S DIC=9002313.32,DIC(0)="L",X=BPSTRANS
 D ^DIC
 S BPSTIEN=+Y
 Q BPSTIEN
 ;
FILE(DIE,DA,BPSFLD,BPSDATA) ;
 ; File in the Override record
 ;
 N DR,X,Y
 S DR=BPSFLD_"///"_BPSDATA
 L +@(DIE_DA_")"):0 I $T D ^DIE L -@(DIE_DA_")") Q
 W !?5,"Another user is editing this entry."
 Q
 ;
PROMPT(DA,BPSFLD,BPSDFLT) ;
 ; Prompt for a specific field and set the data
 ;
 N DIE,DR,DTOUT,X,Y
 S DIE="^BPS(9002313.32,",DR=BPSFLD_"//"_BPSDFLT
 L +@(DIE_DA_")"):0 I $T D ^DIE L -@(DIE_DA_")") Q
 W !?5,"Another user is editing this entry."
 Q
 ;
REJECTS(BPSTIEN) ; BPS*1*22
 N DA,DIE,DR,DTOUT,X,Y
 ; Delete all entries from the reject multiple so user doesn't have to manually delete 
 ; The reject code prompt will have a default value of '07'
 K ^BPS(9002313.32,BPSTIEN,1)
 ; Prompt for Reject Code(s) and set the data 
 S DA=BPSTIEN,DIE="^BPS(9002313.32,",DR=1_"//07"
 L +@(DIE_DA_")"):0 I $T D ^DIE L -@(DIE_DA_")") Q
 W !?5,"Another user is editing this entry."
 Q 
 ;
SETDELAY(BPSTRANS) ;
 ; Input
 ;    BPSTRANS - Transaction IEN
 ; Check the Test Flag in set in BPS SETUP
 I '$$CHECK() Q 0
 N BPSDELAY,BPSTIEN,BPSTIME
 ; Check if the Transaction Number is defined in BPS RESPONSE OVERRIDES
 S BPSTIEN=$O(^BPS(9002313.32,"B",BPSTRANS,""))
 I BPSTIEN="" Q 0
 S BPSDELAY=$$GET1^DIQ(9002313.32,BPSTIEN_",",.07,"I")*60
 I BPSDELAY'>0 Q 0
 S BPSTIME=$$FMADD^XLFDT($$NOW^XLFDT,,,,BPSDELAY)
 I BPSTIME>0 D  Q BPSTIME
 . ;schedule a task to run RUNNING^BPSOSRX
 . N ZTRTN,ZTDTH,ZTIO,ZTSK
 . S ZTRTN="RUNECME^BPSTEST",ZTDESC="BPSTEST: ECME testing tool"
 . S ZTDTH=$$FMADD^XLFDT($$NOW^XLFDT,,,,BPSDELAY+10),ZTIO=""
 . D ^%ZTLOAD
 Q 0
 ;
RUNECME ;
 D RUNNING^BPSOSRX()
 Q
 ;get the reversal reject from the ^XTMP and set BPSDATA to override data
SETREJ(BPSTRANS) ;
 N BPSREJ
 S BPSREJ=$G(^XTMP("BPSTEST",BPSTRANS))
 I BPSREJ="" Q
 S BPSDATA(1,511,1)=BPSREJ
 S BPSDATA(1,510)=1
 Q
 ;enter a reversal reject
ENREVRJ(BPSTRANS) ;
 N BPRJCODE,TMSTAMP
 S BPRJCODE=$$PROMPT^BPSSCRU4("Enter a reject code for reversal")
 I $P(BPRJCODE,U)="" Q
 I $P(BPRJCODE,U)=0 Q
 N X,X1,X2
 S X1=DT,X2=2 D C^%DTC
 S ^XTMP("BPSTEST",0)=X_U_DT_U_"ECME TESTING TOOL, SEE BPSTEST ROUTINE"
 S ^XTMP("BPSTEST",BPSTRANS)=$P(BPRJCODE,U)
 Q
 ;
