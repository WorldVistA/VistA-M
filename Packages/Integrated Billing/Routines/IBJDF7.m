IBJDF7 ;ALB/MR - REPAYMENT PLAN REPORT;14-AUG-00
 ;;2.0;INTEGRATED BILLING;**123**;21-MAR-94
 ;
EN ; - Option entry point.
 S (IBEXCEL,IBTPT)=0,IBDAYS=1
 ;
 ; - Determine sorting (By name or Last 4 SSN)
 S IBSN=$$SNL^IBJD() G ENQ:IBSN="^"
 ;
 ; - Determine the range
 S X=$$INTV^IBJD("PATIENT "_$S(IBSN="N":"NAME",1:"LAST 4")) G ENQ:X="^"
 S IBSNF=$P(X,"^",1),IBSNL=$P(X,"^",2),IBSNA=$P(X,"^",3)
 ;
CDPP ; - Select Current or Defaulted Payment Plan
 S DIR(0)="SA^C:CURRENT;D:DEFAULTED;B:BOTH"
 S DIR("A")="Print (C)URRENT, (D)EFAULTED Repayment Plans or (B)OTH: "
 S DIR("B")="B",DIR("T")=300,DIR("L")=""
 S (DIR("?"),DIR("??"))="^S IBOFF=23 D HELP^IBJDF7H"
 W ! D ^DIR K DIR G:$D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) ENQ
 S IBPLN=Y K DIROUT,DTOUT,DUOUT,DIRUT G MCR:IBPLN="C"
 ;
 ; - Minimum number of days defaulted
 S DIR(0)="NA^1:999",DIR("B")=1
 S DIR("A")="Minimum number of days defaulted: "
 S DIR("T")=300,DIR("?")="^S IBOFF=32 D HELP^IBJDF7H"
 W ! D ^DIR K DIR G:$D(DTOUT)!$D(DUOUT)!$D(DIROUT) ENQ
 S IBDAYS=+Y W:IBDAYS " day(s)" K DIROUT,DTOUT,DUOUT
 ;
MCR ; - Select MCCR or NON-MCCR Receivables
 S DIR(0)="SA^M:MCCR;N:NON-MCCR"
 S DIR("A")="Print (M)CCR or (N)ON-MCCR Receivables: "
 S DIR("B")="M",DIR("T")=300,DIR("L")=""
 S (DIR("?"),DIR("??"))="^S IBOFF=39 D HELP^IBJDF7H"
 W ! D ^DIR K DIR G:$D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) ENQ
 S IBMCR=Y K DIROUT,DTOUT,DUOUT,DIRUT
 ;
 ; - Select a detailed or summary report.
 D DS^IBJD G ENQ:IBRPT["^",DEV:IBRPT="S"
 ;
 ; - Determine whether to gather data for Excel report.
 S IBEXCEL=$$EXCEL^IBJD() G ENQ:IBEXCEL="^",DEV:IBEXCEL
 ;
 ; - Print TOTAL by Patient?
 S DIR(0)="Y",DIR("B")="YES",DIR("T")=300 W !
 S DIR("A")="Do you want to include TOTALs by Patient"
 S DIR("?")="^S IBOFF=55 D HELP^IBJDF7H"
 D ^DIR K DIR G:$D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) ENQ
 S IBTPT=+Y K DIROUT,DTOUT,DUOUT,DIRUT
 ;
DEV ; - Select a device.
 W !!,"This report requires a ",$S(IBRPT="S":80,1:132)," column printer."
 ;
 I '$G(IBEXCEL) D
 . W !!,"Note: This report will search through all active receivables."
 . W !?6,"It is recommended that you queue it to run after normal business hours.",!
 ;
 I $G(IBEXCEL) D EXMSG^IBJD
 ;
 S %ZIS="QM" D ^%ZIS G:POP ENQ
 I $D(IO("Q")) D  G ENQ
 .S ZTRTN="DQ^IBJDF7",ZTDESC="IB - REPAYMENT PLAN REPORT"
 .S ZTSAVE("IB*")="" D ^%ZTLOAD
 .I $G(ZTSK) W !!,"This job has been queued. The task no. is ",ZTSK,"."
 .E  W !!,"Unable to queue this job."
 .K ZTSK,IO("Q") D HOME^%ZIS
 ;
 U IO
 ;
DQ I $G(IBXTRACT) D E^IBJDE(38,1) ;  Change extract status.
 D ST^IBJDF71 ;                  Compile and print the report.
 ;
ENQ K DIROUT,DTOUT,DUOUT,DIRUT,I,IBDAYS,IBEXCEL,IBI,IBMCR,IBSN,IBSNF,IBSNL
 K IBOFF,IBSNA,IBPLN,IBRPT,IBTPT,POP,X,ZTDESC,ZTRTN,ZTSAVE,Y,%ZIS
 Q
