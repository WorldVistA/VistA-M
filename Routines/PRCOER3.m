PRCOER3 ;WIRMFO-EDI RECONCILLIATION REPORT ; [8/31/98 1:46pm]
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 I $S('$G(PRCOBEG):1,'$G(PRCOSTOP):1,'+$G(LIST):1,1:0) G STOP^PRCOER2
 S ZTSAVE("PRCOBEG")=""
 S ZTSAVE("PRCOSTOP")=""
 S ZTSAVE("LIST")=""
 S ZTSAVE("SENDER")=""
 S ZTRTN="START^PRCOER3"
 S ZTDESC="EC/EDI Reconciliation Report"
 D ZIS^PRCOER2
 I $G(POP) G STOP^PRCOER2
 I $G(PRCOPOP) G STOP^PRCOER2
 ;
START ; enter from tasked job
 ;
 U IO
 K ^TMP($J)
 I $E(IOST,1,2)="C-" W @IOF
 D UNLIST
 ;
 N A,HEADER
 ;
 ; Get all records between start and stop times for any sender.
 ;
 ; IN "AL" X-REF 2=PROGRESS LEVEL
 ;               A=INCOMMING TYPE OF TRANSACTION ('ACT' OR 'PRJ')
 ;               I=DATE/TIME PROCESSED
 ;               J=IEN OF FILE 443.75 RECORD
 ;
 I SENDER=0 F A="ACT","PRJ" D
 . S I=PRCOBEG
 . F  S I=$O(^PRC(443.75,"AL",2,A,I)) Q:'I!(I>PRCOSTOP)  D
 . . S J=0
 . . F  S J=$O(^PRC(443.75,"AL",2,A,I,J)) Q:'J  S PRCO(0)=$G(^PRC(443.75,J,0)),PRCO(1)=^(1) I PRCOA[$P(PRCO(0),U,4) D
 . . . I $S($P(PRCO(0),U,4)']"":1,'$P(PRCO(0),U,7):1,'J:1,1:0) Q
 . . . S ^TMP($J,$P(PRCO(0),U,4),$P(PRCO(0),U,7),J)=$P(PRCO(0),U,2)_U_$P(PRCO(1),U,2)_U_$P(PRCO(1),U)_U_$S($P(PRCO(1),U)="PRJ":$P(PRCO(1),U,7),1:"")
 . . . Q
 . . Q
 . Q
 ;
SINGLE ; Come here from start to display a single SENDERs entries.
 ;
 ; IN "AL1" X-REF 2=PROGRESS LEVEL
 ;                S=SENDER
 ;                A=INCOMMING TYPE OF TRANSACTION ('ACT' OR 'PRJ')
 ;                I=DATE/TIME PROCESSED
 ;                J=IEN OF FILE 443.75 RECORD
 ;
 I SENDER>0 S S=SENDER F A="ACT","PRJ" D
 . S I=PRCOBEG
 . F  S I=$O(^PRC(443.75,"AL1",2,S,A,I)) Q:'I!(I>PRCOSTOP)  D
 . . S J=0
 . . F  S J=$O(^PRC(443.75,"AL1",2,S,A,I,J)) Q:'J  S PRCO(0)=$G(^PRC(443.75,J,0)),PRCO(1)=^(1) I PRCOA[$P(PRCO(0),U,4) D
 . . . I $S($P(PRCO(0),U,4)']"":1,'$P(PRCO(0),U,7):1,'J:1,1:0) Q
 . . . S ^TMP($J,$P(PRCO(0),U,4),$P(PRCO(0),U,7),J)=$P(PRCO(0),U,2)_U_$P(PRCO(1),U,2)_U_$P(PRCO(1),U)_U_$S($P(PRCO(1),U)="PRJ":$P(PRCO(1),U,7),1:"")
 . . . Q
 . . Q
 . Q
 ;
 D WRITE
 K ^TMP($J)
 G STOP^PRCOER2
 ;
UNLIST ; take LIST variable from PRCOER1 and convert to user selection
 ; returns PRCOA with transaction type delimited by '^'
 ;
 ; 1 = PHA
 ; 2 = RFQ
 ; 3 = TXT
 ; 7 = ALL of the above (1,2,3,)
 ;
 K PRCOA
 I '+$G(LIST) K LIST Q
 I +LIST=7 S PRCOA="PHA^RFQ" Q
 N I,J,K
 S J=""
 F I=1:1 S J=$P(LIST,",",I) Q:J']""  D
 . S K=$S(J=1:"PHA",J=2:"RFQ",J=3:"TXT",1:"") D
 .. S PRCOA=$S($G(PRCOA)]"":PRCOA_U_K,1:K)
 Q
 ;
PHA ; call to retrieve PHA records to display
 Q
HED ; write header for report
 W !!
 S HEADER=$S(SENDER=0:"EC/EDI RECONCILIATION REPORT",1:"EC/EDI RECONCILIATION REPORT for "_$P($G(^VA(200,SENDER,0)),U))
 W $$CJ^XLFSTR(HEADER,80),!
 W $$CJ^XLFSTR($$REPEAT^XLFSTR("-",$L(HEADER)),80),!
 W !?2,"Date Range for Report: ",$$FMTE^XLFDT(PRCOBEG)_" to "_$$FMTE^XLFDT(PRCOSTOP),!
 W !,"TRANS",?7,"DOCUMENT #",?32,"TRANSACTION",?55,"AUSTIN ACCEPTANCE",!,"TYPE",?35,"DATE",?62,"DATE",!,$$REPEAT^XLFSTR("-",$S($G(IOM):IOM,1:79)),!
 Q
WRITE ; write out record to report sorted by transaction type and date
 ; stored in ^TMP($J,Transaction Type,Trans.date,ien)=PO/RFQ^austin date^incoming transaction^reject code
 ;
 D HED
 I $O(^TMP($J,0))']"" W !,"No transactions for the date range selected.",! Q
 N I,J,K
 S I=""
 S (J,K)=0
 F  S I=$O(^TMP($J,I)) Q:I=""!($G(PRCOUT))  D
 .  F  S J=$O(^TMP($J,I,J)) Q:'J!($G(PRCOUT))  D
 .  .  F  S K=$O(^TMP($J,I,J,K)) Q:'K!($G(PRCOUT))  D
 .  .  .  I $G(^TMP($J,I,J,K))]"" S K(0)=^(K) D  Q:$G(PRCOUT)
 .  .  .  .  W !,I,?7,$P(K(0),U),?32,$$FMTE^XLFDT(J,"2P"),?55,$$FMTE^XLFDT($P(K(0),U,2),"2P")
 .  .  .  .  I $P(K(0),U,3)="PRJ" D
 .  .  .  .  .  W !?2,"** REJECT CODE==> ",$P($G(^PRC(443.76,+$P(K(0),U,4),0)),U,2)
 .  .  .  .  D HANG Q:$G(PRCOUT)
 .  .  .  Q
 .  .  Q
 .  Q
 Q
 ;
HANG ; call at end of screen if output sent to CRT
 ; returns PRCOUT=1 if user exits(^,timeout)
 N DIRUT,DUOUT,DTOUT
 K PRCOUT
 I ($Y+5)>IOSL,$E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR S:'Y PRCOUT=1 Q:$G(PRCOUT)
 I $Y+5>IOSL W @IOF D HED
 Q
