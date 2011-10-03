PRCOER2 ;WISC-EDI REPORTS USING LIST MANAGER CONT ; [8/31/98 1:42pm]
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 D FULL^VALM1
 W @IOF
 N PRCOBEG,PRCOSTOP
 D RT^PRCOER1  ; ask user date range
 I $S('$G(PRCOBEG):1,'$G(PRCOSTOP):1,1:0) G STOP
 ;
 N A,HEADER
 S A(1)="Your selection will generate the Transaction Summary Statistical Report"
 S A(2)="for the following date range: "_$$FMTE^XLFDT(PRCOBEG,"2D")_" - "_$$FMTE^XLFDT(PRCOSTOP,"2D")
 D EN^DDIOL(.A)
 W !!
 S DIR(0)="Y",DIR("A")="Want to continue",DIR("B")="Yes"
 D ^DIR K DIR G STOP:$D(DIRUT)!'Y
 ;
 ; ask user for output device - home or printer
 ;
 S ZTSAVE("PRCOBEG")=""
 S ZTSAVE("PRCOSTOP")=""
 S ZTSAVE("SENDER")=""
 S ZTRTN="EN^PRCOER2"
 S ZTDESC="Transaction Summary Statistics Report"
 D ZIS
 I $G(POP) G STOP
 G STOP:$G(PRCOPOP)
 ;
EN ; enter from tasked job
 U IO
 I $E(IOST,1,2)="C-" W @IOF
 S (ACNT,PCNT,TCNT)=0
 I SENDER=0 F A="ACT","PRJ" S I=PRCOBEG F  S I=$O(^PRC(443.75,"AL",2,A,I)) Q:'I!(I>PRCOSTOP)  D
 . S J=0 F  S J=$O(^PRC(443.75,"AL",2,A,I,J)) Q:'J  D
 . . I A="ACT" S ACNT=ACNT+1
 . . I A="PRJ" S PCNT=PCNT+1
 . . S TCNT=TCNT+1
 ;
 I SENDER>0 F A="ACT","PRJ" S I=PRCOBEG F  S I=$O(^PRC(443.75,"AL1",2,SENDER,A,I)) Q:'I!(I>PRCOSTOP)  D
 . S J=0 F  S J=$O(^PRC(443.75,"AL1",2,SENDER,A,I,J)) Q:'J  D
 . . I A="ACT" S ACNT=ACNT+1
 . . I A="PRJ" S PCNT=PCNT+1
 . . S TCNT=TCNT+1
 ;
EN1 ; those transactions still waiting Austin feedback
 ;
 S (PHA,RFQ,TXT,NOTCNT)=0
 I SENDER=0 F A="PHA","RFQ","TXT" S I=PRCOBEG F  S I=$O(^PRC(443.75,"AJ",1,A,I)) Q:'I!(I>PRCOSTOP)  D
 . S J=0 F  S J=$O(^PRC(443.75,"AJ",1,A,I,J)) Q:'J  D
 . . I A="PHA" S PHA=PHA+1
 . . I A="RFQ" S RFQ=RFQ+1
 . . I A="TXT" S TXT=TXT+1
 . . S NOTCNT=NOTCNT+1
 ;
 I SENDER>0 F A="PHA","RFQ","TXT" S I=PRCOBEG F  S I=$O(^PRC(443.75,"AJ1",1,SENDER,A,I)) Q:'I!(I>PRCOSTOP)  D
 . S J=0 F  S J=$O(^PRC(443.75,"AJ1",1,SENDER,A,I,J)) Q:'J  D
 . . I A="PHA" S PHA=PHA+1
 . . I A="RFQ" S RFQ=RFQ+1
 . . I A="TXT" S TXT=TXT+1
 . . S NOTCNT=NOTCNT+1
 ;
 ; write out summary results and quit
 ;
 D HED
 W !,"Summary of Processed Records: ",!
 W !?5,"# of accepted (ACT) records - ",$J(ACNT,8)
 W !?5,"# of rejected (RJT) records - ",$J(PCNT,8)
 W !?35,"---------"
 W !?35,$J(TCNT,8),!
 ;
 W !,"Summary of Transactions Waiting Austin Processing",!
 W !?5,"# of PHA records - ",$J(PHA,8)
 W !?5,"# of RFQ records - ",$J(RFQ,8)
 W !?5,"# of TXT records - ",$J(TXT,8)
 W !?23,"---------"
 W !?24,$J(NOTCNT,8)
 ;
STOP ; quit and return to listman
 S:$D(ZTQUEUED) ZTREQ="@"
 I '$D(ZTQUEUED) D CLOSE
 K I,ACNT,PCNT,TCNT,PHA,RFQ,TXT,NOTCNT,PRCOPOP,PRCOBEG,PRCOSTOP,PRCOUT,PRCOA
 S VALMBCK="R",VALMBG=1
 W !
 I $E(IOST,1,2)="C-" D PAUSE^PRCOER
 Q
 ;
HED ; header for report
 W !!
 S HEADER=$S(SENDER=0:"TRANSACTION SUMMARY STATISTICS REPORT",1:"TRANSACTION SUMMARY STATISTICS REPORT for "_$P($G(^VA(200,SENDER,0)),U))
 W $$CJ^XLFSTR(HEADER,80),!
 W $$CJ^XLFSTR($$REPEAT^XLFSTR("-",$L(HEADER)),80),!
 W !?2,"Date Range for Report: ",$$FMTE^XLFDT(PRCOBEG)_" to "_$$FMTE^XLFDT(PRCOSTOP),!!
 Q
 ;
ZIS ; ASK DEVICE will return PRCOPOP if QUEUED
 ;
 K IOP,IO("Q"),PRCOPOP
 W ! S %ZIS="QMP" D ^%ZIS Q:POP
1 I $D(IO("Q")) S PRCOPOP=1 K IO("Q"),ZTIO D ^%ZTLOAD W:$D(ZTSK) !,"Request Queued",!,"Task #: ",$G(ZTSK) K ZTSK,ZTSAVE,ZTRTN,ZTIO D HOME^%ZIS
 Q
 ;
CLOSE I '$D(ZTQUEUED) D ^%ZISC
 K IOP,ZTDESC,ZTIO,ZTREQ,ZTRTN,ZTSAVE,ZTDTH,PRCOPOP,POP
 Q
 ; THIS IS NOT USED CURRENTLY.   MAY HAVE TO DELETE
 ; this is called from the EDI protocols to display
 ; variable PRCO = line tag in routine to execute
 ;
 D FULL^VALM1
 ;
EN2 N PRI,PRX
 S VALMBCK="R"
 D SEL^VALM2 G END:'$O(VALMY(0))
 S PRI=0 F  S PRI=$O(VALMY(0)) Q:'PRI  I $D(^TMP("PRCOER",$J,PRI)) S PRX=^(PRI) D @PRCO D  Q:'Y
 . S DIR(0)="E"
 . S DIR("A")="Press <ENTER> to "_$S($O(VALMY(PRI)):"view next selection",1:"return to list")
 . D ^DIR K DIR
 ;
 Q
END S VALMBCK="R"
 Q
