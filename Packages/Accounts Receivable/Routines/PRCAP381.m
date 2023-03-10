PRCAP381 ;EDE/SAB - PRCA*4.5*381 POST INSTALL; 12/04/20
 ;;4.5;Accounts Receivable;**381**;Mar 20, 1995;Build 28
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
EN ; entry point
 D BMES^XPDUTL(" >>  Start of the Post-Installation routine for PRCA*4.5*381")
 ;
 ; Update the ATCS? field in Repayment Plans
 D ATCS
 ;
 D BMES^XPDUTL(" >>  End of the Post-Installation routine for PRCA*4.5*381")
 Q
 ;
ATCS ; review plans and update the AT CS flag associated with the plans.
 ;
 D BMES^XPDUTL(" >>  Reviewing the Repayment Plans Cross Servicing Flags")
 ;
 N RCATCS,RCCSDT,RCCSRCDT,RCDATA,RCDBTR,RCIEN
 ;
 S RCDBTR=0
 F  S RCDBTR=$O(^RCRP(340.5,"E",RCDBTR)) Q:'RCDBTR  D
 . S RCIEN=0
 . S RCATCS=0
 . F  S RCIEN=$O(^RCRP(340.5,"E",RCDBTR,RCIEN)) Q:'RCIEN  D  Q:RCATCS
 . . S RCSTAT=$$GET1^DIQ(340.5,RCIEN_",",.07,"I")
 . . Q:RCSTAT>5 
 . . S (RCBILLDA,RCATCS)=0
 . . ;Loop through all of the bills a Debtor has.
 . . F  S RCBILLDA=$O(^PRCA(430,"C",RCDBTR,RCBILLDA)) Q:'RCBILLDA  D  Q:RCATCS
 . . . S RCCSDT=+$$GET1^DIQ(430,RCBILLDA_",",151,"I")    ; get CS Date referral date
 . . . S RCCSRCDT=+$$GET1^DIQ(430,RCBILLDA_",",153,"I")  ; get CS Recall date
 . . . Q:'RCCSDT   ; Plan not at cross servicing
 . . . Q:RCCSRCDT  ; Plan was at Cross Servicing but is now recalled.
 . . . S RCATCS=1
 . . ;W RCIEN," - ",RCATCS,!
 . . ;
 . . ;Update the field.
 . . D UPDATCS^RCRPU2(RCIEN,RCATCS)
 D BMES^XPDUTL(" >>  Review and updates if necessary of the Repayment Plans Cross Servicing Flags is completed.")
 ;
 Q
