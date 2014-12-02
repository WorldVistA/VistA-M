SCRPWICD ;HINES/LAI - Ambulatory Care Reporting - ICD Code API Wrappers;2/15/2012
 ;;5.3;Scheduling;**593**;AUG 13, 1993;Build 13
 ; Reference to $$IMP^ICDEX supported by ICR #5747
 ; Reference to $$CSI^ICDEX supported by ICR #5747
 ; Reference to $$ICDDX^ICDEX supported by ICR #5747
 ;
 Q
 ;
 ; Coding System Implementation Date
IMP(CSYS) Q $$IMP^ICDEX($G(CSYS))
 ;
 ; Diagnosis Code Info
ICDDX(IEN,CDT) Q $$ICDDX^ICDEX($G(IEN),$P($G(CDT),".",1),$$CSI(80,$G(IEN)),"I")
 ;
 ; Coding system for IEN
CSI(FILE,IEN) Q $$CSI^ICDEX($G(FILE),$G(IEN))
 ;
