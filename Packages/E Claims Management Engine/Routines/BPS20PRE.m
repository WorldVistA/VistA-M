BPS20PRE ;ALB/ESG - Pre-install routine for BPS*1*20 ;10/19/2015
 ;;1.0;E CLAIMS MGMT ENGINE;**20**;JUN 2004;Build 27
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; ePharmacy Compliance Phase 3 - BPS*1*20 patch pre-install
 ;
 Q
 ;
EN ; Entry Point for post-install
 D MES^XPDUTL("  Starting pre-install for BPS*1*20")
 ;
 ; Update the reject code description in BPS NCPDP REJECT CODES
 D REJECTS
 ;
 ; Update the submission clarification codes in file 9002313.25
 D SUBCL
 ;
EX ; exit point
 ;
 D MES^XPDUTL("  Finished pre-install of BPS*1*20")
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
 . S NAME=$P(DATA,";",2,99),DR=".02////^S X=NAME",CNT=CNT+1
 . D ^DIE
 . Q
 D MES^XPDUTL("      - "_CNT_" entries updated")
 D MES^XPDUTL("    - Done with BPS NCPDP REJECT CODES")
 D MES^XPDUTL(" ")
 Q
 ;
NRJCT ; New reject code descriptions
 ;;607;Info Reporting (N1/N3) Trans Cannot Be Matched To A Claim (B1/B3)
 ;;610;Info Reporting Trans Matched to Reversed/Rejected Claim Under Part D
 ;;671;REMS: Laboratory test not conducted within specified time period
 ;;771;Compound contains unidentifiable ingredient; SCC override not allowed
 ;;773;Prescriber Is Not Listed On Medicare Enrollment File
 ;;774;Prescriber Medicare Enrollment Period Is Outside Of Claim Date Of Serv
 ;;A4;Prod May Be Covered Under Medicare-B Bndld Pymt ESRD Dialysis Facility
 ;;R0;Professional Serv Cd of 'MA' req'd for Vaccine Incentive Fee Submitted
 ;;
 ;
SUBCL ; update submission clarification codes - the .02 field is an identifier field
 ; so must be changed in this pre-install routine
 ;
 N LINE,DATA,NUM,NAME,DA,DIE,DR,CNT
 D MES^XPDUTL("    - Updating BPS NCPDP CLARIFICATION CODES")
 S CNT=0
 F LINE=1:1 S DATA=$P($T(NSCCDT+LINE),";;",2,99) Q:DATA=""  D
 . S DIE=9002313.25,NUM=$P(DATA,";",1)
 . S DA=$O(^BPS(DIE,"B",NUM,""))
 . I 'DA Q     ; quit if no IEN found for entry
 . S NAME=$P(DATA,";",2,99),DR=".02////^S X=NAME",CNT=CNT+1
 . D ^DIE
 . Q
 D MES^XPDUTL("      - "_CNT_" entries updated")
 D MES^XPDUTL("    - Done with BPS NCPDP CLARIFICATION CODES")
 D MES^XPDUTL(" ")
 Q
 ;
NSCCDT ; updated text for NCPDP submission clarification codes
 ;;0;ZZ DO NOT USE - NOT SPECIFIED, DEFAULT
 ;;44;ZZ DO NOT USE - ASSOCIATED PRESCRIBER DEA RECENTLY LICENSED OR RE-ACTIVATED
 ;;
 ;
