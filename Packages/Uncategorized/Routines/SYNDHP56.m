SYNDHP56 ; HC/ART - HealthConcourse - retrieve patient mental health observations ;07/24/2019
 ;;1.0;DHP;;Jan 17, 2017;Build 46
 ;;
 ;;Original routine authored by Andrew Thompson & Ferdinand Frankson of Perspecta 2017-2019
 ;
 QUIT
 ;
 ; ---------------- Get patient Observations ----------------------
 ;  MH Administrations
 ;  GAF
 ;
PATOBS(RETSTA,NAME,SSN,DOB,GENDER,FRDAT,TODAT) ; get Observations for a patient by traits
 S RETSTA="-1^This service has been retired"
 QUIT
 ; Return patient Observations for name, SSN, DOB, and gender
 ;
 ; Input:
 ;   NAME    - patient name
 ;   SSN     - social security number
 ;   DOB     - date of birth
 ;   GENDER  - gender
 ;   FRDAT   - from date (inclusive), optional, compared to date given (MH) date/time of diagnosis (GAF)
 ;   TODAT   - to date (inclusive), optional, compared to date given (MH) date/time of diagnosis (GAF)
 ; Output:
 ;   RETSTA  - a delimited string that lists LOINC and SNOMED CT codes for the patient Observations
 ;           - ICN^SCT code|descrption|LOINC code|description|instrument name|date given|clinic name|ordered by|scale:score|identifier
 ;
 S FRDAT=$S($G(FRDAT):$$HL7TFM^XLFDT(FRDAT),1:1000101)
 S TODAT=$S($G(TODAT):$$HL7TFM^XLFDT(TODAT),1:9991231)
 I $G(DEBUG) W !,"FRDAT: ",FRDAT,"   TODAT: ",TODAT,!
 ;
 N C,P,S,ZARR,ICNST,DHPICN,PATIEN
 ;
 S C=",",P="|",S="_"
 D PATVAL^SYNDHP43(.ICNST,NAME,SSN,DOB,GENDER)
 I +ICNST'=1 S RETSTA=ICNST QUIT
 ; if we are here we are dealing with a valid patient
 S DHPICN=$P(ICNST,U,3)
 ; get patient IEN from ICN
 S PATIEN=$O(^DPT("AFICN",DHPICN,""))
 ;
 S RETSTA=DHPICN
 D GET(.RETSTA,PATIEN,FRDAT,TODAT)
 ;
 QUIT
 ;
PATOBSI(RETSTA,DHPICN,FRDAT,TODAT,RETJSON) ; Patient Observations for ICN
 ;
 ; Return patient Observations for a given patient ICN
 ;
 ; Input:
 ;   ICN     - unique patient identifier across all VistA systems
 ;   FRDAT   - from date (inclusive), optional, compared to date given (MH) date/time of diagnosis (GAF)
 ;   TODAT   - to date (inclusive), optional, compared to date given (MH) date/time of diagnosis (GAF)
 ;   RETJSON - J = Return JSON
 ;             F = Return FHIR
 ;             0 or null = Return string (default)
 ; Output:
 ;   RETSTA  - a delimited string that lists LOINC and SNOMED CT codes for the patient Observations
 ;           - ICN^LOINC code|description|SCT code|description|Instrument Name|date given|clinic name|ordered by|scale:score|resource ID^...
 ;
 ; validate ICN
 I $G(DHPICN)="" S RETSTA="-1^What patient?" QUIT
 I '$$UICNVAL^SYNDHPUTL(DHPICN) S RETSTA="-1^Patient identifier not recognised" Q
 ;
 S FRDAT=$S($G(FRDAT):$$HL7TFM^XLFDT(FRDAT),1:1000101)
 S TODAT=$S($G(TODAT):$$HL7TFM^XLFDT(TODAT),1:9991231)
 I $G(DEBUG) W !,"FRDAT: ",FRDAT,"   TODAT: ",TODAT,!
 I FRDAT>TODAT S RETSTA="-1^From date is greater than to date" QUIT
 ;
 N C,P,S,ZARR,PATIEN
 S C=",",P="|",S="_"
 ; get patient IEN from ICN
 S PATIEN=$O(^DPT("AFICN",DHPICN,""))
 I PATIEN="" S RETSTA="-1^Internal data structure error" QUIT
 ;
 S RETSTA=DHPICN
 D GET(.RETSTA,PATIEN,FRDAT,TODAT)
 ;
 QUIT
 ;
