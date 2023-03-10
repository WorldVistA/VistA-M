SDESINACTCLINIC ;ALB/ANU,MGD - Inactivate Clinic in HOSPITAL LOCATION FILE 44 ;July 19, 2022
 ;;5.3;Scheduling;**799,805,820**;Aug 13, 1993;Build 10
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 ; Documented API's and Integration Agreements
 ; -------------------------------------------
 ;Reference to $$GETS^DIQ is supported by IA #2056
 ;Reference to $$GETS1^DIQ is supported by IA #2056
 Q
 ;
JSONINACTCLN(SDCINJSON,SDCLINICIEN,SDEAS) ;Inactivate Clinic
 ;INPUT - SDCLINICIEN (Clinic IEN)
 ; SDEAS - [optional] Enterprise Appointment Scheduling (EAS) Tracking Number associated to an appointment.
 ;RETURN PARMETER:
 ; Status
 ;
 N ERRPOP,ERR,ERRMSG
 D INIT
 D VALIDATE
 I ERRPOP D BLDJSON Q
 D BLDCINREC
 D BLDJSON
 Q
 ;
INIT ; initialize values needed
 S ERR=""
 S ERRPOP=0,ERRMSG=""
 Q
 ;
VALIDATE ; validate incoming parameters
 I $$GET1^DIQ(44,SDCLINICIEN,.01)="" D
 . ;create error message - Clinic Name/Clinic IEN not found
 . D ERRLOG^SDESJSON(.SDCINREC,80)
 . S ERRPOP=1
 S SDEAS=$G(SDEAS,"")
 I $L(SDEAS) S SDEAS=$$EASVALIDATE^SDESUTIL(SDEAS)
 I SDEAS=-1 D ERRLOG^SDESJSON(.SDCINREC,142) S ERRPOP=1
 Q
 ;
BLDJSON ;
 D ENCODE^SDESJSON(.SDCINREC,.SDCINJSON,.ERR)
 K SDCINREC
 Q
 ;
BLDCINREC ;Inactivate Clinic
 ;
 N SDERR,SDFDA,SDCLNNAME
 S SDCLNNAME=""
 S SDCLNNAME=$$GET1^DIQ(44,SDCLINICIEN,.01)
 I $E(SDCLNNAME,1,2)'="ZZ" S SDFDA(44,SDCLINICIEN_",",.01)="ZZ"_$E($$GET1^DIQ(44,SDCLINICIEN,.01),1,28)
 S SDFDA(44,SDCLINICIEN_",",2505)=DT
 D UPDATE^DIE("","SDFDA","","SDERR")
 I $G(SDERR) D ERRLOG^SDESJSON(.SDCINREC,81) Q
 S SDCINREC("Success")="Clinic is successfully inactivated."
 Q
 ;
