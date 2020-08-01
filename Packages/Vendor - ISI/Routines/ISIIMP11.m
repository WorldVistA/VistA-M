ISIIMP11 ;;ISI GROUP/MLS -- ALLERGIES IMPORT CONT.
 ;;1.0;;;Jun 26,2012;Build 93
 Q
 ;
VALIDATE()      ;
 ; Validate import array contents
 S ISIRC=$$VALALG^ISIIMPU6(.ISIMISC)
 Q ISIRC
 ;
MAKEALG() ;
 ; Create patient(s)
 S ISIRC=$$IMPRTALG(.ISIMISC)
 Q ISIRC
 ;
IMPRTALG(ISIMISC) ;Create allergy entry
 ; Input - ISIMISC(ARRAY)
 ; Format:  ISIMISC(PARAM)=VALUE
 ;     eg:  ISIMISC("GMRAORIG")=12345 
 ;
 ; Output - ISIRC [return code]
 ;          ISIRESUL(0)=1 [if successful]
 ;          ISIRESUL(1)="success" [if successful]       
 ;
 N NODE,DFN,GMRARRAY,GMRAIEN
 D PREP
 D ALLERGY
 Q ISIRC
 ;
PREP
 S GMRAIEN=0 ; used for update
 S DFN=ISIMISC("DFN")
 K ISIMISC("ALLERGEN"),ISIMISC("DFN"),ISIMISC("HISTORIC"),ISIMISC("ORIGINTR"),ISIMISC("ORIG_DATE")
 K ISIMISC("PAT_SSN"),ISIMISC("SYMPTOM")
 S NODE=$NAME(^TMP("GMRA",$J))
 K @NODE M @NODE=ISIMISC
 I $G(ISIPARAM("DEBUG"))>0 D  
 . W !,"+++ Final values +++"
 . W !,"DFN:",DFN,!
 . I $D(ISIMISC) W $G(ISIMISC) S X="" F  S X=$O(ISIMISC(X)) Q:X=""  W !,X,":",ISIMISC(X)
 . Q
 Q
 ;
ALLERGY ;Add Allergies for patient
 D UPDATE^GMRAGUI1(0,DFN,NODE)
 Q:+ISIRC<0 ;error
 S ISIRESUL(0)=1
 S ISIRESUL(1)="Success"
 Q
