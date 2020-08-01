SYNDHP53 ; HC/fjf/art - HealthConcourse - get patient labs ;07/24/2019
 ;;1.0;DHP;;Jan 17, 2017;Build 46
 ;;
 ;;Original routine authored by Andrew Thompson & Ferdinand Frankson of Perspecta 2017-2019
 ;
 QUIT
 ;
 ;
 ; ---------------- Get patient labs ----------------------
 ;
PATLAB(RETSTA,NAME,SSN,DOB,GENDER,FRDAT,TODAT) ; get labs for a patient by traits
 S RETSTA="-1^This service has been retired"
 QUIT
 ; Return patient labs for name, SSN, DOB, and gender
 ;
 ; Input:
 ;   NAME    - patient name
 ;   SSN     - social security number
 ;   DOB     - date of birth
 ;   GENDER  - gender
 ;   FRDAT   - from date (inclusive), optional, compared to 63.04:.01 DATE/TIME SPECIMEN TAKEN
 ;   TODAT   - to date (inclusive), optional, compared to 63.04:.01 DATE/TIME SPECIMEN TAKEN
 ; Output:
 ;   RETSTA  - a delimited string that lists LOINC codes for the patient labs
 ;           - ICN^LOINC code1|LOINC description|result|date|identifier
 ;
 S FRDAT=$S($G(FRDAT):$$HL7TFM^XLFDT(FRDAT),1:1000101)
 S TODAT=$S($G(TODAT):$$HL7TFM^XLFDT(TODAT),1:9991231)
 I $G(DEBUG) W !,"FRDAT: ",FRDAT,"   TODAT: ",TODAT,!
 ;
 N P,ICNST,PATIEN
 ;
 S P="|"
 D PATVAL^SYNDHP43(.ICNST,NAME,SSN,DOB,GENDER)
 I +ICNST'=1 S RETSTA=ICNST QUIT
 ; if we are here we are dealing with a valid patient
 S DHPICN=$P(ICNST,U,3)
 ; get patient IEN from ICN
 S PATIEN=$O(^DPT("AFICN",DHPICN,""))
 I PATIEN="" S RETSTA="-1^Patient ICN not found" QUIT
 D LABS(.RETSTA,PATIEN,FRDAT,TODAT,DHPICN)
 ;
 QUIT
 ;
PATLABI(RETSTA,DHPICN,FRDAT,TODAT,RETJSON) ; Patient labs for ICN
 ;
 ; Return patient labs for a given patient ICN
 ;
 ; Input:
 ;   DHPICN  - unique patient identifier across all VistA systems
 ;   FRDAT   - from date (inclusive), optional, compared to 63.04:.01 DATE/TIME SPECIMEN TAKEN
 ;   TODAT   - to date (inclusive), optional, compared to 63.04:.01 DATE/TIME SPECIMEN TAKEN
 ;   RETJSON - J = Return JSON
 ;             F = Return FHIR
 ;             0 or null = Return lab string (default)
 ; Output:
 ;   RETSTA  - a delimited string that lists LOINC codes for the patient labs
 ;           - ICN^LOINC code1|LOINC description|result|date|resource ID^...
 ;          or patient chem labs in JSON format
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
 N LABARRAY
 N PATIEN S PATIEN=$O(^DPT("AFICN",DHPICN,""))
 I PATIEN="" S RETSTA="-1^Internal data structure error" QUIT
 ;
 D LABS(.RETSTA,PATIEN,FRDAT,TODAT,DHPICN,.LABARRAY)
 ;
 ;I $G(RETJSON)="F" D xxx  ;create array for FHIR
 ;
 I $G(RETJSON)="J"!($G(RETJSON)="F") D
 . S RETSTA=""
 . D TOJASON^SYNDHPUTL(.LABARRAY,.RETSTA)
 ;
 QUIT
 ;
LABS(LLIST,PATIEN,FRDAT,TODAT,DHPICN,LABARRAY) ; return chem labs for patient
 ;
 N LABREF S LABREF=$$GET1^DIQ(2,PATIEN_",",63) ;laboratory reference in Patient file
 I LABREF="" S LLIST=DHPICN QUIT
 ;
 N P S P="|"
 N RETSEQ S RETSEQ=0
 N LABS,TESTDT,TESTDTHL,LOINCCD,LOINCNM,RESULT,LABID,TESTIEN,TESTNAME,ARRAY
 D GETLABS^SYNDHP21(.LABS,LABREF,0)
 I $D(LABS("Lab","ERROR")) M LABARRAY("Labs",PATIEN)=LABS QUIT
 N SEQ S SEQ=""
 F  S SEQ=$O(LABS("Lab","chemHemToxRiaSerEtcs","chemHemToxRiaSerEtc",SEQ)) QUIT:SEQ=""  D
 . N TEST S TEST=$NA(LABS("Lab","chemHemToxRiaSerEtcs","chemHemToxRiaSerEtc",SEQ))
 . S TESTDT=@TEST@("dateTimeSpecimenTakenFM")
 . QUIT:'$$RANGECK^SYNDHPUTL(TESTDT,FRDAT,TODAT)  ;quit if outside of requested date range
 . S TESTDTHL=@TEST@("dateTimeSpecimenTakenHL7")
 . S LOINCCD=@TEST@("loincCode")
 . S LOINCNM=@TEST@("loincName")
 . S RESULT=@TEST@("result")
 . S TESTIEN=@TEST@("labTestId")
 . S TESTNAME=@TEST@("labTestName")
 . S LABID=@TEST@("resourceId")
 . I $G(DEBUG) D
 . . ;W "  Workload Code: ",WKLDCODE,?30,WKLDNAME,!
 . . W "  Test Name:     ",TESTIEN,?30,TESTNAME,!
 . . W "  LOINC Code: ",LOINCCD,!
 . . W "  LOINC Name: ",LOINCNM,!
 . . W "  Result:     ",RESULT,!
 . S RETSEQ=RETSEQ+1
 . S ARRAY(RETSEQ)=LOINCCD_P_LOINCNM_P_RESULT_P_TESTDTHL_P_LABID
 . M LABARRAY("Labs",PATIEN)=LABS ;
 ;
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("ARRAY") W !
 ;serialize data
 S LLIST=DHPICN
 S RETSEQ=""
 F  S RETSEQ=$O(ARRAY(RETSEQ)) QUIT:RETSEQ=""  D
 . S LLIST=LLIST_U_ARRAY(RETSEQ)
 ;
 QUIT
 ;
 ; --------------------------------------------------------------------
 ;
 ; ----------- Unit Test -----------
T1 ;
 N ICN S ICN="5000001536V889384"
 N FRDAT S FRDAT=""
 N TODAT S TODAT=""
 N JSON S JSON=""
 N RETSTA
 D PATLABI(.RETSTA,ICN,FRDAT,TODAT,JSON)
 W $$ZW^SYNDHPUTL("RETSTA")
 QUIT
 ;
T2 ;
 N ICN S ICN="5000001536V889384"
 N FRDAT S FRDAT=20140131
 N TODAT S TODAT=20150131
 N JSON S JSON=""
 N RETSTA
 D PATLABI(.RETSTA,ICN,FRDAT,TODAT,JSON)
 W $$ZW^SYNDHPUTL("RETSTA")
 QUIT
 ;
T3 ;
 N ICN S ICN="5000001536V889384"
 N FRDAT S FRDAT=""
 N TODAT S TODAT=""
 N JSON S JSON="J"
 N RETSTA
 D PATLABI(.RETSTA,ICN,FRDAT,TODAT,JSON)
 W $$ZW^SYNDHPUTL("RETSTA")
 QUIT
 ;
