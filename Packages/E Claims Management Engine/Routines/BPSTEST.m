BPSTEST ;OAK/ELZ - ECME TESTING TOOL ;11/15/07  09:55
 ;;1.0;E CLAIMS MGMT ENGINE;**6,7,8**;JUN 2004;Build 29
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;
GETOVER(BPSRXIEN,BPSFILL,BPSORESP,BPSWHERE,BPSTYPE,BPPAYSEQ) ;
 ; called by BPSNCPDP to enter overrides for a particular RX
 ; INPUT
 ;    BPSRXIEN  - Prescription Number
 ;    BPSFILL   - Fill Number
 ;    BPSORESP  - Previous response when this claim was processed
 ;    BPSWHERE  - RX Action passed into BPSNCPDP
 ;    BPSTYPE   - R (Reversal), S (Submission)
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
 ; Do not run for background jobs (CMOP (CR*) or ARES/AREV)
 I $D(ZTQUEUED)!(",ARES,AREV,CRLB,CRLR,CRLX,PC,PL,"[(","_BPSWHERE_",")) Q
 ;
 ; Create Transaction Number
 S BPSFILL="0000"_+BPSFILL
 S BPSTRANS=BPSRXIEN_"."_$E(BPSFILL,$L(BPSFILL)-3,$L(BPSFILL))_$S($G(BPPAYSEQ)>0:+BPPAYSEQ,1:1)
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
 W !,"prescription, if they exist.",!
 S DIR(0)="SA^Y:Yes;N:No"
 S DIR("A")="Do you want to enter overrides for this prescription? ",DIR("B")="YES"
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
 I BPSTYPE="S",BPSORESP="E PAYABLE"!(BPSORESP="E DUPLICATE")!(BPSORESP="E REVERSAL REJECTED")!(BPSORESP="E REVERSAL UNSTRANDED") S BPSTYPE="RS"
 ;
 ; Update with the BPSTYPE
 D FILE("^BPS(9002313.32,",BPSTIEN,.02,BPSTYPE)
 ;
 ; Message for RS
 I BPSTYPE="RS" D
 . W !!,"This submission may also have a reversal so you will be prompted for the"
 . W !,"reversal overrides."
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
 . I BPSSRESP="P"!(BPSSRESP="D") D PROMPT(BPSTIEN,.04,40)
 . I BPSSRESP="P"!(BPSSRESP="D") D PROMPT(BPSTIEN,.06,9)
 . I BPSSRESP="R" D PROMPT(BPSTIEN,1,"07")
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
 ;
 ; Check the Test Flag in set in BPS SETUP
 I '$$CHECK() Q
 ;
 ; Check if the Transaction Number is defined in BPS RESPONSE OVERRIDES
 S BPSTIEN=$O(^BPS(9002313.32,"B",BPSTRANS,""))
 I BPSTIEN="" Q
 ;
 ; If a reversal, check for specific reversal overrides and set
 I BPSTYPE="B2" D
 . S BPSRRESP=$$GET1^DIQ(9002313.32,BPSTIEN_",",.05,"I")
 . ;
 . ; If the response is Stranded, force an <UNDEF> error
 . I BPSRRESP="S" S BPSXXXX=BPSUNDEF
 . I BPSRRESP]"" S BPSDATA(1,112)=$S(BPSRRESP="D":"S",1:BPSRRESP)
 . S BPSDATA(9002313.03,9002313.03,"+1,",501)=$S(BPSRRESP="R":"R",1:"A")
 . I BPSRRESP="R" D SETREJ(BPSTRANS)
 ;
 ; If a submission, check for specific submission overrides and set
 I BPSTYPE="B1" D
 . ; Get submission response
 . S BPSSRESP=$$GET1^DIQ(9002313.32,BPSTIEN_",",.03,"I")
 . ;
 . ; If the response is Stranded, force an <UNDEF> error
 . I BPSSRESP="S" S BPSXXXX=BPSUNDEF
 . ; If it exists, file it
 . I BPSSRESP]"" D
 .. S BPSDATA(1,112)=BPSSRESP
 .. S BPSDATA(9002313.03,9002313.03,"+1,",501)=$S(BPSSRESP="R":"R",1:"A")
 .. ; If payable or duplicate, get the BPSPAID amount and file it if it
 .. ; exists.  Also delete any reject codes
 .. I BPSSRESP="P"!(BPSSRESP="D") D
 ... S BPSPAID=$$GET1^DIQ(9002313.32,BPSTIEN_",",.04,"I")
 ... I BPSPAID]"" D
 .... S BPSDATA(1,509)=$$DFF^BPSECFM(BPSPAID,8)
 .... K BPSDATA(1,510),BPSDATA(1,511)
 .. I BPSSRESP="P"!(BPSSRESP="D") D
 ... S BPSCOPAY=$$GET1^DIQ(9002313.32,BPSTIEN_",",.06,"I")
 ... I BPSCOPAY]"" D
 .... S BPSDATA(1,518)=$$DFF^BPSECFM(BPSCOPAY,8)
 .. ; If rejected, get the rejection code and file them
 .. ; Also, delete the BPSPAID amount
 .. I BPSSRESP="R" D
 ... ; Delete old rejections and BPSPAID amount
 ... K BPSDATA(1,509),BPSDATA(1,511)
 ... ; Loop through rejections and store
 ... S BPSRCNT=0
 ... S BPSRIEN=0 F  S BPSRIEN=$O(^BPS(9002313.32,BPSTIEN,1,BPSRIEN)) Q:+BPSRIEN=0  D
 .... S BPSRCODE=$P($G(^BPS(9002313.32,BPSTIEN,1,BPSRIEN,0)),"^",1)
 .... ; Increment counter and store
 .... I BPSRCODE]"" D
 ..... S BPSRCD=$$GET1^DIQ(9002313.93,BPSRCODE_",",.01,"E")
 ..... I BPSRCD]"" S BPSRCNT=BPSRCNT+1,BPSDATA(1,511,BPSRCNT)=BPSRCD
 ... ; Store total number of rejections
 ... S BPSDATA(1,510)=BPSRCNT
 Q
 ;
SELOVER ;
 ; used to create overrides for prescription that will processed in the
 ; background (CMOP, auto-reversals).  The user is prompted for the
 ; prescription and other information and then calls GETOVER.  It is called
 ; by option BPS PROVIDER RESPONSE OVERRIDES
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
