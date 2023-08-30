SDESCOMPPEN ;ALB/BWF - VISTA SCHEDULING COMPENSATION AND PENSION RPCS ; Jan 23, 2023
 ;;5.3;Scheduling;**836,837,839**;Aug 13, 1993;Build 3
 ;;Per VHA Directive 6402, this routine should not be modified
 ; Reference to DVBCUTL5 in ICR #7042
 ; Reference to DVBCCNNS in ICR #7038
 ; Reference to 2507 REQUEST in ICR #7044
 ; Reference to AMIE C&P EXAM TRACKING in ICR #7045
 ;
 Q
 ;
GET(RESULT,DFN,SDCL,SDT) ;GET entries from 2507 REQUEST file 396.3
 ;INPUT:
 ; DFN    - (required) Patient ID pointer to PATIENT file 2
 ; SDCL   - (required) Clinic ID pointer to HOSPITAL LOCATION file 44
 ; SDT    - (required) Appointment Date/Time in external format
 ;
 N SDDA,ERRORS,RETURN
 S DFN=$G(DFN),SDCL=$G(SDCL),SDT=$G(SDT)
 ;validate DFN
 D VALIDATEDFN^SDESINPUTVALUTL(.ERRORS,DFN)
 ;validate SDCL
 D VALIDATECLINIC(.ERRORS,SDCL)
 I $D(ERRORS) D  Q
 .S ERRORS("CompensationPensionRequest",1)=""
 .D BUILDJSON^SDESBUILDJSON(.RESULT,.ERRORS)
 ;validate SDT
 S SDT=$$VALDATE2^SDESVALUTIL(.ERRORS,SDT,SDCL,76,77)
 I $D(ERRORS) D  Q
 .S ERRORS("CompensationPensionRequest",1)=""
 .D BUILDJSON^SDESBUILDJSON(.RESULT,.ERRORS)
 S SDDA=0 F  S SDDA=$O(^SC(SDCL,"S",SDT,1,SDDA)) Q:SDDA'>0  Q:$P($G(^SC(SDCL,"S",SDT,1,SDDA,0)),U,1)=DFN
 I 'SDDA D ERRLOG^SDESJSON(.ERRORS,418)
 I $D(ERRORS) D  Q
 .S ERRORS("CompensationPensionRequest",1)=""
 .D BUILDJSON^SDESBUILDJSON(.RESULT,.ERRORS)
 D GETREQUESTS(.RETURN,DFN,SDCL)
 I '$D(RETURN) S RETURN("CompensationPensionRequest",1)=""
 D BUILDJSON^SDESBUILDJSON(.RESULT,.RETURN)
 Q
 ;
 ;from DVBCMKLK
