IBJDF8H ;ALB/RRG - AR PRODUCTIVITY REPORT (HELP);29-AUG-00
 ;;2.0;INTEGRATED BILLING;**123**;21-MAR-94
 ;
HELP N IBTEXT
 F  S IBTEXT=$P($T(TEXT+IBOFF),";",3) Q:IBTEXT="*END*"  D
 .W !,IBTEXT S IBOFF=IBOFF+1
 W !
 Q
 ;
TEXT ; - 'FROM Transaction Date' prompt (offset=1).
 ;;  Please enter the beginning date in the range to be considered
 ;;  in this report.
 ;;  example:  MMDDYY  or  'T' = Today  'T+30' = Today + 30 days
 ;;                                     'T-30' = Today - 30 days
 ;;            '^'  - to quit this option
 ;;
 ;;  NOTE: It is NOT possible to enter a future date.
 ;;*END*
 ;
 ; - 'TO Transaction Date' prompt (offset=11)
 ;;  Please enter the ending date in the range to be considered in
 ;;  this report.
 ;;  example:  MMDDYY or 'T' = Today   'T+30' - Today + 30 days
 ;;                                    'T-30' - Today - 30 days
 ;;            '^'  - to quit this option
 ;;
 ;;  NOTE: This date MUST follow the date entered above.
 ;;*END*
 ;
 ; - 'Do you wish to print with Clerk name...' prompt (offset=21)
 ;;      Enter:  'N'  -  To display clerk name
 ;;              'I'  -  To display clerk identifier (numeric)
 ;;              '^'  -  To quit this option
 ;;*END*
 ;
 ; - 'Do you want to print the summary by Clerk?' prompt (offset=27)
 ;;      Enter:  'Y'  -  Display summary by Clerk
 ;;              'N'  -  Do not display summary by Clerk
 ;;              '^'  -  To quit this option
 ;;*END*
 ;
 ; - 'Start with Patient Name/Last 4 of SSN... ' prompt (Offset=33).
 ;;      Enter a valid field value, or
 ;;              <CR> -  To start from the 'First' value of this field
 ;;              '@'  -  To return field to null value
 ;;              '^'  -  To quit this option
 ;;*END*
 ;
 ; - 'Go To Patient Name/Last 4 of SSN...' prompt (Offset=40).
 ;;      Enter a valid field value, or
 ;;              <CR> -  To go to the 'last' value for this field
 ;;              '@'  -  To return field to null value
 ;;              '^'  -  To quit this option
 ;;*END*
 ;
 ; - 'Start with Insurance Carrier...' prompt (Offset=47).
 ;;      Enter a valid field value, or
 ;;              <CR> -  To start from the 'first' value for this field
 ;;              '@'  -  To return field to null value
 ;;              '^'  -  To quit this option
 ;;*END*
 ;
 ; - 'Go to Insurance Carrier...' prompt  (offset=54).
 ;;      Enter a valid field value, or
 ;;              <CR> -  To go to the 'last' value for this field
 ;;              '@'  -  To return field to null value
 ;;              '^'  -  To quit this option
 ;;*END*
 ;
 ; - 'Run list for (S)pecific or (A)ll Clerks...' prompt (offset=61)
 ;;      Enter:  <CR> -  To select ALL clerks
 ;;               'S' -  To select one or more clerks
 ;;               '^' -  To quit this option
 ;;*END*
 ;
 ; - 'Exclude receivables referred to Regional...' prompt  (offset=67)
 ;;      Enter:   'N' -  Do not exclude Receivables referred
 ;;                         to Regional Counsel
 ;;               'Y' -  Exclude Receivables referred to 
 ;;                         Regional Counsel
 ;;               '^' -  To quit this option
 ;;*END*
 ;
