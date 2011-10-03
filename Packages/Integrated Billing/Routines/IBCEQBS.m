IBCEQBS ;ALB/TMP - 837 EDI QUERY BATCH STATUS REPORTS ;05-SEP-96
 ;;2.0;INTEGRATED BILLING;**137**;21-MAR-94
 Q
QSTAT ; Query Pending Batch Transmit Status
 N IBQ,IBQ1,DIC,IBBDA,IBMSG,IBST,Y,DIR,DIRUT,DTOUT,DUOUT,Z
 S IBQ=$P($G(^IBE(350.9,1,8)),U),IBQ1=$P($G(^(8)),U,9)
 I IBQ="",IBQ1="" W !,*7,"No 837 data queues are set up" S DIR(0)="E" D ^DIR Q
 S DIC="^IBA(364.1,",DIC("S")="I $P(^(0),U,2)=""P""",DIC(0)="AEMQZ" D ^DIC
 Q:Y<0  S IBBDA=+Y
 S %ZIS="QM" D ^%ZIS Q:POP
 I $D(IO("Q")) K IO("Q") S ZTRTN="STAT^IBCEQBS",ZTSAVE("IB*")="",ZTDESC="PRINT TXMN STATUS OF PENDING BATCH" D ^%ZTLOAD K ZTSK D HOME^%ZIS Q
 U IO
 D STAT
 Q
 ;
STAT ; Queued job entrypoint
 N Y
 W:$E(IOST,1,2)["C-" @IOF
 W !,"PENDING BATCH TRANSMISSION STATUS REPORT",?50,"Run Date: ",$$HTE^XLFDT($H,"2P"),!
 S Y=IBBDA,Y(0)=$G(^IBA(364.1,IBBDA,0)),Y(1)=$G(^(1))
 S:$P(Y(0),U,14) IBQ=IBQ1
 S IBMSG=$P(Y(0),U,4),Y(1)=$G(^IBA(364.1,+Y,1)),IBST=$$STATUS^XMS1(IBMSG,"XXX@Q-"_IBQ_".VA.GOV")
 W !,"Status of batch ",$P(Y,U,2)," (mail message #: ",IBMSG,"): ",$S(IBST'="":IBST,1:"Sent")
 S Z=$$EXPAND^IBTRE(364.1,1.02,$P(Y(1),U,2))
 W !!,"First Sent: ",$$FMTE^XLFDT(+Y(1),"2P"),?35,"By: ",$S(Z'="":Z,1:"Unknown")
 S Z=$$EXPAND^IBTRE(364.1,1.04,$P(Y(1),U,4))
 W !," Last Sent: ",$$FMTE^XLFDT($P(Y(1),U,3),"2P"),?35,"By: ",$S(Z'="":Z,1:"Unknown")
 D ^%ZISC
 Q
 ;
