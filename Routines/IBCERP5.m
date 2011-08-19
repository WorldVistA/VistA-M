IBCERP5 ;ALB/TMP - BATCH LIST ;02-OCT-96
 ;;2.0;INTEGRATED BILLING;**137,296**;21-MAR-94
 Q
LIST ; List batch detail
 N DIR,IBS1,Y,IBINCL
 S DIR("A")="DO YOU WANT TO INCLUDE A LIST OF BILLS WITH EACH BATCH?: ",DIR(0)="YA",DIR("B")="YES" D ^DIR K DIR
 I $D(DTOUT)!($D(DUOUT)) Q
 S IBINCL=+Y
 S DIR("A")="SORT BY",DIR(0)="SBM^B:BATCH;D:LAST DATE TRANSMITTED;S:LATEST BATCH RECEIPT STATUS",DIR("B")="B" D ^DIR K DIR
 I $D(DTOUT)!($D(DUOUT)) Q
 S IBS1=Y,(IBS1(1),IBS1(2))=""
 ;
 I IBS1="B" D  Q:IBS1(1)=""!(IBS1(2)="")  G LISTQ
 .F  S DIR("?")="Enter the first 10-digit batch number you want included on the report",DIR("A")="Start with BATCH #: ",DIR("B")="FIRST",DIR(0)="FA" D ^DIR K DIR Q:$D(DTOUT)!$D(DUOUT)  D  Q:IBS1(1)'=""
 ..I Y'="FIRST",Y'?10N W !,*7,"Must enter a 10-digit batch #" Q
 ..S IBS1(1)=$S(Y:Y-1,1:0)
 .Q:IBS1(1)=""
 .F  S DIR("?")="Enter the last 10-digit batch number you want included on the report",DIR("A")="Go to BATCH #: ",DIR("B")="LAST",DIR(0)="FA" D ^DIR K DIR Q:$D(DTOUT)!$D(DUOUT)  D  Q:IBS1(2)'=""
 ..I Y'="LAST",Y'?10N W !,*7,"Must enter a 10-digit batch #" Q
 ..S IBS1(2)=$S(Y="LAST":9999999999,1:+Y)
 ;
 I IBS1="D" D  Q:IBS1(1)=""!(IBS1(2)="")  G LISTQ
 .F  S DIR("?")="Enter the first date you want to include on the report",DIR("A")="Start with LAST TRANSMIT DATE: ",DIR("B")="FIRST",DIR(0)="FA" D ^DIR K DIR Q:$D(DTOUT)!$D(DUOUT)  D  Q:IBS1(1)'=""
 ..I Y'="FIRST" S X=Y,%DT="P" D ^%DT I Y<0 W !,*7,"Must enter a valid date" Q
 ..S IBS1(1)=$S(Y:Y-.0000001,1:0)
 .Q:IBS1(1)=""
 .F  S DIR("?")="Enter the last date you want to include on the report",DIR("A")="Go to LAST TRANSMIT DATE: ",DIR("B")="LAST",DIR(0)="FA" D ^DIR K DIR Q:$D(DTOUT)!$D(DUOUT)  D  Q:IBS1(2)'=""
 ..I Y'="LAST" S X=Y,%DT="P" D ^%DT I Y<0 W !,*7,"Must enter a valid date" Q
 ..S IBS1(2)=$S(Y="LAST":9999999,1:Y+.9999)
 ;
 I IBS1="S" D  Q:IBS1(1)=""  G LISTQ
 . N DA
 .S DIR("A")="Select BATCH STATUS: ",DIR(0)="364.1,.02A" D ^DIR K DIR Q:$D(DTOUT)!$D(DUOUT)  S (IBS1(1),IBS1(2))=$P(Y,U)
 ;
 Q
 ;
LISTQ S %ZIS="QM" D ^%ZIS Q:POP
 I $D(IO("Q")) K IO("Q") S ZTRTN="EN^IBCERP5",ZTSAVE("IB*")="",ZTDESC="EDI 837 BATCH DETAIL LIST" D ^%ZTLOAD K ZTSK D HOME^%ZIS Q
 U IO
