IBJDF5 ;ALB/RB - CHAMPVA/TRICARE FOLLOW-UP REPORT;15-APR-00
 ;;2.0;INTEGRATED BILLING;**123,185,240**;21-MAR-94
 ;
EN ; - Option entry point.
 ;
 ; - Select AR categories to print.
 S IBPRT="Choose which category of receivables to print:"
 K IBCTG
 S IBCTG(1)="TRICARE PATIENT"
 S IBCTG(2)="SHARING AGREEMENTS"
 S IBCTG(3)="TRICARE"
 S IBCTG(4)="TRICARE THIRD PARTY"
 S IBCTG(5)="CHAMPVA"
 S IBCTG(6)="CHAMPVA THIRD PARTY"
 S IBCTG(7)="ALL OF THE ABOVE"
 S IBSEL=$$MLTP^IBJD(IBPRT,.IBCTG,1) I 'IBSEL G ENQ
 ;
 S IBSD=0 I IBSEL="1," G TYP
 ;
 ; - Sort by division, if necessary.
 S IBSD=$$SDIV^IBJD() G:IBSD["^" ENQ G:'IBSD TYP
 ;
 ; - Issue prompt for division.
 I IBSD,IBSEL[1 D
 . W !!,"NOTE: Tricare Patient receivables will NOT be sorted"
 . W !?6,"by division!",!,*7
 ;
TYP ; - Select type of receivables to print.
 ; - Select AR categories to print.
 S IBPRT="Choose which type of receivables to print:"
 K IBTPR
 S IBTPR(1)="INPATIENT"
 S IBTPR(2)="OUTPATIENT"
 S IBTPR(3)="PHARMACY REFILL"
 S IBTPR(4)="ALL RECEIVABLES"
 S IBSEL1=$$MLTP^IBJD(IBPRT,.IBTPR,1) I 'IBSEL1 G ENQ
 ;
 ; - Select a detailed or summary report.
 D DS^IBJD G ENQ:IBRPT["^",DEV:IBRPT="S"
 ;
 ; - Determine sorting (By name or Last 4 SSN)
 S IBSN=$$SNL^IBJD() G ENQ:IBSN="^"
 ;
 ; - Determine the range
 S X=$$INTV^IBJD("PATIENT "_$S(IBSN="N":"NAME",1:"LAST 4")) G ENQ:X="^"
 S IBSNF=$P(X,"^",1),IBSNL=$P(X,"^",2),IBSNA=$P(X,"^",3)
 ;
AGE ; - Determine if the active receivable must be within an age range.
 W !!,"Include (A)LL active AR's or those within an AGE (R)ANGE: ALL// "
 R X:DTIME G:'$T!(X["^") ENQ S:X="" X="A" S X=$E(X)
 I "ARar"'[X S IBOFF=1 D HELP^IBJDF5H G AGE
 W "  ",$S("Rr"[X:"RANGE",1:"ALL")
 S IBSMN=$S("Rr"[X:"R",1:"A") G:IBSMN="A" AMT
 ;
 ; - Determine the active receivable age range.
 S DIR(0)="NA^1:99999"
 S DIR("A")="Enter the minimum age of the active receivable: "
 S DIR("T")=DTIME,DIR("?")="^S IBOFF=9 D HELP^IBJDF5H"
 D ^DIR K DIR G:$D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) ENQ
 S IBSMN=+Y W "   ",IBSMN," DAYS" K DIROUT,DTOUT,DUOUT,DIRUT
 ;
 S DIR(0)="NA^"_IBSMN_":99999"
 S DIR("A")="Enter the maximum age of the active receivable: "
 S DIR("B")=IBSMN,DIR("T")=DTIME,DIR("?")="^S IBOFF=14 D HELP^IBJDF5H"
 D ^DIR K DIR G:$D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) ENQ
 S IBSMX=+Y W "   ",IBSMX," DAYS" K DIROUT,DTOUT,DUOUT,DIRUT
 ;
AMT ; - Print receivables with a minimum balance.
 S DIR(0)="Y",DIR("B")="NO" W !
 S DIR("A")="Print receivables with a minimum balance"
 S DIR("T")=DTIME,DIR("?")="^S IBOFF=19 D HELP^IBJDF5H"
 D ^DIR K DIR G:$D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) ENQ
 S IBSAM=+Y K DIROUT,DTOUT,DUOUT,DIRUT G:'IBSAM EXCEL
 ;
AMT1 ; - Determine the minimum balance amount.
 S DIR(0)="NA^1:9999999"
 S DIR("A")="Enter the minimum balance amount of the receivable: "
 S DIR("T")=DTIME,DIR("?")="^S IBOFF=26 D HELP^IBJDF5H"
 D ^DIR K DIR G:$D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) ENQ
 S IBSAM=+Y K DIROUT,DTOUT,DUOUT,DIRUT
 ;
EXCEL ; - Determine whether to gather data for Excel report.
 S IBEXCEL=$$EXCEL^IBJD() I Y S (IBEXCEL,IBSH)=1,IBSH1="M" G DEV
 ;
BCH ; - Determine whether to include the bill comment history.
 S DIR(0)="Y",DIR("B")="NO" W !
 S DIR("A")="Include the bill comment history with each receivable"
 S DIR("T")=DTIME,DIR("?")="^S IBOFF=31 D HELP^IBJDF5H"
 D ^DIR K DIR G:$D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) ENQ
 S IBSH=+Y K DIROUT,DTOUT,DUOUT,DIRUT G:'IBSH DEV
 ;
 S DIR(0)="SA^A:ALL;M:MOST RECENT"
 S DIR("A")="Print (A)LL comments or the (M)OST RECENT comment: "
 S DIR("B")="ALL",DIR("T")=DTIME,DIR("?")="^S IBOFF=40 D HELP^IBJDF5H"
 D ^DIR K DIR G:$D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) ENQ
 S IBSH1=Y K DIROUT,DTOUT,DUOUT,DIRUT G:IBSH1="A" DEV
 ;
 S DIR(0)="NAO^1:999"
 S DIR("A")="Minimum age of most recent bill comment (optional): "
 S DIR("T")=DTIME,DIR("?")="^S IBOFF=47 D HELP^IBJDF5H"
 D ^DIR K DIR G:$D(DTOUT)!$D(DUOUT)!$D(DIROUT) ENQ
 S IBSH2=+Y W:IBSH2 " days" K DIROUT,DTOUT,DUOUT
 ;
