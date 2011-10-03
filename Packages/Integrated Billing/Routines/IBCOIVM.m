IBCOIVM ;ALB/NLR - IVM BILLING ACTIVITY ; 28-APR-94
 ;;Version 2.0 ; INTEGRATED BILLING ;**6,62**; 21-MAR-94
 ;
EN ; Entry point to generate list of patients with policies identified
 ; through IVM Center, including total amounts billed and collected
 ;
 W !!?6,"This report will generate a list of patients who have policies"
 W !?6,"that were identified through the IVM Center.  For all bills"
 W !?6,"generated against these policies, individual and total amounts"
 W !?6,"billed and collected will be indicated.  If you are running"
 W !?6,"this report in your Production account, you will have the"
 W !?6,"opportunity to transmit this report to the IVM Center."
 ;
 ; Allow report transmittal if running in Production.
 S IBFLG=0 G:'$$PROD DEVICE
 ;
 W ! S DIR(0)="Y",DIR("B")="NO",DIR("A")="Would you like this report sent to the IVM Center",DIR("?")="^D HLPIVM^IBCOIVM"
 D ^DIR K DIR S IBFLG=+Y I $D(DIRUT)!($D(DUOUT)) G ENQ
 ;
DEVICE ; Select device for queueing/printing report
 W !!?6,"Please note that this output requires 132 columns.",!
 S %ZIS="QM" D ^%ZIS G:POP ENQ
 I $D(IO("Q")) D  G ENQ
 .S ZTRTN="^IBCOIVM1",ZTDESC="IB - IVM BILLING ACTIVITY",ZTSAVE("IBFLG")=""
 .D ^%ZTLOAD W !!,$S($D(ZTSK):"This job has been queued as task #"_ZTSK_".",1:"Unable to queue this job.")
 .K ZTSK,IO("Q") D HOME^%ZIS
 ;
 U IO D ^IBCOIVM1
 ;
ENQ ; Cleanup
 K DIRUT,DUOUT,DTOUT,DIROUT,I,IBFLG,ZTDESC,ZTREQ,ZTRTN,ZTSAVE
 Q
 ;
 ;
PROD() ; Is this the production account?     Output:  1 - YES,  0 - NO
 N X S X=$G(^XMB("NETNAME"))
 Q $L(X,".")=3!($L(X,".")=4&(X[".MED."))
 ;
HLPIVM ; Help for sending report to the IVM Center.
 W !!,"The IVM Center has identified insurance policies for a"
 W !,"large number of patients, and wishes to track amounts"
 W !,"billed and collected against these policies.  The data"
 W !,"will be compiled nationally and will assist the IVM Center"
 W !,"in meeting its goals.  Even if you are planning to transmit"
 W !,"a report to the IVM Center, you should run the report"
 W !,"once without transmitting to check the results.  You may"
 W !,"then re-run the report and transmit it to the IVM Center."
 Q
