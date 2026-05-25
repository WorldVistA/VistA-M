RCDPEAD5 ;TAS/CJE - 1ST PARTY AUTO DECREASE ; 6/27/19 2:43pm
 ;;4.5;Accounts Receivable;**450**;Mar 20, 1995;Build 15
 ;Per VA Directive 6402, this routine should not be modified.
 ;Read ^IBM(361.1) via Private IA 4051
 ;
OFFSET(IEN344) ; EP - PROCESS^RCDPRPL3 - First Party Auto Decrease for manually posted claims.
 N FDA,IEN01,J,RCDATE,RCTYPE,STAT,TYPES
 I '$$GET1^DIQ(342,"1,",.17,"I") Q  ; Auto-Decrease of manually posted payments is switched off
 D TYPES(.TYPES) ; Event types to process
 S RCTYPE=$$GET1^DIQ(344,IEN344_",",.04,"E")
 I RCTYPE="" Q
 I '$D(TYPES(RCTYPE)) Q  ; Only specified event types are eligible for processing
 S RCDATE=$$GET1^DIQ(344,IEN344_",",.2,"E")
 I RCDATE'="" Q  ; Receipt processed for autodecrease previously
 ;
 ; Status of 1st Party Claim can be OPEN,ACTIVE
 F J=16,42 S STAT(J)=""
 ;
 ; Iterate through the claims on the receipt and check for associated first party co-pays
 S IEN01=0
 F  S IEN01=$O(^RCY(344,IEN344,1,IEN01)) Q:'IEN01  D  ;
 . N CLAIM,RCBILL,RCPAID,RCTYP3,REC
 . S REC=$G(^RCY(344,IEN344,1,IEN01,0))
 . S CLAIM=$P(REC,"^",3)
 . I $P(CLAIM,";",2)'="PRCA(430," Q  ; Not a pointer to an AR
 . I '$D(^DGCR(399,+CLAIM,0)) Q  ; Not a 3rd party claim
 . S RCBILL=+CLAIM
 . S RCTYP3=$$TYP^IBRFN(RCBILL) ; Get type of bill and only match with same type. DBIA 2031 covers call to TYP^IBRFN 
 . ; Do not auto decrease if claim is referred to General Council
 . Q:$P($G(^PRCA(430,RCBILL,6)),U,4)]""
 . ; Get copay details
 . K ^TMP("IBRBF",$J)
 . D RELBILL^IBRFN(RCBILL) ; Integration agreement DBIA3124
 . ; Quit if no related 1st Party claim
 . I '$O(^TMP("IBRBF",$J,RCBILL,0)) Q
 . S RCPAID=$$GET1^DIQ(344.01,IEN01_","_IEN344_",",.04,"I")
 . D EN2(RCBILL,RCTYP3,IEN01_","_IEN344_",",RCPAID)
 . ;
 . K ^TMP("IBRBF",$J)
 ;
 ; Mark this receipt as processsed for 1st party auto decrease
 K FDA
 S FDA(344,IEN344_",",.2)=$$NOW^XLFDT()
 D FILE^DIE("","FDA")
 ;
 Q
EN2(RCBILL,RCTYP3,IENS344,RCPAID) ; Check one third party claim from the receipt for copay offsets
 ; Inputs : RCBILL - Internal entry number of 3rd party bill in files 399 and 430
 ;          RCTYP3 - Type of claim for RCBILL to match vs copay
 ;          IENS344 - Internal entry numbers for subfile 344.01 in format nnn,nnnnnnn,
 ;          RCPAID - Amount paid on the 3rd party claim on this receipt transaction
 ;                   and therefore avaialble for offset of copays.
 ;
 N DFN,IBDUZ,IBNOS,IBSEQNO,QUIT,RCBAL3RD,RCGROUP,RCLST,RCSUB,RCTYPE,STATUS
 S QUIT=0
 S RCSUB=0
 S RCBAL3RD=RCPAID
 F  S RCSUB=$O(^TMP("IBRBF",$J,RCBILL,RCSUB)) Q:'RCSUB  D  Q:QUIT  ;
 . S RCTYPE=$$GET1^DIQ(350,RCSUB_",",.03,"E") ; Access to file 350 covered by DBIA4541
 . S RCGROUP=$$GET1^DIQ(350,RCSUB_",",".03:.11","I") ; Billing group 4=OPT COPAY, 5=RX COPAY
 . I RCTYPE=""!(RCGROUP="") Q
 . I $$TYPE^RCDPEAD3(RCGROUP,RCTYPE,RCTYP3) D  ;
 . . S RCLST(RCBILL,RCSUB)=""
 . . ; If charge is on hold then release it.
 . . S STATUS=$$GET1^DIQ(350,RCSUB_",",.05,"I") ; DBIA4541
 . . I STATUS=8 D  ; Charge is in on-hold, can it be released?
 . . . I $$PREPAY^RCDPEAD3(RCSUB)=1 D QUEUE(RCSUB,RCBILL,IENS344) Q  ; Open prepay, queue the charge to check later
 . . . S IBNOS=RCSUB,IBSEQNO=1,IBDUZ=.5
 . . . S DFN=$$GET1^DIQ(350,RCSUB_",",.02,"I") ; DBIA4541
 . . . D ^IBR ; Call to ^IBR allowed by DBIA7007
 . . ;
 . . S STATUS=$$GET1^DIQ(350,RCSUB_",",.05,"I") ; DBIA4541. Check status again, after release from hold.
 . . I STATUS'=3 Q  ; Status should be billed if charge was released.
 . . ;
 . . S QUIT=$$PROCESS^RCDPEAD3(RCSUB,RCBILL,RCPAID,.RCBAL3RD) ; Process this charge for attempted auto-decrease
 Q
 ;
TYPES(RETURN) ; Create array of specific AR EVENT TYPES that we included
 S RETURN("CASH PAYMENT")=""
 S RETURN("CHAMPVA")=""
 S RETURN("CHECK/MO PAYMENT")=""
 S RETURN("CREDIT CARD PAYMENT")=""
 S RETURN("EDI LOCKBOX")=""
 S RETURN("LOCKBOX")=""
 S RETURN("OGC-CHK")=""
 S RETURN("OGC-EFT")=""
 S RETURN("REGIONAL COUNSEL PAYMENT")=""
 S RETURN("TDA PAYMENT")=""
 Q
 ;
QUEUE(IEN350,IEN399,IENS344) ; Place the charge in a queue from processing at a later date
 ; Input: IEN350 - Internal entry number of charge from IB ACTION file #350
 ;        IEN399 - Internal entry number of third party bill from file 399 or 430
 ;        IENS344 - Internal entry numbers of subfile 344.01 in format nnn,nnnnnnn,
 ; Output: New entry in file #344.74
 ;
 N FDA,IENS
 S IENS="+1,"
 S FDA(344.74,IENS,.01)=IEN350
 S FDA(344.74,IENS,.02)=IEN399
 S FDA(344.74,IENS,.03)=$$NOW^XLFDT()
 S FDA(344.74,IENS,.05)=IENS344
 D UPDATE^DIE("","FDA")
 Q
