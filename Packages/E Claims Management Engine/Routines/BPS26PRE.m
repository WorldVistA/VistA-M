BPS26PRE ;AITC/PD - Pre-install for BPS*1.0*26 ;11/12/2019
 ;;1.0;E CLAIMS MGMT ENGINE;**26**;;Build 24
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; MCCF EDI TAS ePharmacy - BPS*1*26 patch pre-install
 Q
 ;
PRE ; Pre-install functions are coded here.
 ;
 D MES^XPDUTL(" Starting pre-install of BPS*1.0*26")
 ;
 ; Update field .02 in BPS NCPDP REJECT CODES
 D REJECTS
 ;
 D MES^XPDUTL(" Finished pre-install of BPS*1.0*26")
 Q
 ;
REJECTS ;
 ; Update Reject Codes with new explanations
 N CNT,DA,DATA,DIE,DR,LINE,NAME,NUM
 D MES^XPDUTL("    - Updating BPS NCPDP REJECT CODES")
 S CNT=0
 F LINE=1:1 S DATA=$P($T(REJECTS1+LINE),";;",2,99) Q:DATA=""  D
 . S NUM=$P(DATA,";",1)
 . S DIE=9002313.93
 . S DA=$O(^BPSF(DIE,"B",NUM,""))
 . I 'DA Q     ; quit if no IEN found for entry
 . S CNT=CNT+1
 . S NAME=$P(DATA,";",2)
 . S DR=".02////^S X=NAME"
 . D ^DIE
 D MES^XPDUTL("      - "_CNT_" entries updated")
 D MES^XPDUTL("    - Done with BPS NCPDP REJECT CODES")
 D MES^XPDUTL(" ")
 Q
 ;
REJECTS1 ; Updated Reject Code explanations
 ;;43;Plan's database Indicates Submitted Prescriber DEA# Inactive/Expired
 ;;44;Plan's database Indicates Submitted Prescriber DEA# Not Found
 ;;46;Plan database-Submitted Prescriber DEA# Doesn't Allow This Drug Class
 ;;648;Qty Prescribed Does Not Match Qty Prescribed On Original Dispensing
 ;;649;Cumulative Qty For This Rx Number Exceeds Total Prescribed Qty
 ;;922;Morphine Milligram Equivalency (MME) Exceeds Limits
 ;;923;Morphine Milligram Equivalency (MME) Exceeds Limits For Patient Age
 ;;G4;Prescriber must contact plan
 ;;X4;Accumulator Year is not within ATBT timeframe
 ;;
 ;
