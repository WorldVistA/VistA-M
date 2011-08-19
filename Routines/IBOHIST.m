IBOHIST ;ALB/EMG - HISTORY OF CHARGES ON HOLD REPORT ; FEB 25 1997
 ;;2.0; INTEGRATED BILLING ;**70**; 21-MAR-94
 ;
EN ;
 ;***
 D HOME^%ZIS W @IOF,!!,"History of Charges ON HOLD Report",!
 ;
 N DIRUT,DUOUT,DTOUT,IBDATE,Y
 W !!?6,"This report uses the date the IB Action was created to determine"
 W !?6,"whether it should be included in the count and amount totals."
 W !?6,"Please enter the starting date for this report.  The date should"
 W !?6,"be after 6/1/96 or when patch IB*2.0*70 was installed at your"
 W !?6,"facility since this report only counts charges with an ON HOLD"
 W !?6,"DATE defined.  You can also type '^' to exit.",!
 ;
 S DIR(0)="DA^2960601:NOW:EX",DIR("A")="Start with DATE: "
 S DIR("?")="Enter the starting date for this report. (No earlier than 6/1/96)"
 D ^DIR K DIR G:$D(DIRUT) END S IBSDT=+Y
 S DIR(0)="DA^"_+Y_":NOW:EX",DIR("A")="     Go to DATE: ",DIR("?")="Enter the ending date for this report." D ^DIR K DIR G:$D(DIRUT) END S IBEDT=+Y
 ;
DEV S %ZIS="QM",%ZIS("A")="Output Device: " D ^%ZIS G:POP END
 I $D(IO("Q")) S ZTRTN="DQ^IBOHIST",ZTDESC="IB History of Charges on hold Report",ZTSAVE("IB*")="" D ^%ZTLOAD K IO("Q"),ZTSK G END
 U IO
 ;***
 W !!
 ;
DQ ;  -entry from tasked job
 ;***
 ;
 ;  -gross count of statuses, total charges
 ;  -^tmp($j,"ib",ibstatus,"gcnt")=count
 ;   ^tmp($j,"ib",ibstatus,"gtot")=sum of charges
 ;
 K ^TMP($J)
 S IBEDT=IBEDT+.24
 S IBDT=IBSDT+.000001 F  S IBDT=$O(^IB("D",IBDT)) Q:IBDT=""!(IBDT>IBEDT)  S IBN="" F  S IBN=$O(^IB("D",IBDT,IBN)) Q:IBN=""  D
 .S IBND=^IB(IBN,0) Q:'IBND
 .S IBSTAT=$S($D(^IBE(350.21,+$P(IBND,"^",5),0)):$P(^(0),"^"),1:"UNKNOWN")
 .S IBOH=$P($G(^IB(IBN,1)),"^",6) Q:'IBOH
 .S:'$D(^TMP($J,"IB",IBSTAT,"GCNT")) ^("GCNT")=0 S ^("GCNT")=^("GCNT")+1
 .S:'$D(^TMP($J,"IB",IBSTAT,"GTOT")) ^("GTOT")=0 S ^("GTOT")=^("GTOT")+$P(IBND,"^",7)
 .Q
 ;
 D PRINT W !
 G END
 ;
 ;
PRINT ;  -output data
 S IBQUIT=0,IBPAG=0,Y=DT D D^DIQ S IBHDT=Y D HDR
 W !!?((IOM-34)/2),"TOTALS BY CURRENT STATUS OF CHARGE",!
 ;
 S IBSTAT=0 F  S IBSTAT=$O(^TMP($J,"IB",IBSTAT)) Q:IBSTAT=""!(IBQUIT)  D LINE
 Q
 ;
LINE ;
 I $Y>(IOSL-5) D PAUSE^IBOUTL Q:IBQUIT  D HDR
 W !!,"Current Status: ",IBSTAT
 ;W !,"--------------------------"
 W !?5,"NUMBER ENTRIES: ",$J($S($D(^TMP($J,"IB",IBSTAT,"GCNT")):^("GCNT"),1:0),9)
 W !?5,"DOLLAR AMOUNT: $",$J($S($D(^TMP($J,"IB",IBSTAT,"GTOT")):^("GTOT"),1:0),9,2)
 Q
 ;
HDR ;
 W:$E(IOST,1,2)["C-"!(IBPAG>0) @IOF
 W !?((IOM-26)/2),"History of Charges ON HOLD"
 W !?((IOM-3)/2),"for"
 D SITE^IBAUTL S IBSNM=$S($D(^DIC(4,IBFAC,0)):$P(^(0),"^"),1:"")
 W !?((IOM-($L(IBSNM)+6))/2),IBSNM_" ("_IBSITE_")"
 W !?((IOM-54)/2),"Charges created between ",$$DAT2^IBOUTL(IBSDT)," and ",$P($$DAT2^IBOUTL(IBEDT),"@")
 W !!?(IOM-26/2),"Date Printed: ",IBHDT
 S IBPAG=IBPAG+1 W !?(IOM-8/2),"Page: ",IBPAG
 W !?(IOM-26/2),"--------------------------"
 Q
 ;
 ;
END K ^TMP($J)
 ;***
 I $D(ZTQUEUED) S ZTREQ="@" Q
 K DFN,DIRUT,DUOUT,DTOUT,IBDT,IBHDT,IBDATE,IBOH,IBSDT,IBEDT,IBPAG,IBSNM,IBST,IBSTAT,IBFAC,IBSITE,IBN,IBND,IBQUIT,POP,ZTDESC,ZTQUEUED,ZTREQ,ZTRTN,ZTSAVE,X,Y
 D ^%ZISC
 Q
 ;end ibohist
