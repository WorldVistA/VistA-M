MCPOS01D ;HIRMFO/WAA - Kill all cross reference in a file - ;5/31/96  08:08
 ;;2.3;Medicine;;09/13/1996
 ;;
F695 ; FILE 695
 K ^MCAR(695,"B") ; "B" Cross
 K ^MCAR(695,"C") ; Medical Package Use
 D EN1^MCPOS01(695)
F695P1 ; FILE 695.1
 K ^MCAR(695.1,"B") ; "B" Cross
 D EN1^MCPOS01(695.1)
F695P3 ; FILE 695.3
 K ^MCAR(695.3,"B") ; "B" Cross
 D EN1^MCPOS01(695.3)
F695P4 ; FILE 695.4
 K ^MCAR(695.4,"B") ; "B" Cross
 D EN1^MCPOS01(695.4)
F695P5 ; FILE 695.5
 K ^MCAR(695.5,"B") ; "B" Cross
 K ^MCAR(695.5,"BA") ; "BA" Cross
 K ^MCAR(695.5,"C") ; Medical Use
 D EN1^MCPOS01(695.5)
F695P6 ; FILE 695.6
 K ^MCAR(695.6,"B") ; "B" Cross
 D EN1^MCPOS01(695.6)
F695P8 ; FILE 695.8
 K ^MCAR(695.8,"B") ; "B" Cross
 K ^MCAR(695.8,"AC") ; Medical Package Used
 D EN1^MCPOS01(695.8)
F695P9 ; FILE 695.9
 K ^MCAR(695.9,"B") ; "B" Cross
 D EN1^MCPOS01(695.9)
F696 ; FILE 696
 K ^MCAR(696,"B") ; "B" Cross
 D EN1^MCPOS01(696)
F696P1 ; FILE 696.1
 K ^MCAR(696.1,"B") ; "B" Cross
 D EN1^MCPOS01(696.1)
F696P2 ; FILE 696.2
 K ^MCAR(696.2,"B") ; "B" Cross
 D EN1^MCPOS01(696.2)
F696P3 ; FILE 696.3
 K ^MCAR(696.3,"B") ; "B" Cross
 D EN1^MCPOS01(696.3)
F696P4 ; FILE 696.4
 K ^MCAR(696.4,"B") ; "B" Cross
 D EN1^MCPOS01(696.4)
F696P5 ; FILE 696.5
 K ^MCAR(696.5,"B") ; "B" Cross
 K ^MCAR(696.5,"D") ; Display Code
 D EN1^MCPOS01(696.5)
F696P7 ; FILE 696.7
 K ^MCAR(696.7,"B") ; "B" Cross
 D EN1^MCPOS01(696.7)
F696P9 ; FILE 696.9
 K ^MCAR(696.9,"B") ; "B" Cross
 K ^MCAR(696.9,"C") ; Medical Package Use
 D EN1^MCPOS01(696.9)
F697 ; FILE 697
 K ^MCAR(697,"B") ; "B" Cross
 K ^MCAR(697,"C") ; Procedure
 K ^MCAR(697,"D") ; Procedure Name
 D
 .N MCI
 .S MCI=0
 .F  S MCI=$O(^MCAR(697,MCI)) Q:MCI<1  D
 ..K ^MCAR(697,MCI,1,"B") ; "B" Cross
 ..K ^MCAR(697,MCI,2,"B") ; "B" Cross
 ..Q
 .Q
 D EN1^MCPOS01(697)
F697P1 ; FILE 697.1
 K ^MCAR(697.1,"B") ; "B" Cross
 D EN1^MCPOS01(697.1)
F697P2 ; FILE 697.2
 K ^MCAR(697.2,"B") ; "B" Cross
 K ^MCAR(697.2,"C") ; Global Location
 K ^MCAR(697.2,"D") ; Type of Procedure
 D EN1^MCPOS01(697.2)
F697P3 ; FILE 697.3
 K ^MCAR(697.3,"B") ; "B" Cross
 K ^MCAR(697.3,"C") ; Description
 D
 .N MCI
 .S MCI=0
 .F  S MCI=$O(^MCAR(697.3,MCI)) Q:MCI<1  D
 ..K ^MCAR(697.3,MCI,1,"B") ; "B" Cross
 ..K ^MCAR(697.3,MCI,1,"A") ; Entry Num
 ..Q
 .Q
 D EN1^MCPOS01(697.3)
F697P5 ; FILE 697.5
 K ^MCAR(697.5,"B") ; "B" Cross
 K ^MCAR(697.5,"C") ; .01 KWIC
 K ^MCAR(697.5,"D") ; Procedures
 D  ; Diagnosis Code
 .N MCI
 .S MCI="A."
 .F  S MCI=$O(^MCAR(697.5,MCI)) Q:$P(MCI,".")'="A"  D
 ..K ^MCAR(697.5,MCI)
 ..Q
 .Q
 D
 .N MCI
 .S MCI=0
 .F  S MCI=$O(^MCAR(697.5,MCI)) Q:MCI<1  D
 ..K ^MCAR(697.5,MCI,2,"B") ; "B" Cross
 ..K ^MCAR(697.5,MCI,1,"B") ; "B" Cross
 ..K ^MCAR(697.5,MCI,4,"B") ; "B" Cross
 ..Q
 .Q
 D EN1^MCPOS01(697.5)
 G F698^MCPOS01E
