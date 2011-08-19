DGPMOBS ;ALB/MM - Observation API;11/25/98
 ;;5.3;Registration;**212,831**;Aug 13 1993;Build 10
 ;
 ;This routine provides 3 entry points to obtain observation statuses.
 ;Line labels MVT, PT, and SPEC document required input variables and 
 ;output values.
 ;
MVT(IFN) ;This entry point returns the observation status based on
 ;a specified Patient Movement (#405) file entry
 ;
 ;Input:
 ;   Patient Movement (#405) file IFN (Required)
 ;
 ;Output:
 ;   If an observation treating specialty return:
 ;       1^Facility Treating Specialty (#45.7)file IFN^Facility
 ;       Treating Specialty (#45.7) file name^Specialty (#42.4)
 ;       file IFN^Specialty (#42.4) file name
 ;
 ;   If not an observation treating specialty return:
 ;       0^Facility Treating Specialty (#45.7) file IFN^Facility
 ;       Treating Specialty (#45.7) file name^Specialty (#42.4)
 ;       file IFN^Specialty (#42.4) file name
 ;
 ;   If Patient (#2) file DFN, Patient Movement (#405) IFN, or 
 ;   Specialty (#42.4) file IFN not defined or invalid return:
 ;       -1^Error condition
 ;
 N DFN,OBS,SPIFN,VAIP
 S OBS=0
 I '$D(IFN) S OBS="-1^Patient Movement (#405) file IFN undefined" Q OBS
 I '$G(^DGPM(+IFN,0)) S OBS="-1^No Patient Movement (#405) file entry" Q OBS
 S DFN=+$P($G(^DGPM(+IFN,0)),U,3)
 I 'DFN S OBS="-1^Patient (#2) file DFN not defined" Q OBS
 ;VAIP("E") contains the Patient Movement (#405) file IFN
 S VAIP("E")=+IFN
 D INP
 Q OBS
PT(DFN,MVTDT) ;This entry point returns observation status for a patient
 ;based on the treating specialty associated for a designated date/time.
 ;If not defined, defaults to status for the current date/time. 
 ;
 ;Input:
 ;   DFN from Patient (#2) file
 ;   MVTDT (optional) if not defined defaults to current date/time
 ;
 ;Output:
 ;   Same as output documented for MVT entry point
 ;
 N OBS,SPIFN,VAIP
 S OBS=0
 ;If date not defined, defaults to current date/time
 S:'$D(MVTDT) MVTDT=$$NOW^XLFDT
 ;MVTDT must contain a time
 I $P(MVTDT,".",2)']"" S OBS="-1^Time required" Q OBS
 I '$D(DFN) S OBS="-1^Patient (#2) file DFN not defined" Q OBS
 I '$D(^DPT(+DFN,0)) S OBS="-1^No Patient (#2) file entry" Q OBS
 S VAIP("D")=MVTDT
 D INP
 Q OBS
INP ;Get inpatient data based on criteria from MVT and PT entry points
 D IN5^VADPT
 ;VAIP(8) returned by IN5^VADPT call is the treating specialty from 
 ;the Facility Treating Specialty (#45.7) file in internal^external 
 ;format
 ;SPIFN is a pointer to the SPECIALTY (#42.4) file from the SPECIALTY
 ;(#1) field
 S SPIFN=$P($G(^DIC(45.7,+VAIP(8),0)),U,2)
 S OBS=$$SPEC(SPIFN)
 I +OBS'=-1 S OBS=OBS_U_VAIP(8)_U_SPIFN_U_$P($G(^DIC(42.4,+SPIFN,0)),U)
 Q
SPEC(SPIFN) ;This entry point determines if the Specialty file (#42.4) 
 ;is an observation specialty.
 ; 
 ;Observation specialties from the Specialty (#42.4) file are: 
 ;
 ;     18 - Neurology Observation
 ;     23 - Spinal Cord Injury Observation
 ;     24 - Medical Observation
 ;     36 - Blind Rehab Observation
 ;     41 - Rehab Medicine Observation
 ;     65 - Surgical Observation
 ;     94 - Psychiatric Observation
 ;     108 - ED Observation
 ;
 ;Input:
 ;   SPIFN - Specialty (#42.4) IFN
 ;
 ;Output:
 ;   1 observation treating specialty
 ;   0 not an observation specialty
 ;  -1 no treating specialty IFN defined or
 ;     IFN not found in Specialty (#42.4) file
 ;
 N SPEC,TX
 S TX=0
 I '$D(SPIFN) S TX="-1^Specialty (#42.4) IFN not defined" Q TX
 I '$D(^DIC(42.4,+SPIFN,0)) S TX="-1^No Specialty (#42.4) file entry" Q TX
 ;SPEC=observation treating specialty IFNs
 F SPEC=18,23,24,36,41,65,94,108 I SPEC=SPIFN S TX=1 Q
 Q TX
