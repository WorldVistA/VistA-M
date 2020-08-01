SYNDHP01 ; HC/fjf/art - HealthConcourse - get patient vitals ;07/23/2019
 ;;1.0;DHP;;Jan 17, 2017;Build 46
 ;;
 ;;Original routine authored by Andrew Thompson & Ferdinand Frankson of Perspecta 2017-2019
 ;
 QUIT
 ;
 ; ---------------- Get patient vitals ------------------------------
 ;
PATVIT(RETSTA,NAME,SSN,DOB,GENDER,FRDAT,TODAT,RETJSON) ; get vitals for a patient by traits
 S RETSTA="-1^This service has been retired"
 QUIT
 ; Return patient vitals for name, SSN, DOB, and gender
 ;
 ; Input:
 ;   NAME    - patient name
 ;   SSN     - social security number
 ;   DOB     - date of birth
 ;   GENDER  - gender
 ;   FRDAT   - from date (inclusive), optional, compared to .01 DATE/TIME VITALS TAKEN
 ;   TODAT   - to date (inclusive), optional, compared to .01 DATE/TIME VITALS TAKEN
 ;   RETJSON - J = Return JSON
 ;             F = Return FHIR
 ;             0 or null = Return string (default)
 ; Output:
 ;   RETSTA  - a delimited string that lists the vitals for a patient
 ;           - ICN^SCT code for vital|SCT description of vital|value of vital|date|resource id^...
 ;          or patient vitals in JSON format
 ;
 ;     note:resource identifier will be:
 ;             "V"_SITE ID_FILE #_FILE IEN   e.g. V_500_120.5_930
 ;
 S FRDAT=$S($G(FRDAT):$$HL7TFM^XLFDT(FRDAT),1:1000101)
 S TODAT=$S($G(TODAT):$$HL7TFM^XLFDT(TODAT),1:9991231)
 I $G(DEBUG) W !,"FRDAT: ",FRDAT,"   TODAT: ",TODAT,!
 ;
 N ICNST
 D PATVAL^SYNDHP43(.ICNST,NAME,SSN,DOB,GENDER)
 I +ICNST'=1 S RETSTA=ICNST QUIT
 ; if we are here we are dealing with a valid patient
 N DHPIEN S DHPICN=$P(ICNST,U,3)
 ; get patient IEN from ICN
 N PATIEN S PATIEN=$O(^DPT("AFICN",DHPICN,""))
 ;
 I PATIEN="" S RETSTA="-1^Patient ICN not found" QUIT
 ;
 N VARRAY
 S RETSTA=$$VITS(.VARRAY,PATIEN,DHPIEN,FRDAT,TODAT)
 ;
 I $G(RETJSON)="J"!($G(RETJSON)="F") D
 . S RETSTA=""
 . D TOJASON^SYNDHPUTL(.VARRAY,.RETSTA)
 ;
 QUIT
 ;
PATVITI(RETSTA,DHPICN,FRDAT,TODAT,RETJSON) ; Patient vitals for ICN
 ;
 ; Return patient vitals for a given patient ICN
 ;
 ; Input:
 ;   ICN     - unique patient identifier across all VistA systems
 ;   FRDAT   - from date (inclusive), optional, compared to .01 DATE/TIME VITALS TAKEN
 ;   TODAT   - to date (inclusive), optional, compared to .01 DATE/TIME VITALS TAKEN
 ;   RETJSON - J = Return JSON
 ;             F = Return FHIR
 ;             0 or null = Return string (default)
 ; Output:
 ;   RETSTA  - a delimited string that lists the vitals for a patient
 ;           - ICN^SCT code for vital|SCT description of vital|value of vital|date|resource id^...
 ;          or patient vitals in JSON format
 ;
 ;     note:resource identifier will be:
 ;             "V"_SITE ID_FILE #_FILE IEN   e.g. V_500_120.5_930
 ;
 S FRDAT=$S($G(FRDAT):$$HL7TFM^XLFDT(FRDAT),1:1000101)
 S TODAT=$S($G(TODAT):$$HL7TFM^XLFDT(TODAT),1:9991231)
 I $G(DEBUG) W !,"FRDAT: ",FRDAT,"   TODAT: ",TODAT,!
 I FRDAT>TODAT S RETSTA="-1^From date is greater than to date" QUIT
 ;
 ; validate ICN
 I $G(DHPICN)="" S RETSTA="-1^What patient?" QUIT
 I '$$UICNVAL^SYNDHPUTL(DHPICN) S RETSTA="-1^Patient identifier not recognised" QUIT
 ; get patient IEN from ICN
 N PATIEN S PATIEN=$O(^DPT("AFICN",DHPICN,""))
 I PATIEN="" S RETSTA="-1^Internal data structure error" QUIT
 ;
 N VARRAY
 S RETSTA=$$VITS(.VARRAY,PATIEN,DHPICN,FRDAT,TODAT)
 ;
 ;I $G(RETJSON)="F" D xxx  ;create array for FHIR
 ;
 I $G(RETJSON)="J"!($G(RETJSON)="F") D
 . S RETSTA=""
 . D TOJASON^SYNDHPUTL(.VARRAY,.RETSTA)
 ;
 QUIT
 ;
