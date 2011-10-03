IBJDF4 ;ALB/RB - FIRST PARTY FOLLOW-UP REPORT ;15-APR-00
 ;;2.0;INTEGRATED BILLING;**123,204,220**;21-MAR-94
 ; 
EN ; - Option entry point.
 S IBEXCEL=0
 ;
 ; - Select AR categories to print.
 S IBPRT="Choose which type of receivables to print:"
 K IBOPT
 S IBOPT(1)="EMERGENCY/HUMANITARIAN"
 S IBOPT(2)="INELIGIBLE"
 S IBOPT(3)="C-MEANS TEST & RX COPAY"
 S IBOPT(4)="LONG TERM CARE COPAY"
 S IBOPT(5)="ALL OF THE ABOVE"
 S IBSEL=$$MLTP^IBJD(IBPRT,.IBOPT,1) I 'IBSEL G ENQ
 ;
STA ; - Choose bill status.
 W !!,"Run report for (A)CTIVE ARs, (S)USPENDED ARs, or (B)OTH: B// "
 R X:DTIME G:'$T!(X["^") ENQ S:X="" X="B" S X=$E(X)
 I "AaBbSs"'[X S IBOFF=1 D HELP^IBJDF4H G STA
 S IBSTA=$S("Aa"[X:"A","Ss"[X:"S",1:"B")
 W "  ",$S(IBSTA="A":"ACTIVE",IBSTA="S":"SUSPENDED",1:"BOTH")
 ;
 ; - Select a detailed or summary report.
 D DS^IBJD G ENQ:IBRPT["^"
 I IBRPT="S" D  G RC
 . S IBSN="N",IBSNA="ALL",IBSNF="",IBSNL="zzzzz",IBSMN="A"
 ;
 ; - Determine sorting (By name or Last 4 SSN)
 S IBSN=$$SNL^IBJD() G ENQ:IBSN="^"
 ;
 ; - Determine the range
 S X=$$INTV^IBJD("PATIENT "_$S(IBSN="N":"NAME",1:"LAST 4")) G ENQ:X="^"
 S IBSNF=$P(X,"^",1),IBSNL=$P(X,"^",2),IBSNA=$P(X,"^",3)
 ;
AGE ; - Determine if the active receivable must be within an age range.
 W !!,"Include (A)LL ",$S(IBSTA="A":"active ",IBSTA="S":"suspended ",1:""),"ARs or those within an AGE (R)ANGE: ALL// "
 R X:DTIME G:'$T!(X["^") ENQ S:X="" X="A" S X=$E(X)
 I "ARar"'[X S IBOFF=9 D HELP^IBJDF4H G AGE
 S IBSMN=$S("Rr"[X:"R",1:"A") W "  ",$S(IBSMN="R":"RANGE",1:"ALL")
 I IBSMN="A" G AMT
 ;
 ; - Determine the active receivable age range.
 W !,"EXAMPLE Range: 31-60 days"
 S DIR(0)="NA^1:99999"
 S DIR("A")="Enter the minimum age of the receivable: "
 S DIR("T")=DTIME,DIR("?")="^S IBOFF=16 D HELP^IBJDF4H"
 D ^DIR K DIR G:$D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) ENQ
 S IBSMN=+Y W "   ",IBSMN," DAYS" K DIROUT,DTOUT,DUOUT,DIRUT
 ;
 S DIR(0)="NA^"_IBSMN_":99999"
 S DIR("A")="Enter the maximum age of the receivable: "
 S DIR("B")=IBSMN,DIR("T")=DTIME,DIR("?")="^S IBOFF=21 D HELP^IBJDF4H"
 D ^DIR K DIR G:$D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) ENQ
 S IBSMX=+Y W "   ",IBSMX," DAYS" K DIROUT,DTOUT,DUOUT,DIRUT
 ;
AMT ; - Print receivables with a minimum balance.
 S DIR(0)="Y",DIR("B")="NO" W !
 S DIR("A")="Print receivables with a minimum balance"
 S DIR("T")=DTIME,DIR("?")="^S IBOFF=26 D HELP^IBJDF4H"
 D ^DIR K DIR G:$D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) ENQ
 S IBSAM=+Y K DIROUT,DTOUT,DUOUT,DIRUT G:'IBSAM EXCEL
 ;
AMT1 ; - Determine the minimum balance amount.
 S DIR(0)="NA^1:9999999"
 S DIR("A")="Enter the minimum balance amount of the receivable: "
 S DIR("T")=DTIME,DIR("?")="^S IBOFF=33 D HELP^IBJDF4H"
 D ^DIR K DIR G:$D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) ENQ
 S IBSAM=+Y K DIROUT,DTOUT,DUOUT,DIRUT
 ;
