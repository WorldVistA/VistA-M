SDES846PRE ;ALB/BWF - SD*5.3*846 Post Init Routine ; June 15, 2023
 ;;5.3;SCHEDULING;**846**;AUG 13, 1993;Build 12
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 Q
EN ; Scheduling Consult Clean-up
 D TASK
 Q
 ;
TASK ;
 D MES^XPDUTL("")
 D MES^XPDUTL("   SD*5.3*846 Pre-Install to log orphaned encounter data")
 D MES^XPDUTL("   for appointments that were cancelled by VAOS.")
 D MES^XPDUTL("")
 N ZTDESC,ZTRTN,ZTIO,ZTSK,X,ZTDTH,ZTSAVE
 S ZTDESC="SD*5.3*846 Pre-Install Routine"
 D NOW^%DTC S ZTDTH=X,ZTIO="",ZTRTN="ENCREP^SDES846PRE",ZTSAVE("*")="" D ^%ZTLOAD
 I $D(ZTSK) D
 . D MES^XPDUTL("  >>>Task "_ZTSK_" has been queued.")
 . D MES^XPDUTL("")
 I '$D(ZTSK) D
 . D MES^XPDUTL("  UNABLE TO QUEUE THIS JOB.")
 . D MES^XPDUTL("  Please contact the National Help Desk to report this issue.")
 Q
 ;
ENCREP ;
 N DFN,APPTDTTM,ENCOUNTER,CLINIC,IEN44,ENCFOUND,TOTCNT,CANRES,ENCLINKED,APPTIEN,RESOURCE,ENCLINKED
 N CANREASON,APPTCLIN,ENCCLIN,TOTAPPTS,CANBY,CANDTTM,ORPHANENC,APPTENC,APPTCAN
 K ^XTMP("SDES846PRE")
 S ^XTMP("SDES846PRE",0)=$$FMADD^XLFDT(DT,30)_"^"_DT_"^SD*5.3*846 Pre-Install Orphaned Encounter Data report"
 S (TOTCNT,TOTAPPTS)=0
 S CANDTTM=3230509.99
 F  S CANDTTM=$O(^SDEC(409.84,"AD",CANDTTM)) Q:'CANDTTM  D
 .S APPTIEN=0 F  S APPTIEN=$O(^SDEC(409.84,"AD",CANDTTM,APPTIEN)) Q:'APPTIEN  D
 ..S APPTDTTM=$$GET1^DIQ(409.84,APPTIEN,.01,"I")
 ..S DFN=$$GET1^DIQ(409.84,APPTIEN,.05,"I")
 ..S CANBY=$$GET1^DIQ(409.84,APPTIEN,.121,"E")
 ..; only process encounters for appointments that have been CANCELLED by SDESOITEAS,SRV
 ..Q:CANBY'="SDESOITEAS,SRV"
 ..S RESOURCE=$$GET1^DIQ(409.84,APPTIEN,.07,"I") Q:'RESOURCE
 ..S CLINIC=$$GET1^DIQ(409.831,RESOURCE,.04,"I") Q:'CLINIC
 ..S TOTAPPTS=TOTAPPTS+1
 ..S (ENCLINKED,ENCFOUND)=0
 ..S ENCOUNTER=0 F  S ENCOUNTER=$O(^SCE("C",DFN,ENCOUNTER)) Q:'ENCOUNTER!(ENCFOUND)  D
 ...; must match date/time
 ...I $$GET1^DIQ(409.68,ENCOUNTER,.01,"I")'=APPTDTTM Q
 ...; encounter clinic must match the appointment clinic
 ...S ENCCLIN=$$GET1^DIQ(409.68,ENCOUNTER,.04,"I")
 ...I CLINIC'=ENCCLIN Q
 ...S APPTENC=$$GET1^DIQ(2.98,APPTDTTM_","_DFN_",",21,"I")
 ...S APPTCAN=$$GET1^DIQ(2.98,APPTDTTM_","_DFN_",",15,"I")
 ...; if the encounter is still on the appointment and this is not the correct encounter, quit
 ...I APPTENC'="",APPTENC'=ENCOUNTER Q
 ...; if the patient appointment is linked to the encounter and the appointment is not cancelled, quit
 ...I APPTENC'="",APPTENC=ENCOUNTER,APPTCAN="" Q
 ...; if there is an encounter on the appointment, it is not this encounter and the  appointment is cancelled, set ENCLINKED/ENCFOUND and quit
 ...I APPTENC'="",APPTENC=ENCOUNTER,APPTCAN'="" S ENCFOUND=ENCOUNTER,ENCLINKED=1 Q
 ...; this means if the appointment is linked to the encounter and the appointment IS cancelled, we want to close this encounter
 ...S ENCFOUND=ENCOUNTER
 ..; if there is no encounter found for this cancelled or no-show appointment, quit
 ..Q:'ENCFOUND
 ..S TOTCNT=TOTCNT+1
 ..; get the appointment from file 44, if it cannot be found log it.
 ..S IEN44=$$SCIEN(DFN,CLINIC,APPTDTTM)
 ..I 'IEN44 D  Q
 ...S ^XTMP("SDES846PRE",TOTCNT)=APPTDTTM_U_APPTIEN_U_DFN_U_ENCFOUND_U_CANBY_U_"0;Could not locate clinic appointment in the HOSPITAL LOCATION file (#44)."
 ...M ^XTMP("SDES846PRE",TOTCNT)=^SCE(ENCFOUND)
 ..; if checked-in log it as such
 ..I $$CI^SDECU2(DFN,CLINIC,APPTDTTM,IEN44) D  Q
 ...S ^XTMP("SDES846PRE",TOTCNT)=APPTDTTM_U_APPTIEN_U_DFN_U_ENCFOUND_U_CANBY_U_"0;Appointment checked in."
 ...M ^XTMP("SDES846PRE",TOTCNT)=^SCE(ENCFOUND)
 ..S ^XTMP("SDES846PRE",TOTCNT)=APPTDTTM_U_APPTIEN_U_DFN_U_ENCFOUND_U_CANBY_U_1
 ..M ^XTMP("SDES846PRE",TOTCNT)=^SCE(ENCFOUND)
 S ORPHANENC=$G(TOTCNT)
 S TOTCNT=TOTCNT+1
 S $P(^XTMP("SDES846PRE",TOTCNT),"-",80)=""
 S TOTCNT=TOTCNT+1
 S ^XTMP("SDES846PRE",TOTCNT)="TOTAL ORPHANED ENCOUNTERS: "_ORPHANENC
 S TOTCNT=TOTCNT+1
 S ^XTMP("SDES846PRE",TOTCNT)="TOTAL APPOINTMENTS SEARCHED: "_TOTAPPTS
 Q
SCIEN(PAT,CLINIC,DATE) ;returns ien for appt in ^SC
 N X,IEN
 S X=0 F  S X=$O(^SC(CLINIC,"S",DATE,1,X)) Q:'X  Q:$G(IEN)  D
 .; only look at cancelled appts
 .Q:$P($G(^SC(CLINIC,"S",DATE,1,X,0)),U,9)'="C"
 .I +$G(^SC(CLINIC,"S",DATE,1,X,0))=PAT S IEN=X
 Q $G(IEN)
