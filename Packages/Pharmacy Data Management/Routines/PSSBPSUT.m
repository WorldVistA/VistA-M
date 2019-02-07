PSSBPSUT ;BIRM/MFR - BPS (ECME) Utilities ;05/14/07
 ;;1.0;PHARMACY DATA MANAGEMENT;**127,214**;9/30/97;Build 43
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
 ;
EPHARM(PSSDRUG) ; ePharmacy Billable fields check
 ; Check if the ePharmacy Billable fields are all nil.  If so, give the user the 
 ; opportunity to input a value into the fields.
 ;
 ; Input: (r) PSSDRUG - DRUG file (#50) IEN
 ;
 N ARRAY,DA,DATA,DIE,DIR,DR,I,PSSDRUG1,TODAY,Y
 ;
 ; Pull existing values from ^PSDRUG, for ePharmacy Billable fields, and put into ARRAY.
 S PSSDRUG1=PSSDRUG_","
 D GETS^DIQ(50,PSSDRUG1,"84;85;86;100","I","ARRAY")
 ;
 ; If INACTIVE DATE is not greater than today, QUIT. Do not check ePharmacy Billable Fields.
 S TODAY=$$DT^XLFDT
 I (ARRAY(50,PSSDRUG1,100,"I")'="")&(ARRAY(50,PSSDRUG1,100,"I")'>TODAY) Q
 ;
 ; Check the 3 fields in ARRAY.  If any field has a value defined, QUIT.
 S DATA=""
 F I=84,85,86 I $G(ARRAY(50,PSSDRUG1,I,"I"))'="" S DATA=1
 I DATA=1 Q
 ;
 ; All 3 fields were nil.  Prompt user if they would like to enter values.
 S DIR("A",1)=" "
 S DIR("A",2)="  None of the ePharmacy Billable fields are marked.  ePharmacy claims"
 S DIR("A",3)="  will not be billed if not marked.  Do you wish to mark any of the"
 S DIR("A")="  fields (Y/N)"
 S DIR(0)="Y"
 D ^DIR
 ;
 I Y'=1 Q    ; If user did not respond YES to entering ePharmacy Billable fields, QUIT.
 ;
 W !
 ; Display the 3 ePharmacy Billable fields to the user.
 S DIE="^PSDRUG("
 S DA=PSSDRUG
 S DR="84ePharmacy Billable;85  ePharmacy Billable (TRICARE);86  ePharmacy Billable (CHAMPVA)"
 D ^DIE
 ;
 Q
