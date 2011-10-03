PSDCSL ;BIR/JPW-List Drug Name & Stats from DRUG file (#50) ; 29 Aug 94
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
 W !!,"This report lists Drug name, order unit, price per order unit, dispense unit,",!,"dispense units per order unit, and price per dispense unit.",!
 W !,"This report is designed for a 132 column format.",!!
DEV ;asks device and queueing information
 K %ZIS,IOP,IO("Q"),POP S %ZIS="QM",%ZIS("B")="" D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" G END
 I $D(IO("Q")) K IO("Q"),ZTIO,ZTSAVE,ZTDTH,ZTSK S ZTRTN="START^PSDCSL",ZTDESC="CS PHARM LIST DATA FOR DRUG STATS" D ^%ZTLOAD,HOME^%ZIS K ZTSK G END
 U IO
START ;compiles and prints data for report
 K ^TMP("PSDCSL",$J)
 S (PG,PSDOUT)=0,%DT="",X="T" D ^%DT X ^DD("DD") S RPDT=Y
 S PSD="" F  S PSD=$O(^PSDRUG("AIUN",PSD)) Q:PSD=""  F NUM=0:0 S NUM=$O(^PSDRUG("AIUN",PSD,NUM)) Q:'NUM  I $D(^PSDRUG(NUM,0)) D
 .S OK=$S('$D(^PSDRUG(PSD,"I")):1,'+^("I"):1,+^("I")>DT:1,1:0) Q:'OK
 .S PSDRN=$S($P(^PSDRUG(NUM,0),"^")]"":$P(^(0),"^"),1:"ZZ #"_NUM_" DRUG NAME MISSING")
 .I '$D(^PSDRUG(NUM,660)) S (ORU,ORUP,ORD,ORDP,ORDU)="NO DATA"
 .I $D(^PSDRUG(NUM,660)) S NODE=^PSDRUG(NUM,660),ORU=+$P(NODE,"^",2),ORU=$S(ORU:$P($G(^DIC(51.5,ORU,0)),"^"),1:"NO DATA"),ORUP=$S($P(NODE,"^",3)]"":$P(NODE,"^",3),1:"NO DATA") D
 ..S ORD=$S($P(NODE,"^",5)]"":$P(NODE,"^",5),1:"NO DATA"),ORDP=$S($P(NODE,"^",6)]"":$P(NODE,"^",6),1:"NO DATA"),ORDU=$S($P(NODE,"^",8)]"":$P(NODE,"^",8),1:"NO DATA")
 .S ^TMP("PSDCSL",$J,PSDRN,NUM)=ORU_"^"_ORUP_"^"_ORDU_"^"_ORD_"^"_ORDP
PRINT ;prints data from ^tmp
 K LN S $P(LN,"-",132)="" D HEADER
 I '$D(^TMP("PSDCSL",$J)) W !!,?30,"NO DATA FOR THE DRUG FILE STATS REPORT!!",!! G DONE
 S PSD="" F  S PSD=$O(^TMP("PSDCSL",$J,PSD))  Q:PSD=""!(PSDOUT)  D:$Y+5>IOSL HEADER F NUM=0:0 S NUM=$O(^TMP("PSDCSL",$J,PSD,NUM)) Q:'NUM!(PSDOUT)  D
 .W !,?2,PSD
 .S NODE=$G(^TMP("PSDCSL",$J,PSD,NUM)),ORU=$P(NODE,"^"),ORUP=$P(NODE,"^",2),ORDU=$P(NODE,"^",3),ORD=$P(NODE,"^",4),ORDP=$P(NODE,"^",5)
 .W ?47,$S(ORU="NO DATA":ORU,1:$J(ORU,4)),?61,$S(ORUP="NO DATA":ORUP,1:$J(ORUP,7)),?80,$S(ORDU="NO DATA":ORDU,1:$J(ORDU,6))
 .W ?100,$S(ORD="NO DATA":ORD,1:$J(ORD,6)),?120,$S(ORDP="NO DATA":ORDP,1:$J(ORDP,6))
 W !
DONE I $E(IOST)'="C" W @IOF
 I $E(IOST,1,2)="C-",'PSDOUT W ! K DIR,DIRUT S DIR(0)="EA",DIR("A")="END OF REPORT!  Press <RET> to return to the menu" D ^DIR K DIR
END ;
 K %DT,%ZIS,DA,DEA,DIR,DIROUT,DIRUT,DTOUT,DUOUT,LN,NODE,NUM,OK,ORD,ORDP,ORDU,ORU,ORUP,PG,POP,PSD,PSDRN,PSDOUT,RPDT,X,Y,ZTDESC,ZTIO,ZTRTN,ZTSK
 K ^TMP("PSDCSL",$J)
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
HEADER ;prints header information
 I $E(IOST,1,2)="C-",PG W ! K DA,DIR S DIR(0)="E" D ^DIR K DIR I 'Y S PSDOUT=1 Q
 W:$Y @IOF S PG=PG+1 W !,?45,"DRUG FILE STATS FOR CS PHARM DRUGS",!,?55,RPDT,?120,"PAGE: "_PG,!!
 W ?47,"ORDER",?59,"PRICE PER",?80,"DISPENSE",?97,"DISPENSE UNITS",?118,"PRICE PER"
 W !,"DRUG NAME",?47,"UNIT",?59,"ORDER UNIT",?82,"UNIT",?97,"PER ORDER UNIT",?118,"DISPENSE UNIT",!,LN,!
 Q
