IBJDU1 ;ALB/CPM - UTILIZATION WORKLOAD REPORT ; 24-DEC-96
 ;;Version 2.0 ; INTEGRATED BILLING ;**69**; 21-MAR-94
 ;
EN ; Option entry point.
 ;
 W !!,"This report provides a measure of the number of Insurance Reviews"
 W !,"which are conducted in the Medical Center.",!
 ;
 D DATE^IBOUTL I IBBDT=""!(IBEDT="") G ENQ
 ;
 W !!,"This report only requires an 80 column printer."
 ;
 W !!,"   Note:  This report may take a while to run."
 W !?10,"You should queue this report to run after normal business hours.",!
 ;
 ; - select a device
 S %ZIS="QM" D ^%ZIS G:POP ENQ
 I $D(IO("Q")) D  G ENQ
 .S ZTRTN="DQ^IBJDU1",ZTDESC="IB - UTILIZATION WORKLOAD REPORT"
 .F I="IBBDT","IBEDT" S ZTSAVE(I)=""
 .D ^%ZTLOAD
 .W !!,$S($D(ZTSK):"This job has been queued.  The task number is "_ZTSK_".",1:"Unable to queue this job.")
 .K ZTSK,IO("Q") D HOME^%ZIS
 ;
 U IO
 ;
DQ ; Tasked entry point.
 ;
 K IB F I=1:1:10 S IB(I)=0
 ;
 ; - count admissions within the user-specified date range
 S IBDT=IBBDT-.000000001,IBQ=0
 F  S IBDT=$O(^DGPM("AMV1",IBDT)) Q:'IBDT!(IBDT>(IBEDT+.24))  D  Q:IBQ
 .S DFN=0 F  S DFN=$O(^DGPM("AMV1",IBDT,DFN)) Q:'DFN  D  Q:IBQ
 ..S IBPM=0 F  S IBPM=$O(^DGPM("AMV1",IBDT,DFN,IBPM)) Q:'IBPM  D  Q:IBQ
 ...;
 ...I IBPM#100=0 S IBQ=$$STOP^IBOUTL("Utilization Workload Report") Q:IBQ
 ...;
 ...S IB(1)=IB(1)+1 ;                  total admissions
 ...;
 ...Q:'$$INSURED^IBCNS1(DFN,IBDT)
 ...;
 ...S IB(2)=IB(2)+1 ;                  insured admissions
 ...D ELIG^VADPT
 ...I VAEL(3) S IB(3)=IB(3)+1 Q  ;     insured SC admissions
 ...S IB(4)=IB(4)+1 ;                  insured NSC admissions
 ;
 I IBQ G ENQ
 ;
 ; - count insurance reviews
 K ^TMP("IBJDU1",$J)
 S IBDT=IBBDT-.000000001
 F  S IBDT=$O(^IBT(356.2,"B",IBDT)) Q:'IBDT!(IBDT>(IBEDT+.9))  D  Q:IBQ
 .S IBTRC=0 F  S IBTRC=$O(^IBT(356.2,"B",IBDT,IBTRC)) Q:'IBTRC  D  Q:IBQ
 ..;
 ..I IBTRC#100=0 S IBQ=$$STOP^IBOUTL("Utilization Workload Report") Q:IBQ
 ..;
 ..S IBTRCD=$G(^IBT(356.2,+IBTRC,0)) Q:IBTRCD=""
 ..S IBTRN=$P(IBTRCD,"^",2)
 ..Q:$P(IBTRCD,"^",19)<10  ;              review is not complete
 ..Q:'IBTRN  ;                            no corresponding CT entry
 ..S IBPM=$P($G(^IBT(356,IBTRN,0)),"^",5)
 ..Q:'IBPM  ;                             review not for an admission
 ..;
 ..; - get contact type
 ..S IBRTY=$P($G(^IBE(356.11,+$P(IBTRCD,"^",4),0)),"^",2)
 ..;
 ..; - appeals
 ..I IBRTY=60!(IBRTY=65) D  Q
 ...I '$D(^TMP("IBJDU1",$J,IBTRN)) S ^(IBTRN)="",IB(10)=IB(10)+1
 ..;
 ..; - admission reviews
 ..I IBRTY=10!(IBRTY=15)!(IBRTY=20) D  Q
 ...S IB(5)=IB(5)+1
 ...;
 ...; - count reviews where the entire admission was denied
 ...Q:'$P($G(^IBT(356.2,IBTRC,1)),"^",7)
 ...;
 ...S IB(7)=IB(7)+1
 ...S X=$G(^DGPM(IBPM,0)),Y=+$G(^DGPM(+$P(X,"^",17),0))\1
 ...S:'Y Y=DT
 ...S IB(9)=IB(9)+$$FMDIFF^XLFDT(Y,+X\1)
 ..;
 ..; - continued stay reviews
 ..I IBRTY=30 D
 ...S IB(6)=IB(6)+1
 ...;
 ...; - look at denials
 ...Q:$P($G(^IBE(356.7,+$P(IBTRCD,"^",11),1)),"^",3)'=20
 ...S IB(8)=IB(8)+1
 ...S X=$P(IBTRCD,"^",15),Y=$P(IBTRCD,"^",16) S:'Y Y=X
 ...I X S IB(9)=IB(9)+$$FMDIFF^XLFDT(Y,X)+1
 ;
 I IBQ G ENQ
 ;
 ; - print the reports
 S (IBPAG,IBQ)=0 D NOW^%DTC S IBRUN=$$DAT2^IBOUTL(%)
 D SUM
 ;
