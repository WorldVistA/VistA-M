GMRVKPN2 ;HCIOFO/YH-KYOCERA KYOCERA PAIN CHART PRINT COMMANDS (PART 1) ;2/12/99
 ;;4.0;Vitals/Measurements;**9**;Apr 25, 1997
EN3 ;CONTINUATION OF GMRVKPO3
CALL W !,"CALL BOX, '%';"
 W !,"CALL DATE" S J(1)=1,J(2)=J(1)+9 D WRTCALL
 W !,"CALL TIME" S J(1)=17,J(2)=J(1)+9 D WRTCALL
 W !,"CALL RPG, "_^TMP($J,"GMRK","G50M")_", "_^("G50")_", "_^("G51")_", "_^("G52")_", "_^("G53")_", "_^("G54")_", "_^("G55")_", "_^("G56")
 W ", "_^TMP($J,"GMRK","G57")_", "_^("G58")_", "_^("G59")_";"
 W !,"CALL RS1, "_^TMP($J,"GMRK","G50M")_", "_^("G50")_", '"_^("G411")_"', "_^("G51")_", '"_^("G412")_"', "_^("G52")_", '"_^("G413")_"', "_^("G53")_", '"_^("G414")_"', "_^("G54")_", '"_^("G415")_"', "_^("G55")_", '"_^("G416")_"', "
 W ^TMP($J,"GMRK","G56")_", '"_^("G417")_"', "_^("G57")_", '"_^("G418")_"', "_^("G58")_", '"_^("G419")_"';"
 W !,"CALL RS2, "_^TMP($J,"GMRK","G59")_", '"_^("G420")_"';"
 W !,"CALL RSP" S J(1)=250,J(2)=J(1)+9 D WRTCALL
 W !,"CALL PID, """_^TMP($J,"GMRK","G194")_""", '"_^("G196")_"', '"_^("G197")_"', '"_^("G198")_"', '"_^("G199")_"', '"_^("G200")_"', '"_GMRDIV_"', '"_GSTRFIN_"';"
 W !,"RES; EXIT;"
 Q
WRTCALL S I(1)="" F I=J(1):1:J(2) S I(1)=I(1)_", '"_^TMP($J,"GMRK","G"_I)_"'"
 W I(1)_";"
 Q
