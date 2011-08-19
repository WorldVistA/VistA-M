IBTOSA ;ALB/AAS - CLAIMS TRACKING SCHEDULED ADMISSION REPORT ; 27-OCT-93
 ;;2.0;INTEGRATED BILLING;**62,124**;21-MAR-94
 ;
% I '$D(DT) D DT^DICRW
 W !!,"Scheduled Admissions Report"
 ;
DATE ; -- select date
 W !! D DATE^IBOUTL
 I IBBDT=""!(IBEDT="") G END
 ;
DEV ; -- select device, run option
 W !!,"You will need a 132 column printer for this report!",!
 S %ZIS="QM" D ^%ZIS G:POP END
 I $D(IO("Q")) S ZTRTN="DQ^IBTOSA",ZTSAVE("IB*")="",ZTDESC="IB - scheduled Admissions Report" D ^%ZTLOAD K IO("Q"),ZTSK D HOME^%ZIS G END
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
 S IBTSBDT=IBBDT-.1,IBTSEDT=IBEDT+.9 D EN^IBTRKR2
 K ^TMP($J)
 ;
 D FIX
 S IBDT=IBBDT-.1
 F  S IBDT=$O(^IBT(356,"D",IBDT)) Q:'IBDT!(IBDT>(IBEDT+.24))!(IBQUIT)  S IBTRN=0 F  S IBTRN=$O(^IBT(356,"D",IBDT,IBTRN)) Q:'IBTRN!(IBQUIT)  D
 .S IBTRND=$G(^IBT(356,IBTRN,0))
 .Q:'$P(IBTRND,"^",20)  ; inactive
 .Q:+IBDT<IBBDT
 .I $P($G(^IBE(356.6,+$P(IBTRND,"^",18),0)),"^",3)=1,$P(IBTRND,"^",7)=1,$$SCH(IBTRN) D
 .. I $$INSURED^IBCNS1($P(IBTRND,"^",2),IBDT)!$$BUFFER^IBCNBU1($P(IBTRND,"^",2)) D SET
 ;
PR D HDR
 I '$D(^TMP($J,"IBSCH")) W !!,"No Scheduled Admission found in date range",! Q
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
 W ?100,$E($P($G(^DPT(DFN,.1)),"^"),1,12),?115,$E($$EXPAND^IBTRE(356,.07,$P(IBTRND,"^",7)),1,11)
 I +$$BUFFER^IBCNBU1(DFN) W ?129,"YES"
 Q
 ;
HDR ; -- Print header for billing report
 Q:IBQUIT
 I $E(IOST,1,2)="C-",IBPAG D PAUSE^VALM1 I $D(DIRUT) S IBQUIT=1 Q
 I $E(IOST,1,2)="C-"!(IBPAG) W @IOF
 S IBPAG=IBPAG+1
 W !,"Scheduled Admissions with Insurance",?(IOM-33),"Page ",IBPAG,"  ",IBHDT
 W !,"For Period beginning on ",$$DAT1^IBOUTL(IBBDT)," to ",$$DAT1^IBOUTL(IBEDT)
 W !,"Patient",?30,"Pt. ID",?45,"Adm. Date",?66,"Billable",?100,"Ward",?115,"Type",?126,"Buffer"
 W !,$TR($J(" ",IOM)," ","-")
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1,IBQUIT=1 W !!,"....task stop* ed at user request" Q
 Q
 ;
SET ; -- set tmp array
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1,IBQUIT=1 D HDR W !!,"....task stop* ed at user request" Q
 S ^TMP($J,"IBSCH",$P(^DPT(+$P(IBTRND,"^",2),0),"^"),IBDT,IBTRN)=IBTRND
 Q
 ;
SCH(IBTRN) ; -- is patient either admitted or still scheduled
 ;
 N IBX,IBTRND S IBX=1
 S IBTRND=$G(^IBT(356,+IBTRN,0))
 I '$P(IBTRND,"^",32) G SCHQ
 I $P(IBTRND,"^",5) G SCHQ
 S X=$G(^DGS(41.1,+$P(IBTRND,"^",32),0)) I X=""!($P(X,"^",13)) D  S IBX=0
 .N DA,DR,DIC,DIE
 .S DIE="^IBT(356,",DR=".2////0;.32///@",DA=IBTRN
 .D ^DIE
SCHQ Q IBX
 ;
FIX ; -- find bad episode dates and fix
 S IBDT=DT
 F  S IBDT=$O(^IBT(356,"D",IBDT)) Q:'IBDT  S IBTRN=0 F  S IBTRN=$O(^IBT(356,"D",IBDT,IBTRN)) Q:'IBTRN  D F1(IBTRN)
 Q
 ;
F1(IBTRN) ; fix EPISODE DATE
 N IBDT,DA,DR,DIC,DIE
 Q:'$G(IBTRN)
 Q:$G(^IBT(356,+IBTRN,0))=""
 S IBDT=$P(^IBT(356,+IBTRN,0),"^",6)
 I +IBDT'=IBDT,$E(IBDT,$L(IBDT))=0 S IBDT=+IBDT,DA=IBTRN,DR=".06////"_IBDT,DIE="^IBT(356," D ^DIE
 Q
