IBY668PR ;AITC/VD - PRE-Installation for IB patch 668; JUL 9, 2020
 ;;2.0;INTEGRATED BILLING;**668**;MAR 21,1994;Build 28
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; ICR #10013 for the usage of ^DIK.
 ; ICR #10014 for the usage of EN^DIU2
 ; ICR #10141 for the usage of ^XPDUTL.
 Q
 ;
PREINS ; preinstall tag
 ;
 N INSTALLED,XPDIDTOT
 S INSTALLED=$$PATCH^XPDUTL("IB*2.0*668")
 S XPDIDTOT=2
 ;
 D BMES^XPDUTL("    IB*2.0*668 Pre-Install starts .....")
 ;
 D DELFILES(1)
 ;
 D DFLDS(2)  ; delete fields
 ;
 D BMES^XPDUTL("    IB*2.0*668 Pre-Install is complete.")
 Q
 ;
DELFILES(IBXPD) ; Delete files and sub-files
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D BMES^XPDUTL("Deleting SSVI Related Files and Sub-files.")
 ;
 ; if the patch was installed previously - skip deleting files and sub-files
 I INSTALLED D  Q
 . D BMES^XPDUTL("    Patch IB*2.0*668 has been previously installed...")
 . D MES^XPDUTL("    ...Skipping the deletion of files & sub-files.") Q
 ;
 N FILE,SUBFILE
 ; According to the Developer Guide, you can use a file # or global root to delete the file
 ; This module of code will delete the following Files and their related Sub-files:
 ; 
 ; IB SSVI PIN/HL7 PIVOT File #366 and it's related sub-files #366.04 and #366.05
 S FILE=366
 D DFILE(FILE)
 ;
 ;IB INSURANCE INCONSISTENT DATA File #366.1 and it's related sub-file #366.16
 S FILE=366.1
 D DFILE(FILE)
 ;
 ;IB INSURANCE INCONSISTENCY ELEMENTS File #366.2 and it's related sub-file #366.21
 S FILE=366.2
 D DFILE(FILE)
 ;
 D BMES^XPDUTL("SSVI Related Files and Sub-files Deleted.")
 Q
 ;
DFILE(FILE)   ;Delete a File
 N DIU
 S DIU=FILE,DIU(0)="D"  ; "D"elete the data dictionary along with it's data.
 D EN^DIU2
 K DIU
 D BMES^XPDUTL("    ....Deleted File #"_FILE_" it's data and related sub-files")
 Q
 ;
