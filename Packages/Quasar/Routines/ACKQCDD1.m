ACKQCDD1 ;AUG/JLTP-CDR Division Report, Interactive Help Text ; [ 04/26/96 10:28 ]
 ;;3.0;QUASAR;;Feb 11, 2000
 ;Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
 ;
SAVE ; help text for prompt 'Do you wish to save data'
 W !
 W !,"     Once each month you must run and save a CDR report for the month.  It"
 W !,"     will be saved in the A&SP WORKLOAD file (#509850.7).  If you wish to"
 W !,"     save the CDR you are about to run, answer YES.  Otherwise answer NO."
 W !
 W !,"     If you are a multi-divisional site this report must be run each month"
 W !,"     for each Division."
 W !
 W !,"     If you choose to save this CDR, it must be run for a single"
 W !,"     entire month.  If you choose not to save, you can run the CDR for"
 W !,"     any date range you desire."
 W !
 Q
 ;
DATES ; help text for date range input
 W !
 W !,"     Since you have chosen not to save this CDR, you may run it for"
 W !,"     a single month or any other date range you desire.  To run it for a"
 W !,"     single month enter M.  For a date range of your choosing, enter D."
 W !
 Q
 ;
MONTH ; help text for month selection
 W !
 W !,"     Choose the month and year for which you wish to run the CDR"
 W !,"     report.  The month you choose must not be in the future."
 W !
 Q
STARTD ; help text for start of date range
 W !
 W !,"     Enter the starting date for which you wish to run the CDR"
 W !,"     report.  Starting and ending dates must be exact dates and must not"
 W !,"     be in the future.  Starting and ending dates are inclusive."
 W !
 Q
ENDD ; help text for end of date range
 W !
 W !,"     Enter the ending date for which you wish to run the CDR report."
 W !,"     Starting and ending dates must be exact dates and must not be in the"
 W !,"     future.  Starting and ending dates are inclusive."
 W !
 Q
TPH ; help text for total paid hours
 W !
 W !,"     Enter the total number of hours for which you have paid your"
 W !,"     staff during the selected time period."
 W !
 Q
 ;;
FLAT ; help text for flat number of hours for ADMIN and CONT ED, or RESEARCH
 W !
 W !,"     If you answer YES, you will be asked only one time for a number"
 W !,"     of hours that were spent for ",ACKCAT,"."
 W !
 W !,"     The hours you enter will then be evenly divided among all of the"
 W !,"     ",ACKCAT," CDR accounts."
 W !
 Q
