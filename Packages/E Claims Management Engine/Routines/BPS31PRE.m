BPS31PRE ;AITC/MRD - Pre-install routine for BPS*1*31 ;09/30/2021
 ;;1.0;E CLAIMS MGMT ENGINE;**31**;JUN 2004;Build 16
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; MCCF EDI TAS ePharmacy - BPS*1*31 patch pre-install
 ;
 Q
 ;
PRE ; Entry Point for pre-install
 ;
 D MES^XPDUTL("  Starting pre-install for BPS*1*31")
 ;
 ; Update Reject Code explanations in file #9002313.93.
 ;
 D REJECT
 ;
 ; Update codes in BPS NCPDP BENEFIT STAGE INDICATOR file #9002313.35
 ;
 D BSI
 ;
 D MES^XPDUTL("  Finished pre-install of BPS*1*31")
 ;
 Q
 ;
REJECT ; Update Reject Codes with new explanations.
 N CNT,DA,DIE,DR,LINE,DATA,NUM,NAME,X
 D MES^XPDUTL("   - Updating BPS NCPDP REJECT CODES")
 S CNT=0
 F LINE=1:1 S DATA=$P($T(URJCT+LINE),";;",2,99) Q:DATA=""  D
 . S NUM=$P(DATA,";",1)
 . S NAME=$P(DATA,";",2)
 . S DIE=9002313.93
 . S DA=$O(^BPSF(DIE,"B",NUM,""))
 . I 'DA D MES^XPDUTL("     - No IEN found for entry "_NUM) Q
 . S DR=".02////^S X=NAME"
 . D ^DIE
 . S CNT=CNT+1
 . Q
 D MES^XPDUTL("     - "_CNT_" entries updated")
 D MES^XPDUTL("   - Done with BPS NCPDP REJECT CODES")
 D MES^XPDUTL(" ")
 Q
 ;
BSI ; Update Benefit Stage Indicator codes.
 N CNT,CODENEW,CODEOLD,DA,DATE,DIE,DR,LINE
 D MES^XPDUTL("   - Updating file BPS NCPDP BENEFIT STAGE INDICATOR")
 S CNT=0
 F LINE=1:1 S DATA=$P($T(BSICODES+LINE),";;",2,99) Q:DATA=""  D
 . S CODEOLD=$P(DATA,";",1)
 . S CODENEW=$P(DATA,";",2)
 . S DIE=9002313.35
 . S DA=$O(^BPS(DIE,"B",CODEOLD,""))
 . I 'DA D MES^XPDUTL("     - No IEN found for code "_CODEOLD) Q
 . S DR=".01////^S X=CODENEW"
 . D ^DIE
 . S CNT=CNT+1
 . Q
 D MES^XPDUTL("     - "_CNT_" entries updated")
 D MES^XPDUTL("   - Done with file BPS NCPDP BENEFIT STAGE INDICATOR")
 D MES^XPDUTL(" ")
 Q
 ;
BSICODES ; Fields to be updated
 ;;1;01
 ;;2;02
 ;;3;03
 ;;4;04
 ;;
 ;
URJCT ; Updated reject explanation
 ;;500;Patient ID Count Does Not Precede Patient ID Data Fields
 ;;837;Facility ID Qualifier Value Not Supported
 ;;840;Original Manufacturer Product ID Qualifier Value Not Supported
 ;;881;M/I Submission Type Code Count
 ;;981;DOS for Remaining Fill Portion Exceeds Regulatory Time for Dispensing
 ;;RR;M/I Patient ID Count
 ;;TH;Patient ID Count Does Not Match Number Of Repetitions
 ;;
 ;