VITS(PATVIT,PATIEN,DHPICN,FRDAT,TODAT) ; get vitals for a patient
 ; build the array of SNOMED CT codes that correspond to vitals
 ;
 N VITALS,VID,VTYPE,VOBS,VTIEN,VDATEFM,VDATE,SCT,SCTPT,VIT,ZARR
 N C S C=","
 N P S P="|"
 N S S S="_"
 N FN S FN=120.5
 ;
 ; scan vitals "C" index for IEN
 N VIEN S VIEN=""
 F  S VIEN=$O(^GMR(FN,"C",PATIEN,VIEN)) Q:VIEN=""  D
 . N VITALS
 . D GET1VITALS^SYNDHP16(.VITALS,VIEN,0)
 . I $D(VITALS("Vitals","ERROR")) M PATVIT("Vitals",VIEN)=VITALS QUIT
 . S VDATEFM=VITALS("Vitals","dateTimeVitalsTakenFM")
 . QUIT:((VDATEFM\1)<FRDAT)!((VDATEFM\1)>TODAT)  ;quit if outside of requested date range
 . QUIT:'$$RANGECK^SYNDHPUTL(VDATEFM,FRDAT,TODAT)  ;quit if outside of requested date range
 . S VID=VITALS("Vitals","resourceId")
 . S VTYPE=VITALS("Vitals","vitalType")
 . S VOBS=VITALS("Vitals","rate")
 . S VTIEN=VITALS("Vitals","vitalTypeId")
 . S VDATE=VITALS("Vitals","dateTimeVitalsTakenHL7")
 . S SCT=VITALS("Vitals","vitalTypeSCT")
 . S SCTPT=$$SENTENCE^XLFSTR(VITALS("Vitals","vitalType"))
 . S ZARR(DHPICN,SCT,VIEN)=SCTPT_P_VOBS_P_VDATE_P_VID
 . M PATVIT("Vitals",VIEN)=VITALS ;
 ;
 ; serialize data
 S (SCT,VIEN)=""
 N VITALRTN S VITALRTN=DHPICN
 F  S SCT=$O(ZARR(DHPICN,SCT)) Q:SCT=""  D
 . F  S VIEN=$O(ZARR(DHPICN,SCT,VIEN)) Q:VIEN=""  D
 . . S VIT=ZARR(DHPICN,SCT,VIEN)
 . . S VITALRTN=VITALRTN_U_SCT_P_VIT
 ;
 Q VITALRTN
 ;
 ; ----------- Unit Test -----------
T1 ;
 N ICN S ICN="5000000211V385910"
 N FRDAT S FRDAT=""
 N TODAT S TODAT=""
 N JSON S JSON=""
 N RETSTA
 D PATVITI(.RETSTA,ICN,FRDAT,TODAT,JSON)
 W $$ZW^SYNDHPUTL("RETSTA")
 QUIT
 ;
T2 ;
 N ICN S ICN="5000000211V385910"
 N FRDAT S FRDAT=""
 N TODAT S TODAT=""
 N JSON S JSON="J"
 N RETSTA
 D PATVITI(.RETSTA,ICN,FRDAT,TODAT,JSON)
 W $$ZW^SYNDHPUTL("RETSTA")
 QUIT
 ;
T3 ;
 N ICN S ICN="5000000211V385910"
 N FRDAT S FRDAT=20150220
 N TODAT S TODAT=20150223
 N JSON S JSON=""
 N RETSTA
 D PATVITI(.RETSTA,ICN,FRDAT,TODAT,JSON)
 W $$ZW^SYNDHPUTL("RETSTA")
 QUIT