GETREQUESTS(RETURN,DFN,CLINIEN) ;
 N DVBADFN,DVBASDPR,DVBASTAT,CNT,DVBADA,SDINVERSE,SDREQDATE,REQIEN,SDLOOP,SDAMIEIEN,INITIALAPPTDT,ORIGAPPTDT,CURRAPPTDT,CLINNAME,LINKCNT,TMP
 S DVBADFN=DFN,DVBASTAT="P" ;**DVBASTAT used in REQARY^DVBCUTL5
 ; DVBADA/DVBASDPR initialized before calling REQARY^DVBCUTL5 since the function does not initialize
 S (DVBADA,DVBASDPR)=""
 K ^TMP("DVBC",$J),TMP("DVBC LINK")
 D REQARY^DVBCUTL5 ;**Set up ^TMP of AMIE 2507's
 ;^TMP("DVBC",8945,6889775.889799,3110224.1102,34231)=""
 ;                 Inverse REQUEST DATE, REQUEST DATE, IEN)
 S CNT=0
 S SDINVERSE="" F  S SDINVERSE=$O(^TMP("DVBC",$J,SDINVERSE)) Q:SDINVERSE=""  D
 .S SDREQDATE="" F  S SDREQDATE=$O(^TMP("DVBC",$J,SDINVERSE,SDREQDATE)) Q:SDREQDATE=""  D
 ..S REQIEN="" F  S REQIEN=$O(^TMP("DVBC",$J,SDINVERSE,SDREQDATE,REQIEN)) Q:REQIEN=""  D
 ...S CNT=CNT+1
 ...S RETURN("CompensationPensionRequest",CNT,"RequestID")=REQIEN ; 2507 REQUEST ID
 ...S RETURN("CompensationPensionRequest",CNT,"PatientID")=DFN
 ...S RETURN("CompensationPensionRequest",CNT,"PatientName")=$$GET1^DIQ(2,DFN_",",.01)
 ...S RETURN("CompensationPensionRequest",CNT,"RequestDate")=$$FMTISO^SDAMUTDT(SDREQDATE,CLINIEN)
 ...S RETURN("CompensationPensionRequest",CNT,"IsTrackedAmie")=+$E($D(^DVB(396.95,"AR",REQIEN)),1)
 ...K TMP("DVBC LINK")
 ...S LINKCNT=0
 ...D LNKARY^DVBCUTA3(REQIEN,DFN)
 ...S SDLOOP="" F  S SDLOOP=$O(TMP("DVBC LINK",SDLOOP)) Q:SDLOOP=""  D
 ....S SDAMIEIEN="" F  S SDAMIEIEN=$O(TMP("DVBC LINK",SDLOOP,SDAMIEIEN)) Q:SDAMIEIEN=""  D
 .....S INITIALAPPTDT=$$CONVDATE($P(TMP("DVBC LINK",SDLOOP,SDAMIEIEN),U))
 .....S ORIGAPPTDT=$$CONVDATE($P(TMP("DVBC LINK",SDLOOP,SDAMIEIEN),U,2))
 .....S CURRAPPTDT=$$CONVDATE($P(TMP("DVBC LINK",SDLOOP,SDAMIEIEN),U,3))
 .....S CLINNAME=$P(TMP("DVBC LINK",SDLOOP,SDAMIEIEN),U,4)
 .....S LINKCNT=LINKCNT+1
 .....S RETURN("CompensationPensionRequest",CNT,"Links",LINKCNT,"AMIETrackingID")=SDAMIEIEN
 .....S RETURN("CompensationPensionRequest",CNT,"Links",LINKCNT,"InitialAppointmentDate")=$$FMTISO^SDAMUTDT(INITIALAPPTDT,CLINIEN)
 .....S RETURN("CompensationPensionRequest",CNT,"Links",LINKCNT,"OriginalAppointmentDate")=$$FMTISO^SDAMUTDT(ORIGAPPTDT,CLINIEN)
 .....S RETURN("CompensationPensionRequest",CNT,"Links",LINKCNT,"CurrentAppointmentDate")=$$FMTISO^SDAMUTDT(CURRAPPTDT,CLINIEN)
 .....S RETURN("CompensationPensionRequest",CNT,"Links",LINKCNT,"ClinicName")=CLINNAME
 .....S RETURN("CompensationPensionRequest",CNT,"Links",LINKCNT,"ClinicID")=$$FIND1^DIC(44,,"B",CLINNAME)
 K ^TMP("DVBC",$J)
 K TMP("DVBC LINK")
 Q
 ; convert external date/time to fileman
CONVDATE(INDATE)    ;
 N X,Y,%DT
 I INDATE="" Q ""
 S %DT="ST"
 S X=INDATE D ^%DT
 I Y<1 Q ""
 Q Y
 ;
