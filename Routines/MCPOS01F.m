MCPOS01F ;HIRMFO/WAA - Kill all cross reference in a file - ;4/29/96  14:53
 ;;2.3;Medicine;;09/13/1996
 ;;
F699 ; FILE 699
 K ^MCAR(699,"B") ; "B" Cross
 K ^MCAR(699,"C") ; Medical patient
 K ^MCAR(699,"D") ; Procedure
 K ^MCAR(699,"AC") ; Endoscopist
 K ^MCAR(699,"ACE") ; Endoscopist
 K ^MCAR(699,"AD") ; Where performed
 K ^MCAR(699,"PCC") ; PCC Pointer
 K ^MCAR(699,"ES") ; Release code
 D
 .N MCI
 .S MCI=0
 .F  S MCI=$O(^MCAR(699,MCI)) Q:MCI<1  D
 ..K ^MCAR(699,MCI,1,"B") ; "B" Cross
 ..K ^MCAR(699,MCI,3,"B") ; "B" Cross
 ..K ^MCAR(699,MCI,28,"B") ; "B" Cross
 ..K ^MCAR(699,MCI,25,"B") ; "B" Cross
 ..K ^MCAR(699,MCI,27,"B") ; "B" Cross
 ..K ^MCAR(699,MCI,30,"B") ; "B" Cross
 ..D
 ...N MCII
 ...S MCII=0
 ...F  S MCII=$O(^MCAR(699,MCI,30,MCII)) Q:MCII<1  D
 ....K ^MCAR(699,MCI,30,MCII,1,"B") ; "B" Cross
 ....K ^MCAR(699,MCI,30,MCII,2,"B") ; "B" Cross
 ....K ^MCAR(699,MCI,30,MCII,3,"B") ; "B" Cross
 ....Q
 ...Q 
 ..K ^MCAR(699,MCI,10,"B") ; "B" Cross
 ..K ^MCAR(699,MCI,11,"B") ; "B" Cross
 ..K ^MCAR(699,MCI,"IDC","B") ; "B" Cross
 ..K ^MCAR(699,MCI,2005,"B") ; "B" Cross
 ..Q
 .Q
 D EN1^MCPOS01(699)
F699P48 ; FILE 699.48
 K ^MCAR(699.48,"B") ; "B" Cross
 K ^MCAR(699.48,"C") ; Medical package use
 D EN1^MCPOS01(699.48)
F699P5 ; FILE 699.5
 K ^MCAR(699.5,"B") ; "B" Cross
 K ^MCAR(699.5,"C") ; Medical Patient
 K ^MCAR(699.5,"D") ; Subspecialty
 K ^MCAR(699.5,"PCC") ; PCC Pointer
 D
 .N MCI
 .S MCI=0
 .F  S MCI=$O(^MCAR(699.5,MCI)) Q:MCI<1  D
 ..K ^MCAR(699.5,MCI,4,"B") ; "B" Cross
 ..K ^MCAR(699.5,MCI,2,"B") ; "B" Cross
 ..K ^MCAR(699.5,MCI,3,"B") ; "B" Cross
 ..K ^MCAR(699.5,MCI,"ICD","B") ; "B" Cross
 ..K ^MCAR(699.5,MCI,2005,"B") ; "B" Cross
 ..Q
 .Q
 D EN1^MCPOS01(699.5)
F699P55 ; FILE 699.55
 K ^MCAR(699.55,"B") ; "B" Cross
 K ^MCAR(699.55,"C") ; Procedure
 D
 .N MCI
 .S MCI=0
 .F  S MCI=$O(^MCAR(699.55,MCI)) Q:MCI<1  D
 ..K ^MCAR(699.55,MCI,1,"B") ; "B" Cross
 ..Q
 .Q
 D EN1^MCPOS01(699.55)
F699P57 ; FILE 699.57
 K ^MCAR(699.57,"B") ; "B" Cross
 K ^MCAR(699.57,"C") ; Procedure
 D
 .N MCI
 .S MCI=0
 .F  S MCI=$O(^MCAR(699.57,MCI)) Q:MCI<1  D
 ..K ^MCAR(699.57,MCI,1,"B") ; "B" Cross
 ..Q
 .Q
 D EN1^MCPOS01(699.57)
F699P6 ; FILE 699.6
 K ^MCAR(699.6,"B") ; "B" Cross
 K ^MCAR(699.6,"BA") ; KWIC
 K ^MCAR(699.6,"C") ; Procedure
 K ^MCAR(699.6,"E") ; Procedure Name
 K ^MCAR(699.6,"D") ; Cath surgical risk procedure
 D
 .N MCI
 .S MCI=0
 .F  S MCI=$O(^MCAR(699.6,MCI)) Q:MCI<1  D
 ..K ^MCAR(699.6,MCI,1,"B") ; "B" Cross
 ..K ^MCAR(699.6,MCI,2,"B") ; "B" Cross
 ..Q
 .Q
 D EN1^MCPOS01(699.6)
F699P7 ; FILE 699.7
 K ^MCAR(699.7,"B") ; "B" Cross
 K ^MCAR(699.7,"C") ; Type
 D EN1^MCPOS01(699.7)
F699P81 ; FILE 699.81
 K ^MCAR(699.81,"B") ; "B" Cross
 K ^MCAR(699.81,"D") ; KWIC
 K ^MCAR(699.81,"C") ; Medical Package Use
 D EN1^MCPOS01(699.81)
F699P82 ; FILE 699.82
 K ^MCAR(699.82,"B") ; "B" Cross
 K ^MCAR(699.82,"C") ; KWIC
 D EN1^MCPOS01(699.82)
F699P83 ; FILE 699.83
 K ^MCAR(699.83,"B") ; "B" Cross
 K ^MCAR(699.83,"C") ; Medical Use
 D EN1^MCPOS01(699.83)
F699P84 ; FILE 699.84
 K ^MCAR(699.84,"B") ; "B" Cross
 K ^MCAR(699.84,"C") ; KWIC
 D EN1^MCPOS01(699.84)
F699P85 ; FILE 699.85
 K ^MCAR(699.85,"B") ; "B" Cross
 K ^MCAR(699.85,"C") ; KWIC
 K ^MCAR(699.85,"D") ; Medical Package Use
 D EN1^MCPOS01(699.85)
F699P86 ; FILE 699.86
 K ^MCAR(699.86,"B") ; "B" Cross
 K ^MCAR(699.86,"C") ; KWIC
 D EN1^MCPOS01(699.86)
F699P88 ; FILE 699.88
 K ^MCAR(699.88,"B") ; "B" Cross
 K ^MCAR(699.88,"C") ; KWIC
 D EN1^MCPOS01(699.88)
 G F700^MCPOS01G
