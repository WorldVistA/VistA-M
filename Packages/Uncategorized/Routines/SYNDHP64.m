SYNDHP64 ;DHP/AFHIL -fjf/art - HealthConcourse - Write Health Factors to VistA ; 31st July 2018
 ;;0.1;VISTA SYNTHETIC DATA LOADER;;Aug 17, 2018;Build 46
 ;;
 ;;Original routine authored by Andrew Thompson & Ferdinand Frankson of Perspecta 2017-2019
 ;
 QUIT
 ;
 ; -------- Create health factor for a patient
 ;
HLFADD(RETSTA,DHPPAT,DHPLOC,DHPHLF,DHPCAT,DHPCODE,DHPCOD,DHPSYS,DHPDAT,DHPPRV,DHPVST,DHPCOM,DHPUCUM,DHPMAG) ;
 ; Create health factor
 ;
 ;
 ; Input:
 ;   DHPPAT  - Patient ICN (required)
 ;   DHPLOC  - Location Name (required)
 ;   DHPHLF  - Health Factor Name (include SNOMED CT or LOINC code)
 ;   DHPCAT  - Health Factor Category
 ;   DHPCOD  - Code
 ;   DHPSYS  - Coding system (SNOMED CT or LOINC)
 ;   DHPDAT  - Date
 ;   DHPPRV  - Provider
 ;   DHPVST  - Visit number
 ;   DHPCOM  - Comment
 ;   DHPUCUM - UCUM code
 ;   DHPMAG  - Magnitude
 ;
 ; Output:   RETSTA
 ;  1 - success
 ; -1 - failure -1^message
 ;
 I '$D(^DPT("AFICN",DHPPAT)) S RETSTA="-1^Patient not recognised" Q
 ;
 I $G(DHPSCT)="" S RETSTA="-1^SNOMED CT code is required" Q
 I $G(DHPVST)="" S RETSTA="-1^Visit IEN is required" Q
 ;
 ;
 ;S HDATA("LEVEL/SEVERITY")
 ; HDATA("EVENT D/T"))
 ; HDATA("ORD PROVIDER"))
 ; HDATA("ENC PROVIDER"))
 ;
 ;Magnitude and UCUM code
 ; HDATA("MAGNITUDE"))
 ; HDATA("COMMENT"))
 ;
