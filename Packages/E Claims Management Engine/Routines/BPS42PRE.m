BPS42PRE ;AITC/PED - Pre-install routine for BPS*1*42 ;12/30/2025
 ;;1.0;E CLAIMS MGMT ENGINE;**42**;JUN 2004;Build 11
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; MCCF EDI TAS ePharmacy - BPS*1*42 patch pre-install
 ;
 Q
 ;
PRE ; Entry Point for pre-install
 ;
 D MES^XPDUTL(" Starting pre-install for BPS*1*42")
 ;
 ; Update Other Payer Amount Paid Qualifier descriptions in file #9002313.2.
 D BPS2
 ;
 ; Update DAW Code status in file #9002313.24.
 D BPS24
 ;
 ; Update Benefit State Indicator description in file #9002313.35.
 D BPS35
 ;
 D MES^XPDUTL(" Finished pre-install of BPS*1*42")
 ;
 Q
 ;
BPS2 ; Update file 9002313.2
 N CNT,DA,DIE,DR,LINE,DATA,ENTRY,NUM,NAME,X
 D MES^XPDUTL(" - Updating BPS NCPDP OTHER PAYER AMT PAID QUAL")
 S CNT=0
 F LINE=1:1 S DATA=$P($T(BPS2CDS+LINE),";;",2,99) Q:DATA=""  D
 . S NUM=$P(DATA,";",1)
 . S NAME=$P(DATA,";",2)
 . S DIE=9002313.2
 . S DA=$O(^BPS(DIE,"B",NUM,""))
 . I 'DA D MES^XPDUTL(" - No IEN found for entry "_NUM) Q
 . S DR=".02////^S X=NAME"
 . D ^DIE
 . S CNT=CNT+1
 . Q
 S ENTRY="entries"
 I CNT=1 S ENTRY="entry"
 D MES^XPDUTL(" - "_CNT_" "_ENTRY_" updated")
 D MES^XPDUTL(" - Done with BPS NCPDP OTHER PAYER AMT PAID QUAL")
 D MES^XPDUTL(" ")
 Q
 ;
BPS2CDS ; Updated Other Payer Amt Paid Qual
 ;;01;DELIVERY
 ;;02;SHIPPING
 ;;03;POSTAGE
 ;;04;ADMINISTRATIVE
 ;;
 ;
 Q
 ;
BPS24 ; Update file 9002313.24
 N DA,DIE,DR
 D MES^XPDUTL(" - Updating BPS NCPDP DAW CODE")
 S DIE=9002313.24
 S DA=$O(^BPS(DIE,"B","A",""))
 I 'DA D MES^XPDUTL(" - No IEN found for entry A") Q
 S DR="2////1"
 D ^DIE
 D MES^XPDUTL(" - 1 entry updated")
 D MES^XPDUTL(" - Done with BPS NCPDP DAW CODE")
 D MES^XPDUTL(" ")
 Q
 ;
BPS35 ; Update file 9002313.35
 N DA,DIE,DR,NAME,X
 D MES^XPDUTL(" - Updating BPS NCPDP BENEFIT STAGE INDICATOR")
 S CNT=0
 S DIE=9002313.35
 S DA=$O(^BPS(DIE,"B",51,""))
 I 'DA D MES^XPDUTL(" - No IEN found for entry 51") Q
 S NAME="PAID UNDER THE PART B BENEFIT OF THE MEDICARE HEALTH PLAN FOR A QMB DUAL ELIGIBLE BENEFICIARY. PHARMACY SHOULD NOT ATTEMPT TO COLLECT COST-SHARE, BUT INSTEAD SHOULD ATTEMPT TO BILL COB TO MEDICAID COVERAGE."
 S DR=".02////^S X=NAME"
 D ^DIE
 D MES^XPDUTL(" - 1 entry updated")
 D MES^XPDUTL(" - Done with BPS NCPDP BENEFIT STAGE INDICATOR")
 D MES^XPDUTL(" ")
 Q
 ;
