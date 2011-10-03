FHNU10 ; HISC/REL - Print DRI Values ;3/8/95  13:26
 ;;5.5;DIETETICS;;Jan 28, 2005
 W !!,"The list requires a 132 column printer.",!
 W ! K IOP,%ZIS S %ZIS("A")="Select LIST PRINTER: ",%ZIS="MQ" D ^%ZIS K %ZIS,IOP G:POP KIL
 I $D(IO("Q")) S FHPGM="Q1^FHNU10",FHLST="" D EN2^FH G KIL
 U IO D Q1 D ^%ZISC K %ZIS,IOP G KIL
Q1 ; Print the DRI Values
 D NOW^%DTC S DTP=% D DTP^FH
 S PG=0 D HD1,HD2 S ITMS=$T(ITMS+1)
 S MNE="" F  S MNE=$O(^FH(112.2,"C",MNE)) Q:MNE=""  S FN=$O(^FH(112.2,"C",MNE,0)) D L1
 D HD1,HD3 S ITMS=$T(ITMS+2)
 S MNE="" F  S MNE=$O(^FH(112.2,"C",MNE)) Q:MNE=""  S FN=$O(^FH(112.2,"C",MNE,0)) D L1
 D HD1,HD4 S ITMS=$T(ITMS+3)
 S MNE="" F  S MNE=$O(^FH(112.2,"C",MNE)) Q:MNE=""  S FN=$O(^FH(112.2,"C",MNE,0)) D L1
 W ! Q
L1 S X=$G(^FH(112.2,FN,0)) W !,$E($P(X,"^",1),1,30)
 S X=$G(^FH(112.2,FN,1))
 F LL=3:1 S Y=$P(ITMS,";",LL) Q:Y=""  S P1=$P(Y,",",1),P2=$P(Y,",",2),P3=$P(Y,",",3),P4=$P(Y,",",4),Y=$P(X,"^",P1) W:Y'="" ?P2,$J(Y,P3,P4)
 Q
HD1 W:'($E(IOST,1,2)'="C-"&'PG) @IOF S PG=PG+1 W !,"DRI VALUES",?104,DTP,?125,"Page ",PG Q
HD2 W !?32,"Protein",?42,"Vitamin A",?54,"Vitamin E",?66,"Vitamin C",?77,"Thiamin",?87,"Riboflavin",?99,"Niacin",?108,"Vitamin B6",?121,"Folate"
 W !,"Name",?35,"Gm.",?46,"RE",?58,"Mg",?70,"Mg",?80,"Mg",?91,"Mg",?101,"Mg",?112,"Mg",?123,"Mcg"
 D LN Q
HD3 W !?32,"Vitamin B12",?46,"Calcium",?57,"Phosphorus",?70,"Magnesium",?84,"Iron",?93,"Zinc",?101,"Pantothenic",?117,"Copper"
 W !,"Name",?36,"Mcg",?49,"Mg",?61,"Mg",?74,"Mg",?85,"Mg",?94,"Mg",?104,"Acid Mg",?118,"Mg"
 D LN Q
HD4 W !?32,"Manganese",?45,"Sodium",?56,"Potassium",?69,"Biotin",?80,"Selenium",?92,"Choline",?103,"Vitamin D",?116,"Fluoride"
 W !,"Name",?36,"Mg",?47,"Mg",?60,"Mg",?71,"Mcg",?83,"Mcg",?95,"Mg",?107,"Mcg",?119,"Mg"
 D LN Q
ITMS ;;Piece,?Tab,Size,Dec
 ;;1,32,6,1;2,43,6,0;3,55,5,0;4,66,5,0;5,77,5,1;6,86,7,1;7,99,4,0;8,110,5,1;9,121,5,0;
 ;;10,34,5,1;11,46,6,0;12,57,7,0;13,70,6,0;14,84,3,0;15,93,3,0;16,102,7,1;17,117,4,2;
 ;;18,32,7,2;19,45,5,0;20,56,7,0;21,69,4,0;22,79,6,0;23,93,4,0;24,105,4,0;25,116,6,2;
LN W !,"-----------------------------------------------------------------------------------------------------------------------------------",! Q
KIL G KILL^XUSCLEAN
