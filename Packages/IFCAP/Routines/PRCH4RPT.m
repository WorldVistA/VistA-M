PRCH4RPT ;RB/VM-Print Purchase Card exception reports ;09/15/08
V ;;5.1;IFCAP;**125**;Oct 20, 2000;Build 15
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 N PRCA,PRCB
 S PRCF("X")="S" D ^PRCFSITE Q:'$D(PRC("SITE"))  Q:$G(X)="^"
RPT ;select card exception/replacement report type
 K DIR
 S DIR(0)="S^1:ALL Citibank cards with No US Bank replacement #;2:Active Citibank cards with No US Bank replacement #;3:Inactive Citibank cards with US Bank replacement #"
 S DIR("A")="Type of Report",DIR("B")="ALL Citibank cards with No US Bank replacement #" D ^DIR
 Q:$D(DIRUT)!($D(DTOUT))
 S PRCDET=Y
DEV ;device
 S %ZIS="Q" D ^%ZIS G:POP EXIT K IOP I '$D(IO("Q")) U IO G PRT
 I $D(IO("Q")) S ZTIO=ION,ZTSAVE("*")=""
 I  S ZTRTN="PRT^PRCH4RPT",ZTDESC="IFCAP Purchase Card exceptions/replacements" D ^%ZTLOAD D HOME^%ZIS Q
PRT ;print
 ;
COMP ;compile reports
 S IEN=0,U="^",PAGE=0,CTR=0 K ^TMP($J)
COMP1 S IEN=$O(^PRC(440.5,IEN)) G LIST:IEN=""!(IEN]"@")
 S PRCA=$G(^PRC(440.5,IEN,0)),PRCB=$G(^PRC(440.5,IEN,2)) G:PRCA="" COMP1
 I $D(PRC("SITE")) G COMP1:$P(PRCB,U,3)'=PRC("SITE")
 I PRCA'?1"4486".E G COMP1
 I PRCDET=1 D  G COMP1
 . I '$O(^PRC(440.5,"ARPC",$P(PRCA,U),0)) D SAVE
 I PRCDET=2 D  G COMP1
 . Q:$P(PRCB,U,2)="Y"
 . I '$O(^PRC(440.5,"ARPC",$P(PRCA,U),0)) D SAVE
 I PRCDET=3 D  G COMP1
 . Q:$P(PRCB,U,2)'="Y"
 . I $O(^PRC(440.5,"ARPC",$P(PRCA,U),0)) D SAVE
 G COMP1
SAVE S ^TMP($J,$P(PRCA,U),IEN,0)=PRCA,^TMP($J,$P(PRCA,U),IEN,2)=PRCB,CTR=CTR+1
 I PRCDET=3 S ^TMP($J,$P(PRCA,U),IEN,3)=$O(^PRC(440.5,"ARPC",$P(PRCA,U),0))
 Q
LIST ;print report
 S PCNO=0,IEN=0,END=0,PAGE=0
 S HDRW="INACTIVATED CITI #       NEW US BANK #          CARD HOLDER"
 I PRCDET<3 S HDRW="PURCHASE CARD NUMBER         CARD HOLDER"
 D HDR
L1 S PCNO=$O(^TMP($J,PCNO)),IEN=0 G:PCNO="" EXIT
L2 S IEN=$O(^TMP($J,PCNO,IEN)) I IEN="" G L1
 S PRCA=^TMP($J,PCNO,IEN,0),PRCB=^TMP($J,PCNO,IEN,2),PRCC=$G(^TMP($J,PCNO,IEN,3))
 I $Y+1>(IOSL-2) D HDR G EXITZ:END
 W !
 I PRCDET<3 W $P(PRCA,U),?29,$P($G(^VA(200,+$P(PRCA,U,8),0)),U)
 I PRCDET=3 W $P(PRCA,U),?25,$P($G(^PRC(440.5,PRCC,0)),U),?48,$P($G(^VA(200,+$P(PRCA,U,8),0)),U)
 G L1
HDR ;header
 I PAGE>0,$E(IOST,1,2)="C-" S END=$$EOP^PRCH4RPT() Q:END
 S PAGE=PAGE+1 W @IOF,!,"STATION: ",$G(PRC("SITE")),?25,"DEPARTMENT OF VETERANS AFFAIRS",?(IOM-10),"Page ",$J(PAGE,3)
 S X=$$FMTE^XLFDT($$NOW^XLFDT())
 W !,?30,$P($$UP^XLFSTR(X),":",1,2)
 W !!,"** ",$P("ALL Citibank cards with No US Bank replacement #^Active Citibank cards with No US Bank replacement #^Inactive Citibank cards with US Bank replacement #",U,PRCDET)
 W !!,HDRW,!!
 Q
EOP() ; end of page check - return 1 to quit, 0 to continue
 ; 
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 I $E(IOST,1,2)'="C-" Q 0  ; not to terminal
 S DIR(0)="E"
 D ^DIR
 Q 'Y
EXIT S:$D(ZTQUEUED) ZTREQ="@"
 I $G(CTR)=0 W !!?15,"** NO CARDS FOUND MEETING REPORT CRITERIA REQUESTED **"
 W !!,"< END OF REPORT >" I $G(PAGE)>0,$E(IOST,1,2)="C-" S END=$$EOP^PRCH4RPT()
EXITZ W:$E(IOST,1,2)'="C-" @IOF
 D ^%ZISC
 K PRCA,PRCB,PRCF,DIR,DIRUT,DTOUT,PRCDET,POP
 K IEN,PAGE,CTR,PCNO,END,PAGE,HDRW,PRCC,X,Y
 K ^TMP($J)
 Q
