GMVBP4 ;HIOFO/YH,FT-CALL KYOCERA B/P GRAPH MACRO ;11/6/01  14:36
 ;;5.0;GEN. MED. REC. - VITALS;;Oct 31, 2002
 ;
 ; This routine uses the following IAs:
 ; <None>
 ;
EN3 ;CONTINUATION OF GMVBP3
CALL W !,"CALL BOX;"
 W !,"CALL DATE" S J(1)=1,J(2)=J(1)+9 D WRTCALL
 W !,"CALL TIME" S J(1)=17,J(2)=J(1)+9 D WRTCALL
SYSG ;SYSTOLIC BP GRAPH
 W !,"CALL PLSG, "_^TMP($J,"GMRK","G226M")_", "_^("G226")_", "_^("G227")_", "_^("G228")_", "_^("G229")_", "_^("G230")_", "_^("G231")_", "_^("G232")_", "
 W ^TMP($J,"GMRK","G233")_", "_^("G234")_", "_^("G235")_";"
 W !,"CALL PLS1, "_^TMP($J,"GMRK","G226M")_", "_^("G226")_", '"_^("G1201")_"', "_^("G227")_", '"_^("G1202")_"', "_^("G228")_", '"_^("G1203")_"', "_^("G229")_", '"_^("G1204")_"', "
 W ^TMP($J,"GMRK","G230")_", '"_^("G1205")_"', "_^("G231")_", '"_^("G1206")_"', "_^("G232")_", '"_^("G1207")_"', "_^("G233")_", '"_^("G1208")_"', "_^("G234")_", '"_^("G1209")_"';"
 W !,"CALL PLS2, "_^TMP($J,"GMRK","G235")_", '"_^("G1210")_"';"
 ;DIASTOLIC B/P GRAPH
 W !,"CALL PLSG, "_^TMP($J,"GMRK","G210M")_", "_^("G210")_", "_^("G211")_", "_^("G212")_", "_^("G213")_", "_^("G214")_", "_^("G215")_", "_^("G216")_", "
 W ^TMP($J,"GMRK","G217")_", "_^("G218")_", "_^("G219")_";"
 W !,"CALL PLS1, "_^TMP($J,"GMRK","G210M")_", "_^("G210")_", '"_^("G1101")_"', "_^("G211")_", '"_^("G1102")_"', "_^("G212")_", '"_^("G1103")_"', "_^("G213")_", '"_^("G1104")_"', "_^("G214")_", '"_^("G1105")
 W "', "_^TMP($J,"GMRK","G215")_", '"_^("G1106")_"', "_^("G216")_", '"_^("G1107")_"', "_^("G217")_", '"_^("G1108")_"', "_^("G218")_", '"_^("G1109")_"';"
 W !,"CALL PLS2, "_^TMP($J,"GMRK","G219")_", '"_^("G1110")_"';"
PULSE W !,"CALL PULS" S J(1)=98,J(2)=J(1)+9 D WRTCALL
 W !,"CALL PQU" S J(1)=1121,J(2)=J(1)+9 D WRTCALL
 W !,"CALL BP" S J(1)=130,J(2)=J(1)+9 D WRTCALL
 W !,"CALL BP3" S J(1)=1241,J(2)=J(1)+9 D WRTCALL
 W !,"CALL BPQUA" S J(1)=451,J(2)=J(1)+9 D WRTCALL
 W !,"CALL MEAN" S J(1)=1221,J(2)=J(1)+9 D WRTCALL
 W !,"CALL QUA, '"_$G(GLINE(1))_"';"
 W !,"CALL QU2, '"_$G(GLINE(2))_"';"
 W !,"CALL QU3, '"_$G(GLINE(3))_"';"
 W !,"CALL PID, """_^TMP($J,"GMRK","G194")_""", '"_^("G196")_"', '"_^("G197")_"', '"_^("G198")_"', '"_^("G199")_"', '"_^("G200")_"', '"_GMRDIV_"', '"_GSTRFIN_"';"
 W !,"RES; EXIT;"
 Q
WRTCALL ;
 S I(1)="" F I=J(1):1:J(2) S I(1)=I(1)_", '"_^TMP($J,"GMRK","G"_I)_"'"
 W I(1)_";"
 Q
