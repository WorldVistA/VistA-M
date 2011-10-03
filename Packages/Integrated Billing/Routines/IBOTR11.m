IBOTR11 ;ALB/CPM - INSURANCE PAYMENT TREND REPORT - HELP TEXT ; 15-AUG-95
 ;;2.0;INTEGRATED BILLING;**42,100,118,128**;21-MAR-94
 ;
HELP W ! F  S IBTEXT=$P($T(TEXT+IBOFF),";",3) Q:IBTEXT=""  W !,IBTEXT S IBOFF=IBOFF+1
 W ! Q
 ;
TEXT ; - 'Select (I)NPATIENT...' prompt (offset=1).
 ;;      Enter:  '<CR>' -  To select both Inpatient and Outpatient bills
 ;;              'I'    -  To select only Inpatient bills
 ;;              'O'    -  To select only Outpatient bills
 ;;              '^'    -  To quit this option
 ;
 ; - 'Print (C)OMBINED...' prompt (offset=7).
 ;;      Enter:  '<CR>' -  To print a report of both Inpatient and
 ;;                         Outpatient bills
 ;;              'S'    -  To print separate Inpatient and Outpatient
 ;;                         reports
 ;;              '^'    -  To quit this option
 ;
 ; - 'Select (O)PEN, (C)LOSED...' prompt (offset=14).
 ;;      Enter:  '<CR>' -  To select both Open and Closed bills
 ;;              'O'    -  To select only Open bills
 ;;              'C'    -  To select only Closed bills
 ;;              '^'    -  To quit this option
 ;
 ; - 'Do you want to include cancelled bills' prompt (offset=20).
 ;;      Enter:  '<CR>' -  To exclude cancelled bills from the report
 ;;              'Y'    -  To include cancelled bills on the report
 ;;              '^'    -  To quit this option
 ;
 ; - 'Print report by...' prompt (offset=25).
 ;;      Enter:  '<CR>' -  To select bills by the Bill Printed Date
 ;;              '2'    -  To select bills by the Treatment Date
 ;;              '^'    -  To quit this option
 ;
 ; - 'Print (M)AIN REPORT...' prompt (offset=30).
 ;;      Enter:  '<CR>' -  To list all the bills which meet the report
 ;;                         criteria and the grand totals
 ;;              'S'    -  To list only sub-totals by insurance company
 ;;                         and the grand totals
 ;;              'G'    -  To list only the grand totals
 ;;              '^'    -  To quit this option
 ;
 ; - 'Run report/totals for (S)PECIFIC...' prompt (offset=38).
 ;;      Enter:  '<CR>' -  To select a range of insurance companies
 ;;              'S'    -  To select one or more insurance companies
 ;;              '^'    -  To quit this option
 ;
 ; - 'Start with INSURANCE COMPANY' prompt (offset=43).
 ;;      Enter a valid field value up to 40 characters, or:
 ;;              '@'    -  To include null values
 ;;              '<CR>' -  To start from the 'first' value for this field
 ;;              '^'    -  To quit this option
 ;
 ; - 'Go to INSURANCE COMPANY' prompt (offset=49).
 ;;      Enter a valid field value up to 40 characters, or:
 ;;              '@'    -  To include only null values, if 'Start with'
 ;;                         value is @
 ;;              '<CR>' -  To go to the 'last' value for this field
 ;;              '^'    -  To quit this option
 ;
 ; - 'Sort by AMOUNT (O)WED...' prompt (offset=56).
 ;;      Enter:  '<CR>' -  To sort report by insurance company
 ;;              'O'    -  To sort report from the insurance company
 ;;                         with the HIGHEST amount owed them, to the
 ;;                         one with the LOWEST amount owed them
 ;;              'P'    -  To sort report from the insurance company
 ;;                         with the HIGHEST amount paid them, to the
 ;;                         one with the LOWEST amount paid them
 ;;              '^'    -  To quit this option
 ;
 ; - 'Include receivables...' prompt (offset=66).
 ;;      Enter:  '<CR>' -  To exclude receivables referred to the
 ;;                         Regional Counsel from the report
 ;;              'Y'    -  To include receivables referred to the
 ;;                         Regional Counsel to the report
 ;;              '^'    -  To quit this option
 ;
