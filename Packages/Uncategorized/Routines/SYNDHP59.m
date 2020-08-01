SYNDHP59 ; HC/art - HealthConcourse - get care plan data for a patient ;07/24/2019
 ;;1.0;DHP;;Jan 17, 2017;Build 46
 ;;
 ;;Original routine authored by Andrew Thompson & Ferdinand Frankson of Perspecta 2017-2019
 ;
 QUIT
 ; -------------------- Patient Care Plans --------------------
 ;
PATCPALL(RETSTA,NAME,SSN,DOB,GENDER,FRDAT,TODAT,RETJSON) ; get Care Plans for a patient by traits
 S RETSTA="-1^This service has been retired"
 QUIT
 ; Return patient Care Plans for name, SSN, DOB, and gender
 ; This API will only return data for Synthea care plan patients
 ;
 ; Input:
 ;   NAME    - patient name
 ;   SSN     - social security number
 ;   DOB     - date of birth
 ;   GENDER  - gender
 ;   FRDATE  - from date (inclusive), optional, compared to Visit Date/Time
 ;   TODATE  - to date (inclusive), optional, compared to Visit Date/Time
 ;   RETJSON - J = Return JSON
 ;             F = Return FHIR
 ;             0 = Return Care Plan string (default)
 ; Output:
 ;   RETSTA  - a delimited string ...
 ;           - ICN^resourceId|HF SCT|HF Name|levelSeverity|encounterProvider|eventDateTime|visitDateTime|comments^...
 ;
 S FRDAT=$S($G(FRDAT):$$HL7TFM^XLFDT(FRDAT),1:1000101)
 S TODAT=$S($G(TODAT):$$HL7TFM^XLFDT(TODAT),1:9991231)
 I $G(DEBUG) W !,"FRDAT: ",FRDAT,"   TODAT: ",TODAT,!
 ;
 N ICNST,DHPICN,PATIEN
 ;
 D PATVAL^SYNDHP43(.ICNST,NAME,SSN,DOB,GENDER)
 I +ICNST'=1 S RETSTA=ICNST QUIT
 S DHPICN=$P(ICNST,U,3)
 ;
 ; get patient IEN from ICN
 S PATIEN=$O(^DPT("AFICN",DHPICN,""))
 ;
 S RETSTA=DHPICN
 ;
 D GETALL(.RETSTA,PATIEN,FRDAT,TODAT)
 ;
 QUIT
 ;
 ; -------------------- Patient Care Plans --------------------
 ;
PATCPALLI(RETSTA,DHPICN,FRDAT,TODAT,RETJSON) ; Get Patient Care Plans for ICN
 ;
 ; Return patient Care Plans for a given patient ICN
 ; This API will only return care plan(s) for ingested Synthea patients
 ;
 ; Input:
 ;   DHPICN  - patient ICN (unique patient identifier across all VistA systems)
 ;   FRDAT   - from date (inclusive), optional, compared to Visit Date/Time
 ;   TODAT   - to date (inclusive), optional, compared to Visit Date/Time
 ;   RETJSON - J = Return JSON
 ;             F = Return FHIR
 ;             0 = Return Care Plan string (default)
 ; Output:
 ;   RETSTA  - a delimited string ...
 ;           - ICN^resourceId|HF SCT|HF Name|levelSeverity|encounterProvider|eventDateTime|visitDateTime|comments^...
 ;         or care plan data in JSON format
 ;
 S FRDAT=$S($G(FRDAT):$$HL7TFM^XLFDT(FRDAT),1:1000101)
 S TODAT=$S($G(TODAT):$$HL7TFM^XLFDT(TODAT),1:9991231)
 I $G(DEBUG) W !,"FRDAT: ",FRDAT,"   TODAT: ",TODAT,!
 I FRDAT>TODAT S RETSTA="-1^From date is greater than to date" QUIT
 ;
 ; validate ICN
 I $G(DHPICN)="" S RETSTA="-1^What patient?" QUIT
 I '$$UICNVAL^SYNDHPUTL(DHPICN) S RETSTA="-1^Patient identifier not recognised" QUIT
 ;
 ; get patient IEN from ICN
 N PATIEN S PATIEN=$O(^DPT("AFICN",DHPICN,""))
 I PATIEN="" S RETSTA="-1^Internal data structure error" QUIT
 ;
 S RETSTA=DHPICN
 ;
 D GETALL(.RETSTA,PATIEN,FRDAT,TODAT)
 ;
 QUIT
 ;
