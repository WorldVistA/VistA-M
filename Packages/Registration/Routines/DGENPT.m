DGENPT ;ALB/CJM - Patient Protocols; 13 JUN 1997
 ;;5.3;Registration;**121,147**;08/13/93
 ;
PF ;Entry point for DGENPT PREFERRED FACILITY protocol
 ; Input  -- DFN      Patient IEN
 ; Output -- VALMBCK  R   =Refresh screen
 S VALMBCK=""
 D FULL^VALM1
 D PREFER(DFN)
 D HDR^DGENL
 D MESSAGE^DGENL(DFN)
 S VALMBCK="R"
 Q
 ;
PREFER(DFN) ;
 ;Description: Enter/Edit patient's preferred facility.
 ;Input: DFN - patient ien
 ;Output: none
 ;
 Q:'$G(DFN)
 Q:'$D(^DPT(DFN,0))
 ;
 N PREFAC,RESPONSE
 S PREFAC=$$PREF^DGENPTA(DFN)
 S:'PREFAC PREFAC=$P($$SITE^VASITE(),"^")
 W !
 I $$PROMPT^DGENU(2,27.02,PREFAC,.RESPONSE),$$STOREPRE^DGENPTA1(DFN,RESPONSE)
 Q
