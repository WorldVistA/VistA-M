PRCABJ2 ;ALB/SAB - NIGHTLY PROCESS FOR ACCOUNTS RECEIVABLE ;07-JUL-15
 ;;4.5;Accounts Receivable;**304**;Mar 20, 1995;Build 104
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; read of DGCR(399.2 allowed by DBIA 3822
 ;
 Q
 ; Auto-audit Paper bills if ready
ABAUDIT ;
 ; Local Variables
 ;    APIEN - Accounts Payable (file #430) ien
 ;
 N APIEN,DIE,DA,DR,DIR,DIRUT,DTOUT,DUOUT,X,Y,APD0,APD202,FLG1,FLG2
 N PRCABLNO,PRCAECME,NBLIEN,HICD,CATIEN,ACTIVE,BILLTYP,RCPAPER
 ;
 S APIEN=""
 ;
 ;Check parameters to see if it needs to run.
 S FLG1=$$GET1^DIQ(342,"1,",7.05,"I")   ; Get the value of the auto-audit medical paper bill flag
 S FLG2=$$GET1^DIQ(342,"1,",7.06,"I")   ; Get the value of the auto-audit pharmacy paper bill flag
 ;
 ; Quit if both set to no
 Q:('FLG1)&('FLG2)
 ;
 ;retrieve DB values
 S NBLIEN=$O(^PRCA(430.3,"B","NEW BILL",""))  ; New Bill Status IEN
 S CATIEN=$O(^PRCA(430.2,"C","RI",""))        ; Reimbursable Insurance IEN
 S HICD=$O(^PRCA(430.6,"B","HI",""))          ; Health insurance IEN
 S ACTIVE=$O(^PRCA(430.3,"B","ACTIVE",""))    ; New Bill Status IEN
 S BILLTYP=$O(^DGCR(399.3,"B","REIMBURSABLE INS.",""))  ; Bill Type IEN
 S RCPAPER=1 ; Field 27 in ^DGCR(399 ; 0 - is electronic, 1 - FORCE LOCAL PRINT
 ;
 Q:NBLIEN=""
 ;
 F  S APIEN=$O(^PRCA(430,"AC",NBLIEN,APIEN)) Q:'APIEN  D
 . S APD0=$G(^PRCA(430,APIEN,0))   ; Patient info
 . S APD202=$G(^PRCA(430,APIEN,202))   ;Insured info
 . Q:$$GET1^DIQ(399,APIEN_",",.07,"I")'=BILLTYP  ; Bill type is not Reimbursable Insurance. Skip
 . Q:$$GET1^DIQ(399,APIEN_",",27,"I")'=RCPAPER  ; Bill is not forced to Paper (it is electronic). Skip
 . ;
 . Q:$P(APD0,U,7)=""       ; Quit if no PATIENT IEN
 . Q:$P(APD0,U,9)=""       ; Quit if no DEBTOR information
 . Q:$P(APD202,U,1)=""     ; quit if no subscriber name stored
 . Q:$P(APD202,U,5)=""     ; quit if no group name stored
 . Q:$P(APD202,U,6)=""     ; quit if no group number stored
 . ;
 . ;Get the Bill number to check if it is a Pharmacy bill
 . S PRCABLNO=$P(APD0,U)
 . S PRCAECME=$$GETECME^RCDPENR1(PRCABLNO)
 . I PRCAECME=""&'FLG1 Q     ;Skip this bill if No Medical processing
 . I PRCAECME'=""&'FLG2 Q    ;Skip this bill if No Pharmacy
 . ;
 . ; Bill Passed all checks now call auto-audit for this Bill number
 . D AUDITX^PRCAUDT(APIEN)
 Q
