VAFHREG ;ALB/JLU;Checking registration;
 ;;5.3;Registration;**91**;Jun 06, 1996
 ;
EN() ;this tag looks at what option the user is in at the time.  If it is
 ;registration, scheduling then it is assumed that the event will be
 ;picked up by the event drivers.
 ;
 N VAR
 S VAR=0 ;not a registration
 I $P($G(XQY0),"^")="DG REGISTER PATIENT" S VAR=1 G EX ;looking at the option.
 I $P($G(XQY0),"^")="DGRPT 10-10T REGISTRATION" S VAR=1 G EX
EX Q VAR
