XQ93 ; SF-ISC.SEA/JLI - CHECK FOR NEEDING TO BE QUEUED ;12/7/89  15:34 ;10/22/92  12:58 PM
 ;;8.0;KERNEL;;Jul 10, 1995
EN ; Check whether option can be run at present time, otherwise kill
 ; off value of IO and display next non-prohibited time option can be run
 N X,Y S X="N",%DT="T" D ^%DT S X=Y D ^XQ92 Q:X'=""  S Y=+XQY D NEXT^XQ92
 I X="" W !,$C(7),"CAN'T QUEUE IT WITHIN THE NEXT WEEK",! S DIUT=1 Q
 N X1,X2 S Y=X S X2=X\1,X1=DT D D^%DTC S Y="T"_$S(X>0:"+"_X,1:"")_"@"_$E(Y_"00",9,10)_":"_$E(Y_"0000",11,12) W !,$C(7),"THIS OPTION CANNOT BE RUN NOW --  IT CAN BE QUEUED FOR ",Y,!
 K IO
 Q
 ;
CHKQ ; Check for queued job date/time (returns next run time)
 ;    On entry X contains the specified date/time for queueing the job
 ;    On exit X contains the original date/time, or the next available
 ;        date/time the option can be run, or if not within a week a
 ;        NULL value of X.
 ;    The value of XQY is the selected option number
 N Y D ^XQ92 Q:X'=""  S Y=+XQY D NEXT^XQ92
 Q
