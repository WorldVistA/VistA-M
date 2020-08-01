SYNDHP02 ; HC/rbd/art - HealthConcourse - get patient immunization data ;07/26/2019
 ;;1.0;DHP;;Jan 17, 2017;Build 46
 ;;
 ;;Original routine authored by Andrew Thompson & Ferdinand Frankson of Perspecta 2017-2019
 ;
 QUIT
 ;
 ; ---------------- Get patient immunizations information ------------------------------
 ;
PATIMMI(RETSTA,DHPICN,FRDAT,TODAT,RETJSON) ; Patient immunizations for ICN
 ;
 ; Return patient immunizations for a given patient ICN
 ;
 ; Input:
 ;   ICN     - unique patient identifier across all VistA systems
 ;   FRDAT   - from date (inclusive), optional, compared to Visit Date/Time
 ;   TODAT   - to date (inclusive), optional, compared to Visit Date/Time
 ;   RETJSON - J = Return JSON
 ;             F = Return FHIR
 ;             0 or null = Return string (default)
 ; Output:
 ;   RETSTA  - a delimited string that lists patient immunization information
 ;               Resource ID |Imm. Enc. Visit Dt | Imm. CVX Code | Imm. Description | Series Indicator ; Description |
 ;               Imm. Given Date  | Loc. of Enc. | Reaction Indicator ; Description | Imm. Provider
 ;          or patient immunizations in JSON format
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
 N PATIEN S PATIEN=$O(^DPT("AFICN",DHPICN,""))
 I PATIEN="" S RETSTA="-1^Internal data structure error" QUIT
 ;
 N IMMARR
 S RETSTA=$$IMMS(.IMMARR,PATIEN,DHPICN,FRDAT,TODAT)
 ;
 ;I $G(RETJSON)="F" D xxx  ;create array for FHIR
 ;
 I $G(RETJSON)="J"!($G(RETJSON)="F") D
 . S RETSTA=""
 . D TOJASON^SYNDHPUTL(.IMMARR,.RETSTA)
 ;
 Q
 ;
