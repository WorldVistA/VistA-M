SYNDHP05 ; HC/fjf/art - HealthConcourse - retrieve patient diagnostic reports ;07/23/2019
 ;;1.0;DHP;;Jan 17, 2017;Build 46
 ;;
 ;;Original routine authored by Andrew Thompson & Ferdinand Frankson of Perspecta 2017-2019
 ;
 QUIT
 ;
 ; ---------------- Patient diagnostic reports ----------------------
 ;
PATDXRI(RETSTA,DHPICN,FRDAT,TODAT,RETJSON) ; Patient diagnostic report for ICN
 ;
 ; Return patient diagnostic report for a given patient ICN
 ;
 ; Input:
 ;   ICN     - unique patient identifier across all VistA systems
 ;   FRDAT   - from date (inclusive), optional
 ;   TODAT   - to date (inclusive), optional
 ;   RETJSON - J = Return JSON
 ;             F = Return FHIR
 ;             0 or null = Return diagnostic report string (default)
 ; Output:
 ;   RETSTA  - ICN^"IMG"|status|dateTime|provider|identifier|CPT|SCT|desc|primary dx|dx SCT|conclusion^...
 ;                ^"MHDX"|status|dateTime|provider|identifier|diag code|SCT|decription^...
 ;                ^"VISIT"|status|dateTime|provider|identifier|ICD|SCT|diag desc^...
 ;          or patient diagnostic report data in JSON format
 ;
 ; bypass for CQM
 ;
 ; ***********
 ; *********** Important Note for open source community
 ; ***********
 ; *********** Perspecta - who developed this source code and have released it to the open source
 ; *********** need the following six lines to remain intact
 ;
 I DHPICN="2608649748V030771" D  QUIT
 . S RETSTA="2608649748V030771^IMG|final|20170101|PROVIDER,ONE|V_500_74_608|44388||Colon Endoscopy||| there are no previous colonoscopy."
 . S RETSTA=RETSTA_" Impression: There is no definite colonoscopic evidence of malignancy.2. Comparison to previous colonoscopy would be helpful to assure stability."
 ;
 I DHPICN="2627244030V292232" D  QUIT
 . S RETSTA="2627244030V292232^IMG|final|20170101|PROVIDER,ONE|V_500_74_608|88147||Cytopath C/V Automated||| there are no previous cervical cancer screening report."
 . S RETSTA=RETSTA_" Impression: There is no definite CCS evidence of malignancy.2. Comparison to previous CCS would be helpful to assure stability."
 ;
 I DHPICN="1686299845V246594" D  QUIT
 . S RETSTA="1686299845V246594^MHDX|final|20170101|PROVIDER,ONE|V_500_74_608|F32.0|70747007|Major depressive disorder, single episode, mild"
 ;
 ; *********** the above lines will be redacted by Perspecta at some suitable juncture to
 ; *********** be determined by Perspecta
 ; ***********
 ; *********** End of Important Note for open source community
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
 N C,P,PATIEN
 ;
 N USER S USER=$$DUZ^SYNDHP69
 S C=",",P="|"
 ; get patient IEN from ICN
 S PATIEN=$O(^DPT("AFICN",DHPICN,""))
 I PATIEN="" S RETSTA="-1^Internal data structure error" QUIT
 ;
 S RETSTA=DHPICN
 ;
 N DXRPTS
 ;Radology Diagnosis
 N DXARRAY,RETVAL
 S RETVAL=$$DXRAD(.DXARRAY,PATIEN,FRDAT,TODAT)
 I $G(RETJSON)="J"!($G(RETJSON)="F") D
 . M DXRPTS=DXARRAY
 E  D
 . S RETSTA=RETSTA_RETVAL
 ;
 ;Mental Health Diagnosis
 N DXARRAY,RETVAL
 S RETVAL=$$DXMH(.DXARRAY,PATIEN,FRDAT,TODAT)
 I $G(RETJSON)="J"!($G(RETJSON)="F") D
 . M DXRPTS=DXARRAY
 E  D
 . S RETSTA=RETSTA_RETVAL
 ;
 ;Visit Diagnosis
 N DXARRAY,RETVAL
 S RETVAL=$$DXVISIT(.DXARRAY,PATIEN,FRDAT,TODAT)
 I $G(RETJSON)="J"!($G(RETJSON)="F") D
 . M DXRPTS=DXARRAY
 E  D
 . S RETSTA=RETSTA_RETVAL
 ;
 ;I $G(RETJSON)="F" D xxx  ;create array for FHIR
 ;
 I $G(RETJSON)="J"!($G(RETJSON)="F") D
 . S RETSTA=""
 . D TOJASON^SYNDHPUTL(.DXRPTS,.RETSTA)
 ;
 QUIT
 ;
