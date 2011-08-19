PXCAPOV1 ;ISL/dee & LEA/Chylton - Validates data from the PCE Device Interface into PCE's PXK format for POV ;6/20/96
 ;;1.0;PCE PATIENT CARE ENCOUNTER;;Aug 12, 1996
 Q
 ; Variables
 ;   PXCADIAG  Copy of a Diagnosis node of the PXCA array
 ;   PXCAPRV   Pointer to the provider (200)
 ;   PXCANUMB  Count of the number if POVs
 ;   PXCAINDX  Count of the number of Diagnosis for one provider
 ;
PART1 ;
 S PXCAITEM=$P(PXCADIAG,"^",8),PXCAITM2=$L(PXCAITEM)
 I PXCAITM2<2!(PXCAITM2>80) S PXCA("ERROR","DIAGNOSIS",PXCAPRV,PXCAINDX,8)="Provider's DIAGNOSIS term must be 2-80 Characters^"_PXCAITEM
 E  D
 . S PXCAPNAR=+$$PROVNARR^PXAPI(PXCAITEM,9000010.07,$G(PXCACLEX))
 . I PXCAPNAR'>0 S PXCA("ERROR","DIAGNOSIS",PXCAPRV,PXCAINDX,8)="Could not get pointer to Provider's DIAGNOSIS term^"_$P(PXCADIAG,"^",8)
 . E  S $P(PXCADIAG,"^",8)=PXCAPNAR
 S PXCAITEM=$P(PXCADIAG,"^",9),PXCAITM2=$L(PXCAITEM)
 I PXCAITM2>0 D
 . I PXCAITM2<2!(PXCAITM2>80) S PXCA("ERROR","DIAGNOSIS",PXCAPRV,PXCAINDX,9)="Provider's DIAGNOSIS grouper must be 2-80 Characters^"_PXCAITEM
 . E  D
 .. S PXCANARC=+$$PROVNARR^PXAPI(PXCAITEM,9000010.07)
 .. I PXCANARC'>0 S PXCA("ERROR","DIAGNOSIS",PXCAPRV,PXCAINDX,9)="Could not get pointer to Provider's DIAGNOSIS grouper^"_$P(PXCADIAG,"^",9)
 .. E  S $P(PXCADIAG,"^",9)=PXCANARC
 ;
 Q
 ;
