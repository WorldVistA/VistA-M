FHORT5C ; HISC/REL/NCA/RVD - Tubefeeding Reports (cont) ;3/1/04  09:55
 ;;5.5;DIETETICS;;Jan 28, 2005
 ;
 ;RVD 3/1/04 - modify for Outpatient meals project (pull list report).
 ;
PULL ; Pull List
 S NAM="" F  S NAM=$O(^FH(118.2,"B",NAM)) Q:NAM=""  F LL=0:0 S LL=$O(^FH(118.2,"B",NAM,LL)) Q:LL<1  S ^TMP($J,"P",NAM_"~"_LL)=LL
 I SUM S CNOD="0" D P2 Q
 S CNOD="0" F  S CNOD=$O(^TMP($J,"C",CNOD)) Q:CNOD=""  D P2
 Q
P2 S NAM="" D HD3
 F  S NAM=$O(^TMP($J,"P",NAM)) Q:NAM=""  S LL=^(NAM) I $D(^TMP($J,"C",CNOD,LL)) S TU=$P($G(^(LL,0)),"^",1) D
 .S Y0=^FH(118.2,LL,0),TU=TU+.95\1 D:$Y>(IOSL-8) HD3
 .W !?21,$J(TU,5)," ",$P(Y0,"^",2),?41,$P(Y0,"^",1) Q
 W ! Q
DEL ; Delivery List
 D:SUM HD2 S TNOD="" F  S TNOD=$O(^TMP($J,"T",TNOD)) Q:TNOD=""  D:'SUM HD2 S PNOD="" F  S PNOD=$O(^TMP($J,"T",TNOD,PNOD)) Q:PNOD=""  S X0=^(PNOD,0) D
 .D:$Y>(IOSL-10) HD2 W !,$E($P(X0,"^",3),1,12),?13,$E($P(X0,"^",4),1,10),?24,$P(X0,"^",1),?47,$P(X0,"^",2)
 .F TF2=0:0 S TF2=$O(^TMP($J,"T",TNOD,PNOD,TF2)) Q:TF2<1  S X1=^(TF2,0) D
 ..S TW=$P(X0,"^",4) W ?55,$P(X1,"^",1),?86,$P(X1,"^",6),! Q
 .Q
 W ! Q
HD2 ; Delivery Header
 W:'($E(IOST,1,2)'="C-"&'PG) @IOF S PG=PG+1
 W !,DTP,?42,"D E L I V E R Y   O F   T U B E F E E D I N G S",?125,"Page ",PG
 S Y=$S(SUM:"CONSOLIDATED",1:$P(TNOD,"~",2)) W:Y'="" !!?(131-$L(Y)\2),Y
 W !!,"Location",?13,"Room",?24,"Patient",?48,"ID#",?55,"Product",?86,"Quantity",!
 Q
HD3 ; Pull List Header
 W:'($E(IOST,1,2)'="C-"&'PG) @IOF S PG=PG+1
 W !,DTP,?19,"T U B E F E E D I N G   P U L L   L I S T",?72,"Page ",PG
 S Y=$S(SUM:"CONSOLIDATED",1:$P(CNOD,"~",2)) W:Y'="" !!?(80-$L(Y)\2),Y
 W !!?25,"# Units",?41,"Product",! Q
