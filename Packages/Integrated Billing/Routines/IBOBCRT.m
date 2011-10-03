IBOBCRT ;ALB/RJS - IB-BILLING-CYCLE-REPORT 12/19/91
 ;;2.0;INTEGRATED BILLING;**153,199**;21-MAR-94
CATCCLK ;
 ;***
 ;I $D(XRT0) S:'$D(XRTN) XRTN="IBOBCRT" D T1^%ZOSV ;stop rt clock
 ;S XRTL=$ZU(0),XRTN="IBOBCRT-1" D T0^%ZOSV ;start rt clock
 ;***
 S DIC="^IBE(351,",DIC(0)="AEQMZ"
 S DIC("A")="Select MT Billing Clock by PATIENT NAME: "
 N DPTNOFZY S DPTNOFZY=1  ;Suppress PATIENT file fuzzy lookups
 D ^DIC
 I Y<0 G END
 S IBD0=$P(Y,"^",1)
 W ! D OPEN G END:POP
 I $D(IO("Q")) D QUEUED,HOME^%ZIS G CATCCLK
 U IO D DQ
 W ! S DIR(0)="E" D ^DIR I '$D(DIRUT) W @IOF G CATCCLK
 Q
OPEN ;
 S %ZIS="QM" D ^%ZIS
 Q
QUEUED ;
 S ZTRTN="DQ^IBOBCRT",ZTDESC="IB BILLING REPORT",ZTSAVE("IBD0")="" D ^%ZTLOAD W !!,$S($D(ZTSK):"Request Queued!",1:"Request Cancelled")
 Q
HEADER ;
 S Y=DT X ^DD("DD")
 W !,Y,"            Billing Cycle Inquiry",?30,!!
 K Y
 Q
DQ ;
 ;***
 ;I $D(XRT0) S:'$D(XRTN) XRTN="IBOBCRT" D T1^%ZOSV ;stop rt clock
 ;S XRTL=$ZU(0),XRTN="IBOBCRT-2" D T0^%ZOSV ;start rt clock
 ;*** suppress initial form feed (to all but crts)
 W:$E(IOST,1,2)["C-" @IOF
 S D0=IBD0
 I $E(IOST,1,2)="P-" D HEADER
 K DXS D ^IBXBCR2 K DXS D ^IBXBCR K DXS
END ;
 ;***
 ;I $D(XRT0) S:'$D(XRTN) XRTN="IBOBCRT" D T1^%ZOSV ;stop rt clock
 I $D(ZTQUEUED) S ZTREQ="@" Q
 D ^%ZISC
 K D0,DIC,DIR,DIRUT,DXS,POP,Y,ZTDESC,ZTQUEUED,ZTREQ,ZTRTN,ZTSAVE,ZTSK,IBD0
 Q
