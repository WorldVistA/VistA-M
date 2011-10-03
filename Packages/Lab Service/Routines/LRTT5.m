LRTT5 ;DALISC/FHS - LAB URGENCY TURNAROUND TIMES ; 12/3/1997
 ;;5.2;LAB SERVICE;**153,201**;Sep 27, 1994
EN ;
ONE S LREND=0 D ^LRPARAM G:$G(LREND) STOP
 S LRPTITLE="Urgency Turnaround Time",LRPQNUM=1 K LRPQ
 ; from LRTT5
 ; get default dates from QUIC Extract file - if current survey
 W @IOF S LRPOPTN="",LREDT=LRDT0
 D TITLE("TQD")
 D ^LRWU3 G:$G(LREND) STOP S LRPSDT=LRSDT,LRPEDT=LREDT
 W !!,"Select the laboratory tests to be used in this report --",!
 K DIC,^TMP("LRTT5",$J) S DIC=60,DIC(0)="AEMOQZ",DIC("A")="     LABORATORY TEST: "
 S ^TMP("LRTT5",$J,0)=DT_U_DT_U_"LAB URGENCY TURNAROUND TIMES"
 F  D ^DIC Q:Y<1  S ^TMP("LRTT5",$J,"TESTS",+Y)=$P(Y(0),U)
 K DIC I '$D(^TMP("LRTT5",$J,"TESTS")) G STOP
 W !!,"Urgencies:" S LRX=0 F  S LRX=$O(^LAB(62.05,LRX)) Q:LRX>49!(LRX<1)  W:$D(^(LRX,0)) !?10,$P(^(0),U)
 W !,"Enter all urgencies you want extracted." S DIC=62.05,DIC(0)="AEMOQZ",DIC("A")="     URGENCY: ",DIC("S")="I +Y<49"
 F  D ^DIC Q:Y<1  S LRPQ("URGENCY",+Y)=$P(Y(0),U) S:$D(^LAB(62.05,(+Y+50),0)) LRPQ("URGENCY",(+Y+50))=$P(^(0),U)
 K DIC I '$D(LRPQ("URGENCY")) G STOP
 K DIC,DIR S DIR(0)="PO^DIC(4,:AENM",DIR("A")="Select Division(s) "
 W !!?10,"<Optional Screen>  Press return to select all divisions",! D
 . F  D READ Q:$G(LREND)!(Y<1)  S LRLLOC(+Y)=Y
 I $D(LRPQ) D DETAIL I LRPDET<0 K LRPQ
 I $D(LRPQ) D DEV
 D CLEANUP
 Q
DETAIL ; detailed report=1, no detailed report=0, exit=-1
 F  W !!,"Include a detailed report" S %=2 D YN^DICN Q:%  W "  enter 'Y'es or 'N'o"
 S LRPDET=$S(%=1:1,%=2:0,1:-1)
 Q
DEV ;
 W !! S %ZIS="Q" D ^%ZIS I POP Q
 I '$D(IO("Q")) D REPORT Q
 S ZTIO=ION,ZTSAVE("^TMP(""LRTT5"",$J,")="",ZTSAVE("LR*")="",ZTDESC="LAB - "_LRPTITLE,ZTRTN="REPORT^LRTT5" D ^%ZTLOAD W !,$S($D(ZTSK):"Request queued",1:"Request canceled") D HOME^%ZIS K ZTSK Q
 Q
REPORT ; dequeued
 K ^TMP("LR",$J) S ^TMP("LR",$J,0)=DT_U_DT_U_"LAB URGENCY TURNAROUND TIMES"
 D ONE^LRTT5P1
 S LRPNOW=$$NOW^XLFDT,LRPTBF=$$FMTE^XLFDT(LRPSDT),LRPTEF=$$FMTE^XLFDT(LRPEDT)
 U IO W:$E(IOST,1,2)="C-" @IOF D HDR
 I $O(^TMP("LR",$J,0))="" W !!!,"No data to report" G CLEANUP
 D ONE^LRTT5R1
 I '$G(LREND) W !!?20,"****** END OF REPORT ********"
 D CLEANUP
 Q
LNCHECK ; from LRTT5R*
 Q:$G(LREND)  I $Y>(IOSL-6) D
 . I $E(IOST,1,2)="C-" K DIR S DIR(0)="E" D ^DIR S:$G(DIRUT) LREND=1 Q:LREND  D DHDR Q
 . D DHDR
 Q