DEV ; - Select a device.
 I '$G(IBEXCEL) D
 . S X=$S(IBRPT="S":80,1:132)
 . W !!,"You will need a ",X," column printer for this report!",!
 . W !,"Note: This report will search through all  active  receivables."
 . W !,"      You should  queue it to run after normal business hours.",!
 ;
 I $G(IBEXCEL) D EXMSG^IBJD
 ;
 W ! S %ZIS="QM" D ^%ZIS G:POP ENQ
 I $D(IO("Q")) D  G ENQ
 .S ZTRTN="DQ^IBJDF5",ZTDESC="IB - CHAMPVA/TRICARE FOLLOW-UP REPORT"
 .F I="IB*","VAUTD","VAUTD(" S ZTSAVE(I)=""
 .D ^%ZTLOAD
 .I $G(ZTSK) W !!,"This job has been queued. The task no. is ",ZTSK,"."
 .E  W !!,"Unable to queue this job."
 .K ZTSK,IO("Q") D HOME^%ZIS
 ;
 U IO
 ;
 ; If called by the Extraction Module, change extract status for the 6
 ; reports: Tricare Patient, Sharing Agreements, TRICARE, TRICARE 3rd 
 ;          Party, CHAMPVA and CHAMPVA 3rd Party
DQ I $G(IBXTRACT) F I=17:1:21 D E^IBJDE(I,1)
 ;
 D ST^IBJDF51 ;  Compile and print the report.
 ;
ENQ K IBSD,IBSEL,IBSEL1,IBSN,IBSNF,IBSNL,IBSNA,IBOFF,IBSH,IBSH1,IBSH2,IBSAM
 K IBPRT,IBCTG,IBRPT,IBTPR,IBSMN,IBSMX,IBTEXT,IBI,IBEXCEL,DIROUT,DTOUT
 K DTOUT,DIRUT,POP,VAUTD,%ZIS,ZTDESC,ZTRTN,ZTSAVE,I,X,Y
 Q
