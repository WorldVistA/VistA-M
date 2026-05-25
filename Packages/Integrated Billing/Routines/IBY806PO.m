IBY806PO ;AITC/DTG - Post-Installation for IB patch 806; OCT 23, 2024
 ;;2.0;INTEGRATED BILLING;**806**;21-MAR-94;Build 19
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Reference to ^XPDUTL in ICR #10141
 ; Reference to ^XUSAP  in ICR #4677
 Q
 ;
POST ; POST-INSTALL
 N IBXPD,SITE,XPDIDTOT
 ; total number of work items
 S XPDIDTOT=2
 ;
 D MES^XPDUTL("")
 ;
 D ADDPROXY(1)     ; Create "IB,BUFFER CLEANUP" in file New Person (#200)
 ;
 D SETDEF(2)       ; Set default field #350.9,54.03 to '0' for 'NO'
 ;
 D MES^XPDUTL("")  ; Displays the 'Done' message and finishes the progress bar
 D MES^XPDUTL("POST-Install for IB*2.0*806 Completed.")
 Q
 ;============================
 ;
ADDPROXY(IBXPD) ;Add APPLICATION PROXY user to file 200.  Supported by IA#4677.
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Adding entry 'IB,BUFFER CLEANUP' to the New Person file (#200)")
 N IEN200,IBPROX
 S IEN200=$$CREATE^XUSAP("IB,BUFFER CLEANUP","")
 I +IEN200=0 D MES^XPDUTL("New Person 'IB,BUFFER CLEANUP' already exists.") Q
 I IEN200<0 D MES^XPDUTL("...ERROR: New Person 'IB, BUFFER CLEANUP' NOT added.") Q
 I +IEN200>0 D  Q
 . D MES^XPDUTL("New Person 'IB,BUFFER CLEANUP' added.")
 . D MES^XPDUTL("  with 'APPLICATION PROXY' added as the USER CLASS(#200.07,.01)")
 . D MES^XPDUTL("  and ISPRIMARY (#200.07,2).")
 Q
 ;
SETDEF(IBXPD) ;Set Default for field #350.9,54.03 to '0' for 'NO'.
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Set default for field BUFFER CLEANUP ENABLED (#350.9,54.03) ... ")
 ;
 N IBDFDA,DATA,ENABLED,MSG
 S ENABLED=$$GET1^DIQ(350.9,"1,",54.03)
 I ENABLED'="" S MSG="BUFFER CLEANUP ENABLED is already set." G SETDEFQ
 S IBDFDA=1
 S DATA(54.03)=0
 D UPD^IBDFDBS(350.9,.IBDFDA,.DATA)
 S MSG="BUFFER CLEANUP ENABLED default set to 0 for 'NO'."
SETDEFQ ;
 D MES^XPDUTL(MSG)
 ;
 Q