DHDR ; from LRTT5R*
 Q:$G(LREND)  W @IOF D HDR S LRPPAGE=$G(LRPPAGE)+1,LRPDTHDR="LEDI - "_LRPTITLE_" - DETAILED " W ?(IOM-$L(LRPDTHDR)\2),LRPDTHDR,?(IOM-15),"PAGE ",LRPPAGE,!,LRPDHEAD,!
 Q
HDR Q:$G(LREND)
 F LRPLN=$G(LRPVAMC),"LEDI Management Report - "_LRPTITLE,"From "_LRPTBF_" To "_LRPTEF,"Date Printed: "_$$FMTE^XLFDT($$NOW^XLFDT) W !?(IOM-$L(LRPLN)\2),LRPLN
 S LRPLN="",$P(LRPLN,"_",IOM+1)="" W !,LRPLN,!
 Q
CLEANUP ;
STOP K ^TMP("LR",$J),^TMP("LRTT5",$J) I $D(ZTQUEUED) S ZTREQ="@"
 W !! W:$E(IOST,1,2)="P-" @IOF D ^%ZISC
 K %,%I,%DT,%ZIS,%T,%Y,C,DIC,DFN,DTOUT,DUOUT,POP,DIR,LRPVAMC
 K LRAA,LRAASUB,LRAAT,LRPAC,LRPALOC,LRPALRSP,LRAN,LRPCNT,LRPDET,LRDPF
 K LRPDHEAD,LRPDIFF,LRPDNODE,LRPDTHDR,LRPDTYPE,LRPITB,LRPITE,LRAD,LRPLINE,LRPLN
 K LRLOC,LRLLOC,LRLOC44,LRLOCX,LRPLRAC,LRPLRDC,LRPLRDFN,LRPLRDN,LRPLRIDT,LRPLRRX,LRPLRRX1,LRPLRRX2
 K LRPLRSP,LRPLRSS,LRPLRST,LRPLRT,LRPLRTN,LRPLRTS,LRPMERGE,LRPN,LRPNN,LRPNNUM,LRPNOW
 K LRPNT,LRPNUM,LRPOC,LRPOCM,LRPOCNT,LRPOCT,LRPOCTT,LRPOK,LRPOOS,LRPORG,LRPORGN,LRPOS,LRPPAGE
 K LRPPATN,LRPPDOC,LRPQ,LRPQNUM,LRPRX1D,LRPRX1T,LRPSP,LRPSPEC,LRPSPN,LRPTB,LRPTBF
 K LRPTE,LRPTEF,LRTEST,LRTESTN,LRPTITLE,LRPTYPE,LRX,LREDT,LRSDT
 K LRPERR,VA,VADM,VAIN,X,X1,X2,Y,ZTDESC,ZTRTN,ZTSAVE,ZTSK,LRPSDT
 K LRPEDT,LRPOPTN,LREND
 Q
LRTT5U ;
TITLE(LRPUTYPE) ; from LRTT5, LRTT5A, displays "T" title, "Q" question, "D" description
 I LRPUTYPE["T" S LRPLN="LEDI Utility - "_LRPTITLE W !!?(IOM-$L(LRPLN)\2),LRPLN,!
 I LRPUTYPE["D" D
 .I LRPQNUM=1 F LRPOS=1:1 S LRPLN=$P($T(ONED+LRPOS),";;",2) Q:LRPLN=""  W !,$$CJ^XLFSTR(LRPLN,IOM)
 .W !!
 Q
ONED ; description 1
 ;;This option generates a report of the turnaround time for selected lab
 ;;tests. Enter only those urgencies you want extracted. WKLD urgencies will
 ;;be included for each normal urgency selected. Enter the
 ;;test(s) you want the report display.
 ;; - 
 ;;A detailed report is available to show the data being used to
 ;;compute the turnaround times.
 ;; - 
 ;;Regular hours are from 7:01 AM to 5:00PM
 ;;Irregular hours includes all other times, holidays and weekends.
 ;;
 ;
 ;
 Q
READ ;
 D ^DIR S:$D(DTOUT)!($D(DUOUT)) LREND=1
 Q
