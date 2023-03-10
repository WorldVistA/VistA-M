SDESAPPTUTIL ;ALB/TAW - SDED APPOINTMENT UTILITIES ;JULY 18, 2021@15:22
 ;;5.3;Scheduling;**790**;Aug 13, 1993;Build 11
 ; This rtn will hold various utilities for dealing with SDEC APPOINTMENTS File (409.84)
 Q
MISSINGRES(APPTIEN) ;Try to get a resource from Patient / Clinic file
 ; This function will get the DFN and Start Time from the appointment file and look at the Appointment sub-file
 ; under the Patient file to try and find the 
 ; Input:
 ;   APTIEN - (Required) IEN from SDEC Appointment
 ; Return:
 ;   The resource that shold be associated with the appointment
 ;
 N DFN,CLINICIEN,RESIEN,APPT0,APPTSTART,RESTYPE,RESLIST,RESCNT,X,REC,APPTFOUND
 S (APPTFOUND,X,RESIEN,RESCNT)=""
 I APPTIEN="" Q "0^APPOINTMENT IEN IS REQUIRED"
 S APPT0=$G(^SDEC(409.84,APPTIEN,0))
 S DFN=$P(APPT0,U,5)
 S APPTSTART=$P(APPT0,U,1)
 I DFN="" Q "0^NO DFN FOR THIS APPOINTMENT"
 S CLINICIEN=$$GET1^DIQ(2.98,APPTSTART_","_DFN_",",.01,"I")
 I CLINICIEN="" Q "0^HOSPITAL LOCATION NOT FOUND IN APPOINTMENT SUB FILE FOR PATIENT"
 ;
 ;Confirm the patient does have an active appointment at the Hosp Loc for the Appt Start Date/Time
 F  S X=$O(^SC(CLINICIEN,"S",APPTSTART,1,X)) Q:X=""!(APPTFOUND)  D
 .S REC=$G(^SC(CLINICIEN,"S",APPTSTART,1,X,0))
 .I $P(REC,"^",1)'=DFN Q
 .I $P(REC,"^",9)="C" Q
 .S APPTFOUND=1
 I 'APPTFOUND Q "0^PATIENT DOES NOT HAVE AN ACTIVE APPT IN THE CLINIC"
 ;
 ;Since there can be multiple resources linked to a hospital location, fine the one that is a clinic
 F  S RESIEN=$O(^SDEC(409.831,"ALOC",CLINICIEN,RESIEN)) Q:RESIEN=""  D
 .S RESTYPE=$P($G(^SDEC(409.831,RESIEN,0)),"^",11)
 .I $P(RESTYPE,";",2)'="SC(" Q    ;Must be a Hospital Loc
 .S RESLIST($I(RESCNT))=RESIEN
 I 'RESCNT Q "0^NO CLINIC RESOURCES FOR THIS HOSPITAL LOCATION"
 ;I RESCNT>1 Q "0^MULTIPLE CLINIC RESROUCES FOR THIS HOSPITAL LOCATION"
 Q RESLIST(1)
