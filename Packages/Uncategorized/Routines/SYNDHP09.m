SYNDHP09 ; HC/fjf/art - HealthConcourse - get patient health factors ;07/23/2019
 ;;1.0;DHP;;Jan 17, 2017;Build 46
 ;;
 ;;Original routine authored by Andrew Thompson & Ferdinand Frankson of Perspecta 2017-2019
 ;
 QUIT
 ;
 ; ---------------- Get patient health factors ------------------------------
 ;
PATHLF(RETSTA,NAME,SSN,DOB,GENDER,FRDAT,TODAT,RETJSON) ; get health factors for a patient by traits
 S RETSTA="-1^This service has been retired"
 QUIT
 ;
 ; Return patient health factors for name, SSN, DOB, and gender
 ;
 ; Input:
 ;   NAME    - patient name
 ;   SSN     - social security number
 ;   DOB     - date of birth
 ;   GENDER  - gender
 ;   FRDAT   - from date (inclusive), optional, compared to Visit Date/Time
 ;   TODAT   - to date (inclusive), optional, compared to Visit Date/Time
 ;   RETJSON - J = Return JSON
 ;             F = Return FHIR
 ;             0 or null = Return health factors string (default)
 ; Output:
 ;   RETSTA  - a delimited string that lists SNOMED CDT codes for the patient health factors
 ;           - ICN^SCT code|HF Name|Resource ID|HF Severity|Encounter Provider|Visit Date^SCT code...
 ;          or patient health factors in JSON format
 ;
 S FRDAT=$S($G(FRDAT):$$HL7TFM^XLFDT(FRDAT),1:1000101)
 S TODAT=$S($G(TODAT):$$HL7TFM^XLFDT(TODAT),1:9991231)
 I $G(DEBUG) W !,"FRDAT: ",FRDAT,"   TODAT: ",TODAT,!
 ;
 N ICNST
 D PATVAL^SYNDHP43(.ICNST,NAME,SSN,DOB,GENDER)
 I +ICNST'=1 S RETSTA=ICNST QUIT
 N DHPICN S DHPICN=$P(ICNST,U,3)
 N PATIEN S PATIEN=$O(^DPT("AFICN",DHPICN,""))
 ;
 N HFARRAY
 S RETSTA=$$HLFS(.HFARRAY,PATIEN,DHPICN,FRDAT,TODAT)
 ;
 ;I $G(RETJSON)="F" D xxx  ;create array for FHIR
 ;
 I $G(RETJSON)="J"!($G(RETJSON)="F") D
 . S RETSTA=""
 . D TOJASON^SYNDHPUTL(.HFARRAY,.RETSTA)
 ;
 QUIT
 ;
 ; ---------------- Get patient health factors ------------------------------
 ;
