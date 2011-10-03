GMRVWT4 ;HIRMFO/YH-KYOCERA WEIGHT GRAPH - MACRO CALL ;7/15/97
 ;;4.0;Vitals/Measurements;**1**;Apr 25, 1997
EN1 ;
CALL W !,"CALL BOX, '"_GWT(1)_"', '"_GWT(2)_"', '"_GWT(3)_"', '"_GWT(4)_"', '"_GWT(5)_"', '"_GWT(6)_"', '"_GWT(7)_"', '"_GWT(8)_"';"
 W !,"CALL DATE" S J(1)=1,J(2)=J(1)+9 D WRTCALL^GMRVBP4
 W !,"CALL TIME" S J(1)=17,J(2)=J(1)+9 D WRTCALL^GMRVBP4
 W !,"CALL WTG, "_GINI_", "_^TMP($J,"GMRK","G141")_", "_^("G142")_", "_^("G143")_", "_^("G144")_", "_^("G145")_", "_^("G146")
 W ", "_^TMP($J,"GMRK","G147")_", "_^("G148")_", "_^("G149")_", "_^("G150")_";"
 W !,"CALL PLS1, "_GINI_", "_^TMP($J,"GMRK","G141")_", '"_^("G161")_"', "_^("G142")_", '"_^("G162")_"', "_^("G143")_", '"_^("G163")_"', "_^("G144")_", '"_^("G164")_"', "_^("G145")_", '"_^("G165")_"', "_^("G146")_", '"_^("G166")_"', "
 W ^TMP($J,"GMRK","G147")_", '"_^("G167")_"', "_^("G148")_", '"_^("G168")_"', "_^("G149")_", '"_^("G169")_"';"
 W !,"CALL PLS2, "_^TMP($J,"GMRK","G150")_", '"_^("G170")_"';"
WT W !,"CALL WTLB" S J(1)=101,J(2)=J(1)+9 D WRTCALL^GMRVBP4
 W !,"CALL WTKG" S J(1)=121,J(2)=J(1)+9 D WRTCALL^GMRVBP4
 W !,"CALL QUAL" S J(1)=181,J(2)=J(1)+9 D WRTCALL^GMRVBP4
 W !,"CALL BMI" S J(1)=211,J(2)=J(1)+9 D WRTCALL^GMRVBP4
HT W !,"CALL HT" S J(1)=301,J(2)=J(1)+9 D WRTCALL^GMRVBP4
HTCM W !,"CALL HTCM" S J(1)=321,J(2)=J(1)+9 D WRTCALL^GMRVBP4
 W !,"CALL HQ" S J(1)=341,J(2)=J(1)+9 D WRTCALL^GMRVBP4
 W !,"CALL ALLQ, '"_$G(GLINE(1))_"';" W !,"CALL ALL2, '"_$G(GLINE(2))_"';"
PID W !,"CALL PID, """_GMVNM_""", '"_GMVDOB_"', '"_GMVGEN_"', '"_GMVWRD_"', '"_^TMP($J,"GMRK","G199")_"', '"_GMVRMBD_"', '"_GMRDIV_"', '"_GSTRFIN_"';"
 W !,"RES; EXIT;"
 Q
