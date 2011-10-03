IBJDF7H ;ALB/MR - REPAYMENT PLAN REPORT (HELP);14-AUG-00
 ;;2.0;INTEGRATED BILLING;**123,240**;21-MAR-94
 ;
HELP W ! F  S IBTEXT=$P($T(TEXT+IBOFF),";",3) Q:IBTEXT="*END*"  D
 .W !,IBTEXT S IBOFF=IBOFF+1
 W !
 Q
 ;
TEXT ; - 'Sort Patients by (N)AME... ' prompt (Offset=1).
 ;;      Enter:  'N'  -  To select and sort patients by name
 ;;              'L'  -  To select and sort patients by the last 4
 ;;                      of the SSN
 ;;              '^'  -  To quit this option
 ;;*END*
 ;
 ; - 'START WITH PATIENT...' prompt (Offset=8).
 ;;      Enter a valid field value, or
 ;;              '@'    -  To include null values
 ;;              '<CR>' -  To start from the 'first' value for this field
 ;;              '^'    -  To quit this option
 ;;*END*
 ;
 ; - 'GO TO PATIENT' prompt (Offset=16).
 ;;      Enter a valid field value, or
 ;;              '@'    -  To include only null values, if 'Start with'
 ;;                         value is @
 ;;              '<CR>' -  To go to the 'last' value for this field
 ;;              '^'    -  To quit this option
 ;;*END*
 ;
 ; - 'Current or Defaulted Repayment Plan...' prompt (Offset=23).
 ;;      Enter the type of Repayment Plan to be listed:
 ;;                
 ;;              'C'  -  To Current Repayment Plan
 ;;              'D'  -  To Defaulted Repayment Plan
 ;;              'B'  -  To Both (Current and Defaulted)
 ;;              '^'  -  To quit this option
 ;;*END*
 ;
 ; - 'Minimum number of days defaulted:' prompt (Offset=32).
 ;;  Please, enter the minimum number of days defaulted on a payment
 ;;  for a Repayment Plan to be considered defaulted. The  Repayment 
 ;;  Plans with no defaulted payments or that defaulted  fewer  days
 ;;  than the number entered here, will be considered current.
 ;;*END*
 ;
 ; - 'MCCR or NON-MCCR Receivables..." prompt (Offset=39).
 ;;         Enter the type of receivables to be listed:
 ;;
 ;;              'M'  -  To MCCR Receivables
 ;;              'N'  -  To NON-MCCR Receivables
 ;;
 ;;              The NON-MCCR Categories are:
 ;;
 ;;     TRICARE          TRICARE Patient        TRICARE Third Party
 ;;     CHAMPVA          CHAMPVA Subsistence    CHAMPVA Third Party
 ;;     Ex-Employee      Current Employee       Military
 ;;     Vendor           Interagency            Sharing Agreements
 ;;     Federal Agencies-refund      Federal Agencies-reimbursement
 ;;
 ;;              All the others are MCCR.
 ;;*END*
 ; - 'Do you want to print TOTAL by Patient?' prompt (Offset=55).
 ;;      Enter:  'Y'  -  To print the total for patients with more
 ;;                      than one entry
 ;;              'N'  -  To NOT print the total by patient
 ;;              '^'  -  To quit this option
 ;;*END*