EN ; Queued job entrypoint
 N IBPAGE,IBLINE,IBHDRDT,IB0,IB1,IBB,IBB0,IBBL,IB399,IBFIRST,IBSTOP,DIR,Y,IBXR,IBX,IBB3614,IBRIN,IBLTDT,IBTRSTAT
 W:$E(IOST,1,2)["C-" @IOF ;Only initial form feed for print to screen
 S (IBPAGE,IBSTOP)=0 D HDR1
 S IBXR=$S(IBS1="B":"B",IBS1="D":"ALT",1:"ASTAT")
 ;
 S IBV=IBS1(1)
 F  S IBV=$S(IBS1'="S":$O(^IBA(364.1,IBXR,IBV)),1:IBV) Q:IBV=""!(IBV]]IBS1(2))  S IB=0 F  S IB=$O(^IBA(364.1,IBXR,IBV,IB)) S:'IB&(IBS1="S") IBV="" Q:'IB  S IB0=$G(^IBA(364.1,IB,0)),IB1=$G(^(1)) D  G:IBSTOP Q
 .D:IBLINE>(IOSL-15) HDR1 Q:IBSTOP
 .I 'IBFIRST W ! S IBLINE=IBLINE+1
 .S:IBFIRST IBFIRST=0 S IBRESUB=$P(IB0,U,13)
 . K IBX S IBX=1
 . D:$P(IB0,U,10) CKRES^IBCESRV2(IB,0,.IBX)
 .W !,"Batch #: ",$P(IB0,U),?40,"Rejected?: ",$P("NO^YES",U,+$P(IB0,U,5)+1),?60,$S(IBRESUB:"Resubmit: "_$S($P(IB0,U,10):"IN",1:"")_"COMPLETE",1:"")
 .W !," Batch Type : ",$$EXPAND^IBTRE(364.1,.07,$P(IB0,U,7)),?42,"# Bills: ",$P(IB0,U,3),?60,"Mail Msg: ",$P(IB0,U,4)
 .S IBLINE=IBLINE+1
 .I IBLINE>(IOSL-5) D HDR1 Q:IBSTOP
 .W !," Received in Austin?: "_$S($P(IB0,U,2)="A0":"Yes",1:"No")
 .W !," Status Date: ",$$FMTE^XLFDT($P(IB1,U,5),2),?36,"Date Recorded: ",$$FMTE^XLFDT($P(IB1,U,6),2)
 .S IBLINE=IBLINE+1
 .I IBLINE>(IOSL-5) D HDR1 Q:IBSTOP
 .W !," First Sent : ",$$FMTE^XLFDT($P(IB1,U),2),?47,"By: ",$E($$EXPAND^IBTRE(364.1,1.02,$P(IB1,U,2)),1,29)
 .S IBLINE=IBLINE+1
 .I IBLINE>(IOSL-5) D HDR1 Q:IBSTOP
 .I $P(IB1,U)'=$P(IB1,U,3) W !," Last Sent  : ",$$FMTE^XLFDT($P(IB1,U,3),2),?47,"By: ",$E($$EXPAND^IBTRE(364.1,1.02,$P(IB1,U,4)),1,29) S IBLINE=IBLINE+1
 .I IBLINE>(IOSL-5) D HDR1 Q:IBSTOP
 .I $P(IB0,U,8)'="" W !," ",$E($P(IB0,U,8),1,79) S IBLINE=IBLINE+1
 .;EJK 4/5/5 Claim detail can come from 2 source files now. 
 .Q:'IBINCL  ;List of bills not wanted
 .I IBLINE>(IOSL-5) D HDR1 Q:IBSTOP
 .W !,"  **BILLS**",?25,"Number    Transmit Status            Resubmit Batch #"
 .I IBLINE>(IOSL-6) D HDR1 Q:IBSTOP
 .K ^TMP($J,"IBSORT")
 .W !,?2,$S($P(IB0,U,10):"* = NOT RESUBMITTED",1:""),?25,"--------  -------------------------  ----------------" S IBLINE=IBLINE+2
 .;EJK 4/5/5 Get E-Claims test data from new file 361.4
 .I $O(^IBM(361.4,"C",IB,"")) D
 ..S (IBB,IBBL)=0
 ..F  S IBB=$O(^IBM(361.4,"C",IB,IBB)) Q:'IBB  D
 ...S IBB0=$G(^IBM(361.4,IBB,0))
 ...S IB399=$G(^DGCR(399,+IBB0,0))
 ...S IBB3614=$P(IBB0,U,1)
 ...S IBLTDT=$P(IBB0,U,2)
 ...S IBRIN="",IBRIN=$O(^IBM(361.4,IBB,1,"ALTD",IBLTDT,IBRIN),-1)
 ...S $P(IBB3614,U,7)=$P($G(^IBM(361.4,IBB,1,IBRIN,0)),U,4)
 ...S ^TMP($J,"IBSORT",$P(IB399,U),IBB)=IBB3614
 ...Q
 ..Q
 .I $O(^IBA(364,"C",IB,"")) D
 ..S (IBB,IBBL)=0 F  S IBB=$O(^IBA(364,"C",IB,IBB)) Q:'IBB  S IBB0=$G(^IBA(364,IBB,0)),IB399=$G(^DGCR(399,+IBB0,0)) S ^TMP($J,"IBSORT",$P(IB399,U),IBB)=IBB0 S:$D(IBX(IBB)) ^(IBB,1)=1
 .S IBB1="" F  S IBB1=$O(^TMP($J,"IBSORT",IBB1)) Q:IBB1=""!(IBSTOP)  S IBB=0 F  S IBB=$O(^TMP($J,"IBSORT",IBB1,IBB)) Q:'IBB  S IBB0=$G(^(IBB)) D  Q:IBSTOP
 ..I IBLINE>(IOSL-5) D HDR1 Q:IBSTOP  D
 ...W !,"Batch #: ",$$EXPAND^IBTRE(364,.02,$P(IBB0,U,2)),?25,"Number    Transmit Status" W:IBRESUB "            Resubmit Batch #"
 ...W !,?9,"(continued)",?25,"--------  -------------------------  ----------------"
 ...S IBLINE=IBLINE+2,IBFIRST=0
 ..S IBTRSTAT=$$EXPAND^IBTRE(364,.03,$P(IBB0,U,3))
 ..W !,?24,$S($G(^TMP($J,"IBSORT",IBB1,IBB,1)):"*",1:" "),IBB1
 ..W ?35,$S($G(IBTRSTAT)'="":IBTRSTAT,1:"N/A")
 ..W ?65,$$EXPAND^IBTRE(364,.06,$P(IBB0,U,6))
 ..S IBLINE=IBLINE+1
 G:IBSTOP Q
 I $E(IOST,1,2)["C-" K DIR S DIR(0)="E" D ^DIR K DIR
Q I '$D(ZTQUEUED) D ^%ZISC
 I $D(ZTQUEUED) S ZTREQ="@"
 K ^TMP($J,"IBSORT")
 Q
 ;
HDR1 ; Header code
 N Z,DIR,Y
 I 'IBPAGE S IBHDRDT=$$HTE^XLFDT($H,"2")
 I IBPAGE D  Q:IBSTOP
 .I $E(IOST,1,2)["C-" K DIR S DIR(0)="E" D ^DIR K DIR S IBSTOP=('Y) Q:IBSTOP
 .W @IOF
 S IBPAGE=IBPAGE+1
 W !,?32,"BATCH DETAIL LIST",?70,"PAGE: ",IBPAGE,!,?27,"RUN DATE: ",IBHDRDT
 S Z="",$P(Z,"-",81)="" W !,Z
 S IBLINE=3,IBFIRST=1
 Q
 ;
