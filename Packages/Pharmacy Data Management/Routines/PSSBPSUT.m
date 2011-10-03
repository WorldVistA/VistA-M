PSSBPSUT ;BIRM/MFR - BPS (ECME) Utilities ;05/14/07
 ;;1.0;PHARMACY DATA MANAGEMENT;**127**;9/30/97;Build 41
 ;
NCPDPQTY(DRUG,RXQTY) ; Return the NCPDP quantity (Billing Quantity)
 ; Input: (r) DRUG  - DRUG file (#50) IEN
 ;        (r) RXQTY - Quantity dispensed from the PRESCRIPTION file (#52)) 
 ;0utput:  NCPDPQTY - Billing Quantity (3 decimal places)^NCPDP Dispense Unit (EA, GM or ML)
 ;
 N UNIT,MULTIP
 ;
 S DRUG=+$G(DRUG),RXQTY=+$G(RXQTY)
 ;
 ; - Invalid DRUG IEN or DRUG not on file 
 I 'DRUG!'$D(^PSDRUG(DRUG,0)) Q "-1^INVALID DRUG"
 ;
 ; - Invalid NCPDP Dispense Unit
 S UNIT=$$GET1^DIQ(50,DRUG,82,"I") I UNIT'="EA",UNIT'="GM",UNIT'="ML" Q RXQTY
 ;
 ; - Invalid NCPDP Conversion Multiplier
 S MULTIP=+$$GET1^DIQ(50,DRUG,83) I MULTIP'>0 Q RXQTY_"^"_UNIT
 ;
 Q $J(RXQTY*MULTIP,0,3)_"^"_UNIT