GETALL(RETSTA,PATIEN,FRDAT,TODAT) ;get all care plans for a patient
 ;
 N P S P="|"
 ;
 N visitId,HLFACTS
 N HFIEN S HFIEN=""
 F  S HFIEN=$O(^AUPNVHF("C",PATIEN,HFIEN)) QUIT:HFIEN=""  D
 . N HLFACT
 . D GET1HLF^SYNDHP15(.HLFACT,HFIEN,1,0)
 . I $D(HLFACT("HealthFactor","ERROR")) M HLFACTS("CarePlan",HFIEN)=HLFACT QUIT
 . ;I $D(HLFACT("HealthFactor","ERROR")) M HLFACTS("CarePlan",visitId,"Visit",HFIEN)=HLFACT QUIT
 . QUIT:$E(HLFACT("HealthFactor","hlfName"),1,4)'="SYN "
 . I $G(DEBUG) W HLFACT("HealthFactor","visitFM"),!
 . QUIT:'$$RANGECK^SYNDHPUTL(HLFACT("HealthFactor","visitFM"),FRDAT,TODAT)  ;quit if outside of requested date range
 . S visitId=HLFACT("HealthFactor","visitId")
 . M HLFACTS("CarePlan",visitId,"Visit",HFIEN)=HLFACT
 . I $G(RETJSON)'="J",$G(RETJSON)'="F" D
 . . S RETSTA=RETSTA_U_HLFACT("HealthFactor","resourceId")_P_HLFACT("HealthFactor","hlfNameSCT")_P_HLFACT("HealthFactor","hlfName")_P
 . . S RETSTA=RETSTA_HLFACT("HealthFactor","levelSeverity")_P_HLFACT("HealthFactor","encounterProvider")_P_HLFACT("HealthFactor","eventDateTimeHL7")_P
 . . S RETSTA=RETSTA_HLFACT("HealthFactor","visitHL7")_P_HLFACT("HealthFactor","comments")
 ;
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("HLFACTS")
 ;
 ;I $G(RETJSON)="F" D xxx  ;create array for FHIR
 ;
 I $G(RETJSON)="J"!($G(RETJSON)="F") D
 . S RETSTA=""
 . D TOJASON^SYNDHPUTL(.HLFACTS,.RETSTA)
 ;
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("RETSTA")
 ;
 QUIT
 ;
PATCP(RETSTA,NAME,SSN,DOB,GENDER,VRESID,RETJSON) ; get Care Plan for a patient by traits and Visit ID
 S RETSTA="-1^This service has been retired"
 QUIT
 ; Return patient Care Plans for name, SSN, DOB, and gender and Visit ID
 ; This API will only return data for Synthea care plan patients
 ;
 ; Input:
 ;   NAME    - patient name
 ;   SSN     - social security number
 ;   DOB     - date of birth
 ;   GENDER  - gender
 ;   VRESID  - Visit resource ID
 ;   RETJSON - J = Return JSON
 ;             0 = Return Care Plan string (default)
 ; Output:
 ;   RETSTA  - a delimited string ...
 ;           - ICN^resourceId|HF SCT|HF Name|levelSeverity|encounterProvider|eventDateTime|visitDateTime|comments^...
 ;         or care plan data in JSON format
 ;
 I $G(VRESID)="" S RETSTA="-1^What visit?" QUIT
 ;
 N ICNST
 D PATVAL^SYNDHP43(.ICNST,NAME,SSN,DOB,GENDER)
 I +ICNST'=1 S RETSTA=ICNST QUIT
 N DHPICN S DHPICN=$P(ICNST,U,3)
 ;
 ; get patient IEN from ICN
 N PATIEN S PATIEN=$O(^DPT("AFICN",DHPICN,""))
 ;
 S RETSTA=DHPICN
 ;
 D GETONE(.RETSTA,PATIEN,VRESID)
 ;
 QUIT
 ;
PATCPI(RETSTA,DHPICN,VRESID,RETJSON) ; Patient Care Plan(s) for ICN and Visit ID
 ;
 ; Return patient Care Plan for a given patient ICN and Visit ID
 ; This API will only return data for Synthea care plan patients
 ;
 ; Input:
 ;   DHPICN  - patient ICN (unique patient identifier across all VistA systems)
 ;   VRESID  - Visit resource ID, "_" piece 4 is the visit ien
 ;   RETJSON - J = Return JSON
 ;             F = Return FHIR
 ;             0 = Return Care Plan string (default)
 ; Output:
 ;   RETSTA  - a delimited string ...
 ;           - ICN^resourceId|HF SCT|HF Name|levelSeverity|encounterProvider|eventDateTime|visitDateTime|comments^...
 ;         or care plan data in JSON format
 ;
 I $G(DHPICN)="" S RETSTA="-1^What patient?" QUIT
 I $G(VRESID)="" S RETSTA="-1^What visit?" QUIT
 ;
 ; validate ICN
 I '$$UICNVAL^SYNDHPUTL(DHPICN) S RETSTA="-1^Patient identifier not recognised" Q
 ;
 ; get patient IEN from ICN
 N PATIEN S PATIEN=$O(^DPT("AFICN",DHPICN,""))
 ;
 S RETSTA=DHPICN
 ;
 D GETONE(.RETSTA,PATIEN,VRESID)
 ;
 QUIT
 ;
