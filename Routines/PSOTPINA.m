PSOTPINA ;BIR/MR - Driver to Inactivate TPB patients ;12/01/03
 ;;7.0;OUTPATIENT PHARMACY;**160,227**;DEC 1997
 ;
EN Q  ;placed out of order by PSO*7*227
 N PSOSDHL,PSOSDOE,TODAY,%,DIE,DA,DR,DO,PSOINA,X
 ; - Patient not defined
 I '$D(^DPT(+$G(DFN),0)) Q
 ;
 ; - Patient not in the TPB ELIGIBILITY file (#52.91)
 I '$D(^PS(52.91,DFN)) Q
 ;
 ; - Patient TPB's Benefit is INACTIVE
 I $$GET1^DIQ(52.91,DFN,2,"I") Q
 ;
 ; - At least ONE active TPB prescription found
 I $$ACTRX^PSOTPCUL(DFN,1) Q
 ;
 ; - Checking the OUTPATIENT ENCOUNTER
 S (PSOSDHL,PSOSDOE)="",PSOINA=0 D NOW^%DTC S TODAY=%\1
 F  S PSOSDHL=$O(^TMP("SDEVT",$J,PSOSDHL)) Q:'PSOSDHL  D  I PSOINA Q
 . F  S PSOSDOE=$O(^TMP("SDEVT",$J,PSOSDHL,1,"SDOE",PSOSDOE)) Q:'PSOSDOE  D  I PSOINA Q
 . . ;
 . . ; - Appointment is not CHECKED OUT
 . . I $$UP^XLFSTR($TR($$GET1^DIQ(409.68,PSOSDOE,.12),"- "))'="CHECKEDOUT" Q
 . . ;
 . . ; - STOP CODE for the Encounter Location not TPB
 . . I '$$TPBSC^PSOTPCUL($$GET1^DIQ(409.68,PSOSDOE,.04,"I")) Q
 . . ;
 . . ; Inactivate TPB benefits for the patient
 . . S DIE=52.91,DA=DFN,DR="2///"_TODAY_";3///1" D ^DIE S PSOINA=1
 . . ;
 . . ; - Send Mailman Message about TPB inactivation for Patient
 . . D MAIL(DFN,PSOSDOE)
 ;
 Q
 ;
MAIL(DFN,ENC) ; - Create/Send Mailman Message about Inactivation to 
 ;           PSO TPB GROUP (Mail Group)
 ;
 N XMTEXT,XMDUZ,XMSUB,XMY,VADM,CNAM,PNAM,DAT,MSG,DIFROM,X
 ;
 D DEM^VADPT S PNAM=$P(VADM(1),"^")_" ("_$P($P(VADM(2),"^",2),"-",3)_")"
 S DAT=$$GET1^DIQ(409.68,ENC,.01),CNAM=$$GET1^DIQ(409.68,ENC,.04)
 ;
 S XMDUZ="PHARMACY TPB SCHEDULING MONITOR"
 D SXMY^PSOTPCUL("PSO TPB GROUP")
 S XMSUB="TPB PATIENT BENEFIT INACTIVATION"
 ;
 S MSG(1)="The following patient had the TPB (Transitional Pharmacy Benefit) benefit"
 S MSG(2)="automatically inactivated because the following appointment was found: "
 S MSG(3)=" "
 S MSG(4)="     Patient         : "_PNAM
 S MSG(5)="     VA Clinic       : "_CNAM
 S MSG(6)="     Appointment Date: "_DAT
 ;
 S XMTEXT="MSG(" D ^XMD
 Q
