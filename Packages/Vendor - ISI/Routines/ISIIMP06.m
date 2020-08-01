ISIIMP06 ;ISI GROUP/MLS -- Problem Import API
 ;;1.0;;;Jun 26,2012;Build 93
 Q
 ;
PROBLEM(ISIRESUL,ISIMISC)       
 ;Validate input array
 S ISIRC=$$VALIDATE^ISIIMP07 Q:+ISIRC<0 ISIRC
 ;
 D:$G(ISIPARAM("DEBUG"))>0
 . W !,"+++Post validated/updated array+++ (06)"
 . I $D(ISIMISC) W $G(ISIMISC) S X="" F  S X=$O(ISIMISC(X)) Q:X=""  W !,ISIMISC(X)
 . Q
 ;
 ;Create Appointment
 S ISIRC=$$MAKEPROB^ISIIMP07
 Q ISIRC
 ;
