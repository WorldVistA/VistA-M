IBAECB ;WOIFO/AAT-LTC BILLING CLOCK INQUIRY ; 21-FEB-02
 ;;2.0;INTEGRATED BILLING;**171,176**;21-MAR-94
 ;; Per VHA Directive 10-93-142, this routine should not be modified
 ;
 N IBQUIT,POP
 ;
 F  S IBQUIT=0 D ASKPT Q:IBQUIT
 Q
 ;
 ;
ASKPT ; Ask about patient and clock
 N IBDFN,IBCLK,X,Y,DIC
 W !
 S IBDFN=$$ASKPAT^IBAECP I IBDFN<1 S IBQUIT=1 Q  ; Patient code
 ; Enter required clock (if more than one)
 S IBCLK=$$ASKCLK^IBAECP(IBDFN) I IBCLK<0 Q
 F  S IBQUIT=0 D ASKDEV I IBQUIT S IBQUIT=IBQUIT-1 Q
 Q
 ;
ASKDEV ; Ask about device and print
 N DIR,DIRUT
 S %ZIS="QM" W ! D ^%ZIS
 I POP S IBQUIT=1 Q
 I $D(IO("Q")) D RUNTASK S IBQUIT=1 Q
 U IO D PRINT W !
 I IBQUIT S IBQUIT=2 Q
 S IBQUIT=1 W @IOF
 Q
 ;
RUNTASK N ZTRTN,ZTDESC,ZTSAVE,ZTSK,ZTQUEUED,ZTREQ
 S ZTRTN="PRINT^IBAECB"
 S ZTDESC="IB LTC BILLING CLOCK REPORT"
 S ZTSAVE("IBCLK")=""
 D ^%ZTLOAD
 W !!,$S($D(ZTSK):"Request Queued!",1:"Request Cancelled")
 D HOME^%ZIS
 Q
 ;
HEADER N Y
 S Y=DT X ^DD("DD")
 W !,Y,?22,"LTC Billing Clock Inquiry",!!
 Q
 ;
PRINT ;
 ; Input: IBCLK
 I $E(IOST,1,2)="C-" W @IOF ; Form feed to CRT only
 I $E(IOST,1,2)="P-" D HEADER
 ;W !,"Printing clock ",IBCLK
 D REPORT^IBAECB1
 I $E(IOST,1,2)="C-" D PAUSE^IBAECB1
 I $D(ZTQUEUED) S ZTREQ="@" ; Q
 D ^%ZISC
 Q
