PSOCST12 ;BHAM ISC/SAB - DIVISION BY DRUG COST ; 08/19/92 8:37
 ;;7.0;OUTPATIENT PHARMACY;**31**;DEC 1997
 ;External Ref. to ^PS(59, is supp. by DBIA# 212
 ;External Ref. to ^PSDRUG( is supp. by DBIA# 221
BEG S RP=12 D HDC^PSOCSTX F  D CDT^PSOCSTX Q:$G(CTR)  D DVS^PSOCSTX Q:$G(CTR)  S RP=0 D CTP^PSOCSTX Q:$G(CTR)  I RP=0 D DEV Q
 D EX Q
DEV D DVC^PSOCSTX Q:$G(CTR)
 K PSOION I $D(IO("Q")) S ZTDESC="DRUG COSTS BY DIVISION BY DRUG",ZTRTN="START^PSOCST12" D PAS^PSOCSTX
 I  K IO("Q") D ^%ZTLOAD W:$D(ZTSK) !,"REPORT QUEUED TO PRINT !!",! D EX Q
START U IO K ^TMP($J) F PSDT=(BEGDATE-1):0:ENDDATE S PSDT=$O(^PSCST(PSDT)) Q:'PSDT!(PSDT>ENDDATE)  D @$S('IFN:"DIV",1:"DRUG")
 S DIVX="" F  S DIVX=$O(^TMP($J,DIVX)) Q:DIVX=""  S DRUGX="" F  S DRUGX=$O(^TMP($J,DIVX,DRUGX)) Q:DRUGX=""  D STR
 S (QTY,CNT,CNTO,CNTR,COST)=0,DIVX="" I $O(^TMP($J,DIVX))']"" D HD,HDN^PSOCSTX Q
 F  S DIVX=$O(^TMP($J,DIVX)) Q:DIVX=""!($G(CTR))  S DRUGX="" D HD Q:$G(CTR)  F  S DRUGX=$O(^TMP($J,DIVX,DRUGX)) D:DRUGX="" SUB Q:DRUGX=""  D PRT3 Q:$G(CTR)
 I 'CTR,'IFN D HD:($Y+4)>IOSL W !! D PUL W !,"Total for all divisions ",?50,$J(CNTO,6),?57,$J(CNTR,6),?66,$J(CNT,6),?77,$J(QTY,8,2),?88,$J(COST,10,2),?104 S AVG=$S('CNT:0,1:(COST/CNT)) W $J(AVG,10,2) D PUL W !
EX D EX^PSOCSTX K QTY Q
HD D HD0^PSOCSTX Q:$G(CTR)
 W !,?50,"Orgin",?68,"Total",?77,"Total",?90,"Total",?105,"Avg Cost",!,"Drug",?50,"Fills",?57,"Refills",?68,"Fills",?77,"Qty",?90,"Cost",?105,"per Fill"
 W ! F I=1:1:130 W "-"
 W:DIVX]"" !,?5,"Division: ",DIVX
 Q
PUL W !,?50,"------",?57,"------",?66,"------",?77,"--------",?88,"----------",?104,"----------"
 Q
PRT3 D HD:($Y+4)>IOSL Q:$G(CTR)  S Y=^TMP($J,DIVX,DRUGX),FILLS=($P(Y,"^",2)+$P(Y,"^",3)),CNT=CNT+FILLS,CNTO=CNTO+$P(Y,"^",2),CNTR=CNTR+$P(Y,"^",3),COST=COST+$P(Y,"^",4),QTY=QTY+$P(Y,"^",5)
 W !,DRUGX,?50,$J($P(Y,"^",2),6),?57,$J($P(Y,"^",3),6),?66,$J(FILLS,6),?77,$J($P(Y,"^",5),8,2),?88,$J($P(Y,"^",4),10,2),?104 S AVG=$S('FILLS:0,1:($P(Y,"^",4)/FILLS)) W $J(AVG,10,2)
 Q
DIV F DIV=0:0 S DIV=$O(^PSCST(PSDT,"V",DIV)) Q:'DIV  D DRUG
 Q
DRUG F DRUG=0:0 S DRUG=$O(^PSCST(PSDT,"V",DIV,"D",DRUG)) Q:'DRUG  I $D(^(DRUG,0)) S X=^(0) D STORE
 Q
STORE S DIVX=$S($D(^PS(59,+DIV,0)):$P(^(0),"^"),1:"UNKNOWN")
 Q:'$D(^PSDRUG(DRUG,0))  S DRUGX=$P(^(0),"^") S:'$D(^TMP($J,DIVX,DRUGX)) ^TMP($J,DIVX,DRUGX)="^0^0^0^0",^TMP($J,DIVX)="^0^0^0^0^0"
 S UTL=^TMP($J,DIVX,DRUGX),^TMP($J,DIVX,DRUGX)="^"_($P(UTL,"^",2)+$P(X,"^",2))_"^"_($P(UTL,"^",3)+$P(X,"^",3))_"^"_($P(UTL,"^",4)+$P(X,"^",4))_"^"_($P(UTL,"^",5)+$P(X,"^",5))
 Q
STR S $P(^TMP($J,DIVX),"^",2)=($P(^TMP($J,DIVX),"^",2)+$P(^TMP($J,DIVX,DRUGX),"^",2)),$P(^TMP($J,DIVX),"^",3)=($P(^TMP($J,DIVX),"^",3)+$P(^TMP($J,DIVX,DRUGX),"^",3))
 S $P(^TMP($J,DIVX),"^",4)=($P(^TMP($J,DIVX),"^",4)+$P(^TMP($J,DIVX,DRUGX),"^",4)),$P(^TMP($J,DIVX),"^",5)=($P(^TMP($J,DIVX),"^",5)+$P(^TMP($J,DIVX,DRUGX),"^",2)+$P(^TMP($J,DIVX,DRUGX),"^",3))
 S $P(^TMP($J,DIVX),"^",6)=($P(^TMP($J,DIVX),"^",6)+$P(^TMP($J,DIVX,DRUGX),"^",5))
 Q
SUB ;sub-totals per division
 D PUL
 W !,"Total for "_DIVX,?50,$J($P(^TMP($J,DIVX),"^",2),6),?57,$J($P(^(DIVX),"^",3),6),?66,$J($P(^(DIVX),"^",5),6),?77,$J($P(^(DIVX),"^",6),8,2),?88,$J($P(^(DIVX),"^",4),10,2),?104,$J($P(^(DIVX),"^",4)/$P(^(DIVX),"^",5),10,2)
 D PUL Q
