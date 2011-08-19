PRCOER4 ;WIRMFO-EDI EXCEPTIONS REPORT ; [8/31/98 1:51pm]
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 W @IOF
 D RT^PRCOER1  ;ask user date range
 I $S('$G(PRCOBEG):1,'$G(PRCOSTOP):1,1:0) G STOP^PRCOER2
 ;
 S ZTSAVE("PRCOBEG")=""
 S ZTSAVE("PRCOSTOP")=""
 S ZTSAVE("SENDER")=""
 S ZTRTN="START^PRCOER4"
 S ZTDESC="EC/EDI Exceptions Report"
 D ZIS^PRCOER2
 I $G(POP) G STOP^PRCOER2
 I $G(PRCOPOP) G STOP^PRCOER2
 ;
START ; entry to generate Exceptions Report
 ;
 U IO
 I $E(IOST,1,2)="C-" W @IOF
 ; this section gathers all errors sent from Austin
 D HED
 D PRJ
 I '$G(PRCOUT),$E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR G QUIT:$G(DIRUT)
 W @IOF
 D HED
 D POA
 ;
QUIT K DUOUT,DIRUT,DTOUT,IT,PO,PRCO,CNT G STOP^PRCOER2  ;return to list manager control
 ;
PRJ N I,J,PRCO
 D HEDPRJ
 I SENDER=0 S I=PRCOBEG F  S I=$O(^PRC(443.75,"AL",2,"PRJ",I)) Q:'I!(I>PRCOSTOP)!($G(PRCOUT))  D
 .  S J=0 F  S J=$O(^PRC(443.75,"AL",2,"PRJ",I,J)) Q:'J!($G(PRCOUT))  S PRCO(0)=$G(^PRC(443.75,J,0)),PRCO(1)=^(1) D DISPLAY S CNT=1
 I SENDER>0 S I=PRCOBEG F  S I=$O(^PRC(443.75,"AL1",2,SENDER,"PRJ",I)) Q:'I!(I>PRCOSTOP)!($G(PRCOUT))  D
 .  S J=0 F  S J=$O(^PRC(443.75,"AL1",2,SENDER,"PRJ",I,J)) Q:'J!($G(PRCOUT))  S PRCO(0)=$G(^PRC(443.75,J,0)),PRCO(1)=^(1) D DISPLAY S CNT=1
 I '$G(CNT) D NORECORD
 Q
 ;
DISPLAY ; Come here to show a PRJ exception to the user.
 ;
 W !,?1,$P(PRCO(0),U,2),?22,$P(PRCO(0),U,6),?36,$$FMTE^XLFDT($P(PRCO(1),U,2),2),?64,$E($P(PRCO(1),U,3),1,25)
 W !?2,$P(PRCO(1),U,4),?30,$P(PRCO(1),U,6),?38,$P(PRCO(1),U,8),?50,$P(PRCO(1),U,9),?62,$P(PRCO(1),U,10),?73,$P(PRCO(1),U,14)
 I $P(PRCO(1),U,5)]"" W !?4,$P(PRCO(1),U,5)
 I $P(PRCO(1),U,7) W !?4,"Reject Reason Code: ",$P($G(^PRC(443.76,+$P(PRCO(1),U,7),0)),U,2)
 D HANG Q:$G(PRCOUT)
 I $Y+5>IOSL W @IOF D HED,HEDPRJ
 Q
 ;
POA N I,J,PRCO
 K PRCOUT,CNT
 D HEDPOA
 S I=PRCOBEG F  S I=$O(^PRC(443.75,"AM",3,"POA",I)) Q:'I!(I>PRCOSTOP)!($G(PRCOUT))  D
 .  S J=0 F  S J=$O(^PRC(443.75,"AM",3,"POA",I,J)) Q:'J!($G(PRCOUT))  S PRCO(0)=$G(^PRC(443.75,J,0)),PRCO(1)=^(1) D
 ..  S PO=+$P(PRCO(0),U,8) Q:$G(^PRC(442,PO,0))']""  D DISPLAY1
 I '$G(CNT) D NORECORD
 Q
 ;
DISPLAY1 ; Come here to show a POA exception to a user.
 ;
 Q:$P(PRCO(1),U,6)']""  S IT=$O(^PRC(442,PO,2,"B",$P(PRCO(1),U,6),0)) Q:IT=""
 S PRCO(2)=$G(^PRC(442,+PO,2,+IT,0)),PRCO(3)=$G(^(2))
 Q:$P($G(PRCO(3)),U,9)="AC"
 Q:$P($G(PRCO(3)),U,11)="AC"
 S CNT=1
 W !?2,$P(PRCO(0),U,2),?26,$P(PRCO(1),U,6),?48,$P(^PRCD(420.5,+$P(PRCO(2),U,3),0),U,2)
 W !?3,$P(PRCO(2),U,2),?15,$S($P(PRCO(3),U,12):$P(PRCO(3),U,12),1:$P(PRCO(3),U,10))
 W ?27,$S($P(PRCO(3),U,11)]"":$$CODE($P(PRCO(3),U,11)),1:$$CODE($P(PRCO(3),U,9)))
 D ERR
 D HANG Q:$G(PRCOUT)
 I $Y+5>IOSL W @IOF D HED,HEDPOA
 Q
 ;
