ACKQCD1 ;AUG/JLTP-CDR Report Interactive Help Text ; [ 04/26/96 10:28 ]
 ;;3.0;QUASAR;;Feb 11, 2000
 ;Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
SAVE ;
 N I,X W ! F I=3:1 S X=$P($T(SAVE+I),";;",2) Q:X=""  W !,X
 W ! Q
 ;;     Once each month you must run and save a CDR report for the month.  It
 ;;     will be saved in the A&SP WORKLOAD file (#509850.7).  If you wish to
 ;;     save the CDR you are about to run, answer YES.  Otherwise answer NO.
 ;;     
 ;;     If you choose to save this CDR, it must be run for a single
 ;;     entire month.  If you choose not to save, you can run the CDR for
 ;;     any date range you desire.
 ;;
DATES ;
 N I,X W ! F I=3:1 S X=$P($T(DATES+I),";;",2) Q:X=""  W !,X
 W ! Q
 ;;     Since you have chosen not to save this CDR, you may run it for
 ;;     a single month or any other date range you desire.  To run it for a
 ;;     single month enter M.  For a date range of your choosing, enter D.
 ;;
MONTH ;
 N I,X W ! F I=3:1 S X=$P($T(MONTH+I),";;",2) Q:X=""  W !,X
 W ! Q
 ;;     Choose the month and year for which you wish to run the CDR
 ;;     report.  The month you choose must be in the past.
 ;;
STARTD ;
 N I,X W ! F I=3:1 S X=$P($T(STARTD+I),";;",2) Q:X=""  W !,X
 W ! Q
 ;;     Enter the starting date for which you wish to run the CDR
 ;;     report.  Starting and ending dates must be exact dates and must not
 ;;     be in the future.  Starting and ending dates are inclusive.
 ;;
ENDD ;
 N I,X W ! F I=3:1 S X=$P($T(ENDD+I),";;",2) Q:X=""  W !,X
 W ! Q
 ;;     Enter the ending date for which you wish to run the CDR report.
 ;;     Starting and ending dates must be exact dates and must not be in the
 ;;     future.  Starting and ending dates are inclusive.
 ;;
TPH ;
 N I,X W ! F I=3:1 S X=$P($T(TPH+I),";;",2) Q:X=""  W !,X
 W ! Q
 ;;     Enter the total number of hours for which you have paid your
 ;;     staff during the selected time period.
 ;;
FLAT ;
 N I,X W ! F I=4:1 S X=$P($T(FLAT+I),";;",2) Q:X=""  D  W !,X
 .F  Q:X'["|?|"  S X=$P(X,"|?|")_ACKCAT_$P(X,"|?|",2,99)
 W ! Q
 ;;     If you answer YES, you will be asked only one time for a number
 ;;     of hours that were spent for |?|.
 ;;     
 ;;     The hours you enter will then be evenly divided among all of the
 ;;     |?| CDR accounts.
 ;;
