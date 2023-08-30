SDES846PENC ;ALB/BWF - SD*5.3*846 Post Init Routine ; June 15, 2023
 ;;5.3;SCHEDULING;**846**;AUG 13, 1993;Build 12
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 Q
 ;
TASK ;
 D MES^XPDUTL("")
 D MES^XPDUTL("   SD*5.3*846 Post-Install to remove orphaned encounters for")
 D MES^XPDUTL("   appointments that were cancelled by VAOS.")
 D MES^XPDUTL("")
 N ZTDESC,ZTRTN,ZTIO,ZTSK,X,ZTDTH,ZTSAVE
 S ZTDESC="SD*5.3*846 Post Install Routine - Encounter Cleanup"
 D NOW^%DTC S ZTDTH=X,ZTIO="",ZTRTN="FIXENC^SDES846PENC",ZTSAVE("*")="" D ^%ZTLOAD
 I $D(ZTSK) D
 . D MES^XPDUTL("  >>>Task "_ZTSK_" has been queued.")
 . D MES^XPDUTL("")
 I '$D(ZTSK) D
 . D MES^XPDUTL("  UNABLE TO QUEUE THIS JOB.")
 . D MES^XPDUTL("  Please contact the National Help Desk to report this issue.")
 Q
 ;
FIXENC ;
 N DFN,APPTDTTM,ENCOUNTER,CLINIC,IEN44,ENCFOUND,TOTCNT,CANRES,ENCLINKED,APPTIEN,RESOURCE,ENCLINKED
 N CANREASON,APPTCLIN,ENCCLIN,TOTAPPTS,SDESOITEASTOT,CANBY,CANDTTM,ORPHANENC,APPTENC,APPTCAN
 K ^XTMP("SDES846PENC")
 S ^XTMP("SDES846PENC",0)=$$FMADD^XLFDT(DT,30)_"^"_DT_"^SD*5.3*846 Post Install Orphaned Encounter Data report"
 S (TOTCNT,TOTAPPTS,SDESOITEASTOT)=0
 S TOTCNT=TOTCNT+1 S ^XTMP("SDES846PENC",TOTCNT)="APPT DATE/TIME^APPT IEN^PATIENT IEN^ENCOUNTER IEN^CANCELLED BY^UPDATE STATUS"
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
 ...S ^XTMP("SDES846PENC",TOTCNT)=APPTDTTM_U_APPTIEN_U_DFN_U_ENCFOUND_U_CANBY_U_"0;Could not locate clinic appointment in the HOSPITAL LOCATION file (#44)."
 ...M ^XTMP("SDES846PENC",TOTCNT)=^SCE(ENCFOUND)
 ..; if checked-in?? - do we cancel the checkin and proceed to clean up, or report that this entry needs to be handled manually?
 ..I $$CI^SDECU2(DFN,CLINIC,APPTDTTM,IEN44) D
 ...D CANCHECKIN^SDESCANCHECKIN(.CANRES,APPTIEN)
 ..; check again before updating the record - if we could not cancel the check-in log it and quit
 ..I $$CI^SDECU2(DFN,CLINIC,APPTDTTM,IEN44) D  Q
 ...S ^XTMP("SDES846PENC",TOTCNT)=APPTDTTM_U_APPTIEN_U_DFN_U_ENCFOUND_U_CANBY_U_"0;Could not cancel Check-in. Encounter not updated."
 ..I ENCLINKED S FDA(2.98,APPTDTTM_","_DFN_",",21)="@" D FILE^DIE(,"FDA") K FDA
 ..S ^XTMP("SDES846PENC",TOTCNT)=APPTDTTM_U_APPTIEN_U_DFN_U_ENCFOUND_U_CANBY_U_1
 ..S SDESOITEASTOT=$G(SDESOITEASTOT)+1
 ..D EN^SDCODEL(ENCFOUND,2,"","CANCEL")  ;remove OUTPATIENT ENCOUNTER link
 S ORPHANENC=$G(TOTCNT)
 S TOTCNT=TOTCNT+1
 S $P(^XTMP("SDES846PENC",TOTCNT),"-",80)=""
 S TOTCNT=TOTCNT+1
 S ^XTMP("SDES846PENC",TOTCNT)="TOTAL ORPHANED ENCOUNTERS: "_ORPHANENC
 S TOTCNT=TOTCNT+1
 S ^XTMP("SDES846PENC",TOTCNT)="TOTAL APPOINTMENTS SEARCHED: "_TOTAPPTS
 S TOTCNT=TOTCNT+1
 S ^XTMP("SDES846PENC",TOTCNT)="TOTAL ORPHANED ENCOUNTERS REMOVED: "_SDESOITEASTOT
 D MAIL
 Q
SCIEN(PAT,CLINIC,DATE) ;returns ien for appt in ^SC
 N X,IEN
 S X=0 F  S X=$O(^SC(CLINIC,"S",DATE,1,X)) Q:'X  Q:$G(IEN)  D
 .; only look at cancelled appts
 .Q:$P($G(^SC(CLINIC,"S",DATE,1,X,0)),U,9)'="C"
 .I +$G(^SC(CLINIC,"S",DATE,1,X,0))=PAT S IEN=X
 Q $G(IEN)
MAIL ;
 ; Get Station Number
 ;
 N STANUM,MESS1,XMTEXT,XMSUB,XMY,XMDUZ,DIFROM
 S STANUM=$$KSP^XUPARAM("INST")_","
 S STANUM=$$GET1^DIQ(4,STANUM,99)
 S MESS1="Station: "_STANUM_" - "
 ;
 ; Send MailMan message
 S XMDUZ=DUZ
 S XMTEXT="^XTMP(""SDES846PENC"","
 S XMSUB=MESS1_"SD*5.3*846 post install - Orphaned Encounter Clean-up Report"
 S XMDUZ=.5,XMY(DUZ)="",XMY(XMDUZ)=""
 S XMY("DUNNAM.DAVID W@DOMAIN.EXT")=""
 S XMY("REESE,DARRYL M@DOMAIN.EXT")=""
 S XMY("FISHER.BRADLEY@DOMAIN.EXT")=""
 D ^XMD
 Q
