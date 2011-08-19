IBOCHK ;ALB/AAS - INTEGRATED BILLING - RX COPAY LINK CHECK ; 2-APR-91
 ;;2.0;INTEGRATED BILLING;**347**; 21-MAR-94;Build 24
 ;
 ;  -loop through range of IB reference numbers and verify
 ;   soft link exists and has link back to IB.
 ;
% ;
 ;***
 ;S XRTL=$ZU(0),XRTN="IBOCHK-1" D T0^%ZOSV ;start rt clock
 ;
 D HOME^%ZIS W @IOF,?24,"Verify IB - Pharmacy Co-Pay links",!!
 ;
ST S DIC="^IB(",DIC(0)="AEQMN",DIC("A")="START WITH REFERENCE NUMBER:",DIC("B")="" D ^DIC K DIC G:+Y<1 END S IBSTART=$P(Y,"^",2)
 ;
TO S DIC="^IB(",DIC(0)="AEQMN",DIC("A")="GO TO REFERENCE NUMBER: ",DIC("B")="" D ^DIC K DIC G:+Y<1 END S IBEND=$P(Y,"^",2)
 I IBSTART>IBEND W *7,!!,"End must not be less than beginning number",! G ST
 ;
DEV W !!,"*** Margin width of this output is 132 ***"
 W ! S %ZIS="QM",%ZIS("A")="Output Device: " D ^%ZIS G:POP END
 I $D(IO("Q")) S ZTRTN="DQ^IBOCHK",ZTDESC="IB Check Pharmacy Links",ZTSAVE("IB*")="" D ^%ZTLOAD K IO("Q") W ! G END
 ;
 U IO
 ;***
 ;I $D(XRT0) S:'$D(XRTN) XRTN="IBOCHK" D T1^%ZOSV ;stop rt clock
 ;
DQ ;  -entry point from queing
 ;S XRTL=$ZU(0),XRTN="IBOCHK-2" D T0^%ZOSV ;start rt clock
 ;
 S (IBCNT,IBECNT)=0,IBPAG=0,IBQUIT=0 S Y=DT D D^DIQ S IBHDT=Y D HDR
 S IBRNUM=IBSTART-1
 F  S IBRNUM=$O(^IB("B",IBRNUM)) Q:'IBRNUM!(IBRNUM>IBEND)!(IBQUIT)  S IBN="" F  S IBN=$O(^IB("B",IBRNUM,IBN)) Q:'IBN!(IBQUIT)  D CHK
 G END
 ;
CHK S IBCNT=IBCNT+1
 N DFN,IBNODE
 I '$D(^IB(IBN,0))!('$D(^IB(IBN,1))) S IBOERR=1,IBND=IBN G LINE ;xref to no entry
 S IBND=$S($D(^IB(IBN,0)):^(0),1:"")
 S IBSL=$P(^IB(IBN,0),"^",4) I 'IBSL S IBOERR=2 G LINE ;no softlink
 I +IBSL'=52 Q  ;not a pharmacy rx entry
 S IBRXN=$P($P(IBSL,";"),":",2),IBRXN1=$P($P(IBSL,";",2),":",2)
 S DFN=$P(^IB(IBN,0),"^",2)
 I $$FILE^IBRXUTL(IBRXN,.01)="" S IBOERR=3 G LINE ;rx deleted
 S IBNODE=$$IBND^IBRXUTL(DFN,IBRXN)
 I IBNODE'["^" S IBOERR=4 G LINE ;IB node missing
 I +IBNODE,'$P(IBNODE,"^",2) S IBOERR=5 G LINE ;pointer back to IB missing
 Q:'IBRXN1
 I +$$SUBFILE^IBRXUTL(IBRXN,IBRXN1,52,.01)=0 S IBOERR=6 G LINE ;refill deleted
 I $$IBNDFL^IBRXUTL(DFN,IBRXN,IBRXN1)'["^" S IBOERR=7 G LINE ;ib node on refill missing
 I +$$IBNDFL^IBRXUTL(DFN,IBRXN,IBRXN1)=0 S IBOERR=8 G LINE ;no data on node
 Q  ;pharmacy links okay.
 ;
HDR ;
 S IBPAG=IBPAG+1
 W:$E(IOST,1,2)["C-"!(IBPAG>1) @IOF
 W "Verify Integrated Billing links to Pharmacy",?IOM-22,IBHDT,"  Page:",IBPAG
 W !,"Verify IB Reference Number ",IBSTART," to ",IBEND
 W !,"REF. NO.",?12,"PATIENT",?34,"SSN",?40,"RX#",?50,"REFILL",?58,"IB LINK",?80,"CHARGE ID",?91,"TRANS",?97,"ERROR MESSAGE"
 S $P(IBLINE,"-",IOM)="" W !,IBLINE K IBLINE
 Q
LINE ;
 I $Y>(IOSL-5) D PAUSE^IBOUTL Q:IBQUIT  D HDR
 S IBECNT=IBECNT+1
 W !,$P(IBND,"^") S DFN=$P(IBND,"^",2)
 I $D(^DPT(+DFN,0)) D PID^VADPT W ?12,$E($P(^DPT(DFN,0),"^"),1,20),?34,VA("BID"),?40,$P($P(IBND,"^",8),"-"),?50,$P($P(IBSL,";",2),":",2),?58,IBSL,?80,$P(IBND,"^",11),?91,$P(IBND,"^",12)
 W ?97,$P($T(IBOERR+IBOERR),";;",2,99)
 Q
 ;
END ;
 ;***
 I $D(XRT0) S:'$D(XRTN) XRTN="IBOCHK" D T1^%ZOSV ;stop rt clock
 ;
 Q:$D(ZTQUEUED)  K IBCNT,IBECNT,IBEND,IHDT,IBN,IBND,IBPAG,IBQUIT,IBRNUM,IBRXN,IBRXN1,IBSL,IBSTART
 D ^%ZISC
 Q
IBOERR ;error messages
 ;;IB CROSS-REFERENCE BUT NO ENTRY
 ;;IB ENTRY MISSING SOFTLINK
 ;;RX ENTRY DELETED OR ARCHIVED
 ;;RX ENTRY MISSING IB NODE
 ;;RX ENTRY MISSING IB POINTER
 ;;RX REFILL DELETED
 ;;RX REFILL MISSING IB NODE
 ;;RX REFILL MISSING IB LINK
