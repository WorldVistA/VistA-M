BPS27PRE ;AITC/PD/CKB - Pre-install for BPS*1.0*27 ;10/08/2019
 ;;1.0;E CLAIMS MGMT ENGINE;**27**;JUN 2004;Build 15
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; MCCF EDI TAS ePharmacy - BPS*1*27 patch pre-install
 ;
 Q
 ;
EN ; Pre-install functions are coded here.
 ;
 D MES^XPDUTL("  Starting pre-install of BPS*1.0*27")
 D MES^XPDUTL(" ")
 ;
 ; Update descriptions in BPS NCPDP FIELD DEFS file #9002313.91.
 ;
 D FIELDS
 ;
 ; Update fields .02 and .03 in BPS NCPDP PATIENT RESIDENCE CODE.
 ;
 D PTRES
 ;
 ; Update Reject Code explanation in file #9002313.93.
 ;
 D REJECT
 ;
 ; Update Submission Clarification Code description in file #9002313.25.
 ;
 D SCC
 ;
 D MES^XPDUTL("  Finished pre-install of BPS*1.0*27")
 ;
 Q
 ;
FIELDS ; Update Fields Defs with new descriptions
 N CNT,DA,DATA,DIE,DR,LINE,NAME,NUM,STDNAME
 D MES^XPDUTL("    - Updating BPS NCPDP FIELD DEFS")
 S CNT=0
 F LINE=1:1 S DATA=$P($T(NFLDS+LINE),";;",2,99) Q:DATA=""  D
 . S NUM=$P(DATA,";",1)
 . S DIE=9002313.91
 . S DA=$O(^BPSF(DIE,"B",NUM,""))
 . I 'DA D MES^XPDUTL("      - No IEN found for entry "_NUM_",field: "_NAME) Q
 . S CNT=CNT+1
 . S NAME=$P(DATA,";",2)
 . S STDNAME=$P(DATA,";",3)
 . S DR=".03////"_NAME_";1.01////"_STDNAME
 . D ^DIE
 D MES^XPDUTL("      - "_CNT_" entries updated")
 D MES^XPDUTL("    - Done with BPS NCPDP FIELD DEFS")
 D MES^XPDUTL(" ")
 Q
 ;
NFLDS ; Updated Fields
 ;;546;REJECT FIELD OCCURRENCE INDCTR;REJECT FIELD OCCURRENCE INDICATOR
 ;;
 ;
PTRES ;
 ; Update Patient Residence Codes with new explanations
 N BRIEF,CNT,DA,DATA,DIE,DR,FULL,LINE,NUM
 D MES^XPDUTL("    - Updating BPS NCPDP PATIENT RESIDENCE CODE")
 S CNT=0
 F LINE=1:1 S DATA=$P($T(PTRES1+LINE),";;",2,99) Q:DATA=""  D
 . S NUM=$P(DATA,";",1)
 . S DIE=9002313.27
 . S DA=$O(^BPS(DIE,"B",NUM,""))
 . I 'DA D MES^XPDUTL("      - No IEN found for entry "_NUM) Q
 . S CNT=CNT+1
 . S BRIEF=$P(DATA,";",2)
 . S FULL=$P(DATA,";",3)
 . S DR=".02////"_BRIEF_";.03///"_FULL
 . D ^DIE
 D MES^XPDUTL("      - "_CNT_" entries updated")
 D MES^XPDUTL("    - Done with BPS NCPDP PATIENT RESIDENCE CODE")
 D MES^XPDUTL(" ")
 Q
 ;
PTRES1 ; Updated Patient Residence explanations
 ;;15;PRISON/CORRECTIONAL FACILITY;Prison/Correctional Facility
 ;;
 ;
REJECT ;
 ; Update Reject Codes with new explanation
 N CNT,DA,DATA,DIE,DR,LINE,NAME,NUM
 D MES^XPDUTL("    - Updating BPS NCPDP REJECT CODES")
 S CNT=0
 F LINE=1:1 S DATA=$P($T(URJCT+LINE),";;",2,99) Q:DATA=""  D
 . S NUM=$P(DATA,";",1)
 . S DIE=9002313.93
 . S DA=$O(^BPSF(DIE,"B",NUM,""))
 . I 'DA D MES^XPDUTL("      - No IEN found for entry "_NUM) Q
 . S CNT=CNT+1
 . S NAME=$P(DATA,";",2)
 . S DR=".02////"_NAME
 . D ^DIE
 D MES^XPDUTL("      - "_CNT_" entries updated")
 D MES^XPDUTL("    - Done with BPS NCPDP REJECT CODES")
 D MES^XPDUTL(" ")
 Q
 ;
URJCT ; Updated reject explanation
 ;;650;DOS More Than 60 Days From CII Dt Rx Written for LTC/Terminally Ill Pt
 ;;
 ;
SCC ; Update Submission Clarification Code with new explanations
 N CNT,DA,DATA,DIE,DR,LINE,NAME,NUM
 D MES^XPDUTL("    - Updating BPS NCPDP CLARIFICATION CODES")
 S CNT=0
 F LINE=1:1 S DATA=$P($T(UPDSCC+LINE),";;",2,99) Q:DATA=""  D
 . S NUM=$P(DATA,";",1)
 . S DIE=9002313.25
 . S DA=$O(^BPS(DIE,"B",NUM,""))
 . I 'DA D MES^XPDUTL("      - No IEN found for entry "_NUM) Q
 . S CNT=CNT+1
 . S NAME=$P(DATA,";",2)
 . S DR=".02////"_NAME
 . D ^DIE
 D MES^XPDUTL("      - "_CNT_" entries updated")
 D MES^XPDUTL("    - Done with BPS NCPDP CLARIFICATION CODES")
 D MES^XPDUTL(" ")
 Q
 ;
UPDSCC ; Updated clarification code description
 ;;47;OTHER SHORTENED DAYS SUPPLY
 ;;
 ;