ENQ K ^TMP("IBJDU1",$J)
 I $D(ZTQUEUED) S ZTREQ="@" G ENQ1
 ;
 D ^%ZISC
ENQ1 K IB,IBQ,IBBDT,IBEDT,IBDT,IBPM,IBPAG,IBRUN,IBTRC,IBTRCD,IBTRN,IBRTY
 K %,%ZIS,DFN,IBPERI,IBPERS,POP,X,Y,VA,VAERR,VAEL,ZTDESC,ZTRTN,ZTSAVE
 Q
 ;
 ;
 ;
SUM ; Print the Summary Report.
 I $E(IOST,1,2)="C-" W @IOF,*13
 ;
 ; - print overall summary header
 W !!?30,"UTILIZATION WORKLOAD"
 W !?33,"SUMMARY REPORT"
 W !!?22,"For Reviews from ",$$DAT1^IBOUTL(IBBDT)," - ",$$DAT1^IBOUTL(IBEDT)
 W !!?24,"Run Date: ",IBRUN
 W !?24,$$DASH(31),!!
 ;
 ; - print overall summary statistics
 S IBPERI=$S('IB(1):0,1:$J(IB(2)/IB(1)*100,0,2))
 S IBPERS=$S('IB(2):0,1:$J(IB(3)/IB(2)*100,0,2))
 W ?21,"Total Number of Admissions:",?60,$J(IB(1),7)
 W !?6,"Total Number of Admissions with Insurance:",?60,$J(IB(2),7),"  (",IBPERI,"%)"
 W !?39,"SC:",?60,$J(IB(3),7),"  (",IBPERS,"%)"
 W !?38,"NSC:",?60,$J(IB(4),7),"  (",$J(100-IBPERS,0,2),"%)"
 ;
 W !!?7,"Total Number of Admission Reviews completed"
 W !?9,"on Insurance Patients (including pre-certifications):",?65,$J(IB(5),7)
 W !?13,"Total Number of Continued Stay Reviews completed:",?65,$J(IB(6),7)
 W !?5,"Total Number of Admission Denials by Insurance Companies:",?65,$J(IB(7),7)
 W !,"Total Number of Continued Stay Denials by Insurance Companies:",?65,$J(IB(8),7)
 W !?11,"Total Number of days denied by Insurance Companies:",?65,$J(IB(9),7)
 W !?31,"Total Number of Appealed Cases:",?65,$J(IB(10),7)
 ;
 D PAUSE
 Q
 ;
DASH(X) ; Return a dashed line.
 Q $TR($J("",X)," ","=")
 ;
PAUSE ; Page break
 Q:$E(IOST,1,2)'="C-"
 N IBX,DIR,DIRUT,DUOUT,DTOUT,DIROUT,X,Y
 F IBX=$Y:1:(IOSL-3) W !
 S DIR(0)="E" D ^DIR I $D(DIRUT)!($D(DUOUT)) S IBQ=1
 Q
