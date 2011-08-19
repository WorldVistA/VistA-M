MCPOS01B ;HIRMFO/WAA - Kill all cross reference in a file - ;4/29/96  11:05
 ;;2.3;Medicine;;09/13/1996
 ;;
F691 ; FILE 691
 K ^MCAR(691,"B") ; "B" Cross
 K ^MCAR(691,"C") ; Medical patient
 K ^MCAR(691,"PCC") ; PCC Pointer
 K ^MCAR(691,"ES") ; Release Code
 D
 .N MCI
 .S MCI=0
 .F  S MCI=$O(^MCAR(691,MCI)) Q:MCI<1  D
 ..K ^MCAR(691,MCI,.3,"B") ; "B" Cross
 ..K ^MCAR(691,MCI,.4,"B") ; "B" Cross
 ..K ^MCAR(691,MCI,1,"B") ; "B" Cross
 ..K ^MCAR(691,MCI,14,"B") ; "B" Cross
 ..K ^MCAR(691,MCI,"ICD","B") ; "B" Cross
 ..K ^MCAR(691,MCI,2005,"B") ; "B" Cross
 ..Q
 .Q
 D EN1^MCPOS01(691)
F691P1 ; FILE 691.1
 K ^MCAR(691.1,"B") ; "B" Cross
 K ^MCAR(691.1,"C") ; Medical Patient
 K ^MCAR(691.1,"PCC") ; PCC Pointer
 K ^MCAR(691.1,"ES") ; Release Code
 D
 .N MCI
 .S MCI=0
 .F  S MCI=$O(^MCAR(691.1,MCI)) Q:MCI<1  D
 ..K ^MCAR(691.1,MCI,.3,"B") ; "B" Cross
 ..K ^MCAR(691.1,MCI,.4,"B") ; "B" Cross
 ..K ^MCAR(691.1,MCI,6,"B") ; "B" Cross
 ..K ^MCAR(691.1,MCI,"ICD","B") ; "B" Cross
 ..K ^MCAR(691.1,MCI,2005,"B") ; "B" Cross
 .Q
 D EN1^MCPOS01(691.1)
F691P5 ; FILE 691.5
 K ^MCAR(691.5,"B") ; "B" Cross
 K ^MCAR(691.5,"C") ; Medical Patient
 K ^MCAR(691.5,"PCC") ; PCC pointer
 K ^MCAR(691.5,"ES") ; Release Status
 D
 .N MCI
 .S MCI=0
 .F  S MCI=$O(^MCAR(691.5,MCI)) Q:MCI<1  D
 ..K ^MCAR(691.5,MCI,.3,"B") ; "B" Cross
 ..K ^MCAR(691.5,MCI,.4,"B") ; "B" Cross
 ..K ^MCAR(691.5,MCI,.5,"B") ; "B" Cross
 ..K ^MCAR(691.5,MCI,3,"B") ; "B" Cross
 ..K ^MCAR(691.5,MCI,5,"B") ; "B" Cross
 ..K ^MCAR(691.5,MCI,6,"B") ; "B" Cross
 ..K ^MCAR(691.5,MCI,"ICD","B") ; "B" Cross
 ..K ^MCAR(691.5,MCI,2005,"B") ; "B" Cross
 ..Q
 .Q
 D EN1^MCPOS01(691.5)
F691P6 ; FILE 691.6
 K ^MCAR(691.6,"B") ; "B" Cross
 K ^MCAR(691.6,"C") ; Medical Patient
 K ^MCAR(691.6,"PCC") ; PCC Pointer
 K ^MCAR(691.6,"ES") ; Release Code
 D
 .N MCI
 .S MCI=0
 .F  S MCI=$O(^MCAR(691.6,MCI)) Q:MCI<1  D
 ..K ^MCAR(691.6,MCI,.3,"B") ; "B" Cross
 ..K ^MCAR(691.6,MCI,.4,"B") ; "B" Cross
 ..K ^MCAR(691.6,MCI,1,"B") ; "B" Cross
 ..K ^MCAR(691.6,MCI,"ICD","B") ; "B" Cross
 ..Q
 .Q
 D EN1^MCPOS01(691.6)
F691P7 ; FILE 691.7
 K ^MCAR(691.7,"B") ; "B" Cross
 K ^MCAR(691.7,"C") ; Medical Patient
 K ^MCAR(691.7,"PCC") ; PCC Pointer
 K ^MCAR(691.7,"ES") ; Release Code
 D
 .N MCI
 .S MCI=0
 .F  S MCI=$O(^MCAR(691.7,MCI)) Q:MCI<1  D
 ..K ^MCAR(691.7,MCI,.3,"B") ; "B" Cross
 ..K ^MCAR(691.7,MCI,.4,"B") ; "B" Cross
 ..K ^MCAR(691.7,MCI,1,"B") ; "B" Cross
 ..K ^MCAR(691.7,MCI,11,"B") ; "B" Cross
 ..K ^MCAR(691.7,MCI,"ICD","B") ; "B" Cross
 ..Q
 .Q
 D EN1^MCPOS01(691.7)
F691P8 ; FILE 691.8
 K ^MCAR(691.8,"B") ; "B" Cross
 K ^MCAR(691.8,"C") ; Medical Patient
 K ^MCAR(691.8,"PCC") ; PCC Pointer
 K ^MCAR(691.8,"ES") ; Release Code
 D
 .N MCI
 .S MCI=0
 .F  S MCI=$O(^MCAR(691.8,MCI)) Q:MCI<1  D
 ..K ^MCAR(691.8,MCI,1,"B") ; "B" Cross
 ..K ^MCAR(691.8,MCI,2,"B") ; "B" Cross
 ..K ^MCAR(691.8,MCI,3,"B") ; "B" Cross
 ..K ^MCAR(691.8,MCI,5,"B") ; "B" Cross
 ..K ^MCAR(691.8,MCI,11,"B") ; "B" Cross
 ..K ^MCAR(691.8,MCI,"ICD","B") ; "B" Cross
 ..Q
 .Q
 D EN1^MCPOS01(691.8)
F691P9 ; FILE 691.9
 K ^MCAR(691.9,"B") ; "B" Cross
 K ^MCAR(691.9,"C") ; "C" EP Record
 D
 .N MCI
 .S MCI=0
 .F  S MCI=$O(^MCAR(691.9,MCI)) Q:MCI<1  D
 ..K ^MCAR(691.9,MCI,"IDC","B") ; "B" Cross
 ..D
 ...N MCII
 ...S MCII=0
 ...F  S MCII=$O(^MCAR(691.9,MCI,7,MCII)) Q:MCII<1  D
 ....K ^MCAR(691.9,MCI,7,MCII,1,"B") ; "B" Cross
 ....Q
 ...Q
 ..Q
 .Q
 D EN1^MCPOS01(691.9)
 G F692^MCPOS01C
