SYNDHP83 ; AFHIL/fjf - HealthConcourse - retrieve mapped code ;03/21/2019
 ;;1.0;DHP;;Jan 17, 2017;Build 46
 ;
 ;
 Q
 ;
 ; ----------------  Get Mapped Code  ----------------------
 ;
MAPSVC(RETSTA,DHPMAP,DHPCODE,DHPDIR,DHPIOE) ; get mapped code
 ;
 ; Return mapped code for given mapping and source code
 ;
 ; Input:
 ;   DHPMAP   - map identifier e.g. sct2icd, or rxn2ndf
 ;   DHPCODE  - source code to be mapped
 ;   DHPDIR  - direction of mapping
 ;             D for direct (default)
 ;             I for inverse
 ;   DHPIOE  - use internal or exernal mappings
 ;             I for internal SYN VistA (default)
 ;             H for external HealthConcourse
 ; Output:
 ;   RETSTA   - a delimited string that has the following
 ;              n^target_code
 ;
 ;             -where n is a flag indicating success/failure of request
 ;                 1 - success
 ;                -1 - exception
 ;                target_code is the code that is the result of the mapping
 ;
 N C
 S C=","
 S RETSTA=$$MAP^SYNDHPMP(DHPMAP,DHPCODE,DHPDIR,DHPIOE)
 Q
