MCPOS01C ;HIRMFO/WAA - Kill all cross reference in a file - ;4/29/96  11:05
 ;;2.3;Medicine;;09/13/1996
 ;;
F692 ; FILE 692
 K ^MCAR(692,"B") ; "B" Cross
 K ^MCAR(692,"C") ; EP Record
 D
 .N MCI
 .S MCI=0
 .F  S MCI=$O(^MCAR(692,MCI)) Q:MCI<1  D
 ..D
 ...N MCII
 ...S MCII=0
 ...F  S MCII=$O(^MCAR(692,MCI,6,MCII)) Q:MCII<1  D
 ....K ^MCAR(692,MCI,6,MCII,1,"B") ; "B" Cross
 ....Q
 ...Q
 ..Q
 .Q
 D EN1^MCPOS01(692)
F693 ; FILE 693
 K ^MCAR(693,"B") ; "B" Cross
 K ^MCAR(693,"C") ; SYNONYM
 D EN1^MCPOS01(693)
F693P2 ; FILE 693.2
 K ^MCAR(693.2,"B") ; "B" Cross
 D EN1^MCPOS01(693.2)
F693P3 ; FILE 693.3
 K ^MCAR(693.3,"B") ; "B" Cross
 K ^MCAR(693.3,"C") ; Code Number
 D EN1^MCPOS01(693.3)
F693P5 ; FILE 693.5
 K ^MCAR(693.5,"B") ; "B" Cross
 D EN1^MCPOS01(693.5)
F693P6 ; FILE 693.6
 K ^MCAR(693.6,"B") ; "B" Cross
 D EN1^MCPOS01(693.6)
F694 ; FILE 694
 K ^MCAR(694,"B") ; "B" Cross
 K ^MCAR(694,"C") ; Medical patient
 K ^MCAR(694,"PCC") ; PCC Pointer
 K ^MCAR(694,"ES") ; Release Code
 D
 .N MCI
 .S MCI=0
 .F  S MCI=$O(^MCAR(694,MCI)) Q:MCI<1  D
 ..K ^MCAR(694,MCI,8,"B") ; "B" Cross
 ..K ^MCAR(694,MCI,10,"B") ; "B" Cross
 ..K ^MCAR(694,MCI,5,"B") ; "B" Cross
 ..K ^MCAR(694,MCI,2,"B") ; "B" Cross
 ..K ^MCAR(694,MCI,"ICD","B") ; "B" Cross
 ..K ^MCAR(694,MCI,2005,"B") ; "B" Cross
 ..Q
 .Q
 D EN1^MCPOS01(694)
F694P1 ; FILE 694.1
 K ^MCAR(694.1,"B") ; "B" Cross
 K ^MCAR(694.1,"C") ; Medical Type
 D EN1^MCPOS01(694.1)
F694P5 ; FILE 694.5
 K ^MCAR(694.5,"B") ; "B" Cross
 K ^MCAR(694.5,"C") ; Patient
 D
 .N MCI
 .S MCI=0
 .F  S MCI=$O(^MCAR(694.5,MCI)) Q:MCI<1  D
 ..K ^MCAR(694.5,MCI,11,"B") ; "B" Cross
 ..Q
 .Q
 D EN1^MCPOS01(694.5)
F694P9 ; FILE 694.8
 K ^MCAR(694.8,"B") ; "B" Cross
 K ^MCAR(694.8,"C") ; SYNONYM
 K ^MCAR(694.8,"PAR") ; PARENT
 K ^MCAR(684.8,"PS") ;Procedure/Subspecialty
 D
 .N MCI
 .S MCI=0
 .F  S MCI=$O(^MCAR(694.8,MCI)) Q:MCI<1  D
 ..K ^MCAR(694.8,MCI,1,"B") ; "B" Cross
 ..K ^MCAR(694.8,MCI,3,"B") ; "B" Cross
 ..Q
 .Q
 D EN1^MCPOS01(694.8)
 G F695^MCPOS01D