SET(RESULT,REQIEN,AMIETRKIEN,VETREQ,SDCL,SDT)  ;SET entries to AMIE C&P EXAM TRACKING file 396.95 and update file 396.3
 ;INPUT:
 ;  1. REQIEN       - (required) 2507 REQUEST id pointer to 2507 REQUEST file 396.3
 ;  2. AMIETRKIEN   - (optional) Link ID  - Pointer to AMIE C&P EXAM TRACKING file 396.95
 ;                  - This should ONLY be passed in if there is an AMIE tracking ID that is being updated.
 ;  3. VETREQ   - (optional) Veteran Request flag - (field .04 in file 396.95)
 ;                "Is this appointment due to a veteran requested cancellation or 'No Show'"
 ;                0=NO; 1=YES
 ;  4. SDCL     - (required) pointer to HOSPITAL LOCATION file 44
 ;  5. SDT      - (required) Appointment date/time in external format.
 ;                 The appointment date/time will be used as the original date if this is a new appointment
 ;                 The appointment date/time will be used as the 'reschedule' date if this is a re-schedule/update (AMIETRKIEN is passed in)
 ;
 N DFN,DVBALKRC,DVBAVTRQ,COMPPEN,SDDA,ERRORS
 S REQIEN=$G(REQIEN),SDT=$G(SDT),SDCL=$G(SDCL),AMIETRKIEN=$G(AMIETRKIEN),VETREQ=$G(VETREQ)
 ;validate REQIEN
 D VALREQIEN(.ERRORS,REQIEN)
 ;validate VETREQ
 D VALVETREQ(.ERRORS,VETREQ)
 ;validate SDCL
 D VALIDATECLINIC(.ERRORS,SDCL)
 I $D(ERRORS) D  Q
 .S ERRORS("CompensationPensionSet",1)=""
 .D BUILDJSON^SDESBUILDJSON(.RESULT,.ERRORS)
 ;validate SDT
 S SDT=$$VALDATE2^SDESVALUTIL(.ERRORS,SDT,SDCL,76,77)
 I $D(ERRORS) D  Q
 .S ERRORS("CompensationPensionSet",1)=""
 .D BUILDJSON^SDESBUILDJSON(.RESULT,.ERRORS)
 S DFN=$$GET1^DIQ(396.3,REQIEN_",",.01,"I")
 S SDDA=$$FIND^SDESCHECKOUT(DFN,SDT,SDCL)
 I 'SDDA D ERRLOG^SDESJSON(.ERRORS,418)
 I $G(AMIETRKIEN)'="" D VALAMIEIEN(.ERRORS,AMIETRKIEN)
 I $D(ERRORS) D  Q
 .S ERRORS("CompensationPensionSet",1)=""
 .D BUILDJSON^SDESBUILDJSON(.RESULT,.ERRORS)
 I AMIETRKIEN="" D  Q
 .D CRTREC(SDT,REQIEN,.AMIETRKIEN)
 .S COMPPEN("CompensationPensionSet","AMIETrackingRecordAdded")=AMIETRKIEN
 .D BUILDJSON^SDESBUILDJSON(.RESULT,.COMPPEN)
 I AMIETRKIEN'="" D  Q
 .D UPDTLK(AMIETRKIEN,SDT,VETREQ)
 .S COMPPEN("CompensationPensionSet","AMIETrackingRecordUpdated")=AMIETRKIEN
 .D BUILDJSON^SDESBUILDJSON(.RESULT,.COMPPEN)
 I '$D(COMPPEN) S COMPPEN("CompensationPensionSet",1)=""
 D BUILDJSON^SDESBUILDJSON(.RESULT,.COMPPEN)
 Q
CRTREC(SDT,REQIEN,AMIETRKIEN) ;** Add a record to file 396.95 (Appt Tracking)
 N FDA,NEWAMIEIEN,AMIEERR
 S FDA(396.95,"+1,",.01)=SDT
 S FDA(396.95,"+1,",.02)=SDT
 S FDA(396.95,"+1,",.03)=SDT
 S FDA(396.95,"+1,",.04)=0
 S FDA(396.95,"+1,",.06)=REQIEN
 S FDA(396.95,"+1,",.07)=1
 D UPDATE^DIE(,"FDA","NEWAMIEIEN","AMIEERR")
 S AMIETRKIEN=$G(NEWAMIEIEN(1))
 Q
