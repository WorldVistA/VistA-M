SYNDHP08 ; HC/rbd/art - HealthConcourse - get patient flag data ;06/24/2019
 ;;1.0;DHP;;Jan 17, 2017;Build 46
 ;;
 ;;Original routine authored by Andrew Thompson & Ferdinand Frankson of Perspecta 2017-2019
 ;
 QUIT
 ;
 ; ---------------- Get patient flag information ------------------------------
 ;
PATFLGI(RETSTA,DHPICN,FRDAT,TODAT,RETJSON) ; Patient flags for ICN
 ;
 ; Return patient flags for a given patient ICN
 ;
 ; Input:
 ;   ICN     - unique patient identifier across all VistA systems
 ;   FRDAT   - from date (inclusive), optional, not used, no logical date to compare
 ;   TODAT   - to date (inclusive), optional, not used, no logical date to compare
 ;   RETJSON - J = Return JSON
 ;             F = Return FHIR
 ;             0 or null = Return patient flags string (default)
 ; Output:
 ;   RETSTA  - a delimited string that lists patient flag information
 ;             ICN^flag name|SNOMED CT code|flag record IEN|national or local|status|owner site|originating site|review date|resource id^...
 ;          or patient flags in JSON format
 ;
 S FRDAT=$S($G(FRDAT):$$HL7TFM^XLFDT(FRDAT),1:1000101)
 S TODAT=$S($G(TODAT):$$HL7TFM^XLFDT(TODAT),1:9991231)
 I $G(DEBUG) W !,"DHPICN: ",DHPICN,"   FRDAT: ",FRDAT,"   TODAT: ",TODAT,"   RETJSON: ",RETJSON,!
 I FRDAT>TODAT S RETSTA="-1^From date is greater than to date" QUIT
 ;patient flag data does not contain a date to compare to TODAT or FRDAT
 ;
 ; validate ICN
 I $G(DHPICN)="" S RETSTA="-1^What Patient?" QUIT
 I '$$UICNVAL^SYNDHPUTL(DHPICN) S RETSTA="-1^Patient identifier not recognised" QUIT
 ;
 N PATIEN S PATIEN=$O(^DPT("AFICN",DHPICN,""))
 I PATIEN="" S RETSTA="-1^Internal data structure error" QUIT
 ;
 N FLAGARR
 S RETSTA=$$FLAGS(.FLAGARR,PATIEN,DHPICN,FRDAT,TODAT)
 ;
 ;I $G(RETJSON)="F" D xxx  ;create array for FHIR
 ;
 I $G(RETJSON)="J"!($G(RETJSON)="F") D
 . S RETSTA=""
 . D TOJASON^SYNDHPUTL(.FLAGARR,.RETSTA)
 ;
 QUIT
 ;
FLAGS(FLAGARR,PATIEN,DHPICN,FRDAT,TODAT) ; get flags for a patient
 ;
 N FLAGREC,ZARR
 N PTFLGID,FLAGDESC,NATLOC,STATUS,OWNSITE,ORIGSITE,RVWDT,RVWDTDSP,FLAGSCT
 N C,P,S S C=",",P="|",S="_"
 ;
 N FNUM S FNUM=26.13      ;  file
 ; scan PATIENT "B" index for Flags
 ;S DHPICN=PATIEN
 N FLAGIEN S FLAGIEN=0
 F  S FLAGIEN=$O(^DGPF(26.13,"B",PATIEN,FLAGIEN)) QUIT:FLAGIEN=""  D
 . N FLAG
 . D GET1FLAG^SYNDHP17(.FLAG,FLAGIEN,0)
 . I $D(FLAG("Flag","ERROR")) M FLAGARR("Flags",FLAGIEN)=FLAG QUIT
 . I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("FLAG")
 . S PTFLGID=FLAG("Flag","resourceId")
 . S FLAGDESC=FLAG("Flag","flagName") ;flag name
 . S NATLOC=$S(FLAG("Flag","flagNameId")["26.15":"National",1:"Local")
 . S STATUS=FLAG("Flag","status") ;status
 . S OWNSITE=FLAG("Flag","ownerSite") ;owner site
 . S ORIGSITE=FLAG("Flag","originatingSite") ;originating site
 . S RVWDT=FLAG("Flag","reviewDateFM") ;review date
 . S RVWDTDSP=FLAG("Flag","reviewDateHL7")
 . S FLAGSCT=FLAG("Flag","flagSCT")
 . ;S ASSNARR=FLAG("Flag","assignmentNarrative")
 . S ZARR(DHPICN,FLAGDESC)=FLAGSCT_P_FLAGIEN_P_NATLOC_P_STATUS_P_OWNSITE_P_ORIGSITE_P_RVWDTDSP_P_PTFLGID
 . M FLAGARR("Flags",FLAGIEN)=FLAG ;
 ;
 ; serialize data
 N FLAGDESC S FLAGDESC=""
 N FLAGS S FLAGS=DHPICN
 F  S FLAGDESC=$O(ZARR(DHPICN,FLAGDESC)) QUIT:FLAGDESC=""  D
 . S FLAGREC=ZARR(DHPICN,FLAGDESC)
 . S FLAGS=FLAGS_U_FLAGDESC_P_FLAGREC
 ;
 QUIT FLAGS
 ;
 ; ----------- Unit Test -----------
T1 ;
 N ICN S ICN="10189V514254"
 N FRDAT S FRDAT=""
 N TODAT S TODAT=""
 N JSON S JSON=""
 N RETSTA
 D PATFLGI(.RETSTA,ICN,FRDAT,TODAT,JSON)
 W $$ZW^SYNDHPUTL("RETSTA")
 QUIT
 ;
T2 ;
 N ICN S ICN="10189V514254"
 N FRDAT S FRDAT=""
 N TODAT S TODAT=""
 N JSON S JSON="J"
 N RETSTA
 D PATFLGI(.RETSTA,ICN,FRDAT,TODAT,JSON)
 W $$ZW^SYNDHPUTL("RETSTA")
 QUIT
 ;
