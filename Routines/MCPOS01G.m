MCPOS01G ;HIRMFO/WAA - Kill all cross reference in a file - ;4/29/96  14:54
 ;;2.3;Medicine;;09/13/1996
 ;;
F700 ; FILE 700
 K ^MCAR(700,"B") ; "B" Cross
 K ^MCAR(700,"AV") ; Volume Study
 K ^MCAR(700,"AF") ; Flow Study
 K ^MCAR(700,"ADI") ; DLCO-SB
 K ^MCAR(700,"AS") ; Special Study
 K ^MCAR(700,"C") ; Medical Patient
 K ^MCAR(700,"PCC") ; PCC Pointer
 D
 .N MCI
 .S MCI=0
 .F  S MCI=$O(^MCAR(700,MCI)) Q:MCI<1  D
 ..K ^MCAR(700,MCI,1,"B") ; "B" Cross
 ..K ^MCAR(700,MCI,3,"B") ; "B" Cross
 ..K ^MCAR(700,MCI,4,"B") ; "B" Cross
 ..K ^MCAR(700,MCI,6,"B") ; "B" Cross
 ..K ^MCAR(700,MCI,7,"B") ; "B" Cross
 ..K ^MCAR(700,MCI,8,"B") ; "B" Cross
 ..K ^MCAR(700,MCI,9,"B") ; "B" Cross
 ..K ^MCAR(700,MCI,10,"B") ; "B" Cross
 ..K ^MCAR(700,MCI,12,"B") ; "B" Cross
 ..K ^MCAR(700,MCI,13,"B") ; "B" Cross
 ..K ^MCAR(700,MCI,15,"B") ; "B" Cross
 ..K ^MCAR(700,MCI,"S","B") ; "B" Cross
 ..D
 ...N MCII
 ...S MCII=0
 ...F  S MCII=$O(^MCAR(700,MCI,"S",MCII)) Q:MCII<1  D
 ....K ^MCAR(700,MCI,"S",MCII,3,"B") ; "B" Cross
 ....Q
 ...Q
 ..K ^MCAR(700,MCI,24,"B") ; "B" Cross
 ..K ^MCAR(700,MCI,"ICD","B") ; "B" Cross
 ..Q
 .Q
 D EN1^MCPOS01(700)
F700P1 ; FILE 700.1
 K ^MCAR(700.1,"B") ; "B" Cross
 K ^MCAR(700.1,"AC") ; Sex Type
 D EN1^MCPOS01(700.1)
F700P2 ; FILE 700.2
 K ^MCAR(700.2,"B") ; "B" Cross
 K ^MCAR(700.2,"D") ; Type
 K ^MCAR(700.2,"C") ; Reference
 K ^MCAR(700.2,"E") ; Sex Type
 D EN1^MCPOS01(700.2)
F700P5 ; FILE 700.5
 K ^MCAR(700.5,"B") ; "B" Cross
 K ^MCAR(700.5,"C") ; Date/Time Latest
 K ^MCAR(700.5,"PT") ; Patient
 D EN1^MCPOS01(700.5)
F701 ; FILE 701
 K ^MCAR(701,"B") ; "B" Cross
 K ^MCAR(701,"C") ; Medical Patient
 K ^MCAR(701,"D") ; SSN
 K ^MCAR(701,"PCC") ; PCC Pointer
 D
 .N MCI
 .S MCI=0
 .F  S MCI=$O(^MCAR(701,MCI)) Q:MCI<1  D
 ..K ^MCAR(701,MCI,6,"B") ; "B" Cross
 ..K ^MCAR(701,MCI,13,"B") ; "B" Cross
 ..K ^MCAR(701,MCI,"ICD","B") ; "B" Cross
 ..K ^MCAR(701,MCI,2005,"B") ; "B" Cross
 ..Q
 .Q
 D EN1^MCPOS01(701)
 Q
