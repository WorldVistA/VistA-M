BPS23PRE ;AITC/CKB - Pre-install routine for BPS*1*23 ;2/21/2017
 ;;1.0;E CLAIMS MGMT ENGINE;**23**;JUN 2004;Build 44
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; MCCF EDI TAS ePharmacy Iteration 1 - BPS*1*23 patch pre-install
 Q
 ;
EN ; Entry Point for pre-install
 D MES^XPDUTL(" Starting pre-install for BPS*1*23")
 ;
 ; Update Reject codes explanations in file #9002313.93
 D REJECTS
 ;
 ; Update Result of Service Codes explanations in file #9002313.22
 D SVCCODE
 ;
 ; Update Clarification (file #9002313.25) and Other Payer Amount Paid Qualifier
 ;  codes (file #9002313.2) with new descriptions
 D UPDCCQC
 ;
EX ; Exit point
 D MES^XPDUTL(" Finished pre-install of BPS*1*23")
 Q
 ;
REJECTS ; Update Reject Codes with new explanations
 N LINE,DATA,NUM,NAME,DA,DIE,DR,CNT
 D MES^XPDUTL(" - Updating BPS NCPDP REJECT CODES")
 S CNT=0
 F LINE=1:1 S DATA=$P($T(URJCT+LINE),";;",2,99) Q:DATA=""  D
 . S DIE=9002313.93,NUM=$P(DATA,";",1)
 . S DA=$O(^BPSF(DIE,"B",NUM,""))
 . I 'DA D MES^XPDUTL(" - No IEN found for entry "_NUM) Q
 . S NAME=$P(DATA,";",2),DR=".02////^S X=NAME",CNT=CNT+1
 . D ^DIE
 D MES^XPDUTL(" - "_CNT_" entries updated")
 D MES^XPDUTL(" - Done with BPS NCPDP REJECT CODES")
 D MES^XPDUTL(" ")
 Q
 ;
URJCT ; Updated reject explanations
 ;;01;M/I IIN Number
 ;;299;Reported Adjudicated Program Type Is Not Used For This Transaction Code
 ;;708;PDMP: M/I Reported Adjudicated Program Type
 ;;820;Info Reporting Trans Mtchd to Rev/Rej Clm not Submitted Part D IIN PCN
 ;;821;Info Reporting Trans Mtchd to Pd Clm Not Submitted Part D IIN PCN
 ;;A1;ID Submitted Is Associated With An Excluded Prescriber
 ;;ZS;M/I Reported Adjudicated Program Type
 ;;
 ;
SVCCODE ; Update Result of Service Codes with new explanations
 N LINE,CODE,NUM,DESC,DA,DIE,DR,CNT
 D MES^XPDUTL(" - Updating BPS NCPDP RESULT OF SERVICE CODES")
 S CNT=0
 F LINE=1:1 S CODE=$P($T(UPDSVC+LINE),";;",2,99) Q:CODE=""  D
 . S DIE=9002313.22,NUM=$P(CODE,";",1)
 . S DA=$O(^BPS(DIE,"B",NUM,""))
 . I 'DA D MES^XPDUTL(" - No IEN found for entry "_NUM) Q
 . S DESC=$P(CODE,";",2),DR="1////^S X=DESC",CNT=CNT+1
 . D ^DIE
 D MES^XPDUTL(" - "_CNT_" entries updated")
 D MES^XPDUTL(" - Done with BPS NCPDP RESULT OF SERVICE CODES")
 D MES^XPDUTL(" ")
 Q
 ;
UPDSVC ; Updated Result of Service Code explanations
 ;;1A;DISPENSED AS IS, FALSE POSITIVE
 ;;1B;DISPENSED PRESCRIPTION AS IS
 ;;1C;DISPENSED, WITH DIFFERENT DOSE
 ;;1D;DISPENSED, WITH DIFFERENT DIRECTIONS
 ;;1E;DISPENSED, WITH DIFFERENT DRUG
 ;;1F;DISPENSED, WITH DIFFERENT QUANTITY
 ;;1G;DISPENSED, WITH PRESCRIBER APPROVAL
 ;;1K;DISPENSED WITH DIFFERENT DOSAGE FORM
 ;;2A;PRESCRIPTION NOT DISPENSED
 ;;2B;NOT DISPENSED, DIRECTIONS CLARIFIED
 ;;
 ;
UPDCCQC ;
 ;Update Clarification codes with new descriptions
 N LINE,CODE,NUM,DESC,DA,DIE,DR,CNT
 D MES^XPDUTL(" - Updating BPS NCPDP CLARIFICATION CODES")
 S CNT=0
 F LINE=1:1 S CODE=$P($T(UCC+LINE),";;",2,99) Q:CODE=""  D
 . S DIE=9002313.25,NUM=$P(CODE,";",1)
 . S DA=$O(^BPS(DIE,"B",NUM,""))
 . I 'DA D MES^XPDUTL(" - No IEN found for entry "_NUM) Q
 . S DESC=$P(CODE,";",2),DR=".02////^S X=DESC",CNT=CNT+1
 . D ^DIE
 D MES^XPDUTL(" - "_CNT_" entries updated")
 D MES^XPDUTL(" - Done with BPS NCPDP CLARIFICATION CODES")
 D MES^XPDUTL(" ")
 ;
 ;Update Other Payer Amount Paid Qualifier codes with new description
 N LINE,CODE,NUM,DESC,DA,DIE,DR,CNT
 D MES^XPDUTL(" - Updating BPS NCPDP OTHER PAYER AMT PAID QUAL FILE")
 S CNT=0
 F LINE=1:1 S CODE=$P($T(UQC+LINE),";;",2,99) Q:CODE=""  D
 . S DIE=9002313.2,NUM=$P(CODE,";",1)
 . S DA=$O(^BPS(DIE,"B",NUM,""))
 . I 'DA D MES^XPDUTL(" - No IEN found for entry "_NUM) Q
 . S DESC=$P(CODE,";",2),DR=".02////^S X=DESC",CNT=CNT+1
 . D ^DIE
 D MES^XPDUTL(" - "_CNT_" entries updated")
 D MES^XPDUTL(" - Done with BPS NCPDP OTHER PAYER AMT PAID QUAL FILE")
 D MES^XPDUTL(" ")
 Q
 ;
UCC ; Updated Clarification Code explanations
 ;;47;SHORTENED DAYS SUPPLY DISPENSED
 ;;48;DISPENSED SUBSEQUENT TO A SHORTENED DAYS SUPPLY DISPENSING
 ;;
 ;
UQC ; Updated Other Payer Amount Paid Qualifier explanations
 ;;10;PERCENTAGE TAX
 ;;
 ;
