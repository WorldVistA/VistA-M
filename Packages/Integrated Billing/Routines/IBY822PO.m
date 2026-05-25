IBY822PO ;AITC/CKB - Post-Installation for IB patch 822; 02-APR-2025
 ;;2.0;INTEGRATED BILLING;**822**;21-MAR-94;Build 21
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Reference to ^XPDUTL in ICR #10141
 ; Reference to ^XUSAP  in ICR #4677
 Q
 ;
POST ; POST-INSTALL
 N IBXPD,XPDIDTOT
 ; total number of work items
 S XPDIDTOT=4
 ;
 D MES^XPDUTL("")
 ;
 D UPDENTRY(1)     ; Update DESCRIPTION field (#355.12,.02) for 'E-PHARMACY' entry to 'EPHARMACY' entry
 ;
 D IIVSTAT(2)      ; Add two new entries to the IIV STATUS TABLE file #365.15
 ;
 D ADDPROXY(3)     ; Create "IB,AUTOINS FILEUPDATE" in file New Person (#200)
 ;
 D SETDEF(4)       ; Set default for field E1 TRANSACTIONS ENABLED (#350.9,54.05) to '1' for 'YES'
 ;
 D MES^XPDUTL("")  ; Displays the 'Done' message and finishes the progress bar
 D MES^XPDUTL("POST-Install for IB*2.0*822 Completed.")
 Q
 ;================================
 ;
UPDENTRY(IBXPD) ;Update field #.02 DESCRIPTION in file #355.12 SOURCE OF INFORMATION
 ; from 'E-PHARMACY' to 'EPHARMACY'
 ;
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Update DESCRIPTION (#355.12,.02) for 'E-PHARMACY' entry... ")
 ;
 N IBENT,DATA,MSG
 I $D(^IBE(355.12,"C","EPHARMACY")) D  G UPDENTQ
 . S MSG="DESCRIPTION has already been updated to 'EPHARMACY'."
 . D MES^XPDUTL(MSG)
 S IBENT=$O(^IBE(355.12,"C","E-PHARMACY",0))
 I IBENT="" S MSG="Unable to update E-PHARMACY entry, not found." G UPDENTQ
 S DATA(.02)="EPHARMACY"
 D UPD^IBDFDBS(355.12,.IBENT,.DATA)
 S MSG="DESCRIPTION for 'E-PHARMACY' has been updated to 'EPHARMACY'."
UPDENTQ ;
 S MSG="Finshed STEP "_IBXPD_" of "_XPDIDTOT
 D MES^XPDUTL(MSG)
 ;
 Q
 ;================================
 ;
IIVSTAT(IBXPD) ;Add two new entries to the IIV STATUS TABLE file #365.15
 ;
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Adding entries to the IIV STATUS TABLE File (#365.15)")
 ;
 N IBASC,IBCODE,IBDATA,IBERR,IBEX,IBFIEN,IBFILE,IBIENS,IBRIEN,MSG
 S IBFILE=365.15,(IBCODE,IBASC,IBEX,IBERR,IBRIEN,IBFIEN)=""
 ; check if 'a1' or 'r1' defined
 I $D(^IBE(365.15,"B","a1")) D  G IIVST2
 . D MES^XPDUTL("Code 'a1' has already been added.")
 ; first create 'a1'
 S IBCODE="a1",IBASC=97,IBEX=0
 K IBDATA
 S IBDATA(.01)=IBCODE,IBDATA(.02)=IBASC,IBDATA(.03)=IBEX
 S IBFIEN=$$ADD^IBDFDBS(IBFILE,,.IBDATA,.IBERR,.IBRIEN)
 I 'IBFIEN!'(IBRIEN) D  G IIVST2
 . S MSG="NOT able to add entry 'a1' for reason: "_IBERR
 . D MES^XPDUTL(MSG)
 ; add description
 K IBDATA S IBERR="" S IBIENS=IBFIEN S:IBIENS="" IBIENS=IBRIEN S IBIENS=IBIENS_","
 I '+IBIENS D MES^XPDUTL("'a1' not added to the IIV STATUS TABLE File (#365.15)") G IIVST2
 S MSG="Entry 'a1' ("_+IBIENS_") ADDED to the IIV STATUS TABLE File (#365.15)" D MES^XPDUTL(MSG)
 S IBDATA(1,0)="Information received via electronic inquiry indicates an Accepted Response."
 ; save it
 D WP^DIE(IBFILE,IBIENS,1,"","IBDATA","IBERR")
 I IBERR'="" D
 . S MSG="NOT able to add DESCRIPTION to code : 'a1' ("_+IBIENS_") for error: "_IBERR
 E  S MSG="ADDED DESCRIPTION to code : 'a1' ("_+IBIENS_")"
 D MES^XPDUTL(MSG)
 ;
 ; add corrective action
 K IBDATA S IBERR=""
 S IBDATA(1,0)="Action to take: Review the details in the ePharmacy Eligibility Response Data"
 S IBDATA(2,0)="before processing this buffer entry."
 ; save it
 D WP^DIE(IBFILE,IBIENS,2,"","IBDATA","IBERR")
 I IBERR'="" D
 . S MSG="NOT able to add CORRECTIVE ACTION to code : 'a1' ("_+IBIENS_") for error: "_IBERR
 E  S MSG="ADDED CORRECTIVE ACTION to code : 'a1' ("_+IBIENS_")"
 D MES^XPDUTL(MSG)
 ;
IIVST2 ; add 'r1'
 ;
 I $D(^IBE(365.15,"B","r1")) D  G IIVSTATQ
 . D MES^XPDUTL("Code 'r1' has already been added.")
 ; first create 'r1'
 K IBDATA
 S IBCODE="r1",IBASC=114,IBEX=0,IBERR="",IBIENS="",IBRIEN="",IBFIEN=""
 S IBDATA(.01)=IBCODE,IBDATA(.02)=IBASC,IBDATA(.03)=IBEX
 S IBFIEN=$$ADD^IBDFDBS(IBFILE,,.IBDATA,.IBERR,.IBRIEN)
 I 'IBFIEN!'(IBRIEN) D  G IIVSTATQ
 . S MSG="NOT able to add entry 'r1' for reason: "_IBERR
 . D MES^XPDUTL(MSG)
 ;
 ; add description
 K IBDATA S IBERR="" S IBIENS=IBFIEN S:IBIENS="" IBIENS=IBRIEN S IBIENS=IBIENS_","
 I '+IBIENS S MSG="'r1' was not added to the IIV STATUS TABLE File (#365.15)" D MES^XPDUTL(MSG) G IIVSTATQ
 S MSG="Entry 'r1' ("_+IBIENS_") ADDED to the IIV STATUS TABLE File (#365.15)" D MES^XPDUTL(MSG)
 S IBDATA(1,0)="Information received via electronic inquiry indicates a Rejected Response."
 ; save it
 D WP^DIE(IBFILE,IBIENS,1,"","IBDATA","IBERR")
 I IBERR'="" D
 . S MSG="NOT able to add DESCRIPTION to code : 'r1' ("_+IBIENS_") for error: "_IBERR
 E  S MSG="ADDED DESCRIPTION to code : 'r1' ("_+IBIENS_")"
 D MES^XPDUTL(MSG)
 ;
 ; add corrective action
 K IBDATA S IBERR=""
 S IBDATA(1,0)="Action to take: Review the details listed in the ePharmacy Eligibility"
 S IBDATA(2,0)="Response and contact the insurance company to manually verify this"
 S IBDATA(3,0)="insurance information."
 ; save it
 D WP^DIE(IBFILE,IBIENS,2,"","IBDATA","IBERR")
 I IBERR'="" D
 . S MSG="NOT able to add CORRECTIVE ACTION to code : 'a1' ("_+IBIENS_") for error: "_IBERR
 E  S MSG="ADDED CORRECTIVE ACTION to code : 'r1' ("_+IBIENS_")"
 D MES^XPDUTL(MSG)
 ;
IIVSTATQ ;
 S MSG="Finished STEP "_IBXPD_" of "_XPDIDTOT
 D MES^XPDUTL(MSG)
 Q
 ;================================ 
 ;
ADDPROXY(IBXPD) ;Add APPLICATION PROXY user to file 200.  Supported by IA#4677.
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Adding entry 'IB,AUTOINS FILEUPDATE' to the New Person file (#200)")
 N IEN200,IBPROX
 S IEN200=$$CREATE^XUSAP("IB,AUTOINS FILEUPDATE","")
 I +IEN200=0 D MES^XPDUTL("New Person 'IB,AUTOINS FILEUPDATE' already exists.") Q
 I IEN200<0 D MES^XPDUTL("...ERROR: New Person 'IB,AUTOINS FILEUPDATE' NOT added.") Q
 I +IEN200>0 D  Q
 . D MES^XPDUTL("New Person 'IB,AUTOINS FILEUPDATE' added.")
 Q
 ;================================ 
 ;
SETDEF(IBXPD) ;Set default for field #350.9,54.05 to '1' for 'YES'.
 ;
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Set default for field E1 TRANSACTIONS ENABLED (#350.9,54.05) ... ")
 ;
 N IBDFDA,DATA,ENABLED,MSG
 S ENABLED=$$GET1^DIQ(350.9,"1,",54.05)
 I ENABLED'="" S MSG="E1 TRANSACTIONS ENABLED is already set." G SETDEFQ
 S IBDFDA=1
 S DATA(54.05)=1
 D UPD^IBDFDBS(350.9,.IBDFDA,.DATA)
 S MSG="E1 TRANSACTIONS ENABLED default set to 1 for 'YES'."
SETDEFQ ;
 D MES^XPDUTL(MSG)
 Q
