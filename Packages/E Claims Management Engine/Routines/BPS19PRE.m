BPS19PRE ;ALB/DMB - Pre-install for BPS*1.0*19 ;10/21/2014
 ;;1.0;E CLAIMS MGMT ENGINE;**19**;JUN 2004;Build 18
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; NCPDP Continuous Maintenance Standards - BPS*1*19 patch pre-install
 ;
 Q
 ;
EN ; Entry Point for post-install
 D MES^XPDUTL("  Starting pre-install for BPS*1*19")
 ; Update the reject code description in BPS NCPDP REJECT CODES
 D REJECTS
 ; Update the field names for BPS NCPPD FIELD DEFS
 D FIELDS
 ;
EX ; exit point
 ;
 D MES^XPDUTL("  Finished pre-install of BPS*1*19")
 Q
 ;
REJECTS ;
 ; Update Reject Codes with new explanations
 N LINE,DATA,NUM,NAME,DA,DIE,DR,CNT
 D MES^XPDUTL("    - Updating BPS NCPDP REJECT CODES")
 S CNT=0
 F LINE=1:1 S DATA=$P($T(NRJCT+LINE),";;",2,99) Q:DATA=""  D
 . S DIE=9002313.93,NUM=$P(DATA,";",1)
 . S DA=$O(^BPSF(DIE,"B",NUM,""))
 . I 'DA Q     ; quit if no IEN found for entry
 . S NAME=$P(DATA,";",2),DR=".02////^S X=NAME",CNT=CNT+1
 . D ^DIE
 D MES^XPDUTL("      - "_CNT_" entries updated")
 D MES^XPDUTL("    - Done with BPS NCPDP REJECT CODES")
 D MES^XPDUTL(" ")
 Q
 ;
NRJCT ; New reject explanations
 ;;27;Product Identifier not FDA/NSDE Listed
 ;;30;Reversal request outside processor reversal window
 ;;31;No matching paid claim found for reversal request
 ;;43;Plan DB indicates the assoc DEA to submitted Prescriber ID is inactive
 ;;
FIELDS ;
 ; Update Field Defs with new descriptions
 N LINE,DATA,NUM,NAME,DA,DIE,DR,CNT
 D MES^XPDUTL("    - Updating BPS NCPDP FIELD DEFS")
 S CNT=0
 F LINE=1:1 S DATA=$P($T(NFLDS+LINE),";;",2,99) Q:DATA=""  D
 . S NUM=$P(DATA,";",1)
 . S DA=$O(^BPSF(9002313.91,"B",NUM,""))
 . I 'DA D MES^XPDUTL("      - No IEN found for entry "_NUM) Q
 . S DIE=9002313.91,NAME=$P(DATA,";",2),DR=".03////^S X=NAME",CNT=CNT+1
 . D ^DIE
 D MES^XPDUTL("      - "_CNT_" entries updated")
 D MES^XPDUTL("    - Done with BPS NCPDP FIELD DEFS")
 D MES^XPDUTL(" ")
 Q
 ;
NFLDS ; New field names
 ;;124;PAY TO ZIP/POSTAL ZONE
 ;;320;EMPLOYER TELEPHONE NUMBER
 ;;326;PATIENT TELEPHONE NUMBER
 ;;498.12;PRESCRIBER TELEPHONE NUMBER
 ;;550;HELP DESK TELEPHONE NUMBER
 ;;
