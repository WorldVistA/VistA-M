SYNDHP07 ; HC/rbd/art - HealthConcourse - get patient's nursing care plan data ;07/23/2019
 ;;1.0;DHP;;Jan 17, 2017;Build 46
 ;;
 ;;Original routine authored by Andrew Thompson & Ferdinand Frankson of Perspecta 2017-2019
 ;
 QUIT
 ;
 ;
 ; ---------------- Get patient nursing care plan goals information ------------------------
 ;
PATGOLI(RETSTA,DHPICN,FRDAT,TODAT,RETJSON) ; Patient goals for ICN
 ;
 ; Return patient nursing care plan goals for a given patient ICN
 ;
 ; Input:
 ;   ICN     - unique patient identifier across all VistA systems
 ;   FRDAT   - from date (inclusive), optional, compares to date/time entered
 ;   TODAT   - to date (inclusive), optional, compares to date/time entered
 ;   RETJSON - J = Return JSON
 ;             F = Return FHIR
 ;             0 or null = Return patient goals string (default)
 ; Output:
 ;   RETSTA  - a delimited string that lists patient goals information
 ;             ICN ^ Resource ID | Date/Time Entered | Goal/Expected Outcome | Target Date | User Who Entered | code ; Status of Goal ^ ...
 ;          or patient nursing care plans in JSON format
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
 N NCPARR
 N PATIEN S PATIEN=$O(^DPT("AFICN",DHPICN,""))
 I PATIEN="" S RETSTA="-1^Internal data structure error" QUIT
 ;
 S RETSTA=$$GOALS(.NCPARR,PATIEN,DHPICN,FRDAT,TODAT)
 ;
 ;I $G(RETJSON)="F" D xxx  ;create array for FHIR
 ;
 I $G(RETJSON)="J"!($G(RETJSON)="F") D
 . S RETSTA=""
 . D TOJASON^SYNDHPUTL(.NCPARR,.RETSTA)
 ;
 QUIT
 ;
GOALS(NCPARR,PATIEN,DHPICN,FRDAT,TODAT) ; get goals for a patient
 ;
 N FNUM S FNUM=216.8      ;  file
 N S S S="_"
 N P S P="|"
 ; scan PATIENT "TARG" index in Nursing Care Plan file for Goals
 N TARGNUM,PTGOLID,ENTRYDT,ENTRYDTFM,ENTRDISP,GOAL,TARGDISP,ENTUSER,GOALSTAT,ZARR,GOALREC
 N MRECIEN S MRECIEN=""
 F  S MRECIEN=$O(^GMR(124.3,"C",PATIEN,MRECIEN)) QUIT:MRECIEN=""  D
 . N NCP
 . D GET1NCP^SYNDHP15(.NCP,MRECIEN,0)
 . I $D(NCP("NurseCarePlan","ERROR")) M NCPARR("NCPS",MRECIEN)=NCP QUIT
 . S TARGNUM=""
 . F  S TARGNUM=$O(NCP("NurseCarePlan","targetDates","targetDate",TARGNUM)) QUIT:TARGNUM=""  D
 . . S PTGOLID=NCP("NurseCarePlan","targetDates","targetDate",TARGNUM,"resourceId")
 . . S ENTRYDT=NCP("NurseCarePlan","targetDates","targetDate",TARGNUM,"dateTimeEntered")
 . . S ENTRYDTFM=NCP("NurseCarePlan","targetDates","targetDate",TARGNUM,"dateTimeEnteredFM")
 . . QUIT:'$$RANGECK^SYNDHPUTL(ENTRYDTFM,FRDAT,TODAT)  ;quit if outside of requested date range
 . . S ENTRDISP=NCP("NurseCarePlan","targetDates","targetDate",TARGNUM,"dateTimeEnteredHL7")
 . . S GOAL=NCP("NurseCarePlan","targetDates","targetDate",TARGNUM,"goalExpectedOutcome")
 . . S TARGDISP=NCP("NurseCarePlan","targetDates","targetDate",TARGNUM,"targetDateHL7")
 . . S ENTUSER=NCP("NurseCarePlan","targetDates","targetDate",TARGNUM,"userWhoEntered")
 . . S GOALSTAT=NCP("NurseCarePlan","targetDates","targetDate",TARGNUM,"goalMetDcdCd")_";"_NCP("NurseCarePlan","targetDates","targetDate",TARGNUM,"goalMetDcd")
 . . S ZARR(DHPICN,ENTRYDTFM,GOAL)=PTGOLID_P_ENTRDISP_P_GOAL_P_TARGDISP_P_ENTUSER_P_GOALSTAT
 . ;patient data is not included in the NCP record
 . S NCP("NurseCarePlan","patient")=$$GET1^DIQ(2,PATIEN_",",.01)
 . S NCP("NurseCarePlan","patientId")=PATIEN
 . S NCP("NurseCarePlan","patientICN")=DHPICN
 . M NCPARR("NCPS",MRECIEN)=NCP ;
 ;
 ; serialize data
 S ENTRYDT=""
 N GOALS S GOALS=DHPICN
 F  S ENTRYDT=$O(ZARR(DHPICN,ENTRYDT)) Q:ENTRYDT=""  D
 . S GOAL=""
 . F  S GOAL=$O(ZARR(DHPICN,ENTRYDT,GOAL)) Q:GOAL=""  D
 . . S GOALREC=ZARR(DHPICN,ENTRYDT,GOAL)
 . . S GOALS=GOALS_U_GOALREC
 ;
 QUIT GOALS
 ;
 ; ----------- Unit Test -----------
T1 ;
 N ICN S ICN="1967316818V742124"
 N FRDAT S FRDAT=""
 N TODAT S TODAT=""
 N JSON S JSON=""
 N RETSTA
 D PATGOLI(.RETSTA,ICN,FRDAT,TODAT,JSON)
 W $$ZW^SYNDHPUTL("RETSTA")
 QUIT
 ;
T2 ;
 N ICN S ICN="1967316818V742124"
 N FRDAT S FRDAT=19930212
 N TODAT S TODAT=19930228
 N JSON S JSON=""
 N RETSTA
 D PATGOLI(.RETSTA,ICN,FRDAT,TODAT,JSON)
 W $$ZW^SYNDHPUTL("RETSTA")
 QUIT
 ;
T3 ;
 N ICN S ICN="1967316818V742124"
 N FRDAT S FRDAT=""
 N TODAT S TODAT=""
 N JSON S JSON="J"
 N RETSTA
 D PATGOLI(.RETSTA,ICN,FRDAT,TODAT,JSON)
 W $$ZW^SYNDHPUTL("RETSTA")
 QUIT
 ;
