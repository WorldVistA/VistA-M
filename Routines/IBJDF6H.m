IBJDF6H ;ALB/RB - MISCELLANEOUS BILLS FOLLOW-UP REPORT (HELP);15-APR-00
 ;;2.0;INTEGRATED BILLING;**123**;21-MAR-94
 ;
HELP W ! F  S IBTEXT=$P($T(TEXT+IBOFF),";",3) Q:IBTEXT="*END*"  D
 .W !,IBTEXT S IBOFF=IBOFF+1
 W !
 Q
 ;
TEXT ; - 'Include (A)LL active AR's...' prompt (Offset=1).
 ;;      Enter:  '<CR>' -  To include all active receivables on the
 ;;                        report
 ;;              'R'    -  To restrict receivables to those within
 ;;                        a certain age range
 ;;              '^'    -  To quit this option
 ;;*END*
 ;
 ; - 'Enter the minimum age...' prompt (Offset=9).
 ;; Enter the minimum days in which the receivable should have been in
 ;; an active status, or '^' to quit this option.
 ;;*END*
 ;
 ; - 'Enter the maximum age...' prompt (Offset=14).
 ;; Enter the maximum days in which the receivable should have been in
 ;; an active status, or '^' to quit this option.
 ;;*END*
 ;
 ; - 'Print receivables with a minimum...' prompt (Offset=19).
 ;;      Enter:  'Y'    -  To print just those receivables that are over
 ;;                        a certain balance amount.
 ;;              '<CR>' -  To skip this question
 ;;              '^'    -  To quit this option
 ;;*END*
 ;
 ; - 'Enter the minimum balance amount...' prompt (Offset=26).
 ;; Enter the minimum balance amount for the receivable, or '^' to quit
 ;; this option.
 ;;*END*
 ;
 ; - 'Include the Bill Comment history...' prompt (Offset=31).
 ;;      Enter:  '<CR>' -  To exclude the bill comment history from the
 ;;                        report
 ;;              'Y'    -  To include the bill comment history to the
 ;;                        report (This history includes the date
 ;;                        and comments from comment transactions)
 ;;              '^'    -  To quit this option
 ;;*END*
 ;
 ; - 'Print (A)ll comments...' prompt (Offset=40).
 ;;      Enter:  '<CR>' -  To print ALL comments for a receivable
 ;;              'M'    -  To print the only the most recent comment
 ;;                         entered for a receivable
 ;;              '^'    -  To quit this option
 ;;*END*
 ;
 ; - 'Minimum age of most recent...' prompt (Offset=47).
 ;; Enter the minimum age (number of days ago) of an AR's most recent
 ;; bill comment. AR's with recent comments that are at least this age
 ;; will be included on the report. Enter '<CR>' to skip this prompt,
 ;; or '^' to quit this option.
 ;;*END*
