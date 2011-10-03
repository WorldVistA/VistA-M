QAQAHOC4 ;HISC/DAD-AD HOC REPORTS: MACRO OUTPUT ;12/30/92  11:30
 ;;1.7;QM Integration Module;**2,5**;07/25/1995
EN1 ; *** Set the output macro flag
 S QAQMOUTP=1 W !!?3,"You will be prompted for an output",!?3,"device when you exit the ",QAQTYPE(0)," menu. ",*7
 R QA:QAQDTIME
 Q
EN2 ; *** Print the macro report
 K %ZIS,IOP S %ZIS="QM",%ZIS("A")="   Output macro to device: " W ! D ^%ZIS G:POP EXIT I $D(IO("Q")) K IO("Q") D QVAR,^%ZTLOAD G EXIT
ENTSK K QAQUNDL S QAQEXIT=0,$P(QAQUNDL,"_",81)=""
 U IO W:$E(IOST)="C" @IOF
 W !?19,"=========================================="
 W !?19,"|| AD HOC REPORT GENERATOR MACRO REPORT ||"
 W !?19,"=========================================="
 W !!!,"Report name: ",$E(QAQUNDL,1,67)
 W !!,"Sort fields:",!,"------------"
 W !!,"Macro: ",$S($D(QAQMACRO("S"))#2:$P(QAQMACRO("S"),"^",2),1:$E(QAQUNDL,1,73))
 F QAQORDER=1:1:QAQMAXOP("S") S QAQFIELD=$O(QAQOPTN("S",QAQORDER,"")),X=$G(QAQOPTN("S",QAQORDER,+QAQFIELD)) D PS
 D PAUSE G:QAQEXIT EXIT
 W !!,"Print fields:",!,"-------------"
 W !!,"Macro: ",$S($D(QAQMACRO("P"))#2:$P(QAQMACRO("P"),"^",2),1:$E(QAQUNDL,1,73))
 F QAQORDER=1:1:QAQMAXOP("P") S QAQFIELD=$O(QAQOPTN("P",QAQORDER,"")),X=$G(QAQOPTN("P",QAQORDER,+QAQFIELD)) D PP
 D PAUSE G:QAQEXIT EXIT
 W !!,"Header: ",$E(QAQUNDL,1,72)
 W !!,"Device: ",$E(QAQUNDL,1,72)
 W:$E(IOST)'="C" @IOF
EXIT ; *** Exit the macro report
 D ^%ZISC S QAQMOUTP=0
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
PS ; *** Print the macro sort data
 S X(1)=$P(X,";"),X(1)=$TR(X(1),$TR(X(1),"+-!@'#"))_QAQFIELD_$S($P(X,";")]"":";"_$P(X,";",2,99),1:"")
 S X(2)=$S($G(FR(QAQORDER))]"":FR(QAQORDER),X(1)]"":"Beginning",1:""),X(3)=$S($G(TO(QAQORDER))]"":TO(QAQORDER),X(1)]"":"Ending",1:"")
 I $D(QAQMACRO("S")),X(1)]"" D
 . S QAQD1=0 F QA=$L(X(1),";"):-1:1 D  Q:QAQD1
 .. S QAQD1=$O(^QA(740.1,+QAQMACRO("S"),"FLD","B",$P(X(1),";",1,QA),0))
 .. Q
 . I QAQD1 D
 .. S QA=$G(^QA(740.1,+QAQMACRO("S"),"FLD",QAQD1,0)),QAQ=$G(^("FRTO"))
 .. S X(1)=$P(QA,"^")
 .. F QAI=1,2 S X(QAI+1)=$S($P(QA,"^",3):"Ask User",$P(QAQ,"^",QAI)]"":$E($P(QAQ,"^",QAI),1,30),QAI=1:"Beginning",1:"Ending")
 .. Q
 . Q
PS1 ; *** Inquire sort macro entry point
 S QA=$G(QAQMENU(+QAQFIELD)),QA=$S(QA'>0:"",1:$P(QA,"^",2))
 W !!?3,QAQORDER,") Field: ",$S(QA]"":QA,QAQFIELD?1.N:"*** CORRUPTED ***",1:$E(QAQUNDL,1,30))
 F XX=1:1:$L(X(1)) I "'!@#&+-"[$E(X(1)) S X(1)=$E(X(1),2,999)
 W !?6,"Entry: ",$S(X(1)]"":X(1),1:$E(QAQUNDL,1,30))
 W !?6,"From:  ",$E($S(X(2)]"":X(2),1:QAQUNDL),1,30)
 W ?46,"To: ",$E($S(X(3)]"":X(3),1:QAQUNDL),1,30)
 Q
PP ; *** Print the macro print data
 S X(1)=$P(X,";"),X(1)=$TR(X(1),$TR(X(1),"&!+#"))_QAQFIELD_$S($P(X,";",2)]"":";"_$P(X,";",2,99),1:"")
 I $D(QAQMACRO("P")),X(1)]"" D
 . S QAQD1=0 F QA=$L(X(1),";"):-1:1 D  Q:QAQD1
 .. S QAQD1=$O(^QA(740.1,+QAQMACRO("P"),"FLD","B",$P(X(1),";",1,QA),0))
 .. Q
 . I QAQD1 S X(1)=$P($G(^QA(740.1,+QAQMACRO("P"),"FLD",QAQD1,0)),"^")
 . Q
PP1 ; *** Inquire print macro entry point
 S QA=$P($G(QAQMENU(+QAQFIELD)),"^",2)
 W !!?3,QAQORDER,") Field: ",$S(QA]"":QA,QAQFIELD?1.N:"*** CORRUPTED ***",1:$E(QAQUNDL,1,30))
 F XX=1:1:$L(X(1)) I "'!@#&+-"[$E(X(1)) S X(1)=$E(X(1),2,999)
 W !?6,"Entry: ",$S(X(1)]"":X(1),1:$E(QAQUNDL,1,30))
 Q
PAUSE ; *** Pause at the end of page
 I $E(IOST)="C" K DIR S DIR(0)="E" D ^DIR K DIR S QAQEXIT=$S(Y'>0:1,1:0)
 Q
QVAR ; *** Save variables for queueing
 S ZTRTN="ENTSK^QAQAHOC4",ZTDESC="Ad Hoc Report Generator Macro Report"
 F QA="FR","QAQMAXOP(","QAQMENU(","QAQOPTN(","QAQTEMP","QAQMACRO(","TO" S ZTSAVE(QA)=""
 Q
