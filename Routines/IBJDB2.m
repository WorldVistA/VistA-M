IBJDB2 ;ALB/RB - REASONS NOT BILLABLE REPORT (INPUT);19-JUN-00
 ;;2.0;INTEGRATED BILLING;**123,185**;21-MAR-94
 ;
 ; - Sort by division.
 S IBSD=$$SDIV^IBJD() I IBSD["^" G ENQ
 ;
GDR ; - Get specific date range.
 W !!,"Run report for (D)ATE ENTERED or (E)PISODE DATE: D// "
 R X:DTIME G:'$T!(X["^") ENQ S X=$S(X="":"D",1:$E(X))
 I "DdEe"'[X D HELP1 G GDR
 S IBD=$S("Dd"[X:"DATE ENTERED",1:"EPISODE DATE") W " ",IBD
 S DIR(0)="DA^:DT:EX",DIR("A")="   Start with "_IBD_": ",DIR("T")=DTIME
 D ^DIR K DIR G:$D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) ENQ
 S IBBDT=+Y K DIROUT,DTOUT,DUOUT,DIRUT
 S DIR(0)="DA^"_IBBDT_":DT:EX"
 S DIR("A")="        Go to "_IBD_": ",DIR("T")=DTIME
 D ^DIR K DIR G:$D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) ENQ
 S IBEDT=+Y K DIROUT,DTOUT,DUOUT,DIRUT
 ;
 ; - Get ALL/Specific reasons not billable.
 D ALSP^IBJD("Reasons Not Billable^Reason Not Billable","^IBE(356.8,",.IBSRNB)
 I IBSRNB["^" G ENQ
 ;
 ; - Get ALL/Specific Providers
 D ALSP^IBJD("Providers^Provider","^VA(200,",.IBSPRV)
 I IBSPRV["^" G ENQ
 ;
DS ; - Select a detailed or summary report.
 D DS^IBJD G:IBRPT["^" ENQ
 ;
SEL ; - Select episode to print.
 S IBPRT="Choose which episode to print:"
 K IBEPS
 S IBEPS(1)="INPATIENT"
 S IBEPS(2)="OUTPATIENT"
 S IBEPS(3)="PROSTHETICS"
 S IBEPS(4)="PHARMACY"
 S IBEPS(5)="ALL RECEIVABLES"
 S IBSEL=$$MLTP^IBJD(IBPRT,.IBEPS,1) I 'IBSEL G ENQ
 ;
 ; - Get ALL/Specific Inpatient Specialties
 I IBSEL["1" D  I IBSISP["^" G ENQ
 . D ALSP^IBJD("Inpatient Specialties^Inpatient Specialty","^DIC(45.7,",.IBSISP)
 ;
 ; - Get ALL/Specific Outpatient Specialties
 I IBSEL["2" D  I IBSOSP["^" G ENQ
 . D ALSP^IBJD("Outpatient Specialties^Outpatient Specialty","^DIC(40.7,",.IBSOSP)
 ;
 I IBRPT="S" G DEV
 ;
RPS ; - Sort by RNB category/specialty/provider, if necessary.
 S IBSORT="R" G:IBSEL'[1&(IBSEL'[2) EXCEL
 W !!,"Sort report by (R)NB CATEGORY, (P)ROVIDER, or (S)PECIALTY: R// "
 R X:DTIME G:'$T!(X["^") ENQ S X=$S(X="":"R",1:$E(X))
 I "RrPpSs"'[X D HELP2 G RPS
 W " ",$S("Pp"[X:"PROVIDER","Ss"[X:"SPECIALTY",1:"RNB CATEGORY")
 S IBSORT=X
 ;
EXCEL ; - Determine whether to gather data for Excel report.
 S IBEXCEL=$$EXCEL^IBJD() G ENQ:IBEXCEL="^"
 ;
DEV ; - Select a device.
 I '$G(IBEXCEL) D
 . S X=$S(IBRPT="S":80,1:132)
 . W !!,"You will need a ",X," column printer for this report!",!
 . W !,"Note: This report may take a while to run. You should  queue it"
 . W !,"      to run after normal business hours.",!
 ;
 I $G(IBEXCEL) D EXMSG^IBJD
 ;
 S %ZIS="QM" D ^%ZIS G:POP ENQ
 I $D(IO("Q")) D  G ENQ
 .S ZTRTN="DQ^IBJDB2",ZTDESC="IB - REASONS NOT BILLABLE REPORT"
 .F I="IB*","IBSRNB(","VAUTD","VAUTD(" S ZTSAVE(I)=""
 .D ^%ZTLOAD
 .I $D(ZTSK) W !!,"This job has been queued. Task number is "_ZTSK_"."
 .E  W !!,"Unable to queue this job."
 .K I,IO("Q"),ZTSK D HOME^%ZIS
 ;
 U IO
 ;
DQ ; - Tasked entry point.
 ;
 ; If called by the Extraction Module, change extract status for the 4
 ; reports: Reasons not Billable Inpatient, Outpatient, Prosthetics and 
 ; Pharmacy.
 I $G(IBXTRACT) F I=25:1:36 D E^IBJDE(I,1)
 ;
 D ^IBJDB21 ; Compile and print report.
 ;
ENQ K ^TMP("IBJDB2",$J)
 I $D(ZTQUEUED) S ZTREQ="@" G ENQ1
 D ^%ZISC
ENQ1 K IBBDT,IBCLK,IBD,IBEDT,IBEPD,IBEPS,IBEXCEL,IBPRT,IBRPT,IBSD,IBSEL
 K IBSORT,IBSISP,IBSOSP,IBSPRV,IBSRNB
 K POP,VAUTD,ZTDESC,ZTRTN,ZTSAVE,%ZIS,I,X,Y,%
 Q
 ;
HELP1 ; - 'Run report by (D)ATE ENTERED...' prompt.
 W !!?6,"Enter: '<CR>' - To enter a DATE ENTERED range for the report"
 W !?16,"'E' - To enter a EPISODE DATE range for the report"
 W !?16,"'^' - To quit this option"
 Q
 ;
HELP2 ; - 'Sort report by (R)NB CATEGORY...' prompt.
 W !!?6,"Enter: '<CR>' - To sort detail report by RNB category"
 W !?16,"'P' - To sort detail report by provider"
 W !?16,"'S' - To sort detail report by specialty"
 W !?16,"'^' - To quit this option"
 Q
