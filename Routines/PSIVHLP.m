PSIVHLP ;BIR/PR-HELP TEXT ;26 JUL 94 / 9:57 AM
 ;;5.0; INPATIENT MEDICATIONS ;;16 DEC 97
 W ! F PSIVHLP=0:1 S PSIVHLP1=$P($T(@HELP+PSIVHLP),";",3) Q:PSIVHLP1=""  W !,PSIVHLP1
 W ! K HELP,PSIVHLP1,PSIVHLP Q
 ;
ACTHLP ; Display action line help.
 W !,"You may take the following action on this order:",!!
 N X F X="DC","E","H","L","O","R","S" I DIR(0)[(X_":") W $P($T(@X),";",3),!
 Q
VIEW ;;Enter the #(s) of the orders, that you wish to view, separated by commas.
 ;;ex. '1,2,5' or '1'
 ;;
OK ;;Enter 'Y' if the order has been correctly entered or 'N' to edit the
 ;;order.  To DELETE the order enter an '^'.
 ;;*** NOTE: If the order has been incorrectly entered, a 'Y' cannot be entered.
 ;;
NEWORD ;;Enter a 'Y' to enter a new order for this patient or 'N' to select
 ;;another patient name.
 ;;
CHSE ;;Choose the #(s) of the order(s) that you wish to view (ex. '1' or '1,2,5'),
 ;;or enter 'A' to view Allergies/Adverse Reactions.
 ;;
DC ;;== DC == Discontinue order.
O ;;== O  == Put order on 'On Call' status or remove order from 'On Call' status.
E ;;== E  == Edit the order.
R ;;== R  == Renew the order, or Reinstate if the order was auto-discontinued.
H ;;== H  == Put order on Hold or remove order from Hold status.
S ;;== S  == Show (view) the order. Brings the order back to the screen.
L ;;== L  == Look at the activity log 'AND' label log.
A ;;== A  == View Allergies and/or Adverse Drug Reactions.
 ;;
ACTLOG ;;Enter 'Y' to view the activity log or 'N' <RETURN> if you do
 ;;not want to see the activity log.
 ;;
SUSL ;;Enter the # of labels you wish to suspend for this order.
 ;;You may only suspend 10 labels at a time.
 ;;
SUSC ;;Choose the #(s) of the order(s) that you with to suspend.
 ;;(Ex. '1' or '1,2,3')
 ;;
ASKMAN ;;Enter the #(s) of the manufacturing time(s) that you wish to
 ;;run.  If you want to run the manufacturing times for #1 and #2
 ;;enter '1,2'.
 ;;
 ;;NOTE --> If you pick two of the same manufacturing types (Two
 ;;         Adm. or Two PB's) the first will be ignored and the
 ;;         second one entered will be run !!!
 ;;
UWL ;;Enter a date, without time, that corresponds to the date that
 ;;the ward list was run.  Example: If you ran a ward list for
 ;;today and you want to edit that ward list ... Enter 'T' or
 ;;<RETURN>.
 ;;
MLL ;;Enter a date, without time, that corresponds to the date that
 ;;the ward list was run.  Example: If you ran a ward list for
 ;;today and you want to print the Manufacturing List for that ward
 ;;list enter 'T' or <RETURN>.
 ;;
LBL1 ;;Enter a date, without time, that corresponds to the date that
 ;;the ward list was run.  Example: If you ran a ward list for
 ;;today and you want to run the schedule labels from that ward
 ;;list or manufacturing list ... Enter a 'T' or <RETURN>.
 ;;
PURGE ;;Enter a date that you wish to stop the purge.  For example,
 ;;if you want to purge IV orders that are at least 40 days old ...
 ;;enter 'T-40'.
 ;;
ANSWER ;;   P - Print specified # of labels now
 ;;   S - Suspend specified # of labels for IV ROOM to print on demand.
 ;;    (ONLY available if site parameter is enabled for suspense)
 ;;   B or ^ - Bypass any more action
 ;;
 ;;Enter one of the actions above.  You may perform more than one action
 ;;but they must be done, one at a time.  As each action is taken that
 ;;operates on labels, the total labels will be reduced by that amount.
 ;;
 ;; i.e.  8 labels needed - Suspend 3 then 5 are available to print
 ;;
 ;; NOTE: Valid actions are displayed in parenthesis after 'Action' prompt.
 ;;
PRORPT ;;  If you want a view of each order on the profile enter a 'Y'.
 ;;  If you just want a listing of the patient's profile without a view
 ;;  of each order enter a 'N'.
 ;;
RNL ;; You will enter the beginning date and ending date of the renewal list.
 ;; Ex. If you want to know what orders will expire from noon today to
 ;;     noon tomorrow ... enter 'T@1200' as the beginning date and
 ;;     'T+1@1200' as the ending date.
 ;;
ALGN ;; Answer yes if the label alignment is OK. Enter no if you wish to
 ;; re-align the labels again.
 ;;
 ;;
REDT ;;Enter a # between -10 and 10.  If returns/destroyed were entered
 ;;in error, a '-' preceding the # will remove the returns/destroyed
 ;;for you.
