FHORT5B ; HISC/REL/NCA - Tubefeeding Reports (cont) ;5/4/93  10:47 
 ;;5.5;DIETETICS;**1**;Jan 28, 2005
PREP ; Preparation Report
 D:SUM HD1 S TNOD="" F  S TNOD=$O(^TMP($J,"T",TNOD)) Q:TNOD=""  D:'SUM HD1 D A2
 Q
A2 S PNOD="" F  S PNOD=$O(^TMP($J,"T",TNOD,PNOD)) Q:PNOD=""  S X0=^(PNOD,0) D A3
 Q
A3 D:$Y>(IOSL-10) HD1 W !,$P(X0,"^",3)," ",$P(X0,"^",4),!,$P(X0,"^",1),?23,$P(X0,"^",2)
 F TF2=0:0 S TF2=$O(^TMP($J,"T",TNOD,PNOD,TF2)) Q:'TF2  S X1=^(TF2,0) D A4
 S COM=$P(X0,"^",5) W:COM'="" ?66,COM,! Q
A4 W ?31,$E($P(X1,"^",1),1,29) S STR=$P(X1,"^",7) W ?61,$S(STR=4:"Full",STR=2:"1/2",STR=1:"1/4",1:"3/4")
 W ?66,$P(X1,"^",8),?101,$P(X1,"^",2),?110,$P(X1,"^",6)
 S TW=$P(X1,"^",4) I TW W ?117,$J($P(X1,"^",3),5),?126,$J(TW,4)
 W ! Q
HD1 ; Preparation Header
 W:'($E(IOST,1,2)'="C-"&'PG) @IOF S PG=PG+1
 W !,DTP,?39,"P R E P A R A T I O N   O F   T U B E F E E D I N G S",?125,"Page ",PG
 S Y=$S(SUM:"CONSOLIDATED",1:$P(TNOD,"~",2)) W:Y'="" !!?(131-$L(Y)\2),Y
 W !!,?112,"#",?119,"ML",?127,"ML"
 W !,"Patient",?24,"ID#",?31,"Product",?61,"Str",?66,"Quantity",?101,"Unit",?110,"Units",?117,"Product",?126,"Water",!
 Q
