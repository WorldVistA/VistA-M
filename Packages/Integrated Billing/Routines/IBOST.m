IBOST ;ALB/AAS - INTEGRATED BILLING STATISTICAL REPORT ; 8-MAR-91
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;
EN ;
 ;***
 ;S XRTL=$ZU(0),XRTN="IBOST-1" D T0^%ZOSV ;start rt clock
 D HOME^%ZIS W @IOF,*13,?20,"Integrated Billing Statistical Report"
 W !! D DATE^IBOUTL I IBEDT="" G END
DEV S %ZIS="QM",%ZIS("A")="Output Device: " D ^%ZIS G:POP END
 I $D(IO("Q")) S ZTRTN="DQ^IBOST",ZTDESC="IB Statistical Report",ZTSAVE("IB*")="" D ^%ZTLOAD K IO("Q"),ZTSK G END
 U IO
 ;***
 ;I $D(XRT0) S:'$D(XRTN) XRTN="IBOST" D T1^%ZOSV ;stop rt clock
 W !!
 ;
DQ ;  -entry from tasked job
 ;***
 ;S XRTL=$ZU(0),XRTN="IBOST-2" D T0^%ZOSV ;start rt clock
 K ^TMP($J)
 S IBN="" F IBDT=IBBDT:0 S IBDT=$O(^IB("D",IBDT)) Q:'IBDT!(IBDT>(IBEDT+.24))  F IBN=0:0 S IBN=$O(^IB("D",IBDT,IBN)) Q:'IBN  I $D(^IB(IBN,0)) D GROSS,NET:$P(^IB(IBN,0),"^",9)=IBN
 ;
 D PRINT W !
 G END
 ;
GROSS ;  -gross count of action types, total charges
 ;  -^tmp($j,"ib",ibaction type,"gcnt")=count
 ;   ^tmp($j,"ib",ibaction type,"gtot")=sum of charges
 ;
 S IBND=^IB(IBN,0)
 S IBATYP=$S($D(^IBE(350.1,+$P(IBND,"^",3),0)):$P(^(0),"^"),1:"UNKNOWN"),IBSEQNO=$S($D(^IBE(350.1,+$P(IBND,"^",3),0)):$P(^(0),"^",5),1:0)
 S:'$D(^TMP($J,"IB",IBSEQNO,IBATYP,"GCNT")) ^("GCNT")=0 S ^("GCNT")=^("GCNT")+1
 S:'$D(^TMP($J,"IB",IBSEQNO,IBATYP,"GTOT")) ^("GTOT")=0 S ^("GTOT")=^("GTOT")+$P(IBND,"^",7)
 Q
 ;
NET ; -net count of new actions that aren't cancelled
 ;  -^tmp($j,"ib",ibaction type,"ncnt")=net count
 ;   ^tmp($j,"ib",ibaction type,"ntot")=net total
 S IBLAST="",IBLDT=$O(^IB("APDT",IBN,"")) I +IBLDT F IBL=0:0 S IBL=$O(^IB("APDT",IBN,IBLDT,IBL)) Q:'IBL  S IBLAST=IBL
 Q:'IBLAST
 Q:'$D(^IB(IBLAST,0))
 S IBCHRG=$P(^IB(IBLAST,0),"^",7),IBSEQNOL=$S($D(^IBE(350.1,$P(^IB(IBLAST,0),"^",3),0)):$P(^(0),"^",5),1:"")
 S:IBSEQNOL=2 IBCHRG=0
 S:'$D(^TMP($J,"IB",IBSEQNO,IBATYP,"NTOT")) ^("NTOT")=0 S ^("NTOT")=^("NTOT")+(IBCHRG)
 S:'$D(^TMP($J,"IB",IBSEQNO,IBATYP,"NCNT")) ^("NCNT")=0 S ^("NCNT")=^("NCNT")+$S(IBSEQNOL=2:0,1:1)
 Q
 ;
