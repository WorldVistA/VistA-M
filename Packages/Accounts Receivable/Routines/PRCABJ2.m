PRCABJ2 ;ALB/SAB - NIGHTLY PROCESS FOR ACCOUNTS RECEIVABLE ;07-JUL-15
 ;;4.5;Accounts Receivable;**304,321,326**;Mar 20, 1995;Build 26
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; read of DGCR(399.2 allowed by DBIA 3822
 ;
 Q
 ; Auto-audit Paper and Electronic (EDI) bills if ready
ABAUDIT ;
 ; Local Variables
 ;    APIEN - Accounts Payable (file #430) ien
 ;
 N APIEN,BILLTYP,BILLTYPF,BILLVAL,DIE,DA,DR,DIR,DIRUT,DTOUT,DUOUT,X,Y
 N APD0,APD202,FLG1,FLG2,FLG1E,FLG2E,NBLIEN ; PRCA*4.5*321
 N PRCABLNO,PRCAECME,RATEIEN,RCPAPER,XX ; PRCA*4.5*321
 ;
 S APIEN=""
 ;
 ;Check parameters to see if it needs to run.
 S FLG1=$$GET1^DIQ(342,"1,",7.05,"I")   ; Get the value of the auto-audit medical paper bill flag
 S FLG2=$$GET1^DIQ(342,"1,",7.06,"I")   ; Get the value of the auto-audit pharmacy paper bill flag
 S FLG1E=$$GET1^DIQ(342,"1,",7.07,"I") ; Get the value of the auto-audit medical EDI bill flag - PRCA*4.5*321
 S FLG2E=$$GET1^DIQ(342,"1,",7.08,"I") ; Get the value of the auto-audit pharmacy EDI bill flag - PRCA*4.5*321
 ;
 ; Quit if all auto-audit parameters are set to 'No'
 Q:('FLG1)&('FLG2)&('FLG1E)&('FLG2E)  ; PRCA*4.5*321
 ;
 ;retrieve DB values
 S NBLIEN=$O(^PRCA(430.3,"B","NEW BILL",""))  ; New Bill Status IEN
 ;S CATIEN=$O(^PRCA(430.2,"C","RI",""))        ; Reimbursable Insurance IEN  ; removed PRCA*4.5*321
 ;S HICD=$O(^PRCA(430.6,"B","HI",""))          ; Health insurance IEN  ; removed PRCA*4.5*321
 ;S ACTIVE=$O(^PRCA(430.3,"B","ACTIVE",""))    ; New Bill Status IEN  ; removed PRCA*4.5*321
 S BILLTYP=$O(^DGCR(399.3,"B","REIMBURSABLE INS.",""))  ; Bill Type IEN
 S BILLTYPF=$O(^DGCR(399.3,"B","FEE REIMB INS","")) ; Re-Imb. Fee Bill Type IEN - PRCA*4.5*326
 ;S RCPAPER=1 ; Field 27 in ^DGCR(399 ; 0 - is electronic, 1 - FORCE LOCAL PRINT  ; removed PRCA*4.5*321
 ;
 Q:NBLIEN=""
 ;
 F  S APIEN=$O(^PRCA(430,"AC",NBLIEN,APIEN)) Q:'APIEN  D
 . S APD0=$G(^PRCA(430,APIEN,0))   ; Patient info
 . S APD202=$G(^PRCA(430,APIEN,202))   ;Insured info
 . S BILLVAL=$$GET1^DIQ(399,APIEN_",",.07,"I") ; PRCA*4.5*326
 . I BILLVAL'=BILLTYP,BILLVAL'=BILLTYPF Q  ; Rate Type must be Reimbursable Insurance - PRCA*4.5*326
 . ; BEGIN - PRCA*4.5*321
 . Q:$$GET1^DIQ(430,APIEN_",",7,"I")=""       ; Quit if no PATIENT IEN
 . Q:$$GET1^DIQ(430,APIEN_",",9,"I")=""       ; Quit if no DEBTOR information
 . Q:$$GET1^DIQ(430,APIEN_",",239,"I")=""     ; quit if no subscriber name stored
 . Q:$$GET1^DIQ(430,APIEN_",",243,"I")=""     ; quit if no group name stored
 . Q:$$GET1^DIQ(430,APIEN_",",244,"I")=""     ; quit if no group number stored
 . Q:$$BILLREJ^PRCAUDT(APIEN)  ; PRCA*4.5*321 - claim has reject messages, do not audit
 . ;
 . S RATEIEN=$$GET1^DIQ(399,APIEN_",",.07,"I") ; Get bill's rate type ; IA 4118
 . Q:'RATEIEN
 . ; A rate type is auto-audited if BILL RESULTING FROM field is non-null
 . Q:'$$GET1^DIQ(399.3,RATEIEN_",",.11,"I")  ; Quit if not an auto-audit rate type
 . ;Read on IB file #399 field #27 covered by ICR #3820
 . S RCPAPER=$$GET1^DIQ(399,APIEN_",",27,"I") ; 0 - is electronic, 1 - is paper
 . ;Get the Bill number to check if it is a Pharmacy bill
 . S PRCABLNO=$$GET1^DIQ(430,APIEN_",",.01,"I")
 . S PRCAECME=$$GETECME^RCDPENR1(PRCABLNO)
 . I PRCAECME="",'FLG1,RCPAPER Q     ;Skip this paper bill if No Medical processing
 . I PRCAECME'="",'FLG2,RCPAPER Q    ;Skip this paper bill if No Pharmacy processing
 . I PRCAECME="",'FLG1E,'RCPAPER Q     ;Skip this EDI bill if No Medical processing
 . I PRCAECME'="",'FLG2E,'RCPAPER Q    ;Skip this EDI bill if No Pharmacy processing
 . ;
 . ; Bill Passed all checks now call auto-audit for this Bill number
 . D AUDITX^PRCAUDT(APIEN)
 Q