IMMS(IMMARR,PATIEN,DHPICN,FRDAT,TODAT) ; get immunizations for a patient
 ;
 N C,P,S,HLFCTS,VSTDT,PTIMMIEN,IMMREC
 N PTIMMID,IMMDESC,LOCENC,SERIES,IMMGIVEN,REACTID,REACTION,IMMPROV,ZARR
 N SERIESID,VIEN
 S C=",",P="|",S="_"
 N FNUM S FNUM=9000010.11      ;  file
 ; scan PXRMINDX 9000010.11 "CVX" "PI" index for Immunizations
 ; Example of such an entry - ^PXRMINDX(9000010.11,"CVX","PI",69,109,3000425.113046,64)=""
 ;S DHPICN=PATIEN
 N IMCVXCOD S IMCVXCOD=""
 F  S IMCVXCOD=$O(^PXRMINDX(FNUM,"CVX","PI",PATIEN,IMCVXCOD)) Q:IMCVXCOD=""  D
 .S VSTDT=""
 .F  S VSTDT=$O(^PXRMINDX(FNUM,"CVX","PI",PATIEN,IMCVXCOD,VSTDT)) Q:VSTDT=""  D
 ..QUIT:'$$RANGECK^SYNDHPUTL(VSTDT,FRDAT,TODAT)  ;quit if outside of requested date range
 ..S PTIMMIEN=""
 ..F  S PTIMMIEN=$O(^PXRMINDX(FNUM,"CVX","PI",PATIEN,IMCVXCOD,VSTDT,PTIMMIEN)) Q:PTIMMIEN=""  D
 ...N IMMUNIZE
 ...D GET1IMMUN^SYNDHP12(.IMMUNIZE,PTIMMIEN,0)
 ...I $D(IMMUNIZE("Immunize","ERROR")) M IMMARR("Immunizations",PTIMMIEN)=IMMUNIZE QUIT
 ...S PTIMMID=IMMUNIZE("Immunize","resourceId")
 ...S IMMDESC=IMMUNIZE("Immunize","immunization")
 ...S VIEN=IMMUNIZE("Immunize","visitId")
 ...S LOCENC=IMMUNIZE("Immunize","location")
 ...S SERIES=IMMUNIZE("Immunize","series")
 ...S SERIESID=IMMUNIZE("Immunize","seriesCd")
 ...S IMMGIVEN=IMMUNIZE("Immunize","eventDateAndTimeHL7")
 ...S REACTID=IMMUNIZE("Immunize","reactionCd")
 ...S REACTION=IMMUNIZE("Immunize","reaction")
 ...S IMMPROV=IMMUNIZE("Immunize","encounterProvider")
 ...S IMMREC=PTIMMID_P_$$FMTHL7^XLFDT(VSTDT)_P_IMCVXCOD_P_IMMDESC_P_SERIESID_";"_SERIES_P_IMMGIVEN_P_LOCENC
 ...S IMMREC=IMMREC_P_REACTID_";"_REACTION_P_IMMPROV
 ...S ZARR(DHPICN,VSTDT,IMCVXCOD)=IMMREC
 ...M IMMARR("Immunizations",PTIMMIEN)=IMMUNIZE ;
 ;
 ; serialize data
 S VSTDT=""
 S HLFCTS=DHPICN
 F  S VSTDT=$O(ZARR(DHPICN,VSTDT)) Q:VSTDT=""  D
 .S IMCVXCOD="" F  S IMCVXCOD=$O(ZARR(DHPICN,VSTDT,IMCVXCOD)) Q:IMCVXCOD=""  D
 ..S IMMREC=ZARR(DHPICN,VSTDT,IMCVXCOD)
 ..S HLFCTS=HLFCTS_U_IMMREC
 ;
 Q HLFCTS
 ; for a given pt, returns Unique ID |Imm. Enc. Visit Dt | Imm. CVX Code | Imm. Description | Series Indicator ; Description |
 ;                            Imm. Given Date  | Loc. of Enc. | Reaction Indicator ; Description | Imm. Provider
 ;
 ;  Series can be:   'P' FOR PARTIALLY COMPLETE
 ;                   'C' FOR COMPLETE
 ;                   'B' FOR BOOSTER
 ;                   '1' FOR SERIES 1
 ;                   '2' FOR SERIES 2
 ;                   '3' FOR SERIES 3
 ;                   '4' FOR SERIES 4
 ;                   '5' FOR SERIES 5
 ;                   '6' FOR SERIES 6
 ;                   '7' FOR SERIES 7
 ;                   '8' FOR SERIES 8
 ;
 ;  Reactions can be:  '1' FOR FEVER
 ;                     '2' FOR IRRITABILITY;
 ;                     '3' FOR LOCAL REACTION OR SWELLING;
 ;                     '4' FOR VOMITING;
 ;                     '5' FOR RASH OR ITCHING;
 ;                     '6' FOR LETHARGY;
 ;                     '7' FOR CONVULSIONS;
 ;                     '8' FOR ARTHRITIS OR ARTHRALGIAS;
 ;                     '9' FOR ANAPHYLAXIS OR COLLAPSE;
 ;                     '10' FOR RESPIRATORY DISTRESS;
 ;                     '11' FOR OTHER;
 ;                     '0' FOR NONE;
 ;
 ; ----------- Unit Test -----------
T1 ;
 N ICN S ICN="10110V004877"
 N FRDAT S FRDAT=""
 N TODAT S TODAT=""
 N JSON S JSON=""
 N RETSTA
 D PATIMMI(.RETSTA,ICN,FRDAT,TODAT,JSON)
 W $$ZW^SYNDHPUTL("RETSTA")
 QUIT
 ;
T2 ;
 N ICN S ICN="10110V004877"
 N FRDAT S FRDAT=20130801
 N TODAT S TODAT=20140431
 N JSON S JSON=""
 N RETSTA
 D PATIMMI(.RETSTA,ICN,FRDAT,TODAT,JSON)
 W $$ZW^SYNDHPUTL("RETSTA")
 QUIT
 ;
T3 ;
 N ICN S ICN="10110V004877"
 N FRDAT S FRDAT=""
 N TODAT S TODAT=""
 N JSON S JSON="J"
 N RETSTA
 D PATIMMI(.RETSTA,ICN,FRDAT,TODAT,JSON)
 W $$ZW^SYNDHPUTL("RETSTA")
 QUIT
 ;
