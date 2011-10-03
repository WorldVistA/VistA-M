IBTUBV ;ALB/AAS - UNBILLED AMOUNTS - VIEW UNBILLED DATA ;29-SEP-94
 ;;2.0;INTEGRATED BILLING;**19,123,155**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
% ; - View unbilled amounts for the month.
 I '$D(IOF) D HOME^%ZIS
 W !!,"View unbilled amounts",!
 S %ZIS="QM" D ^%ZIS G:POP END
 I $D(IO("Q")) D  G END
 .S ZTRTN="DQ^IBTUBV",ZTSAVE("IB*")=""
 .S ZTDESC="IB - Unbilled View Unbilled Amounts"
 .D ^%ZTLOAD K IO("Q"),ZTSK D HOME^%ZIS
 ;
 U IO D DQ
 ;
END W ! I $D(ZTQUEUED) S ZTREQ="@" Q
 D ^%ZISC
 Q
 ;
DQ ; - Entry point when queued.
 N IBAVGI,IBAVGP,IBFL,IBHDT,IBPAG,IBQUIT,IBTMON,DA,ND,ND3,TAB,X,Y
 S IBHDT=$$HTE^XLFDT($H,1),(IBPAG,IBQUIT)=0
 D HDR S IBTMON="",TAB=40
 F  S IBTMON=$O(^IBE(356.19,"AIVDT",IBTMON)) Q:'IBTMON  D  Q:IBQUIT
 .S DA=-IBTMON,IBFL=1
 .I '$D(^IBE(356.19,DA,1)) D OLDV(DA) Q  ; No '1' node-print old report.
 .S ND=$P($G(^IBE(356.19,DA,1)),U,1,6)
 .;
 .; - Get average instutional amount.
 .S X1=$S('$P(ND,U,3):0,1:+ND/$P(ND,U,3))
 .S X2=$S('$P(ND,U):0,1:+$P(ND,U,2)/+ND),IBAVGI=$J(X1*X2,0,2)
 .;
 .; - Get average professional amount.
 .S X1=$S('$P(ND,U,6):0,1:+$P(ND,U,4)/$P(ND,U,6))
 .S X2=$S('$P(ND,U,4):0,1:+$P(ND,U,5)/$P(ND,U,4)),IBAVGP=$J(X1*X2,0,2)
 .;
 .S ND=$G(^IBE(356.19,DA,2))
 .S ND3=$G(^IBE(356.19,DA,3))
 .I $Y>(IOSL-7) D HDR Q:IBQUIT
 .W !?22,"Inpatient Care: ",$$MYR(DA)
 .W !?9,"Number of Unbilled Inpatient Cases: ",$J($P(ND,U,2)+ND,11)
 .W !?10,"Number of Unbilled MRA Admissions: ",$J($P(ND3,U,2)+ND3,11)
 .W !?4,"Average Inpt. Institutional Bill Amount: ",$J(IBAVGI,11,2)
 .W !?5,"Average Inpt. Professional Bill Amount: ",$J(IBAVGP,11,2)
 .W !?14,"Total Unbilled Inpatient Care: ",$J($P(ND,U,7),11,2)
 .W !?10,"Total MRA Unbilled Inpatient Care: ",$J($P(ND3,U,7),11,2),!
 .;
 .I $Y>(IOSL-7) D HDR Q:IBQUIT
 .W !?21,"Outpatient Care: ",$$MYR(DA)
 .W !?8,"Number of Unbilled Outpatient Cases: ",$J($P(ND,U,3),11)
 .W !?15,"Number of Unbilled CPT Codes: ",$J($P(ND,U,4)+$P(ND,U,5),11)
 .W !?11,"Number of MRA Unbilled CPT Codes: ",$J($P(ND3,U,4)+$P(ND3,U,5),11)
 .W !?13,"Total Unbilled Outpatient Care: ",$J($P(ND,U,8),11,2)
 .W !?9,"Total MRA Unbilled Outpatient Care: ",$J($P(ND3,U,8),11,2),!
 .;
 .I $Y>(IOSL-7) D HDR Q:IBQUIT
 .W !?23,"Prescriptions: ",$$MYR(DA)
 .W !?11,"Number of Unbilled Prescriptions: ",$J($P(ND,U,6),11)
 .W !?7,"Number of MRA Unbilled Prescriptions: ",$J($P(ND3,U,6),11)
 .W !?15,"Total Unbilled Prescriptions: ",$J($P(ND,U,9),11,2)
 .W !?11,"Total MRA Unbilled Prescriptions: ",$J($P(ND3,U,9),11,2),!
 ;
 I '$G(IBFL) W !!,"No Unbilled Amount information found."
 Q
 ;
OLDV(X) ; - Print old version of report if no '1' node of file #356.19 entry.
 S ND=$G(^IBE(356.19,X,0)) G:'$P(ND,U,16) OLDVQ
 I $Y>(IOSL-7) D HDR
 W !!?11,"Inpatient Care: ",$$MYR(X)
 W !?3,"Number of Unbilled Inpt. Cases: ",$J($P(ND,U,12),11)
 W !?8,"Average Inpt. Bill Amount: ",$J($P(ND,U,13),11,2)
 W !?9,"Total Inpatient Unbilled: ",$J($P(ND,U,12)*$P(ND,U,13),11,2)
 ;
 I $Y>(IOSL-7) D HDR
 W !!?11,"Outpatient Care: ",$$MYR(X)
 W !?3,"Number of Unbilled Opt. Cases: ",$J($P(ND,U,14),11)
 W !?9,"Average Opt. Bill Amount: ",$J($P(ND,U,15),11,2)
 W !?8,"Total Outpatient Unbilled: ",$J($P(ND,U,14)*$P(ND,U,15),11,2)
 ;
OLDVQ Q
 ;
HDR ; - Output header.
 I $E(IOST,1,2)="C-",IBPAG D PAUSE^VALM1 I $D(DIRUT) S IBQUIT=1 G HDRQ
 I $E(IOST,1,2)="C-"!(IBPAG) W @IOF
 S IBPAG=IBPAG+1
 W !,"Unbilled Amounts Report",?(IOM-33),"Page ",IBPAG,"  ",IBHDT
 W !,$TR($J(" ",IOM)," ","-")
 I $D(ZTQUEUED),$$S^%ZTLOAD D
 .S (IBQUIT,ZTSTOP)=1 W !!,"...task stopped at user request"
 ;
HDRQ Q
 ;
MYR(X) ; - Format month/year (MM/YY).
 Q $S('$G(X):"",1:$E(X,4,5)_"/"_$E(X,2,3))
