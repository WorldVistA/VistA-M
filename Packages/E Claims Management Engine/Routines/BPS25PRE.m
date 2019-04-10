BPS25PRE ;AITC/CKB - Pre-install for BPS*1.0*25 ;10/10/2018
 ;;1.0;E CLAIMS MGMT ENGINE;**24**;;Build 4
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; MCCF EDI TAS ePharmacy - BPS*1*25 patch pre-install
 Q
 ;
EN ; Entry Point for pre-install
 D MES^XPDUTL(" Starting pre-install for BPS*1*25")
 ;
 ; Update Reject code explanation for file #9002313.93
 D REJECTS
 ;
EX ; Exit point
 D MES^XPDUTL(" Finished pre-install of BPS*1*25")
 Q
 ;
REJECTS ; Update Reject Code with new explanation
 N LINE,DATA,NUM,NAME,DA,DIE,DR,CNT
 D MES^XPDUTL("    - Updating BPS NCPDP REJECT CODES")
 S CNT=0
 F LINE=1:1 S DATA=$P($T(URJCT+LINE),";;",2,99) Q:DATA=""  D
 . S DIE=9002313.93,NUM=$P(DATA,";",1)
 . S DA=$O(^BPSF(DIE,"B",NUM,""))
 . I 'DA D MES^XPDUTL(" - No IEN found for entry "_NUM) Q
 . S NAME=$P(DATA,";",2),DR=".02////^S X=NAME",CNT=CNT+1
 . D ^DIE
 D MES^XPDUTL("      - "_CNT_" entries updated")
 D MES^XPDUTL("    - Done with BPS NCPDP REJECT CODES")
 D MES^XPDUTL(" ")
 Q
 ;
URJCT ; Updated reject explanation
 ;;559;ID Excluded Is Associated With A Sanctioned Pharmacy
 ;;
 ;
