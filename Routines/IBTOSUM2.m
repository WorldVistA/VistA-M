IBTOSUM2 ;ALB/AAS - CLAIMS TRACKING BILLING INFORMATION PRINT ; 29-OCT-93
 ;;2.0;INTEGRATED BILLING;**118**;21-MAR-94
 ;
PRINT ; - Print the report.
 K X,X2,X3
 D HDR,MAIN,PENAL
 I $O(IBCNT(3,0)) D RNB
 I $O(IBCNT(10,0)) D APPROV
 I $O(IBCNT(20,0)) D DENIAL
 Q
 ;
MAIN ; - Print main body of report.
 S IBPER(1)=$J($S('IBCNT(2):0,1:IBCNT(2)/IBCNT(1)*100),0,2)
 S IBPER(2)=$J($S('IBCNT(3,0):0,1:+IBCNT(3,0)/IBCNT(1)*100),0,2)
 S IBPER(3)=$J($S('IBCNT(4):0,1:IBCNT(4)/IBCNT(1)*100),0,2)
 S IBPER(4)=$J($S('IBCNT(99):0,1:IBCNT(99)/IBCNT(1)*100),0,2)
 S IBPER(5)=$J($S('IBCNT(13):0,1:IBCNT(13)/IBCNT(1)*100),0,2)
 W !?((IOM/2)-16),"Total ",$S(IBSORT="A":"Admissions",1:"Discharges"),": ",$J(IBCNT(1),11)
 W !?((IOM/2)-31),"Total ",$S(IBSORT="A":"Admissions",1:"Discharges")," with Insurance: ",$J(IBCNT(2),11),"   (",IBPER(1),"%)"
 W !?((IOM/2)-25),"Total Billable ",$S(IBSORT="A":"Admissions",1:"Discharges"),": ",$J(+$G(IBCNT(3,0)),11),"   (",IBPER(2),"%)"
 ;
 W !?((IOM/2)-34),"Total ",$S(IBSORT="A":"Admissions",1:"Discharges")," Requiring Reviews: ",$J(IBCNT(4),11),"   (",IBPER(3),"%)"
 W !?((IOM/2)-25),"Total ",$S(IBSORT="A":"Admissions",1:"Discharges")," Reviewed: ",$J(IBCNT(99),11),"   (",IBPER(4),"%)"
 W !?((IOM/2)-39),"Total ",$S(IBSORT="A":"Admissions",1:"Discharges")," Reviewed-Multi Carrier: ",$J(IBCNT(13),11),"   (",IBPER(5),"%)"
 ;
 I $E(IOST,1,2)="C-" W ! D PAUSE^VALM1 Q:$D(DIRUT)  W @IOF
 ;
 W !!?((IOM/2)-18),"Total Reviews Done: ",$J(IBCNT(5),11)
 W !?((IOM/2)-23),"Number of Days Approved: ",$J(IBCNT(10),11)
 S X=IBCNT(11),X2="0$" D COMMA^%DTC
 W !?((IOM/2)-39),"Amount Collectible Approved for Billing: ",X
 ;
 W !!?((IOM/2)-21),"Number of Days Denied: ",$J(IBCNT(20),11)
 S X=IBCNT(21),X2="0$" D COMMA^%DTC
 W !?((IOM/2)-25),"Amount Denied for Billing: ",X
 ;
 W !!?((IOM/2)-20),"Total Cases Appealed: ",$J(IBCNT(80),11)
 W !?((IOM/2)-25),"Number of Initial Appeals: ",$J(IBCNT(81),11)
 W !?((IOM/2)-28),"Number of Subsequent Appeals: ",$J(IBCNT(82),11)
 ;
 Q
 ;
PENAL ; -- penalty codes; variable; external form
 ;   1; IBCNT(31);  NO PRE ADMISSION CERTIFICATION
 ;   2; IBCNT(32);  UNTIMELY PRE ADMISSION CERTIFICATION
 ;   3; IBCNT(33);  VA A NON-PROVIDER
 ;
 W !!!?((IOM/2)-14),"Penalty Report:  Number of cases              Dollars"
 W !?((IOM/2)-14),"---------------  ------------------------------------"
 W !?((IOM/2)-30),"No Pre Admission Certification: ",$J($P(IBCNT(31),U),10),"                   " S X=+$P(IBCNT(31),U,2),X3=9,X2="0$" D COMMA^%DTC W X
 W !?((IOM/2)-36),"Untimely Pre Admission Certification: ",$J($P(IBCNT(32),U),10),"                   " S X=+$P(IBCNT(32),U,2),X3=9,X2="0$" D COMMA^%DTC W X
 W !?((IOM/2)-17),"VA a Non-Provider: ",$J($P(IBCNT(33),U),10),"                   " S X=+$P(IBCNT(33),U,2),X3=9,X2="0$" D COMMA^%DTC W X
 Q
 ;
RNB ; -- print reasons not billable
 D CNT(3)
 W !!!?((IOM/2)-26),"Reason Not Billable Report:  Reason                Count"
 W !?((IOM/2)-26),"---------------------------  ------------------------------------"
 S I=0 F  S I=$O(IBCNT(3,I)) Q:'I  D
 .W !?((IOM/2)+3),$E($P($G(^IBE(356.8,+I,0)),U),1,20)
 .W ?((IOM/2)+24),$J(IBCNT(3,I),6)
 .W " (",$J(IBCNT(3,I)/IBCNT(3,"NB")*100,0,2),"%)"
 ;
 W !?((IOM/2)+23),"-------"
 W !?((IOM/2)+3),"Total:",?((IOM/2)+23),$J(IBCNT(3,"NB"),7)
 Q
 ;
 ;
DENIAL ; -- print days denied by specialty
 D CNT(20)
 W !!!?((IOM/2)-24),"Days Denied by Specialty:  Specialty         No. Days   Dollars"
 W !?((IOM/2)-24),"-------------------------  ------------------------------------"
 S I=0 F  S I=$O(IBCNT(20,I)) Q:'I  D
 .W !?((IOM/2)+3),$E($P($G(^DIC(45.7,+I,0)),U)_"       ",1,16)
 .W ?((IOM/2)+20)," ",$J(IBCNT(20,I),6)
 .S X=IBCNT(21,I),X2="0$" D COMMA^%DTC
 .W ?((IOM/2)+30)," ",X
 Q
 ;
 ;
APPROV ; -- print days approved by specialty
 D CNT(10)
 W !!!?((IOM/2)-26),"Days Approved by Specialty:  Specialty         No. Days   Dollars"
 W !?((IOM/2)-26),"---------------------------  ------------------------------------"
 S I=0 F  S I=$O(IBCNT(10,I)) Q:'I  D
 .W !?((IOM/2)+3),$E($P($G(^DIC(45.7,+I,0)),U)_"       ",1,16)
 .W ?((IOM/2)+20)," ",$J(IBCNT(10,I),6)
 .S X=IBCNT(11,I),X2="0$" D COMMA^%DTC
 .W ?((IOM/2)+30)," ",X
 ;
 Q
 ;
HDR ; -- print report header
 W:$E(IOST,1,2)["C-"!(IBPAG>0) @IOF
 W !?((IOM-22)/2),"MCCR/UR SUMMARY REPORT"
 W !?((IOM-3)/2),"for"
 D SITE^IBAUTL S IBSNM=$S($D(^DIC(4,IBFAC,0)):$P(^(0),U),1:"")
 W !?((IOM-($L(IBSNM)+6))/2),IBSNM_" ("_IBSITE_")"
 W !!?((IOM-14)/2),"for "_$S(IBSORT="A":"Admissions",1:"Discharges")
 W !?(IOM-18/2),"From: " S Y=IBBDT D DT^DIQ
 W !?((IOM-16)/2)," To: " S Y=IBEDT D DT^DIQ
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
