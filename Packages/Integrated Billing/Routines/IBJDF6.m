IBJDF6 ;ALB/RB - MISCELLANEOUS BILLS FOLLOW-UP REPORT ;15-APR-00
 ;;2.0;INTEGRATED BILLING;**123,159**;21-MAR-94
 ;
EN ; - Option entry point.
 ;
SEL ; - Select type of receivables to print.
 K IBCTG S IBPRT="Choose which type of receivables to print:"
 S IBCTG(1)="MEDICARE"
 S IBCTG(2)="NO-FAULT AUTO ACCIDENT"
 S IBCTG(3)="TORT FEASOR"
 S IBCTG(4)="WORKMEN'S COMP"
 S IBCTG(5)="CURRENT EMPLOYEE"
 S IBCTG(6)="EX-EMPLOYEE"
 S IBCTG(7)="FEDERAL AGENCIES-REFUND"
 S IBCTG(8)="FEDERAL AGENCIES-REIMBURSEMENT"
 S IBCTG(9)="MILITARY"
 S IBCTG(10)="INTERAGENCY"
 S IBCTG(11)="VENDOR"
 S IBCTG(12)="ALL OF THE ABOVE"
 ;
 S IBSEL=$$MLTP^IBJD(IBPRT,.IBCTG,1) I 'IBSEL G ENQ
 S (IB0,IB1)=0
 F X=1:1 S Y=$P(IBSEL,",",X) Q:'Y  D
 . I Y=1!(Y=2)!(Y=3)!(Y=4) S IB0=1 Q
 . S IB1=1
 G ENQ:'IBSEL S IBSEL=","_IBSEL
 ;
 ; - Sort by division.
 S IBSDV=0 I IB0 S IBSDV=$$SDIV^IBJD() I IBSDV["^" G ENQ
 ;
 ; - Select a detailed or summary report.
 D DS^IBJD I IBRPT["^" G ENQ
 ;
 I IBSDV S IB2=0 F X=2:1 S Y=$P(IBSEL,",",X) Q:'Y  D:Y>4
 . I 'IB2 D  S IB2=1
 . . W !!,"NOTE: The receivables of these types will NOT be sorted by division:",!,*7
 . W !?6,IBCTG(Y)
 ;
 G DEV:IBRPT="S"
 ;
 ; - Determine sorting (By name or Last 4 SSN)
 S (IBSN,X)=""
 I IB0 D  I IBSN="^"!(X="^") G ENQ
 . S IBSN=$$SNL^IBJD() Q:IBSN="^"
 . W !!,"These receivables will be sorted by PATIENT/SSN:",!
 . F X=2:1 S Y=$P(IBSEL,",",X) Q:'Y  I Y<5 W !?6,IBCTG(Y)
 . ; - Determine the PATIENT range
 . S X=$$INTV^IBJD("PATIENT "_$S(IBSN="N":"NAME",1:"LAST 4")) Q:X="^"
 . S IBSNF=$P(X,"^",1),IBSNL=$P(X,"^",2),IBSNA=$P(X,"^",3)
 ;
 ; - Determine range of debtors.
 I 'IB1 G AGE
 ;
 I IB0 D
 . W !!,"These receivables will be sorted by DEBTOR:",!
 . F X=2:1 S Y=$P(IBSEL,",",X) Q:'Y  I Y>4 W !?6,IBCTG(Y)
 S VAUTD(0)=""
 ;
 ; - Determine the DEBTOR range
 S X=$$INTV^IBJD("DEBTOR") G ENQ:X="^"
 S IBSDF=$P(X,"^",1),IBSDL=$P(X,"^",2),IBSDA=$P(X,"^",3)
 ;
AGE ; - Determine if the active receivable must be within an age range.
 W !!,"Include (A)LL active AR's or those within an AGE (R)ANGE: ALL// "
 R X:DTIME G:'$T!(X["^") ENQ S:X="" X="A" S X=$E(X)
 I "ARar"'[X S IBOFF=1 D HELP^IBJDF6H G AGE
 W "  ",$S("Rr"[X:"RANGE",1:"ALL")
 S IBSMN=$S("Rr"[X:"R",1:"A") G:IBSMN="A" AMT
 ;
 ; - Determine the active receivable age range.
 S DIR(0)="NA^1:99999"
 S DIR("A")="Enter the minimum age of the active receivable: "
 S DIR("T")=DTIME,DIR("?")="^S IBOFF=9 D HELP^IBJDF6H"
 D ^DIR K DIR G:$D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) ENQ
 S IBSMN=+Y W "   ",IBSMN," DAYS" K DIROUT,DTOUT,DUOUT,DIRUT
 ;
 S DIR(0)="NA^"_IBSMN_":99999",DIR("B")=IBSMN
 S DIR("A")="Enter the maximum age of the active receivable: "
 S DIR("T")=DTIME,DIR("?")="^S IBOFF=14 D HELP^IBJDF6H"
 D ^DIR K DIR G:$D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) ENQ
 S IBSMX=+Y W "   ",IBSMX," DAYS" K DIROUT,DTOUT,DUOUT,DIRUT
 ;
AMT ; - Print receivables with a minimum balance.
 S DIR(0)="Y",DIR("B")="NO" W !
 S DIR("A")="Print receivables with a minimum balance"
 S DIR("T")=DTIME,DIR("?")="^S IBOFF=19 D HELP^IBJDF6H"
 D ^DIR K DIR G:$D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) ENQ
 S IBSAM=+Y K DIROUT,DTOUT,DUOUT,DIRUT G:'IBSAM EXCEL
 ;
AMT1 ; - Determine the minimum balance amount.
 S DIR(0)="NA^1:9999999"
 S DIR("A")="Enter the minimum balance amount of the receivable: "
 S DIR("T")=DTIME,DIR("?")="^S IBOFF=26 D HELP^IBJDF6H"
 D ^DIR K DIR G:$D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) ENQ
 S IBSAM=+Y K DIROUT,DTOUT,DUOUT,DIRUT
 ;
