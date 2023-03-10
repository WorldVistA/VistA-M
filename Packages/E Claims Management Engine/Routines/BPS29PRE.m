BPS29PRE ;AITC/PD - Pre-install for BPS*1.0*29 ;1/4/2021
 ;;1.0;E CLAIMS MGMT ENGINE;**29**;JUN 2004;Build 41
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; MCCF EDI TAS ePharmacy - BPS*1*29 patch pre-install
 Q
 ;
PRE ; Pre-install functions are coded here.
 ;
 D MES^XPDUTL(" Starting pre-install of BPS*1.0*29")
 ;
 ; Update field .02 in BPS NCPDP REJECT CODES
 D REJECTS
 ;
 D MES^XPDUTL(" Finished pre-install of BPS*1.0*29")
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
 ;;eC;CHAMPVA-NON BILLABLE
 ;;eT;TRICARE-NON BILLABLE
 ;;
 ;
