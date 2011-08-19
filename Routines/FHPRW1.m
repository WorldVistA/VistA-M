FHPRW1 ; HISC/REL - List Facilities ;4/27/93  13:34 
 ;;5.5;DIETETICS;;Jan 28, 2005
 W ! K IOP,%ZIS S %ZIS("A")="Select LIST Printer: ",%ZIS="MQ" D ^%ZIS K %ZIS,IOP G:POP KIL
 I $D(IO("Q")) S FHPGM="Q1^FHPRW1",FHLST="" D EN2^FH G KIL
 U IO D Q1 D ^%ZISC K %ZIS,IOP G KIL
Q1 ; Print Facilities' Information
 D NOW^%DTC S NOW=%,PG=0
 F K1=0:0 S K1=$O(^FH(119.71,K1)) Q:K1'>0  D Q2
 D ^FHPRW2,^FHPRW3,^FHPRW4 W ! Q
Q2 S X=^FH(119.71,K1,0) D SVC,HDR
 W !!,"Full Names on Daily Menu:",?40,$S($P(X,"^",2)="Y":"YES",1:"NO")
 W !,"Print Meal Distribution:",?40,$S($P(X,"^",5)="Y":"YES",1:"NO")
 W !,"Separate Production Summary Pages:",?40,$S($P(X,"^",7)="Y":"YES",1:"NO")
 W !,"Separate Recipe Preparation Pages:",?40,$S($P(X,"^",4)="Y":"YES",1:"NO")
 W !,"Separate Storeroom Pages:",?40,$S($P(X,"^",6)="Y":"YES",1:"NO")
 I $D(^TMP($J,"T")) W !!,"Associated Tray Lines:",! S NX="" F  S NX=$O(^TMP($J,"T",NX)) Q:NX=""  W !?5,$P(NX,"~",1)
 I $D(^TMP($J,"C")) W !!,"Associated Cafeterias:",! S NX="" F  S NX=$O(^TMP($J,"C",NX)) Q:NX=""  W !?5,$P(NX,"~",1)
 I $D(^TMP($J,"S")) W !!,"Associated Supplemental Fdg. Sites:",! S NX="" F  S NX=$O(^TMP($J,"S",NX)) Q:NX=""  W !?5,$P(NX,"~",1)
 W ! Q
SVC ; Build Service temp file
 K ^TMP($J)
 F LL=0:0 S LL=$O(^FH(119.72,LL)) Q:LL<1  S Y=^(LL,0) I $P(Y,"^",3)=K1 S TYP=$P(Y,"^",2) D S1
 F LL=0:0 S LL=$O(^FH(119.74,LL)) Q:LL<1  S Y=^(LL,0) I $P(Y,"^",3)=K1 S TYP="S" D S1
 Q
S1 I $G(^FH(119.72,LL,"I"))'="Y" S ^TMP($J,TYP,$P(Y,"^",1)_"~"_LL)="" Q
HDR W:'($E(IOST,1,2)'="C-"&'PG) @IOF S PG=PG+1,DTP=NOW D DTP^FH W !,$E(DTP,1,9),?21,"P R O D U C T I O N   F A C I L I T Y",?73,"Page ",PG
 S Y=$P(X,"^",1) W !!?(78-$L(Y)\2),Y
 W !,"-------------------------------------------------------------------------------",! Q
KIL K ^TMP($J) G KILL^XUSCLEAN
