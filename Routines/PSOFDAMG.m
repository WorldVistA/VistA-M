PSOFDAMG ;BHAM ISC/MR - FDA Medication Guide ;11/10/09 3:44pm
 ;;7.0;OUTPATIENT PHARMACY;**343**;DEC 1997;Build 17
 ;External reference EN^PSNFDAMG supported by DBIA 5517
 ;External reference ^PSDRUG supported by DBIA 221
 ;
DISPLAY ; Display the FDA Medication Guide
 ; Note: RX0 is a global variable (assumed as such by most hidden actions)
 N DRGIEN,VAPRDIEN
 S DRGIEN=+$P($G(RX0),"^",6)
 I '$D(^PSDRUG(DRGIEN,0)) W $C(7),!,"Invalid Drug" D PAUSE^VALM1 Q
 S VAPRDIEN=+$P($G(^PSDRUG(DRGIEN,"ND")),"^",3)
 I 'VAPRDIEN W $C(7),!!,$$GET1^DIQ(50,DRGIEN,.01)_" not matched to the National Drug File (NDF)" D PAUSE^VALM1 Q
 ;
 D FULL^VALM1 D EN^PSNFDAMG(VAPRDIEN)
 Q