DXRAD(DXRPTRAD,PATIEN,FRDAT,TODAT) ; get radiology diagnostic report
 ;
 N SEQ S SEQ=0
 N DXRRAD S DXRRAD=""
 I $G(DEBUG) W !,"Radiology Diagnoses",!
 N RADEX
 D RADEXAM^SYNDHP55(.RADEX,PATIEN,1,FRDAT,TODAT)
 ;             1      2        3       4            5            6         7        8     9     10     11                 12      13        14        15       16          17
 ; RADEX(SEQ)=PID_U_PatDfn_U_CatEx_U_ExamDate_U_ExamDateHl7_U_caseNbr_U_PROCIEN_U_PROC_U_CPT_U_SCT_U_primaryDiagnosis_U_REQPHYS_U_PIRES_U_PISTAFF_U_VISITDT_U_VISITHL_U_EnteringUser
 ;               1     2        3         4        5         6               7                        8
 ; RADEX(SEQ,1)=PID^dayCase^dateTime^dateTimeHL7^status id^status^verifying physician id^verifying physician name
 ; RADEX(SEQ,"REPORT")=report
 ; RADEX(SEQ,"IMPRESSION")=impression
 ;
 D BLDARRAY(.RADEX,.DXRPTRAD)
 ;
 N PRSTA,PDATE,PDATEHL,PPROV,PID,PRCPT,SCT,DESC,PRIMEDX,DXSCT,TEXT
 N IDX S IDX=""
 F  S IDX=$O(RADEX(IDX)) QUIT:IDX=""  D
 . QUIT:'$D(RADEX(IDX,1))  ;there is no rad diag rpt for this exam
 . S PRSTA="final" ;status
 . S PDATE=$P($G(RADEX(IDX,1)),U,3) ;exam date (FM)
 . QUIT:'$$RANGECK^SYNDHPUTL(PDATE,FRDAT,TODAT)  ;quit if outside of requested date range
 . S PDATEHL=$P($G(RADEX(IDX,1)),U,4) ;exam date (HL7)
 . S PPROV=$P($G(RADEX(IDX,1)),U,8) ;verifying provider
 . S PID=$P($G(RADEX(IDX,1)),U,1) ;resource id
 . S PRCPT=$P($G(RADEX(IDX)),U,9) ;procedure cpt
 . S SCT=$P($G(RADEX(IDX)),U,10) ;procedure sct
 . S DESC=$P($G(RADEX(IDX)),U,8) ;procedure desc
 . S PRIMEDX=$P($G(RADEX(IDX)),U,11) ;primary diagnosis
 . S DXSCT="" ;                              <<<<<<<<<<<<<<<< rad diagnoses are text, no associated SCT
 . S TEXT=$G(RADEX(IDX,"REPORT"))
 . S DXRRAD=DXRRAD_U_"IMG"_P_PRSTA_P_PDATEHL_P_PPROV_P_PID_P_PRCPT_P_SCT_P_DESC_P_PRIMEDX_P_DXSCT_P_TEXT
 ;
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("DXRRAD")
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("DXRPTRAD")
 ;
 QUIT DXRRAD
 ;   RETSTA  - ICN^"IMG"|status|dateTime|provider|identifier|CPT|SCT|desc|primary dx|dx SCT|conclusion^...
 ;
