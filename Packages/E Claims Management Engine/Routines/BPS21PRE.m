BPS21PRE ;AITC/CKB - Pre-installroutine for BPS*1*21 ;2/21/2017
 ;;1.0;E CLAIMS MGMT ENGINE;**21**;JUN 2004;Build 28
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; MCCF EDI TAS ePharmacy Iteration 1 - BPS*1*21 patch pre-install
 Q
 ;
EN ; Entry Point for pre-install
 D MES^XPDUTL("  Starting pre-install for BPS*1*21")
 ;
 ; Update descriptions in the BPS NCPDP FIELD DEF file #9002313.91
 D FIELDS
 ;
 ; Update Reject codes in BPS NCPDP REJECT CODES file #9002313.93
 D REJECTS
 ;
EX ; Exit point
 D MES^XPDUTL("  Finished pre-install of BPS*1*21")
 Q
 ;
FIELDS ; Update Fields Defs with new descriptions
 N LINE,DATA,NUM,NAME,DA,DIE,DR,CNT
 D MES^XPDUTL(" - Updating BPS NCPDP FIELD DEFS")
 S CNT=0
 F LINE=1:1 S DATA=$P($T(NFLDS+LINE),";;",2,99)  Q:DATA=""  D
 . S DIE=9002313.91,NUM=$P(DATA,";",1)
 . S DA=$O(^BPSF(DIE,"B",NUM,""))
 . I 'DA D MES^XPDUTL("   - No IEN found for entry "_NUM) Q
 . S NAME=$P(DATA,";",2),DR=".03////^S X=NAME",CNT=CNT+1
 . D ^DIE
 D MES^XPDUTL("   - "_CNT_" entries updated")
 D MES^XPDUTL(" - Done with BPS NCPDP FIELD DEFS")
 D MES^XPDUTL(" ")
 Q
 ;
NFLDS ; Updated field names
 ;;409;INGREDIENT COST SUBMITTED
 ;;431;OTHER PAYER AMOUNT PAID
 ;;433;PATIENT PAID AMOUNT SUBMITTED
 ;;579;ASSOC RX/SERVICE PROV ID QUAL
 ;;580;ASSOC RX/SERVICE PROVIDER ID
 ;;581;ASSOC RX/SERVICE REF NUM QUAL
 ;;582;ASSOC RX/SERVICE FILL NUMBER
 ;
 ;
REJECTS ; Update Reject Codes with new explanations
 N LINE,DATA,NUM,NAME,DA,DIE,DR,CNT
 D MES^XPDUTL("    - Updating BPS NCPDP REJECT CODES")
 S CNT=0
 F LINE=1:1 S DATA=$P($T(NRJCT+LINE),";;",2,99) Q:DATA=""  D
 . S DIE=9002313.93,NUM=$P(DATA,";",1)
 . S DA=$O(^BPSF(DIE,"B",NUM,""))
 . I 'DA D MES^XPDUTL("   - No IEN found for entry "_NUM) Q
 . S NAME=$P(DATA,";",2),DR=".02////^S X=NAME",CNT=CNT+1
 . D ^DIE
 D MES^XPDUTL("      - "_CNT_" entries updated")
 D MES^XPDUTL("    - Done with BPS NCPDP REJECT CODES")
 D MES^XPDUTL(" ")
 Q
 ;
NRJCT ; Updated reject explanations
 ;;280;Prior Authorization ID Submitted is not used for this Transaction Code
 ;;EV;M/I Prior Authorization ID Submitted 
 ;;N7;Use Prior Authorization ID Provided During Transition Period
 ;;N8;Use Prior Authorization ID Provided For Emergency Fill
 ;;N9;Use Prior Authorization ID Provided For Level of Care Change
 ;;635;Employer Country Code Value Not Supported
 ;;637;Entity Country Code Value Not Supported
 ;;638;Facility Country Code Value Not Supported
 ;;639;Patient ID Associated Country Code Value Not Supported
 ;;640;Pay to Country Code Value Not Supported
