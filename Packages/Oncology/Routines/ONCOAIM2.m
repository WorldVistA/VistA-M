ONCOAIM2 ;Hines OIFO/GWB - SEQUENCE NUMBER HELP FRAME ;1/22/96
 ;;2.11;ONCOLOGY;**1,36,44**;Mar 07, 1995
 ;
HLP ;Help Frame to display existing primaries
 W !,$S($O(^TMP($J,"MAL",""))'="":"Existing malignant or in situ primaries",1:"No malignant or in situ primaries.")," for ",ONCONM,$S($O(^TMP($J,"MAL",""))'="":":",1:".")
 S NUM=0 F  S MAL=NUM,NUM=$O(^TMP($J,"MAL",NUM)) D  Q:NUM'>0
 .Q:NUM'>0
 .W !?1,$P(^TMP($J,"MAL",NUM),U,2)," ",$P(^TMP($J,"MAL",NUM),U,3),?40,$P(^TMP($J,"MAL",NUM),U,5)
 W !!,$S($O(^TMP($J,"BEN",""))'="":"Existing non-malignant primaries",1:"No non-malignant primaries")," for ",ONCONM,$S($O(^TMP($J,"BEN",""))'="":":",1:".")
 S ALPHA=0 F  S BEN=ALPHA,ALPHA=$O(^TMP($J,"BEN",ALPHA)) D  Q:ALPHA'>0
 .Q:ALPHA'>0
 .W !?1,$P(^TMP($J,"BEN",ALPHA),U,2)," ",$P(^TMP($J,"BEN",ALPHA),U,3),?40,$P(^TMP($J,"BEN",ALPHA),U,5)
 W !
 W !,"Next available malignant or in situ SEQUENCE NUMBER: ",NEXTMAL
 W !,"Next available non-malignant SEQUENCE NUMBER.......: ",NEXTBEN
 W !
 Q