BLDARRAY(RADEX,DXRPTRAD) ;Build an array from data returned by RADEXAM^SYNDHP55
 ;
 ;             1      2        3          4            5            6         7        8     9     10     11                 12      13        14        15       16           17
 ; RADEX(SEQ)=PID_U_PatDfn_U_Category_U_ExamDate_U_ExamDateHl7_U_caseNbr_U_PROCIEN_U_PROC_U_CPT_U_SCT_U_primaryDiagnosis_U_REQPHYS_U_PIRES_U_PISTAFF_U_VISITDT_U_VISITHL_U_EnteringUser
 ;               1     2        3         4        5         6               7                        8
 ; RADEX(SEQ,1)=PID^dayCase^dateTime^dateTimeHL7^status id^status^verifying physician id^verifying physician name
 ; RADEX(SEQ,"REPORT")=report
 ; RADEX(SEQ,"IMPRESSION")=impression
 ;
 N IDX S IDX=""
 F  S IDX=$O(RADEX(IDX)) QUIT:IDX=""  D
 . QUIT:'$D(RADEX(IDX,1))  ;there is no rad diag rpt for this exam
 . S PDATE=$P($G(RADEX(IDX,1)),U,3) ;exam date (FM)
 . QUIT:'$$RANGECK^SYNDHPUTL(PDATE,FRDAT,TODAT)  ;quit if outside of requested date range
 . N RADEXAM S RADEXAM=$NA(DXRPTRAD("DxReportRad",IDX,"RadExam"))
 . S @RADEXAM@("resourceType")="DiagnosticReport"
 . S @RADEXAM@("resourceId")=$P($G(RADEX(IDX)),U,1)
 . S @RADEXAM@("status")="final"
 . S @RADEXAM@("patientId")=$P($G(RADEX(IDX)),U,2)
 . S @RADEXAM@("category")=$P($G(RADEX(IDX)),U,3)
 . S @RADEXAM@("ExamDateFM")=$P($G(RADEX(IDX)),U,4)
 . S @RADEXAM@("ExamDateHL7")=$P($G(RADEX(IDX)),U,5)
 . S @RADEXAM@("ExamDateFHIR")=$$FMTFHIR^SYNDHPUTL($P($G(RADEX(IDX)),U,4))
 . S @RADEXAM@("caseNbr")=$P($G(RADEX(IDX)),U,6)
 . S @RADEXAM@("procedureId")=$P($G(RADEX(IDX)),U,7)
 . S @RADEXAM@("procedure")=$P($G(RADEX(IDX)),U,8)
 . S @RADEXAM@("procedureCPT")=$P($G(RADEX(IDX)),U,9)
 . S @RADEXAM@("procedureSCT")=$P($G(RADEX(IDX)),U,10)
 . S @RADEXAM@("primaryDiagnosis")=$P($G(RADEX(IDX)),U,11)
 . S @RADEXAM@("primaryDiagnosisSCT")="" ;           <<<<<<<<<<<<<<<<<no icd to map
 . S @RADEXAM@("requestingPhysician")=$P($G(RADEX(IDX)),U,12)
 . S @RADEXAM@("primaryInterpretingResident")=$P($G(RADEX(IDX)),U,13)
 . S @RADEXAM@("primaryInterpretingStaff")=$P($G(RADEX(IDX)),U,14)
 . S @RADEXAM@("visitDateFM")=$P($G(RADEX(IDX)),U,15)
 . S @RADEXAM@("visitDateHL7")=$P($G(RADEX(IDX)),U,16)
 . S @RADEXAM@("visitDateFHIR")=$$FMTFHIR^SYNDHPUTL($P($G(RADEX(IDX)),U,15))
 . S @RADEXAM@("EnteringUser")=$P($G(RADEX(IDX)),U,17)
 . N RADRPT S RADRPT=$NA(DXRPTRAD("DxReportRad",IDX,"RadReport"))
 . S @RADRPT@("resourceId")=$P($G(RADEX(IDX,1)),U,1)
 . S @RADRPT@("dayCase")=$P($G(RADEX(IDX,1)),U,2)
 . S @RADRPT@("dateTimeFM")=$P($G(RADEX(IDX,1)),U,3)
 . S @RADRPT@("dateTimeHL7")=$P($G(RADEX(IDX,1)),U,4)
 . S @RADRPT@("dateTimeFHIR")=$$FMTFHIR^SYNDHPUTL($P($G(RADEX(IDX,1)),U,3))
 . S @RADRPT@("statusId")=$P($G(RADEX(IDX,1)),U,5)
 . S @RADRPT@("status")=$P($G(RADEX(IDX,1)),U,6)
 . S @RADRPT@("verifyingPhysicianId")=$P($G(RADEX(IDX,1)),U,7)
 . S @RADRPT@("verifyingPhysicianName")=$P($G(RADEX(IDX,1)),U,8)
 . S @RADRPT@("conclusion")=$G(RADEX(IDX,"REPORT"))
 . S @RADRPT@("impression")=$G(RADEX(IDX,"IMPRESSION"))
 ;
 QUIT
 ;$$FMTFHIR^SYNDHPUTL(
DXMH(DXRPTMH,PATIEN,FRDAT,TODAT) ;get Mental Health Diagnosis
 ;
 N MHDXRS,SERMHDXRS,MHIEN,IENS,MAPPING
 N STATUS,DXDTFM,DXDTHL,DXBY,PID,STATUS,DXCODE,SDESC
 ;
 N SNOMED S SNOMED=""
 N S,P
 S S="_",P="|"
 ;
 I $G(DEBUG) W !,"Mental Health Diagnosis",!
 N MHDXRS S MHDXRS=""
 N FNBR1 S FNBR1=627.8 ;Diagnostic Results-Mental Health
 N SEQ S SEQ=0
 ;
 S MHIEN=""
 F  S MHIEN=$O(^YSD(627.8,"C",PATIEN,MHIEN)) QUIT:MHIEN=""  D
 . S IENS=MHIEN_","
 . S DXCODE=$$GET1^DIQ(FNBR1,IENS,1) ;diagnosis
 . QUIT:DXCODE=""
 . N DXMH
 . D GET1MHDX^SYNDHP17(.DXMH,MHIEN,0)
 . QUIT:$D(DXMH("Mhdiag","ERROR"))
 . I $D(DXMH("Mhdiag","ERROR")) M DXRPTMH("DxReportMH",MHIEN)=DXMH QUIT
 . I $G(DEBUG) W $$ZW^SYNDHPUTL("DXMH")
 . S DXDTFM=DXMH("Mhdiag","dateTimeOfDiagnosisFM") ;date/time of diagnosis fm format
 . QUIT:'$$RANGECK^SYNDHPUTL(DXDTFM,FRDAT,TODAT)  ;quit if outside of requested date range
 . S DXDTHL=DXMH("Mhdiag","dateTimeOfDiagnosisHL7") ;hl7 format date/time of diagnosis
 . S DXBY=DXMH("Mhdiag","diagnosisBy") ;diagnosed by
 . S DXCODE=DXMH("Mhdiag","diagnosis") ;diagnosis
 . S SDESC=$P($$ICDDX^ICDEX(DXCODE),U,4)
 . S STATUS=$$LOW^XLFSTR(DXMH("Mhdiag","statusVPRINRu")) ;status
 . S PID=DXMH("Mhdiag","resourceId")
 . S SNOMED=DXMH("Mhdiag","diagnosisSCT")
 . ;
 . ;^category|status|dateTime|provider|identifier|diag code|SCT|diag desc^...
 . S SEQ=SEQ+1
 . S MHDXRS(SEQ)=U_"MHDX"_P_STATUS_P_DXDTHL_P_DXBY_P_PID_P_DXCODE_P_SNOMED_P_SDESC
 . M DXRPTMH("DxReportMH",MHIEN)=DXMH ;
 ;
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("MHDXRS")
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("DXRPTMH")
 ;
 ;serialize data
 S SERMHDXRS=""
 S SEQ=""
 F  S SEQ=$O(MHDXRS(SEQ)) QUIT:SEQ=""  D
 . S SERMHDXRS=SERMHDXRS_MHDXRS(SEQ)
 ;
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("SERMHDXRS")
 ;
 QUIT SERMHDXRS
 ;
DXVISIT(DXRPTV,PATIEN,FRDAT,TODAT) ; get visit diagnostic report
 ;
 N STATUS,DXDTHL,PROV,SERPOV,RESID,DXCODE,SNOMED,SDESC,MAPPING,SNOMED
 N SEQ S SEQ=0
 N DXVISIT S DXVISIT=""
 I $G(DEBUG) W !,"Visit Diagnosis",!
 ;patient - ^AUPNVPOV("C",
 N POVIEN S POVIEN=""
 F  S POVIEN=$O(^AUPNVPOV("C",PATIEN,POVIEN)) QUIT:POVIEN=""  D
 . N VPOV
 . D GET1VPOV^SYNDHP13(.VPOV,POVIEN,0)
 . I $D(VPOV("V POV","ERROR")) M DXRPTV("DxReportVisit",POVIEN)=VPOV QUIT
 . S VPOV("V POV","resourceType")="DiagnosticReport"
 . S STATUS="final"
 . S DXDTFM=VPOV("V POV","visitFM")
 . QUIT:'$$RANGECK^SYNDHPUTL(DXDTFM,FRDAT,TODAT)  ;quit if outside of requested date range
 . S DXDTHL=VPOV("V POV","visitHL7")
 . S PROV=VPOV("V POV","encounterProvider")
 . S RESID=VPOV("V POV","resourceId")
 . S DXCODE=VPOV("V POV","pov")
 . S SDESC=$P($$ICDDX^ICDEX(DXCODE),U,4)
 . S SNOMED=VPOV("V POV","povSCT")
 . ;^category|status|dateTime|provider|identifier|ICD|SCT|diag desc^...
 . S SEQ=SEQ+1
 . S DXVISIT(SEQ)=U_"VISIT"_P_STATUS_P_DXDTHL_P_PROV_P_RESID_P_DXCODE_P_SNOMED_P_SDESC
 . M DXRPTV("DxReportVisit",POVIEN)=VPOV ;
 ;serialize data
 S SERPOV=""
 S SEQ=""
 F  S SEQ=$O(DXVISIT(SEQ)) QUIT:SEQ=""  D
 . S SERPOV=SERPOV_DXVISIT(SEQ)
 ;
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("SERPOV")
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("DXRPTV")
 ;
 QUIT SERPOV
 ;
 ; ----------- Unit Test -----------
T1 ;
 N ICN S ICN="10101V964144"
 N FRDAT S FRDAT=""
 N TODAT S TODAT=""
 N JSON S JSON=""
 N RETSTA
 D PATDXRI(.RETSTA,ICN,FRDAT,TODAT,JSON)
 W $$ZW^SYNDHPUTL("RETSTA")
 QUIT
 ;
T2 ;
 N ICN S ICN="10101V964144"
 N FRDAT S FRDAT=20000101
 N TODAT S TODAT=20100101
 N JSON S JSON=""
 N RETSTA
 D PATDXRI(.RETSTA,ICN,FRDAT,TODAT,JSON)
 W $$ZW^SYNDHPUTL("RETSTA")
 QUIT
 ;
T3 ;
 N ICN S ICN="10101V964144"
 N FRDAT S FRDAT=""
 N TODAT S TODAT=""
 N JSON S JSON="J"
 N RETSTA
 D PATDXRI(.RETSTA,ICN,FRDAT,TODAT,JSON)
 W $$ZW^SYNDHPUTL("RETSTA")
 QUIT
 ;
