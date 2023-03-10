BPS28PRE ;AITC/CKB - Pre-install for BPS*1.0*28 ;04/28/2020
 ;;1.0;E CLAIMS MGMT ENGINE;**28**;JUN 2004;Build 22
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; MCCF EDI TAS ePharmacy - BPS*1*28 patch pre-install
 ;
 Q
 ;
EN ; Pre-install functions are coded here.
 ;
 D MES^XPDUTL(" Starting pre-install of BPS*1.0*28")
 ;
 ; Update descriptions in BPS NCPDP FIELD DEFS file #9002313.91
 D FIELDS
 ;
 D MES^XPDUTL(" Finished pre-install of BPS*1.0*28")
 Q
 ;
FIELDS ; Update Fields Defs with new descriptions
 N LINE,DATA,NUM,NAME,DA,DIE,DR,CNT
 D MES^XPDUTL("   - Updating BPS NCPDP FIELD DEFS")
 S CNT=0
 F LINE=1:1 S DATA=$P($T(UFLDS+LINE),";;",2,99) Q:DATA=""  D
 . S NUM=$P(DATA,";",1),NAME=$P(DATA,";",2)
 . S DIE=9002313.91
 . S DA=$O(^BPSF(DIE,"B",NUM,""))
 . I 'DA D MES^XPDUTL("     - No IEN found for entry "_NUM_",field: "_NAME) Q
 . S DR=".03////^S X=NAME",CNT=CNT+1
 . D ^DIE
 D MES^XPDUTL("     - "_CNT_" entries updated")
 D MES^XPDUTL("   - Done with BPS NCPDP FIELD DEFS")
 D MES^XPDUTL(" ")
 Q
 ;
UFLDS ; Fields to be updated
 ;;475;DUR/DUE CO-AGENT ID QUALIFIER
 ;;476;DUR/DUE CO-AGENT ID
 ;;544;DUR/DUE FREE TEXT MESSAGE
 ;;555;FRMULRY ALT ESTMTD PT COST SHR
 ;;
 ;
