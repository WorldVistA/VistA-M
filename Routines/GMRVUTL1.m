GMRVUTL1 ;HIRMFO/YH-VITALS/MEASUREMENTS UTILITY ;2/4/99
 ;;4.0;Vitals/Measurements;**7,13**;Apr 25, 1997
CG ;HELP INFORMATION FOR CIRCUMFERENCE/GIRTH
 W !,"** Circumference:  a number + 'I' or 'C' (2 decimals allowed)",!,?3,"For example:  72.25I (inches)   147C (centimeters)",!,?3,"Default: INCHES"
 Q
CVP ;HELP INFORMATION FOR CVP
 W !,"** Central venous pressure:  a number for cmH2O measurement",!,?3,"or a number + 'G' for mmHg measurement (1 decimal allowed).",!,?3,"A negative number can be entered up to & including -13 cmH2O or -9.6 mmHg.",! Q
PO2 ;HELP INFORMATION FOR PULSE OXIMETRY
 W !,"** Pulse Oximetry:  Enter the numeric value of the patients Pulse Oximetry.",!,?3,"The value will be interpreted as a percentage (not greater than 100)."
 Q
PAIN ;HELP INFORMATION FOR PAIN
 W !,"** Pain:  Enter a numeric value. 0 for no pain. 1-10 for pain scale",!,?3,"10 is worst imaginable pain or enter 99 if the patient is unable to respond"
 W !,?3,"For example: 99 or 5"
 Q
