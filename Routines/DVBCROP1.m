DVBCROP1 ;ALB/GTS-557/THM-REOPEN REQUESTS/EXAMS, CONTINUED ; 11/16/90  7:39 AM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
STATUS1 W *7,!!,"Since this request has reopened, its status will",!,"be PENDING, REPORTED.",!!,"Be sure to regenerate any exam worksheets that will be needed",!,"for this request.",!!
 W "Press RETURN to continue " R ANS:DTIME ;if timeout, properly set record
 K DR S DIE="^DVB(396.3,",DR="6///@;11///@;12///@;13///@;14///@;15///@;16///@;17////P;19///@;20///@;26///@",DA=REQDA D ^DIE
 Q
