ORQ10 ; slc/dcm - Test this utility
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;;Dec 17, 1997
TEST ;Test utility
 N DIC,Y,GP,ORLIST,ORVP,ORL,X1,X2,X,FLAG,O2
 S (X1,X2,O2)=""
 ;W !,"Order # (optional): " R X:DTIME S O2=X I $L(X),'$D(^OR(100,X,0)) S O2="" W "   Invalid order #" G TEST
 I O2,$D(^OR(100,O2,0)) S ORVP=$P(^(0),"^",2)
 I 'O2 K ^TMP("OR",$J) D ^ORUDPA
 I $O(Y(0)) S ORVP=+Y($O(Y(0)))_";DPT("
 Q:'$G(ORVP)
LP S DIC=100.98,DIC(0)="AEQM" D ^DIC S GP=$S(+Y>0:+Y,1:"") G:'GP TEST
CON W !!,"1 => All",?24,"6 => New",?45," 11 => Unsigned"
 W !,"2 => Active/Current",?24,"7 => Pending",?46,"12 => Flagged"
 W !,"3 => Discontinued",?24,"8 => Activity",?46,"13 => Verb/Phone"
 W !,"4 => Completed/Expired",?24,"9 => Expanded",?46,"14 => Verb/Phone Unsign"
 W !,"5 => Expiring",?23,"10 => Notifications"
 W !!,"Select CONTEXT: 1// " R X:DTIME Q:'$T!(X["^")  S:X="" X=1
 I X'?1N.N!(X>14)!(X<1) W !,"Enter a number from 1 to 14 that matches the context list" G CON
 S FLAG=X D
 . S %DT="AETS",%DT("A")="Select Start Date: " D ^%DT S X1=$S(Y>0:Y,1:"") I Y<0,X["^" Q
 . S %DT="AETS",%DT("A")="Select End Date: " D ^%DT S X2=$S(Y>0:Y,1:"") I Y<0,X["^" Q
 W !,"What do you want stored:  1. Just the order #",!,?26,"2. Order # & text",!?26,"3. Order # & Reason for action",!?26,"4. Detailed Display fields"
 R !?8,"Enter choice: 1// ",X:DTIME S:X="" X=1 Q:X["^"
 S X3=$S(X=1:0,X=2:2,X=3:3,X=4:1,1:0)
 W !!,"For: "_$P(^DPT(+ORVP,0),"^"),?35," "_$P(Y,"^",2),?55,"Context #"_FLAG
 D EN^ORQ1(ORVP,GP,FLAG,"",X1,X2,X3)
 W !?5,"<"_$S($G(^TMP("ORR",$J,ORLIST,"TOT")):^("TOT"),1:0)_" Orders found>"
 I $G(^TMP("ORR",$J,ORLIST,"TOT")) W !,"Do you want to see the list of Orders" S %=1 D YN^DICN D
 . I %=1 W ! S IFN=0 F  S IFN=$O(^TMP("ORR",$J,ORLIST,IFN)) Q:IFN<1  W !,^(IFN)
 K ^TMP("ORR",$J,ORLIST)
 D READ^ORUTL G LP
 Q
 ;
STATUS(NUM) ; -- Returns name of status by number
 I NUM=1 Q "All"
 I NUM=2 Q "Current"
 I NUM=3 Q "Discontinued"
 I NUM=4 Q "Completed/Expired"
 I NUM=5 Q "Expiring"
 I NUM=6 Q "New"
 I NUM=7 Q "Pending"
 I NUM=8 Q "Activity"
 I NUM=9 Q "Expanded"
 I NUM=10 Q "Notifications"
 I NUM=11 Q "Unsigned"
 I NUM=12 Q "Flagged"
 I NUM=13 Q "Verbal/Phoned"
 I NUM=14 Q "Verbal/Phoned Unsigned"
 Q ""
