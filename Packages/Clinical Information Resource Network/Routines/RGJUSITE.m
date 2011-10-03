RGJUSITE ;ALB/JLU-CIRN SITE PARAMETER (#991.8) FILE API ;10/01/96
 ;;1.0;CLINICAL INFO RESOURCE NETWORK;**7,19**;30 Apr 99
 ;
SEND() ;this function call is used to determine if the MPI/PD messages should
 ;be fired.  It will check the parameter 'stop mpi/pd messaging' in 991.8
 ;INPUTS - There are no inputs.
 ;OUTPUTS - This function will return a zero if the messages are
 ;          to be stopped.
 ;          A positive one will be returned if the messages are 
 ;          not to be stopped.
 ;          A two will be returned for suspend.
 ;
 N VAL,IEN,STOP ;**7
 S STOP=1
 S IEN=$O(^RGSITE(991.8,"B",1,0))
 G STOPQ:'IEN
 S VAL=$P($G(^RGSITE(991.8,IEN,1)),U,6)
 S STOP=$S('VAL:0,1:1,2:2)
 ;
STOPQ Q STOP
 ;
