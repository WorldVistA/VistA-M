VPRSDAD ;OIT/CF -- SDA DPT utilities ;10/25/18  15:29
 ;;1.0;VIRTUAL PATIENT RECORD;**14**;Sep 01, 2011;Build 38
 ;;Per VHA Directive 6402, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; DIQ                           2056
 ;
SID ; -- State GET ID Action
 ; ForeignCountryFlag set & cleaned up patient address entities 
 Q:+$G(VPR("ForeignCountryFlag"))=0
 S DIENTY=+$O(^DDE("B","VPR CODE ONLY",0)) I DIENTY<1 S DDEOUT=1 Q
 S DNAME="State"
 Q
 ;
FCF ; set ForeignCountryFlag
 S VPR("ForeignCountryFlag")=1
 Q
 ;
NUSC(VPRX) ; boolean true if non-United States country
 Q VPRX'=""&(VPRX'="UNITED STATES")&(VPRX'="USA")
 ;
ADD(DFN) ; -- flag if foreign address fields for VPR PATIENT ADDRESS
 ; called from GET ID action
 S VAPA("HasCountry")=$$NUSC($$GET1^DIQ(2,DFN_",",.1173))
 D:VAPA("HasCountry")=1 
 .;S VATEMP("Province")=$$GET1^DIQ(2,DFN_",",.1171)
 .;S VATEMP("PostalCode")=$$GET1^DIQ(2,DFN_",",.1172)
 .D FCF
 Q
 ;
TEMP(DFN) ; -- populate foreign address fields for VPR PATIENT TEMP ADDRESS
 ; called from GET ID action
 S VATEMP("HasCountry")=$$NUSC($$GET1^DIQ(2,DFN_",",.1223))
 D:VATEMP("HasCountry")=1 
 .S VATEMP("Province")=$$GET1^DIQ(2,DFN_",",.1221)
 .S VATEMP("PostalCode")=$$GET1^DIQ(2,DFN_",",.1222)
 .D FCF
 Q
 ;
NOK(DFN) ; -- populate foreign address fields for VPR PATIENT NOK ADDRESS
 ; called from GET ID action
 S VAOA("HasCountry")=$$NUSC($$GET1^DIQ(2,DFN_",",.221))
 D:VAOA("HasCountry")=1 
 .S VAOA("Province")=$$GET1^DIQ(2,DFN_",",.222)
 .S VAOA("PostalCode")=$$GET1^DIQ(2,DFN_",",.223)
 .D FCF
 Q
 ;
NOK2(DFN) ; -- populate foreign address fields for VPR PATIENT NOK2 ADDRESS
 ; called from GET ID action
 S VAOA("HasCountry")=$$NUSC($$GET1^DIQ(2,DFN_",",.2101))
 D:VAOA("HasCountry")=1 
 .S VAOA("Province")=$$GET1^DIQ(2,DFN_",",.2102)
 .S VAOA("PostalCode")=$$GET1^DIQ(2,DFN_",",.2103)
 .D FCF
 Q
 ;
ECON(DFN) ; -- populate foreign address fields for VPR PATIENT ECON ADDRESS
 ; called from GET ID action
 S VAOA("HasCountry")=$$NUSC($$GET1^DIQ(2,DFN_",",.3306))
 D:VAOA("HasCountry")=1 
 .S VAOA("Province")=$$GET1^DIQ(2,DFN_",",.3307)
 .S VAOA("PostalCode")=$$GET1^DIQ(2,DFN_",",.3308)
 .D FCF
 Q
 ;
ECON2(DFN) ; -- populate foreign address fields for VPR PATIENT ECON2 ADDRESS
 ; called from GET ID action
 S VAOA("HasCountry")=$$NUSC($$GET1^DIQ(2,DFN_",",.331012))
 D:VAOA("HasCountry")=1 
 .S VAOA("Province")=$$GET1^DIQ(2,DFN_",",.331013)
 .S VAOA("PostalCode")=$$GET1^DIQ(2,DFN_",",.331014)
 .D FCF
 Q
