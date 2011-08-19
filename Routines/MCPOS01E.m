MCPOS01E ;HIRMFO/WAA - Kill all cross reference in a file - ;4/29/96  14:53
 ;;2.3;Medicine;;09/13/1996
 ;;
F698 ; FILE 698
 K ^MCAR(698,"B") ; "B" Cross
 K ^MCAR(698,"C") ; Medical Patient
 K ^MCAR(698,"PCC") ; PCC Pointer
 D
 .N MCI
 .S MCI=0
 .F  S MCI=$O(^MCAR(698,MCI)) Q:MCI<1  D
 ..K ^MCAR(698,MCI,"ICD","B") ; "B" Cross
 ..Q
 .Q
 D EN1^MCPOS01(698)
F698P1 ; FILE 698.1
 K ^MCAR(698.1,"B") ; "B" Cross
 K ^MCAR(698.1,"C") ; Medical Patient
 K ^MCAR(698.1,"PCC") ; PCC Pointer
 D
 .N MCI
 .S MCI=0
 .F  S MCI=$O(^MCAR(698.1,MCI)) Q:MCI<1  D
 ..K ^MCAR(698.1,MCI,"ICD","B") ; "B" Cross
 ..Q
 .Q
 D EN1^MCPOS01(698.1)
F698P2 ; FILE 698.2
 K ^MCAR(698.2,"B") ; "B" Cross
 K ^MCAR(698.2,"C") ; Medical Patient
 K ^MCAR(698.2,"PCC") ; PCC Pointer
 D
 .N MCI
 .S MCI=0
 .F  S MCI=$O(^MCAR(698.2,MCI)) Q:MCI<1  D
 ..K ^MCAR(698.2,MCI,"ICD","B") ; "B" Cross
 ..Q
 .Q
 D EN1^MCPOS01(698.2)
F698P3 ; FILE 698.3
 K ^MCAR(698.3,"B") ; "B" Cross
 K ^MCAR(698.3,"C") ; Medical Patient
 K ^MCAR(698.3,"PCC") ; PCC Pointer
 D
 .N MCI
 .S MCI=0
 .F  S MCI=$O(^MCAR(698.3,MCI)) Q:MCI<1  D
 ..K ^MCAR(698.3,MCI,"ICD","B") ; "B" Cross
 ..Q
 .Q
 D EN1^MCPOS01(698.3)
F698P4 ; FILE 698.4
 K ^MCAR(698.4,"B") ; "B" Cross
 K ^MCAR(698.4,"C") ; Type of Equipment
 K ^MCAR(698.4,"D") ; Manufacture
 D EN1^MCPOS01(698.4)
F698P6 ; FILE 698.6
 K ^MCAR(698.6,"B") ; "B" Cross
 K ^MCAR(698.6,"C") ; Mnemonic
 D EN1^MCPOS01(698.6)
F698P9 ; FILE 698.9
 K ^MCAR(698.9,"B") ; "B" Cross
 K ^MCAR(698.9,"D") ; Abbreviation
 D EN1^MCPOS01(698.9)
 G F699^MCPOS01F
