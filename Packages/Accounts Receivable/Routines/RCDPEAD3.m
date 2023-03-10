RCDPEAD3 ;ALB/PJH - AUTO DECREASE ; 6/27/19 2:43pm
 ;;4.5;Accounts Receivable;**345,349**;Mar 20, 1995;Build 44
 ;Per VA Directive 6402, this routine should not be modified.
 ;Read ^IBM(361.1) via Private IA 4051
 ;
EN(RCDAY) ; EP - EN^RCDPEM. Auto Decrease - applies to auto-posted claims only
 ;
 ; INPUT  RCDAY - Day to search for auto-posted but not decreased lines
 ; OUTPUT - Auto-decreases claims
 ;
 N IEN350,IENS41,J,RC6AM,RCARRAY,RCBAL3RD,RCBILL,RCDAYS,RCERA,RCLINE,RCPAID,RCQIEN,RCRTYPE,RCSECS,STAT,STATUS,X
 ; Nightly process does not pass RCDAY. Default: Run for most recent business day minus RCDAYS delay
 S RCDAYS=+$$GET1^DIQ(342,"1,",.15,"E")
 I $G(RCDAY)="" D  ;
 . S RCSECS=$P($H,",",2)
 . S RC6AM=21600
 . S RCDAY=$$FMADD^XLFDT(DT,$S(RCSECS<RC6AM:-1-RCDAYS,1:-RCDAYS))
 ;
 ; Status of 1st Party Claim can be OPEN,ACTIVE
 F J=16,42 S STAT(J)=""
 ;
 ; Scan "F" index of ERA file for ERA entries with AUTOPOST DATE field 344.41 #9 matching RCDAY
 S RCERA=0
 F  S RCERA=$O(^RCY(344.4,"F",RCDAY,RCERA)) Q:'RCERA  D
 . ; Build index to scratchpad for this ERA
 . K RCARRAY
 . D BUILD^RCDPEAP(RCERA,.RCARRAY)
 . ;
 . ; Scan ERA DETAIL entries in #344.41 for auto-posted medical claims
 . S RCLINE=0
 . F  S RCLINE=$O(^RCY(344.4,"F",RCDAY,RCERA,RCLINE)) Q:'RCLINE  D
 . . ; Process line
 . . I $$GET1^DIQ(344.41,RCLINE_","_RCERA_",",10.01,"I") Q  ; PRCA*4.5*349 - Already processed before
 . . D EN2(RCERA,.RCARRAY,RCLINE)
 . . D FLAG(RCERA,RCLINE) ; PRCA*4.5*349 - Flag line as having been processed
 ;
 ; Scan entries in RCDPE FIRST PARTY CHARGE QUEUE that could not be decreased due to existence of a pre-pay
 S RCQIEN=0
 F  S RCQIEN=$O(^RCY(344.74,RCQIEN)) Q:'RCQIEN  D  ;
 . S IEN350=$$GET1^DIQ(344.74,RCQIEN_",",.01,"I")
 . S RCBILL=$$GET1^DIQ(344.74,RCQIEN_",",.02,"I")
 . S IENS41=$$GET1^DIQ(344.74,RCQIEN_",",.04,"E")
 . S (RCPAID,RCBAL3RD)=+$$GET1^DIQ(344.41,IENS41,.03)
 . ; Access to file 350 DBIA4541.
 . S STATUS=$$GET1^DIQ(350,IEN350_",",.05,"I")
 . I STATUS'=8 D DEL74(RCQIEN) ; If charge is not on hold remove from queue, but continue with checks.
 . I STATUS'=3,STATUS'=8 Q  ; Charge not on hold or billed so quit
 . ;
 . ; On hold charge with no pre-pay. Release from hold.
 . I STATUS=8 D  ;
 . . I $$PREPAY(IEN350)=1 Q  ; Still has open pre-pay so quit
 . . S IBNOS=IEN350,IBSEQNO=1,IBDUZ=.5
 . . S DFN=$$GET1^DIQ(350,IEN350_",",.02,"I") ; DBIA4541
 . . D ^IBR ; Call to ^IBR allowed by DBIA7007
 . . D DEL74(RCQIEN) ; Charge released from hold, remove from queue.
 . ;
 . S STATUS=$$GET1^DIQ(350,IEN350_",",.05,"I")
 . I STATUS'=3 Q
 . ;
 . S X=$$PROCESS(IEN350,RCBILL,RCPAID,.RCBAL3RD) ; Process this charge for attempted auto-decrease
 ; 
 Q
 ;
