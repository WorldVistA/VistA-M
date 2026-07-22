SDES2BLDAPPT2 ;ALB/LAB,JAS,LAB,TAW,RN,MCB- VISTA SCHEDULING BUILDING APPT OBJECT FROM PATIENT ;APRIL 10,2026
 ;;5.3;Scheduling;**871,877,880,916,909,929,942**;Aug 13, 1993;Build 2
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 Q
 ;
GET2INFO(APPTOBJ,APPTIEN,SDDFN,RECCNT) ;
 S APPTOBJ("Appointment",RECCNT,"Patient","DFN")=SDDFN
 S APPTOBJ("Appointment",RECCNT,"Patient","ICN")=$$GETPATICN^SDESINPUTVALUTL(SDDFN)
 S APPTOBJ("Appointment",RECCNT,"Patient","SSN")=$$LAST4SSN^SDESINPUTVALUTL(SDDFN)
 S APPTOBJ("Appointment",RECCNT,"Patient","DateOfBirth")=$$FMTISO^SDAMUTDT($$GET1^DIQ(2,SDDFN_",",.03,"I"))
 S APPTOBJ("Appointment",RECCNT,"Patient","DateOfBirthInternal")=$$GET1^DIQ(2,SDDFN_",",.03,"I")
 S APPTOBJ("Appointment",RECCNT,"Patient","DateOfDeath")=$$FMTISO^SDAMUTDT($$GET1^DIQ(2,SDDFN_",",.351,"I"))
 S APPTOBJ("Appointment",RECCNT,"Patient","EligibilityIEN")=$$GET1^DIQ(2,SDDFN_",",.361,"I")
 S APPTOBJ("Appointment",RECCNT,"Patient","Eligibility")=$$GET1^DIQ(2,SDDFN_",",.361,"E")
 S APPTOBJ("Appointment",RECCNT,"Patient","FugitiveFelonFlag")=$S($$GET1^DIQ(2,SDDFN_",",1100.01,"I"):"YES",1:"NO")
 S APPTOBJ("Appointment",RECCNT,"Patient","Gender")=$$GET1^DIQ(2,SDDFN_",",.02,"E")
 S APPTOBJ("Appointment",RECCNT,"Patient","Name")=$$GET1^DIQ(2,SDDFN_",",.01,"E")
 S APPTOBJ("Appointment",RECCNT,"Patient","Street")=$$GET1^DIQ(2,SDDFN_",",.111,"E")
 S APPTOBJ("Appointment",RECCNT,"Patient","residentialPhone")=$$GET1^DIQ(2,SDDFN_",",.131,"I")
 S APPTOBJ("Appointment",RECCNT,"Patient","cellularPhone")=$$GET1^DIQ(2,SDDFN_",",.134,"I")
 S APPTOBJ("Appointment",RECCNT,"Patient","PreferredName")=$$GET1^DIQ(2,SDDFN_",",.2405,"I")
 N SENSITIVE,NEEDSINS
 D SENSITIVE^SDES2UTIL(.SENSITIVE,SDDFN,DUZ)
 S APPTOBJ("Appointment",RECCNT,"Patient","SensitivePatientRestrictedRecord")=$S($G(SENSITIVE(1)):1,1:0)
 S APPTOBJ("Appointment",RECCNT,"Patient","SensitivePatientType")=$G(SENSITIVE(1))
 D NEEDVERIFY^SDESPATRPC(.NEEDSINS,SDDFN,180,90)
 S APPTOBJ("Appointment",RECCNT,"Patient","NeedInsuranceVerification")=NEEDSINS
 D GETREGDT(.APPTOBJ,RECCNT,SDDFN)
 D NATIONALFLAG(.APPTOBJ,RECCNT,SDDFN)
 D LOCALFLAGS(.APPTOBJ,RECCNT,SDDFN)
 Q
 ;
