IBY601PO ;EDE/DM - Post-Installation for IB patch 601 ; 01-NOV-2017
 ;;2.0;INTEGRATED BILLING;**601**;21-MAR-94;Build 14
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
POST ; POST ROUTINE(S)
 N IBXPD,XPDIDTOT
 S XPDIDTOT=2
 ;
 ; Send site registration message to FSC
 D REGMSG(1)
 ;
 ; Check/remove any link from an insurance to the National MBI Payer
 D CHKLNK(2)
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
 I '$$PROD^XUPROD(1) D MES^XPDUTL(" N/A - Not a production account - No site registration message sent") G REGMSGQ
 D MES^XPDUTL("Sending site registration message to FSC ... ")
 D ^IBCNEHLM
 ;
REGMSGQ ;
 Q
 ; 
CHKLNK(IBXPD) ; Due to a timing issue with the National MBI Payer
 ;It's possible that a client linked an insurance to the MBI payer
 ;This is not allowed. Any such link will be removed
 N IBMBIPYR,IBIEN
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Verifying Insurance links to payers...")
 S IBMBIPYR=0
 S IBMBIPYR=$O(^IBE(365.12,"B","CMS MBI ONLY",IBMBIPYR))
 I 'IBMBIPYR D BMES^XPDUTL("MBI Payer has not been established") G CHKLNKQ
 S IBIEN=0
 F  S IBIEN=$O(^DIC(36,"AC",IBMBIPYR,IBIEN)) Q:'IBIEN  D
 . S DIE="^DIC(36,",DA=IBIEN,DR="3.1///@" D ^DIE ; remove the link
 . W !,"Insurance:"_IBIEN_" "_$$GET1^DIQ(36,IBIEN_",","NAME")
 . K DIE,DA,DR
 ;
CHKLNKQ ;
 Q
 ;
