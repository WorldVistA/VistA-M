BPS15PRE ;ALB/ESG - Pre-install for BPS*1.0*15 ;03/04/2013
 ;;1.0;E CLAIMS MGMT ENGINE;**15**;JUN 2004;Build 13
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
PRE ; Entry Point for pre-install
 ;
 ; The purpose of this pre-install routine is to update dictionary entries
 ; that are being edited (not added) with this patch. Because both the code and description fields
 ; are identifier fields for the record, edits are a problem if we just let KIDS send the
 ; data to the target sites. Duplicate entries will be created. So this pre-install routine
 ; will update the data to the correct values, so KIDS will not create duplicates.
 ;
 D MES^XPDUTL("  Starting pre-install of BPS*1*15")
 ;
 D DFIELDS    ; update changed BPS dictionary entries found in ^BPS(file#
 D REJECTS    ; update NCPDP reject codes/descriptions found in 9002313.93
 ;
 D MES^XPDUTL("  Finished pre-install of BPS*1*15")
 Q
 ;
DFIELDS ;Update changed dictionary entries
 N LINE,DATA,NUM,NAME,DA,DIE,DR,CNT,DCT,FLDNUM
 D MES^XPDUTL("    - Updating dictionaries values")
 S CNT=0
 F LINE=1:1 S DATA=$P($T(DFLDS+LINE),";;",2,99) Q:DATA=""  D
 . S NUM=$P(DATA,";",1),DCT=$P(DATA,";",3),FLDNUM=$P(DATA,";",4)
 . S DA=$O(^BPS(DCT,"B",NUM,""))
 . I 'DA D MES^XPDUTL("      - No IEN found for entry "_NUM) Q
 . S DIE=DCT,NAME=$P(DATA,";",2),DR=FLDNUM_"////"_NAME,CNT=CNT+1
 . D ^DIE
 D MES^XPDUTL("    - "_CNT_" entries updated")
 D MES^XPDUTL("    - Done with updating dictionaries values")
 D MES^XPDUTL(" ")
 Q
 ;
DFLDS ;
 ;;PT;PERFORM LABORATORY TEST;9002313.21;1;Edit to code PT (440-E5) Professional Service Code
 ;;RT;RECOMMEND LABORATORY TEST;9002313.21;1;Edit to code RT (440-E5) Professional Service Code
 ;;
 ;
 ;
REJECTS ; Update existing Reject Codes with new explanations
 N LINE,DATA,NUM,NAME,DA,DIE,DR,CNT,X,Y
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
NRJCT ; Existing reject codes, but with updated reject code descriptions
 ;;42;Plan's Prescriber database indicates Prescriber ID is inactive/expired
 ;;43;Associated DEA to submitted Prescriber ID is inactive or expired
 ;;44;Plan's Prescriber database indicates DEA to Prescriber ID not found
 ;;46;Assoc DEA to submitted Prescriber ID doesn't allow drug DEA Schedule
 ;;63;Product/Service ID Not Covered For Institutionalized Patient
 ;;71;Prescriber ID Is Not Covered
 ;;421;Purchaser Date of Birth is not used for this Transaction Code
 ;;477;Other Payer ID Count Does Not Precede Other Payer ID Data Fields
 ;;569;Provide Notice: Medicare Prescription Drug Coverage and Your Rights
 ;;597;LTC Dispensing Type Does Not Support The Packaging Type
 ;;1R;Version/Release Value Not Supported
 ;;1S;Transaction Code/Type Value Not Supported
 ;;4Y;Patient Residence Value Not Supported
 ;;4Z;Place of Service Not Supported By Plan
 ;;7J;Patient Relationship Code Value Not Supported
 ;;7K;Discrepancy Between Other Coverage Code And Other Payer Amount
 ;;7N;Patient ID Qualifier Value Not Supported
 ;;7Q;Other Payer ID Qualifier Value Not Supported
 ;;7S;Other Payer Amount Paid Qualifier Value Not Supported
 ;;8K;DAW Code Value Not Supported
 ;;8R;Submission Clarification Code Value Not Supported
 ;;8S;Basis Of Cost Determination Value Not Supported
 ;;A6;This Product/Service May Be Covered Under Medicare Part B
 ;;MP;Other Payer Cardholder ID Not Covered
 ;;PW;Employer ID Not Covered
 ;;PX;Other Payer ID Not Covered
 ;;RU;Mandatory Elements Must Occur Before Optional Data Elements In Segment
 ;;VA;Pay To Qualifier Value Not Supported
 ;;VB;Generic Equivalent Product ID Qualifier Value Not Supported
 ;;VC;Pharmacy Service Type Value Not Supported
 ;;YJ;Medicaid Agency Number Not Supported
 ;;Z0;Purchaser Country Code Value Not Supported For Processor/Payer
 ;;Z1;Prescriber Alternate ID Qualifier Value Not Supported
 ;;Z8;Purchaser Relationship Code Value Not Supported
 ;;ZD;Associated Rx/Service Reference Number Qualifier Value Not Supported
 ;;ZV;Reported Payment Type Value Not Supported
 ;;ZZ;Cardholder ID submitted is inactive. New Cardholder ID on file
 ;;
 ;
