ECTDSUR ;B'ham ISC/DMA-Surgery Workload ;01/29/91 08:00
V ;;1.05;INTERIM MANAGEMENT SUPPORT;;
 I '$D(^SRF) W *7,!!?29,"OPTION IS UNAVAILABLE!",!,"The 'Surgery' File - #130 is not loaded on your system.",!! S XQUIT="" Q
 I '$O(^SRF(0)) W *7,!!,"'Surgery' File - #130 has not been populated on your system.",!! S XQUIT="" Q
 ;
BDAT K %DT S %DT="AEX",%DT("A")="Beginning date : " D ^%DT G:Y<0 END S ECBD=Y
EDAT S %DT("A")="Ending date : " D ^%DT G:Y<0 END S ECED=Y I Y<ECBD W !,"Ending date must be later than beginning date",! G BDAT
 S %ZIS="Q" D ^%ZIS I POP G END
 I $D(IO("Q")) G QUE
 ;
DEQ ;gather and print data
 U IO K ^TMP($J)
 S ECED=ECED+.3
 F ECD=ECBD-.1:0 S ECD=$O(^SRF("AC",ECD)) Q:'ECD  Q:ECD>ECED  F ECD0=0:0 S ECD0=$O(^SRF("AC",ECD,ECD0)) Q:'ECD0  I $D(^SRF(ECD0,0)) S DATA=^(0) D GET
 ;
PRINT ;
 W:$Y @IOF
 S (COT,CAT)=0,PGCT=1,$P(LN,"-",81)=""
 W !,?15,"SURGERY CASES FOR THE PERIOD ",$E(ECBD,4,5),"/",$E(ECBD,6,7),"/",$E(ECBD,2,3)," TO ",$E(ECED,4,5),"/",$E(ECED,6,7),"/",$E(ECED,2,3) D NOW^%DTC S Y=$E(%,1,12) X ^DD("DD") W !!?45,Y,?70,"PAGE ",PGCT S PGCT=PGCT+1
 W !!,?35,"COMPLETED",?47,"CANCELLED",?61,"TOTAL",?71,"PERCENT",!,"SPECIALTY",?37,"CASES",?49,"CASES",?61,"CASES",?70,"CANCELLED",!,LN
 I $O(^TMP($J,0))="" W !?19,"NO DATA AVAILABLE FOR SELECTED DATE RANGE.",!! G DONE
 S SC="" F J=0:0 S SC=$O(^TMP($J,SC)) Q:SC=""  S DATA=^(SC),CO=$P(DATA,"^"),CA=$P(DATA,"^",2),TOT=CO+CA,CAT=CAT+CA,COT=COT+CO W !,?3,$S(SC="zz":"NOT SPECIFIED",1:SC),?35,$J(CO,5,0),?47,$J(CA,5,0) W:TOT ?61,$J(TOT,5,0),?71,$J((100*CA/TOT),5,1)
 W !?35 F J=1:1:45 W "-"
 W !?10,"TOTAL",?35,$J(COT,5,0),?47,$J(CAT,5,0) S TOT=COT+CAT W:TOT ?61,$J(TOT,5,0),?71,$J(100*CAT/TOT,5,1)
DONE W:$E(IOST)="P" @IOF D ^%ZISC
END K %,%H,%I,%DT,%ZIS,CA,CAT,CO,COT,DATA,ECBD,ECD,ECD0,ECED,J,LN,PGCT,POP,SC,SPP,TOT,X,Y,ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTSK,^TMP($J) I IO="" S IOP="HOME" D ^%ZIS
 Q
 ;
GET ;
 S SC="zz",SPP=+$P(DATA,"^",4) I $D(^DIC(45.3,SPP,0)),$P(^(0),"^",2)]"" S SC=$P(^(0),"^",2) I $E(SC,2,200)["(" S SC=$P(SC,"(")
 S X=0
 I $D(^SRF(ECD0,.2)),$P(^(.2),"^",12) S X=1
 I $D(^SRF(ECD0,30)),^(30)]"" S X=2
 Q:'X
 ;X=1 FOR COMPLETED, 2 FOR CANCELLED
 I '$D(^TMP($J,SC)) S ^(SC)=""
 S $P(^TMP($J,SC),"^",X)=$P(^TMP($J,SC),"^",X)+1
 Q
 ;
QUE S ZTRTN="DEQ^ECTDSUR",(ZTSAVE("ECBD"),ZTSAVE("ECED"))="",ZTDESC="Surgery Workload",ZTIO=ION D ^%ZTLOAD G END
