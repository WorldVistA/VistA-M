PSSNCPDP ;BIR/LE - Pharmacy Data Management DD Utility ;10/30/97 9:41
 ;;1.0; PHARMACY DATA MANAGEMENT; **127**;9/30/97;Build 41
 ;
 Q
EN ;
 N ZZX
 I $G(PSSNQM3) K PSSNQM3 Q  ;killing PSSNQM3 so that a secondary ? entered would get full help text message
 D HDR
 D EACH:$P($G(^PSDRUG(DA,"EPH")),"^",2)="EA"
 D GRAM:$P($G(^PSDRUG(DA,"EPH")),"^",2)="GM"
 D MILL:$P($G(^PSDRUG(DA,"EPH")),"^",2)="ML"
 W !
 Q
 ;
 ;Help  text for NCPDP QUANTITY MULTIPLIER field (#83) of DRUG file (#50).
HDR ;
 W !?5,"The value in the NCPDP QUANTITY MULTIPLIER field is multiplied by the"
 W !?5,"VISTA dispensed quantity of the drug for ePharmacy prescriptions,"
 W !?5,"resulting in the NCPDP quantity that should be electronically billed"
 W !?5,"to a Third Party Insurance Company."
 Q
 ;
EACH ;Each help text
 W !!?5,"Most products with a NCPDP DISPENSE UNIT of EA (EACH) should have the"
 W !?5,"NCPDP QUANTITY MULTIPLIER field set to 1 (one) because the VA dispensed"
 W !?5,"quantity is the same quantity that should be billed to the Third Party"
 W !?5,"Insurance Companies. HOWEVER some exceptions require a value different"
 W !?5,"than 1 (one). See examples below:"
 W !!?10,"Drug: ORTHO TRI-CYCLEN TAB,28    Quantity Dispensed: 3 CYCLES"
 W !!?5,"The Quantity Dispensed above indicates how many 28-day cycles are"
 W !?5,"being dispensed (3). However, the Third Party Insurance Companies need"
 W !?5,"to know how many TABLETS are being dispensed. Therefore, the correct"
 W !?5,"value for the NCPDP QUANTITY MULTIPLIER would be 28. The correct quantity"
 R !?5,"Enter to continue:  ",ZZX:60 W $C(13)
 W ?5,"to submit electronically is 3 x 28 = 84 tablets."
 W !!?5,"A similar case is METHYLPREDNISOLONE 4MG TAB DOSEPAK,21, which is"
 W !?5,"dispensed in packages (PKG) and not in tablets. The NCPDP QUANTITY"
 W !?5,"MULTIPLIER for this product is 21."
 Q
 ;
GRAM ;Gram help text
 W !!?5,"Most products with a NCPDP DISPENSE UNIT of GM (GRAMS) should have the"
 W !?5,"NCPDP QUANTITY MULTIPLIER set to 1 (one). HOWEVER for products dispensed"
 W !?5,"in units such as TUBE, the NCPDP QUANTITY MULTIPLIER field should contain"
 W !?5,"the number of GRAMS contained in 1 TUBE. See examples below:"
 W !!?10,"Drug:  GENTAMICIN SO4 0.3% OINT,OPH   Quantity Dispensed: 1 TUBE"
 W !!?5,"The Quantity Dispensed above indicates how many tubes are being dispensed"
 W !?5,"(1). However, the Third Party Insurance Companies need to know how many"
 W !?5,"GRAMS are being dispensed. The correct value for the NCPDP QUANTITY"
 R !?5,"Enter to continue:  ",ZZX:60 W $C(13)
 W ?5,"MULTIPLIER field for this product is 3.5, because there are 3.5 grams in"
 W !?5,"each tube. The correct quantity to submit electronically will be"
 W !?5,"3.5 x 1 = 3.5 grams."
 W !!?5,"Another example is IPRATROPIUM BR 17MCG/SPRAY AEROSOL,INHL., which is"
 W !?5,"dispensed by the number of inhalers used to fill the prescription. Each"
 W !?5,"inhaler contains 12.9 grams of IPRATROPIUM, so the NCPDP QUANTITY"
 W !?5,"MULTIPLIER for this product will be 12.9."
 Q
 ;
MILL ;Milliliter help text
 W !!?5,"Most products with a NCPDP DISPENSE UNIT of ML (Milliliters) should have"
 W !?5,"this field set to 1 (one). HOWEVER for some drugs that are dispensed in"
 W !?5,"units such as VIAL or BOTTLE, the NCPDP QUANTITY MULTIPLIER field should"
 W !?5,"contain the number of MILILLITERS contained in 1 VIAL or BOTTLE for this"
 W !?5,"drug. See examples below:"
 W !!?10,"Drug:   INSULIN,NPH,HUMAN 100UNT/ML INJ   Quantity Dispensed  3 VIALS"
 W !!?5,"The Quantity Dispensed above indicates how many vials are being dispensed"
 W !?5,"(3). However, the Third Party Insurance Companies need to know how many"
 W !?5,"milliliters are being dispensed. The correct value for the NCPDP QUANTITY"
 W !?5,"MULTIPLIER field for this product is 10, because there are 10 milliliters"
 W !?5,"in each vial. The correct quantity to submit electronically will be "
 W !?5,"3 x 10 = 30 milliliters."
 R !?5,"Enter to continue:  ",ZZX:60 W $C(13) W "                              "
 W !?5,"Another example is DARBEPOETIN ALFA,RECOMBINANT 150MCG/0.3ML SYR INJ,"
 W !?5,"SURECLICK which is dispensed by the number of syringes used for the "
 W !?5,"prescription. Each syringe contains 0.3 ML of DARBEPOETIN, so the NCPDP"
 W !?5,"QUANTITY MULTIPLIER for this product will be 0.3. Notice in this case the"
 W !?5,"NCPDP QUANTITY MULTIPLIER is less than 1."
 W !
 Q
 ;