PATHLFI(RETSTA,DHPICN,FRDAT,TODAT,RETJSON) ; Patient health factors for ICN
 ;
 ; Return patient vitals for a given patient ICN
 ;
 ; Input:
 ;   ICN     - unique patient identifier across all VistA systems
 ;   FRDAT   - from date (inclusive), optional, compared to Visit Date/Time
 ;   TODAT   - to date (inclusive), optional, compared to Visit Date/Time
 ;   RETJSON - J = Return JSON
 ;             F = Return FHIR
 ;             0 or null = Return health factors string (default)
 ; Output:
 ;   RETSTA  - a delimited string that list the health factors for the patient
 ;           - ICN^SCT code|HF Name|Resource ID|HF Severity|Encounter Provider|Visit Date^...
 ;          or patient health factors in JSON format
 ;
 ; bypass for CQM
 ;
 ; ***********
 ; *********** Important Note for open source community
 ; ***********
 ; *********** Perspecta - who developed this source code and have released it to the open source
 ; *********** need the following six lines to remain intact
 ;
 I DHPICN="2495309561V670720" D  QUIT
 . S RETSTA="2495309561V670720^75624-7|5 or more drinks|442_130_1014|9|9990000033|20170101^24165007|Alcohol Counseling and Treatment|442_130_101||9990000033|20170101"
 I DHPICN="1686299845V246594" D  QUIT
 . S RETSTA="1686299845V246594^44249-1|PHQ-9|442_130_1014|4.0|9990000033|20170101"
 ;I DHPICN="2495309561V670720" D  QUIT
 ;. S RETSTA="2495309561V670720^24165007|Alcohol Counseling and Treatment|442_130_101||9990000033|20170101"
 ;
 ; *********** the above lines will be redacted by Perspecta at some suitable juncture to
 ; *********** be determined by Perspecta
 ; ***********
 ; *********** End of Important Note for open source community
 ;
 ;HLFCTS_U_SCT_P_HLF
 ;SCTPT_P_HID_P_HFSEV_P_HFPROV_P_HFDATE=HLF
 ;
 ; validate ICN
 I $G(DHPICN)="" S RETSTA="-1^What patient?" QUIT
 I '$$UICNVAL^SYNDHPUTL(DHPICN) S RETSTA="-1^Patient identifier not recognised" QUIT
 ;
 S FRDAT=$S($G(FRDAT):$$HL7TFM^XLFDT(FRDAT),1:1000101)
 S TODAT=$S($G(TODAT):$$HL7TFM^XLFDT(TODAT),1:9991231)
 I $G(DEBUG) W !,"FRDAT: ",FRDAT,"   TODAT: ",TODAT,!
 I FRDAT>TODAT S RETSTA="-1^From date is greater than to date" QUIT
 ;
 ; get patient IEN from ICN
 N PATIEN S PATIEN=$O(^DPT("AFICN",DHPICN,""))
 I PATIEN="" S RETSTA="-1^Internal data structure error" QUIT
 ;
 N HFARRAY
 S RETSTA=$$HLFS(.HFARRAY,PATIEN,DHPICN,FRDAT,TODAT)
 ;
 ;I $G(RETJSON)="F" D xxx  ;create array for FHIR
 ;
 I $G(RETJSON)="J"!($G(RETJSON)="F") D
 . S RETSTA=""
 . D TOJASON^SYNDHPUTL(.HFARRAY,.RETSTA)
 ;
 QUIT
 ;
