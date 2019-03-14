IBY621PO ;AITC/DM - Post-Installation for IB patch 621; 22-MAY-2018
 ;;2.0;INTEGRATED BILLING;**621**;21-MAR-94;Build 14
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
POST ; POST ROUTINE(S)
 N IBXPD,XPDIDTOT
 S XPDIDTOT=3
 ;
 ; Create/update the EICD extract  
 D CHKEICD(1)
 ;
 ; Send site registration message to FSC
 D REGMSG(2)
 ;
 ; Check/remove any link from an insurance to the National EICD Payer
 D CHKLNK(3)
 ;
 ; Displays the 'Done' message and finishes the progress bar
 D MES^XPDUTL("")
 D MES^XPDUTL("POST-Install Completed.")
 Q
 ;
REGMSG(IBXPD) ; send site registration message to FSC
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Sending site registration message to FSC ... ")
 ;
 I '$$PROD^XUPROD(1) D MES^XPDUTL(" N/A - Not a production account - No site registration message sent") G REGMSGQ
 D MES^XPDUTL("Sending site registration message to FSC ... ")
 D ^IBCNEHLM
 ;
REGMSGQ ;
 Q
 ; 
CHKLNK(IBXPD) ; Due to a timing issue with the National EICD Payer
 ;It's possible that a client linked an insurance to the EICD payer
 ;This is not allowed. Any such link will be removed
 N IBEICDPY,IBIEN
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Verifying Insurance links to payers...")
 ;
 S IBEICDPY=0
 S IBEICDPY=$O(^IBE(365.12,"B","ELECTRONIC COVERAGE DISCOVERY",IBEICDPY))
 I 'IBEICDPY D BMES^XPDUTL("The Electronic Insurance Coverage Discovery Payer has not been established") G CHKLNKQ
 S IBIEN=0
 F  S IBIEN=$O(^DIC(36,"AC",IBEICDPY,IBIEN)) Q:'IBIEN  D
 . S DIE="^DIC(36,",DA=IBIEN,DR="3.1///@" D ^DIE ; remove the link
 . W !,"Insurance:"_IBIEN_" "_$$GET1^DIQ(36,IBIEN_",","NAME")
 . K DIE,DA,DR
 ;
CHKLNKQ ;
 Q
 ;
CHKEICD(IBXPD) ; Create or update the EICD Extract
 N IBFDA,IBSETIEN,IBERR,IBEXT4,IBEXTIEN
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Create/update the EICD Extract parameters... ")
 ;
 S IBEXT4=+$$FIND1^DIC(350.9002,",1,","BQX","4","B")
 I 'IBEXT4 D  G CHKEICDQ
 . W !," Creating a new EICD batch extract record..."
 . S IBEXTIEN="+1,1,"
 . S IBSETIEN(1)=4 ;for safety, force new IEN to 4
 . S IBFDA(350.9002,IBEXTIEN,.01)="4"   ; BATCH EXTRACTS
 . S IBFDA(350.9002,IBEXTIEN,.02)="1"   ; Active?
 . S IBFDA(350.9002,IBEXTIEN,.03)=""    ; SELECTION CRITERIA #1
 . S IBFDA(350.9002,IBEXTIEN,.04)=""    ; SELECTION CRITERIA #2
 . S IBFDA(350.9002,IBEXTIEN,.05)=99999 ; MAXIMUM EXTRACT NUMBER
 . S IBFDA(350.9002,IBEXTIEN,.06)="1"   ; SUPPRESS BUFFER CREATION
 . S IBFDA(350.9002,IBEXTIEN,.07)=31    ; START DAYS
 . S IBFDA(350.9002,IBEXTIEN,.08)=9     ; DAYS AFTER START
 . S IBFDA(350.9002,IBEXTIEN,.09)=365   ; FREQUENCY
 . ;
 . D UPDATE^DIE(,"IBFDA","IBSETIEN","IBERR")
 . I $G(IBERR("DIERR",1,"TEXT",1))'="" W !,"ISSUE CREATING EXTRACT: "_$G(IBERR("DIERR",1,"TEXT",1))
 ;
 I IBEXT4 D  G CHKEICDQ
 . W !," Updating existing EICD batch extract record..."
 . S IBEXTIEN=IBEXT4_",1,"
 . S IBFDA(350.9002,IBEXTIEN,.02)="1"   ; Active?
 . S IBFDA(350.9002,IBEXTIEN,.03)=""    ; SELECTION CRITERIA #1
 . S IBFDA(350.9002,IBEXTIEN,.04)=""    ; SELECTION CRITERIA #2
 . S IBFDA(350.9002,IBEXTIEN,.05)=99999 ; MAXIMUM EXTRACT NUMBER
 . S IBFDA(350.9002,IBEXTIEN,.06)="1"   ; SUPPRESS BUFFER CREATION
 . S IBFDA(350.9002,IBEXTIEN,.07)=31    ; START DAYS
 . S IBFDA(350.9002,IBEXTIEN,.08)=9     ; DAYS AFTER START
 . S IBFDA(350.9002,IBEXTIEN,.09)=365   ; FREQUENCY
 . ;
 . D FILE^DIE(,"IBFDA","IBERR")
 . I $G(IBERR("DIERR",1,"TEXT",1))'="" W !,"ISSUE UPDATING EXTRACT: "_$G(IBERR("DIERR",1,"TEXT",1))
 ;
CHKEICDQ ; 
 Q
 ;