GETREGDT(APPTOBJ,RECCNT,SDDFN) ;
 N ORIGREGIEN,ORIGREGDT,LASTREGIEN,LASTREGDT,DEMODIFF
 S DEMODIFF=180
 I $D(^DGS(41.41,"B",SDDFN)) D
 .S ORIGREGIEN=$O(^DGS(41.41,"B",SDDFN,0))
 .S LASTREGIEN=$O(^DGS(41.41,"B",SDDFN,"A"),-1)
 .S ORIGREGDT=$$FMTISO^SDAMUTDT($$GET1^DIQ(41.41,ORIGREGIEN,1,"I"))
 .S LASTREGDT=$$FMTISO^SDAMUTDT($$GET1^DIQ(41.41,LASTREGIEN,1,"I"))
 .S DEMODIFF=$$FMDIFF^XLFDT(DT,$$GET1^DIQ(41.41,LASTREGIEN_",",1,"I"))
 S APPTOBJ("Appointment",RECCNT,"Patient","OriginalRegistrationDate")=$G(ORIGREGDT)
 S APPTOBJ("Appointment",RECCNT,"Patient","LastRegistrationDate")=$G(LASTREGDT)
 S APPTOBJ("Appointment",RECCNT,"Patient","DemographicsNeedUpdate")=$S(DEMODIFF>179:1,DEMODIFF<180:0)
 Q
 ;
