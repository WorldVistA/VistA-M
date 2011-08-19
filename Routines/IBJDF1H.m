IBJDF1H ;ALB/CPM - THIRD PARTY FOLLOW-UP REPORT (HELP); 09-JAN-97
 ;;2.0;INTEGRATED BILLING;**69,118,128,205**;21-MAR-94
 ;
HELP W ! F  S IBTEXT=$P($T(TEXT+IBOFF),";",3) Q:IBTEXT="*END*"  W !,IBTEXT S IBOFF=IBOFF+1
 W !
 Q
 ;
TEXT ; - 'Sort by division' prompt (Offset=1).
 ;;      Enter:  '<CR>' -  To print the report without regard to division
 ;;              'Y'    -  To select those divisions for which a separate
 ;;                         report should be created
 ;;              '^'    -  To quit this option
 ;;*END*
 ;
 ; - 'Run report for (S)PECIFIC...' prompt (Offset=8).
 ;;      Enter:  '<CR>' -  To select a range of insurance companies
 ;;              'S'    -  To select one or more insurance companies
 ;;              '^'    -  To quit this option
 ;;*END*
 ;
 ; - 'Start with INSURANCE COMPANY' prompt (Offset=14).
 ;;      Enter a valid field value up to 40 characters, or
 ;;              '@'    -  To include null values
 ;;              '<CR>' -  To start from the 'first' value for this field
 ;;              '^'    -  To quit this option
 ;;*END*
 ;
 ; - 'Go to INSURANCE COMPANY' prompt (Offset=21).
 ;;      Enter a valid field value up to 40 characters, or
 ;;              '@'    -  To include only null values, if 'Start with'
 ;;                         value is @
 ;;              '<CR>' -  To go to the 'last' value for this field
 ;;              '^'    -  To quit this option
 ;;*END*
 ;
 ; - 'Sort Patients by (N)AME... ' prompt (Offset=29).
 ;;      Enter:  '<CR>' -  To select and sort patients by name
 ;;              'L'    -  To select and sort patients by the last 4
 ;;                         of the SSN
 ;;              '^'    -  To quit this option
 ;;*END*
 ;
 ; - 'Start with PATIENT...' prompt (Offset=36).
 ;;      Enter a valid field value, or
 ;;              '@'    -  To include null values
 ;;              '<CR>' -  To start from the 'first' value for this field
 ;;              '^'    -  To quit this option
 ;;*END*
 ;
 ; - 'Go to PATIENT...' prompt (Offset=43).
 ;;      Enter a valid field value, or
 ;;              '@'    -  To include only null values, if 'Start with'
 ;;                         value is @
 ;;              '<CR>' -  To go to the 'last' value for this field
 ;;              '^'    -  To quit this option
 ;;*END*
 ;
 ; - 'Include (A)LL active AR's...' prompt (Offset=51).
 ;;      Enter:  '<CR>' -  To include all active receivables on the
 ;;                         report
 ;;              'R'    -  To restrict receivables to those within
 ;;                         a certain age range
 ;;              '^'    -  To quit this option
 ;;*END*
 ;
 ; - 'Enter the minimum age...' prompt (Offset=59).
 ;; Enter the minimum days in which the receivable should have been in
 ;;  an active status, or '^' to quit this option.
 ;;*END*
 ;
 ; - 'Enter the maximum age...' prompt (Offset=64).
 ;; Enter the maximum days in which the receivable should have been in
 ;;  an active status, or '^' to quit this option.
 ;;*END*
 ;
 ; - 'Print receivables with a minimum...' prompt (Offset=69).
 ;;      Enter:  'Y'    -  To print just those receivables that are over
 ;;                         a certain balance amount.
 ;;              '<CR>' -  To skip this question
 ;;              '^'    -  To quit this option
 ;;*END*
 ;
 ; - 'Enter the minimum balance amount...' prompt (Offset=76).
 ;; Enter the minimum balance amount for the receivable, or '^' to quit
 ;;  this option.
 ;;*END*
 ;
 ; - 'Include the Bill Comment history...' prompt (Offset=81).
 ;;      Enter:  '<CR>' -  To exclude the bill comment history from the
 ;;                         report
 ;;              'Y'    -  To include the bill comment history to the
 ;;                         report (This history includes the date
 ;;                         and comments from comment transactions)
 ;;              '^'    -  To quit this option
 ;;*END*
 ;
 ; - 'Include receivables referred...' prompt (Offset=90).
 ;;      Enter:  '<CR>' -  To exclude receivables referred to Regional
 ;;                         Counsel from the report
 ;;              'Y'    -  To include receivables referred to Regional
 ;;                         Counsel to the report (These receivables
 ;;                         will have a '*' after the current balance)
 ;;              '^'    -  To quit this option
 ;;*END*
 ;
 ; - 'Run report for (D)ATE OF CARE or (A)CTIVE IN AR...' prompt (Offset=99).
 ;;      Enter:  '<CR>' -  To calculate report by Days Active in AR
 ;;              'D'    -  To to calculate report by Date of Care
 ;;              '^'    -  To quit this option
 ;;*END*