EXCEL ; - Determine whether to gather data for Excel report.
 S IBEXCEL=$$EXCEL^IBJD() G ENQ:IBEXCEL="^"
 I IBEXCEL S IBSH=1,IBSH1="M" G DEV
 ;
BCH ; - Determine whether to include the bill comment history.
 S DIR(0)="Y",DIR("B")="NO" W !
 S DIR("A")="Include the bill comment history with each receivable"
 S DIR("T")=DTIME,DIR("?")="^S IBOFF=31 D HELP^IBJDF6H"
 D ^DIR K DIR G:$D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) ENQ
 S IBSH=+Y K DIROUT,DTOUT,DUOUT,DIRUT G:'IBSH DEV
 ;
 S DIR(0)="SA^A:ALL;M:MOST RECENT"
 S DIR("A")="Print (A)LL comments or the (M)OST RECENT comment: "
 S DIR("B")="ALL",DIR("T")=DTIME,DIR("?")="^S IBOFF=40 D HELP^IBJDF6H"
 D ^DIR K DIR G:$D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) ENQ
 S IBSH1=Y K DIROUT,DTOUT,DUOUT,DIRUT G:IBSH1="A" DEV
 ;
 S DIR(0)="NAO^1:999"
 S DIR("A")="Minimum age of most recent bill comment (optional): "
 S DIR("T")=DTIME,DIR("?")="^S IBOFF=47 D HELP^IBJDF6H"
 D ^DIR K DIR G:$D(DTOUT)!$D(DUOUT)!$D(DIROUT) ENQ
 S IBSH2=+Y W:IBSH2 " DAYS" K DIROUT,DTOUT,DUOUT,DIRUT
 ;
DEV ; - Select a device.
 K IB0,IB1,IB2
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
 . S ZTRTN="DQ^IBJDF6",ZTDESC="IB - MISC. BILLS FOLLOW-UP REPORT"
 . F I="IB*","VAUTD","VAUTD(" S ZTSAVE(I)=""
 . D ^%ZTLOAD
 . I $D(ZTSK) W !!,"This job has been queued. Task number is ",ZTSK,"."
 . E  W !!,"Unable to queue this job."
 . K ZTSK,IO("Q") D HOME^%ZIS
 ;
 U IO
 ;
 ; If called by the Extraction Module, change extract status for the 3 
 ; reports: No-fault auto accident, Tort Feasor and Workman's Comp
DQ I $G(IBXTRACT) F I=22:1:24 D E^IBJDE(I,1)
 ;
 D ST^IBJDF61 ;    Compile and print the report.
 ;
ENQ K IBSDA,IBSDF,IBSDL,IBSDV,IBSEL,IBSN,IBSNA,IBSNF,IBSNL,IBSH,IBSH1,IBSH2
 K IBCTG,IBCTS,IBOFF,IBPRT,IBRPT,IBSAM,IBSMN,IBSMX,IBTEXT,IBI,DIROUT
 K DTOUT,DUOUT,DIRUT,POP,VAUTD,%ZIS,ZTDESC,ZTRTN,ZTSAVE,I,X,Y,Z
 Q
