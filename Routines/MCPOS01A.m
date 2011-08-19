MCPOS01A ;HIRMFO/WAA - Kill all cross reference in a file - ;8/6/96  07:23
 ;;2.3;Medicine;;09/13/1996
 ;;
 ; 
 ; These routines will loop through a list of file number
 ; and delete all the cross references for that file.
 ; Then these routines will use file manager to reindex all
 ; the cross references in that same file.
 ; 
 ; This program is the master control program.  It
 ; will loop through a list of file number and pass that
 ; number to the kill routine then it will pass to the reindex
 ; routine
 ;
EN1 ; Main Entry point
F690 ; FILE 690
 K ^MCAR(690,"B") ; "B" Cross
 K ^MCAR(690,"AC") ; Procedures
 D
 .N MCI
 .S MCI=0
 .F  S MCI=$O(^MCAR(690,MCI)) Q:MCI<1  D
 ..K ^MCAR(690,MCI,"P","B") ; "B" Cross
 ..K ^MCAR(690,MCI,"P1","B") ; "B" Cross
 ..K ^MCAR(690,MCI,"P4","B") ; "B" Cross
 ..Q
 .Q
 D EN1^MCPOS01(690)
F690P1 ; FILE 690.1
 K ^MCAR(690.1,"B") ; "B" Cross
 D
 .N MCI
 .S MCI=0
 .F  S MCI=$O(^MCAR(690.1,MCI)) Q:MCI<1  D
 ..K ^MCAR(690.1,MCI,1,"B") ; "B" Cross
 ..K ^MCAR(690.1,MCI,2,"B") ; "B" Cross
 ..Q
 .Q
 D EN1^MCPOS01(690.1)
F690P2 ; FILE 690.2
 K ^MCAR(690.2,"B") ; "B" Cross
 K ^MCAR(690.2,"C") ; File number cross
 K ^MCAR(690.2,"D") ; Procedure
 D
 .N MCI
 .S MCI=0
 .F  S MCI=$O(^MCAR(690.2,MCI)) Q:MCI<1  D
 ..K ^MCAR(690.2,MCI,1,"B") ; "B" Cross
 ..K ^MCAR(690.2,MCI,2,"B") ; "B" Cross
 ..D
 ...N MCII
 ...S MCII=0
 ...F  S MCII=$O(^MCAR(690.2,MCI,2,MCII)) Q:MCII<1  D
 ....K ^MCAR(690.2,MCI,2,MCII,1,"B") ; "B" Cross
 ....Q
 ...Q
 ..K ^MCAR(690.1,MCI,3,"B") ; "B" Cross
 ..Q
 .Q
 D EN1^MCPOS01(690.2)
F690P5 ; FILE 690.5
 K ^MCAR(690.5,"B") ; "B" Cross
 K ^MCAR(690.5,"C") ; ASTM cross
 D EN1^MCPOS01(690.5)
F690P97 ; FILE 690.97
 K ^MCAR(690.97,"B") ; "B" Cross
 D EN1^MCPOS01(690.97)
F690P99 ; FILE 690.99
 K ^MCAR(690.99,"B") ; "B" Cross
 K ^MCAR(690.99,"AA") ; IEN
 K ^MCAR(690.99,"AB") ; SUB-IEN
 D EN1^MCPOS01(690.99)
 G F691^MCPOS01B
