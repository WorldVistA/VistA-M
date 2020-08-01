ISIIMP18 ;ISI GROUP/MLS -- CONSULTS IMPORT API
 ;;1.0;;;Jun 26,2012;Build 93
 Q
CONSULTS(ISIRESUL,ISIMISC)       
 N ERR,VAL
 N:'$G(ISIPARAM("DEBUG")) ISIPARAM
 K ISIRESUL S (ISIRESUL(0),ISIRC)=0
 ;
 ;Validate setup & parameters
 S ISIRC=$$VALIDATE^ISIIMP19 Q:+ISIRC<0 ISIRC
 ;
  D:$G(ISIPARAM("DEBUG"))>0
 . ;Write out input parameters
 . W !,"+++Validated ISIMISC parameters+++",!
 . I $D(ISIMISC) S X="" F  S X=$O(ISIMISC(X)) Q:X=""  W !,$G(ISIMISC(X))
 . W !,"<HIT RETURN TO PROCEED>" R X:5
 . Q
 ;
 ;Create patient record
 S ISIRC=$$MAKECONS^ISIIMP19 Q:+ISIRC<0 ISIRC
 Q ISIRC
