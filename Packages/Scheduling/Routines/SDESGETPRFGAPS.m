SDESGETPRFGAPS ;ALB/ANU - VISTA SCHEDULING RPCS ;NOV 22, 2022
 ;;5.3;Scheduling;**831**;Aug 13, 1993;Build 4
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 ;External References
 ;-------------------
 ; Reference to $$GETS^DIQ,$$GETS1^DIQ in ICR #2056
 ;
 Q
 ;
PREFGET(JSONRETURN,DFN,INAC) ; Get values from SDEC PREFERENCES AND SPECIAL NEEDS file
 ;INPUT:
 ;  DFN  = (integer) Patient ID - Pointer to the PATIENT file 2
 ;  INAC = (optional) include inactive entries (1-Include; 0-Don't Include)
 ;RETURN:
 ; Successful Return:
 ;          1. (integer)        Patient ID - pointer to PATIENT file
 ;          2. (text)           Preference text
 ;          3. (date/time)      Date/Time preference added in external format - defaults to NOW
 ;          4. (integer)        Added by User - Pointer to NEW PERSON file - defaults to Current User
 ;          5. (text)           Added by User Name
 ;          6. (date/time)      Date/Time Inactivated in external format
 ;          7. (integer)        Inactivated by user - Pointer to NEW PERSON file
 ;          8. (text)           Inactivated by user Name
 ;          9. (text)           Remarks
 ;
 N ISDFNVALID,ISINACVALID,RETURN,ERRORS,REQUESTIEN,REQUEST
 ;
 S ISDFNVALID=$$VALIDATEDFN(.ERRORS,$G(DFN))
 S ISINACVALID=$$VALIDATEINAC(.ERRORS,$G(INAC))
 I $D(ERRORS) M RETURN=ERRORS D BUILDJSON^SDESBUILDJSON(.JSONRETURN,.RETURN) Q
 ;
 I '$D(ERRORS) S HASFIELDS=$$PREFG(.ELGFIELDSARRAY,DFN,INAC)
 I HASFIELDS M RETURN=ELGFIELDSARRAY
 ;
 I '$D(RETURN("PatientPref")) S RETURN("PatientPref",1)=""
 D BUILDJSON^SDESBUILDJSON(.JSONRETURN,.RETURN)
 D CLEANUP
 Q
 ;
PATWARDGET(JSONRETURN,DFN) ; Get values 
 ;INPUT:
 ;  DFN  = (integer) Patient ID - Pointer to the PATIENT file 2
 ;RETURN:
 ; Successful Return:
 ;          1. (integer)        Patient ID - pointer to PATIENT file
 ;          2. (text)           Patient Name
 ;          3. (text)           Patient Ward
 ;
 N ISDFNVALID,RETURN,ERRORS,REQUESTIEN,REQUEST
 ;
 S ISDFNVALID=$$VALIDATEDFN(.ERRORS,$G(DFN))
 I $D(ERRORS) M RETURN=ERRORS D BUILDJSON^SDESBUILDJSON(.JSONRETURN,.RETURN) Q
 ;
 I '$D(ERRORS) S HASFIELDS=$$PATWARD(.ELGFIELDSARRAY,DFN)
 I HASFIELDS M RETURN=ELGFIELDSARRAY
 ;
 I '$D(RETURN("InPatient")) S RETURN("InPatient",1)=""
 D BUILDJSON^SDESBUILDJSON(.JSONRETURN,.RETURN)
 D CLEANUP
 Q
 ;
VALIDATEDFN(ERRORS,DFN) ;
 I DFN="" D ERRLOG^SDESJSON(.ERRORS,1) Q 0
 I DFN'="",'$D(^DPT(DFN,0)) D ERRLOG^SDESJSON(.ERRORS,2) Q 0
 Q 1
 ;
VALIDATEINAC(ERRORS,INAC) ;
 I +$G(INAC)'=0,+$G(INAC)'=1 D ERRLOG^SDESJSON(.ERRORS,372) Q 0
 Q 1
 ;
PREFG(ELGARRAY,DFN,INAC) ; Get values from SDEC PREFERENCES AND SPECIAL NEEDS file
 ;
 N PIEN,PIEN1,PIEN1NOD,SDESI,SDI,SDWP,SDMSG,PREFARY,ERR,SDESERR,IENS,HASDATA,X
 S SDESI=1
 ;check for existing patient entry in SDEC PREFERENCES AND SPECIAL NEEDS file
 S PIEN=$O(^SDEC(409.845,"B",DFN,0))
 I PIEN="" Q 1
 S PIEN1=0 F  S PIEN1=$O(^SDEC(409.845,PIEN,1,PIEN1)) Q:PIEN1'>0  D
 .S PIEN1NOD=^SDEC(409.845,PIEN,1,PIEN1,0)
 .I '+$G(INAC) Q:$P(PIEN1NOD,U,4)'=""
 .S SDESI=SDESI+1
 .S IENS=PIEN1_","_PIEN_","
 .D GETS^DIQ(409.8451,IENS,"**","IE","PREFARY","ERR")
 .S ELGARRAY("PatientPref",1,"PatientDFN")=DFN
 .S ELGARRAY("PatientPref",1,"PatientName")=$$GET1^DIQ(2,DFN_",",.01,"E")
 .S ELGARRAY("PatientPref",SDESI,"Preference")=$G(PREFARY(409.8451,IENS,.01,"E"))
 .S ELGARRAY("PatientPref",SDESI,"AddedDateTime")=$$FMTISO^SDAMUTDT($G(PREFARY(409.8451,IENS,2,"I")))
 .S ELGARRAY("PatientPref",SDESI,"AddedByUserIEN")=$G(PREFARY(409.8451,IENS,3,"I"))
 .S ELGARRAY("PatientPref",SDESI,"AddedByUserName")=$G(PREFARY(409.8451,IENS,3,"E"))
 .S ELGARRAY("PatientPref",SDESI,"InactiveDate")=$$FMTISO^SDAMUTDT($G(PREFARY(409.8451,IENS,4,"I")))
 .S ELGARRAY("PatientPref",SDESI,"InactivatedByUserIEN")=$G(PREFARY(409.8451,IENS,5,"I"))
 .S ELGARRAY("PatientPref",SDESI,"InactivatedByUserName")=$G(PREFARY(409.8451,IENS,5,"E"))
 .;get remark
 .K SDWP S X=$$GET1^DIQ(409.8451,PIEN1_","_PIEN_",",6,"","SDWP","SDMSG")
 .S SDWP=""
 .S SDI=0 F  S SDI=$O(SDWP(SDI)) Q:SDI=""  D
 ..S ELGARRAY("PatientPref",SDESI,"Remarks",SDI)=$G(SDWP(SDI))
 S HASDATA=($D(ELGARRAY)>1)
 Q HASDATA
 ;
PATWARD(ELGARRAY,DFN) ; Get values 
 ;
 N HASDATA
 S ELGARRAY("InPatient","PatientDFN")=DFN
 S ELGARRAY("InPatient","PatientName")=$$GET1^DIQ(2,DFN_",",.01,"E")
 ;S ELGARRAY("PatientHealthInfo","MentalHealthProvider")=$$START^SCMCMHTC(DFN) ;Return Mental Health Provider
 ;S ELGARRAY("PatientHealthInfo","PrimaryCareProvider")=$$OUTPTPR^SDUTL3(DFN) ;Return Primary Care Provider
 S ELGARRAY("InPatient","PatientWard")=$$GET1^DIQ(2,DFN_",",.1,"E")
 S HASDATA=($D(ELGARRAY)>1)
 Q HASDATA
 ;
CLEANUP ;
 K RETURNERROR,ERRORFLAG,ERRORS,ISRGIENVALID,ISRGNAMEVALID
 K RETURN,HASFIELDS,ELGFIELDSARRAY,ELGRETURN
 Q
 ;
