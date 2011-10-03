RCYPAY ;WISC/LDB-Date Sorted Payment report ;18 Aug 97
V ;;4.5;Accounts Receivable;**91**;Mar 20, 1995
 N ADM,AMT,BILL,CAT,CNT,DAT,DATE,DATESTRT,DATEEND,DATEX,DATEY,INT,LN,NOW,OUT,PG,POP,PRIN,RECPT,SUM,TN,TN0,TN1,TN3,TOT,TYP,X,Y,Z,ZTDESC,ZTRTN,ZTSAVE,%ZIS
 K ^TMP($J,"PAY"),^TMP($J,"CAT")
 ;
 ;  select date range
 D DATESEL("PAYMENT POSTED") I '$G(DATEEND) Q
 S DATEEND=DATEEND+.99
 ;
 ;  select summary or detail
 S DIR(0)="S^S:SUMMARY;D:DETAILED",DIR("A")="Summary or Detailed ",DIR("B")="S",DIR("?")="Detailed will include individual bill amounts."
 D ^DIR Q:$D(DIRUT)
 K DIR
 S SUM=Y
 ;
CAT ;select category
 K DIC S Y=0
 W !,"CATEGORY OF BILL: "_$S('$O(^TMP($J,"CAT",0)):"ALL// ",1:"")
 R X:DTIME I '$T!(X="^") Q
 I ((X="")!(X="ALL")),'$O(^TMP($J,"CAT",0)) S (CAT,X)="ALL" S ^TMP($J,"CAT",0)="ALL" G QUE
 S DIC="^PRCA(430.2,",DIC(0)="QEMZ"
 D ^DIC S CAT=+Y
 I X["?" W !!,"Enter 'ALL' for all categories or category name.",! G CAT
 I CAT'="ALL",(+CAT>0) S ^TMP($J,"CAT",+CAT)="" G CAT
 I X="" G QUE
 Q:X="^"
 G:+CAT<0 CAT
 ;  select device
QUE W !,"This report requires 132 column display."
 W ! S %ZIS="Q" D ^%ZIS Q:POP
 I $D(IO("Q")) D  D ^%ZTLOAD K IO("Q"),ZTSK Q
 .   S ZTDESC="Date Sorted Payment Report",ZTRTN="DQ^RCYPAY"
 .   S (ZTSAVE("DATESTRT"),ZTSAVE("DATEEND"),ZTSAVE("SUM"),ZTSAVE("^TMP($J,"))="",ZTSAVE("ZTREQ")="@"
 W !!,"<*> please wait <*>"
DQ D PROC D:SUM="D" DPRNT D:SUM="S" SPRNT
 D ^%ZISC K ^TMP($J,"PAY"),^TMP($J,"CAT") Q
 ;
PROC ;  report (queue) starts here
 U IO
 F TYP=2,34 S DAT=DATESTRT-.01 F  S DAT=$O(^PRCA(433,"AT",TYP,DAT)) Q:'DAT!(DAT>DATEEND)  D
 .S TN=0 F  S TN=$O(^PRCA(433,"AT",TYP,DAT,TN)) Q:'TN  D
 ..S TN0=$G(^PRCA(433,+TN,0))
 ..S TN1=$G(^PRCA(433,+TN,1))
 ..S TN3=$G(^PRCA(433,+TN,3))
 ..S BILL=$P(TN0,"^",2) Q:'BILL  S CAT=$P($G(^PRCA(430,+BILL,0)),"^",2) Q:'CAT
 ..I $G(^TMP($J,"CAT",0))'="ALL" Q:'$D(^TMP($J,"CAT",CAT))
 ..S RECPT=$P(TN1,"^",3)
 ..S DATE=$P(TN1,"^")
 ..S AMT=$P(TN1,"^",5),PRIN=+TN3,INT=$P(TN3,"^",2),ADM=$P(TN3,"^",3)
 ..S ^TMP($J,"PAY",CAT,BILL,TN)=DATE_"/"_DAT_"^"_RECPT_"^"_AMT_"^"_PRIN_"^"_INT_"^"_ADM
TOT S CAT=0 F  S CAT=$O(^TMP($J,"PAY",CAT)) Q:'CAT  D
 .S ^TMP($J,"PAY",CAT,"TOT")=0
 .S BILL=0 F  S BILL=$O(^TMP($J,"PAY",CAT,BILL)) Q:'BILL  D
 ..S TN=0 F  S TN=$O(^TMP($J,"PAY",CAT,BILL,TN)) Q:'TN  D
 ...F Z=2:1:5 S $P(^TMP($J,"PAY",CAT,"TOT"),"^",Z-1)=$P(^TMP($J,"PAY",CAT,BILL,TN),"^",Z+1)+$P(^TMP($J,"PAY",CAT,"TOT"),"^",Z-1)
 ...F X=1:1:4 S $P(^TMP($J,"PAY","TOT"),"^",X)=$P($G(^TMP($J,"PAY",CAT,"TOT")),"^",X)+$P($G(^TMP($J,"PAY","TOT")),"^",X)
 ;
 ;start print
 S (OUT,PG)=0
 S Y=DATESTRT D DD^%DT S DATEX=Y
 S Y=DATEEND D DD^%DT S DATEY=$P(Y,"@")
 D NOW^%DTC S Y=% D DD^%DT S NOW=Y
 I $E(IOST,1,2)="C" W @IOF
 D HDR D:SUM="S" HDR2 D:SUM="D" HDR1
 Q
 ;
HDR ;header
 W:$E(IOST,1,2)="C-" @IOF
 S PG=PG+1
 W !,"DATE SORTED REPORT"_$S(SUM="D":" Detailed",1:" Summary")
 W ?45,NOW,?68,"PAGE ",PG
 W !,?20,"FOR DATES: ",DATEX," - ",DATEY
 S LN="",$P(LN,"-",IOM)=""
 ;W !,LN
 Q
 ;
HDR1 ;detailed header
 W !,"BILL",?13,"POSTED DATE",?25,"PAYMENT DATE",?38,"RECEIPT",?54,"AMOUNT",?69,"PRIN",?83,"INT",?95,"ADM"
 W !,LN
 Q
 ;
HDR2 ;summary header
 W !,?26,"AMOUNT",?37,"PRIN",?46,"INT",?57,"ADM"
 W !,LN
 Q
 ;
DPRNT ;print
 S ^TMP($J,"PAY","TOT")=0
 S (CAT,CNT,CNT(2),OUT)=0 F  S CAT=$O(^TMP($J,"PAY",CAT)) Q:'CAT!OUT  D  W !
 .F X=1:1:4 S $P(^TMP($J,"PAY","TOT"),"^",X)=$P($G(^TMP($J,"PAY","TOT")),"^",X)+$P($G(^TMP($J,"PAY",CAT,"TOT")),"^",X)
 .W !,"CATEGORY: ",$P($G(^PRCA(430.2,+CAT,0)),"^")
 .S (CNT,CNT(1),BILL)=0 F  S BILL=$O(^TMP($J,"PAY",CAT,BILL)) Q:BILL=""!OUT  D
 ..S:BILL'="TOT" CNT=CNT+1
 ..I BILL="TOT" D
 ...W !,"TOTAL BILLS: ",CNT,?52,$J($P(^TMP($J,"PAY",CAT,"TOT"),"^"),9,2)
 ...W ?65,$J($P(^TMP($J,"PAY",CAT,"TOT"),"^",2),9,2),?78,$J($P(^("TOT"),"^",3),8,2),?90,$J($P(^("TOT"),"^",4),8,2)
 ...S TOT=^TMP($J,"PAY",CAT,"TOT")
 ...W !,"TOTAL PAYMENTS:",?52,$J(CNT(1),9),?65,$J(CNT(1),9),?77,$J(CNT(1),9),?89,$J(CNT(1),9)
 ...W !,"SUBMEAN:"
 ...W ?52,$S($P(TOT,"^"):$J($P(TOT,"^")/CNT(1),9,2),1:"")
 ...W ?65,$S($P(TOT,"^",2):$J($P(TOT,"^",2)/CNT(1),9,2),1:"")
 ...W ?77,$S($P(TOT,"^",3):$J($P(TOT,"^",3)/CNT(1),9,2),1:"")
 ...W ?89,$S($P(TOT,"^",4):$J($P(TOT,"^",4)/CNT(1),9,2),1:"")
 ..S TN=0 F  S TN=$O(^TMP($J,"PAY",CAT,BILL,TN)) Q:'TN!OUT  D
 ...S CNT(1)=CNT(1)+1,CNT(2)=CNT(2)+1
 ...S TN0=^TMP($J,"PAY",CAT,BILL,TN)
 ...W !,$P($G(^PRCA(430,+BILL,0)),"^")
 ...W ?13 S Y=$P($P(TN0,"^"),"/",2) X ^DD("DD") W Y
 ...Q:OUT  S Y=$P($P(TN0,"^"),"/") X ^DD("DD") W ?26,Y
 ...W ?38,$P(TN0,"^",2),?52,$J($P(TN0,"^",3),9,2),?65,$J($P(TN0,"^",4),9,2),?78,$J($P(TN0,"^",5),8,2),?90,$J($P(TN0,"^",6),8,2)
 ..Q:OUT  I $Y+10>IOSL D
 ...N DIR,DIRUT
 ...I $E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR S:$D(DIRUT) OUT=1
 ...Q:OUT  W @IOF D HDR,HDR1
 S TOT=^TMP($J,"PAY","TOT")
 Q:OUT  W !,"TOTAL:",?52,$J($P(TOT,"^"),9,2)
 W ?65,$J($P(TOT,"^",2),9,2),?77,$J($P(TOT,"^",3),9,2),?89,$J($P(TOT,"^",4),9,2)
 W !,"COUNT",?52,$J(CNT(2),9),?65,$J(CNT(2),9),?77,$J(CNT(2),9),?89,$J(CNT(2),9)
 W !,"MEAN"
 W ?52,$S($P(TOT,"^"):$J($P(TOT,"^")/CNT(2),9,2),1:"")
 W ?65,$S($P(TOT,"^",2):$J($P(TOT,"^",2)/CNT(2),9,2),1:"")
 W ?77,$S($P(TOT,"^",3):$J($P(TOT,"^",3)/CNT(2),9,2),1:"")
 W ?89,$S($P(TOT,"^",4):$J($P(TOT,"^",4)/CNT(2),9,2),1:"")
 W:$O(^TMP($J,"PAY",0))="" !?30,"NONE IN THIS DATE RANGE"
 I $E(IOST,1,2)="C-" R !,"PRESS RETURN TO CONTINUE",X:DTIME
 D ^%ZISC
 K ^TMP($J,"PAY")
 Q
 ;
 ;
 ;
DATESEL(DESCR) ;  select starting and ending dates in days
 ;  returns datestrt and dateend
 N %,%DT,%H,%I,DEFAULT,X,Y
 K DATEEND,DATESTRT
START S Y=$E(DT,1,5)_"01" D DD^%DT S DEFAULT=Y
 S %DT("A")="Start with "_$S(DESCR'="":DESCR_" ",1:"")_"Date: ",%DT("B")=DEFAULT,%DT="AEP",%DT(0)=-DT D ^%DT I Y<0 Q
 I $E(Y,6,7)="00" S Y=$E(Y,1,5)_"01"
 S DATESTRT=Y
 S Y=DT D DD^%DT S DEFAULT=Y
 S %DT("A")="  End with "_$S(DESCR'="":DESCR_" ",1:"")_"Date: ",%DT("B")=DEFAULT,%DT="AEP",%DT(0)=-DT D ^%DT I Y<0 Q
 I $E(Y,6,7)="00" S Y=$E(Y,1,5)_"01"
 I Y<DATESTRT W !,"END DATE MUST BE GREATER THAN OR EQUAL TO THE START DATE.",! G START
 S DATEEND=Y,Y=DATESTRT D DD^%DT
 W !?5,"***  Selected date range from ",Y," to " S Y=DATEEND D DD^%DT W Y,"  ***"
 Q
 ;
 ;
SPRNT ;Print Summary
 S ^TMP($J,"PAY","TOT")=0
 S (CAT,CNT(2))=0 F  S CAT=$O(^TMP($J,"PAY",CAT)) Q:'CAT!(OUT)  D
 .I $Y+7>IOSL D
 ..I $E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR S:$D(DIRUT) OUT=1
 ..Q:OUT  W @IOF D HDR,HDR2
 .Q:OUT
 .W !!,"CATEGORY: ",$P(^PRCA(430.2,+CAT,0),"^")
 .W !,"TOTAL BILLS: "
 .S (BILL,CNT)=0 F  S BILL=$O(^TMP($J,"PAY",CAT,BILL)) Q:'BILL  S CNT=CNT+1
 .W CNT
 .S (CNT(1),BILL,TN)=0 F  S BILL=$O(^TMP($J,"PAY",CAT,BILL)) Q:'BILL  D
 ..S TN=0 F  S TN=$O(^TMP($J,"PAY",CAT,BILL,TN)) Q:'TN  S CNT(1)=CNT(1)+1,CNT(2)=CNT(2)+1
 .S TOT=^TMP($J,"PAY",CAT,"TOT")
 .W ?22,$J($P(TOT,"^"),9,2),?33,$J($P(TOT,"^",2),9,2),?43,$J($P(TOT,"^",3),8,2),?54,$J($P(TOT,"^",4),8,2)
 .F X=1:1:4 S $P(^TMP($J,"PAY","TOT"),"^",X)=$P(TOT,"^",X)+$P($G(^TMP($J,"PAY","TOT")),"^",X)
 .W !,"TOTAL PAYMENTS",?22,$J(CNT(1),9),?33,$J(CNT(1),9),?41,$J(CNT(1),9),?53,$J(CNT(1),9)
 .W !,"SUBMEAN",?22,$S($P(TOT,"^"):$J($P(TOT,"^")/CNT(1),9,2),1:"")
 .W ?33,$S($P(TOT,"^",2):$J($P(TOT,"^",2)/CNT(1),9,2),1:"")
 .W ?42,$S($P(TOT,"^",3):$J($P(TOT,"^",3)/CNT(1),9,2),1:"")
 .W ?53,$S($P(TOT,"^",4):$J($P(TOT,"^",4)/CNT(1),9,2),1:"")
 S TOT=^TMP($J,"PAY","TOT")
 Q:OUT  W !!,"TOTAL",?22,$J($P(TOT,"^"),9,2),?33,$J($P(TOT,"^",2),9,2)
 W ?42,$J($P(TOT,"^",3),9,2),?53,$J($P(TOT,"^",4),9,2)
 W !,"COUNT",?22,$J(CNT(2),9),?33,$J(CNT(2),9),?42,$J(CNT(2),9),?53,$J(CNT(2),9)
 W !,"MEAN",?22,$S($P(TOT,"^"):$J($P(TOT,"^")/CNT(2),9,2),1:"")
 W ?33,$S($P(TOT,"^",2):$J($P(TOT,"^",2)/CNT(2),9,2),1:"")
 W ?42,$S($P(TOT,"^",3):$J($P(TOT,"^",3)/CNT(2),9,2),1:"")
 W ?53,$S($P(TOT,"^",4):$J($P(TOT,"^",4)/CNT(2),9,2),1:"")
 W:$O(^TMP($J,"PAY",0))="" !?30,"NONE IN THIS DATE RANGE"
 I $E(IOST,1,2)="C-" R !,"PRESS RETURN TO CONTINUE",X:DTIME
 Q