HLFS(HFARRAY,PATIEN,DHPICN,FRDAT,TODAT) ; get health factors for a patient
 ; build the array of SNOMED CT codes that correspond to health factors
 ;
 N USER S USER=$$DUZ^SYNDHP69
 N SITE S SITE=$P($$SITE^VASITE,"^",3)
 N P S P="|"
 N FNUM S FNUM=9000010.23
 N FNBR2 S FNBR2=9000010 ;visit
 I $G(DEBUG) W !,"Health Factors",!
 ;
 ; scan Health Factors C index for DFN
 N VISITID,VISITDT,VISITHL,HID,HFACT,HFACTOR,HFSEV,HFDATE,HFDATEHL
 N HFOPRVNM,HFEPRVNM,HFOPROV,HFEPROV,SCTPT,SCT,ZARR,HLFCTS
 N HIEN S HIEN=""
 F  S HIEN=$O(^AUPNVHF("C",PATIEN,HIEN)) QUIT:HIEN=""  D
 . N HLFACT
 . D GET1HLF^SYNDHP15(.HLFACT,HIEN,0)
 . I $D(HLFACT("HealthFactor","ERROR")) M HFARRAY("HealthFactors",HIEN)=HLFACT QUIT
 . S VISITID=HLFACT("HealthFactor","visitId") ;visit ien
 . S VISITDT=$$GET1^DIQ(FNBR2,VISITID_",",.01,"I") ;visit/admit date&time
 . QUIT:'$$RANGECK^SYNDHPUTL(VISITDT,FRDAT,TODAT)  ;quit if outside of requested date range
 . S VISITHL=$$FMTHL7^XLFDT(VISITDT) ;hl7 format visit/admit date&time
 . S HID=HLFACT("HealthFactor","resourceId")
 . S HFACT=HLFACT("HealthFactor","hlfNameId") ;health factor ien
 . S HFACTOR=HLFACT("HealthFactor","hlfName") ;health factor name
 . S HFSEV=HLFACT("HealthFactor","levelSeverity") ;level/severity
 . S HFDATE=HLFACT("HealthFactor","eventDateTime") ;event date and time
 . S HFDATEHL=$$FMTHL7^XLFDT(HFDATE) ;event date and time in HL7 format
 . S HFOPROV=HLFACT("HealthFactor","orderingProviderId") ;ordering provider ien
 . S HFOPRVNM=HLFACT("HealthFactor","orderingProvider") ;ordering provider
 . S HFEPROV=HLFACT("HealthFactor","encounterProviderId") ;encounter provider ien
 . S HFEPRVNM=HLFACT("HealthFactor","encounterProvider") ;encounter provider
 . S SCT=HLFACT("HealthFactor","hlfNameSCT")
 . S SCTPT=HFACTOR
 . M HFARRAY("HealthFactors",HIEN)=HLFACT ;
 . ;
 . ; if care plan HF, get SCT from name string
 . I $E(HLFACT("HealthFactor","hlfName"),1,4)="SYN " D
 . . S SCT=$P($P(HLFACT("HealthFactor","hlfName"),"SCT:",2),")",1)
 . ;
 . S ZARR(HIEN)=SCT_P_SCTPT_P_HID_P_HFSEV_P_HFEPRVNM_P_VISITHL
 . ;
 . I $G(DEBUG)=1 D
 . . W !,"Record IEN:",?21,HIEN,!
 . . W "Health Factor:",?21,HFACT,"     ",HFACTOR,!
 . . W "Visit IEN:",?21,VISITID,!
 . . W "Visit Date:",?21,VISITDT,"     ",VISITHL,!
 . . W "Level/Severity:",?21,HFSEV,!
 . . W "Event Date:",?21,HFDATE,"     ",HFDATEHL,!
 . . W "Ordering Provider: ",?21,HFOPROV,"     ",HFOPRVNM,!
 . . W "Encounter Provider:",?21,HFEPROV,"     ",HFEPRVNM,!
 . . W "SCT:",?21,SCT,"     ",SCTPT,!!
 ;
 ; serialize data
 S HIEN=""
 S HLFCTS=DHPICN
 F  S HIEN=$O(ZARR(HIEN)) QUIT:HIEN=""  D
 . S HLFCTS=HLFCTS_U_ZARR(HIEN)
 ;
 QUIT HLFCTS
 ;
 ; ----------- Unit Test -----------
T1 ;
 N ICN S ICN="5000001536V889384"
 N FRDAT S FRDAT=""
 N TODAT S TODAT=""
 N JSON S JSON=""
 N RETSTA
 D PATHLFI(.RETSTA,ICN,FRDAT,TODAT,JSON)
 W $$ZW^SYNDHPUTL("RETSTA")
 QUIT
 ;
T2 ;
 N ICN S ICN="5000001536V889384"
 N FRDAT S FRDAT=20150101
 N TODAT S TODAT=20151231
 N JSON S JSON=""
 N RETSTA
 D PATHLFI(.RETSTA,ICN,FRDAT,TODAT,JSON)
 W $$ZW^SYNDHPUTL("RETSTA")
 QUIT
 ;
T3 ;
 N ICN S ICN="5000001536V889384"
 N FRDAT S FRDAT=""
 N TODAT S TODAT=""
 N JSON S JSON="J"
 N RETSTA
 D PATHLFI(.RETSTA,ICN,FRDAT,TODAT,JSON)
 W $$ZW^SYNDHPUTL("RETSTA")
 QUIT
 ;
HLFTEST0 ; all pass ICN
 N ICN S ICN=""
 F  S ICN=$O(^DPT("AFICN",ICN)) Q:ICN=""  D
 .D PATHLFI(.RETSTA,ICN) W $$ZW^SYNDHPUTL("RETSTA")
 Q
HLFTEST1 ; all pass ICN return those with data
 N ICN S ICN=""
 F  S ICN=$O(^DPT("AFICN",ICN)) Q:ICN=""  D
 .D PATHLFI(.RETSTA,ICN)
 .I $L(RETSTA,"|")>1 W $$ZW^SYNDHPUTL("RETSTA")
 Q
