IBY348PO ;ALB/ESG - Post-Installation for IB patch 348 ;13-Sep-2006
 ;;2.0;INTEGRATED BILLING;**348**;21-MAR-94;Build 5
 ;
 ;
EN ;
 N XPDIDTOT S XPDIDTOT=6
 D SSN          ; 1. remove force print SSN fields
 D PARA         ; 2. remove the default form type field
 D DIC          ; 3. update some file descriptions
 D RIT          ; 4. Recompile Input Templates
 D TAB          ; 5. reset the 1500 claim form address column
 D LID          ; 6. set default value for CMS-1500 PRINT LEGACY ID site parameter
EX ;
 Q
 ;
SSN ; Remove 2 force print SSN fields from the insurance company file
 NEW DIK,DA,IEN,DATA
 D BMES^XPDUTL(" STEP 1 of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Removing force print SSN fields from file 36 ....")
 ;
 ; remove the fields from the data dictionary
 S DIK="^DD(36,",DA=3.11,DA(1)=36 D ^DIK
 S DIK="^DD(36,",DA=3.12,DA(1)=36 D ^DIK
 ;
 ; remove the data from the file
 S IEN=0
 F  S IEN=$O(^DIC(36,IEN)) Q:'IEN  D
 . S DATA=$G(^DIC(36,IEN,3))                            ; 3 node
 . I $P(DATA,U,11)'="" S $P(^DIC(36,IEN,3),U,11)=""
 . I $P(DATA,U,12)'="" S $P(^DIC(36,IEN,3),U,12)=""
 . Q
 ;
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(1)
 Q
 ;
PARA ; remove the default form type field from the IB site parameter file.
 ; this field is obsolete because it was used to convert from the UB-82
 ; to the UB-92.  It always had to be a UB form type and now there is
 ; only 1 UB form type.
 NEW DIK,DA
 D BMES^XPDUTL(" STEP 2 of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Removing default form type field from file 350.9 ....")
 ;
 ; remove the field from the data dictionary
 S DIK="^DD(350.9,",DA=1.26,DA(1)=350.9 D ^DIK
 ;
 ; remove the data from the file
 S $P(^IBE(350.9,1,1),U,26)=""
 ;
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(2)
PARAX ;
 Q
 ;
DIC ; update some file descriptions with CMS-1500
 NEW HCFA,CMS,FILE,Z,TEXT,NEWTEXT
 D BMES^XPDUTL(" STEP 3 of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Updating file descriptions for the CMS-1500 ....")
 ;
 S HCFA="HCFA 1500",CMS="CMS-1500"
 F FILE=353.1,353.2 S Z=0 F  S Z=$O(^DIC(FILE,"%D",Z)) Q:'Z  D
 . S TEXT=$G(^DIC(FILE,"%D",Z,0)) Q:TEXT'[HCFA
 . S NEWTEXT=$P(TEXT,HCFA,1)_CMS_$P(TEXT,HCFA,2)
 . S ^DIC(FILE,"%D",Z,0)=NEWTEXT
 . Q
 ;
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(3)
DICX ;
 Q
 ;
RIT ; Recompile input templates for billing screens
 NEW X,Y,DMAX
 D BMES^XPDUTL(" STEP 4 of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Recompiling Input Templates for Billing Screens 3, 6 & 7....")
 S X="IBXSC3",Y=$$FIND1^DIC(.402,,"X","IB SCREEN3","B"),DMAX=8000
 I Y D EN^DIEZ
 S X="IBXSC6",Y=$$FIND1^DIC(.402,,"X","IB SCREEN6","B"),DMAX=8000
 I Y D EN^DIEZ
 S X="IBXSC7",Y=$$FIND1^DIC(.402,,"X","IB SCREEN7","B"),DMAX=8000
 I Y D EN^DIEZ
RITX ;
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(4)
 Q
 ;
TAB ; reset the CMS-1500 ADDRESS COLUMN field in the IB site parameter file.
 ; The new 1500 form has pre-printed information covering the first
 ; 26 columns over lines 1-6 where the payer name and address goes.
 ; If the column number in the parameter file is less than 28, change
 ; it to be 28.
 D BMES^XPDUTL(" STEP 5 of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Validating the CMS-1500 Address Column Value....")
 ;
 N COL,DIE,DA,DR
 S COL=$P($G(^IBE(350.9,1,1)),U,27)
 I COL<28 S DIE=350.9,DA=1,DR="1.27///28" D ^DIE
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(5)
TABX ;
 Q
LID ; set default value for CMS-1500 PRINT LEGACY ID site parameter
 ; This site parameter should default to "YES" (always print legacy id)
 D BMES^XPDUTL(" STEP 6 of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Setting default value for CMS-1500 PRINT LEGACY ID site parameter....")
 I $P($G(^IBE(350.9,1,1)),U,32)="" S DIE=350.9,DA=1,DR="1.32///YES" D ^DIE
LIDX ;
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(6)
 Q
 ;
