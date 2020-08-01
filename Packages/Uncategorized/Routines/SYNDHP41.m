SYNDHP41 ; HC/rdb/art - HealthConcourse - retrieve patient appointments ;07/23/2019
 ;;1.0;DHP;;Jan 17, 2017;Build 46
 ;;
 ;;Original routine authored by Andrew Thompson & Ferdinand Frankson of Perspecta 2017-2019
 ;
 QUIT
 ;
 ; ---------------- Get patient appointment information ------------------------------
 ;
PATAPTI(RETSTA,DHPICN,FRDAT,TODAT,RETJSON) ; Patient appointments for ICN
 ;
 ; Return patient appointments for a given patient ICN
 ; Returns a patient's appointments from PATIENT:APPOINTMENT (2:1900)
 ;
 ; Input:
 ;   ICN     - unique patient identifier across all VistA systems
 ;   FRDAT   - from date (inclusive), optional, compared to appointment date/time
 ;   TODAT   - to date (inclusive), optional, compared to appointment date/time
 ;   RETJSON - J = Return JSON
 ;             F = Return FHIR
 ;             0 or null = Return string (default)
 ; Output:
 ;   RETSTA  - a delimited string that lists patient appointment information
 ;          ICN ^ Patient IEN _ Appt Date (HL7) | Clinic | Appt Status | purpose of visit | Appt Type | Resource ID ^...
 ;
 ; bypass for CQM
 ;
 ; ***********
 ; *********** Important Note for open source community
 ; ***********
 ; *********** Perspecta - who developed this source code and have released it to the open source
 ; *********** need the following six lines to remain intact
 ;
 ;I DHPICN="1686299845V246594" D  Q
 ;.S RETSTA="1686299845V246594^101916_201704281200-0500|GENERAL MEDICINE||UNSCHED. VISIT|REGULAR"
 ;
 ; *********** the above lines will be redacted by Perspecta at some suitable juncture to
 ; *********** be determined by Perspecta
 ; ***********
 ; *********** End of Important Note for open source community
 ;
 S FRDAT=$S($G(FRDAT):$$HL7TFM^XLFDT(FRDAT),1:1000101)
 S TODAT=$S($G(TODAT):$$HL7TFM^XLFDT(TODAT),1:9991231)
 I $G(DEBUG) W !,"FRDAT: ",FRDAT,"   TODAT: ",TODAT,!
 I FRDAT>TODAT S RETSTA="-1^From date is greater than to date" QUIT
 ;
 ; validate ICN
 I $G(DHPICN)="" S RETSTA="-1^What patient?" QUIT
 I '$$UICNVAL^SYNDHPUTL(DHPICN) S RETSTA="-1^Patient identifier not recognised" Q
 ;
 ; get patient IEN from ICN
 S PATIEN=$O(^DPT("AFICN",DHPICN,""))
 I PATIEN="" S RETSTA="-1^Internal data structure error" QUIT
 ;
 N PATAPPT
 S RETSTA=$$APPTS(.PATAPPT,PATIEN,DHPICN,FRDAT,TODAT)
 ;
 ;I $G(RETJSON)="F" D xxx  ;create array for FHIR
 ;
 I $G(RETJSON)="J"!($G(RETJSON)="F") D
 . S RETSTA=""
 . D TOJASON^SYNDHPUTL(.PATAPPT,.RETSTA)
 ;
 QUIT
 ;
APPTS(PATAPPT,PATIEN,DHPICN,FRDAT,TODAT) ; get appointments for a patient
 ;
 N P S P="|"
 N S S S="_"
 ;
 D GETPATAPPT^SYNDHP25(.PATAPPT,PATIEN,0) ;get patient appointment records
 I $D(PATAPPT("Patappt","ERROR")) QUIT
 ;
 N APPTDTTM,PTAPTID,CLNAM,APDTDISP,APPTSTAT,APPTPURP,APPTTYPE,ZARR
 S APPTDTTM=""
 F  S APPTDTTM=$O(PATAPPT("Patappt","appointments","appointment",APPTDTTM)) Q:APPTDTTM=""  D
 . QUIT:'$$RANGECK^SYNDHPUTL(APPTDTTM,FRDAT,TODAT)  ;quit if outside of requested date range
 . N APPT S APPT=$NA(PATAPPT("Patappt","appointments","appointment",APPTDTTM))
 . S PTAPTID=@APPT@("resourceId")
 . S CLNAM=@APPT@("clinic") ;clinic
 . S APDTDISP=@APPT@("appointmentDateTimeFHIR") ;appt. date/time
 . S APPTSTAT=@APPT@("status") ;status
 . S APPTPURP=@APPT@("purposeOfVisit") ;purpose of visit
 . S APPTTYPE=@APPT@("appointmentType") ;appt. type
 . S ZARR(DHPICN,APPTDTTM)=PATIEN_S_APDTDISP_P_CLNAM_P_APPTSTAT_P_APPTPURP_P_APPTTYPE_P_PTAPTID
 ; serialize data
 S APPTDTTM=""
 N APPTREC
 N APPTS S APPTS=DHPICN
 F  S APPTDTTM=$O(ZARR(DHPICN,APPTDTTM)) Q:APPTDTTM=""  D
 .S APPTREC=ZARR(DHPICN,APPTDTTM)
 .S APPTS=APPTS_U_APPTREC
 Q APPTS
 ;
 ; ----------- Unit Test -----------
T1 ;
 N ICN S ICN="1435855215V947437"
 N FRDAT S FRDAT=""
 N TODAT S TODAT=""
 N RETSTA
 D PATAPTI(.RETSTA,ICN,FRDAT,TODAT)
 W $$ZW^SYNDHPUTL("RETSTA")
 QUIT
 ;
T2 ;
 N ICN S ICN="1435855215V947437"
 N FRDAT S FRDAT=20150201
 N TODAT S TODAT=20160101
 N RETSTA
 D PATAPTI(.RETSTA,ICN,FRDAT,TODAT)
 W $$ZW^SYNDHPUTL("RETSTA")
 QUIT
 ;
T3 ;
 N ICN S ICN="1435855215V947437"
 N FRDAT S FRDAT=""
 N TODAT S TODAT=""
 N JSON S JSON="J"
 N RETSTA
 D PATAPTI(.RETSTA,ICN,FRDAT,TODAT,JSON)
 W $$ZW^SYNDHPUTL("RETSTA")
 QUIT
 ;
