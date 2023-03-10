RCP367 ;AITC/DOM - Patch PRCA*4.5*367 Post Installation Processing ;20 Feb 2020 14:00:00
 ;;4.5;Accounts Receivable;**367**;Feb 20, 2020;Build 11
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
POST ;
 D BMES^XPDUTL("PRCA*4.5*367 post-installation Started "_$$HTE^XLFDT($H))
 D RECPTYPE
 D CKOLDEFT
 D BMES^XPDUTL("PRCA*4.5*367 post-installation finished "_$$HTE^XLFDT($H))
 Q
 ;
RECPTYPE ; Add new receipt type
 N ERROR,RCFDA,RCJ
 I '$D(^RC(341.1,"B","CHAMPVA")) D  ; Check if already added
 . D BMES^XPDUTL("Adding new entry to AR Event Type file.")
 . S RCFDA(341.1,"+1,",.01)="CHAMPVA"
 . S RCFDA(341.1,"+1,",.02)=17
 . S RCFDA(341.1,"+1,",.06)=1
 . D UPDATE^DIE(,"RCFDA")
 ;
 ; Check integrity of the 341.1 file.
 S ERROR=0
 D VERIFY^PRCABJ
 I ERROR D  ;
 .  D BMES^XPDUTL("**Error in AR EVENT TYPE file**")
 .  S RCJ=""
 .  F  S RCJ=$O(ERROR(RCJ)) Q:'RCJ  D  ;
 . . D BMES^XPDUTL(ERROR(RCJ))
 I 'ERROR D  ;
 . D BMES^XPDUTL("AR EVENT TYPE file verified.")
 Q
 ;
CKOLDEFT ; Check for EFTs that are 7 years or older and are matched to
 ; a paper check.  These EDTs result in an erroneous Old EFT warning
 ; message when working ERAs in the EDI Lockbox Worklist.  If any
 ; EFTs are found that are 7 years or older and are matched to a 
 ; paper check, the first three found are displayed to the IRM who is
 ; then instructed to send an email message to VHAePaymentsTesting@domain.ext mail group
 ; listing the EFT numbers found so testers can verify that these
 ; EFTs are NOT among the list of EFTs causing the need for an
 ; override.
 N CTR,DAYSLIMT,EFTDA,ENDDT,MSG,RECVDT,STARTDT,TARRAY,XX,ZZ
 D BMES^XPDUTL("Looking for old EFTs matched to a paper EOB with purged receipts.")
 S CTR=0
 S STARTDT=$$GET1^DIQ(344.61,1,.09,"I")     ; Pre-Patch EFT Cut-off Date
 S STARTDT=$$FMADD^XLFDT(STARTDT,-1,0,0)    ; Back-Up one day for $O    
 ;
 ; Stop checking if EFTs aren't at least 7 years old because the receipts are only
 ; purged for EFTs at least 7 years old (see MAN^RCDPUT)
 S ENDDT=$$FMADD^XLFDT(DT,(365*-7),0,0)
 S DAYSLIMT("M")=$$GET1^DIQ(344.61,1,.06)   ; Medical
 S DAYSLIMT("P")=$$GET1^DIQ(344.61,1,.07)   ; Pharmacy
 S DAYSLIMT("T")=$$GET1^DIQ(344.61,1,.13)   ; Tricare
 ;
 ; Get 3 examples of EFTs matched to paper checks with purged receipts
 S RECVDT=STARTDT
 F  S RECVDT=$O(^RCY(344.31,"ADR",RECVDT)) Q:'RECVDT  Q:RECVDT>ENDDT  Q:CTR>2  D
 . S EFTDA=""
 . F  S EFTDA=$O(^RCY(344.31,"ADR",RECVDT,EFTDA)) Q:'EFTDA  Q:CTR>2  D
 . . D CHKEFT(RECVDT,EFTDA,"A",.DAYSLIMT,.TARRAY,.CTR)
 ;
 I CTR=0 D  Q
 . D BMES^XPDUTL("No old EFTs matched to a paper EOB with purged receipts were found.")
 ;
 S XX=1
 S MSG(1)="The following trace numbers of old EFTs with purged receipts were found:"
 S ZZ=""
 F  D  Q:ZZ=""
 . S ZZ=$O(TARRAY(ZZ))
 . Q:ZZ=""
 . S XX=XX+1,MSG(XX)="     "_ZZ
 S XX=XX+1,MSG(XX)="Please send an outlook email to:  VHAePaymentsTesting@domain.ext"
 S XX=XX+1,MSG(XX)="Include the installation site and the Trace Numbers listed above."
 D BMES^XPDUTL(.MSG)
 Q
 ;
CHKEFT(RECVDT,EFTDA,TYPE,DAYSLIMT,TRARRY,CTR) ; Check EFT for warnings/errors
 ;Input:    RECVDT  - Current Date Received being processed
 ;          EFTDA   - IEN of EDI THIRD PARY EFT DETAIL
 ;          TYPE    - "A" (Medical, Pharmacy and Tricare)
 ;          DAYSLIMT- days an EFT can age before post prevention rules apply 
 ;          TRARRY  - Current Array of trace numbers of problem EFTs
 ;          CTR     - Current number of EFTs found
 ; Ouput:   TRARRY  - Updated Array of trace numbers of problem EFTs
 ;          CTR     - Updated number of EFTs found
 ;
 N EFTTYPE,ERAREC,TRACE
 Q:$G(^RCY(344.31,EFTDA,0))=""                      ; skip, no data
 Q:+$$GET1^DIQ(344.31,EFTDA_",",.07,"I")=0          ; skip, zero payment amt.
 ;
 ; Ignore duplicate EFTs which have been removed 
 Q:$$GET1^DIQ(344.31,EFTDA_",",.18,"I")             ;^DD(344.31,.18,0)="DATE/TIME DUPLICATE REMOVED
 S ERAREC=+$$GET1^DIQ(344.31,EFTDA_",",.1,"I")      ; Pointer to ERA record
 Q:ERAREC                                           ; Matched to an ERA
 ;
 ; Exclude EFT matched to Paper EOB if receipt is processed
 Q:'$$GET1^DIQ(344.31,EFTDA_",",.08,"I")            ; Not matched to a paper check
 Q:'$$PROC(EFTDA)                                   ; Receipt isn't purged
 S TRACE=$$GET1^DIQ(344.31,EFTDA_",",.04,"I")       ; TRACE #
 S:TRACE="" TRACE="(No trace #)"
 S CTR=CTR+1,TRARRY(TRACE)=""
 Q
 ;
PROC(EFTDA) ; Check if TR Receipt for an EFT linked to Paper EOB was purged 
 ; Input:   EFTDA - IEN for file 344.31
 ; Returns: 1 if TR receipt was purged, 0 otherwise
 N IEN344
 ;
 ; Find TR receipt and check if status is not CLOSED
 S IEN344=$O(^RCY(344,"AEFT",EFTDA,0))
 I IEN344="" Q 1                                       ; Purged Receipt
 Q 0
 ;
