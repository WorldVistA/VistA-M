IBCERP4 ;ALB/TMP - EDI RECEIPT/REJECTION MSGS STILL PENDING/UPDATNG ; 4/22/03 8:29am
 ;;2.0;INTEGRATED BILLING;**137,211**;21-MAR-94
 Q
PENDING ; Report of EDI messages still waiting to be filed
 ;  after a user-specified # of days.
 N DIR,IBDAYS
 W !!
 S DIR(0)="NA^1:999",DIR("B")=1,DIR("A")="MINIMUM # OF DAYS MSGS WAITING TO BE FILED: ",DIR("?",1)="Enter the minimum number of days a message has been waiting to be filed",DIR("?")="before it appears on this report" D ^DIR K DIR
 Q:$D(DTOUT)!$D(DUOUT)
 S IBDAYS=+Y
 S %ZIS="QM" D ^%ZIS Q:POP
 I $D(IO("Q")) K IO("Q") S ZTSAVE("IB*")="",ZTRTN="EN^IBCERP4",ZTDESC="REPORT OF EDI MSGS PENDING TOO LONG TO BE FILED" D ^%ZTLOAD K ZTSK D HOME^%ZIS Q
 U IO
EN ; Queued job entrypoint
 N IBPAGE,IBHDRDT,IBLINE,IBSTOP,IBDA,IBCT,IBM,IBMSG,IB0,IB1,IB,DIR,Y
 ;
 K ^TMP($J,"IBSORT")
 S IBDA=0 F  S IBDA=$O(^IBA(364.2,IBDA)) Q:'IBDA  S IB0=$G(^IBA(364.2,IBDA,0)),IB1=$G(^(1)),IBM=+$P(IB0,U,2) D
 .; IB*2.0*211 - kill off records with dangling nodes
 . I IB0="",IB1'="" N DA,DIK,Y S DA=IBDA,DIK="^IBA(364.2," D ^DIK Q
 . I DT-($P(IB1,U,3)\1)'<IBDAYS,'$P(IB0,U,12) D
 .. S ^TMP($J,"IBSORT",$P(IB0,U),IBDA)=$P(IB0,U)_U_$P(IB0,U,6)_U_$P(IB1,U,3)_U_$P(IB0,U,4,5),$P(^(IBDA),U,6)=IBM
 ;
 W:$E(IOST,1,2)["C-" @IOF ;Only initial form feed for print to screen
 ;
 S (IBPAGE,IBSTOP,IBCT,IBMSG,IBLINE)=0
 D HDR1
 I '$D(^TMP($J,"IBSORT")) W !,"No data found for this report",!
 F  S IBMSG=$O(^TMP($J,"IBSORT",IBMSG)) Q:'IBMSG!(IBSTOP)  S IBDA=0 F  S IBDA=$O(^TMP($J,"IBSORT",IBMSG,IBDA)) Q:'IBDA  S IBV=$G(^(IBDA)) D  Q:IBSTOP
 . D:IBLINE>(IOSL-5) HDR1 Q:IBSTOP
 . W !,?2,$P($G(^IBE(364.3,+$P(IBV,U,6),0)),U,5)
 . W !,?4,$P(IBV,U),?15,$$EXPAND^IBTRE(364.2,.06,$P(IBV,U,2)),?31,$$FMTE^XLFDT($P(IBV,U,3),1),?54,$$EXPAND^IBTRE(364.2,.04,$P(IBV,U,4))
 . S Z=$$BN1^PRCAFN(+$G(^IBA(364,+$P(IBV,U,5),0)))
 . I Z'=-1 W ?65,Z
 . S IBCT=IBCT+1,IBLINE=IBLINE+1
 ;
 W !!,"TOTAL # OF MESSAGES WAITING OVER "_IBDAYS_" DAY"_$S(IBDAYS>1:"S",1:"")_" TO BE FILED: ",IBCT
 ;
 I $E(IOST,1,2)["C-" K DIR S DIR(0)="E" D ^DIR K DIR
STOP I '$D(ZTQUEUED) D ^%ZISC
 I $D(ZTQUEUED) S ZTREQ="@"
 K ^TMP($J,"IBSORT")
 Q
 ;
HDR1 ; Report header
 ;IB = the text for the type of batch
 N Z,DIR,Y
 I 'IBPAGE S IBHDRDT=$$HTE^XLFDT($H,"2")
 I IBPAGE D  Q:IBSTOP
 . I $E(IOST,1,2)["C-" K DIR S DIR(0)="E" D ^DIR K DIR S IBSTOP=('Y) Q:IBSTOP
 . W @IOF
 ;
 S IBPAGE=IBPAGE+1,Z="EDI MESSAGES WAITING TO BE FILED OVER "_IBDAYS_" DAY"_$S(IBDAYS>1:"S",1:"")
 W !,?((80-$L(Z))\2),Z,?70,"PAGE: ",IBPAGE,!
 W !,?26,"RUN DATE: ",IBHDRDT,!
 W !,?2,"MESSAGE TYPE"
 W !,?4,"MAIL",?31,"IN CURRENT",!,?4,"MESSAGE #",?15,"CURRENT STATUS",?31,"STATUS SINCE",?54,"BATCH #",?65,"BILL #",!
 S Z="",$P(Z,"-",76)="" W ?2,Z,!
 S IBLINE=7
 Q
 ;
