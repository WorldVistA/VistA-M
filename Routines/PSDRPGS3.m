PSDRPGS3 ;BIR/JPW,LTL-Reprint Green Sheet (VA FORM 10-2638) cont'd ; 21 Jun 94
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
 W !?6,"CONTROLLED SUBSTANCE ADMINISTRATION RECORD",?54
 K LN S $P(LN,"_",80)="" W !,LN,!?6
 W "| DATE   TIME     NAME OF PATIENT      DOSE  BALANCE  ADMINISTERED BY    |"
 F LINE=1:1:10 W !?6,"|_______|_____|_______________________|_____|______|_____________________|",!
 Q
