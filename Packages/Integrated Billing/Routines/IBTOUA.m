IBTOUA ;ALB/AAS - CLAIMS TRACKING UNSCHEDULED ADMISSION REPORT ; 27-OCT-93
 ;;Version 2.0 ; INTEGRATED BILLING ;**20**; 21-MAR-94
 ;
% I '$D(DT) D DT^DICRW
 W !!,"Unscheduled Admissions Report"
 ;
DATE ; -- select date
 W !! D DATE^IBOUTL
 I IBBDT=""!(IBEDT="") G END
 ;
DEV ; -- select device, run option
 W !!,"You will need a 132 column printer for this report!",!
 S %ZIS="QM" D ^%ZIS G:POP END
 I $D(IO("Q")) S ZTRTN="DQ^IBTOUA",ZTSAVE("IB*")="",ZTDESC="IB - Unscheduled Admissions Report" D ^%ZTLOAD K IO("Q"),ZTSK D HOME^%ZIS G END
 ;
 U IO
 S X=132 X ^%ZOSF("RM")
DQ D PRINT G END
 Q
 ;
END ; -- Clean up
 K ^TMP($J) W !
 I $D(ZTQUEUED) S ZTREQ="@" Q
 D ^%ZISC
 K I,J,X,Y,DFN,%ZIS,VA,IBTRN,IBTRND,IBPAG,IBHDT,IBDT,IBBDT,IBEDT,IBQUIT
 Q
 ;
PRINT ; -- print one billing report from ct
 S IBPAG=0,IBHDT=$$HTE^XLFDT($H,1),IBQUIT=0
 K ^TMP($J)
 ;
 D FIX^IBTOSA
 S IBDT=IBBDT-.1
 F  S IBDT=$O(^IBT(356,"D",IBDT)) Q:'IBDT!(IBDT>(IBEDT+.24))!(IBQUIT)  S IBTRN=0 F  S IBTRN=$O(^IBT(356,"D",IBDT,IBTRN)) Q:'IBTRN!(IBQUIT)  S IBTRND=$G(^IBT(356,IBTRN,0)) D
 .Q:'$P(IBTRND,"^",20)  ; inactive
 .;Q:+IBDT<IBEDT
 .I $P(IBTRND,"^",5),$P(IBTRND,"^",7)'=1,$$INSURED^IBCNS1($P(IBTRND,"^",2),IBDT) D SET
 ;
PR D HDR
 I '$D(^TMP($J,"IBSCH")) W !!,"No Unscheduled Admission found in date range.",! Q
 S IBNAM="",IBCNT=0
 F  S IBNAM=$O(^TMP($J,"IBSCH",IBNAM)) Q:IBNAM=""!(IBQUIT)  S IBDT=0 F  S IBDT=$O(^TMP($J,"IBSCH",IBNAM,IBDT)) Q:'IBDT!(IBQUIT)  S IBTRN=0 F  S IBTRN=$O(^TMP($J,"IBSCH",IBNAM,IBDT,IBTRN)) Q:'IBTRN!(IBQUIT)  S IBTRND=^(IBTRN) D ONE
 ;
 Q:IBQUIT
 W !!,"------------------"
 W !,"TOTAL = ",IBCNT
 I $D(ZTQUEUED) G END
 Q
 ;
ONE ; -- Print one patients data
 Q:IBQUIT
 I IOSL<($Y+5) D HDR Q:IBQUIT
 S IBCNT=IBCNT+1
 S DFN=$P(IBTRND,"^",2) D PID^VADPT
 W !,$E(IBNAM,1,27),?30,VA("PID"),?45,$$DAT1^IBOUTL($P(IBTRND,"^",6),"2P")
 W ?66,$S('$P(IBTRND,"^",19):"YES",1:$E("NO - "_$P($G(^IBE(356.8,+$P(IBTRND,"^",19),0)),"^"),1,27))
 W ?100,$E($P($G(^DPT(DFN,.1)),"^"),1,12),?115,$E($$EXPAND^IBTRE(356,.07,$P(IBTRND,"^",7)),1,15)
 Q
 ;
HDR ; -- Print header for billing report
 Q:IBQUIT
 I $E(IOST,1,2)="C-",IBPAG D PAUSE^VALM1 I $D(DIRUT) S IBQUIT=1 Q
 I $E(IOST,1,2)="C-"!(IBPAG) W @IOF
 S IBPAG=IBPAG+1
 W !,"Unscheduled Admissions with Insurance",?(IOM-33),"Page ",IBPAG,"  ",IBHDT
 W !,"For Period beginning on ",$$DAT1^IBOUTL(IBBDT)," to ",$$DAT1^IBOUTL(IBEDT)
 W !,"Patient",?30,"Pt. ID",?45,"Adm. Date",?66,"Billable",?100,"Ward",?115,"Type"
 W !,$TR($J(" ",IOM)," ","-")
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1,IBQUIT=1 W !!,"....task stoped at user request"
 Q
 ;
SET ; -- set tmp array
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1,IBQUIT=1 D HDR W !!,"....task stoped at user request" Q
 S ^TMP($J,"IBSCH",$P(^DPT(+$P(IBTRND,"^",2),0),"^"),IBDT,IBTRN)=IBTRND
 Q
