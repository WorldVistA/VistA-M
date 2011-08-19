SDCO5 ;ALB/RMO - Make Clinic Appt - Check Out;08 DEC 1992 4:05 pm
 ;;5.3;Scheduling;**27**;08/13/93
 ;
MC(SDOE,SDASKF,SDCOMKF,SDCOQUIT) ;Entry point for SDCO CLINIC APPT protocol
 ; Input  -- SDOE     Outpatient Encounter file IEN
 ;           SDASKF   Ask if user wishes to make an appt
 ; Output -- SDCOMKF  User Makes an Appointment
 ;                    1=Yes
 ;           SDCOQUIT User entered '^' or timeout
 N DFN,DIRUT,SDAMERR,SDCL,SDCLN,SDDA,SDFN,SDOE0,SDSC,SDT
 S VALMBCK=""
 I $G(SDASKF),'$$ASK S:$D(DIRUT) SDCOQUIT="" G MCQ
 S SDOE0=$G(^SCE(+SDOE,0)),SDFN=+$P(SDOE0,"^",2)
 I $P(SDOE0,U,4),$P(SDOE0,U,8)'=3 S SDCLN=+$P(SDOE0,"^",4)
 D FULL^VALM1
 D ^SDM
 I $D(SDAMERR) D PAUSE^VALM1
 I '$D(SDAMERR) S SDCOMKF=1
 D SDM^SDKILL S VALMBCK="R"
MCQ Q
 ;
ASK() ;Ask if user wishes to make an appt
 N DIR,DTOUT,DUOUT,Y
 S DIR("A")="Do you wish to make a follow-up appointment"
 S DIR("B")="YES",DIR(0)="Y" D ^DIR
 Q +$G(Y)
