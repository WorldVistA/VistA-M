IBTOTR ;ALB/AAS - CLAIMS TRACKING INQUIRY ; 27-OCT-93
 ;;2.0; INTEGRATED BILLING ;**40,199**; 21-MAR-94
 ;
% I '$D(DT) D DT^DICRW
 W !!,"Claims Tracking Inquiry"
 ;
PAT ; -- Select patient
 W !! D END
 S DIC="^DPT(",DIC(0)="AEQM"
 N DPTNOFZY S DPTNOFZY=1  ;Suppress PATIENT file fuzzy lookups
 D ^DIC K DIC I +Y<1 G END
 S DFN=+Y
 ;
VSIT ;
 ; -- get claims tracking visit entry
 D TRAC^IBTRV K IBY
 I '$G(IBTRN) G END
 ;
DEV ; -- select device, run option
 W !
 S %ZIS="QM" D ^%ZIS G:POP END
 I $D(IO("Q")) S ZTRTN="DQ^IBTOTR",ZTSAVE("IB*")="",ZTSAVE("DFN")="",ZTDESC="IB - Inquire to Claims Tracking" D ^%ZTLOAD K IO("Q"),ZTSK D HOME^%ZIS G PAT
 ;
 U IO
 D ONE,END G PAT
 Q
 ;
END ; -- Clean up
 I $D(ZTQUEUED) S ZTREQ="@" Q
 D ^%ZISC
 K I,J,X,Y,DFN,%ZIS,VA,IBTRN,IBTRND,IBTRND1,IBPAG,IBHDT,IBDISDT,IBETYP,IBQUIT,IBTAG,IBI,IBJ,IBII,IBTRTP,IBNAR,IBCNT
 D KVAR^VADPT
 Q
 ;
DQ ; -- entry print from task man
 D ONE G END
 Q
 ;
ONE ; -- print one billing report from ct
 I $D(ZTQUEUED) S ZTREQ="@"
 S IBPAG=0,IBHDT=$$HTE^XLFDT($H,1),IBQUIT=0
 D PID^VADPT
 S IBTRND=$G(^IBT(356,+IBTRN,0)),IBTRND1=$G(^(1))
 S IBETYP=$G(^IBE(356.6,+$P(IBTRND,"^",18),0))
 D HDR,SECT1^IBTOBI
 W ! D BI1^IBTOBI1,CLIN
 ;
 I ($Y+11)>IOSL D HDR Q:IBQUIT
 W !!,"  Insurance Review Information "
 N I,J,IBTRC,IBTRCD,IBD,IBACTION,TCODE
 S IBCNT=0
 S IBII="" F  S IBII=$O(^IBT(356.2,"ATIDT",IBTRN,IBII)) Q:'IBII!(IBQUIT)  S IBTRC=0 F  S IBTRC=$O(^IBT(356.2,"ATIDT",IBTRN,IBII,IBTRC)) Q:'IBTRC!(IBQUIT)  D
 .N IBD
 .S IBCNT=IBCNT+1
 .D IR1^IBTOBI2
 .D IR2^IBTOBI2
 .S IBJ=0 F  S IBJ=$O(IBD(IBJ)) Q:'IBJ  W !,$E($G(IBD(IBJ,1)),1,39),?40,$E($G(IBD(IBJ,2)),1,39)
 .W !
 .I ($Y+9)>IOSL D HDR Q:IBQUIT
 I IBCNT<1 W !,"None on file.",!
 ;
 I ($Y+11)>IOSL D HDR Q:IBQUIT
 W !,"  Hospital Review Information "
 N I,J,IBTRV,IBTRVD,IBD
 S IBCNT=0
 S IBII="" F  S IBII=$O(^IBT(356.1,"ATIDT",IBTRN,IBII)) Q:'IBII!(IBQUIT)  S IBTRV=0 F  S IBTRV=$O(^IBT(356.1,"ATIDT",IBTRN,IBII,IBTRV)) Q:'IBTRV!(IBQUIT)  D
 .N IBD
 .S IBCNT=IBCNT+1
 .D HR1^IBTOBI3
 .D HR2^IBTOBI3
 .; Patch #40 pick up Special Unit SI or IS
 .D UNIT^IBTOBI3
 .S IBJ=0 F  S IBJ=$O(IBD(IBJ)) Q:'IBJ  W !,$E($G(IBD(IBJ,1)),1,40),?40,$E($G(IBD(IBJ,2)),1,39)
 .W !
 .I ($Y+9)>IOSL D HDR Q:IBQUIT
 I IBCNT<1 W !,"None on file.",!
 Q
 ;
HDR ; -- Print header for billing report
 Q:IBQUIT
 I $E(IOST,1,2)="C-",IBPAG D PAUSE^VALM1 I $D(DIRUT) S IBQUIT=1 Q
 I $E(IOST,1,2)="C-"!(IBPAG) W @IOF
 S IBPAG=IBPAG+1
 W !,"Claim Tracking Inquiry",?(IOM-33),"Page ",IBPAG,"  ",IBHDT
 W !,$E($P($G(^DPT(DFN,0)),"^"),1,25),?28,VA("PID"),?50,"DOB: ",$$FMTE^XLFDT($P($G(^DPT(DFN,0)),"^",3),1)
 W !,$$EXPAND^IBTRE(356,.18,$P(IBTRND,"^",18))," on ",$$FMTE^XLFDT($P(IBTRND,"^",6),1)
 W !,$TR($J(" ",IOM)," ","-")
 Q
 ;
CLIN ; -- output clinical information
 N IBOE,DGPM
 ;
 I $P(IBETYP,"^",3)=1 S DGPM=$P(^IBT(356,+IBTRN,0),"^",5) I 'DGPM Q
 I $P(IBETYP,"^",3)=2 S IBOE=$P(^IBT(356,+IBTRN,0),"^",4)
 F IBTAG="DIAG","PROC","PROV" D @IBTAG Q:IBQUIT
 Q
 ;
DIAG ; -- print diagnosis information
 I '$G(DGPM),('$G(IBOE)) Q
 Q:$P(IBETYP,"^",3)>2
 I ($Y+9)>IOSL D HDR Q:IBQUIT
 D DIAG1^IBTOBI4
 Q
 ;
PROC ; -- print procedure information
 Q:$P(IBETYP,"^",3)>2
 I ($Y+9)>IOSL D HDR Q:IBQUIT
 D PROC1^IBTOBI4
 Q
 ;
PROV ; -- print provider information
 I '$G(DGPM),('$G(IBOE)) Q
 Q:$P(IBETYP,"^",3)>2
 I ($Y+9)>IOSL D HDR Q:IBQUIT
 D PROV1^IBTOBI4
 Q
