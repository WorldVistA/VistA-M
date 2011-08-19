IBTOUR3 ;ALB/AAS - CLAIMS TRACKING UR ACTIVITY REPORT PRINT ; 02-DEC-93
 ;;Version 2.0 ; INTEGRATED BILLING ;**56**; 21-MAR-94
 ;
INS ; -- print the report
 Q:IBQUIT
 D HDR,MAIN
 Q:IBQUIT
 I $O(IBCNT(3,0)) D RNB Q:IBQUIT
 I $D(^TMP($J,"IBTOUR1")) D ISPEC^IBTOUR Q:IBQUIT
 I 'IBQUIT,$E(IOST,1,2)="C-" W ! D PAUSE^VALM1 Q:$D(DIRUT)
 Q
 ;
HOSP Q:IBQUIT
 D HDR,HOSPRV
 Q:IBQUIT
 I $D(^TMP($J,"IBTOUR2")) D HSPEC^IBTOUR Q:IBQUIT
 I 'IBQUIT,$E(IOST,1,2)="C-" W ! D PAUSE^VALM1 Q:$D(DIRUT)
 Q
 ;
MAIN ; -- print main body of report
 W !?((IOM/2+6)-16),"Total Admissions: ",$J(IBCNT(1),10)
 W !?((IOM/2+6)-24),"Total Admissions to NHCU: ",$J(+$G(IBCNT(1,1)),10)
 W !?((IOM/2+6)-31),"Total Admissions to Domiciliary: ",$J(+$G(IBCNT(1,2)),10)
 W !?((IOM/2+6)-34),"Total Admissions Requiring Reviews: ",$J(IBCNT(4),10)
 W !?((IOM/2+6)-33),"Number of Scheduled Adm. Reviewed: ",$J(IBCNT(11),10)
 ;
 W !!?((IOM/2+6)-31),"Total Admissions with Insurance: ",$J(IBCNT(2),10)
 W !?((IOM/2+6)-25),"Total Billable Admissions: ",$J(+$G(IBCNT(3,0)),10)
 ;
 I $E(IOST,1,2)="C-" W ! D PAUSE^VALM1 W:'$D(DIRUT) @IOF I $D(DIRUT) S IBQUIT=1 Q
 ;
 W !!?((IOM/2+6)-33),"Cases with Pre-Cert and Follow-up: ",$J(IBCNT(5),10)
 W !?((IOM/2+6)-32),"Cases with Pre-Cert no Follow-up: ",$J(IBCNT(6),10)
 ;
 W !?((IOM/2+6)-22),"Number of Closed Cases: ",$J(IBCNT(7),10)
 W !?((IOM/2+6)-31),"Number of Billable Closed Cases: ",$J(IBCNT(7,0),10)
 W !?((IOM/2+6)-33),"Number of Unbillable Closed Cases: ",$J(IBCNT(7,1),10)
 ;
 W !!?((IOM/2+6)-30),"Number of New Cases Still Open: ",$J(IBCNT(8),10)
 W !!?((IOM/2+6)-24),"Number of Previous Cases: ",$J(IBCNT(9),10)
 W !?((IOM/2+6)-44),"Number of Previous Cases Closed and Billable: ",$J(IBCNT(9,0),10)
 W !?((IOM/2+6)-45),"Number of Previous Cases Closed, not Billable: ",$J(IBCNT(9,1),10)
 W !?((IOM/2+6)-35),"Number of Previous Cases still Open: ",$J(IBCNT(9,2),10)
 ;
 W !!?((IOM/2+6)-35),"Number of Outpatient Cases Reviewed: ",$J(IBCNT(10),10)
 ;
 Q
 ;
RNB ; -- print reasons not billable
 D CNT(4)
 W !!!?((IOM/2+6)-26),"Reason Not Billable Report:  Reason                   Count"
 W !?((IOM/2+6)-26),"---------------------------  ------------------------------"
 S I=0 F  S I=$O(IBCNT(3,I)) Q:'I  D
 .W !?((IOM/2)+9),$E($P($G(^IBE(356.8,+I,0)),"^")_"               ",1,22)
 .W ?((IOM/2)+31)," ",$J(IBCNT(3,I),6)
 Q
 ;