PRINT ;  -output data
 S IBQUIT=0,IBPAG=0,Y=DT D D^DIQ S IBHDT=Y D HDR
 W !!?((IOM-25)/2),"NET TOTALS BY ACTION TYPE"
 F IBSEQNO=0:0 S IBSEQNO=$O(^TMP($J,"IB",IBSEQNO)) Q:'IBSEQNO!(IBQUIT)  S IBATYP="" F IBT=0:0 S IBATYP=$O(^TMP($J,"IB",IBSEQNO,IBATYP)) Q:IBATYP=""!(IBQUIT)  D NETLIN
 ;
 W !!?((IOM-27)/2),"GROSS TOTALS BY ACTION TYPE"
 F IBSEQNO=0:0 S IBSEQNO=$O(^TMP($J,"IB",IBSEQNO)) Q:'IBSEQNO!(IBQUIT)  S IBATYP="" F IBT=0:0 S IBATYP=$O(^TMP($J,"IB",IBSEQNO,IBATYP)) Q:IBATYP=""!(IBQUIT)  D LINE
 Q
 ;
LINE ;
 I $Y>(IOSL-5) D PAUSE^IBOUTL Q:IBQUIT  D HDR
 W !!?((IOM/2)-$L($P(IBATYP," ",2,99))),$P(IBATYP," ",2,99)
 W !?((IOM/2)-12),"NUMBER ENTRIES: ",$S($D(^TMP($J,"IB",IBSEQNO,IBATYP,"GCNT")):^("GCNT"),1:0)
 W !?((IOM/2)-12),"DOLLAR AMOUNT: $",$S($D(^TMP($J,"IB",IBSEQNO,IBATYP,"GTOT")):^("GTOT"),1:0)
 Q
 ;
NETLIN ;
 I $Y>(IOSL-5) D PAUSE^IBOUTL Q:IBQUIT  D HDR
 Q:'$D(^TMP($J,"IB",IBSEQNO,IBATYP,"NCNT"))
 W !!?((IOM/2)-$L($P(IBATYP," ",2,99))),$P(IBATYP," ",2,99)
 W !?((IOM/2)-12),"NUMBER ENTRIES: ",$S($D(^TMP($J,"IB",IBSEQNO,IBATYP,"NCNT")):^("NCNT"),1:0)
 W !?((IOM/2)-12),"DOLLAR AMOUNT: $",$S($D(^TMP($J,"IB",IBSEQNO,IBATYP,"NTOT")):^("NTOT"),1:0)
 Q
HDR ;
 W:$E(IOST,1,2)["C-"!(IBPAG>0) @IOF,*13
 W ?((IOM-37)/2),"INTEGRATED BILLING STATISTICAL REPORT"
 W !?((IOM-3)/2),"for"
 D SITE^IBAUTL S IBSNM=$S($D(^DIC(4,IBFAC,0)):$P(^(0),"^"),1:"")
 W !?((IOM-($L(IBSNM)+6))/2),IBSNM_" ("_IBSITE_")"
 W !!?(IOM-18/2),"From: " S Y=IBBDT D DT^DIQ
 W !?((IOM-16)/2),"To: " S Y=IBEDT D DT^DIQ
 W !!?(IOM-26/2),"Date Printed: ",IBHDT
 S IBPAG=IBPAG+1 W !?(IOM-8/2),"Page: ",IBPAG
 W !?(IOM-26/2),"--------------------------"
 Q
 ;
END K ^TMP($J)
 ;***
 ;I $D(XRT0) S:'$D(XRTN) XRTN="IBOST" D T1^%ZOSV ;stop rt clock
 I $D(ZTQUEUED) S ZTREQ="@" Q
 K DUOUT,IBT,IBBDT,IBEDT,IBATYP,IBSEQNO,IBHDT,IBPAG,IBSNM,IBFAC,IBSITE,IBSEQNOL,IBLAST,IBL,IBCHRG,IBDT,IBJ,IBLDT,IBN,IBND,IBQUIT,X,Y
 D ^%ZISC
 Q