GET(RETSTA,PATIEN,FRDAT,TODAT) ;
 ;
 N OBSARRAY
 ;Mental Health Observations (Assessments/Administrations)
 N MHARRAY,RETVAL
 S RETVAL=$$MHOBS(.MHARRAY,PATIEN,FRDAT,TODAT)
 I $G(RETJSON)="J"!($G(RETJSON)="F") D
 . M OBSARRAY=MHARRAY
 E  D
 . S RETSTA=RETSTA_RETVAL
 ;
 ;GAF (Global Assessment of Functioning)
 N GAFARRAY,RETVAL
 S RETVAL=$$GAFOBS(.GAFARRAY,PATIEN,FRDAT,TODAT)
 I $G(RETJSON)="J"!($G(RETJSON)="F") D
 . M OBSARRAY=GAFARRAY
 E  D
 . S RETSTA=RETSTA_RETVAL
 ;
 ;I $G(RETJSON)="F" D xxx  ;create array for FHIR
 ;
 I $G(RETJSON)="J"!($G(RETJSON)="F") D
 . S RETSTA=""
 . D TOJASON^SYNDHPUTL(.OBSARRAY,.RETSTA)
 ;
 QUIT
 ;
 ;
MHOBS(MHARRAY,PATIEN,FRDAT,TODAT) ;Mental Health Observations
 ;patient's MH administration results - observation
 ;
 N PROCS,SERPROCS
 N ADMINIEN,ADMINNBR,INSTID,INSTNAME,GIVDATE,GIVDATEHL,PROVO,PROVA,LOCID,LOCATION,SCALE,SCORE,PROVNAMO,PROVNAMA
 N SNOMED,SDESC,LOINC,LDESC,MH2LOINC,LOINC2MH,MH2SNOMED,SCT
 N RESIEN,RIENS
 N YS,YSRET,YSSEQ
 ;
 N SITE S SITE=$P($$SITE^VASITE,"^",3)
 ;
 S PROCS=""
 ;D LOADREF(.MH2LOINC,.LOINC2MH,.MH2SNOMED)  ;load temporary code arrays
 ;
 N SEQ S SEQ=0
 N MHADMIEN S MHADMIEN=""
 F  S MHADMIEN=$O(^YTT(601.84,"C",PATIEN,MHADMIEN)) Q:MHADMIEN=""  D
 . N MHADM
 . D GET1MHADM^SYNDHP26(.MHADM,MHADMIEN,0) ;get one MH Administration record
 . I $D(MHADM("Mhadm","ERROR")) M MHARRAY("Observations",MHADMIEN)=MHADM QUIT
 . S ADMINNBR=MHADM("Mhadm","administrationNumber") ;administration number
 . QUIT:ADMINNBR=""
 . S GIVDATE=MHADM("Mhadm","dateGivenFM") ;date given
 . QUIT:'$$RANGECK^SYNDHPUTL(GIVDATE,FRDAT,TODAT)  ;quit if outside of requested date range
 . QUIT:MHADM("Mhadm","isCompleteCd")'="Y"  ;quit if not complete
 . S INSTNAME=MHADM("Mhadm","instrumentName") ;instrument name
 . S INSTID=MHADM("Mhadm","instrumentNameId") ;instrument id
 . S GIVDATEHL=MHADM("Mhadm","dateGivenHL7") ;hl7 format date given
 . S PROVO=MHADM("Mhadm","orderedById") ;ordered by ien
 . S PROVNAMO=MHADM("Mhadm","orderedBy") ;ordered by
 . S PROVA=MHADM("Mhadm","administeredById") ;administered by ien
 . S PROVNAMA=MHADM("Mhadm","administeredBy") ;administered by
 . S LOCID=MHADM("Mhadm","locationId") ;location ien
 . S LOCATION=MHADM("Mhadm","location") ;location
 . S LOINC=MHADM("Mhadm","loincCode")
 . S SCT=MHADM("Mhadm","snomedCode")
 . S LDESC=INSTNAME_" Result"
 . S SDESC=MHADM("Mhadm","sctPreferredTerm")
 . ;get administration results
 . S RESULT=""
 . S RESIEN=""
 . F  S RESIEN=$O(^YTT(601.92,"AC",ADMINNBR,RESIEN)) Q:RESIEN=""  D
 . . N MHRES
 . . D GET1MHRES^SYNDHP26(.MHRES,RESIEN,0) ;get one MH Results record
 . . I $D(MHRES("Mhres","ERROR")) M MHARRAY("Observations",MHADMIEN,"results")=MHRES QUIT
 . . S RIENS=RESIEN_","
 . . S SCALE=MHRES("Mhres","scale") ;scale
 . . S SCORE=MHRES("Mhres","rawScore") ;raw score
 . . S RESULT=SCALE_":"_SCORE
 . . S PID=$$RESID^SYNDHP69("V",SITE,601.84,ADMINNBR,601.92_U_RESIEN)
 . . ;
 . . I $G(DEBUG) D
 . . . W !,"Admin Number:    ",ADMINNBR,!
 . . . W "Instrument:      ",INSTID,"     ",INSTNAME,!
 . . . W "Date Given:      ",GIVDATE,"     ",GIVDATEHL,!
 . . . W "Ordered by:      ",PROVO,"     ",PROVNAMO,!
 . . . W "Administered by: ",PROVA,"     ",PROVNAMA,!
 . . . W "Location:        ",LOCID,"     ",LOCATION,!
 . . . W "Results:     ",RESULT,!
 . . . W "LOINC Code:  ",LOINC,!
 . . . W "SNOMED Code: ",SCT,!
 . . . W "Description: ",SDESC,!
 . . ;
 . . ;record is created for each result for an instrument administration
 . . ;LOINC code|description|SCT code|descrption|Instrument Name|date given|clinic name|ordered by|scale:score|resource id
 . . S SEQ=SEQ+1
 . . S PROCS(SEQ)=U_LOINC_P_LDESC_P_SCT_P_SDESC_P_INSTNAME_P_GIVDATEHL_P_LOCATION_P_PROVNAMO_P_RESULT_P_PID
 . . M MHARRAY("Observations",MHADMIEN,"Mhadm","results")=MHRES
 . M MHARRAY("Observations",MHADMIEN)=MHADM
 ;
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("PROCS")
 ;serialize data
 S SERPROCS=""
 S SEQ=""
 F  S SEQ=$O(PROCS(SEQ)) QUIT:SEQ=""  D
 . S SERPROCS=SERPROCS_PROCS(SEQ)
 ;
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("SERPROCS")
 ;
 QUIT SERPROCS
 ;