DFLDS(IBXPD) ; Delete fields and data when needed.
 ;
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D BMES^XPDUTL("Deleting IB Site Parameter File (#350.9) SSVI Fields.")
 ;
 ; if the patch was installed previously - skip deleting files and sub-files
 N DA,DIK,FLDNO
 ; This module of code deletes the data and the definitions
 ; for the following fields in the IB SITE PARAMETERS File (#350.9):
 ;   -  Field # 100 IB SSVI DISABLE/ENABLE
 ;   -  Field # 101 IB SSVI LAST INS DATE XFER
 ;   -  Field # 102 IB CURRENT PIVOT ENTRY
 ;   -  Field # 103 IB PIVOT FILE DAYS TO RETAIN
 ;
 I INSTALLED D  Q
 . D BMES^XPDUTL("    Patch IB*2.0*668 has been previously installed...")
 . D MES^XPDUTL("    ...Skipping the deletion of the IB Site Parameter fields.") Q
 ;
 ; Delete the data.
 S DA=0 F  S DA=$O(^IBE(350.9,DA)) Q:'DA  D
 . N DIE,DR
 . F FLDNO=100,101,102,103 D
 . . S DR=FLDNO_"////@",DIE="^IBE(350.9," D ^DIE
 . . D BMES^XPDUTL("    ....Deleted Data for Field (#350.9,"_FLDNO_").")
 ;
 ; Delete the field definitions.
 F FLDNO=100,101,102,103 D
 . K DA
 . S DIK="^DD(350.9,",DA=FLDNO,DA(1)=350.9 D ^DIK
 . D BMES^XPDUTL("    .......Deleted Definition for Field (#350.9,"_FLDNO_").")
 D BMES^XPDUTL("IB Site Parameter File (#350.9) SSVI Fields Deleted.")
 Q
 ;
 ;========================================================
POST ; Post install routine
 ;
 N IBXPD,PRODENV,SITE,SITENAME,SITENUM,XPDIDTOT
 S XPDIDTOT=4
 S SITE=$$SITE^VASITE,SITENAME=$P(SITE,U,2),SITENUM=$P(SITE,U,3)
 ;
 S PRODENV=$$PROD^XUPROD(1)   ; 1=Production Environment, 0=Test Environment
 D BMES^XPDUTL("    IB*2.0*668 Post-Install starts .....")
 ;
 D IIVTOEIV(1)
 ;
 D CONVERT(2)
 ;
 D STATUPD(3)
 ;
 D ADDSOI(4)
 ;
 D BMES^XPDUTL("    IB*2.0*668 Post-Install is complete.")
 Q
 ;
IIVTOEIV(IBXPD) ; Change Payer Application entry from IIV to EIV
 N DA,DIE,DR
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D BMES^XPDUTL("Changing name of application in the Payer Application file (#365.13)")
 S DIE=365.13,DA=$$FIND1^DIC(365.13,,,"IIV")
 I 'DA D BMES^XPDUTL("    IIV not found in Payer Application File.") Q
 S DR=".01////EIV" D ^DIE
 D BMES^XPDUTL("Name of Payer Application successfully changed from IIV to EIV.")
 Q
 ;
CONVERT(IBXPD) ;
 ;This will file the following data into the new locations in PAYER file (#365.12):
 ; *** For the EIV application only 
 ; #365.121,.11 -> #365.12,.07
 ; #365.121,.12 -> #365.12,.08
 ; #365.121,.07 -> #365.121,4.01
 ; #365.121,.08 -> #365.121,4.02
 ; #365.121,.14 -> #365.121,4.03
 ; #365.121,.15 -> #365.121,4.04
 ;
 N APPIEN,ARRAY,EIVIEN,FDA,IENS,IENS1,MSG,PIEN,SKIPPED,TOTAL
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D BMES^XPDUTL("Copying data to new locations within the PAYER file (#365.12)")
 ;
 S EIVIEN=$$FIND1^DIC(365.13,,"X","EIV","B")
 S (PIEN,SKIPPED,TOTAL)=0
 F  S PIEN=$O(^IBE(365.12,PIEN)) Q:'PIEN  D
 . S APPIEN=0
 . F  S APPIEN=$O(^IBE(365.12,PIEN,1,APPIEN)) Q:'APPIEN  D
 .. K ARRAY
 .. S IENS=APPIEN_","_PIEN_","
 .. D GETS^DIQ(365.121,IENS,".01;.07;.08;.11;.12;.14;.15","I","ARRAY")
 .. I ARRAY(365.121,IENS,.01,"I")'=EIVIEN Q   ; Not the EIV application
 .. S TOTAL=TOTAL+1
 .. S IENS1=PIEN_","
 .. I $$UPDATED(PIEN,IENS,IENS1) S SKIPPED=SKIPPED+1 Q  ;Already updated
 .. S FDA(365.12,IENS1,.07)=ARRAY(365.121,IENS,.11,"I")
 .. S FDA(365.12,IENS1,.08)=ARRAY(365.121,IENS,.12,"I")
 .. S FDA(365.121,IENS,4.01)=ARRAY(365.121,IENS,.07,"I")
 .. S FDA(365.121,IENS,4.02)=ARRAY(365.121,IENS,.08,"I")
 .. S FDA(365.121,IENS,4.03)=ARRAY(365.121,IENS,.14,"I")
 .. S FDA(365.121,IENS,4.04)=ARRAY(365.121,IENS,.15,"I")
 .. D FILE^DIE("","FDA","ERROR")
 I 'SKIPPED S MSG="Data successfully copied to the new locations." G XCONVERT
 I SKIPPED=TOTAL S MSG="Data was previously copied to the new locations, due to a prior install." G XCONVERT
 S MSG=(TOTAL-SKIPPED)_" payers had their data copied. "_SKIPPED_" payers were skipped due to a prior install."
XCONVERT ;
 D BMES^XPDUTL(MSG)
 Q
 ;
UPDATED(PIEN,IENS,IENS1) ; Was this payer record already converted (fields moved)
 N ARRAY1,FOUND
 S FOUND=0
 D GETS^DIQ(365.121,IENS,"4.01;4.02;4.03;4.04","I","ARRAY1")
 I $G(ARRAY1(365.121,IENS,4.01,"I"))'="" S FOUND=1 G UPDTX
 I $G(ARRAY1(365.121,IENS,4.02,"I"))'="" S FOUND=1 G UPDTX
 I $G(ARRAY1(365.121,IENS,4.03,"I"))'="" S FOUND=1 G UPDTX
 I $G(ARRAY1(365.121,IENS,4.04,"I"))'="" S FOUND=1 G UPDTX
 D GETS^DIQ(365.12,IENS1,".07;.08","I","ARRAY1")
 I $G(ARRAY1(365.12,IENS1,.07,"I"))'="" S FOUND=1 G UPDTX
 I $G(ARRAY1(365.12,IENS1,.08,"I"))'="" S FOUND=1 G UPDTX
UPDTX ;
 Q FOUND
 ;
STATUPD(IBXPD) ; Update the DESCRIPTION and CORRECTIVE ACTION fields of IIV STATUS TABLE FILE (#365.15)
 ;
 N FIELD,FILE,IENS,TEXT
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D BMES^XPDUTL("Updating Status description in the IIV STATUS TABLE file (#365.15)")
 ;
 S FILE=365.15
 ;Update DESCRIPTION of status B5
 ;
 S FIELD=1
 S IENS=$$FIND1^DIC(365.15,,,"B5")_","
 S TEXT(1)="eIV could not create an inquiry for this entry.  The payer is not"
 S TEXT(2)="nationally enabled for eIV."
 D WP^DIE(FILE,IENS,FIELD,,"TEXT","ERROR")
 ;
 ;Update DESCRIPTION for status B6
 S IENS=$$FIND1^DIC(365.15,,,"B6")_","
 S TEXT(1)="eIV could not create an inquiry for this entry.  The payer is not locally"
 S TEXT(2)="enabled for eIV."
 D WP^DIE(FILE,IENS,FIELD,,"TEXT","ERROR")
 ;
 ;Update CORRECTIVE ACTION for status B6
 S FIELD=2
 S TEXT(1)="Action to take:  Either use the option ""Payer Edit"" to locally enable this"
 S TEXT(2)="payer or contact the insurance company to manually verify this insurance"
 S TEXT(3)="information."
 D WP^DIE(FILE,IENS,FIELD,,"TEXT","ERROR")
 ;
 D BMES^XPDUTL("Status Description successfully updated.")
 Q
 ;
ADDSOI(IBXPD) ; Add 'ADV MED COST MGMT SOLUTION' to the SOI file.
 N DA,DIK,IBCNT,IBERR,IBIEN,NEWSOI,OLDSOI
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D BMES^XPDUTL("Adding 'ADV MED COST MGMT SOLUTION' as a new Source of Information")
 D MES^XPDUTL("in the Source of Information File (#355.12) ... ")
 ;
 S NEWSOI(.01)=22,NEWSOI(.02)="ADV MED COST MGMT SOLUTION",NEWSOI(.03)="AMCMS"
 ;
 S IBCNT=22
 I $D(^IBE(355.12,IBCNT)) D  Q   ; An SOI already exists in record #22.
 . N PCCNT
 . F PCCNT=.01:.01:.03 S OLDSOI(PCCNT)=$$GET1^DIQ(355.12,IBCNT,PCCNT,"I")
 . ;
 . I OLDSOI(.02)="ADV MED COST MGMT SOLUTION",OLDSOI(.03)="AMCMS" D  Q  ;'AMCMS' already exists.
 . . D BMES^XPDUTL("ADV MED COST MGMT SOLUTION (AMCMS) entry was not installed.")
 . . D MES^XPDUTL("It already exists in the Source Of Information file (#355.12).")
 . ;
 . ; Delete pre-existing SOI record #22 because it is not the AMCMS SOI.
 . S DA=IBCNT S DIK="^IBE(355.12," D ^DIK
 . S IBIEN=$$ADD^IBDFDBS(355.12,,.NEWSOI,.IBERR,IBCNT)
 . I IBERR D  Q
 . . D BMES^XPDUTL("*** ERROR ADDING "_NEWSOI(.02)_" CODE TO THE SOURCE OF INFORMATION TABLE (#355.12) - Log a Service Ticket! ***")
 . D BMES^XPDUTL("Replaced record #22 ("_OLDSOI(.03)_") - "_OLDSOI(.02)_" with the new")
 . D MES^XPDUTL("ADV MED COST MGMT SOLUTION (AMCMS) entry in the Source Of Information file")
 . D MES^XPDUTL("(#355.12).")
 . ;
 . I PRODENV D   ; Send an email to the eInsurance Rapid Response Team.
 . . N MSG,SUBJ,XMINSTR,XMTO
 . . S SUBJ="IB*2*668 - AMCMS replaces existing SOI #"_$P(SITE,U,3)_" "_$P(SITE,U,2)
 . . S SUBJ=$E(SUBJ,1,65)
 . . S MSG(1)="On "_$$FMTE^XLFDT($$NOW^XLFDT)_" at Site # "_SITENUM_" - "_SITENAME_","
 . . S MSG(2)="the installation of patch IB*2.0*668 added the new AMCMS - ADV"
 . . S MSG(3)="MED COST MGMT SOLUTION entry to the Source Of Information file"
 . . S MSG(4)="(#355.12) by removing the non-standardized entry #22 for"
 . . S MSG(5)=OLDSOI(.03)_" - "_OLDSOI(.02)_"."
 . . S MSG(6)=""
 . . S XMTO("VHAeInsuranceRapidResponse@domain.ext")=""
 . . ;
 . . S XMINSTR("FROM")="VistA-eInsurance"
 . . D SENDMSG^XMXAPI(DUZ,SUBJ,"MSG",.XMTO,.XMINSTR)
 ;
 S IBIEN=$$ADD^IBDFDBS(355.12,,.NEWSOI,.IBERR,IBCNT)
 I IBERR D  Q
 . D BMES^XPDUTL("*** ERROR ADDING "_NEWSOI(.02)_" CODE TO THE SOURCE OF INFORMATION TABLE (#355.12) - Log a Service Ticket! ***")
 D BMES^XPDUTL("Source of Information: ADV MED COST MGMT SOLUTION added successfully")
 Q
 ;
