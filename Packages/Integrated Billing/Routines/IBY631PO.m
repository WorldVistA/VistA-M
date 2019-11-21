IBY631PO ;AITC/TAZ - Post-Installation for IB patch 631; 22-MAY-2018
 ;;2.0;INTEGRATED BILLING;**631**;21-MAR-94;Build 23
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
POST ; POST ROUTINE(S)
 N IBXPD,XPDIDTOT
 S XPDIDTOT=2
 ;
 ; Send site registration message to FSC
 D REGMSG(1)
 ; Change the description & acronym for PURCHASED CARE CHOICE in SOI file [#355.12]
 D CHGSOI(2)
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
CHGSOI(IBXPD) ; change the PURCHASED CARE CHOICE description & acronym in SOI file.
 N IBDATA,IBDFDA,IBERROR,IBFILE
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Changing Description & Acronym for PURCHASED CARE CHOICE (PCC)")
 D MES^XPDUTL("to COMMUNITY CARE NETWORK (CCN) in the SOI File [#355.12] ... ")
 ;
 ; Get the internal EIN for the SOI record to be changed in the #355.12 file.
 S IBDFDA=$$FIND1^DIC(355.12,"","X","PURCHASED CARE CHOICE","C")
 I 'IBDFDA D  G CHGSOIQ
 . D MES^XPDUTL(" The 'PURCHASED CARE CHOICE' does not exist in the SOI file [#355.12],")
 . D MES^XPDUTL(" ...Description and Acronym NOT CHANGED.")
 ; Change the description & acronym for the SOI record in the #355.12 file.
 S IBFILE=355.12,IBDATA(.02)="COMMUNITY CARE NETWORK",IBDATA(.03)="CCN"
 I $$UPD^IBDFDBS(IBFILE,IBDFDA,.IBDATA,.IBERROR) D  G CHGSOIQ
 . D MES^XPDUTL(" CHANGED the Description & Acronym for PURCHASED CARE CHOICE (PCC)")
 . D MES^XPDUTL("   in the SOI File to COMMUNITY CARE NETWORK (CCN).")
 ;
CHGSOIQ ;
 Q
 ;