GAFOBS(GAFARRAY,PATIEN,FRDAT,TODAT) ;get GAF score
 ;
 N PROCS,SERPROCS,SEQ,MHIEN,IENS
 N FILEDTFM,FILEDT,FILEDTHL,GAFDTFM,GAFDT,GAFDTHL,GAFBYID,GAFBY,TRANSCID,TRANSCR,GAF,RESULT,PID
 N SNOMED,SDESC,LOINC,LDESC,DESC,PATTYPE
 ;
 S (SNOMED,LOINC)=""
 S (SDESC,LDESC)="GAF"
 S DESC="Global Assessment of Functioning"
 ;
 I $G(DEBUG) W !,"GAF - Global Assessment of Functioning",!!
 S PROCS=""
 S FNBR1=627.8 ;Diagnostic Results-Mental Health
 S SEQ=0
 ;
 S MHIEN=""
 F  S MHIEN=$O(^YSD(627.8,"C",PATIEN,MHIEN)) QUIT:MHIEN=""  D
 . N GAFREC
 . D GET1MHDX^SYNDHP17(.GAFREC,MHIEN,0) ;get one GAF record
 . I $D(GAFREC("Mhdiag","ERROR")) M GAFARRAY("Observations",MHIEN)=GAFREC QUIT
 . S GAF=GAFREC("Mhdiag","axis5-GAF") ;axis 5 (GAF)
 . QUIT:GAF=""
 . S GAFDTFM=GAFREC("Mhdiag","dateTimeOfDiagnosisFM") ;date/time of diagnosis fm format
 . QUIT:'$$RANGECK^SYNDHPUTL(GAFDTFM,FRDAT,TODAT)  ;quit if outside of requested date range
 . S FILEDTFM=GAFREC("Mhdiag","fileEntryDateFM") ;file entry date fm format
 . S FILEDT=GAFREC("Mhdiag","fileEntryDate") ;file entry date
 . S FILEDTHL=GAFREC("Mhdiag","fileEntryDateHL7") ;hl7 format file entry date
 . S GAFDT=GAFREC("Mhdiag","dateTimeOfDiagnosis") ;date/time of diagnosis
 . S GAFDTHL=GAFREC("Mhdiag","dateTimeOfDiagnosisHL7") ;hl7 format date/time of diagnosis
 . S GAFBYID=GAFREC("Mhdiag","diagnosisById") ;diagnosed by ien
 . S GAFBY=GAFREC("Mhdiag","diagnosisBy") ;diagnosed by
 . S TRANSCID=GAFREC("Mhdiag","transcriberId") ;transcriber ien
 . S TRANSCR=GAFREC("Mhdiag","transcriber") ;transcriber
 . S RESULT="GAF Scale:"_GAF
 . S PATTYPE=GAFREC("Mhdiag","patientTypeCd") ;patient type
 . S PID=GAFREC("Mhdiag","resourceId")
 . S GAFREC("Mhdiag","instrumentName")="Global Assessment of Functioning"
 . S GAFREC("Mhdiag","instrumentNameId")="GAF"
 . ;
 . I $G(DEBUG) D
 . . W "File Date Time: ",FILEDTFM,"     ",FILEDT,"     ",FILEDTHL,!
 . . W "GAF Date Time:  ",GAFDTFM,"     ",GAFDT,"     ",GAFDTHL,!
 . . W "Diagnosis by:   ",GAFBYID,"     ",GAFBY,!
 . . W "Transcriber:    ",TRANSCID,"     ",TRANSCR,!
 . . W "Patient Type:   ",PATTYPE,!
 . . W "Result:         ",RESULT,!
 . . W "LOINC Code:  ",LOINC,!
 . . W "SNOMED Code: ",SNOMED,!
 . . W "Description: ",SDESC,!
 . ;
 . ;LOINC code|description|SCT code|descrption|Instrument Name|date given|clinic name|ordered by|scale:score|identifier
 . S SEQ=SEQ+1
 . S PROCS(SEQ)=U_LOINC_P_LDESC_P_SNOMED_P_SDESC_P_DESC_P_GAFDTHL_P_""_P_GAFBY_P_RESULT_P_PID
 . M GAFARRAY("Observations",MHIEN)=GAFREC QUIT
 ;
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("PROCS")
 ;
 ;serialize data
 S SERPROCS=""
 S SEQ=""
 F  S SEQ=$O(PROCS(SEQ)) QUIT:SEQ=""  D
 . S SERPROCS=SERPROCS_PROCS(SEQ)
 ;
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("SERPROCS")
 ;
 QUIT SERPROCS
 ;
 ; ----------- Unit Test -----------
T1 ;
 N ICN S ICN="5000000352V586511"
 N FRDAT S FRDAT=""
 N TODAT S TODAT=""
 N RETSTA
 D PATOBSI(.RETSTA,ICN,FRDAT,TODAT)
 W $$ZW^SYNDHPUTL("RETSTA")
 QUIT
 ;
T2 ;
 N ICN S ICN="5000000352V586511"
 N FRDAT S FRDAT=20140831
 N TODAT S TODAT=20141101
 N RETSTA
 D PATOBSI(.RETSTA,ICN,FRDAT,TODAT)
 W $$ZW^SYNDHPUTL("RETSTA")
 QUIT
 ;
T3 ;
 N ICN S ICN="5000000352V586511"
 N FRDAT S FRDAT=""
 N TODAT S TODAT=""
 N JSON S JSON="J"
 N RETSTA
 D PATOBSI(.RETSTA,ICN,FRDAT,TODAT,JSON)
 W $$ZW^SYNDHPUTL("RETSTA")
 QUIT
 ;