HED ; used to print main header for exception report.
 W !!
 S HEADER=$S(SENDER=0:"EC/EDI EXCEPTION REPORT",1:"EC/EDI EXCEPTION REPORT for "_$P($G(^VA(200,SENDER,0)),U))
 W $$CJ^XLFSTR(HEADER,$S($G(IOM):IOM,1:80)),!
 W $$CJ^XLFSTR($$REPEAT^XLFSTR("-",$L(HEADER)),$S($G(IOM):IOM,1:80)),!
 W !?2,"Date Range for Report: ",$$FMTE^XLFDT(PRCOBEG)_" to "_$$FMTE^XLFDT(PRCOSTOP),!
 Q
HEDPRJ ; write header for PRJ data
 W !,$$CJ^XLFSTR(">>>> PRJ EXCEPTIONS <<<<",$S($G(IOM):IOM,1:80))
 W !!?1,"REFERENCE #",?22,"VENDOR ID",?36,"DATE/TIME PROCESSED",?59,"INCORRECT SEGMENT"
 W !?2,"INCORRECT FIELD",?30,"LINE#",?38,"DESC-LINE#",?50,"DE-SEQ#",?62,"CO-SEQ#",?73,"SEQ #"
 W !?4,"FIELD CONTENTS"
 W !,$$REPEAT^XLFSTR("=",$S($G(IOM):IOM,1:80))
 Q
 ;
HEDPOA ; write header for POA exceptions
 W !,$$CJ^XLFSTR(">>>> POA EXCEPTIONS <<<<",$S($G(IOM):IOM,1:80))
 W !!?1,"REFERENCE #",?24,"LINE ITEM #",?47,"UNIT OF PURCHASE"
 W !?2,"QTY ORDERED",?15,"QTY EXCEPTED",?29,"EXCEPTION REASON"
 W !,$$REPEAT^XLFSTR("=",$S($G(IOM):IOM,1:80))
 Q
 ;
HANG ; call at end of screen if output sent to screen
 ; returns 'PRCOUT'=1 if user enter '^'
 N DIRUT,DUOUT,DTOUT
 K PRCOUT
 I $Y+5>IOSL,$E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR S:'Y PRCOUT=1 Q:$G(PRCOUT)
 ;
 ; I $Y+5>IOSL W @IOF D HED
 ;
 Q
 ;
CODE(X) ; returns external value of set of codes from field 442.01,13
 ; X = what is stored
 I $G(X)']"" Q ""
 N Y,C
 S Y=X
 S C=$P(^DD(442.01,13,0),U,2)
 D Y^DIQ
 Q Y
 ;
ERR ; write out incoming processing errors
 ;
 Q:'$O(^PRC(443.75,J,"ERR",0))
 W !?8,">>> Incoming processing errors <<<"
 N I S I=0
 F  S I=$O(^PRC(443.75,J,"ERR",I)) Q:'I  W !?2,"- ",$G(^(I,0))
 Q
 ;
NORECORD ; write no data to report
 W !!?3,"No records meet the selection criteria.",!
 Q
 ;
PO ; display selected PURCHASE ORDER
 S MESS="Enter the line number of the PO/RFQ"
 D MSG^VALM10(MESS)
 W !!!!
AGAIN W !,"LINE NUMBER: " R PONUM:DTIME
 I PONUM["^"!(PONUM="") G FINI
 I PONUM'?1.N!(PONUM<1) W !!,?6," Please enter the line number next to the PO/RFQ Number.",$C(7),! G AGAIN
 I PONUM>VALMCNT W !!,?6," Response must be no greater than "_VALMCNT_".",$C(7),! G AGAIN
 S PONUM1=$P($G(^PRC(443.75,"PRCOER",$J,PONUM)),U,2)
 S PONUM2=$G(^PRC(443.75,PONUM1,0))
 I PONUM2="" W !,"THE ENTRY IN FILE 443.75 IS MISSING" G FINI
 S PRC("SITE")=$P($P(PONUM2,U,2),"-",1)
 I $P(PONUM2,"-",3)="RFQ" W !!,?6," Please use option View RFQ [PRCHQ15] to review this line item.",$C(7),! G AGAIN
 S D0=$P(PONUM2,U,8)
 D CLEAR^VALM1
 D ^PRCHDP1
FINI D PAUSE^VALM1
 S VALMBCK="R"
 Q
