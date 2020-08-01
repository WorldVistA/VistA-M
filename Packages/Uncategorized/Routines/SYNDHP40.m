SYNDHP40 ; HC/fjf/art - HealthConcourse - retrieve patient encounters ;07/23/2019
 ;;1.0;DHP;;Jan 17, 2017;Build 46
 ;;
 ;;Original routine authored by Andrew Thompson & Ferdinand Frankson of Perspecta 2017-2019
 ;
 QUIT
 ;
 ; ---------------- Get patient encounters ----------------------------
 ;
PATENCI(RETSTA,DHPICN,FRDAT,TODAT,RETJSON) ; Patient primary encounters for ICN
 ;
 ; Return primary encounters/visits for a given patient ICN
 ;
 ; Input:
 ;   ICN     - unique patient identifier across all VistA systems
 ;   FRDAT   - from date (inclusive), optional, compared to .01 VISIT/ADMIT DATE&TIME
 ;   TODAT   - to date (inclusive), optional, compared to .01 VISIT/ADMIT DATE&TIME
 ;   RETJSON - J = Return JSON
 ;             F = Return FHIR
 ;             0 or null = Return string (default)
 ; Output:
 ;   RETSTA  - a delimited string that lists the following information
 ;      PatientICN ^ RESOURSE ID ^ TYPE ^ ENCOUNTER DATE ^ REASON ^ ICD DIAGNOSIS CODE ; ICD DIAGNOSIS NAME
 ;      ^ SERVICE CATEGORY ^ SOURCE ^
 ;      ^ LOCATION OF ENCOUNTER , LOCATION ADDRESS SEPARATED BY SEMICOLONS ^ HOSPITAL LOCATION
 ;      ^ PROVIDER(S) SEPARATED BY SEMICOLONS
 ;
 ;   Identifier will be "V_"_SITE ID_"_"_FILE #_"_"_FILE IEN   i.e. V_500_9000010_930
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
 N C S C=","
 N P S P="|"
 N S S S=";"
 ;
 ; get patient IEN from ICN
 N PATIEN S PATIEN=$O(^DPT("AFICN",DHPICN,""))
 I PATIEN="" S RETSTA="-1^Internal data structure error" QUIT
 ;
 N RETDESC S RETDESC=""
 N VISITS
 N VIEN S VIEN=""
 F  S VIEN=$O(^AUPNVSIT("C",PATIEN,VIEN)) QUIT:VIEN=""  D
 . N ACU,IDENT,ENCDT,ENCDTI,TYPE,SERV,SOURCE,LOC,HLOC,LOCI,LOCD,LOCA,CONIEN,PDO
 . N DIAGC,DIAGN,ENFLG,DATEN,DISD,REASON,PROV,PERIOD,PERIODFM,SITE,PROBLEM,PROVIDERS
 . N VISIT
 . D GET1VISIT^SYNDHP13(.VISIT,VIEN,0) ;get one Visit record . QUIT:$D(VISITE)
 . I $D(VISIT("Visit","ERROR")) M VISITS("Encounters",VIEN)=VISIT QUIT
 . I VISIT("Visit","encounterTypeCd")'="P" QUIT
 . S PERIODFM=VISIT("Visit","visitAdmitDateTimeFM")   ; encounter date/time
 . QUIT:'$$RANGECK^SYNDHPUTL(PERIODFM,FRDAT,TODAT)  ;quit if outside of requested date range
 . S IDENT=VISIT("Visit","resourceId")
 . S PERIOD=VISIT("Visit","visitAdmitDateTimeHL7")   ; date/time, HL7 format
 . S ENCDTI=VISIT("Visit","visitAdmitDateTimeFM")\1
 . ;get first diagnosis for patient
 . S ENFLG=0,CONIEN=""
 . F  S CONIEN=$O(^AUPNPROB("AC",PATIEN,CONIEN)) QUIT:CONIEN=""  D  QUIT:ENFLG=1
 . . D GET1PROB^SYNDHP11(.PROBLEM,CONIEN,0)
 . . I $D(VPROV("Problem","ERROR")) M VISITS("Encounters",VIEN,"providers")=VPROV QUIT
 . . S DATEN=PROBLEM("Problem","dateEnteredFM") QUIT:(DATEN\1)'=$G(ENCDTI)  ;date/time must equal date entered
 . . S REASON=PROBLEM("Problem","problem") ; reason
 . . S DIAGC=PROBLEM("Problem","diagnosisId") ; condition
 . . S DIAGN=$G(^ICD9(DIAGC,68,1,1)) ; diagnosis
 . . S ENFLG=1    ;set flag to know we have data and can move on
 . S TYPE=VISIT("Visit","patientStatusInOut")  ; encounter type
 . S DISD=VISIT("Visit","encounterType") ; discharge disposition
 . S LOC=VISIT("Visit","locOfEncounter")
 . S LOCI=VISIT("Visit","locOfEncounterId") ; location
 . I $G(LOCI)'="" D
 . . D GET1SITE^SYNDHP10(.SITE,LOCI,0) ;get one Institution record
 . . I $D(SITE("Site","ERROR")) M VISITS("Encounters",VIEN,"Site")=SITE QUIT
 . . S LOCD=$G(^DIC(4,LOCI,1))
 . . S LOCA=SITE("Site","streetAddr1")_S_SITE("Site","streetAddr2")_S_SITE("Site","city")_S_SITE("Site","zip") ; location address
 . S SERV=VISIT("Visit","serviceCategory") ; service category
 . S HLOC=VISIT("Visit","hospitalLocation") ; hospital location
 . S SOURCE=VISIT("Visit","dataSource")  ; Source
 . S PDO=""
 . S PROV=""
 . F  S PDO=$O(^AUPNVPRV("AD",VIEN,PDO)) Q:PDO=""  D
 . . N VPROV
 . . D GET1VPROV^SYNDHP23(.VPROV,PDO,0)
 . . I $D(VPROV("Vprov","ERROR")) M VISITS("Encounters",VIEN,"providers")=VPROV QUIT
 . . S PROV=VPROV("Vprov","provider")_S
 . . M PROVIDERS(PDO)=VPROV
 . S RETDESC=RETDESC_$G(IDENT)_U_$G(TYPE)_U_$G(PERIOD)_U_$G(REASON)_U_$G(DIAGC)_S_$G(DIAGN)_U_$G(SERV)_U_$G(SOURCE)_U_$G(LOC)_C_$G(LOCA)_U_$G(HLOC)_U_PROV_P
 . M VISITS("Encounters",VIEN)=VISIT
 . I $D(PROBLEM) M VISITS("Encounters",VIEN,"Visit","diagnosis")=PROBLEM
 . I $D(PROVIDERS) M VISITS("Encounters",VIEN,"Visit","providers")=PROVIDERS
 . I $D(SITE) M VISITS("Encounters",VIEN,"Visit","location")=SITE
 S RETSTA=DHPICN_U_RETDESC
 ;
 ;I $G(RETJSON)="F" D xxx  ;create array for FHIR
 ;
 I $G(RETJSON)="J"!($G(RETJSON)="F") D
 . S RETSTA=""
 . D TOJASON^SYNDHPUTL(.VISITS,.RETSTA)
 ;
 QUIT
 ;
 ; ----------- Unit Test -----------
T1 ;
 N ICN S ICN="5000000109V646500"
 N FRDAT S FRDAT=""
 N TODAT S TODAT=""
 N RETSTA
 D PATENCI(.RETSTA,ICN,FRDAT,TODAT)
 W $$ZW^SYNDHPUTL("RETSTA")
 QUIT
 ;
T2 ;
 N ICN S ICN="5000000109V646500"
 N FRDAT S FRDAT=20151001
 N TODAT S TODAT=20151031
 N RETSTA
 D PATENCI(.RETSTA,ICN,FRDAT,TODAT)
 W $$ZW^SYNDHPUTL("RETSTA")
 QUIT
 ;
T3 ;
 N ICN S ICN="5000000109V646500"
 N FRDAT S FRDAT=""
 N TODAT S TODAT=""
 N JSON S JSON="J"
 N RETSTA
 D PATENCI(.RETSTA,ICN,FRDAT,TODAT,JSON)
 W $$ZW^SYNDHPUTL("RETSTA")
 QUIT
 ;
