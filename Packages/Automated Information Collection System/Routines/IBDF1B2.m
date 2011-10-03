IBDF1B2 ;ALB/CJM - ENCOUNTER FORM PRINT (IBDF1B1 continued - user options for printing); 3/1/93
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
 ;
PRNTFRMS ;print encounter form(s) for an appointment
 N FORMS,IBFORM,IBF
 ;FORMS - list of forms to print for patient
 ;IBF - a counter used to parse FORMS
 S FORMS=$$FORMS(IBCLINIC,DFN,IBAPPT)
 F IBF=1:1 S IBFORM=$P(FORMS,"^",IBF) Q:'IBFORM  D DRWFORM^IBDF2A(IBFORM,1,.IBDEVICE)
 Q
 ;
FORMS(CLINIC,DFN,IBAPPT) ;returns a list of forms that should be printed for this patient in this clinic and this appt.
 N FORMS,SETUP,TYPE
 S FORMS=""
 S SETUP=$O(^SD(409.95,"B",+CLINIC,0)),SETUP=$G(^SD(409.95,+SETUP,0))
 S:$P(SETUP,"^",2) FORMS=$P(SETUP,"^",2)_"^"
 S:$P(SETUP,"^",6) FORMS=FORMS_$P(SETUP,"^",6)_"^"
 S:$P(SETUP,"^",8) FORMS=FORMS_$P(SETUP,"^",8)_"^"
 S:$P(SETUP,"^",9) FORMS=FORMS_$P(SETUP,"^",9)_"^"
 I $P(SETUP,"^",3)!$P(SETUP,"^",4) D
 .D TYPE
 .I TYPE="NEW",$P(SETUP,"^",4) S FORMS=FORMS_$P(SETUP,"^",4)_"^"
 .I TYPE="OLD",$P(SETUP,"^",3) S FORMS=FORMS_$P(SETUP,"^",3)_"^"
 Q FORMS
TYPE ;determine if patient is NEW or OLD at clinic - quick and dirty
 N APPT,NODE
 S TYPE="NEW"
 S APPT=DT-10000 F  S APPT=$O(^DPT(DFN,"S",APPT)) Q:('APPT)!(APPT'<IBAPPT)  S NODE=$G(^DPT(DFN,"S",APPT,0)) I +NODE=CLINIC,(($P(NODE,"^",2)="I")!($P(NODE,"^",2)="NT")!($P(NODE,"^",2)="")) S TYPE="OLD" Q
 Q
