IBOHTOT ;ALB/EMG - COUNT/AMT OF CHARGES ON HOLD REPORT ; FEB 25 1997
 ;;2.0; INTEGRATED BILLING ;**70**; 21-MAR-94
 ;
EN ;
 ;***
 D HOME^%ZIS W @IOF,!!,"Count and Dollar Amount of Charges ON HOLD Report",!!
 ;
DEV S %ZIS="QM",%ZIS("A")="Output Device: " D ^%ZIS G:POP END
 I $D(IO("Q")) S ZTRTN="DQ^IBOHTOT",ZTDESC="IB Count/Amt Report",ZTSAVE("IB*")="" D ^%ZTLOAD K IO("Q"),ZTSK G END
 U IO
 ;***
 W !!
 ;
DQ ;  -entry from tasked job
 ;***
 K ^TMP($J)
 S DFN=0 F  S DFN=$O(^IB("AH",DFN)) Q:'DFN  S IBN=0 F  S IBN=$O(^IB("AH",DFN,IBN)) Q:'IBN  I $D(^IB(IBN,0)) D DATA
 ;
 D PRINT W !
 D TPRINT W !
 G END
 ;
DATA ;  -gross count of action types, total charges
 ;  -^tmp($j,"ib",ibaction type,"gcnt")=count
 ;  -^tmp($j,"ib",ibaction type,"gtot")=sum of charges
 ;  -^tmp($j,"ibtot","fcnt")=final count of entries
 ;  -^tmp($j,"ibtot","ftot")=final sum of charges
 ;
 S IBND=^IB(IBN,0)
 S IBATYP=$S($D(^IBE(350.1,+$P(IBND,"^",3),0)):$P(^(0),"^"),1:"UNKNOWN")
 S:'$D(^TMP($J,"IB",IBATYP,"GCNT")) ^("GCNT")=0 S ^("GCNT")=^("GCNT")+1
 S:'$D(^TMP($J,"IB",IBATYP,"GTOT")) ^("GTOT")=0 S ^("GTOT")=^("GTOT")+$P(IBND,"^",7)
 S:'$D(^TMP($J,"IBTOT","FCNT")) ^("FCNT")=0 S ^("FCNT")=^("FCNT")+1
 S:'$D(^TMP($J,"IBTOT","FTOT")) ^("FTOT")=0 S ^("FTOT")=^("FTOT")+$P(IBND,"^",7)
 Q
 ;
 ;
PRINT ;  -output data
 S IBQUIT=0,IBPAG=0,Y=DT D D^DIQ S IBHDT=Y D HDR
 W !!?((IOM-25)/2),"TOTALS BY ACTION TYPE"
 ;
 S IBATYP="" F IBT=0:0 S IBATYP=$O(^TMP($J,"IB",IBATYP)) Q:IBATYP=""!(IBQUIT)  D LINE
 Q
 ;
TPRINT ; -grand total of data
 I $Y>(IOSL-5) D PAUSE^IBOUTL Q:IBQUIT  D HDR
 W !!,?(IOM-26/2),"**************************"
 W !,?((IOM/2)-20),"TOTAL NUMBER OF ENTRIES: ",$J($S($D(^TMP($J,"IBTOT","FCNT")):^("FCNT"),1:0),13)
 W !,?((IOM/2)-20),"    TOTAL DOLLAR AMOUNT: $",$J($S($D(^TMP($J,"IBTOT","FTOT")):^("FTOT"),1:0),12,2)
 Q
 ;
LINE ;
 I $Y>(IOSL-5) D PAUSE^IBOUTL Q:IBQUIT  D HDR
 W !!?((IOM/2)-$L($P(IBATYP," ",2,99))),$P(IBATYP," ",2,99)
 W !?((IOM/2)-12),"NUMBER ENTRIES: ",$J($S($D(^TMP($J,"IB",IBATYP,"GCNT")):^("GCNT"),1:0),9)
 W !?((IOM/2)-12),"DOLLAR AMOUNT: $",$J($S($D(^TMP($J,"IB",IBATYP,"GTOT")):^("GTOT"),1:0),9,2)
 Q
 ;
HDR ;
 W:$E(IOST,1,2)["C-"!(IBPAG>0) !,@IOF
 W ?((IOM-42)/2),"Count and Dollar Amount of Charges ON HOLD"
 W !?((IOM-3)/2),"for"
 D SITE^IBAUTL S IBSNM=$S($D(^DIC(4,IBFAC,0)):$P(^(0),"^"),1:"")
 W !?((IOM-($L(IBSNM)+6))/2),IBSNM_" ("_IBSITE_")"
 W !!?(IOM-26/2),"Date Printed: ",IBHDT
 S IBPAG=IBPAG+1 W !?(IOM-8/2),"Page: ",IBPAG
 W !?(IOM-26/2),"--------------------------"
 Q
 ;
END K ^TMP($J)
 ;***
 I $D(ZTQUEUED) S ZTREQ="@" Q
 K DFN,IBT,IBATYP,IBHDT,IBPAG,IBSNM,IBFAC,IBSITE,IBN,IBND,IBQUIT,POP,X,Y
 D ^%ZISC
 Q