EXCEL ; - Determine whether to gather data for Excel report.
 S IBEXCEL=$$EXCEL^IBJD() G ENQ:IBEXCEL="^"
 I IBEXCEL S IBSH=1,IBSH1="M" G RC
 ;
BCH ; - Determine whether to include the bill comment history.
 S DIR(0)="Y",DIR("B")="NO" W !
 S DIR("A")="Include the bill comment history with each receivable"
 S DIR("T")=DTIME,DIR("?")="^S IBOFF=38 D HELP^IBJDF4H"
 D ^DIR K DIR G:$D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) ENQ
 S IBSH=+Y K DIROUT,DTOUT,DUOUT,DIRUT G:'IBSH RC
 ;
 S DIR(0)="SA^A:ALL;M:MOST RECENT"
 S DIR("A")="Print (A)LL comments or the (M)OST RECENT comment: "
 S DIR("B")="ALL",DIR("T")=DTIME,DIR("?")="^S IBOFF=47 D HELP^IBJDF4H"
 D ^DIR K DIR G:$D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) ENQ
 S IBSH1=Y K DIROUT,DTOUT,DUOUT,DIRUT G:IBSH1="A" RC
 ;
 S DIR(0)="NAO^1:999"
 S DIR("A")="Minimum age of most recent bill comment (optional): "
 S DIR("T")=DTIME,DIR("?")="^S IBOFF=54 D HELP^IBJDF4H"
 D ^DIR K DIR G:$D(DTOUT)!$D(DUOUT)!$D(DIROUT) ENQ
 S IBSH2=+Y W:IBSH2 " days" K DIROUT,DTOUT,DUOUT
 ;
RC ; - Include receivables referred to Regional Counsel?
 S DIR(0)="Y",DIR("B")="NO",DIR("T")=DTIME W !
 S DIR("A")="Include ARs referred to Regional Counsel"
 S DIR("?")="^S IBOFF=61 D HELP^IBJDF4H"
 D ^DIR K DIR G:$D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) ENQ
 S IBSRC=+Y K DIROUT,DTOUT,DUOUT,DIRUT
 ;
DEV ; - Select a device.
 I '$G(IBEXCEL) D
 . W !!,"Note: This report will search through all "
 . W $S(IBSTA="A":"active",IBSTA="S":"suspended",1:"active & suspended")," receivables."
 . W !?6,"It is recommended that you queue it to run after normal business hours."
 ;
 I $G(IBEXCEL) D EXMSG^IBJD
 ;
 W ! S %ZIS="QM" D ^%ZIS G:POP ENQ
 I $D(IO("Q")) D  G ENQ
 .S ZTRTN="DQ^IBJDF4",ZTDESC="IB - FIRST PARTY FOLLOW-UP REPORT"
 .S ZTSAVE("IB*")="" D ^%ZTLOAD
 .I $G(ZTSK) W !!,"This job has been queued. The task no. is ",ZTSK,"."
 .E  W !!,"Unable to queue this job."
 .K ZTSK,IO("Q") D HOME^%ZIS
 ;
 U IO
 ;
 ; If called by the Extraction Module, change extract status for the  5
 ; reports: Emergency/Humanitarian, Ineligible receivables, C-Means Test,
 ;          RX Copay/SC VET and RX Copay/NSC VET
DQ I $G(IBXTRACT) F I=12:1:16 D E^IBJDE(I,1)
 ;
 D ST^IBJDF41 ;   Compile and print the report.
 ;
ENQ K IBSEL,IBSN,IBSNF,IBSNL,IBOFF,IBSNA,IBSH,IBSH1,IBSH2,IBSAM,IBSRC,IBTEXT
 K IBI,IBOPT,IBPRT,IBSTA,IBEXCEL,IBRPT,IBSMN,IBSMX,POP,DIROUT,DTOUT,DUOUT
 K DIRUT,%ZIS,ZTDESC,ZTRTN,ZTSAVE,I,X,Y
 Q
