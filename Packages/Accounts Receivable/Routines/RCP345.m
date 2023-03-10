RCP345 ;AITC/CJE,hrubovcak - ePayment Lockbox Post-Installation Processing ;22 Jan 2019 14:32:31
 ;;4.5;Accounts Receivable;**345**;Mar 20, 1995;Build 34
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
POST ;
 D AUTO1
 ;
 D BMES^XPDUTL("Creating index on CARC Auto-Decrease No Pay (#344.62)")
 S DIK="^RCY(344.62,",DIK(1)=".08^ACTVN" D ENALL^DIK
 ;
 D RXADDF ; Populate defaults for Pharmacy Auto-Decrease
EFT ;
 S ZTRTN="EFT3446^"_$T(+0),ZTDESC="Add EFT Payer/TIN to 344.6",ZTIO="",ZTDTH=$H
 D ^%ZTLOAD
 D MES^XPDUTL($S($G(ZTSK):"Task# "_ZTSK_" queued, to add EFTs to 344.6",1:"Unable to queue EFT 344.6 task."))
 ;
 D BMES^XPDUTL("Fixing ERA numbers...")
 D FIX3444
 ;
 D BMES^XPDUTL("PRCA*4.5*345 post-installation finished "_$$HTE^XLFDT($H))
 Q
 ;
AUTO1 ; Populate default values for 1st party auto-decrease
 N FDA,IEN3501,J,RCLIST
 D BMES^XPDUTL("Populate default values for 1st party auto-decrease (#342)")
 S FDA(342,"1,",.14)=0
 S FDA(342,"1,",.15)=0
 D FILE^DIE("","FDA")
 ;
 S RCLIST(1)="DG FEE SERVICE (OPT) NEW"
 S RCLIST(2)="DG OPT COPAY NEW"
 ; S RCLIST(3)="PSO NSC RX COPAY NEW"
 ; S RCLIST(4)="PSO SC RX COPAY NEW"
 S RCLIST(3)="CC (OPT) NEW"
 ;
 K ^RC(342,1,14)
 S J=0 F  S J=$O(RCLIST(J)) Q:'J  D  ;
 . S IEN3501=$O(^IBE(350.1,"B",RCLIST(J),0))
 . I IEN3501 D  ;
 . . K FDA,IENS
 . . S FDA(342.014,"+1,1,",.01)=IEN3501
 . . S FDA(342.014,"+1,1,",.02)=1
 . . D UPDATE^DIE("","FDA")
 Q
 ;
RXADDF ; Populate defaults for Pharmacy Auto-Decrease
 N FDA
 S FDA(344.61,"1,",1.02)=0
 S FDA(344.61,"1,",1.03)=5
 S FDA(344.61,"1,",1.04)=100
 D FILE^DIE("","FDA")
 Q
 ;
EFT3446 ; Add EFT Payer/TINs to payer exclusion file
 N ID,IEN,NAME,RET
 S IEN=0
 F  S IEN=$O(^RCY(344.31,IEN)) Q:'IEN  D  ;
 . S NAME=$$GET1^DIQ(344.31,IEN_",",.02)
 . S ID=$$GET1^DIQ(344.31,IEN_",",.03)
 . I NAME=""!(ID="") Q
 . I '$D(^RCY(344.6,"CPID",NAME,ID)) S RET=$$PAYRINIT^RCDPESP(IEN,344.31)
 Q
 ;
FIX3444 ; Repair Internal Entry Numbers in 344.4 where IEN is not equal to .01
 N IEN,ENTRY
 S IEN=0
 F  S IEN=$O(^RCY(344.4,IEN)) Q:'IEN  D  ;
 . S ENTRY=$P($G(^RCY(344.4,IEN,0)),"^",1)
 . I 'ENTRY Q
 . I ENTRY'=IEN D  ;
 . . N FDA
 . . S FDA(344.4,IEN_",",.01)=IEN
 . . D FILE^DIE("","FDA")
 Q
