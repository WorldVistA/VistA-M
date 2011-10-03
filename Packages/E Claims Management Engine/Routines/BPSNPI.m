BPSNPI ;BHAM ISC/DMB - NPI Utilities ;04/19/2006
 ;;1.0;E CLAIMS MGMT ENGINE;**2,5**;JUN 2004;Build 45
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; Reference to $$NPI^XUSNPI supported by IA4532
 ;
 ; Must call at an entry point  
 Q
 ;
 ; NPIREQ - Extrinsic funtion that will return a flag indicating
 ;          if the NPI 'drop dead date' has been passed.
 ; Input
 ;    BPSDT - Date to check (internal Fileman format)
 ; Output
 ;    1 - On or after the May 23, 2008 drop dead date
 ;    0 - Prior to the May 23, 2008 drop dead date 
NPIREQ(BPSDT) ; Check NPI drop dead date
 N BPSCHKDT
 S BPSCHKDT=3080523
 Q $S(BPSDT<BPSCHKDT:0,1:1)
 ;
 ; NPI - Get NPI number
 ; Input
 ;   TYPE - Organization_ID, Individual_ID, or Pharmacy_ID
 ;   IEN  - For Organization, IEN from Institution file (#4)
 ;        - For Individual, IEN from New Person file (#200)
 ;        - For Pharmacy, IEN from Outpatient Site file (#59)
 ; Output - NPI for valid entry
 ;        -  -1^Error Code if unable to get NPI
NPI(TYPE,IEN) ;
 N NPI
 S TYPE=$G(TYPE)
 I TYPE'="Organization_ID",TYPE'="Individual_ID",TYPE'="Pharmacy_ID" Q "-1^Invalid Type"
 I '$G(IEN) Q "-1^Invalid IEN"
 I TYPE="Pharmacy_ID" D
 . K ^TMP($J,"BPS59")
 . D PSS^PSO59(IEN,"","BPS59")
 . S IEN=$P($G(^TMP($J,"BPS59",IEN,101)),U,1),TYPE="Organization_ID"
 . K ^TMP($J,"BPS59")
 I 'IEN Q "-1^Unable to determine Institution ID"
 S NPI=$$NPI^XUSNPI(TYPE,IEN)
 I $P(NPI,U,1)<1 Q "-1^No NPI"
 I $P(NPI,U,3)'="Active" Q "-1^Inactive NPI"
 Q $P(NPI,U,1)
 ;
NPKEY(BPSNCP,BPSNPI,BPSAPI) ;
 ; Determine primay key to use in MFE 4.1 for pharm registration.
 ; Input
 ;    BPSNCP  - ncpdp number for the pharmacy in file (#9002313.56,.02)
 ;    BPSNPI - existing NPI for the pharmacy in file (#9002313.56,41.01)
 ;    BPSAPI - current NPI returned from NPI^BPSNPI 
 N BPSPKY
 S BPSPKY=""
 I $G(BPSNPI) S BPSPKY=BPSNPI
 E  I $G(BPSNCP) S BPSPKY=BPSNCP
 E  S BPSPKY=$G(BPSAPI)
 Q BPSPKY
