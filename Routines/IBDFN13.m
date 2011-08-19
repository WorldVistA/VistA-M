IBDFN13 ;ALB/CJM - ENCOUNTER FORM - (input tranforms for AICS Data Types);MAY 10, 1995
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
 ;
CKOUTTM(X,IBFORMID) ;adds the date to the time and puts in FM format- gets the date from IBFORMID("APPT")
 ;pass X and IBFORMID by reference!!!
 ;
 S X=($G(IBFORMID("APPT"))\1)_"."_X
 Q
CKOUT(X) ;converts X to FM date and time
 ;pass X by reference!
 N %DT,Y
 S %DT="NR"
 D ^%DT
 S X=Y
 Q
