ECXUDRF ;ALB/DHH-PHARMACY RECREATE CALLS ; 5/28/08 3:22pm
 ;;3.0;DSS;**112**;MAY 5, 2008;Build 26
 ;
 ;This routine will recreate the IV or UD extract for DSS Inpatient
 ;Pharmacy IA (#5201)
 ;
ENIVP ; entry point to recreate IVP extract holding file (#728.113)
 S EXTRACT="IV"
 D EN^PSJDSS
 Q
 ;
ENUDP ; entry point to recreate UDP extract holding file (#728.904)
 S EXTRACT="UD"
 D EN^PSJDSS
 Q
 ;
