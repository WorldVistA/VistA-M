ISIIMP09 ;;ISI GROUP/MLS -- VITALS IMPORT CONT.
 ;;1.0;;;Jun 26,2012;Build 93
 Q
 ;
VALIDATE()      ;
 ; Validate import array contents
 S ISIRC=$$VALVITAL^ISIIMPU5(.ISIMISC)
 Q ISIRC
 ;
MAKEVIT() ;
 ; Create patient(s)
 S ISIRC=$$IMPORTVT(.ISIMISC)
 Q ISIRC
 ;
IMPORTVT(ISIMISC) ;Create Vitals entry
 ; Input - ISIMISC(ARRAY)
 ; Format:  ISIMISC(PARAM)=VALUE
 ;     eg:  ISIMISC("DFN")=12345 
 ;
 ; Output - ISIRC [return code]       
 N DT,DFN,TYP,RT,LOC,ENT
 D PREP
 D VITALS
 Q ISIRC
 ;
PREP
 S DT=$G(ISIMISC("DT_TAKEN"))
 S DFN=$G(ISIMISC("DFN"))
 S TYP=$G(ISIMISC("VITAL_TYPE"))
 I $G(ISIMISC("RATE"))="" S ISIMISC("RATE")=$$GEN(TYP)
 S RT=$G(ISIMISC("RATE"))
 S LOC=$G(ISIMISC("LOCATION"))
 S ENT=$G(ISIMISC("ENTERED_BY"))
 Q
 ;
VITALS ;Add vitals for patient
 N RESULT K RESULT
 S DATA=DT_U_DFN_U_TYP_";"_RT_U_LOC_U_ENT
 D EN1^GMVDCSAV(.RESULT,DATA)
 I $G(RESULT(0))["ERROR" S ISIRC="-1^Error creating Vital entry (ISIIMP09)"
 Q:+ISIRC<0
 S ISIRESUL(0)="1"
 S ISIRESUL(1)="success"
 Q
 ;
GEN(TYPE) ;Generate values for vitals
 N READ
 S:TYPE=1 READ=($R(80)+110)_"/"_($R(30)+55)
 S:TYPE=2 READ=($R(2)+97)_"."_($R(9)+1)
 S:TYPE=3 READ=$R(8)+12
 S:TYPE=5 READ=$R(30)+65
 I TYPE=8 D  
 .S HGT=$S($P($G(^GMR(120.5,+$O(^PXRMINDX(120.5,"PI",DFN,8,+$O(^PXRMINDX(120.5,"PI",DFN,8,""),-1),0)),0)),U,8):$P(^(0),U,8),1:(60+$R(18)))
 .S READ=HGT
 I TYPE=9 D  
 . S WGT=$S($P($G(^GMR(120.5,+$O(^PXRMINDX(120.5,"PI",DFN,9,+$O(^PXRMINDX(120.5,"PI",DFN,9,""),-1),0)),0)),U,8):$P(^(0),U,8),1:(110+$R(150)))
 . S GORL=$R(2),LBS=$R(5),(READ,WGT)=WGT+($S(GORL=0:"-",1:"+")_LBS)
 S:TYPE=21 READ=$R(9)+91
 S:TYPE=22 READ=$R(3)
 Q READ
 
