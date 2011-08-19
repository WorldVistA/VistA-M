GMVKPO4 ;HIOFO/YH,FT-GRAPH KYOCERA PRINT COMMANDS (PART 1) ;11/6/01  15:01
 ;;5.0;GEN. MED. REC. - VITALS;;Oct 31, 2002
 ;
 ; This routine uses the following IAs:
 ; <None>
 ;
EN3 ;CONTINUATION OF GMVKPO3
CALL W !,"CALL BOX, '%';"
 W !,"CALL DATE" S J(1)=1,J(2)=J(1)+9 D WRTCALL^GMVBP4
 W !,"CALL TIME" S J(1)=17,J(2)=J(1)+9 D WRTCALL^GMVBP4
 W !,"CALL RPG, "_^TMP($J,"GMRK","G50M")_", "_^("G50")_", "_^("G51")_", "_^("G52")_", "_^("G53")_", "_^("G54")_", "_^("G55")_", "_^("G56")
 W ", "_^TMP($J,"GMRK","G57")_", "_^("G58")_", "_^("G59")_";"
 W !,"CALL RS1, "_^TMP($J,"GMRK","G50M")_", "_^("G50")_", '"_^("G411")_"', "_^("G51")_", '"_^("G412")_"', "_^("G52")_", '"_^("G413")_"', "_^("G53")_", '"_^("G414")_"', "_^("G54")_", '"_^("G415")_"', "_^("G55")_", '"_^("G416")_"', "
 W ^TMP($J,"GMRK","G56")_", '"_^("G417")_"', "_^("G57")_", '"_^("G418")_"', "_^("G58")_", '"_^("G419")_"';"
 W !,"CALL RS2, "_^TMP($J,"GMRK","G59")_", '"_^("G420")_"';"
 W !,"CALL RSP" S J(1)=250,J(2)=J(1)+9 D WRTCALL^GMVBP4
 W !,"CALL PLSG, "_^TMP($J,"GMRK","G82M")_", "_^("G82")_", "_^("G83")_", "_^("G84")_", "_^("G85")_", "_^("G86")_", "_^("G87")_", "_^("G88")_", "
 W ^TMP($J,"GMRK","G89")_", "_^("G90")_", "_^("G91")_";"
 W !,"CALL PLS1, "_^TMP($J,"GMRK","G82M")_", "_^("G82")_", '"_^("G431")_"', "_^("G83")_", '"_^("G432")_"', "_^("G84")_", '"_^("G433")_"', "_^("G85")_", '"_^("G434")_"', "_^("G86")_", '"_^("G435")_"', "_^("G87")_", '"_^("G436")_"', "
 W ^TMP($J,"GMRK","G88")_", '"_^("G437")_"', "_^("G89")_", '"_^("G438")_"', "_^("G90")_", '"_^("G439")_"';"
 W !,"CALL PLS2, "_^TMP($J,"GMRK","G91")_", '"_^("G440")_"';"
 W !,"CALL PULS" S J(1)=282,J(2)=J(1)+9 D WRTCALL^GMVBP4
PO2Q ;
 W !,"CALL POXL" S J(1)=1431,J(2)=J(1)+9 D WRTCALL^GMVBP4
 W !,"CALL POXP" S J(1)=1451,J(2)=J(1)+9 D WRTCALL^GMVBP4
 W !,"CALL POXM" S J(1)=1471,J(2)=J(1)+9 D WRTCALL^GMVBP4
 W !,"CALL NEWP" S J(1)=311,J(2)=J(1)+9 D WRTCALL^GMVBP4
 W !,"CALL PLQ" S J(1)=331,J(2)=J(1)+9 D WRTCALL^GMVBP4
 W !,"CALL QUA, '"_$G(GLINE(1))_"';" W !,"CALL QU2, '"_$G(GLINE(2))_"';"
 W !,"CALL PID, """_^TMP($J,"GMRK","G194")_""", '"_^("G196")_"', '"_^("G197")_"', '"_^("G198")_"', '"_^("G199")_"', '"_^("G200")_"', '"_GMRDIV_"', '"_GSTRFIN_"';"
 W !,"RES; EXIT;"
 Q
