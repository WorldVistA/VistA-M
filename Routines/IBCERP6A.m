IBCERP6A ;ALB/JEH - READY FOR EXTRACT LIST MANAGER REPORT ;27-OCT-99
 ;;2.0;INTEGRATED BILLING;**137**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN ; - Ask device
 N %ZIS,ZTRTN,ZTSAVE,ZTDESC
 S %ZIS="QM" D ^%ZIS G:POP ENQ1
 I $D(IO("Q")) D  G ENQ1
 .S ZTRTN="LIST^IBCERP6A",ZTDESC="IB - EDI/MRA Claims in Rescue Process"
 .S ZTSAVE("IBPARAM")="",ZTSAVE("^TMP(""IBCERP6"",$J,")=""
 .D ^%ZTLOAD
 .W !!,$S($D(ZTSK):"Your task number"_ZTSK_" has been queued.",1:"Unable to queue this job.")
 .K ZTSK,IO("Q") D HOME^%ZIS
 U IO
 ;
LIST ; - Tasked entry point
 ;
 ;
 S (IBQUIT,IBPG)=0 D HDR
 I '$D(^TMP("IBCERP6",$J)) W !!,"There are no records to print" G ENQ1
 S IBSTAT="" F  S IBSTAT=$O(^TMP("IBCERP6",$J,IBSTAT)) Q:IBSTAT=""!(IBQUIT)  D
 .S IBILL="" F  S IBILL=$O(^TMP("IBCERP6",$J,IBSTAT,IBILL)) Q:IBILL=""!(IBQUIT)  S IBREC=^(IBILL)  D
 ..I ($Y+5)>IOSL D  I IBQUIT Q
 ...D ASK I IBQUIT Q
 ...D HDR
 ..;
 ..W !,?2,$P(IBREC,U,2),?15,$P(IBREC,U,3),?22,$P(IBREC,U,4)
 ..W ?28,$E($P(IBREC,U,5),1,4),?35,$P(IBREC,U,6),?40,$E($P(IBREC,U,7),6,7)_"/"_$E($P(IBREC,U,7),4,5)_"/"_$E($P(IBREC,U,7),2,3)
 ..W ?50,$P(IBREC,U,8),?55,$E($P(IBREC,U,9),1,13),?70,$E($P(IBREC,U,10),1,9)
 I $D(ZTQUEUED) S ZTREQ="@"
 ;
 I '$D(ZTQUEUED) D ^%ZISC
ENQ1 K IBSTAT,IBILL,IBREC,IBPG,IBQUIT
 Q
HDR ;Prints report heading
 I $E(IOST,1,2)="C-" W @IOF,*13
 S IBPG=IBPG+1
 W !!,?25,"Claims in Rescue Process",?55,$$FMTE^XLFDT(DT),?70,"Page: ",IBPG
 W !!,?15,"Inpt/",?22,"Inst/",!,?4,"Bill #",?15,"Opt",?22,"Prof",?28,"Name"
 W ?35,"SSN",?40,"Stmt Date",?50,"Type",?55,"Ins Co.",?70,"Status"
 W !,$TR($J("",IOM)," ","=")
 Q
 ;
ASK ;
 I $E(IOST,1,2)'["C-" Q
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="E" D ^DIR
 I ($D(DIRUT))!($D(DUOUT)) S IBQUIT=1 Q
 Q
 ;