UPDTLK(AMIETRKIEN,RSCHDT,VETREQ) ;** Update selected 396.95 link
 N FDA
 S FDA(396.95,AMIETRKIEN_",",.03)=RSCHDT
 S FDA(396.95,AMIETRKIEN_",",.07)=1
 I $$GET1^DIQ(396.95,AMIETRKIEN,.04,"I")=0&('$G(VETREQ)) D
 .S FDA(396.95,AMIETRKIEN_",",.02)=RSCHDT
 I $G(VETREQ) D
 .S FDA(396.95,AMIETRKIEN_",",.04)=1
 .S FDA(396.95,AMIETRKIEN_",",.05)=RSCHDT
 D FILE^DIE(,"FDA") K FDA
 Q
AMIECAN(RETURN,DFN,APPTDTTM)   ; update amie tracking for cancellations
 N AMIEIEN,DVBAAUTO,DVBAFND,DVBALKDA,REQIEN,DVBASTAT,DVBAUPDT,LNKCNT,APPTDTTME,MSGCNT
 ; DVBASTAT and DVBALKDA used by CANCEL^DVBCCNNS
 S DVBASTAT=$$GET1^DIQ(2.98,APPTDTTM_","_DFN_",",3,"I")
 S (AMIEIEN,DVBALKDA)=""
 S (DVBAUPDT,LNKCNT,DVBAFND,MSGCNT,DVBAAUTO)=0
 F  S AMIEIEN=$O(^DVB(396.95,"CD",APPTDTTM,AMIEIEN)) Q:AMIEIEN=""  D
 .S REQIEN=$$GET1^DIQ(396.95,AMIEIEN,.06,"I")
 .I $$GET1^DIQ(396.3,REQIEN,.01,"I")'=DFN Q
 .S LNKCNT=LNKCNT+1
 .I $$GET1^DIQ(396.95,AMIEIEN,.07,"I")=1 S DVBAFND=1,DVBALKDA=AMIEIEN
 .I 'DVBAFND,$$GET1^DIQ(396.95,AMIEIEN,.08,"I")>DVBAUPDT D
 ..S DVBAUPDT=$P(^DVB(396.95,AMIEIEN,0),U,8) ;**Keep latest cancel dte
 ..S DVBALKDA=AMIEIEN ;**Keep DA of rec last cancelled
 I (DVBASTAT="PCA")!((DVBASTAT="NA")!(DVBASTAT="CA")) S DVBAAUTO=1
 ;** Appt not linked
 I LNKCNT=0 D
 .S APPTDTTME=$$FMTE^XLFDT(APPTDTTM)
 .S MSGCNT=MSGCNT+1
 .S RETURN("CompensationPensionCancel",MSGCNT,"Text")="Appointment "_APPTDTTME_" was not linked to a 2507 request or was manually rebooked and linked to another appointment."
 .S MSGCNT=MSGCNT+1
 .S RETURN("CompensationPensionCancel",MSGCNT,"Text")="If the appointment was manually rebooked, you do not want to auto-rebook."
 .S MSGCNT=MSGCNT+1
 .S RETURN("CompensationPensionCancel",MSGCNT,"Text")="If the appointment was not properly linked, it will need to be linked with the AMIE/C&P appointment link management option."
 I 'DVBAAUTO,(DVBAFND) D  ;**Appt linked, not Auto
 .D CANCEL^DVBCCNNS
 .S RETURN("CompensationPensionCancel","Status")="The AMIE C&P Tracking link has been updated."
 .S RETURN("CompensationPensionCancel","AmieID")=DVBALKDA
 I +LNKCNT>1 D
 .S MSGCNT=MSGCNT+1
 .S RETURN("CompensationPensionCancel",MSGCNT,"Text")="This C&P appointment has multiple links with the same Current Appt Date. Use the AMIE/C&P Appointment Link Management option to review and delete any duplicate links."
 Q
 ; validate clinic
VALIDATECLINIC(ERRORS,CLINICIEN) ;
 I CLINICIEN="" D ERRLOG^SDESJSON(.ERRORS,18) Q
 I '$D(^SC(CLINICIEN,0)) D ERRLOG^SDESJSON(.ERRORS,19) Q
 Q
 ; validate request ien
VALREQIEN(ERRORS,REQIEN) ;
 I REQIEN="" D ERRLOG^SDESJSON(.ERRORS,419) Q
 I '$D(^DVB(396.3,REQIEN)) D ERRLOG^SDESJSON(.ERRORS,420)
 Q
VALVETREQ(ERRORS,VETREQ) ;
 I VETREQ'=1,VETREQ'="",VETREQ'=0 D ERRLOG^SDESJSON(.ERRORS,422)
 Q
VALAMIEIEN(ERRORS,AMIEIEN) ;
 I 'AMIETRKIEN!('$D(^DVB(396.95,AMIEIEN))) D ERRLOG^SDESJSON(.ERRORS,421)
 Q
 ;
