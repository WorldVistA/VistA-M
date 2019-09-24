PRCABJ2 ;OIT/hrub - NIGHTLY PROCESS FOR ACCOUNTS RECEIVABLE ;31 Oct 2018 16:00:59
 ;;4.5;Accounts Receivable;**304,321,326,332,338,351**;Mar 20, 1995;Build 15
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; read of ^DGCR(399.2 allowed by DBIA 3822
 ; refactored 17 October 2018, PRCA*4.5*332
 Q
 ; Auto-audit Paper, Electronic, and Tricare bills if ready
 ; PRCA*4.5*332 - Whole subroutine re-written
ABAUDIT ;
 ; APIEN - Accounts Payable (file #430) ien (also same ien for file #399)
 N APIEN,ARBILL,C,FLAG,J,PRCA,RTYPE  ;PRCA*4.5*321, PRCA*4.5*332
 ;
 S ARBILL("newBillIEN")=$O(^PRCA(430.3,"B","NEW BILL",""))  ; New Bill IEN
 Q:ARBILL("newBillIEN")=""  ; must have the IEN for new bills
 ; Check parameters to see if audit needs to run
 S FLAG("aaMedPaper")=$$GET1^DIQ(342,"1,",7.05,"I")  ; (#7.05) AUTO-AUDIT MEDICAL PAPER BILLS [5S]
 S FLAG("aaRxPaper")=$$GET1^DIQ(342,"1,",7.06,"I")  ; (#7.06) AUTO-AUDIT RX PAPER BILLS [6S]
 S FLAG("aaMedEDI")=$$GET1^DIQ(342,"1,",7.07,"I")  ; (#7.07) AUTO-AUDIT MEDICAL EDI BILLS [7S] - PRCA*4.5*321
 S FLAG("aaRxEDI")=$$GET1^DIQ(342,"1,",7.08,"I")  ; (#7.08) AUTO-AUDIT RX EDI BILLS [8S] - PRCA*4.5*321
 S FLAG("aaTricare")=$$GET1^DIQ(342,"1,",7.09,"I") ; (#7.09) AUTO-AUDIT TRICARE BILLS [9S] - PRCA*4.5*332
 ; quit if all auto-audit parameters are 'No'
 Q:('FLAG("aaMedPaper"))&('FLAG("aaRxPaper"))&('FLAG("aaMedEDI"))&('FLAG("aaRxEDI"))&('FLAG("aaTricare"))  ; PRCA*4.5*321
 ;
 ; RTYPE - array of RATE TYPE entries that have (#.11) BILL RESULTING FROM [11P:430.6] - PRCA*4.5*332
 S C=0 F  S C=$O(^DGCR(399.3,C)) Q:'C  S J=$G(^(C,0)) S:$P(J,U,11) RTYPE(C)=J
 ; loop through new bills
 ; BILL - info for this bill
 ; PRCA - bill # and ECME info
 ; RTDGCR - used for file #399 info (except rate type)
 S APIEN="" F  S APIEN=$O(^PRCA(430,"AC",ARBILL("newBillIEN"),APIEN)) Q:'APIEN  D
 . N BILL,PRCA,RTDGCR
 . ;
 . S BILL("rtTyp")=$$GET1^DIQ(399,APIEN_",",.07,"I") ; (#.07) RATE TYPE [7P:399.3] - PRCA*4.5*326
 . Q:'BILL("rtTyp")  ; must have rate type
 . Q:'$D(RTYPE(BILL("rtTyp")))  ; no auto-audit for this RATE TYPE
 . ; BEGIN - PRCA*4.5*321
 . Q:$$GET1^DIQ(430,APIEN_",",7,"I")=""  ; quit if no (#7) PATIENT [7P:2]
 . Q:$$GET1^DIQ(430,APIEN_",",9,"I")=""  ; quit if no (#9) DEBTOR [9P:340]
 . Q:$$GET1^DIQ(430,APIEN_",",239,"I")=""  ; quit if no (#239) INSURED NAME [1F]
 . Q:$$GET1^DIQ(430,APIEN_",",243,"I")=""  ; quit if no (#243) GROUP NAME [5F]
 . Q:$$GET1^DIQ(430,APIEN_",",244,"I")=""  ; quit if no (#244) GROUP NUMBER [6F]
 . Q:$$BILLREJ^PRCAUDT(APIEN)  ; PRCA*4.5*321 - claim has reject messages, do not audit
 . ;
 . S RTDGCR("type")=$$GET1^DIQ(399,APIEN_",",.07,"E")  ; (#.07) RATE TYPE [7P:399.3] (IA 4118)
 . S RTDGCR("paper")=$$GET1^DIQ(399,APIEN_",",27,"I")  ; (#.27) BILL CHARGE TYPE [27S] (ICR 3820)
 . S BILL("audit?")=0  ; Boolean flag, need to audit bill?
 . S BILL("doneCheck?")=0  ; Boolean flag, done checking?
 . ; Get Bill number to check if it's a Pharmacy bill
 . S PRCA("bill#")=$$GET1^DIQ(430,APIEN_",",.01,"I")  ; (#.01) BILL NO. [1F]
 . S PRCA("ecme#")=$$GETECME^RCDPENR1(APIEN)  ; ECME# from the bill
 . ;
 . I PRCA("ecme#")'="" D  ; has ECME#, check pharmacy flags
 ..  I RTDGCR("paper"),'FLAG("aaRxPaper") S BILL("doneCheck?")=1 Q  ; Skip paper bill if No auto-audit
 ..  I 'RTDGCR("paper"),'FLAG("aaRxEDI")  S BILL("doneCheck?")=1 Q  ; Skip EDI bill if No auto-audit
 ..  S BILL("audit?")="1^pharmacy"  ; audit this pharmacy bill
 . ;
 . I BILL("audit?") D AUDITX^PRCAUDT(APIEN) Q  ; audit pharmacy bill, continue loop
 . Q:BILL("doneCheck?")  ; done checking, continue loop through bills
 . ;
 . I RTDGCR("type")["TRICARE" D
 ..  I FLAG("aaTricare") S BILL("audit?")="1^Tricare"  ; audit this Tricare bill
 ..  S BILL("doneCheck?")=1
 . I BILL("audit?") D AUDITX^PRCAUDT(APIEN) Q  ; audit Tricare bill, continue loop
 . Q:BILL("doneCheck?")  ;  done checking, continue loop through bills
 . D  ; medical bill, check medical flags
 ..  I RTDGCR("paper"),'FLAG("aaMedPaper") S BILL("doneCheck?")=1 Q  ; Skip paper bill if No auto-audit
 ..  I 'RTDGCR("paper"),'FLAG("aaMedEDI")  S BILL("doneCheck?")=1 Q  ; Skip EDI bill if No auto-audit
 ..  S BILL("audit?")="1^medical"  ; audit this medical bill
 . Q:BILL("doneCheck?")  ; no auto-audit for medical bill
 . ; passed medical checks call auto-audit for this Bill
 . I BILL("audit?") D AUDITX^PRCAUDT(APIEN)
 ;
 Q
 ;
