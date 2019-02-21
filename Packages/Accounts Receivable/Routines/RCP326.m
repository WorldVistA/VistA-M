RCP326 ;BIRM/EWL ALB/PJH - ePayment Lockbox Post-Installation Processing ;Dec 20, 2014@14:08:45
 ;;4.5;Accounts Receivable;**326**;Jan 21, 2014;Build 26
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
POST() ;
 N DIK
 D BMES^XPDUTL("Re-indexing TRANSACTION#  on EFT DETAIL file (#344.31)")
 S DIK="^RCY(344.31,",DIK(1)=".14^D" D ENALL^DIK
 ;
 D BMES^XPDUTL("Creating index by payer name and TIN on EFT DETAIL file (#344.31)")
 S DIK="^RCY(344.31,",DIK(1)=".02^APT" D ENALL^DIK
 ;
 D BMES^XPDUTL("Creating index by TIN and payer name on EFT DETAIL file (#344.31)")
 S DIK="^RCY(344.31,",DIK(1)=".03^ATP" D ENALL^DIK
 ;
 D BMES^XPDUTL("Creating index by payer name and TIN on ERA file (#344.4)")
 S DIK="^RCY(344.4,",DIK(1)=".06^APT" D ENALL^DIK
 ;
 D BMES^XPDUTL("Creating index by TIN and payer name on ERA file (#344.4)")
 S DIK="^RCY(344.4,",DIK(1)=".03^ATP" D ENALL^DIK
 ;
 D BMES^XPDUTL("Creating index by pharmacy flag on Payer Exclusion file (#344.6)")
 S DIK="^RCY(344.6,",DIK(1)=".09^ARX" D ENALL^DIK
 ;
 D BMES^XPDUTL("Creating index by tricare flag on Payer Exclusion file (#344.6)")
 S DIK="^RCY(344.6,",DIK(1)=".1^ATR" D ENALL^DIK
 ;
 ; Populate MED AMT DEFAULT AUTO-DECREASE
 D:$$GET1^DIQ(344.61,"1,",.05)=""
 .N DA,DIE,DR
 .S DIE="^RCY(344.61,",DR=".05///5000;",DA=1 D ^DIE
 ;
US786 ;
 D BMES^XPDUTL("Converting RCDPE APAR, MEDICAL/PHARMACY parameter from 'Both' to 'All'")
 N RCENT,RCERR,RCINST,RCOUT,RCPAR
 K ^TMP($J,"RCP326")
 S RCOUT="^TMP($J,""RCP326"")"
 S RCPAR="RCDPE APAR"
 S RCINST="MEDICAL/PHARMACY"
 D ENVAL^XPAR(.RCOUT,RCPAR,RCINST,.RCERR,1) ; IA 2992 PARAMETER DEFINITION TOOLKIT
 S RCENT=""
 F  S RCENT=$O(^TMP($J,"RCP326",RCENT)) Q:RCENT=""  D  ;
 . I $G(^TMP($J,"RCP326",RCENT,RCINST))="B" D  ;
 . . D EN^XPAR(RCENT,RCPAR,RCINST,"A",.RCERR) ; IA 2992 PARAMETER DEFINITION TOOLKIT
 K ^TMP($J,"RCP326")
 ;
 S ZTRTN="EFT3446^"_$T(+0),ZTDESC="Add EFT Payer/TIN to 344.6",ZTIO="",ZTDTH=$H
 D ^%ZTLOAD
 D MES^XPDUTL($S($G(ZTSK):"Task# "_ZTSK_" queued, to add EFTs to 344.6",1:"Unable to queue EFT 344.6 task."))
 Q
EFT3446 ; Add EFT Payer/TINs to payer exclusion file
 N ID,IEN,NAME,RET
 S IEN=0
 F  S IEN=$O(^RCY(344.31,IEN)) Q:'IEN  D  ;
 . S NAME=$$GET1^DIQ(344.31,IEN_",",.02)
 . S ID=$$GET1^DIQ(344.31,IEN_",",.03)
 . I NAME=""!(ID="") Q
 . I '$D(^RCY(344.6,"CPID",NAME,ID)) S RET=$$PAYRINIT^RCDPESP(IEN,344.31)
 Q
