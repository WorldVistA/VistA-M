IBY687PO ;AITC/VD - Post-Installation for IB patch 687; OCT 02, 2020
 ;;2.0;INTEGRATED BILLING;**687**;MAR 21,1994;Build 88
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; ICR #1367 for the usage of ^XPDKEY.
 ; ICR #10141 for the usage of ^XPDUTL.
 ; ICR #4677 for the usage of CREATE^XUSAP.
 ; ICR #10007 for the usage of DO^DIC1.
 ; ICR #2052 for the usage of FIELD^DID.
 ; ICR #2916 for the usage of FILESEC^DDMOD.
 Q
 ;
POST ; POST-INSTALL
 N IBXPD,PRODENV,SITE,SITENAME,SITENUM,XPDIDTOT
 S XPDIDTOT=13
 S SITE=$$SITE^VASITE,SITENAME=$P(SITE,U,2),SITENUM=$P(SITE,U,3)
 ;
 S PRODENV=$$PROD^XUPROD(1)   ; 1=Production Environment, 0=Test Environment
 D MES^XPDUTL("")
 ;
 D IIU(1)          ; Add new payer application to PAYER APPLICATION file (#365.13)
 ;
 D SITEFIL(2)      ; Set initial value for the IIU MASTER SWITCH field (#350.9,53.01)
 D SITEFIL(3)      ; Set initial value for the IIU ENABLED field (#350.9,53.02)
 D SITEFIL(4)      ; Set initial value for the IIU RECENT VISIT DAYS field (#350.9,53.03)
 D SITEFIL(5)      ; Set initial value for the IIU MIN DAYS BEFORE SHARING field (#350.9,53.04)
 D SITEFIL(6)      ; Set initial value for the IIU PURGE SENT RECORDS field (#350.9,53.05)
 D SITEFIL(7)      ; Set initial value for the IIU PURGE CANDIDATE RECORDS field (#350.9,53.06)
 D SITEFIL(8)      ; Set initial value for the IIU PURGE RECEIVED RECORDS field (#350.9,53.07)
 ;
 D RENAMKY(9)      ; Rename the IBCNE EIV MAINTENANCE security key to IBCNE EIV IIU MAINTENANCE
 ;
 D ADDPROXY(10)    ; Create "INTERFACE,IB IIU" in file New Person (#200)
 ;
 D CLNIB668(11)    ; Clean up Files & Fields that should have been deleted during IB*668 pre-install
 ;
 D FILESEC(12)     ;Set Security on INTERFACILITY INSURANCE UPDATE (#365.19) File
 ;
 D SITEREG(13,SITENUM) ; Send site registration message to FSC
 ;
 D MES^XPDUTL("")      ; Displays the 'Done' message and finishes the progress bar
 D MES^XPDUTL("POST-Install for IB*2.0*687 Completed.")
 Q
 ;============================
IIU(IBXPD) ; Add new payer application to PAYER APPLICATION file (#365.13)
 N IBERR,IBIEN,DATA
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Adding ""IIU"" as a new Payer Application in PAYER APPLICATION file (#365.13)")
 ;
 S DATA(.01)="IIU"
 ;
 I $$FIND1^DIC(365.13,,,"IIU") D  G IIUQ   ; IIU already exists in file.
 . D MES^XPDUTL("IIU already exists in the Payer Application file (#355.13).")
 ;
 S IBIEN=$$ADD^IBDFDBS(365.13,,.DATA,.IBERR)
 ;
 I IBERR D  G IIUQ
 . D BMES^XPDUTL("")
 . D BMES^XPDUTL("*** ERROR ADDING ""IIU"" TO THE PAYER APPLICATION FILE (#365.13) - Log a Service Ticket! ***")
 ;
 D MES^XPDUTL("Payer Application: IIU added successfully")
 ;
IIUQ ;
 Q
 ;
SITEFIL(IBXPD) ; Set initial value of the new IB Site Parameter fields (US23559)
 N DA,DIE,DR
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 ;
 I IBXPD=2 D  Q
 . D MES^XPDUTL("Initialize value of IIU MASTER SWITCH field to NULL in IB SITE PARAMETERS file...")
 . I $$GET1^DIQ(350.9,"1,",53.01)'="" D  Q    ; Skip if this field is already set.
 . . D BMES^XPDUTL("    Patch IB*2.0*687 has been previously installed...")
 . . D MES^XPDUTL("    ...Skipping the initialization of the IIU MASTER SWITCH field.") Q
 . S DA=1,DIE=350.9,DR="53.01///" D ^DIE    ; Set to NULL because FSC controls this setting.
 . K DA,DIE,DR
 ;
 I IBXPD=3 D  Q
 . D MES^XPDUTL("Initialize value of IIU ENABLED to YES in IB SITE PARAMETERS file...")
 . I $$GET1^DIQ(350.9,"1,",53.02)'="" D  Q    ; Skip if this field is already set.
 . . D BMES^XPDUTL("    Patch IB*2.0*687 has been previously installed...")
 . . D MES^XPDUTL("    ...Skipping the initialization of the IIU ENABLED field.") Q
 . S DIE=350.9,DA=1,DR="53.02///"_"Y" D ^DIE
 . K DA,DIE,DR
 ;
 I IBXPD=4 D  Q
 . D MES^XPDUTL("Initialize value of IIU RECENT VISIT DAYS field to 335 in IB SITE PARAMETERS file...")
 . I $$GET1^DIQ(350.9,"1,",53.03)'="" D  Q    ; Skip if this field is already set.
 . . D BMES^XPDUTL("    Patch IB*2.0*687 has been previously installed...")
 . . D MES^XPDUTL("    ...Skipping the initialization of the IIU RECENT VISIT DAYS field.") Q
 . S DA=1,DIE=350.9,DR="53.03///335" D ^DIE
 . K DA,DIE,DR
 ;
 I IBXPD=5 D  Q
 . D MES^XPDUTL("Initialize value of IIU MIN DAYS BEFORE SHARING field to 170 in IB SITE PARAMETERS file...")
 . I $$GET1^DIQ(350.9,"1,",53.04)'="" D  Q    ; Skip if this field is already set.
 . . D BMES^XPDUTL("    Patch IB*2.0*687 has been previously installed...")
 . . D MES^XPDUTL("    ...Skipping the initialization of the IIU MIN DAYS BEFORE SHARING field.") Q
 . S DA=1,DIE=350.9,DR="53.04///170" D ^DIE
 . K DA,DIE,DR
 ;
 I IBXPD=6 D  Q
 . D MES^XPDUTL("Initialize value of IIU PURGE SENT RECORDS field to 180 in IB SITE PARAMETERS file...")
 . I $$GET1^DIQ(350.9,"1,",53.05)'="" D  Q    ; Skip if this field is already set.
 . . D BMES^XPDUTL("    Patch IB*2.0*687 has been previously installed...")
 . . D MES^XPDUTL("    ...Skipping the initialization of the IIU PURGE SENT RECORDS field.") Q
 . S DA=1,DIE=350.9,DR="53.05///180" D ^DIE
 . K DA,DIE,DR
 ;
 I IBXPD=7 D  Q
 . D MES^XPDUTL("Initialize value of IIU PURGE CANDIDATE RECORDS field to 7 in IB SITE PARAMETERS file...")
 . I $$GET1^DIQ(350.9,"1,",53.06)'="" D  Q    ; Skip if this field is already set.
 . . D BMES^XPDUTL("    Patch IB*2.0*687 has been previously installed...")
 . . D MES^XPDUTL("    ...Skipping the initialization of the IIU PURGE CANDIDATE RECORDS field.") Q
 . S DA=1,DIE=350.9,DR="53.06///7" D ^DIE
 . K DA,DIE,DR
 ;
 I IBXPD=8 D  Q
 . D MES^XPDUTL("Initialize value of IIU PURGE RECEIVED RECORDS field to 30 in IB SITE PARAMETERS file...")
 . I $$GET1^DIQ(350.9,"1,",53.07)'="" D  Q    ; Skip if this field is already set.
 . . D BMES^XPDUTL("    Patch IB*2.0*687 has been previously installed...")
 . . D MES^XPDUTL("    ...Skipping the initialization of the IIU PURGE RECEIVED RECORDS field.") Q
 . S DA=1,DIE=350.9,DR="53.07///30" D ^DIE
 . K DA,DIE,DR
 Q
 ;
RENAMKY(IBXPD) ; Rename the IBCNE EIV MAINTENANCE security key to IBCNE EIV IIU MAINTENANCE
 N IBFLAG
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Renaming the IBCNE EIV MAINTENANCE security key...")
 ;
 ; Check whether the security key has already been renamed.
 I $O(^DIC(19.1,"B","IBCNE EIV MAINTENANCE",0))'>0,+$O(^DIC(19.1,"B","IBCNE EIV IIU MAINTENANCE",0)) D  Q
 . D MES^XPDUTL("The IBCNE EIV MAINTENANCE security key was previously renamed")
 . D MES^XPDUTL("to IBCNE EIV IIU MAINTENANCE. No change made.")
 ; 
 ; Rename the security key.
 S IBFLAG=$$RENAME^XPDKEY("IBCNE EIV MAINTENANCE","IBCNE EIV IIU MAINTENANCE")    ; ICR # 1367
 I 'IBFLAG D MES^XPDUTL("The IBCNE EIV MAINTENANCE security key was not renamed!"),MES^XPDUTL("Aborting security key update.") Q
 ;
 D MES^XPDUTL("The IBCNE EIV MAINTENANCE security key has been successfully renamed")
 D MES^XPDUTL("to IBCNE EIV IIU MAINTENANCE!")
 Q
 ;
ADDPROXY(IBXPD) ;Add APPLICATION PROXY user to file 200.  Supported by IA#4677.
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Adding entry 'INTERFACE,IB IIU' to the New Person file (#200)")
 N IEN200
 S IEN200=$$CREATE^XUSAP("INTERFACE,IB IIU","")
 I +IEN200=0 D MES^XPDUTL("........'INTERFACE,IB IIU' already exists.")
 I +IEN200>0 D MES^XPDUTL("........'INTERFACE,IB IIU' added.")
 I IEN200<0 D MES^XPDUTL("........ERROR: 'INTERFACE,IB IIU' NOT added.")
 Q
 ;
CLNIB668(IBXPD) ;Clean up Files & Fields that weren't deleted during the IB*668 pre-install.
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D DELFILES ; delete files
 D DFLDS    ; delete fields
 Q
 ;
DELFILES ; Delete files and sub-files.
 D BMES^XPDUTL("Checking for SSVI Related Files and Sub-files for possible deletion.")
 ;
 N DIC,DO,FILE,FOUND,SUBFILE
 ; According to the Developer Guide, you can use a file # or global root to delete the file
 ; This module of code will delete the following Files and their related Sub-files:
 S FOUND=0
 ; 
 ; IB SSVI PIN/HL7 PIVOT File #366 and it's related sub-files #366.04 and #366.05
 S FILE=366
 S DIC="^IBCN(366," D DO^DIC1  ; ICR # 10007
 I $P(DO,"^")="IB SSVI PIN/HL7 PIVOT" D DFILE(FILE)
 K DIC,DO
 ;
 ;IB INSURANCE INCONSISTENT DATA File #366.1 and it's related sub-file #366.16
 S FILE=366.1
 S DIC="^IBCN(366.1," D DO^DIC1
 I $P(DO,"^")="IB INSURANCE INCONSISTENT DATA" D DFILE(FILE)
 K DIC,DO
 ;
 ;IB INSURANCE CONSISTENCY ELEMENTS File #366.2 and it's related sub-file #366.21
 S FILE=366.2
 S DIC="^IBCN(366.2," D DO^DIC1
 I $P(DO,"^")="IB INSURANCE CONSISTENCY ELEMENTS" D DFILE(FILE)
 ;I $P(DO,"^")="IB INSURANCE INCONSISTENCY ELEMENTS" D DFILE(FILE)
 K DIC,DO
 ;
 I FOUND D BMES^XPDUTL("SSVI Related Files and Sub-files Deleted.")
 I 'FOUND D BMES^XPDUTL("No SSVI Related Files and Sub-files were deleted.")
 Q
 ;
DFILE(FILE)   ;Delete a File
 N DIU
 S FOUND=1
 S DIU=FILE,DIU(0)="D"  ; "D"elete the data dictionary along with it's data.
 D EN^DIU2
 K DIU
 D BMES^XPDUTL("    ....Deleted File #"_FILE_" it's data and related sub-files")
 Q
 ;
DFLDS ; Delete fields and data when needed.
 D BMES^XPDUTL("Checking for IB Site Parameter File (#350.9) SSVI Fields for possible deletion.")
 ;
 N DA,DIC,DIK,DO,FLD,FLD100,FLD101,FLD102,FLD103,FLDNO,FOUND
 ; This module of code deletes the data and the definitions
 ; for the following fields in the IB SITE PARAMETERS File (#350.9):
 ;   -  Field # 100 IB SSVI DISABLE/ENABLE
 ;   -  Field # 101 IB SSVI LAST INS DATE XFER
 ;   -  Field # 102 IB CURRENT PIVOT ENTRY HL7
 ;   -  Field # 103 IB PIVOT FILE DAYS TO RETAIN
 ;
 ; Delete the data.
 S (FLD100,FLD101,FLD102,FLD103,FOUND)=0
 ;
 S DA=0 F  S DA=$O(^IBE(350.9,DA)) Q:'DA  D
 . N DIE,DR,FNAME
 . F FLDNO=100,101,102,103 D
 . . D FIELD^DID(350.9,FLDNO,,"LABEL","FNAME")  ;ICR # 2052
 . . S FLD="FLD"_FLDNO
 . . I FLDNO=100 I $G(FNAME("LABEL"))="IB SSVI DISABLE/ENABLE" S @FLD=1
 . . I FLDNO=101 I $G(FNAME("LABEL"))="IB SSVI LAST INS DATE XFER" S @FLD=1
 . . ;I FLDNO=102 I $G(FNAME("LABEL"))="IB CURRENT PIVOT ENTRY HL7" S @FLD=1
 . . I FLDNO=102 I $G(FNAME("LABEL"))="IB CURRENT PIVOT ENTRY" S @FLD=1
 . . I FLDNO=103 I $G(FNAME("LABEL"))="IB PIVOT FILE DAYS TO RETAIN" S @FLD=1
 . . K FNAME
 . . I @FLD=1 D
 . . . S FOUND=1
 . . . S DR=FLDNO_"////@",DIE="^IBE(350.9," D ^DIE
 . . . D BMES^XPDUTL("    ....Deleted Data for Field (#350.9,"_FLDNO_").")
 ;
 ; Delete the field definitions.
 F FLDNO=100,101,102,103 D
 . S FLD="FLD"_FLDNO
 . I @FLD=1 D
 . . K DA
 . . S DIK="^DD(350.9,",DA=FLDNO,DA(1)=350.9 D ^DIK
 . . D BMES^XPDUTL("    .......Deleted Definition for Field (#350.9,"_FLDNO_").")
 ;
 I FOUND D BMES^XPDUTL("IB Site Parameter File (#350.9) SSVI Fields Deleted.")
 I 'FOUND D BMES^XPDUTL("No IB Site Parameter File (#350.9) SSVI Fields were deleted.")
 Q
 ;
FILESEC(IBXPD) ;Update File Security on INTERFACILITY INSURANCE UPDATE file (#365.19)
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Updating file security on the INTERFACILITY INSURANCE UPDATE (#365.19) file ... ")
 N CODES,ERROR
 ;
 S CODES("AUDIT")="@"
 S CODES("DD")="@"
 S CODES("DEL")="@"
 S CODES("LAYGO")="@"
 S CODES("WR")="@"
 ;
 D FILESEC^DDMOD(365.19,.CODES,"ERROR")
 ;
 I $D(ERROR) D MES^XPDUTL("File security was NOT updated.") G FILESECQ
 ;
 D MES^XPDUTL("File security has been updated.")
FILESECQ ;
 Q
 ;
SITEREG(IBXPD,SITENUM) ; send site registration message to FSC
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Send eIV site registration message to FSC ... ")
 ;
 I '$$PROD^XUPROD(1) D MES^XPDUTL("N/A - Not a production account - No site registration message sent") G SITEREGQ
 I SITENUM=358 D MES^XPDUTL("Current Site is MANILA - NO eIV site registration message sent") G SITEREGQ
 D ^IBCNEHLM
 D MES^XPDUTL("eIV site registration message was successfully sent")
 ;
SITEREGQ ;
 Q
