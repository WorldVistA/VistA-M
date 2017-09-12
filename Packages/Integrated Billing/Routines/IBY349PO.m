IBY349PO ;ALB/ESG - Post-Installation for IB patch 349 ;27-Nov-2006
 ;;2.0;INTEGRATED BILLING;**349**;21-MAR-94;Build 46
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
EN ;
 N XPDIDTOT S XPDIDTOT=4
 D LID          ; 1. set default value for UB PRINT LEGACY ID parameter
 D PARA         ; 2. remove the PRINT '001' FOR TOTAL CHARGES? field
 D RIT          ; 3. recompile some billing screen input templates
 D DIC          ; 4. update some file descriptions
EX ;
 Q
 ;
LID ; set default value for UB PRINT LEGACY ID site parameter
 ; This site parameter should default to "YES" (always print legacy id)
 NEW DIE,DA,DR
 D BMES^XPDUTL(" STEP 1 of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Setting default value for UB PRINT LEGACY ID site parameter...")
 I $P($G(^IBE(350.9,1,1)),U,33)="" S DIE=350.9,DA=1,DR="1.33///YES" D ^DIE
LIDX ;
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(1)
 Q
 ;
PARA ; remove the PRINT '001' FOR TOTAL CHARGES? field from the IB site
 ; parameters file.  This field is obsolete.
 NEW DIK,DA
 D BMES^XPDUTL(" STEP 2 of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Removing '001' for Total field from file 350.9 ....")
 ;
 ; remove the field from the data dictionary
 S DIK="^DD(350.9,",DA=1.1,DA(1)=350.9 D ^DIK
 ;
 ; remove the data from the file
 S $P(^IBE(350.9,1,1),U,10)=""
 ;
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(2)
PARAX ;
 Q
 ;
RIT ; Recompile input templates for billing screens
 NEW X,Y,DMAX
 D BMES^XPDUTL(" STEP 3 of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Recompiling Input Templates for Billing Screens 6, 7 & 8....")
 S X="IBXSC6",Y=$$FIND1^DIC(.402,,"X","IB SCREEN6","B"),DMAX=8000
 I Y D EN^DIEZ
 S X="IBXSC7",Y=$$FIND1^DIC(.402,,"X","IB SCREEN7","B"),DMAX=8000
 I Y D EN^DIEZ
 S X="IBXSC82",Y=$$FIND1^DIC(.402,,"X","IB SCREEN82","B"),DMAX=8000
 I Y D EN^DIEZ
RITX ;
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(3)
 Q
 ;
DIC ; update some file descriptions with UB-04
 NEW UB82,UB04,FILE,Z,TEXT,NEWTEXT
 D BMES^XPDUTL(" STEP 4 of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Updating file descriptions for the UB-04 ....")
 ;
 S UB82="UB-82",UB04="UB-04"
 F FILE=353 S Z=0 F  S Z=$O(^DIC(FILE,"%D",Z)) Q:'Z  D
 . S TEXT=$G(^DIC(FILE,"%D",Z,0)) Q:TEXT'[UB82
 . S NEWTEXT=$P(TEXT,UB82,1)_UB04_$P(TEXT,UB82,2)
 . S ^DIC(FILE,"%D",Z,0)=NEWTEXT
 . Q
 ;
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(4)
DICX ;
 Q