GETONE(RETSTA,PATIEN,VRESID) ;get care plan(s) for a visit
 ;
 N P S P="|"
 N S S S="_"
 N D S D="-"
 ;
 N HLFACTS
 N VISIT S VISIT=$P(VRESID,D,4)
 N HFIEN S HFIEN=""
 F  S HFIEN=$O(^AUPNVHF("C",PATIEN,HFIEN)) QUIT:HFIEN=""  D
 . N HLFACT
 . D GET1HLF^SYNDHP15(.HLFACT,HFIEN,1,0)
 . I $D(HLFACT("HealthFactor","ERROR")) M HLFACTS("CarePlan",HFIEN)=HLFACT QUIT
 . ;I $D(HLFACT("HealthFactor","ERROR")) M HLFACTS("CarePlan",visitId,"Visit",HFIEN)=HLFACT QUIT
 . QUIT:$E(HLFACT("HealthFactor","hlfName"),1,4)'="SYN "  ;skip if not synthea ingested
 . QUIT:VISIT'=HLFACT("HealthFactor","visitId")  ;skip if not for requested visit
 . S visitId=HLFACT("HealthFactor","visitId")
 . M HLFACTS("CarePlan",visitId,"Visit",HFIEN)=HLFACT
 . I $G(RETJSON)'="J",$G(RETJSON)'="F" D
 . . S RETSTA=RETSTA_U_HLFACT("HealthFactor","resourceId")_P_HLFACT("HealthFactor","hlfNameSCT")_P_HLFACT("HealthFactor","hlfName")_P
 . . S RETSTA=RETSTA_HLFACT("HealthFactor","levelSeverity")_P_HLFACT("HealthFactor","encounterProvider")_P_HLFACT("HealthFactor","eventDateTimeHL7")_P
 . . S RETSTA=RETSTA_HLFACT("HealthFactor","visitHL7")_P_HLFACT("HealthFactor","comments")
 ;
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("HLFACTS")
 ;
 ;I $G(RETJSON)="F" D xxx  ;create array for FHIR
 ;
 I $G(RETJSON)="J"!($G(RETJSON)="F") D
 . S RETSTA=""
 . D TOJASON^SYNDHPUTL(.HLFACTS,.RETSTA)
 ;
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("RETSTA")
 ;
 QUIT
 ;
 ; ----------- Unit Test -----------
T1 ;
 N ICN S ICN="1435855215V947437"
 N FRDAT S FRDAT=""
 N TODAT S TODAT=""
 N JSON S JSON=""
 N RETSTA
 D PATCPALLI(.RETSTA,ICN,FRDAT,TODAT,JSON)
 W $$ZW^SYNDHPUTL("RETSTA"),!!
 QUIT
 ;
T2 ;
 N ICN S ICN="1435855215V947437"
 N FRDAT S FRDAT=20000101
 N TODAT S TODAT=20120101
 N JSON S JSON=""
 N RETSTA
 D PATCPALLI(.RETSTA,ICN,FRDAT,TODAT,JSON)
 W $$ZW^SYNDHPUTL("RETSTA"),!!
 QUIT
 ;
T3 ;
 N ICN S ICN="1435855215V947437"
 N FRDAT S FRDAT=""
 N TODAT S TODAT=""
 N JSON S JSON="J"
 N RETSTA
 D PATCPALLI(.RETSTA,ICN,FRDAT,TODAT,JSON)
 W $$ZW^SYNDHPUTL("RETSTA"),!!
 QUIT
 ;
T4 ;
 N ICN S ICN="2434609669V691690"
 N VRESID S VRESID="V-500-1000010-34494"
 N JSON S JSON=""
 N RETSTA
 D PATCPI(.RETSTA,ICN,VRESID,JSON)
 W $$ZW^SYNDHPUTL("RETSTA"),!!
 QUIT
 ;
T5 ;
 N ICN S ICN="2434609669V691690"
 N VRESID S VRESID="V-500-1000010-34494"
 N JSON S JSON="J"
 N RETSTA
 D PATCPI(.RETSTA,ICN,VRESID,JSON)
 W $$ZW^SYNDHPUTL("RETSTA"),!!
 QUIT
 ;