EN2(RCERA,RCARRAY,RCLINE) ; Auto-decrease selected lines
 ; Input:   RCERA       - ERA number
 ;          RCARRAY     - Array of ERA Scratchpad lines
 ;          RCLINE      - ERA line sequence
 ;
 ; Get claim number RCBILL for the ERA line using EOB #361.1 pointer
 N AMT,COMMENT,COPAY,DEBT,DFN,EOBIEN,FDA,IBNOS,IBSEQNO,IBDUZ,PRCADB,PRCATY,QUIT
 N RCBAL,RCBILL,RCCLAIM,RCCOPAY,RCGROUP,RCLST,RCSTATUS,RCSUB,RCTRANDA,RCTYP3,RCTYPE,STATUS
 ;
 ; Get amount paid on the line
 S IENS41=RCLINE_","_RCERA_","
 S (RCPAID,RCBAL3RD)=+$$GET1^DIQ(344.41,IENS41,.03)
 ;
 ; Quit if this is a no-payment line
 I RCPAID=0 Q
 ;
 ; Get pointer to EOB file #361.1 from ERA DETAIL
 S EOBIEN=$P($G(^RCY(344.4,RCERA,1,RCLINE,0)),U,2),RCBILL=0
 ;
 ; Get ^DGCR(399 pointer (DINUM for #430 file)
 S:EOBIEN RCBILL=$P($G(^IBM(361.1,EOBIEN,0)),U) Q:'RCBILL
 S RCTYP3=$$TYP^IBRFN(RCBILL) ; Get type of bill and only match with same type. DBIA 2031 covers call to TYP^IBRFN 
 ;
 ; If claim has been split/edit and claim changed in APAR do not auto decrease - BOOKMARK - VERIFY WITH EPAY TEAM
 Q:$$SPLIT^RCDPEAD(RCERA,RCLINE,RCBILL,.RCARRAY)
 ;
 ; Do not auto decrease if claim is referred to General Council
 Q:$P($G(^PRCA(430,RCBILL,6)),U,4)]""
 ;
 ; Get copay details
 K ^TMP("IBRBF",$J)
 D RELBILL^IBRFN(RCBILL) ; Integration agreement DBIA3124
 ; Quit if no related 1st Party claim
 I '$O(^TMP("IBRBF",$J,RCBILL,0)) Q
 ; Get COPAY amount and COPAY claim IEN for #430
 ;
 S QUIT=0
 S RCSUB=0
 F  S RCSUB=$O(^TMP("IBRBF",$J,RCBILL,RCSUB)) Q:'RCSUB  D  Q:QUIT  ;
 . S RCTYPE=$$GET1^DIQ(350,RCSUB_",",.03,"I") ; Access to file 350 covered by DBIA4541
 . S RCGROUP=$$GET1^DIQ(350,RCSUB_",",".03:.11","I") ; Billing group 4=OPT COPAY, 5=RX COPAY
 . I RCTYPE=""!(RCGROUP="") Q
 . I $D(^RC(342,1,14,"ACE",1,RCTYPE)) D  ; Action type is flagged for auto-decrease
 . . I RCTYP3="O",RCGROUP'=4 Q  ; Only match O/P claim with O/P charge
 . . I RCTYP3="PH",RCGROUP'=5 Q  ; Only match RX claim with RX charge
 . . S RCLST(RCBILL,RCSUB)=""
 . . ; If charge is on hold then release it.
 . . S STATUS=$$GET1^DIQ(350,RCSUB_",",.05,"I") ; DBIA4541
 . . I STATUS=8 D  ; Charge is in on-hold, can it be released?
 . . . I $$PREPAY(RCSUB)=1 D QUEUE(RCSUB,RCBILL,IENS41) Q  ; Open prepay, queue the charge to check later
 . . . S IBNOS=RCSUB,IBSEQNO=1,IBDUZ=.5
 . . . S DFN=$$GET1^DIQ(350,RCSUB_",",.02,"I") ; DBIA4541
 . . . D ^IBR ; Call to ^IBR allowed by DBIA7007
 . . ;
 . . S STATUS=$$GET1^DIQ(350,RCSUB_",",.05,"I") ; DBIA4541. Check status again, after release from hold.
 . . I STATUS'=3 Q  ; Status should be billed if charge was released.
 . . ;
 . . S QUIT=$$PROCESS(RCSUB,RCBILL,RCPAID,.RCBAL3RD) ; Process this charge for attempted auto-decrease
 ;
 K ^TMP("IBRBF",$J)
 Q
 ;
PROCESS(IEN350,RCBILL,RCPAID,RCBAL3RD) ; Process this charge for attempted auto-decrease
 ; Inputs: IEN350 - Internal entry number for charge in file #350
 ;         RCBILL - Internal entry number for third party bill from file #399
 ;         RCPAID - Amount paid on ERA line for this third party bill
 ;         RCBAL3RD - Remaining balance on third party bill not yet used for auto-decrease of a copay
 ; Returns: 1 - quit loop after processing this record
 ;          0 - don't quit
 ;
 ; Get copay claim (external format)
 S RETURN=0
 S RCCLAIM=$$GET1^DIQ(350,IEN350_",",.11) ; DBIA4541
 I RCCLAIM="" Q 0
 S RCCOPAY=$O(^PRCA(430,"B",RCCLAIM,""))
 I 'RCCOPAY Q 0
 S STATUS=$P($G(^PRCA(430,RCCOPAY,0)),"^",8)
 ; Check 1st Party claim status vs list allowed for auto-decrease
 I '$D(STAT(STATUS)) Q 0
 ;
 ; Get copay balance remaining
 S COPAY=+$$GET1^DIQ(430,RCCOPAY_",",11)
 ; Quit if copay balance is zero
 I COPAY=0 Q 0
 ; PRCA*4.5*349 - Only process auto-decrease if copay balance = (charge - (previous auto-decreases))
 I +COPAY'=($$GET1^DIQ(350,IEN350_",",.07)-$$DECAMT(RCCOPAY)) Q 0 ; DBIA4541
 ;
 ; Get 1st party balance
 S DEBT=$$GET1^DIQ(430,RCCOPAY_",",9,"I")
 I 'DEBT Q 0
 S PRCADB=$$GET1^DIQ(340,DEBT_",",.01,"I")
 S PRCATY="ALL"
 D COMP^PRCAAPR
 S RCBAL=+$G(^TMP("PRCAAPR",$J,"C"))
 K ^TMP("PRCAAPR",$J)
 ; Determine decrease amount
 S AMT=$$AMT(RCBAL,RCBAL3RD,COPAY)
 ; Ignore zero amounts
 Q:AMT'>0 0
 ; Decrease adjustment comment
 D COMM1(.COMMENT,IEN350,RCBILL,AMT,RCPAID)
 ; Apply DECREASE ADJUSTMENT for COPAY
 S RCTRANDA=$$INCDEC^RCBEUTR1(RCCOPAY,-AMT,.COMMENT,"","",0) Q:'RCTRANDA 0
 ; File third party bill on decrease adjustment transaction
 K FDA
 S FDA(433,RCTRANDA_",",94)=RCBILL
 S FDA(433,RCTRANDA_",",42)=.5 ; Make sure PROCESSED BY is postmaster
 D FILE^DIE("","FDA")
 ; Add a comment transaction to first party bill also.
 S RCTRANDA=$$TRAN1(IEN350,RCBILL,RCCOPAY,AMT,RCPAID)
 S RCTRANDA=$$TRAN3(IEN350,RCBILL,RCCOPAY,AMT,COPAY) ; Add third party bill comment Transaction
 S RCBAL3RD=RCBAL3RD-AMT ; Take amount off the 3rd party payment and use for subsequent decrease.
 I RCBAL3RD=0!(RCBAL3RD<0) S RETURN=1
 Q RETURN
 ;
AMT(RCBAL,RCPAID,RCOPAY) ; Calculate Decrease Amount
 ; 
 ; INPUT
 ;    RCBAL - 1st Party Balance
 ;    RCPAID - Amount Paid on 3rd Party claim
 ;    RCOPAY - Copay amount
 ; OUTPUT
 ;    Amount to decrease
 ;
 ; Existing credit balance on 1st party account
 I RCBAL<0!(RCBAL=0) Q 0 ; Adjustment would leave the account in credit so don't do anything
 I RCBAL<COPAY Q $S(RCPAID<RCBAL:RCPAID,1:RCBAL)
 ; Existing debit balance on 1st party account
 Q $S(RCPAID<RCOPAY:RCPAID,1:RCOPAY)
 ;
SHOWTYP() ; EP - Display list of IB ACTION TYPE enabled for 1st party auto-decrease
 ; Input - None
 ; Output - To screen
 N COUNT,FLAG,IEN2,TYPE,X
 S COUNT=0
 S FLAG=$$GET1^DIQ(342,"1,",.14,"I")
 I FLAG D  ; Only show enabled types if auto-decrease is on
 . S IEN2=0
 . F  S IEN2=$O(^RC(342,1,14,IEN2)) Q:'IEN2  D  ;
 . . S FLAG=$$GET1^DIQ(342.014,IEN2_",1,",.02,"I")
 . . I FLAG D  ;
 . . . I COUNT=0 W !!,"Charge types enabled for 1st party auto-decrease:"
 . . . W !,"   "_$$GET1^DIQ(342.014,IEN2_",1,",.01,"E")
 . . . S COUNT=COUNT+1
 W !
 Q
 ;
TRAN1(IEN350,IEN399,IEN430,AMT,RCPAID) ; File auto-decrease comment on first party AR
 ; Input:  IEN350 - Internal entry number to IB Action (File #350)
 ;         IEN399 - Internal entry number to Third Party Bill (Files #399 and #430)
 ;         IEN430 - Internal entry number of First Party Bill (File #430)
 ;         AMT    - Amount of auto-decease
 ;         RCPAID - Amount paid on third party bill
 ;
 N BILL3,BILL430,COMMENT,FDA,IENS,RCDOS
 S RCDOS=$$DOS(IEN350)
 S BILL3=$$GET1^DIQ(399,IEN399_",",.01,"E")
 S BILL430=$$GET1^DIQ(430,IEN399_",",.01,"E")
 ;
 S RCTRANDA=$$ADD433^RCBEUTRA(IEN430,45) I 'RCTRANDA Q 0
 ;
 S FDA(433,RCTRANDA_",",4)=2
 S FDA(433,RCTRANDA_",",5.02)=BILL3_" PD $"_$FN(AMT,"",2)_" DOS:"_RCDOS
 S FDA(433,RCTRANDA_",",11)=DT
 S FDA(433,RCTRANDA_",",15)=0
 S FDA(433,RCTRANDA_",",42)=.5
 D FILE^DIE("","FDA")
 ;
 S COMMENT(1)="THIRD PARTY PAYMENT RECIEVED ON BILL NUMBER "_BILL430_" = $"_$FN(RCPAID,"",2)
 S COMMENT(2)="DOS:"_RCDOS_"   "_$$RXMT(IEN350)
 S COMMENT(3)="$"_$FN(AMT,"",2)_" AUTO-DECREASE APPLIED FOR CLAIMS MATCHING"
 S COMMENT(4)=$$GET1^DIQ(200,".5,",.01,"E")
 D WP^DIE(433,RCTRANDA_",",41,"","COMMENT")
 L -^PRCA(433,RCTRANDA)
 Q RCTRANDA
 Q
 ;
TRAN3(IEN350,IEN399,IEN430,AMT,COPAY) ; File auto-decrease comment on third party AR
 ; Input:  IEN350 - Internal entry number to IB Action (File #350)
 ;         IEN399 - Internal entry number to Third Party Bill (Files #399 and #430)
 ;         IEN430 - Internal entry number of First Party Bill (File #430)
 ;         AMT    - Amount of auto-decease
 ;         COPAY  - Copay amount being decreased
 ;
 N BILL1,COMMENT,FDA,IENS,RCDOS
 S RCDOS=$$DOS(IEN350)
 S BILL1=$$GET1^DIQ(430,IEN430_",",.01,"E")
 ;
 S RCTRANDA=$$ADD433^RCBEUTRA(IEN399,45) I 'RCTRANDA Q 0
 ;
 S FDA(433,RCTRANDA_",",4)=2
 S FDA(433,RCTRANDA_",",5.02)=BILL1_" offset $"_$FN(AMT,"",2)
 S FDA(433,RCTRANDA_",",11)=DT
 S FDA(433,RCTRANDA_",",15)=0
 S FDA(433,RCTRANDA_",",42)=.5
 D FILE^DIE("","FDA")
 ;
 S COMMENT(1)="FIRST PARTY BILL # "_BILL1_" AUTO-DECREASED $"_$FN(AMT,"",2)_" FOR CLAIMS MATCHING"
 S COMMENT(2)="DOS:"_RCDOS
 S COMMENT(3)=$$GET1^DIQ(200,".5,",.01,"E")
 D WP^DIE(433,RCTRANDA_",",41,"","COMMENT")
 L -^PRCA(433,RCTRANDA)
 Q RCTRANDA
 ;
COMM1(COMMENT,IEN350,IEN399,AMT,RCPAID) ; Build comment text for first party bill
 ; Input:  IEN350 - Internal entry number to IB Action (File #350)
 ;         IEN399 - Internal entry number to Third Party Bill (Files #399 and #430)
 ;         AMT    - Amount of auto-decease
 ;         RCPAID - Amount paid on third party bill
 ; Output: COMMENT - Array passed by reference
 N BILL3
 S BILL3=$$GET1^DIQ(430,IEN399_",",.01,"E")
 S COMMENT(1)="THIRD PARTY PAYMENT RECIEVED ON BILL NUMBER "_BILL3_" = $"_$FN(RCPAID,"",2)
 S COMMENT(2)="DOS: "_$$DOS(IEN350)_"   "_$$RXMT(IEN350)
 S COMMENT(3)="$"_$FN(AMT,"",2)_" AUTO-DECREASE APPLIED FOR CLAIMS MATCHING"
 S COMMENT(4)=$$GET1^DIQ(200,".5,",.01,"E")
 Q
 ;
DOS(IEN350) ; Get Date of Service for charge
 ; Input: IEN350 - Intenal entry number of IB Action (file #350)
 ;
 N FIELD,FILE,FROM,IEN,RETURN
 S RETURN=""
 S FROM=$$GET1^DIQ(350,IEN350_",",.04,"I") ; DBIA4541
 S FILE=$P(FROM,":",1),IEN=+$P(FROM,":",2)
 ; Use issue date for prescription or date for o/p encounter
 S FIELD=$S(FILE=52:1,FILE=409.68:.01,1:"")
 I FIELD="" S FILE=350,FIELD=.17,IEN=IEN350 ; If not Rx or o/p use Event date from charge file
 S RETURN=$$GET1^DIQ(FILE,IEN_",",FIELD,"I")
 I RETURN'="" S RETURN=$$FMTE^XLFDT(RETURN,"2D")
 Q RETURN
 ;
RXMT(IEN350) ; Return Rx # or "MT" for transaction comment line
 ; Input: IEN350 - Internal entry number of IB Action (file #350)
 ;
 N FROM,RETURN
 S RETURN="MT"
 S FROM=$$GET1^DIQ(350,IEN350_",",.04,"I") ; DBIA4541
 S FILE=$P(FROM,":",1),IEN=+$P(FROM,":",2)
 I FILE=52 S RETURN="RX#: "_$$GET1^DIQ(FILE,IEN_",",.01,"E") ; RX #
 Q RETURN
 ;
PREPAY(IEN350) ; Check for open pre-pay
 ; Input: IEN350 - Internal entry number of charge from IB ACTION file #350
 ; Returns: 1 - Patient has an open pre-payment
 ;          0 - No open pre-payment
 ;         -1 - Error
 N PIEN,RCDATA7,RCDEBTDA,RCPREDA,RCVPP,RETURN
 S RETURN=0
 S PIEN=$$GET1^DIQ(350,IEN350_",",.02,"I")
 I 'PIEN Q -1
 S RCVPP=PIEN_";DPT(" ; Variable pointer to debtor file 340
 S RCDEBTDA=$O(^RCD(340,"B",RCVPP,0))
 I 'RCDEBTDA Q -1
 ;
 S RCPREDA=0
 F  S RCPREDA=$O(^PRCA(430,"AS",RCDEBTDA,42,RCPREDA)) Q:'RCPREDA!(RETURN'=0)  D
 . ;
 . I $$GET1^DIQ(430,RCPREDA_",",2,"I")'=26 Q    ; Not a prepayment
 . I $$GET1^DIQ(430,RCPREDA_",",8,"E")'="OPEN" Q  ; If CURRENT STATUS not "OPEN" skip
 . I '$$GET1^DIQ(430,RCPREDA_",",71,"I") Q  ;  No balance on prepayment so skip.
 . ;
 . S RETURN=1
 ;
 Q RETURN
 ;
QUEUE(IEN350,IEN399,IENS41) ; Place the charge in a queue from processing at a later date
 ; Input: IEN350 - Internal entry number of charge from IB ACTION file #350
 ;        IEN399 - Internal entry number of third party bill from file 399 or 430
 ;        IENS41 - Internal entry numbers of subfile 344.41 in format nnn,nnnnnnn,
 ; Output: New entry in file #344.74
 ;
 N FDA,IENS
 S IENS="+1,"
 S FDA(344.74,IENS,.01)=IEN350
 S FDA(344.74,IENS,.02)=IEN399
 S FDA(344.74,IENS,.03)=$$NOW^XLFDT()
 S FDA(344.74,IENS,.04)=IENS41
 D UPDATE^DIE("","FDA")
 Q
DEL74(IEN74) ; Delete FIRST PARTY CHARGE QUEUE entry
 ; Input: IEN74 - Internal entry number of file 344.74
 ; Output: None
 N FDA
 S FDA(344.74,IEN74_",",.01)="@"
 D FILE^DIE("","FDA")
 Q
 ;
 ; Subroutine added for PRCA*4.5*349
DECAMT(IEN430) ; Return amount that bill has been previously auto-decreased.
 ; Input: IEN430 - Internal Entry number of file #430
 ; Returns: Total amount of previous auto-decreases
 N RETURN,TRANDA,TYPE
 S RETURN=0
 S TRANDA=""
 F  S TRANDA=$O(^PRCA(433,"C",IEN430,TRANDA)) Q:'TRANDA  D  ;
 . I $$GET1^DIQ(433,TRANDA_",",12,"E")'="DECREASE ADJUSTMENT" Q
 . I $$GET1^DIQ(433,TRANDA_",",42,"E")'="POSTMASTER" Q
 . S RETURN=RETURN+$$GET1^DIQ(433,TRANDA_",",15,"E") ; Add auto-decrease amount to total
 Q RETURN
 ;
 ; PRCA*4.5*349 - Subroutine added
FLAG(RCERA,RCLINE) ; Flag ERA detail line as having been checked or processed for 1st party auto-decrease
 ; Input: RCERA  - Internal entry number of file 344.4
 ;        RCLINE - Internal entry number of subfile 344.41
 N FDA
 S FDA(344.41,RCLINE_","_RCERA_",",10.01)=1
 D FILE^DIE("","FDA")
 Q
