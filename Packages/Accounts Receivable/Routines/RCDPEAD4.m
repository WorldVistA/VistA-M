RCDPEAD4 ;AITC/CJE - AUTO DECREASE ;Jun 06, 2014@19:11:19
 ;;4.5;Accounts Receivable;**349**;Mar 20, 1995;Build 44
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
REJ(WHICH) ; Process zero balance denial ERA's - PRCA*4.5*326
 ; PRCA*4.5*345 - Added WHICH
 ; Input:   WHICH       - 1 - Medical Claims
 ;                      - 3 - TRICARE Claims
 ;
 N FLD,PAID,PAYID,PAYNAM,RCDATE,RCERA,RC3446,RCDAY,RCLINE,RCPARM,RCRTYPE,RCSCR ; PRCA*4.5*345
 S FLD=$S(WHICH=1:.12,1:1.1)                           ; PRCA*4.5*349 - Added line ;
 ; Get days to wait for payer rejects (rename no-pay lines field) 
 S RCDAY=$$FMADD^XLFDT(DT\1,-$$GET1^DIQ(344.61,"1,",FLD))   ; PRCA*4.5*345 - Replaced .12 w/FLD
 ;
 ; Scan AFD index for ERA received within date range
 S RCDATE=$$FMADD^XLFDT(RCDAY,-1)_".99999",PAID=0
 F  S RCDATE=$O(^RCY(344.4,"AFD",RCDATE)) Q:'RCDATE  Q:(RCDATE\1)>RCDAY  D
 . S RCERA=0
 . ; Check for payer reject ERA's
 . F  S RCERA=$O(^RCY(344.4,"AFD",RCDATE,RCERA)) Q:'RCERA  D
 . . Q:+$$GET1^DIQ(344.4,RCERA_",",.05)                 ; Ignore ERA if total paid is not zero
 . . Q:+$$GET1^DIQ(344.4,RCERA_",",.16,"I")             ; Ignore ERA if removed from worklist
 . . Q:$$GET1^DIQ(344.4,RCERA_",",.15)'="NON"           ; Ignore ERA if not payment type of NON
 . . S RCRTYPE=$$PHARM^RCDPEAP1(RCERA)
 . . Q:RCRTYPE                                          ; Quit if ERA is for Pharmacy
 . . ;
 . . S RCRTYPE=$$ISTYPE^RCDPEU1(344.4,RCERA,"T") ; PRCA*4.5*349 - TRICARE ERA?
 . . ; Quit if ERA is not for Medical and processing Medical
 . . I WHICH=1,RCRTYPE Q
 . . ; Quit if ERA is not for TRICARE and processing TRICARE
 . . I WHICH=3,'RCRTYPE ; PRCA*4.5*349 - Added line
 . . ;
 . . ; Check payer exclusion file for this ERA's payer   
 . . S PAYID=$P($G(^RCY(344.4,RCERA,0)),U,3)
 . . S PAYNAM=$P($G(^RCY(344.4,RCERA,0)),U,6)
 . . I PAYID'="",PAYNAM'="" D
 . . . S RCPARM=$O(^RCY(344.6,"CPID",PAYNAM,PAYID,""))
 . . . S:RCPARM'="" RC3446=$G(^RCY(344.6,RCPARM,0))
 . . ;
 . . ; Ignore ERA if EXCLUDE MED CLAIMS POSTING  (#.06) or EXCLUDE MED CLAIMS DECREASE (#.07) fields set to 'yes'
 . . ; PRCA*4.5*345 - Added ,WHICH=1
 . . I $G(RC3446)'="",WHICH=1 Q:$P(RC3446,U,6)=1  Q:$P(RC3446,U,7)=1
 . . ;
 . . ; Ignore ERA if auto-post blocked
 . . Q:$$GET1^DIQ(344.4,RCERA_",",.19,"I")
 . . ;
 . . ; Build Scratchpad (if needed) and Verify Lines
 . . K ^TMP($J,"RCDPEWLA")
 . . S RCSCR=$$SCRPAD^RCDPEWLZ(RCERA)
 . . I 'RCSCR Q
 . . ; Ignore ERA if it has PLBs
 . . I $D(^TMP($J,"RCDPEWLA","ERA LEVEL ADJUSTMENT EXISTS")) Q
 . . ;
 . . ; Build index to scratchpad for this ERA
 . . N RCARRAY
 . . D BUILD^RCDPEAP(RCERA,.RCARRAY)
 . . ; Search lines
 . . S RCLINE=0
 . . F  S RCLINE=$O(RCARRAY(RCLINE)) Q:'RCLINE  D
 . . . ; Ignore claim line if already auto decreased
 . . . Q:$P($G(^RCY(344.4,RCERA,1,RCLINE,5)),U,3)
 . . . ; Process line
 . . . D EN4^RCDPEAD(RCDATE,RCERA,.RCARRAY,PAID,RCLINE,WHICH)       ; PRCA*4.5*345 - Added WHICH
 Q
