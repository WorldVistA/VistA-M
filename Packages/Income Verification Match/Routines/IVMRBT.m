IVMRBT ;ALB/CPM - IVM BILLING TRANSMISSION REPORT ; 13-JUN-94
 ;;Version 2.0 ; INCOME VERIFICATION MATCH ;; 21-OCT-94
 ;
EN ; Entry point to generate the IVM Billing Transmission Report.
 ;
 W !!,"This report will list all billing activity which has been, or will be,"
 W !,"transmitted to the IVM Center.  This includes Means Test charges for"
 W !,"patients who have changed categories due to IVM-verified Means Tests,"
 W !,"as well as claims to insurance companies for patients who have"
 W !,"insurance policies identified by the IVM Center."
 W !!,"Please note that this output requires 132 columns.  This report may not"
 W !,"run very quickly so you might choose to queue the report to a printer.",!
 ;
 S %ZIS="QM" D ^%ZIS G:POP ENQ
 I $D(IO("Q")) D  G ENQ
 .S ZTRTN="DQ^IVMRBT",ZTDESC="IVM - BILLING TRANSMISSION REPORT"
 .D ^%ZTLOAD W !!,$S($D(ZTSK):"This job has been queued as task #"_ZTSK_".",1:"Unable to queue this job.")
 .K ZTSK,IO("Q")
 ;
 U IO
 ;
DQ ; Tasked entry point.
 K ^TMP("IVMRBT",$J)
 S DFN=0 F  S DFN=$O(^IVM(301.61,"C",DFN)) Q:'DFN  S ^TMP("IVMRBT",$J,$P($$PT^IVMUFNC4(DFN),"^",1,2))=DFN
 ;
 ; - print out the report
 D NOW^%DTC S IVMHDRDT=$$DAT1^IVMUFNC4(%,1),IVMPAG=0,IVMQ=0 D HDR
 I '$D(^TMP("IVMRBT",$J)) W !!?25,"There have been no recorded transmissions of billing data to the IVM Center." G ENQ1
 ;
 S IVMNA="" F  S IVMNA=$O(^TMP("IVMRBT",$J,IVMNA)) Q:IVMNA=""!IVMQ  S DFN=^(IVMNA) D
 .W ! I $Y>(IOSL-5) D PAUSE Q:IVMQ  D HDR W !
 .W !,$E($P(IVMNA,"^"),1,25),?27,$E($P(IVMNA,"^",2),1,12)
 .;
 .S (IVMF,IVMTDA)=0 F  S IVMTDA=$O(^IVM(301.61,"C",DFN,IVMTDA)) Q:'IVMTDA!IVMQ  D
 ..I $Y>(IOSL-5),IVMF D PAUSE Q:IVMQ  D HDR W !!,$E($P(IVMNA,"^"),1,25),?27,$E($P(IVMNA,"^",2),1,14) S IVMF=0
 ..S IVMN=$G(^IVM(301.61,IVMTDA,0))
 ..W:IVMF !
 ..W ?40,$P(IVMN,"^")
 ..W ?52,$S($P(IVMN,"^",10)!$P(IVMN,"^",11):"*",1:"")
 ..W ?54,$$CLSF($P(IVMN,"^",3))
 ..W ?59,$$EXPAND^IVMUFNC(301.61,.04,$P(IVMN,"^",4))
 ..W ?70,$$DAT1^IVMUFNC4($P(IVMN,"^",5)),?80,$$DAT1^IVMUFNC4($P(IVMN,"^",6))
 ..W ?90,$$DAT1^IVMUFNC4($P(IVMN,"^",7))
 ..W ?100,$J($P(IVMN,"^",8),8,2)
 ..W ?110,$S($P(IVMN,"^",9):$J($P(IVMN,"^",9),8,2),$P(IVMN,"^",4)>1:" --N/A--",1:$J($P(IVMN,"^",9),8,2))
 ..W ?120,$S($P(IVMN,"^",13):$$DAT1^IVMUFNC4($P(IVMN,"^",13)),1:"Not Sent")
 ..W ?129,$$EXPAND^IVMUFNC(301.61,.14,+$P(IVMN,"^",14))
 ..S IVMF=1
 ;
 D:'IVMQ PAUSE
 ;
ENQ K ^TMP("IVMRBT",$J)
 I $D(ZTQUEUED) S ZTREQ="@" Q
 D ^%ZISC
 K IVMQ,IVMPAG,DIRUT,DUOUT,DTOUT,DIROUT,I,ZTDESC,ZTREQ,ZTRTN,ZTSAVE
ENQ1 Q
 ;
 ;
PAUSE ; Pause for screen output.
 Q:$E(IOST,1,2)'="C-"
 N IVMI,DIR,DIRUT,DIROUT,DUOUT,DTOUT
 F IVMI=$Y:1:(IOSL-3) W !
 S DIR(0)="E" D ^DIR I $D(DIRUT)!($D(DUOUT)) S IVMQ=1
 Q
 ;
HDR ; Display report header.
 N X,Y
 I $E(IOST,1,2)="C-"!(IVMPAG) W @IOF
 S IVMPAG=IVMPAG+1
 W !,"Run Date: ",IVMHDRDT,?50,"IVM BILLING TRANSMISSION REPORT",?121,"Page: ",IVMPAG
 W !!,$$DASH,!,?53,"Bill",?92,"Date",?103,"Amt",?113,"Amt",?122,"Date",?128,"Last"
 W !,"Patient Name",?27,"SSN",?40,"Ref #",?53,"Clsf",?59,"Bill Type",?70,"Bill From   -   To",?90,"Generated",?102,"Billed",?113,"Coll",?122,"Trans",?128,"Tran",!,$$DASH
 Q
 ;
DASH() ; Write dashed line.
 Q $TR($J("",132)," ","=")
 ;
CLSF(X) ; Return the bill classification.
 ;  Input:  X  --  Internal value of classification in #301.61
 ; Output:  I=Inpatient, O=Outpatient, R=Refill, P=Prosthetics
 Q $S('$G(X):"O",X=1:"I",X=2:"O",X=3:"R",X=4:"P",1:"O")
