BPS39PRE ;AITC/PED - Pre-install routine for BPS*1*39 ;12/30/2024
 ;;1.0;E CLAIMS MGMT ENGINE;**39**;JUN 2004;Build 14
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; MCCF EDI TAS ePharmacy - BPS*1*39 patch pre-install
 ;
 Q
 ;
PRE ; Entry Point for pre-install
 ;
 D MES^XPDUTL(" Starting pre-install for BPS*1*39")
 ;
 ; Update Other Prescriber ID Qualifier descriptions in file #9002313.41.
 ;
 D BPS41
 ;
 D MES^XPDUTL(" Finished pre-install of BPS*1*39")
 ;
 Q
 ;
BPS41 ; Update file 9002313.41
 N CNT,DA,DIE,DR,LINE,DATA,ENTRY,NUM,NAME,X
 D MES^XPDUTL(" - Updating BPS NCPDP OTHER PRESCRIBER QUALIFIER")
 S CNT=0
 F LINE=1:1 S DATA=$P($T(BPS41CDS+LINE),";;",2,99) Q:DATA=""  D
 . S NUM=$P(DATA,";",1)
 . S NAME=$P(DATA,";",2)
 . S DIE=9002313.41
 . S DA=$O(^BPS(DIE,"B",NUM,""))
 . I 'DA D MES^XPDUTL(" - No IEN found for entry "_NUM) Q
 . S DR=".02////^S X=NAME"
 . D ^DIE
 . S CNT=CNT+1
 . Q
 S ENTRY="entries"
 I CNT=1 S ENTRY="entry"
 D MES^XPDUTL(" - "_CNT_" "_ENTRY_" updated")
 D MES^XPDUTL(" - Done with BPS NCPDP OTHER PRESCRIBER QUALIFIER")
 D MES^XPDUTL(" ")
 Q
 ;
BPS41CDS ; Updated DAW code
 ;;18;No Prescriber ID, No RX Associated to the transaction
 ;;
 ;
 Q
 ;
