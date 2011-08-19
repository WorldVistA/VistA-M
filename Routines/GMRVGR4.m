GMRVGR4 ;HIRMFO/YH-VITALS GRAPH KYOCERA PRINT COMMANDS (PART 1) ;5/1/97
 ;;4.0;Vitals/Measurements;**1**;Apr 25, 1997
EN3 ;CONTINUATION OF GMRVGR3
CALL W !,"CALL BOX,'%';"
 W !,"CALL DATE" S J(1)=1,J(2)=J(1)+9 D WRTCALL^GMRVBP4
 W !,"CALL TIME" S J(1)=17,J(2)=J(1)+9 D WRTCALL^GMRVBP4
 W !,"CALL WT" S J(1)=34,J(2)=J(1)+9 D WRTCALL^GMRVBP4
 W !,"CALL WTKG" S J(1)=311,J(2)=J(1)+9 D WRTCALL^GMRVBP4
 W !,"CALL BMI" S J(1)=331,J(2)=J(1)+9 D WRTCALL^GMRVBP4
 W !,"CALL HT" S J(1)=271,J(2)=J(1)+9 D WRTCALL^GMRVBP4
 W !,"CALL HTCM" S J(1)=291,J(2)=J(1)+9 D WRTCALL^GMRVBP4
 W !,"CALL TMPG, "_^TMP($J,"GMRK","G50M")_", "_^("G50")_", "_^("G51")_", "_^("G52")_", "_^("G53")_", "_^("G54")_", "_^("G55")_", "_^("G56")
 W ", "_^TMP($J,"GMRK","G57")_", "_^("G58")_", "_^("G59")_";"
 W !,"CALL TMP1, "_^TMP($J,"GMRK","G50M")_", "_^("G50")_", '"_^("G211")_"', "_^("G51")_", '"_^("G212")_"', "_^("G52")_", '"_^("G213")_"', "_^("G53")_", '"_^("G214")_"', "_^("G54")_", '"_^("G215")_"', "_^("G55")_", '"_^("G216")_"', "
 W ^TMP($J,"GMRK","G56")_", '"_^("G217")_"', "_^("G57")_", '"_^("G218")_"', "_^("G58")_", '"_^("G219")_"';"
 W !,"CALL TMP2, "_^TMP($J,"GMRK","G59")_", '"_^("G220")_"';"
 W !,"CALL TEMP" S J(1)=66,J(2)=J(1)+9 D WRTCALL^GMRVBP4
 W !,"CALL PLSG, "_^TMP($J,"GMRK","G82M")_", "_^("G82")_", "_^("G83")_", "_^("G84")_", "_^("G85")_", "_^("G86")_", "_^("G87")_", "_^("G88")_", "
 W ^TMP($J,"GMRK","G89")_", "_^("G90")_", "_^("G91")_";"
 W !,"CALL PLS1, "_^TMP($J,"GMRK","G82M")_", "_^("G82")_", '"_^("G231")_"', "_^("G83")_", '"_^("G232")_"', "_^("G84")_", '"_^("G233")_"', "_^("G85")_", '"_^("G234")_"', "_^("G86")_", '"_^("G235")_"', "_^("G87")_", '"_^("G236")_"', "
 W ^TMP($J,"GMRK","G88")_", '"_^("G237")_"', "_^("G89")_", '"_^("G238")_"', "_^("G90")_", '"_^("G239")_"';"
 W !,"CALL PLS2, "_^TMP($J,"GMRK","G91")_", '"_^("G240")_"';"
 W !,"CALL PULS" S J(1)=98,J(2)=J(1)+9 D WRTCALL^GMRVBP4
 Q