HDR ; -- print report header
 W:$E(IOST,1,2)["C-"!(IBPAG>0) @IOF
 W !?((IOM-22)/2),"UR ACTIVITY SUMMARY REPORT"
 W !?((IOM-18)/2),"for "_$S($D(IBHDRL):IBHDRL_" Reviews")
 D SITE^IBAUTL S IBSNM=$S($D(^DIC(4,IBFAC,0)):$P(^(0),"^"),1:"")
 W !?((IOM-($L(IBSNM)+6))/2),IBSNM_" ("_IBSITE_")"
 W !!?(IOM-18/2),"From: " S Y=IBBDT D DT^DIQ
 W !?((IOM-16)/2),"To: " S Y=IBEDT D DT^DIQ
 W !!?(IOM-26/2),"Date Printed: ",IBHDT
 S IBPAG=IBPAG+1 W !?(IOM-8/2),"Page: ",IBPAG
 W !?(IOM-26/2),"--------------------------",!!
 Q
 ;
CHK ; -- check task man stop flag
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1 D HDR W !!,"....task stopped at user request."
 Q
 ;
CNT(N) ; -- see if enought room on page for list
 Q:'$G(N)
 S (IBC,I)=0 F  S I=$O(IBCNT(N,I)) Q:'I  S IBC=IBC+1
 I IOSL<($Y+IBC+3),$E(IOST,1,2)="C-" D PAUSE^VALM1 S:$D(DIRUT) IBQUIT=1 W:'IBQUIT @IOF Q
 I IOSL<($Y+IBC+3) D HDR
 Q
 ;
HOSPRV ; -- Hospital Review Summary
 W !?((IOM/2+6)-16),"Total Admissions: ",$J(IBCNT(1),10)
 W !?((IOM/2+6)-24),"Total Admissions to NHCU: ",$J(+$G(IBCNT(1,1)),10)
 W !?((IOM/2+6)-31),"Total Admissions to Domiciliary: ",$J(+$G(IBCNT(1,2)),10)
 W !!?((IOM/2+6)-20),"Total Cases Reviewed: ",$J(+$G(IBCNT(40)),10)
 W !?((IOM/2+6)-29),"Number of New Case Still Open: ",$J(IBCNT(41),10)
 W !?((IOM/2+6)-24),"Number of Previous Cases: ",$J(IBCNT(42),10)
 W !?((IOM/2+6)-35),"Number of Previous Cases still Open: ",$J(IBCNT(43),10)
 ;
 I $E(IOST,1,2)="C-" W ! D PAUSE^VALM1 W:'$D(DIRUT) @IOF I $D(DIRUT) S IBQUIT=1 Q
 ;
 W !!?((IOM/2+6)-25),"Total Random Sample Cases: ",$J(IBCNT(44),10)
 W !?((IOM/2+6)-29),"Total Special Condition Cases: ",$J(+$G(IBCNT(45)),10)
 W !?((IOM/2+6)-4),"COPD: ",$J(+$G(IBCNT(45,2)),10)
 W !?((IOM/2+6)-4)," CVD: ",$J(+$G(IBCNT(45,3)),10)
 W !?((IOM/2+6)-4),"TURP: ",$J(+$G(IBCNT(45,1)),10)
 W !?((IOM/2+6)-25),"Total Locally Added Cases: ",$J(IBCNT(46),10)
 ;
 W !!?((IOM/2+6)-36),"Total Cases Meeting Criteria on Adm.: ",$J(+$G(IBCNT(47)),10)
 W !,?((IOM/2+6)-37),"Total Cases Not Meeting Crit. on Adm.: ",$J(+$G(IBCNT(51)),10)
 ;
 W !!?((IOM/2+6)-19),"Total Days Reviewed: ",$J(+$G(IBCNT(48)),10)
 W !?((IOM/2+6)-27),"Total Days Meeting Criteria: ",$J(IBCNT(49),10)
 W !?((IOM/2+6)-31),"Total Days Not Meeting Criteria: ",$J(+$G(IBCNT(50)),10)
 Q