NATIONALFLAG(APPTOBJ,RECCNT,SDDFN) ;
 N PRFDATA,DFNERROR,DFNERRORS,FN,RESNUM,PRFCNT,FIEN,FPTR,PRFARRY,NARR,FDATA,PRFIEN,SDZ,SDFILE,SDX
 S FN=26.15
 D LIST^DIC(26.15,,,"E",,,,,,,"FDATA","ERR")
 S (RESNUM,PRFCNT)=0
 F  S RESNUM=$O(FDATA("DILIST",2,RESNUM)) Q:'RESNUM  D
 .S FIEN=$G(FDATA("DILIST",2,RESNUM))
 .S FPTR=FIEN_";"_$P($$ROOT^DILFD(26.15),U,2)
 .I '$D(^DGPF(26.13,"C",SDDFN,FPTR)) Q
 .S PRFIEN=0
 .S PRFIEN=$O(^DGPF(26.13,"C",SDDFN,FPTR,0))
 .I 'PRFIEN Q
 .I '$$GET1^DIQ(26.13,PRFIEN_",",.03,"I") Q
 .S SDX=$P($G(FPTR),";",1),SDFILE=$S($G(FPTR)["26.15":26.15,1:26.11)
 .I 'SDX Q
 .I '$$GET1^DIQ(SDFILE,SDX_",",.02,"I") Q
 .K PRFDATA
 .D GETINF^DGPFAPIH(SDDFN,FPTR,,,"PRFDATA") Q:'$D(PRFDATA)
 .S PRFCNT=PRFCNT+1
 .S APPTOBJ("Appointment",RECCNT,"Patient","NationalFlag",PRFCNT,"Name")=$P($G(PRFDATA("FLAG")),U,2)
 .S APPTOBJ("Appointment",RECCNT,"Patient","NationalFlag",PRFCNT,"Type")=$P($G(PRFDATA("FLAGTYPE")),U,2)
 .S APPTOBJ("Appointment",RECCNT,"Patient","NationalFlag",PRFCNT,"Category")=$P($G(PRFDATA("CATEGORY")),U)
 .S APPTOBJ("Appointment",RECCNT,"Patient","NationalFlag",PRFCNT,"AssignedDate")=$$FMTISO^SDAMUTDT($P($G(PRFDATA("ASSIGNDT")),U,1))
 .S APPTOBJ("Appointment",RECCNT,"Patient","NationalFlag",PRFCNT,"OwnerSiteID")=$P($G(PRFDATA("OWNER")),U)
 .S APPTOBJ("Appointment",RECCNT,"Patient","NationalFlag",PRFCNT,"OwnerSiteName")=$P($G(PRFDATA("OWNER")),U,2)
 .S APPTOBJ("Appointment",RECCNT,"Patient","NationalFlag",PRFCNT,"OriginatingSiteID")=$P($G(PRFDATA("ORIGSITE")),U)
 .S APPTOBJ("Appointment",RECCNT,"Patient","NationalFlag",PRFCNT,"OriginatingSiteName")=$P($G(PRFDATA("ORIGSITE")),U,2)
 .S APPTOBJ("Appointment",RECCNT,"Patient","NationalFlag",PRFCNT,"ReviewDate")=$$FMTISO^SDAMUTDT($P($G(PRFDATA("REVIEWDT")),U))
 .S NARR=0 F  S NARR=$O(PRFDATA("NARR",NARR)) Q:'NARR  D
 ..S APPTOBJ("Appointment",RECCNT,"Patient","NationalFlag",PRFCNT,"Narrative",NARR)=$G(PRFDATA("NARR",NARR,0))
 I '$D(APPTOBJ("Appointment",RECCNT,"Patient","NationalFlag")) S APPTOBJ("Appointment",RECCNT,"Patient","NationalFlag",1)=""
 Q
 ;
LOCALFLAGS(APPTOBJ,RECCNT,SDDFN) ;
 N PRFDATA,DFNERROR,DFNERRORS,FN,RESNUM,PRFCNT,FIEN,FPTR,PRFARRY,NARR,FDATA,PRFIEN,SDZ,SDFILE,SDX
 S FN=26.11
 D LIST^DIC(26.11,,,"E",,,,,,,"FDATA","ERR")
 S (RESNUM,PRFCNT)=0
 F  S RESNUM=$O(FDATA("DILIST",2,RESNUM)) Q:'RESNUM  D
 .S FIEN=$G(FDATA("DILIST",2,RESNUM))
 .S FPTR=FIEN_";"_$P($$ROOT^DILFD(26.11),U,2)
 .I '$D(^DGPF(26.13,"C",SDDFN,FPTR)) Q
 .S PRFIEN=0
 .S PRFIEN=$O(^DGPF(26.13,"C",SDDFN,FPTR,0))
 .I 'PRFIEN Q
 .I '$$GET1^DIQ(26.13,PRFIEN_",",.03,"I") Q
 .S SDX=$P($G(FPTR),";",1),SDFILE=$S($G(FPTR)["26.15":26.15,1:26.11)
 .I 'SDX Q
 .I '$$GET1^DIQ(SDFILE,SDX_",",.02,"I") Q
 .K PRFDATA
 .D GETINF^DGPFAPIH(SDDFN,FPTR,,,"PRFDATA") Q:'$D(PRFDATA)
 .S PRFCNT=PRFCNT+1
 .S APPTOBJ("Appointment",RECCNT,"Patient","LocalFlag",PRFCNT,"Name")=$P($G(PRFDATA("FLAG")),U,2)
 .S APPTOBJ("Appointment",RECCNT,"Patient","LocalFlag",PRFCNT,"Type")=$P($G(PRFDATA("FLAGTYPE")),U,2)
 .S APPTOBJ("Appointment",RECCNT,"Patient","LocalFlag",PRFCNT,"Category")=$P($G(PRFDATA("CATEGORY")),U)
 .S APPTOBJ("Appointment",RECCNT,"Patient","LocalFlag",PRFCNT,"AssignedDate")=$$FMTISO^SDAMUTDT($P($G(PRFDATA("ASSIGNDT")),U,1))
 .S APPTOBJ("Appointment",RECCNT,"Patient","LocalFlag",PRFCNT,"OwnerSiteID")=$P($G(PRFDATA("OWNER")),U)
 .S APPTOBJ("Appointment",RECCNT,"Patient","LocalFlag",PRFCNT,"OwnerSiteName")=$P($G(PRFDATA("OWNER")),U,2)
 .S APPTOBJ("Appointment",RECCNT,"Patient","LocalFlag",PRFCNT,"OriginatingSiteID")=$P($G(PRFDATA("ORIGSITE")),U)
 .S APPTOBJ("Appointment",RECCNT,"Patient","LocalFlag",PRFCNT,"OriginatingSiteName")=$P($G(PRFDATA("ORIGSITE")),U,2)
 .S APPTOBJ("Appointment",RECCNT,"Patient","LocalFlag",PRFCNT,"ReviewDate")=$$FMTISO^SDAMUTDT($P($G(PRFDATA("REVIEWDT")),U))
 .S NARR=0 F  S NARR=$O(PRFDATA("NARR",NARR)) Q:'NARR  D
 ..S APPTOBJ("Appointment",RECCNT,"Patient","LocalFlag",PRFCNT,"Narrative",NARR)=$G(PRFDATA("NARR",NARR,0))
 I '$D(APPTOBJ("Appointment",RECCNT,"Patient","LocalFlag")) S APPTOBJ("Appointment",RECCNT,"Patient","LocalFlag",1)=""
 Q
 ;
GET298INFO(APPTOBJ,APPTIEN,SDDFN,RECCNT,CLINIEN) ;
 N INCLUDEPAT,PATIENS,ARRAY298,ERR
 D CHECKSTATUS(.INCLUDEPAT,SDDFN,APPTIEN,APPTOBJ("Appointment",RECCNT,"StartTimeFM")) ;need to know whether to include PatientAppointment information
 S APPTOBJ("Appointment",RECCNT,"OverLaidAppointmentData")=$S(INCLUDEPAT=1:"NO",1:"YES")
 I INCLUDEPAT=0 D BLANK298(.APPTOBJ) Q
 S PATIENS=APPTOBJ("Appointment",RECCNT,"StartTimeFM")_","_SDDFN_","
 D GETS^DIQ(2.98,PATIENS,"**","IE","ARRAY298","ERR")
 S APPTOBJ("Appointment",RECCNT,"AppointmentTypeSubCategory")=$G(ARRAY298(2.98,PATIENS,24,"E"))
 S APPTOBJ("Appointment",RECCNT,"AutoRebookedApptDateTime")=$$FMTISO^SDAMUTDT($G(ARRAY298(2.98,PATIENS,12,"I")))
 S APPTOBJ("Appointment",RECCNT,"CancellationRemarks")=$$CLEANCMMTS^SDES2APPTUTIL($G(ARRAY298(2.98,PATIENS,17,"E")))
 S APPTOBJ("Appointment",RECCNT,"CollateralVisit")=$G(ARRAY298(2.98,PATIENS,13,"E"))
 S APPTOBJ("Appointment",RECCNT,"EkgDateTime")=$$FMTISO^SDAMUTDT($G(ARRAY298(2.98,PATIENS,7,"I")),CLINIEN)
 S APPTOBJ("Appointment",RECCNT,"EncounterConversionStatus")=$G(ARRAY298(2.98,PATIENS,23.1,"E"))
 S APPTOBJ("Appointment",RECCNT,"EncounterFormsAsAddOns")=$G(ARRAY298(2.98,PATIENS,23,"E"))
 S APPTOBJ("Appointment",RECCNT,"EncounterFormsPrinted")=$G(ARRAY298(2.98,PATIENS,22,"E"))
 S APPTOBJ("Appointment",RECCNT,"FollowUpVisit")=$G(ARRAY298(2.98,PATIENS,28,"E"))
 S APPTOBJ("Appointment",RECCNT,"LabDateTime")=$$FMTISO^SDAMUTDT($G(ARRAY298(2.98,PATIENS,5,"I")),CLINIEN)
 S APPTOBJ("Appointment",RECCNT,"NextAvaApptIndicator")=$G(ARRAY298(2.98,PATIENS,26,"E"))
 S APPTOBJ("Appointment",RECCNT,"NoShowCancelDateTime")=$$FMTISO^SDAMUTDT($G(ARRAY298(2.98,PATIENS,15,"I")))
 S APPTOBJ("Appointment",RECCNT,"NoShowCancelledBy")=$G(ARRAY298(2.98,PATIENS,14,"E"))
 S APPTOBJ("Appointment",RECCNT,"NumberOfCollateralSeen")=$G(ARRAY298(2.98,PATIENS,11,"E"))
 S APPTOBJ("Appointment",RECCNT,"OutpatientEncounter")=$$FMTISO^SDAMUTDT($$GET1^DIQ(409.68,$G(ARRAY298(2.98,PATIENS,21,"I")),.01,"I"),CLINIEN)
 S APPTOBJ("Appointment",RECCNT,"PurposeOfVisit")=$G(ARRAY298(2.98,PATIENS,9,"E"))
 S APPTOBJ("Appointment",RECCNT,"RealAppointment")=$G(ARRAY298(2.98,PATIENS,4,"E"))
 S APPTOBJ("Appointment",RECCNT,"RoutingSlipPrintDate")=$$FMTISO^SDAMUTDT($G(ARRAY298(2.98,PATIENS,8.5,"I")))
 S APPTOBJ("Appointment",RECCNT,"RoutingSlipPrinted")=$G(ARRAY298(2.98,PATIENS,8,"E"))
 S APPTOBJ("Appointment",RECCNT,"SchedulerName")=$G(ARRAY298(2.98,PATIENS,30,"E"))
 S APPTOBJ("Appointment",RECCNT,"SchedulingApplication")=$G(ARRAY298(2.98,PATIENS,29,"I"))
 S APPTOBJ("Appointment",RECCNT,"SchedulingRequestType")=$G(ARRAY298(2.98,PATIENS,25,"E"))
 S APPTOBJ("Appointment",RECCNT,"SpecialSurveyDisposition")=$G(ARRAY298(2.98,PATIENS,10,"E"))
 S:APPTOBJ("Appointment",RECCNT,"Status")="" APPTOBJ("Appointment",RECCNT,"Status")=APPTOBJ("Appointment",RECCNT,"CurrentStatus")
 S APPTOBJ("Appointment",RECCNT,"InpatientFlag")=$S($G(ARRAY298(2.98,PATIENS,3,"I"))="I":1,1:0)
 S APPTOBJ("Appointment",RECCNT,"XrayDateTime")=$$FMTISO^SDAMUTDT($G(ARRAY298(2.98,PATIENS,6,"I")),CLINIEN)
 Q
 ;
BLANK298(APPTOBJ) ;if overlaid appointment, send empty fields
 S APPTOBJ("Appointment",RECCNT,"InpatientFlag")=""
 S APPTOBJ("Appointment",RECCNT,"AppointmentTypeSubCategory")=""
 S APPTOBJ("Appointment",RECCNT,"AutoRebookedApptDateTime")=""
 S APPTOBJ("Appointment",RECCNT,"CancellationRemarks")=""
 S APPTOBJ("Appointment",RECCNT,"CollateralVisit")=""
 S APPTOBJ("Appointment",RECCNT,"EkgDateTime")=""
 S APPTOBJ("Appointment",RECCNT,"EncounterConversionStatus")=""
 S APPTOBJ("Appointment",RECCNT,"EncounterFormsAsAddOns")=""
 S APPTOBJ("Appointment",RECCNT,"EncounterFormsPrinted")=""
 S APPTOBJ("Appointment",RECCNT,"FollowUpVisit")=""
 S APPTOBJ("Appointment",RECCNT,"LabDateTime")=""
 S APPTOBJ("Appointment",RECCNT,"NextAvaApptIndicator")=""
 S APPTOBJ("Appointment",RECCNT,"NoShowCancelDateTime")=""
 S APPTOBJ("Appointment",RECCNT,"NoShowCancelledBy")=""
 S APPTOBJ("Appointment",RECCNT,"NumberOfCollateralSeen")=""
 S APPTOBJ("Appointment",RECCNT,"OutpatientEncounter")=""
 S APPTOBJ("Appointment",RECCNT,"PurposeOfVisit")=""
 S APPTOBJ("Appointment",RECCNT,"RealAppointment")=""
 S APPTOBJ("Appointment",RECCNT,"RoutingSlipPrintDate")=""
 S APPTOBJ("Appointment",RECCNT,"RoutingSlipPrinted")=""
 S APPTOBJ("Appointment",RECCNT,"SchedulerName")=""
 S APPTOBJ("Appointment",RECCNT,"SchedulingApplication")=""
 S APPTOBJ("Appointment",RECCNT,"SchedulingRequestType")=""
 S APPTOBJ("Appointment",RECCNT,"SpecialSurveyDisposition")=""
 S APPTOBJ("Appointment",RECCNT,"XrayDateTime")=""
 Q
 ;
CHECKSTATUS(INCLUDEPAT,SDDFN,APPTIEN,APPTDTTM) ;
 S INCLUDEPAT=$O(^SDEC(409.84,"APTDT",SDDFN,APPTDTTM,APPTIEN))
 S:INCLUDEPAT'="" INCLUDEPAT=0 ;Patient appointment was overlaid with new appointment
 S:INCLUDEPAT="" INCLUDEPAT=1
 Q
 ;
