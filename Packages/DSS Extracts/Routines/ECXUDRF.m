ECXUDRF ;ALB/DHH-PHARMACY RECREATE CALLS ;10/22/13  17:33
 ;;3.0;DSS EXTRACTS;**112,148**;Dec 22, 1997;Build 3
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
