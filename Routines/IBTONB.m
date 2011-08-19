IBTONB ;ALB/AAS - CLAIMS TRACKING NOT BILLED REPORT ; 27-OCT-93
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;
% I '$D(DT) D DT^DICRW
 W !!,"Unbilled Care from Claims Tracking"
 ;
DATE ; -- select date
 W !! D DATE^IBOUTL
 I IBBDT=""!(IBEDT="") G END
 ;
DEV ; -- select device, run option
 W !
 S %ZIS="QM" D ^%ZIS G:POP END
 I $D(IO("Q")) S ZTRTN="DQ^IBTONB",ZTSAVE("IB*")="",ZTSAVE("DFN")="",ZTDESC="IB - Unbilled Care from Claims Tracking" D ^%ZTLOAD K IO("Q"),ZTSK D HOME^%ZIS G END
 ;
 U IO
 D DQ G END
 Q
 ;
END ; -- Clean up
 I $D(ZTQUEUED) S ZTREQ="@" Q
 D ^%ZISC
 K I,J,X,Y,DFN,%ZIS,VA,IBTRN,IBTRND,IBTRND1,IBPAG,IBHDT,IBDISDT,IBETYP,IBQUIT,IBTAG
 D KVAR^VADPT
 Q
DQ ; -- print one billing report from ct
 S IBPAG=0,IBHDT=$$HTE^XLFDT($H,1),IBQUIT=0
 W !!,"Not Done Yet"
 ;
 Q
 ;
HDR ; -- Print header for billing report
 Q:IBQUIT
 I $E(IOST,1,2)="C-",IBPAG D PAUSE^VALM1 I $D(DIRUT) S IBQUIT=1 Q
 I $E(IOST,1,2)="C-"!(IBPAG) W @IOF
 S IBPAG=IBPAG+1
 W !,"MCCR/UR ACTIVITY REPORT Report",?(IOM-33),"Page ",IBPAG,"  ",IBHDT
 W !,$TR($J(" ",IOM)," ","-")
 Q
 ;
 Q
PAT ; -- Select patient
 W !!
 S DIC="^DPT(",DIC(0)="AEQM"
 D ^DIC K DIC I +Y<1 G END
 S DFN=+Y
 ;
VSIT ;
 ; -- get claims tracking visit entry
 D TRAC^IBTRV
 I '$G(IBTRN) G END
